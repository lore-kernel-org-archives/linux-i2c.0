From: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c_imc: New driver for Intel's iMC, found on
 LGA2011 chips
Date: Sat, 07 Mar 2015 13:48:27 +0100
Message-ID: <1425732507.2281.12.camel@tiscali.nl>
References: <cover.1425695891.git.luto@amacapital.net>
	 <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13443f0542fb447a4c0e558a5f6077c6a76a6e95.1425695891.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rui Wang <ruiv.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Alun Evans <alun-eX+YDEU5biwsV2N9l4h3zg@public.gmane.org>, Robert Elliott <Elliott-VXdhtT5mjnY@public.gmane.org>, Boaz Harrosh <boaz-/8YdC2HfS5554TAoqtyWWQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Just two nits.

Andy Lutomirski schreef op vr 06-03-2015 om 18:50 [-0800]:

> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -149,6 +149,24 @@ config I2C_ISMT
>  	  This driver can also be built as a module.  If so, the module will be
>  	  called i2c-ismt.
>  
> +config I2C_IMC
> +	tristate "Intel iMC (LGA 2011) SMBus Controller"
> +	depends on PCI && X86
> +	select I2C_DIMM_BUS

The pedant in me can't help but notice that I2C_DIMM_BUS itself is added
in patch 2/2. And so is the call of i2c_scan_dimm_bus() in i2c-imc.c
that apparently requires this select. So that select isn't really needed
in this patch but in 2/2.

> +	help
> +	  If you say yes to this option, support will be included for the Intel
> +	  Integrated Memory Controller SMBus host controller interface.  This
> +	  controller is found on LGA 2011 Xeons and Core i7 Extremes.
> +
> +	  There are currently no systems on which the kernel knows that it can
> +	  safely enable this driver.  For now, you need to pass this driver a
> +	  scary module parameter, and you should only pass that parameter if you
> +	  have a special motherboard and know exactly what you are doing.
> +	  Special motherboards include the Supermicro X9DRH-iF-NV.
> +
> +	  This driver can also be built as a module.  If so, the module will be
> +	  called i2c-imc.
> +
>  config I2C_PIIX4
>  	tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
>  	depends on PCI

> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-imc.c
> @@ -0,0 +1,583 @@
> +/*
> + * Copyright (c) 2013 Andrew Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

So you probably want to use
    MODULE_LICENSE("GPL v2");

here.


Paul Bolle
