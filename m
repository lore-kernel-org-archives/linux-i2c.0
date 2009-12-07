From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] [MISC] Add HTC PLD driver
Date: Mon, 7 Dec 2009 12:49:46 +0000
Message-ID: <20091207124945.GA9018@sirena.org.uk>
References: <1260083683-13095-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260083683-13095-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Dec 05, 2009 at 11:14:43PM -0800, Cory Maccarrone wrote:
> This change introduces a driver for the HTC PLD chip found
> on some smartphones, such as the HTC Wizard and HTC Herald.
> It works through the I2C bus and provides two main features:
> 
>   * 32 general-purpose I/O pins
>   * Input device support for directional keypad buttons
> 
> The above phones have LCD and keyboard backlight brightness
> and LED controls attached to this chip, as well as some
> power management functions.
> 
> This driver was originally written by
> Angelo Arrifano <miknix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> of the Linwizard project.

> Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>  drivers/misc/Kconfig   |   11 +++
>  drivers/misc/Makefile  |    1 +
>  drivers/misc/htcpld.c  |  204 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/htcpld.h |   14 ++++

A core in drivers/mfd plus drivers/gpio and drivers/input drivers for
the indidivudal functions would be a more natural implementation for
this.

> +void htcpld_chip_set(u8 chip_addr, u8 val)
> +{
> +	struct htcpld_chip_data *chip_data;
> +
> +	if (chip_addr > HTCPLD_ADDR_MAX)
> +		return;
> +
> +	if (!htcpld_chip[chip_addr])
> +		return;
> +
> +	chip_data = i2c_get_clientdata(htcpld_chip[chip_addr]);
> +	if (!chip_data)
> +		return;
> +
> +	i2c_smbus_read_byte_data(htcpld_chip[chip_addr],
> +				(chip_data->cache = val));
> +}
> +EXPORT_SYMBOL_GPL(htcpld_chip_set);

I'd certainly suggest taking a look at how MFD core drivers are usually
structured.  Much of this code looks like it's supposed to be doing the
same job as a MFD driver normally would but without the device model.
