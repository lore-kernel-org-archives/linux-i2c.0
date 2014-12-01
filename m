From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/3] mfd: add support for Cypress CYUSBS234 USB Serial
 Bridge controller
Date: Mon, 1 Dec 2014 12:15:33 +0000
Message-ID: <20141201121533.GE15845@x1>
References: <1417241944-17799-1-git-send-email-muth@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417241944-17799-1-git-send-email-muth@cypress.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Muthu Mani <muth@cypress.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, gregkh@linuxfoundation.org, Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Rajaram Regupathy <rera@cypress.com>
List-Id: linux-i2c@vger.kernel.org

> Adds support for USB-I2C/GPIO interfaces of Cypress Semiconductor
> CYUSBS234 USB-Serial Bridge controller.

I would like a USB Ack for this.

> Details about the device can be found at:
> http://www.cypress.com/?rID=3D84126
>=20
> Signed-off-by: Muthu Mani <muth@cypress.com>
> Signed-off-by: Rajaram Regupathy <rera@cypress.com>
> ---
> Changes since v3:
> * Added devm_* allocation function
> * Added vendor commands to read configuration info
>=20
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
>  include/linux/mfd/cyusbs23x.h |  56 ++++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 drivers/mfd/cyusbs23x.c
>  create mode 100644 include/linux/mfd/cyusbs23x.h
>=20
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 1456ea7..504d125 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -116,6 +116,18 @@ config MFD_ASIC3
>           This driver supports the ASIC3 multifunction chip found on =
many
>           PDAs (mainly iPAQ and HTC based ones)
>=20
> +config MFD_CYUSBS23X
> +       tristate "Cypress CYUSBS23x USB Serial Bridge controller"
> +       select MFD_CORE
> +       depends on USB
> +       default n

Not sure there's a requirement for this.  It's not going to magically
turn itself on if not requested.

> +       help
> +         Say yes here if you want support for Cypress Semiconductor
> +         CYUSBS23x USB-Serial Bridge controller.
> +
> +         This driver can also be built as a module. If so, the modul=
e will be
> +         called cyusbs23x.
> +
>  config PMIC_DA903X
>         bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
>         depends on I2C=3Dy
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 8bd54b1..81c0f87 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -151,6 +151,7 @@ si476x-core-y :=3D si476x-cmd.o si476x-prop.o si4=
76x-i2c.o
>  obj-$(CONFIG_MFD_SI476X_CORE)  +=3D si476x-core.o
>=20
>  obj-$(CONFIG_MFD_CS5535)       +=3D cs5535-mfd.o
> +obj-$(CONFIG_MFD_CYUSBS23X)     +=3D cyusbs23x.o
>  obj-$(CONFIG_MFD_OMAP_USB_HOST)        +=3D omap-usb-host.o omap-usb=
-tll.o
>  obj-$(CONFIG_MFD_PM8921_CORE)  +=3D pm8921-core.o ssbi.o
>  obj-$(CONFIG_MFD_SPMI_PMIC)    +=3D qcom-spmi-pmic.o
> diff --git a/drivers/mfd/cyusbs23x.c b/drivers/mfd/cyusbs23x.c
> new file mode 100644
> index 0000000..bdde42f
> --- /dev/null
> +++ b/drivers/mfd/cyusbs23x.c
> @@ -0,0 +1,167 @@
> +/*
> + * Cypress USB-Serial Bridge Controller USB adapter driver
> + *
> + * Copyright (c) 2014 Cypress Semiconductor Corporation.
> + *
> + * Author:
> + *   Muthu Mani <muth@cypress.com>
> + *
> + * Additional contributors include:
> + *   Rajaram Regupathy <rera@cypress.com>
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

By all means put this in the commit log, but I'm not sure it lives
here.  Besides, we can make those assumptions by the lack of entries
in the mfd_cell struct array.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/mutex.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/cyusbs23x.h>
> +
> +#include <linux/usb.h>

Does is this separate?  Please remove the '\n'.

> +/* Serial interfaces (I2C, SPI, UART) differ in interface subclass *=
/
> +enum cy_scb_modes {
> +       CY_USBS_SCB_DISABLED =3D 0,
> +       CY_USBS_SCB_UART =3D 1,
> +       CY_USBS_SCB_SPI =3D 2,
> +       CY_USBS_SCB_I2C =3D 3

Why have you numbered these individually?

> +};
> +
> +static const struct usb_device_id cyusbs23x_usb_table[] =3D {
> +       { USB_DEVICE(0x04b4, 0x0004) },   /* Cypress Semiconductor CY=
USBS234 */
> +       { }
> +};
> +
> +MODULE_DEVICE_TABLE(usb, cyusbs23x_usb_table);
> +
> +static const struct mfd_cell cyusbs23x_i2c_gpio_devs[] =3D {
> +       {
> +               .name =3D "cyusbs23x-i2c",
> +       },
> +       {
> +               .name =3D "cyusbs23x-gpio",
> +       },
> +};

Please make these one line entries:

{ .name =3D "cyusbs23x-i2c", },
{ .name =3D "cyusbs23x-gpio", },

> +static int update_ep_details(struct usb_interface *interface,
> +                               struct cyusbs23x *cyusbs)
> +{
> +       struct usb_host_interface *iface_desc;
> +       struct usb_endpoint_descriptor *ep;
> +       int i;
> +
> +       iface_desc =3D interface->cur_altsetting;
> +
> +       for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
> +
> +               ep =3D &iface_desc->endpoint[i].desc;
> +
> +               if (!cyusbs->bulk_in_ep_num && usb_endpoint_is_bulk_i=
n(ep))
> +                       cyusbs->bulk_in_ep_num =3D ep->bEndpointAddre=
ss;
> +               if (!cyusbs->bulk_out_ep_num && usb_endpoint_is_bulk_=
out(ep))
> +                       cyusbs->bulk_out_ep_num =3D ep->bEndpointAddr=
ess;
> +               if (!cyusbs->intr_in_ep_num && usb_endpoint_is_int_in=
(ep))
> +                       cyusbs->intr_in_ep_num =3D ep->bEndpointAddre=
ss;
> +       }
> +
> +       dev_dbg(&interface->dev, "%s intr_in=3D%d, bulk_in=3D%d, bulk=
_out=3D%d\n",
> +               __func__, cyusbs->intr_in_ep_num ,
> +               cyusbs->bulk_in_ep_num, cyusbs->bulk_out_ep_num);
> +
> +       if (!cyusbs->bulk_in_ep_num || !cyusbs->bulk_out_ep_num ||
> +               !cyusbs->intr_in_ep_num) {
> +               dev_err(&interface->dev, "%s invalid endpoints\n", __=
func__);
> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int cyusbs23x_probe(struct usb_interface *interface,
> +                          const struct usb_device_id *id)
> +{
> +       struct cyusbs23x *cyusbs;
> +       const struct mfd_cell *cyusbs23x_devs;
> +       int ret, ndevs =3D 0;

No need to pre-allocate this.  It can't be used before it's
initialised elsewhere.

> +       cyusbs =3D devm_kzalloc(&interface->dev, sizeof(*cyusbs), GFP=
_KERNEL);
> +       if (!cyusbs)
> +               return -ENOMEM;
> +
> +       ret =3D update_ep_details(interface, cyusbs);
> +       if (ret)
> +               return -ENODEV;
> +
> +       /* Serial interfaces (I2C, SPI, UART) differ in interface sub=
class */
> +       switch (interface->cur_altsetting->desc.bInterfaceSubClass) {
> +       case CY_USBS_SCB_I2C:
> +               dev_info(&interface->dev, "using I2C interface\n");
> +               cyusbs23x_devs =3D cyusbs23x_i2c_gpio_devs;
> +               ndevs =3D ARRAY_SIZE(cyusbs23x_i2c_gpio_devs);

Not sure I get this.  Why do you have local variables for these
instead of using them directly?

> +               break;
> +       default:
> +               dev_err(&interface->dev, "unsupported subclass\n");
> +               return -ENODEV;
> +       }
> +
> +       cyusbs->usb_dev =3D usb_get_dev(interface_to_usbdev(interface=
));
> +       cyusbs->usb_intf =3D interface;
> +       cyusbs->intf_num =3D interface->cur_altsetting->desc.bInterfa=
ceNumber;

If you're saving interface, you probably don't need to save this
separately.

> +       usb_set_intfdata(interface, cyusbs);
> +
> +       ret =3D mfd_add_devices(&interface->dev, PLATFORM_DEVID_AUTO,
> +                               cyusbs23x_devs, ndevs, NULL, 0, NULL)=
;
> +       if (ret) {
> +               dev_err(&interface->dev, "Failed to register devices\=
n");
> +               goto error;
> +       }
> +
> +       dev_info(&interface->dev, "registered MFD device\n");

Remove this line.

> +       return 0;
> +
> +error:
> +       usb_put_dev(cyusbs->usb_dev);

Isn't there a devm_* version of usb_set_intfdata()?

> +       return ret;
> +}
> +
> +static void cyusbs23x_disconnect(struct usb_interface *interface)
> +{
> +       struct cyusbs23x *cyusbs =3D usb_get_intfdata(interface);
> +
> +       mfd_remove_devices(&interface->dev);
> +       usb_put_dev(cyusbs->usb_dev);
> +}
> +
> +static struct usb_driver cyusbs23x_usb_driver =3D {
> +       .name           =3D "cyusbs23x",
> +       .probe          =3D cyusbs23x_probe,
> +       .disconnect     =3D cyusbs23x_disconnect,
> +       .id_table       =3D cyusbs23x_usb_table,
> +};
> +
> +module_usb_driver(cyusbs23x_usb_driver);
> +
> +MODULE_AUTHOR("Rajaram Regupathy <rera@cypress.com>");
> +MODULE_AUTHOR("Muthu Mani <muth@cypress.com>");
> +MODULE_DESCRIPTION("Cypress CYUSBS23x MFD core driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/cyusbs23x.h b/include/linux/mfd/cyusbs=
23x.h
> new file mode 100644
> index 0000000..534fcf7
> --- /dev/null
> +++ b/include/linux/mfd/cyusbs23x.h
> @@ -0,0 +1,56 @@
> +/*
> + * Cypress USB-Serial Bridge Controller definitions
> + *
> + * Copyright (c) 2014 Cypress Semiconductor Corporation.
> + *
> + * Author:
> + *   Muthu Mani <muth@cypress.com>
> + *
> + * Additional contributors include:
> + *   Rajaram Regupathy <rera@cypress.com>
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
> +       struct usb_device *usb_dev;
> +       struct usb_interface *usb_intf;
> +
> +       u8 intf_num;
> +       u8 bulk_in_ep_num;
> +       u8 bulk_out_ep_num;
> +       u8 intr_in_ep_num;
> +};
> +
> +enum cy_usbs_vendor_cmds {
> +       CY_DEV_CMD_READ_CONFIG         =3D 0xB5,
> +       CY_I2C_GET_CONFIG_CMD          =3D 0xC4,
> +       CY_I2C_SET_CONFIG_CMD          =3D 0xC5,
> +       CY_I2C_WRITE_CMD               =3D 0xC6,
> +       CY_I2C_READ_CMD                =3D 0xC7,
> +       CY_I2C_GET_STATUS_CMD          =3D 0xC8,
> +       CY_I2C_RESET_CMD               =3D 0xC9,
> +       CY_GPIO_GET_CONFIG_CMD         =3D 0xD8,
> +       CY_GPIO_SET_CONFIG_CMD         =3D 0xD9,
> +       CY_GPIO_GET_VALUE_CMD          =3D 0xDA,
> +       CY_GPIO_SET_VALUE_CMD          =3D 0xDB,
> +       CY_DEV_ENABLE_CONFIG_READ_CMD  =3D 0xE2
> +};
> +
> +/* SCB index shift */
> +#define CY_SCB_INDEX_SHIFT      15
> +
> +#define CY_USBS_CTRL_XFER_TIMEOUT      2000
> +#define CY_USBS_BULK_XFER_TIMEOUT      5000
> +#define CY_USBS_INTR_XFER_TIMEOUT      5000
> +
> +#endif /* __MFD_CYUSBS23X_H__ */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
