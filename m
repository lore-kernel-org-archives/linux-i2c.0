From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [Bug fix] octeon-i2c driver updates
Date: Fri, 1 Dec 2017 11:06:30 +0100
Message-ID: <20171201100630.GA3632@hc>
References: <VI1PR0702MB3615DF756007C1F87BED50BB8E210@VI1PR0702MB3615.eurprd07.prod.outlook.com>
 <20171124131026.GA30811@hc>
 <VI1PR0702MB3615361B408E67F3B4A41E1A8E250@VI1PR0702MB3615.eurprd07.prod.outlook.com>
 <VI1PR0702MB3615B742A40741B68ED04BAF8E380@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <VI1PR0702MB3615B742A40741B68ED04BAF8E380@VI1PR0702MB3615.eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zhang, Sean C. (NSB - CN/Hangzhou)" <sean.c.zhang@nokia-sbell.com>
Cc: "david.daney@cavium.com" <david.daney@cavium.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Sean,

as you try to solve two different issues I suggest that you create one
patch per issue.

For the second point (retry of START after recovery) I would still like
to hear Wolfram's opinion. I would assume that any i2c user should
be well aware of -EAGAIN, so I wonder if it is worth the additional
complexity of the retry logic.

Also, the first issue changes Octeon MIPS which I'm not able to test,
so David needs to be involved here.

thanks,
Jan

On Thu, Nov 30, 2017 at 01:56:09AM +0000, Zhang, Sean C. (NSB - CN/Hangzhou) wrote:
> Hi Jan,
> 
> Any other comments for this patch?
> 
> BR,
> Sean Zhang
> 
> -----Original Message-----
> From: Zhang, Sean C. (NSB - CN/Hangzhou) 
> Sent: Monday, November 27, 2017 4:38 PM
> To: 'Jan Glauber' <jan.glauber@caviumnetworks.com>
> Cc: david.daney@cavium.com; wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [Bug fix] octeon-i2c driver updates
> 
> Hi Jan,
> 
> There are two points in this patch.
> 
> Point 1. As you see, replaced octeon_i2c_init_lowlevel() by recover bus status if TWSI controller is not IDLE.
> Please take a scenario like this: when system soft reset without I2C slave reset, maybe make this I2C bus
> dead lock occurred (I2C slave device stuck low SCL) in chance. Then during system goes up and I2C slave 
> device creating process, if this I2C slave device has a register with less than 8 bytes to read, but I2C bus was
> still stuck low SCL by last system reset, then the read will failed and this I2C slave device cannot be created.
> If bus recovered before the reading process, this failure can be fixed.
> 
> Function flow explanation shown as below:
> 
> a. System reset without I2C slave device reset
> --make SCL stuck low by I2C slave device
> ......
> b. octeon_i2c_probe（）
> -- octeon_i2c_init_lowlevel  //reset TWSI core, but SCL still stuck low by.
> ......
> 
> c. Another I2C slave device creating process
> octeon_i2c_xfer()
> -- octeon_i2c_hlc_comp_read() //failed due to SCL stuck low.
> 
> If full recovery executed in octeon_i2c_probe（), above failure can be avoided.
> 
> 
> Point 2. octeon_i2c_recovery() is used in octeon_i2c_start() error branch, in the case of octeon_i2c_recovery()
> successful, octeon_i2c_start() will return -EAGAIN, and then octeon_i2c_xfer() return with error. I understand this like
> this: if octeon_i2c_recovery() successful, then i2c START signal can be sent again, and all following step can be continue,
> octeon_i2c_xfer() should not return error from this condition.
> 
> BR,
> Sean Zhang
> 
> -----Original Message-----
> From: Jan Glauber [mailto:jan.glauber@caviumnetworks.com] 
> Sent: Friday, November 24, 2017 9:10 PM
> To: Zhang, Sean C. (NSB - CN/Hangzhou) <sean.c.zhang@nokia-sbell.com>
> Cc: david.daney@cavium.com; wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [Bug fix] octeon-i2c driver updates
> 
> On Thu, Nov 23, 2017 at 11:42:36AM +0000, Zhang, Sean C. (NSB - CN/Hangzhou) wrote:
> > Dear Maintainer,
> > 
> > For octeon TWSI controller, I found below two cases, maybe can be improved.
> 
> Hi Sean,
> 
> form the description below this looks like you're fixing a bug. Can you
> elaborate on when the I2C bus dead lock occurs. Is it always happening?
> 
> What I don't like about the patch is that you're removing
> octeon_i2c_init_lowlevel() from the probe and replacing it by _always_
> going through a full recovery. Why is this neccessary?
> 
> Regards,
> Jan
> 
> > 
> > >From 09d9f0ce658d7f6a50d1af352dde619c29bc8bcf Mon Sep 17 00:00:00 2001
> > From: hgt463 <sean.c.zhang@nokia.com>
> > Date: Thu, 23 Nov 2017 18:46:09 +0800
> > Subject: [PATCH] Driver updates:
> >  - In the case of I2C bus dead lock occurred during driver probing,
> >    it is better try to recovery it. so added bus recovery step in
> >    octeon_i2c_probe();
> >  - The purpose of function octeon_i2c_start() is to send START, so after
> >    bus recovery, also need try to send START again.
> > 
> > Signed-off-by: hgt463 <sean.c.zhang@nokia.com>
> > ---
> >  drivers/i2c/busses/i2c-octeon-core.c    |   31 ++++++++++++++++++++++++++++++-
> >  drivers/i2c/busses/i2c-octeon-platdrv.c |   15 +++++++++------
> >  2 files changed, 39 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
> > index 1d87757..3ae1e03 100644
> > --- a/drivers/i2c/busses/i2c-octeon-core.c
> > +++ b/drivers/i2c/busses/i2c-octeon-core.c
> > @@ -255,6 +255,35 @@ static int octeon_i2c_recovery(struct octeon_i2c *i2c)
> >         return ret;
> >  }
> >  
> > +/*
> > + * octeon_i2c_start_retry - send START to the bus after bus recovery.
> > + * @i2c: The struct octeon_i2c
> > + *
> > + * Returns 0 on success, otherwise a negative errno.
> > + */
> > +static int octeon_i2c_start_retry(struct octeon_i2c *i2c)
> > +{
> > +       int ret;
> > +       u8 stat;
> > +
> > +       ret = octeon_i2c_recovery(i2c);
> > +       if (ret)
> > +               goto error;
> > +
> > +       octeon_i2c_ctl_write(i2c, TWSI_CTL_ENAB | TWSI_CTL_STA);
> > +       ret = octeon_i2c_wait(i2c);
> > +       if (ret)
> > +               goto error;
> > +
> > +       stat = octeon_i2c_stat_read(i2c);
> > +       if (stat == STAT_START || stat == STAT_REP_START)
> > +               /* START successful, bail out */
> > +               return 0;
> > +
> > +error:
> > +       return (ret) ? ret : -EAGAIN;
> > +}
> > +
> >  /**
> >   * octeon_i2c_start - send START to the bus
> >   * @i2c: The struct octeon_i2c
> > @@ -280,7 +309,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
> >  
> >  error:
> >         /* START failed, try to recover */
> > -       ret = octeon_i2c_recovery(i2c);
> > +       ret = octeon_i2c_start_retry(i2c);
> >         return (ret) ? ret : -EAGAIN;
> >  }
> >  
> > diff --git a/drivers/i2c/busses/i2c-octeon-platdrv.c b/drivers/i2c/busses/i2c-octeon-platdrv.c
> > index 64bda83..98063af 100644
> > --- a/drivers/i2c/busses/i2c-octeon-platdrv.c
> > +++ b/drivers/i2c/busses/i2c-octeon-platdrv.c
> > @@ -228,12 +228,6 @@ static int octeon_i2c_probe(struct platform_device *pdev)
> >         if (OCTEON_IS_MODEL(OCTEON_CN38XX))
> >                 i2c->broken_irq_check = true;
> >  
> > -       result = octeon_i2c_init_lowlevel(i2c);
> > -       if (result) {
> > -               dev_err(i2c->dev, "init low level failed\n");
> > -               goto  out;
> > -       }
> > -
> >         octeon_i2c_set_clock(i2c);
> >  
> >         i2c->adap = octeon_i2c_ops;
> > @@ -245,6 +239,15 @@ static int octeon_i2c_probe(struct platform_device *pdev)
> >         i2c_set_adapdata(&i2c->adap, i2c);
> >         platform_set_drvdata(pdev, i2c);
> >  
> > +       stat = octeon_i2c_stat_read(i2c);
> > +       if (stat != STAT_IDLE) {
> > +               result = octeon_i2c_recovery(i2c);
> > +               if (result) {
> > +                       dev_err(i2c->dev, "octeon i2c recovery failed\n");
> > +                       goto  out;
> > +               }
> > +       }
> > +
> >         result = i2c_add_adapter(&i2c->adap);
> >         if (result < 0)
> >                 goto out;
> > 
> > 
> > Attached patch for you review. Thanks in advance.
> > 
> > BR,
> > Sean Zhang
> 
> 
