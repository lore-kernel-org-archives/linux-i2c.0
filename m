From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Thu, 9 Oct 2014 08:40:29 +0100
Message-ID: <20141009074029.GL20647@lee--X1>
References: <1412606587-3323-1-git-send-email-muth@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412606587-3323-1-git-send-email-muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 06 Oct 2014, Muthu Mani wrote:

> Adds support for USB-I2C/GPIO interfaces of Cypress Semiconductor
> CYUSBS234 USB-Serial Bridge controller.
>=20
> Details about the device can be found at:
> http://www.cypress.com/?rID=3D84126
>=20
> Signed-off-by: Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since v2:
> * Used auto mfd id to support multiple devices
> * Cleaned up the code
>=20
> Changes since v1:
> * Identified different serial interface and loaded correct cell drive=
r
> * Formed a mfd id to support multiple devices
> * Removed unused platform device
>=20
>  drivers/mfd/Kconfig           |  12 +++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/cyusbs23x.c       | 167 ++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/cyusbs23x.h |  62 ++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 drivers/mfd/cyusbs23x.c
>  create mode 100644 include/linux/mfd/cyusbs23x.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index de5abf2..a31e9e3 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -116,6 +116,18 @@ config MFD_ASIC3
>  	  This driver supports the ASIC3 multifunction chip found on many
>  	  PDAs (mainly iPAQ and HTC based ones)
> =20
> +config MFD_CYUSBS23X
> +        tristate "Cypress CYUSBS23x USB Serial Bridge controller"

White space issue here.

> +	select MFD_CORE
> +	depends on USB
> +	default n
> +	help
> +	  Say yes here if you want support for Cypress Semiconductor
> +	  CYUSBS23x USB-Serial Bridge controller.
> +
> +	  This driver can also be built as a module. If so, the module will=
 be
> +	  called cyusbs23x.
> +
>  config PMIC_DA903X
>  	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
>  	depends on I2C=3Dy
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f001487..fc5bcd1 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -151,6 +151,7 @@ si476x-core-y :=3D si476x-cmd.o si476x-prop.o si4=
76x-i2c.o
>  obj-$(CONFIG_MFD_SI476X_CORE)	+=3D si476x-core.o
> =20
>  obj-$(CONFIG_MFD_CS5535)	+=3D cs5535-mfd.o
> +obj-$(CONFIG_MFD_CYUSBS23X)     +=3D cyusbs23x.o
>  obj-$(CONFIG_MFD_OMAP_USB_HOST)	+=3D omap-usb-host.o omap-usb-tll.o
>  obj-$(CONFIG_MFD_PM8921_CORE) 	+=3D pm8921-core.o ssbi.o
>  obj-$(CONFIG_TPS65911_COMPARATOR)	+=3D tps65911-comparator.o
> diff --git a/drivers/mfd/cyusbs23x.c b/drivers/mfd/cyusbs23x.c
> new file mode 100644
> index 0000000..c70ea40
> --- /dev/null
> +++ b/drivers/mfd/cyusbs23x.c
> @@ -0,0 +1,167 @@
> +/*
> + * Cypress USB-Serial Bridge Controller USB adapter driver
> + *
> + * Copyright (c) 2014 Cypress Semiconductor Corporation.
> + *
> + * Author:
> + *   Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> + *
> + * Additional contributors include:
> + *   Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + */
> +
> +/*
> + * This is core MFD driver for Cypress Semiconductor CYUSBS234 USB-S=
erial
> + * Bridge controller. CYUSBS234 offers a single channel serial inter=
face
> + * (I2C/SPI/UART). It can be configured to enable either of I2C, SPI=
, UART
> + * interfaces. The GPIOs are also available to access.
> + * Details about the device can be found at:
> + *    http://www.cypress.com/?rID=3D84126
> + *
> + * Separate cell drivers are available for I2C and GPIO. SPI and UAR=
T are not
> + * supported yet. All GPIOs are exposed for get operation. However, =
only
> + * unused GPIOs can be set.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +

This '\n' is superfluous, please remove it.

> +#include <linux/mfd/core.h>
> +#include <linux/mfd/cyusbs23x.h>
> +
> +#include <linux/usb.h>
> +
> +static const struct usb_device_id cyusbs23x_usb_table[] =3D {
> +	{ USB_DEVICE(0x04b4, 0x0004) },   /* Cypress Semiconductor */
> +	{ }                               /* Terminating entry */

This comment is not required, please remove it.

> +};
> +
> +MODULE_DEVICE_TABLE(usb, cyusbs23x_usb_table);
> +
> +static const struct mfd_cell cyusbs23x_i2c_devs[] =3D {
> +	{
> +		.name =3D "cyusbs23x-i2c",
> +	},
> +	{
> +		.name =3D "cyusbs23x-gpio",
> +	},
> +};
> +
> +static int update_ep_details(struct usb_interface *interface,
> +				struct cyusbs23x *cyusbs)
> +{
> +	struct usb_host_interface *iface_desc;
> +	struct usb_endpoint_descriptor *ep;
> +	int i;
> +
> +	iface_desc =3D interface->cur_altsetting;
> +
> +	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> +
> +		ep =3D &iface_desc->endpoint[i].desc;
> +
> +		if (!cyusbs->bulk_in_ep_num && usb_endpoint_is_bulk_in(ep))
> +			cyusbs->bulk_in_ep_num =3D ep->bEndpointAddress;
> +		if (!cyusbs->bulk_out_ep_num && usb_endpoint_is_bulk_out(ep))
> +			cyusbs->bulk_out_ep_num =3D ep->bEndpointAddress;
> +		if (!cyusbs->intr_in_ep_num && usb_endpoint_is_int_in(ep))
> +			cyusbs->intr_in_ep_num =3D ep->bEndpointAddress;
> +	}

All of the USB specific code in this driver will require a USB Ack.

> +	dev_dbg(&interface->dev, "%s intr_in=3D%d, bulk_in=3D%d, bulk_out=3D=
%d\n",
> +		__func__, cyusbs->intr_in_ep_num ,
> +		cyusbs->bulk_in_ep_num, cyusbs->bulk_out_ep_num);
> +
> +	if (!cyusbs->bulk_in_ep_num || !cyusbs->bulk_out_ep_num ||
> +		!cyusbs->intr_in_ep_num)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static int cyusbs23x_probe(struct usb_interface *interface,
> +			   const struct usb_device_id *id)
> +{
> +	struct cyusbs23x *cyusbs;
> +	const struct mfd_cell *cyusbs23x_devs;
> +	int ret, ndevs =3D 0;
> +	u8 sub_class;
> +
> +	cyusbs =3D kzalloc(sizeof(*cyusbs), GFP_KERNEL);

Any reason for not using managed resources (devm_*)?

> +	if (cyusbs =3D=3D NULL)

if (!cyusbs)

> +		return -ENOMEM;
> +
> +	cyusbs->usb_dev =3D usb_get_dev(interface_to_usbdev(interface));

Can you do this last?  Then you can remove the 'error' error path.

> +	cyusbs->usb_intf =3D interface;
> +	cyusbs->intf_num =3D interface->cur_altsetting->desc.bInterfaceNumb=
er;

If you're already saving 'interface' there is no need to save this
also, just extract it from 'cyusbs->usb_intf' when you need it.

> +	ret =3D update_ep_details(interface, cyusbs);
> +	if (ret < 0) {

Can ret be > 0?  If not, just do 'if (ret)'

> +		dev_err(&interface->dev, "invalid interface\n");

If you put the error message in update_ep_details() can you print out
a more specific error message and remove this line.

> +		goto error;
> +	}
> +
> +	usb_set_intfdata(interface, cyusbs);
> +
> +	/* Serial interfaces (I2C, SPI, UART) differ in interface subclass =
*/
> +	sub_class =3D interface->cur_altsetting->desc.bInterfaceSubClass;
> +	switch (sub_class) {

This is a waste of a variable and adds nothing to the code.  Just
switch() for 'interface->cur_altsetting->desc.bInterfaceSubClass'.

> +	case CY_USBS_SCB_I2C:
> +		dev_info(&interface->dev, "I2C interface found\n");

Was it even lost?

Would "using I2C interface" be better?

> +		cyusbs23x_devs =3D cyusbs23x_i2c_devs;
> +		ndevs =3D ARRAY_SIZE(cyusbs23x_i2c_devs);
> +		break;

I assume there will be other interfaces supported at a later date?  If
not, this switch() is pretty over-the-top.

> +	default:
> +		dev_err(&interface->dev, "unsupported subclass\n");
> +		ret =3D -ENODEV;
> +		goto error;
> +	}
> +
> +	ret =3D mfd_add_devices(&interface->dev, PLATFORM_DEVID_AUTO,
> +				cyusbs23x_devs, ndevs, NULL, 0, NULL);
> +	if (ret !=3D 0) {

if (ret)

> +		dev_err(&interface->dev, "Failed to add mfd devices to core\n");

"Failed to register devices"

> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	usb_put_dev(cyusbs->usb_dev);
> +	kfree(cyusbs);
> +
> +	return ret;
> +}
> +
> +static void cyusbs23x_disconnect(struct usb_interface *interface)
> +{
> +	struct cyusbs23x *cyusbs =3D usb_get_intfdata(interface);
> +
> +	mfd_remove_devices(&interface->dev);
> +	usb_put_dev(cyusbs->usb_dev);
> +	kfree(cyusbs);

If you use managed resources, you can remove this line.

> +	dev_dbg(&interface->dev, "disconnected\n");

Please remove this line.

> +}
> +
> +static struct usb_driver cyusbs23x_usb_driver =3D {
> +	.name           =3D "cyusbs23x",
> +	.probe          =3D cyusbs23x_probe,
> +	.disconnect     =3D cyusbs23x_disconnect,
> +	.id_table       =3D cyusbs23x_usb_table,
> +};
> +
> +module_usb_driver(cyusbs23x_usb_driver);
> +
> +MODULE_AUTHOR("Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
> +MODULE_AUTHOR("Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("Cypress CYUSBS23x mfd core driver");

s/mfd/MFD/

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/cyusbs23x.h b/include/linux/mfd/cyusbs=
23x.h
> new file mode 100644
> index 0000000..1580d98
> --- /dev/null
> +++ b/include/linux/mfd/cyusbs23x.h
> @@ -0,0 +1,62 @@
> +/*
> + * Cypress USB-Serial Bridge Controller definitions
> + *
> + * Copyright (c) 2014 Cypress Semiconductor Corporation.
> + *
> + * Author:
> + *   Muthu Mani <muth-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> + *
> + * Additional contributors include:
> + *   Rajaram Regupathy <rera-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License version 2 as pu=
blished by
> + * the Free Software Foundation.
> + */
> +
> +#ifndef __MFD_CYUSBS23X_H__
> +#define __MFD_CYUSBS23X_H__
> +
> +#include <linux/types.h>
> +#include <linux/usb.h>
> +
> +/* Structure to hold all device specific stuff */
> +struct cyusbs23x {
> +	struct usb_device *usb_dev;
> +	struct usb_interface *usb_intf;
> +
> +	u8 intf_num;
> +	u8 bulk_in_ep_num;
> +	u8 bulk_out_ep_num;
> +	u8 intr_in_ep_num;
> +};
> +
> +enum cy_usbs_vendor_cmds {
> +	CY_I2C_GET_CONFIG_CMD  =3D 0xC4,
> +	CY_I2C_SET_CONFIG_CMD  =3D 0xC5,
> +	CY_I2C_WRITE_CMD       =3D 0xC6,
> +	CY_I2C_READ_CMD        =3D 0xC7,
> +	CY_I2C_GET_STATUS_CMD  =3D 0xC8,
> +	CY_I2C_RESET_CMD       =3D 0xC9,
> +	CY_GPIO_GET_CONFIG_CMD =3D 0xD8,
> +	CY_GPIO_SET_CONFIG_CMD =3D 0xD9,
> +	CY_GPIO_GET_VALUE_CMD  =3D 0xDA,
> +	CY_GPIO_SET_VALUE_CMD  =3D 0xDB,
> +};
> +
> +/* Serial interfaces (I2C, SPI, UART) differ in interface subclass *=
/
> +enum cy_scb_modes {
> +	CY_USBS_SCB_DISABLED =3D 0,
> +	CY_USBS_SCB_UART =3D 1,
> +	CY_USBS_SCB_SPI =3D 2,
> +	CY_USBS_SCB_I2C =3D 3

No need to number these.

> +};
> +
> +/* SCB index shift */
> +#define CY_SCB_INDEX_SHIFT      15
> +
> +#define CY_USBS_CTRL_XFER_TIMEOUT	2000
> +#define CY_USBS_BULK_XFER_TIMEOUT	5000
> +#define CY_USBS_INTR_XFER_TIMEOUT	5000
> +
> +#endif /* __MFD_CYUSBS23X_H__ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
