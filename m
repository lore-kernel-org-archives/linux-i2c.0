From: Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH] i2c: i2c-mv64xxx: add suspend/resume support
Date: Thu, 11 Aug 2016 10:39:37 +0200
Message-ID: <CAH76GKOYUVFO831YYyP-4RFmsumCV+ViY4tNqYXvEtKs4_=54A@mail.gmail.com>
References: <1469097573-17638-1-git-send-email-jaz@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469097573-17638-1-git-send-email-jaz@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcin Wojtas <mw@semihalf.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, wsa@the-dreams.de
List-Id: linux-i2c@vger.kernel.org

Hi,

I just wanted to kindly remind about this patch.

Best regards,
Grzegorz

2016-07-21 12:39 GMT+02:00 Grzegorz Jaszczyk <jaz@semihalf.com>:
> There is no need to implement subroutine for suspend since there is no
> data to store before suspending.
>
> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index b4dec08..dc048e7 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -977,12 +977,24 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>         return 0;
>  }
>
> +static int mv64xxx_i2c_resume(struct device *dev)
> +{
> +       struct mv64xxx_i2c_data *drv_data = dev_get_drvdata(dev);
> +
> +       mv64xxx_i2c_hw_init(drv_data);
> +
> +       return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mv64xxx_i2c_pm_ops, NULL, mv64xxx_i2c_resume);
> +
>  static struct platform_driver mv64xxx_i2c_driver = {
>         .probe  = mv64xxx_i2c_probe,
>         .remove = mv64xxx_i2c_remove,
>         .driver = {
>                 .name   = MV64XXX_I2C_CTLR_NAME,
>                 .of_match_table = mv64xxx_i2c_of_match_table,
> +               .pm = &mv64xxx_i2c_pm_ops,
>         },
>  };
>
> --
> 1.8.3.1
>
