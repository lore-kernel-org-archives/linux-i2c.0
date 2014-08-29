From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: Add support for ACPI i2c device
Date: Fri, 29 Aug 2014 10:39:17 +0200
Message-ID: <20140829083917.GB1329@katana>
References: <carlpeng008@gmail.com>
 <1409281752-1473-1-git-send-email-carlpeng008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409281752-1473-1-git-send-email-carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2014 at 11:09:12AM +0800, Carl Peng wrote:
> AMD platform i2c bus controllers are ACPI devices,
> this patch is to add a ACPI glue for Designware
> core, make it support i2c bus controller with
> ACPI interface.
>=20
> Signed-off-by: Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

i2c-designware-platdrv.c has ACPI support, can't you reuse that?
CCing Mika for ACPI expertise...

> ---
>  drivers/i2c/busses/Kconfig                  |  12 +
>  drivers/i2c/busses/Makefile                 |   1 +
>  drivers/i2c/busses/i2c-designware-acpidrv.c | 355 ++++++++++++++++++++++=
++++++
>  drivers/i2c/busses/i2c-designware-core.h    |   4 +
>  4 files changed, 372 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-designware-acpidrv.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..974700c 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -441,6 +441,18 @@ config I2C_DESIGNWARE_PCI
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-designware-pci.
> =20
> +config I2C_DESIGNWARE_ACPI
> +	tristate "Synopsys DesignWare ACPI"
> +	depends on ACPI
> +	select I2C_DESIGNWARE_CORE
> +	help
> +	  AMD platform i2c bus controller is ACPI device, this driver is
> +	  to add ACPI glue for designware core, make it support ACPI
> +	  interface.
> +
> +	  If you say yes to this option, support will be included for the
> +	  Synopsys DesignWare I2C adapter. Only master mode is supported.
> +
>  config I2C_EFM32
>  	tristate "EFM32 I2C controller"
>  	depends on ARCH_EFM32 || COMPILE_TEST
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 49bf07e..ce86081 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+=3D i2c-designwa=
re-platform.o
>  i2c-designware-platform-objs :=3D i2c-designware-platdrv.o
>  obj-$(CONFIG_I2C_DESIGNWARE_PCI)	+=3D i2c-designware-pci.o
>  i2c-designware-pci-objs :=3D i2c-designware-pcidrv.o
> +obj-$(CONFIG_I2C_DESIGNWARE_ACPI)	+=3D i2c-designware-acpidrv.o
>  obj-$(CONFIG_I2C_EFM32)		+=3D i2c-efm32.o
>  obj-$(CONFIG_I2C_EG20T)		+=3D i2c-eg20t.o
>  obj-$(CONFIG_I2C_EXYNOS5)	+=3D i2c-exynos5.o
> diff --git a/drivers/i2c/busses/i2c-designware-acpidrv.c b/drivers/i2c/bu=
sses/i2c-designware-acpidrv.c
> new file mode 100644
> index 0000000..ebe3a51
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware-acpidrv.c
> @@ -0,0 +1,355 @@
> +/*
> + * Synopsys DesignWare I2C adapter driver (master only).
> + *
> + * Based on the TI DAVINCI I2C adapter driver.
> + *
> + * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2007 MontaVista Software Inc.
> + * Copyright (C) 2009 Provigent Ltd.
> + * Copyright (C) 2011 Intel corporation.
> + *
> + * ---------------------------------------------------------------------=
-------
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * ---------------------------------------------------------------------=
-------
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/acpi.h>
> +
> +#include "i2c-designware-core.h"
> +
> +#define CLK_KHZ	(133 * 1024)
> +#define TX_FIFO_DEPTH	128
> +#define RX_FIFO_DEPTH	128
> +
> +#define DRIVER_NAME	"i2c-designware-acpi"
> +
> +#define INTEL_MID_STD_CFG	(DW_IC_CON_MASTER |			\
> +				DW_IC_CON_SLAVE_DISABLE |	\
> +				DW_IC_CON_RESTART_EN)
> +
> +enum dw_acpi_ctl_id_t {
> +	I2C_BUS_A =3D 0,
> +	I2C_BUS_B,
> +	I2C_BUS_C,
> +	I2C_BUS_D,
> +};
> +
> +struct dw_acpi_controller {
> +	u32 bus_num;
> +	u32 bus_cfg;
> +	u32 tx_fifo_depth;
> +	u32 rx_fifo_depth;
> +	u32 clk_khz;
> +};
> +
> +/*i2c controller parameter*/
> +static struct  dw_acpi_controller  dw_acpi_controllers[] =3D {
> +	[I2C_BUS_A] =3D {
> +		.bus_num     =3D 1,
> +		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth =3D TX_FIFO_DEPTH,
> +		.rx_fifo_depth =3D RX_FIFO_DEPTH,
> +		.clk_khz      =3D  CLK_KHZ,
> +	},
> +	[I2C_BUS_B] =3D {
> +		.bus_num     =3D 2,
> +		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth =3D TX_FIFO_DEPTH,
> +		.rx_fifo_depth =3D RX_FIFO_DEPTH,
> +		.clk_khz      =3D  CLK_KHZ,
> +	},
> +	[I2C_BUS_C] =3D {
> +		.bus_num     =3D 3,
> +		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth =3D TX_FIFO_DEPTH,
> +		.rx_fifo_depth =3D RX_FIFO_DEPTH,
> +		.clk_khz      =3D  CLK_KHZ,
> +	},
> +	[I2C_BUS_D] =3D {
> +		.bus_num     =3D 4,
> +		.bus_cfg   =3D INTEL_MID_STD_CFG | DW_IC_CON_SPEED_STD,
> +		.tx_fifo_depth =3D TX_FIFO_DEPTH,
> +		.rx_fifo_depth =3D RX_FIFO_DEPTH,
> +		.clk_khz      =3D  CLK_KHZ,
> +	},
> +};
> +
> +static struct i2c_algorithm i2c_dw_algo =3D {
> +	.master_xfer	=3D i2c_dw_xfer,
> +	.functionality	=3D i2c_dw_func,
> +};
> +
> +static int i2c_dw_acpi_suspend(struct device *dev)
> +{
> +	struct dw_i2c_dev *i2c =3D acpi_driver_data(to_acpi_device(dev));
> +
> +	i2c_dw_disable(i2c);
> +
> +	return 0;
> +}
> +
> +static int i2c_dw_acpi_resume(struct device *dev)
> +{
> +	struct dw_i2c_dev *i2c =3D acpi_driver_data(to_acpi_device(dev));
> +	u32 enabled;
> +
> +	enabled =3D i2c_dw_is_enabled(i2c);
> +	if (enabled)
> +		return 0;
> +
> +	i2c_dw_init(i2c);
> +
> +	return 0;
> +}
> +
> +static int i2c_dw_acpi_runtime_idle(struct device *dev)
> +{
> +	int err =3D pm_schedule_suspend(dev, 500);
> +
> +	dev_dbg(dev, "runtime_idle called\n");
> +
> +	if (err !=3D 0)
> +		return 0;
> +
> +	return -EBUSY;
> +}
> +
> +static int get_irq_flag(int trigger, int polarity, int share)
> +{
> +	int flags;
> +
> +	if (trigger =3D=3D ACPI_LEVEL_SENSITIVE)
> +		flags =3D (polarity =3D=3D ACPI_ACTIVE_LOW) ? IRQF_TRIGGER_LOW
> +							: IRQF_TRIGGER_HIGH;
> +	else
> +		flags =3D (polarity =3D=3D ACPI_ACTIVE_LOW) ? IRQF_TRIGGER_FALLING
> +							: IRQF_TRIGGER_RISING;
> +
> +	if (share =3D=3D ACPI_SHARED)
> +		flags |=3D IRQF_SHARED;
> +
> +	return flags;
> +}
> +
> +static acpi_status
> +acpi_i2c_parse_resource(struct acpi_resource *res, void *context)
> +{
> +	int ret;
> +	struct dw_i2c_dev *dev =3D context;
> +	struct acpi_resource_fixed_memory32 *fixmem32;
> +
> +	switch (res->type) {
> +	case ACPI_RESOURCE_TYPE_FIXED_MEMORY32:
> +		fixmem32 =3D &res->data.fixed_memory32;
> +		if (!fixmem32)
> +			return AE_NO_MEMORY;
> +
> +		dev->io_base =3D fixmem32->address;
> +		dev->io_length =3D fixmem32->address_length;
> +		ret =3D AE_OK;
> +		break;
> +
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		dev->irq =3D res->data.irq.interrupts[0];
> +		dev->irq_flag =3D get_irq_flag(res->data.irq.triggering,
> +			res->data.irq.polarity, res->data.irq.sharable);
> +		ret =3D AE_OK;
> +		break;
> +
> +	default:
> +		if (dev->io_base && dev->irq)
> +			ret =3D AE_OK;
> +		else
> +			ret =3D AE_NOT_FOUND;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops i2c_dw_pm_ops =3D {
> +	.resume         =3D i2c_dw_acpi_resume,
> +	.suspend        =3D i2c_dw_acpi_suspend,
> +	SET_RUNTIME_PM_OPS(i2c_dw_acpi_suspend, i2c_dw_acpi_resume,
> +			   i2c_dw_acpi_runtime_idle)
> +};
> +
> +static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
> +{
> +	return dev->acpi_controller->clk_khz;
> +}
> +
> +static u32 i2c_get_uid(struct acpi_device *dev)
> +{
> +	return kstrtoul(dev->pnp.unique_id, 10, NULL);
> +}
> +
> +static int i2c_dw_acpi_add(struct acpi_device *pdev)
> +{
> +	int r;
> +	acpi_status status;
> +	struct dw_i2c_dev *dev;
> +	struct i2c_adapter *adap;
> +	struct dw_acpi_controller *controller;
> +	u32 controller_id;
> +
> +	controller_id =3D i2c_get_uid(pdev);
> +
> +	if (controller_id >=3D ARRAY_SIZE(dw_acpi_controllers)) {
> +		dev_err(&pdev->dev, "invalid controller number %d\n",
> +			controller_id);
> +		return  -EINVAL;
> +	}
> +
> +	controller =3D &dw_acpi_controllers[controller_id];
> +
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
> +	if (!dev)
> +		return  -ENOMEM;
> +
> +	status =3D acpi_walk_resources(pdev->handle, METHOD_NAME__CRS,
> +				     acpi_i2c_parse_resource, dev);
> +	if (ACPI_FAILURE(status) || !dev->io_base || !dev->irq) {
> +		dev_err(&pdev->dev, "failure getting resource\n");
> +		return -ENODEV;
> +	}
> +
> +	init_completion(&dev->cmd_complete);
> +	mutex_init(&dev->lock);
> +	dev->clk =3D NULL;
> +	dev->acpi_controller =3D controller;
> +	dev->get_clk_rate_khz =3D i2c_dw_get_clk_rate_khz;
> +	dev->base =3D devm_ioremap(&pdev->dev, dev->io_base, dev->io_length);
> +	if (dev->base =3D=3D NULL) {
> +		dev_err(&pdev->dev, "failure mapping I/O memory\n");
> +		return -EBUSY;
> +	}
> +	dev->dev =3D &pdev->dev;
> +	dev->functionality =3D
> +		I2C_FUNC_I2C |
> +		I2C_FUNC_SMBUS_BYTE |
> +		I2C_FUNC_SMBUS_BYTE_DATA |
> +		I2C_FUNC_SMBUS_WORD_DATA |
> +		I2C_FUNC_SMBUS_I2C_BLOCK;
> +	dev->master_cfg =3D  controller->bus_cfg;
> +
> +	pdev->driver_data =3D dev;
> +
> +	dev->tx_fifo_depth =3D controller->tx_fifo_depth;
> +	dev->rx_fifo_depth =3D controller->rx_fifo_depth;
> +
> +	r =3D i2c_dw_init(dev);
> +	if (r) {
> +		dev_err(&pdev->dev, "failure initiating i2c controller\n");
> +		return -EINVAL;
> +	}
> +
> +	adap =3D &dev->adapter;
> +	i2c_set_adapdata(adap, dev);
> +	adap->owner =3D THIS_MODULE;
> +	adap->class =3D I2C_CLASS_HWMON;
> +	adap->algo =3D &i2c_dw_algo;
> +	adap->dev.parent =3D &pdev->dev;
> +	ACPI_COMPANION_SET(adap->dev.parent, pdev);
> +	adap->nr =3D controller->bus_num;
> +	snprintf(adap->name, sizeof(adap->name), "i2c-designware-acpi-%d",
> +		 adap->nr);
> +
> +	r =3D devm_request_irq(&pdev->dev, dev->irq, i2c_dw_isr, dev->irq_flag,
> +			     adap->name, dev);
> +	if (r) {
> +		dev_err(&pdev->dev, "failure requesting irq %d\n", dev->irq);
> +		return r;
> +	}
> +
> +	i2c_dw_disable_int(dev);
> +	i2c_dw_clear_int(dev);
> +
> +	r =3D i2c_add_numbered_adapter(adap);
> +	if (r) {
> +		dev_err(&pdev->dev, "failure adding adapter\n");
> +		return r;
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static int i2c_dw_acpi_remove(struct acpi_device *pdev)
> +{
> +	struct dw_i2c_dev *dev =3D acpi_driver_data(pdev);
> +
> +	i2c_dw_disable(dev);
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_get_noresume(&pdev->dev);
> +
> +	i2c_del_adapter(&dev->adapter);
> +
> +	return 0;
> +}
> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("i2c_designware-acpi");
> +
> +static const struct acpi_device_id i2_designware_acpi_ids[] =3D {
> +	{ "IFC0000", 0},
> +	{ "AMD0010", 0},
> +	{ "", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, i2_designware_acpi_ids);
> +
> +static struct acpi_driver dw_i2c_driver =3D {
> +	.name =3D         DRIVER_NAME,
> +	.class =3D        DRIVER_NAME,
> +	.ids =3D          i2_designware_acpi_ids,
> +	.ops =3D          {
> +				.add =3D  i2c_dw_acpi_add,
> +				.remove =3D i2c_dw_acpi_remove,
> +			},
> +	.drv.pm =3D &i2c_dw_pm_ops,
> +};
> +
> +static int __init dw_i2c_module_init(void)
> +{
> +	int ret;
> +
> +	ret =3D acpi_bus_register_driver(&dw_i2c_driver);
> +
> +	return ret;
> +}
> +module_init(dw_i2c_module_init);
> +
> +static void __exit dw_i2c_module_exit(void)
> +{
> +	acpi_bus_unregister_driver(&dw_i2c_driver);
> +}
> +module_exit(dw_i2c_module_exit);
> +
> +MODULE_AUTHOR("Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("Synopsys DesignWare ACPI I2C bus adapter");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busse=
s/i2c-designware-core.h
> index d66b6cb..b88dbb8 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -73,11 +73,14 @@
>  struct dw_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;
> +	resource_size_t		io_base;
> +	u32			io_length;
>  	struct completion	cmd_complete;
>  	struct mutex		lock;
>  	struct clk		*clk;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
>  	struct dw_pci_controller *controller;
> +	struct dw_acpi_controller *acpi_controller;
>  	int			cmd_err;
>  	struct i2c_msg		*msgs;
>  	int			msgs_num;
> @@ -91,6 +94,7 @@ struct dw_i2c_dev {
>  	unsigned int		status;
>  	u32			abort_source;
>  	int			irq;
> +	unsigned int		irq_flag;
>  	u32			accessor_flags;
>  	struct i2c_adapter	adapter;
>  	u32			functionality;
> --=20
> 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUADw1AAoJEBQN5MwUoCm2bnQQAI/fgXTLtpMu8ixpKlRU9KRb
gzvpgemzreGFewzvNBjJgAFydiXdrt/VZZC8zceL3dEq4X6bdLMjnKf+O1PAfaox
KJZ/hFuqPAlBgJ0S+E/h0CGw/ZiSeVGQ7ZXWAw016r/3d1x7/txyVtaNglom7F7b
mhDylJ13chhNElsgxJ7zyAlG+w5xx2sXjI8+J+wCm4ye9FhA1eZPLO9W2y68rMtQ
l1KmZgByh5CFbZYYXubm/ezoUtH4Jz13glTtns8SGiagnbSaON+yNucme/egfUiE
RBILiT4zQiR0GttACobRHRulh5yHqKCcGmtd0GOsFQe1gIv7ZDX6rwuMtdUGfqfP
ciIzaGxmIL1Oq9oQugFAg9PbeNswqRkwbIaEKLju9iF+6780fd9f3XY/+4lG9YUs
qJR7z6Q/aFg8oztfuzCT4Xj77uYiicIfW4O+CFT66DjQCmHnDVey64dhiSECnptJ
UWuNUt0kWiLsfROpeD4UeE5OmtemmcQeBgGyuDKhUCR5oZgLNvY2jzsOunSKySQb
p17sflafbeALY8GDqDYPsKDtsAJ00xJfvKRrKHTpmQ/Qrf3KgAvtDsek4YawL+Yi
ulnrlSYoPqxLySktuQrXNhKALCXBudnoLf6CFtoOYtFms07s8JKRTFp60yZqG2qQ
ZLwPH+bfmAFcvSLm7UEz
=flDX
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
