From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v4 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Fri, 26 Aug 2016 11:28:08 +0200
Message-ID: <20160826092808.GG20309@localhost>
References: <20160809145517.22815-1-afd@ti.com>
 <20160809145517.22815-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160809145517.22815-2-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 09, 2016 at 09:55:16AM -0500, Andrew F. Davis wrote:
> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> Add MFD core support.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/mfd/Kconfig             |   9 +++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/ti-smusbdig.c       | 138 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/mfd/ti-smusbdig.c
>  create mode 100644 include/linux/mfd/ti-smusbdig.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2d1fb64..0b63431 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1387,6 +1387,15 @@ config MFD_LM3533
>  	  additional drivers must be enabled in order to use the LED,
>  	  backlight or ambient-light-sensor functionality of the device.
>  
> +config MFD_TI_SMUSBDIG
> +	tristate "Texas Instruments SM-USB-DIG interface adapter"
> +	depends on USB
> +	select MFD_CORE
> +	help
> +	  Support for the TI SM-USB-DIG USB to SPI/I2C/1Wire/GPIO adapter.
> +	  Additional drivers such as SPI_TI_SMUSBDIG, I2C_TI_SMUSBDIG, etc. must
> +	  be enabled in order to use the functionality of the device.
> +
>  config MFD_TIMBERDALE
>  	tristate "Timberdale FPGA"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 2ba3ba3..aa2845e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -68,6 +68,8 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+= wm8350-i2c.o
>  wm8994-objs			:= wm8994-core.o wm8994-irq.o wm8994-regmap.o
>  obj-$(CONFIG_MFD_WM8994)	+= wm8994.o
>  
> +obj-$(CONFIG_MFD_TI_SMUSBDIG)	+= ti-smusbdig.o
> +
>  obj-$(CONFIG_TPS6105X)		+= tps6105x.o
>  obj-$(CONFIG_TPS65010)		+= tps65010.o
>  obj-$(CONFIG_TPS6507X)		+= tps6507x.o
> diff --git a/drivers/mfd/ti-smusbdig.c b/drivers/mfd/ti-smusbdig.c
> new file mode 100644
> index 0000000..19f48c6
> --- /dev/null
> +++ b/drivers/mfd/ti-smusbdig.c
> @@ -0,0 +1,138 @@
> +/*
> + * MFD Core driver for TI SM-USB-DIG
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
> + *	Andrew F. Davis <afd@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether expressed or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License version 2 for more details.
> + */
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/ti-smusbdig.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +
> +#define TI_USB_VENDOR_ID                0x0451
> +#define TI_USB_DEVICE_ID_SM_USB_DIG     0x2f90
> +
> +#define TI_SMUSBDIG_USB_TIMEOUT_MS      1000
> +
> +struct ti_smusbdig_device {
> +	struct usb_device *usb_dev;
> +	struct usb_interface *interface;
> +};
> +
> +int ti_smusbdig_xfer(struct ti_smusbdig_device *ti_smusbdig,
> +		     u8 *buffer, int size)
> +{
> +	struct device *dev = &ti_smusbdig->interface->dev;
> +	int actual_length, ret;
> +
> +	if (!ti_smusbdig || !buffer || size <= 0)
> +		return -EINVAL;

Why not use size_t and skip the negative size check?

> +
> +	ret = usb_interrupt_msg(ti_smusbdig->usb_dev,
> +				usb_sndctrlpipe(ti_smusbdig->usb_dev, 1),

This should be usb_sndintpipe.

Hardcoding the EP number isn't that nice, consider using a define or
determine and store it at probe.

> +				buffer, size, &actual_length,
> +				TI_SMUSBDIG_USB_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(dev, "USB transaction failed\n");

Please include the errno in your error messages (e.g. "failed: %d\n").

You also need to check for short transfers.

> +		return ret;
> +	}
> +
> +	ret = usb_interrupt_msg(ti_smusbdig->usb_dev,
> +				usb_rcvctrlpipe(ti_smusbdig->usb_dev, 1),

usb_rcvintpipe, same comment about hardcoded EP number.

> +				buffer, TI_SMUSBDIG_PACKET_SIZE, &actual_length,
> +				TI_SMUSBDIG_USB_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(dev, "USB transaction failed\n");
> +		return ret;
> +	}

What about the size of the received data? Don't you either need to check
it against TI_SMUSBDIG_PACKET_SIZE or return the actual size read?

> +
> +	return 0;
> +}

You also need to serialise access to the transfer function, or replies
could potentially be mismatched.

> +EXPORT_SYMBOL_GPL(ti_smusbdig_xfer);
> +
> +static const struct mfd_cell ti_smusbdig_mfd_cells[] = {
> +	{ .name = "ti-sm-usb-dig-gpio", },
> +	{ .name = "ti-sm-usb-dig-i2c", },
> +	{ .name = "ti-sm-usb-dig-spi", },
> +	{ .name = "ti-sm-usb-dig-w1", },
> +};
> +
> +static int ti_smusbdig_probe(struct usb_interface *interface,
> +			     const struct usb_device_id *usb_id)
> +{
> +	struct usb_host_interface *hostif = interface->cur_altsetting;
> +	struct device *dev = &interface->dev;
> +	struct ti_smusbdig_device *ti_smusbdig;
> +	u8 buffer[TI_SMUSBDIG_PACKET_SIZE];

You must not use a stack-allocated buffer for DMA transfers (use kalloc
here or in the transfer function).

> +	int ret;
> +
> +	if (hostif->desc.bInterfaceNumber != 0 ||
> +	    hostif->desc.bNumEndpoints < 2)
> +		return -ENODEV;
> +
> +	ti_smusbdig = devm_kzalloc(dev, sizeof(*ti_smusbdig), GFP_KERNEL);
> +	if (!ti_smusbdig)
> +		return -ENOMEM;
> +
> +	ti_smusbdig->usb_dev = usb_get_dev(interface_to_usbdev(interface));

You must put the reference you acquire here in error paths and at
disconnect.

> +	ti_smusbdig->interface = interface;
> +	usb_set_intfdata(interface, ti_smusbdig);
> +
> +	buffer[0] = TI_SMUSBDIG_VERSION;
> +	ret = ti_smusbdig_xfer(ti_smusbdig, buffer, 1);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "TI SM-USB-DIG Version: %d.%02d Found\n",
> +		 buffer[0], buffer[1]);
> +
> +	/* Turn on power supply output */
> +	buffer[0] = TI_SMUSBDIG_COMMAND;
> +	buffer[1] = TI_SMUSBDIG_COMMAND_DUTPOWERON;
> +	ret = ti_smusbdig_xfer(ti_smusbdig, buffer, 2);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(dev, ti_smusbdig);
> +	ret = mfd_add_hotplug_devices(dev, ti_smusbdig_mfd_cells,
> +				      ARRAY_SIZE(ti_smusbdig_mfd_cells));
> +	if (ret) {
> +		dev_err(dev, "unable to add MFD devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ti_smusbdig_disconnect(struct usb_interface *interface)
> +{
> +	mfd_remove_devices(&interface->dev);
> +}
> +
> +static const struct usb_device_id ti_smusbdig_id_table[] = {
> +	{ USB_DEVICE(TI_USB_VENDOR_ID, TI_USB_DEVICE_ID_SM_USB_DIG) },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(usb, ti_smusbdig_id_table);
> +
> +static struct usb_driver ti_smusbdig_driver = {
> +	.name = "ti-sm-usb-dig",
> +	.probe = ti_smusbdig_probe,
> +	.disconnect = ti_smusbdig_disconnect,
> +	.id_table = ti_smusbdig_id_table,
> +};
> +module_usb_driver(ti_smusbdig_driver);
> +
> +MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> +MODULE_DESCRIPTION("Core driver for TI SM-USB-DIG interface adapter");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/ti-smusbdig.h b/include/linux/mfd/ti-smusbdig.h
> new file mode 100644
> index 0000000..46fd2da
> --- /dev/null
> +++ b/include/linux/mfd/ti-smusbdig.h
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
> + *	Andrew F. Davis <afd@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether expressed or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License version 2 for more details.
> + */
> +
> +#ifndef __LINUX_MFD_TI_SMUSBDIG_H
> +#define __LINUX_MFD_TI_SMUSBDIG_H
> +
> +#define TI_SMUSBDIG_PACKET_SIZE    32
> +/* (packet size - packet header */
> +#define TI_SMUSBDIG_DATA_SIZE (TI_SMUSBDIG_PACKET_SIZE - 7)
> +
> +enum ti_smusbdig_function {
> +	TI_SMUSBDIG_SPI            = 0x01,
> +	TI_SMUSBDIG_I2C            = 0x02,
> +	TI_SMUSBDIG_1W             = 0x03,
> +	TI_SMUSBDIG_COMMAND        = 0x04,
> +	TI_SMUSBDIG_VERSION        = 0x07,
> +};
> +
> +enum ti_smusbdig_sub_command {
> +	TI_SMUSBDIG_COMMAND_DUTPOWERON	= 0x01,
> +	TI_SMUSBDIG_COMMAND_DUTPOWEROFF	= 0x02,
> +};
> +
> +struct ti_smusbdig_packet {
> +	u8 function;
> +	u8 channel;
> +	u8 edge_polarity;
> +	u8 num_commands;
> +	u8 is_command_mask[3];
> +	u8 data[TI_SMUSBDIG_DATA_SIZE];
> +} __packed;

So this packet format isn't used for all functions (e.g.
TI_SMUSBDIG_COMMAND above). Is the protocol documented somewhere?

Making the code and header more self-contained would be good, but you
could also provide a link to the documentation.

Thanks,
Johan
