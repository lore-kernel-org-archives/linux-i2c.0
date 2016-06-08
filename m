From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: sm-usb-dig: Add support for the TI SM-USB-DIG
Date: Wed, 8 Jun 2016 14:06:47 +0100
Message-ID: <20160608130647.GD14888@dell>
References: <20160531173045.5742-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36717 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbcFHNGS (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Jun 2016 09:06:18 -0400
Received: by mail-wm0-f43.google.com with SMTP id n184so180896955wmn.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jun 2016 06:06:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160531173045.5742-1-afd@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 31 May 2016, Andrew F. Davis wrote:

> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> Add MFD core support.
>=20
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
> The SPI, GPIO, and 1Wire drivers are WIP.
>=20
>  drivers/mfd/Kconfig            |   8 +++
>  drivers/mfd/Makefile           |   2 +
>  drivers/mfd/sm-usb-dig.c       | 138 +++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/sm-usb-dig.h |  73 ++++++++++++++++++++++
>  4 files changed, 221 insertions(+)
>  create mode 100644 drivers/mfd/sm-usb-dig.c
>  create mode 100644 include/linux/mfd/sm-usb-dig.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1bcf601..455219a 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1373,6 +1373,14 @@ config MFD_LM3533
>  	  additional drivers must be enabled in order to use the LED,
>  	  backlight or ambient-light-sensor functionality of the device.
> =20
> +config MFD_SM_USB_DIG
> +	tristate "Texas Instruments SM-USB-DIG interface adapter"

If it is decided that MFD is truly the best place for this driver, you
are still going to need a USB Ack for it.

> +	select MFD_CORE
> +	help
> +	  Support for the TI SM-USB-DIG USB to SPI/I2C/1Wire/GPIO adapter.
> +	  Additional drivers such as SPI_SM_USB_DIG, I2C_SM_USB_DIG, etc. m=
ust
> +	  be enabled in order to use the functionality of the device.
> +
>  config MFD_TIMBERDALE
>  	tristate "Timberdale FPGA"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 42a66e1..376013e 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -68,6 +68,8 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+=3D wm8350-i2c.o
>  wm8994-objs			:=3D wm8994-core.o wm8994-irq.o wm8994-regmap.o
>  obj-$(CONFIG_MFD_WM8994)	+=3D wm8994.o
> =20
> +obj-$(CONFIG_MFD_SM_USB_DIG)    +=3D sm-usb-dig.o
> +
>  obj-$(CONFIG_TPS6105X)		+=3D tps6105x.o
>  obj-$(CONFIG_TPS65010)		+=3D tps65010.o
>  obj-$(CONFIG_TPS6507X)		+=3D tps6507x.o
> diff --git a/drivers/mfd/sm-usb-dig.c b/drivers/mfd/sm-usb-dig.c
> new file mode 100644
> index 0000000..cf7ccab
> --- /dev/null
> +++ b/drivers/mfd/sm-usb-dig.c

This should probably be ti-sm-usb-dig.c

> @@ -0,0 +1,138 @@
> +/*
> + * MFD Core driver for TI SM-USB-DIG
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *	Andrew F. Davis <afd@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License versi=
on 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether expressed or implied; without even the implied warr=
anty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License version 2 for more details.
> + */
> +
> +#include <linux/usb.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +
> +#include <linux/mfd/sm-usb-dig.h>

All alphabetical.

> +#define USB_VENDOR_ID_TI                0x0451
> +#define USB_DEVICE_ID_TI_SM_USB_DIG	0x2f90

TI at the beginning.

> +#define SMUSBDIG_USB_TIMEOUT		1000	/* in ms */

Rename to SMUSBDIG_USB_TIMEOUT_MS

> +struct smusbdig_device {
> +	struct usb_device *usb_dev;
> +	struct usb_interface *interface;
> +};

s/smusbdig/ti_smusbdig/

=2E.. throughout.

> +int smusbdig_xfer(struct smusbdig_device *smusbdig, u8 *buffer, int =
size)
> +{
> +	struct device *dev =3D &smusbdig->interface->dev;
> +	int actual_length, ret;
> +
> +	if (!smusbdig || !buffer || size <=3D 0)
> +		return -EINVAL;
> +
> +	ret =3D usb_interrupt_msg(smusbdig->usb_dev,
> +				usb_sndctrlpipe(smusbdig->usb_dev, 1),
> +				buffer, size, &actual_length,
> +				SMUSBDIG_USB_TIMEOUT);
> +	if (ret) {
> +		dev_err(dev, "USB transaction failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D usb_interrupt_msg(smusbdig->usb_dev,
> +				usb_rcvctrlpipe(smusbdig->usb_dev, 1),
> +				buffer, SMUSBDIG_PACKET_SIZE, &actual_length,
> +				SMUSBDIG_USB_TIMEOUT);
> +	if (ret) {
> +		dev_err(dev, "USB transaction failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(smusbdig_xfer);
> +
> +static const struct mfd_cell smusbdig_mfd_cells[] =3D {
> +	{ .name =3D "sm-usb-dig-gpio", },
> +	{ .name =3D "sm-usb-dig-i2c", },
> +	{ .name =3D "sm-usb-dig-spi", },
> +	{ .name =3D "sm-usb-dig-w1", },
> +};
> +
> +static int smusbdig_probe(struct usb_interface *interface,
> +			  const struct usb_device_id *usb_id)
> +{
> +	struct usb_host_interface *hostif =3D interface->cur_altsetting;
> +	struct device *dev =3D &interface->dev;
> +	struct smusbdig_device *smusbdig;
> +	u8 buffer[SMUSBDIG_PACKET_SIZE];
> +	int ret;
> +
> +	if (hostif->desc.bInterfaceNumber !=3D 0 ||
> +	    hostif->desc.bNumEndpoints < 2)
> +		return -ENODEV;
> +
> +	smusbdig =3D devm_kzalloc(dev, sizeof(*smusbdig), GFP_KERNEL);
> +	if (!smusbdig)
> +		return -ENOMEM;
> +
> +	smusbdig->usb_dev =3D usb_get_dev(interface_to_usbdev(interface));
> +	smusbdig->interface =3D interface;
> +	usb_set_intfdata(interface, smusbdig);
> +
> +	buffer[0] =3D SMUSBDIG_VERSION;
> +	ret =3D smusbdig_xfer(smusbdig, buffer, 1);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "TI SM-USB-DIG Version: %d.%02d Found\n",
> +		 buffer[0], buffer[1]);
> +
> +	/* Turn on power supply output */
> +	buffer[0] =3D SMUSBDIG_COMMAND;
> +	buffer[1] =3D SMUSBDIG_COMMAND_DUTPOWERON;
> +	ret =3D smusbdig_xfer(smusbdig, buffer, 2);
> +	if (ret)
> +		return ret;
> +
> +	dev_set_drvdata(dev, smusbdig);
> +	ret =3D mfd_add_hotplug_devices(dev, smusbdig_mfd_cells,
> +				      ARRAY_SIZE(smusbdig_mfd_cells));
> +	if (ret) {
> +		dev_err(dev, "unable to add MFD devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void smusbdig_disconnect(struct usb_interface *interface)
> +{
> +	mfd_remove_devices(&interface->dev);
> +}
> +
> +static const struct usb_device_id smusbdig_id_table[] =3D {
> +	{ USB_DEVICE(USB_VENDOR_ID_TI, USB_DEVICE_ID_TI_SM_USB_DIG) },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(usb, smusbdig_id_table);
> +
> +static struct usb_driver smusbdig_driver =3D {
> +	.name =3D "sm-usb-dig",
> +	.probe =3D smusbdig_probe,
> +	.disconnect =3D smusbdig_disconnect,
> +	.id_table =3D smusbdig_id_table,
> +};
> +module_usb_driver(smusbdig_driver);

This doesn't look like an MFD driver.

Why aren't you putting this in the USB subsystem?

> +MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
> +MODULE_DESCRIPTION("Core driver for TI SM-USB-DIG interface adapter"=
);
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/sm-usb-dig.h b/include/linux/mfd/sm-us=
b-dig.h
> new file mode 100644
> index 0000000..1558ff2
> --- /dev/null
> +++ b/include/linux/mfd/sm-usb-dig.h
> @@ -0,0 +1,73 @@
> +/*
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + *	Andrew F. Davis <afd@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License versi=
on 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether expressed or implied; without even the implied warr=
anty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License version 2 for more details.
> + */
> +
> +#ifndef __LINUX_MFD_SM_USB_DIG_H
> +#define __LINUX_MFD_SM_USB_DIG_H
> +
> +#define SMUSBDIG_PACKET_SIZE    32
> +/* (packet size - packet header */
> +#define SMUSBDIG_DATA_SIZE (SMUSBDIG_PACKET_SIZE - 7)
> +
> +enum smusbdig_function {
> +	SMUSBDIG_SPI            =3D 0x01,
> +	SMUSBDIG_I2C            =3D 0x02,
> +	SMUSBDIG_1W             =3D 0x03,
> +	SMUSBDIG_COMMAND        =3D 0x04,
> +	SMUSBDIG_VERSION        =3D 0x07,
> +};
> +
> +enum smusbdig_sub_command {
> +	SMUSBDIG_COMMAND_DUTPOWERON	=3D 0x01,
> +	SMUSBDIG_COMMAND_DUTPOWEROFF	=3D 0x02,
> +};
> +
> +struct smusbdig_packet {
> +	u8 function;
> +	u8 channel;
> +	u8 edge_polarity;
> +	u8 num_commands;
> +	u8 is_command_mask[3];
> +	u8 data[SMUSBDIG_DATA_SIZE];
> +} __packed;
> +
> +static void smusbdig_packet_add_command(struct smusbdig_packet *pack=
et,
> +					int command)
> +{
> +	int num_commands =3D packet->num_commands;
> +	int mask_number =3D num_commands / 8;
> +	int mask_bit =3D num_commands % 8;
> +
> +	if (num_commands >=3D SMUSBDIG_DATA_SIZE)
> +		return;
> +
> +	packet->is_command_mask[mask_number] |=3D BIT(7 - mask_bit);
> +	packet->data[num_commands] =3D command;
> +	packet->num_commands++;
> +}

Inline?

> +static void smusbdig_packet_add_data(struct smusbdig_packet *packet,=
 u8 data)
> +{
> +	int num_commands =3D packet->num_commands;
> +
> +	if (num_commands >=3D SMUSBDIG_DATA_SIZE)
> +		return;
> +
> +	packet->data[num_commands] =3D data;
> +	packet->num_commands++;
> +}

Inline?

> +struct smusbdig_device;
> +int smusbdig_xfer(struct smusbdig_device *smusbdig, u8 *buffer, int =
size);
> +
> +#endif /* __LINUX_MFD_SM_USB_DIG_H */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
