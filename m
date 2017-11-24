From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [Bug fix] octeon-i2c driver updates
Date: Fri, 24 Nov 2017 14:10:26 +0100
Message-ID: <20171124131026.GA30811@hc>
References: <VI1PR0702MB3615DF756007C1F87BED50BB8E210@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:29216
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750825AbdKXNKj (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 24 Nov 2017 08:10:39 -0500
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3615DF756007C1F87BED50BB8E210@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Zhang, Sean C. (NSB - CN/Hangzhou)" <sean.c.zhang@nokia-sbell.com>
Cc: "david.daney@cavium.com" <david.daney@cavium.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 23, 2017 at 11:42:36AM +0000, Zhang, Sean C. (NSB - CN/Hangzhou) wrote:
> Dear Maintainer,
> 
> For octeon TWSI controller, I found below two cases, maybe can be improved.

Hi Sean,

form the description below this looks like you're fixing a bug. Can you
elaborate on when the I2C bus dead lock occurs. Is it always happening?

What I don't like about the patch is that you're removing
octeon_i2c_init_lowlevel() from the probe and replacing it by _always_
going through a full recovery. Why is this neccessary?

Regards,
Jan

> 
> >From 09d9f0ce658d7f6a50d1af352dde619c29bc8bcf Mon Sep 17 00:00:00 2001
> From: hgt463 <sean.c.zhang@nokia.com>
> Date: Thu, 23 Nov 2017 18:46:09 +0800
> Subject: [PATCH] Driver updates:
>  - In the case of I2C bus dead lock occurred during driver probing,
>    it is better try to recovery it. so added bus recovery step in
>    octeon_i2c_probe();
>  - The purpose of function octeon_i2c_start() is to send START, so after
>    bus recovery, also need try to send START again.
> 
> Signed-off-by: hgt463 <sean.c.zhang@nokia.com>
> ---
>  drivers/i2c/busses/i2c-octeon-core.c    |   31 ++++++++++++++++++++++++++++++-
>  drivers/i2c/busses/i2c-octeon-platdrv.c |   15 +++++++++------
>  2 files changed, 39 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
> index 1d87757..3ae1e03 100644
> --- a/drivers/i2c/busses/i2c-octeon-core.c
> +++ b/drivers/i2c/busses/i2c-octeon-core.c
> @@ -255,6 +255,35 @@ static int octeon_i2c_recovery(struct octeon_i2c *i2c)
>         return ret;
>  }
>  
> +/*
> + * octeon_i2c_start_retry - send START to the bus after bus recovery.
> + * @i2c: The struct octeon_i2c
> + *
> + * Returns 0 on success, otherwise a negative errno.
> + */
> +static int octeon_i2c_start_retry(struct octeon_i2c *i2c)
> +{
> +       int ret;
> +       u8 stat;
> +
> +       ret = octeon_i2c_recovery(i2c);
> +       if (ret)
> +               goto error;
> +
> +       octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STA);
> +       ret = octeon_i2c_wait(i2c);
> +       if (ret)
> +               goto error;
> +
> +       stat = octeon_i2c_stat_read(i2c);
> +       if (stat == STAT_START || stat == STAT_REP_START)
> +               /* START successful, bail out */
> +               return 0;
> +
> +error:
> +       return (ret) ? ret : -EAGAIN;
> +}
> +
>  /**
>   * octeon_i2c_start - send START to the bus
>   * @i2c: The struct octeon_i2c
> @@ -280,7 +309,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
>  
>  error:
>         /* START failed, try to recover */
> -       ret = octeon_i2c_recovery(i2c);
> +       ret = octeon_i2c_start_retry(i2c);
>         return (ret) ? ret : -EAGAIN;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
> index 64bda83..98063af 100644
> --- a/drivers/i2c/busses/i2c-octeon-platdrv.c
> +++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
> @@ -228,12 +228,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>         if (OCTEON_IS_MODEL(OCTEON_CN38XX))
>                 i2c->broken_irq_check = true;
>  
> -       result = octeon_i2c_init_lowlevel(i2c);
> -       if (result) {
> -               dev_err(i2c->dev, "init low level failed\n");
> -               goto  out;
> -       }
> -
>         octeon_i2c_set_clock(i2c);
>  
>         i2c->adap = octeon_i2c_ops;
> @@ -245,6 +239,15 @@ static int octeon_i2c_probe(struct platform_device *pdev)
>         i2c_set_adapdata(&i2c->adap, i2c);
>         platform_set_drvdata(pdev, i2c);
>  
> +       stat = octeon_i2c_stat_read(i2c);
> +       if (stat != STAT_IDLE) {
> +               result = octeon_i2c_recovery(i2c);
> +               if (result) {
> +                       dev_err(i2c->dev, "octeon i2c recovery failed\n");
> +                       goto  out;
> +               }
> +       }
> +
>         result = i2c_add_adapter(&i2c->adap);
>         if (result < 0)
>                 goto out;
> 
> 
> Attached patch for you review. Thanks in advance.
> 
> BR,
> Sean Zhang
