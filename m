From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [patch 5/8] OSIRIS: Add i2c device list to Simtec Osiris
Date: Sun, 1 Jun 2008 22:35:09 +0100
Message-ID: <20080601213509.GH7334@trinity.fluff.org>
References: <20080529132244.818543231@fluff.org.uk>
	<20080529132406.837870894@fluff.org.uk>
	<20080601092116.63c4808e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080601092116.63c4808e-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
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

On Sun, Jun 01, 2008 at 09:21:16AM +0200, Jean Delvare wrote:
> Hi Ben,
> 
> On Thu, 29 May 2008 14:22:49 +0100, Ben Dooks wrote:
> > Add an i2c board information initialisers to the board
> > to define which devices are present.
> > 
> > Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > 
> > --- linux-2.6.26-rc4-quilt1.orig/arch/arm/mach-s3c2440/mach-osiris.c	2008-05-27 15:14:42.000000000 +0100
> > +++ linux-2.6.26-rc4-quilt1/arch/arm/mach-s3c2440/mach-osiris.c	2008-05-27 15:22:33.000000000 +0100
> > @@ -1,6 +1,6 @@
> >  /* linux/arch/arm/mach-s3c2440/mach-osiris.c
> >   *
> > - * Copyright (c) 2005 Simtec Electronics
> > + * Copyright (c) 2005,2008 Simtec Electronics
> >   *	http://armlinux.simtec.co.uk/
> >   *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> >   *
> > @@ -19,6 +19,7 @@
> >  #include <linux/sysdev.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/clk.h>
> > +#include <linux/i2c.h>
> >  
> >  #include <asm/mach/arch.h>
> >  #include <asm/mach/map.h>
> > @@ -322,6 +323,19 @@ static struct sys_device osiris_pm_sysde
> >  	.cls		= &osiris_pm_sysclass,
> >  };
> >  
> > +/* I2C devices fitted. */
> > +
> > +static struct i2c_board_info osiris_i2c_info[] __initdata = {
> > +	{
> > +		.type	= "tps65011",
> > +		.addr	= 0x48,
> 
> Please use the I2C_BOARD_INFO helper in all your device declarations.
> 
> > +		.irq	= IRQ_EINT20,
> > +	}, {
> > +		.type	= "eeprom",
> > +		.addr	= 0x50,
> > +	}
> 
> The "eeprom" driver is not a new-style i2c driver, so it won't be able
> to bind to device. Having it declared here even prevents the legacy
> binding to happen, because the address will be busy. So you should
> either not list the eeprom here and let the legacy eeprom driver pick
> it later, or add a new-style mode to the eeprom driver - but then you
> probably want to use David Brownell and Wolfram Sang's at24 driver
> instead, it's much better.

Thanks, I'll change this to at94. Is this driver going to be included
on the next kernel window?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
