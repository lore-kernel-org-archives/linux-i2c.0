From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 7/8] VR1000: Add i2c device list to Thorcom VR1000
Date: Sun, 1 Jun 2008 22:38:55 +0100
Message-ID: <20080601213855.GI7334@trinity.fluff.org>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132407.211335410@fluff.org.uk>
	<20080601093215.67a1ac41@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080601093215.67a1ac41-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 01, 2008 at 09:32:15AM +0200, Jean Delvare wrote:
> On Thu, 29 May 2008 14:22:51 +0100, Ben Dooks wrote:
> > Add i2c board intialisers to specify the I2C devices
> > attached on the Thorcom VR1000.
> > 
> > Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > 
> > Index: linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2410/mach-vr1000.c
> > ===================================================================
> > --- linux-2.6.26-rc4-quilt1.orig/arch/arm/mach-s3c2410/mach-vr1000.c	2008-05-27 23:31:41.000000000 +0100
> > +++ linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2410/mach-vr1000.c	2008-05-27 23:59:05.000000000 +0100
> > @@ -1,6 +1,6 @@
> >  /* linux/arch/arm/mach-s3c2410/mach-vr1000.c
> >   *
> > - * Copyright (c) 2003-2005 Simtec Electronics
> > + * Copyright (c) 2003-2005,2008 Simtec Electronics
> >   *   Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> >   *
> >   * Machine support for Thorcom VR1000 board. Designed for Thorcom by
> > @@ -19,6 +19,7 @@
> >  #include <linux/timer.h>
> >  #include <linux/init.h>
> >  #include <linux/dm9000.h>
> > +#include <linux/i2c.h>
> >  
> >  #include <linux/serial.h>
> >  #include <linux/tty.h>
> > @@ -315,6 +316,24 @@ static struct platform_device vr1000_led
> >  	},
> >  };
> >  
> > +/* I2C devices. */
> > +
> > +static struct i2c_board_info vr1000_i2c_info[] __initdata = {
> > +	{
> > +		.type	= "tlv320aic23",
> > +		.addr	= 0x1a,
> > +	}, {
> > +		.type	= "tmp101",
> > +		.addr	= 0x48,
> 
> Same problem as "eeprom"... The lm75 driver doesn't yet support the
> "tmp101" as a new-style device in mainline, so this won't work and will
> prevent the lm75 driver from attaching as a legacy driver too. So this
> device declaration should be delayed or commented out until the lm75
> driver is ready.

I'll think about that one, although it does take a force to load the lm75
on current kernels due to it not being 'truly' lm75 compatible. Is there
any chance of the new driver being merged during the next change window?

PS, I've done a quick test of the new lm75 driver and it seems to work
fine for me and would like to see a solution where we don't need to force
probe the lm75 module.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
