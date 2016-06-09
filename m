From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: sm-usb-dig: Add support for the TI SM-USB-DIG
Date: Thu, 9 Jun 2016 15:23:25 +0100
Message-ID: <20160609142325.GD2385@dell>
References: <20160531173045.5742-1-afd@ti.com>
 <20160608130647.GD14888@dell>
 <575857B0.3090504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36241 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcFIOWx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 9 Jun 2016 10:22:53 -0400
Received: by mail-wm0-f51.google.com with SMTP id n184so227826526wmn.1
        for <linux-i2c@vger.kernel.org>; Thu, 09 Jun 2016 07:22:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <575857B0.3090504@ti.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 08 Jun 2016, Andrew F. Davis wrote:

> On 06/08/2016 08:06 AM, Lee Jones wrote:
> > On Tue, 31 May 2016, Andrew F. Davis wrote:
> >=20
> >> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> >> Add MFD core support.
> >>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> ---
> >> The SPI, GPIO, and 1Wire drivers are WIP.
> >>
> >>  drivers/mfd/Kconfig            |   8 +++
> >>  drivers/mfd/Makefile           |   2 +
> >>  drivers/mfd/sm-usb-dig.c       | 138 ++++++++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/mfd/sm-usb-dig.h |  73 ++++++++++++++++++++++
> >>  4 files changed, 221 insertions(+)
> >>  create mode 100644 drivers/mfd/sm-usb-dig.c
> >>  create mode 100644 include/linux/mfd/sm-usb-dig.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 1bcf601..455219a 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -1373,6 +1373,14 @@ config MFD_LM3533
> >>  	  additional drivers must be enabled in order to use the LED,
> >>  	  backlight or ambient-light-sensor functionality of the device.
> >> =20
> >> +config MFD_SM_USB_DIG
> >> +	tristate "Texas Instruments SM-USB-DIG interface adapter"
> >=20
> > If it is decided that MFD is truly the best place for this driver, =
you
> > are still going to need a USB Ack for it.
> >=20
>=20
> Okay, will CC for next version.
>=20
> >> +	select MFD_CORE
> >> +	help
> >> +	  Support for the TI SM-USB-DIG USB to SPI/I2C/1Wire/GPIO adapte=
r.
> >> +	  Additional drivers such as SPI_SM_USB_DIG, I2C_SM_USB_DIG, etc=
=2E must
> >> +	  be enabled in order to use the functionality of the device.
> >> +
> >>  config MFD_TIMBERDALE
> >>  	tristate "Timberdale FPGA"
> >>  	select MFD_CORE
> >> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> >> index 42a66e1..376013e 100644
> >> --- a/drivers/mfd/Makefile
> >> +++ b/drivers/mfd/Makefile
> >> @@ -68,6 +68,8 @@ obj-$(CONFIG_MFD_WM8350_I2C)	+=3D wm8350-i2c.o
> >>  wm8994-objs			:=3D wm8994-core.o wm8994-irq.o wm8994-regmap.o
> >>  obj-$(CONFIG_MFD_WM8994)	+=3D wm8994.o
> >> =20
> >> +obj-$(CONFIG_MFD_SM_USB_DIG)    +=3D sm-usb-dig.o
> >> +
> >>  obj-$(CONFIG_TPS6105X)		+=3D tps6105x.o
> >>  obj-$(CONFIG_TPS65010)		+=3D tps65010.o
> >>  obj-$(CONFIG_TPS6507X)		+=3D tps6507x.o
> >> diff --git a/drivers/mfd/sm-usb-dig.c b/drivers/mfd/sm-usb-dig.c
> >> new file mode 100644
> >> index 0000000..cf7ccab
> >> --- /dev/null
> >> +++ b/drivers/mfd/sm-usb-dig.c
> >=20
> > This should probably be ti-sm-usb-dig.c
> >=20
>=20
> There doesn't seem to be a standard of prefixing devices with their
> manufacturers name, why would here be any different?

Because most drivers have a standard naming convention; maxim, da, lp,
tps, wm, etc.  So they are easy to group and categorise.  Others use
their company or family name; qcom, st, omap, etc, which has the
same effect.  Where as "sm" doesn't really tell me much.

What does the SM stand for anyway?

> >> @@ -0,0 +1,138 @@
> >> +/*
> >> + * MFD Core driver for TI SM-USB-DIG
> >> + *
> >> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www=
=2Eti.com/
> >> + *	Andrew F. Davis <afd@ti.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or
> >> + * modify it under the terms of the GNU General Public License ve=
rsion 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed "as is" WITHOUT ANY WARRANTY of an=
y
> >> + * kind, whether expressed or implied; without even the implied w=
arranty
> >> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See t=
he
> >> + * GNU General Public License version 2 for more details.
> >> + */
> >> +
> >> +#include <linux/usb.h>
> >> +#include <linux/mfd/core.h>
> >> +#include <linux/module.h>
> >> +
> >> +#include <linux/mfd/sm-usb-dig.h>
> >=20
> > All alphabetical.
> >=20
>=20
> ACK
>=20
> >> +#define USB_VENDOR_ID_TI                0x0451
> >> +#define USB_DEVICE_ID_TI_SM_USB_DIG	0x2f90
> >=20
> > TI at the beginning.
> >=20
>=20
> ACK
>=20
> >> +#define SMUSBDIG_USB_TIMEOUT		1000	/* in ms */
> >=20
> > Rename to SMUSBDIG_USB_TIMEOUT_MS
> >=20
>=20
> ACK
>=20
> >> +struct smusbdig_device {
> >> +	struct usb_device *usb_dev;
> >> +	struct usb_interface *interface;
> >> +};
> >=20
> > s/smusbdig/ti_smusbdig/
> >=20
> > ... throughout.
> >=20
>=20
> I'm not sure about this, I don't think anyone else will be making one=
 of
> these and this only adds a lot of extra characters to a lot of lines.

We usually prefix functions by vendor or platform name by convention.

Examples:

  git grep "static struct.*(" -- drivers/mfd/ drivers/spi

> >> +int smusbdig_xfer(struct smusbdig_device *smusbdig, u8 *buffer, i=
nt size)
> >> +{
> >> +	struct device *dev =3D &smusbdig->interface->dev;
> >> +	int actual_length, ret;
> >> +
> >> +	if (!smusbdig || !buffer || size <=3D 0)
> >> +		return -EINVAL;
> >> +
> >> +	ret =3D usb_interrupt_msg(smusbdig->usb_dev,
> >> +				usb_sndctrlpipe(smusbdig->usb_dev, 1),
> >> +				buffer, size, &actual_length,
> >> +				SMUSBDIG_USB_TIMEOUT);
> >> +	if (ret) {
> >> +		dev_err(dev, "USB transaction failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret =3D usb_interrupt_msg(smusbdig->usb_dev,
> >> +				usb_rcvctrlpipe(smusbdig->usb_dev, 1),
> >> +				buffer, SMUSBDIG_PACKET_SIZE, &actual_length,
> >> +				SMUSBDIG_USB_TIMEOUT);
> >> +	if (ret) {
> >> +		dev_err(dev, "USB transaction failed\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(smusbdig_xfer);
> >> +
> >> +static const struct mfd_cell smusbdig_mfd_cells[] =3D {
> >> +	{ .name =3D "sm-usb-dig-gpio", },
> >> +	{ .name =3D "sm-usb-dig-i2c", },
> >> +	{ .name =3D "sm-usb-dig-spi", },
> >> +	{ .name =3D "sm-usb-dig-w1", },
> >> +};
> >> +
> >> +static int smusbdig_probe(struct usb_interface *interface,
> >> +			  const struct usb_device_id *usb_id)
> >> +{
> >> +	struct usb_host_interface *hostif =3D interface->cur_altsetting;
> >> +	struct device *dev =3D &interface->dev;
> >> +	struct smusbdig_device *smusbdig;
> >> +	u8 buffer[SMUSBDIG_PACKET_SIZE];
> >> +	int ret;
> >> +
> >> +	if (hostif->desc.bInterfaceNumber !=3D 0 ||
> >> +	    hostif->desc.bNumEndpoints < 2)
> >> +		return -ENODEV;
> >> +
> >> +	smusbdig =3D devm_kzalloc(dev, sizeof(*smusbdig), GFP_KERNEL);
> >> +	if (!smusbdig)
> >> +		return -ENOMEM;
> >> +
> >> +	smusbdig->usb_dev =3D usb_get_dev(interface_to_usbdev(interface)=
);
> >> +	smusbdig->interface =3D interface;
> >> +	usb_set_intfdata(interface, smusbdig);
> >> +
> >> +	buffer[0] =3D SMUSBDIG_VERSION;
> >> +	ret =3D smusbdig_xfer(smusbdig, buffer, 1);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	dev_info(dev, "TI SM-USB-DIG Version: %d.%02d Found\n",
> >> +		 buffer[0], buffer[1]);
> >> +
> >> +	/* Turn on power supply output */
> >> +	buffer[0] =3D SMUSBDIG_COMMAND;
> >> +	buffer[1] =3D SMUSBDIG_COMMAND_DUTPOWERON;
> >> +	ret =3D smusbdig_xfer(smusbdig, buffer, 2);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	dev_set_drvdata(dev, smusbdig);
> >> +	ret =3D mfd_add_hotplug_devices(dev, smusbdig_mfd_cells,
> >> +				      ARRAY_SIZE(smusbdig_mfd_cells));
> >> +	if (ret) {
> >> +		dev_err(dev, "unable to add MFD devices\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +void smusbdig_disconnect(struct usb_interface *interface)
> >> +{
> >> +	mfd_remove_devices(&interface->dev);
> >> +}
> >> +
> >> +static const struct usb_device_id smusbdig_id_table[] =3D {
> >> +	{ USB_DEVICE(USB_VENDOR_ID_TI, USB_DEVICE_ID_TI_SM_USB_DIG) },
> >> +	{ /* sentinel */ }
> >> +};
> >> +MODULE_DEVICE_TABLE(usb, smusbdig_id_table);
> >> +
> >> +static struct usb_driver smusbdig_driver =3D {
> >> +	.name =3D "sm-usb-dig",
> >> +	.probe =3D smusbdig_probe,
> >> +	.disconnect =3D smusbdig_disconnect,
> >> +	.id_table =3D smusbdig_id_table,
> >> +};
> >> +module_usb_driver(smusbdig_driver);
> >=20
> > This doesn't look like an MFD driver.
> >=20
> > Why aren't you putting this in the USB subsystem?
> >=20
>=20
> This is not a USB driver, it just attaches to the USB bus like other
> drivers in this subsystem that attach to SPI/I2C/Platform buses, driv=
ers
> tend to go into folders based on the functionality they expose, and t=
his
> exposes multiple functions, not USB functionality, so MFD makes the m=
ost
> sense to me.
>=20
> This device/driver is just like the dln2 and viperboard drivers
> currently in the MFD subsystem.

Okay.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
