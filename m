From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: i801: Create iTCO device on newer Intel PCHs
Date: Tue, 11 Aug 2015 15:14:59 +0100
Message-ID: <20150811141459.GJ18282@x1>
References: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk>
 <1438865186-25794-3-git-send-email-matt@codeblueprint.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438865186-25794-3-git-send-email-matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Fleming <matt-mF/unelCI9GS6iBeEJttW/XRex20P6io@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Fleming <matt.fleming-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 06 Aug 2015, Matt Fleming wrote:

> From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>=20
> Starting from Intel Sunrisepoint (Skylake PCH) the iTCO watchdog reso=
urces
> have been moved to reside under the i801 SMBus host controller wherea=
s
> previously they were under the LPC device.
>=20
> In order to support the iTCO watchdog on newer PCHs we need to create=
 the
> platform device here in the SMBus driver and pass all known resources=
 using
> platform data.
>=20
> Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Matt Fleming <matt.fleming-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>=20
> v4:
>  - No changes
>=20
> v3:
>  - Added Guenter's Review tag
>=20
> v2:
>  - Don't use bitops but same scheme used already
>  - Delete superfluous NULL-checks for platform_device_unregister()
>=20
>  drivers/i2c/busses/i2c-i801.c | 120 ++++++++++++++++++++++++++++++++=
+++++++++-
>  1 file changed, 119 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i=
801.c
> index 5ecbb3fdc27e..eaef9bc9d88c 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -88,12 +88,13 @@
>  #include <linux/slab.h>
>  #include <linux/wait.h>
>  #include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/itco_wdt.h>
> =20
>  #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODU=
LE) && \
>  		defined CONFIG_DMI
>  #include <linux/gpio.h>
>  #include <linux/i2c-mux-gpio.h>
> -#include <linux/platform_device.h>
>  #endif
> =20
>  /* I801 SMBus address offsets */
> @@ -113,6 +114,16 @@
>  #define SMBPCICTL	0x004
>  #define SMBPCISTS	0x006
>  #define SMBHSTCFG	0x040
> +#define TCOBASE		0x050
> +#define TCOCTL		0x054
> +
> +#define ACPIBASE		0x040
> +#define ACPIBASE_SMI_OFF	0x030
> +#define ACPICTRL		0x044
> +#define ACPICTRL_EN		0x080
> +
> +#define SBREG_BAR		0x10
> +#define SBREG_SMBCTRL		0xc6000c
> =20
>  /* Host status bits for SMBPCISTS */
>  #define SMBPCISTS_INTS		0x08
> @@ -125,6 +136,9 @@
>  #define SMBHSTCFG_SMB_SMI_EN	2
>  #define SMBHSTCFG_I2C_EN	4
> =20
> +/* TCO configuration bits for TCOCTL */
> +#define TCOCTL_EN		0x0100
> +
>  /* Auxiliary control register bits, ICH4+ only */
>  #define SMBAUXCTL_CRC		1
>  #define SMBAUXCTL_E32B		2
> @@ -221,6 +235,7 @@ struct i801_priv {
>  	const struct i801_mux_config *mux_drvdata;
>  	struct platform_device *mux_pdev;
>  #endif
> +	struct platform_device *tco_pdev;
>  };
> =20
>  #define FEATURE_SMBUS_PEC	(1 << 0)
> @@ -230,6 +245,7 @@ struct i801_priv {
>  #define FEATURE_IRQ		(1 << 4)
>  /* Not really a feature, but it's convenient to handle it as such */
>  #define FEATURE_IDF		(1 << 15)
> +#define FEATURE_TCO		(1 << 16)
> =20
>  static const char *i801_feature_names[] =3D {
>  	"SMBus PEC",
> @@ -1132,6 +1148,95 @@ static inline unsigned int i801_get_adapter_cl=
ass(struct i801_priv *priv)
>  }
>  #endif
> =20
> +static const struct itco_wdt_platform_data tco_platform_data =3D {
> +	.name =3D "Intel PCH",
> +	.version =3D 4,
> +};
> +
> +static DEFINE_SPINLOCK(p2sb_spinlock);
> +
> +static void i801_add_tco(struct i801_priv *priv)
> +{
> +	struct pci_dev *pci_dev =3D priv->pci_dev;
> +	struct resource tco_res[3], *res;
> +	struct platform_device *pdev;
> +	unsigned int devfn;
> +	u32 tco_base, tco_ctl;
> +	u32 base_addr, ctrl_val;
> +	u64 base64_addr;
> +
> +	if (!(priv->features & FEATURE_TCO))
> +		return;
> +
> +	pci_read_config_dword(pci_dev, TCOBASE, &tco_base);
> +	pci_read_config_dword(pci_dev, TCOCTL, &tco_ctl);
> +	if (!(tco_ctl & TCOCTL_EN))
> +		return;
> +
> +	memset(tco_res, 0, sizeof(tco_res));
> +
> +	res =3D &tco_res[ICH_RES_IO_TCO];
> +	res->start =3D tco_base & ~1;
> +	res->end =3D res->start + 32 - 1;
> +	res->flags =3D IORESOURCE_IO;
> +
> +	/*
> +	 * Power Management registers.
> +	 */
> +	devfn =3D PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 2);
> +	pci_bus_read_config_dword(pci_dev->bus, devfn, ACPIBASE, &base_addr=
);
> +
> +	res =3D &tco_res[ICH_RES_IO_SMI];
> +	res->start =3D (base_addr & ~1) + ACPIBASE_SMI_OFF;
> +	res->end =3D res->start + 3;
> +	res->flags =3D IORESOURCE_IO;
> +
> +	/*
> +	 * Enable the ACPI I/O space.
> +	 */
> +	pci_bus_read_config_dword(pci_dev->bus, devfn, ACPICTRL, &ctrl_val)=
;
> +	ctrl_val |=3D ACPICTRL_EN;
> +	pci_bus_write_config_dword(pci_dev->bus, devfn, ACPICTRL, ctrl_val)=
;
> +
> +	/*
> +	 * We must access the NO_REBOOT bit over the Primary to Sideband
> +	 * bridge (P2SB). The BIOS prevents the P2SB device from being
> +	 * enumerated by the PCI subsystem, so we need to unhide/hide it
> +	 * to lookup the P2SB BAR.
> +	 */
> +	spin_lock(&p2sb_spinlock);
> +
> +	devfn =3D PCI_DEVFN(PCI_SLOT(pci_dev->devfn), 1);
> +
> +	/* Unhide the P2SB device */
> +	pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x0);
> +
> +	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR, &base_add=
r);
> +	base64_addr =3D base_addr & 0xfffffff0;
> +
> +	pci_bus_read_config_dword(pci_dev->bus, devfn, SBREG_BAR + 0x4, &ba=
se_addr);
> +	base64_addr |=3D (u64)base_addr << 32;
> +
> +	/* Hide the P2SB device */
> +	pci_bus_write_config_byte(pci_dev->bus, devfn, 0xe1, 0x1);
> +	spin_unlock(&p2sb_spinlock);
> +
> +	res =3D &tco_res[ICH_RES_MEM_OFF];
> +	res->start =3D (resource_size_t)base64_addr + SBREG_SMBCTRL;
> +	res->end =3D res->start + 3;
> +	res->flags =3D IORESOURCE_MEM;
> +
> +	pdev =3D platform_device_register_resndata(&pci_dev->dev, "iTCO_wdt=
", -1,
> +						 tco_res, 3, &tco_platform_data,
> +						 sizeof(tco_platform_data));
> +	if (IS_ERR(pdev)) {
> +		dev_warn(&pci_dev->dev, "failed to create iTCO device\n");
> +		return;
> +	}
> +
> +	priv->tco_pdev =3D pdev;
> +}
> +
>  static int i801_probe(struct pci_dev *dev, const struct pci_device_i=
d *id)
>  {
>  	unsigned char temp;
> @@ -1149,6 +1254,15 @@ static int i801_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
> =20
>  	priv->pci_dev =3D dev;
>  	switch (dev->device) {
> +	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_SMBUS:
> +	case PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_SMBUS:
> +		priv->features |=3D FEATURE_I2C_BLOCK_READ;
> +		priv->features |=3D FEATURE_IRQ;
> +		priv->features |=3D FEATURE_SMBUS_PEC;
> +		priv->features |=3D FEATURE_BLOCK_BUFFER;
> +		priv->features |=3D FEATURE_TCO;
> +		break;
> +
>  	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0:
>  	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1:
>  	case PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2:
> @@ -1265,6 +1379,8 @@ static int i801_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
>  	dev_info(&dev->dev, "SMBus using %s\n",
>  		 priv->features & FEATURE_IRQ ? "PCI interrupt" : "polling");
> =20
> +	i801_add_tco(priv);
> +
>  	/* set up the sysfs linkage to our parent device */
>  	priv->adapter.dev.parent =3D &dev->dev;
> =20
> @@ -1296,6 +1412,8 @@ static void i801_remove(struct pci_dev *dev)
>  	i2c_del_adapter(&priv->adapter);
>  	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
> =20
> +	platform_device_unregister(priv->tco_pdev);
> +
>  	/*
>  	 * do not call pci_disable_device(dev) since it can cause hard hang=
s on
>  	 * some systems during power-off (eg. Fujitsu-Siemens Lifebook E801=
0)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
