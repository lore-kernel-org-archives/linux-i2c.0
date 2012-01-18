From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: Support for Netlogic XLR/XLS I2C controller.
Date: Wed, 18 Jan 2012 22:27:02 +0100
Message-ID: <20120118212702.GA21576@pengutronix.de>
References: <1326900802-27831-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1326900802-27831-2-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326900802-27831-2-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> +config I2C_XLR
> +	tristate "XLR I2C support"
> +	depends on CPU_XLR
> +	help
> +	  This driver enables support for the on-chip I2C interface of
> +	  the Netlogic XLR/XLS MIPS processors.
> +
> +	  Say yes to this option if you have a Netlogic XLR/XLS based
> +	  board and you need to access the I2C devices (typically the
> +	  RTC, sensors, EEPROM) connected to this interface.

Do you insist on this paragraph?

> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-xlr.
> +
>  config I2C_EG20T
>  	tristate "Intel EG20T PCH / OKI SEMICONDUCTOR IOH(ML7213/ML7223)"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index fba6da6..4372dee 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_I2C_TEGRA)		+=3D i2c-tegra.o
>  obj-$(CONFIG_I2C_VERSATILE)	+=3D i2c-versatile.o
>  obj-$(CONFIG_I2C_OCTEON)	+=3D i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)	+=3D i2c-xiic.o
> +obj-$(CONFIG_I2C_XLR)           +=3D i2c-xlr.o

Use tabs here.

>  obj-$(CONFIG_I2C_EG20T)         +=3D i2c-eg20t.o
> =20
>  # External I2C/SMBus adapter drivers
> diff --git a/drivers/i2c/busses/i2c-xlr.c b/drivers/i2c/busses/i2c-xlr.c
> new file mode 100644
> index 0000000..62307ba
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-xlr.c
> @@ -0,0 +1,285 @@
> +/*
> + * Copyright 2011, Netlogic Microsystems Inc.
> + * Copyright 2004, Matt Porter <mporter-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/ioport.h>
> +#include <linux/delay.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +/* XLR I2C REGISTERS */
> +#define XLR_I2C_CFG		0x00
> +#define XLR_I2C_CLKDIV		0x01
> +#define XLR_I2C_DEVADDR		0x02
> +#define XLR_I2C_ADDR		0x03
> +#define XLR_I2C_DATAOUT		0x04
> +#define XLR_I2C_DATAIN		0x05
> +#define XLR_I2C_STATUS		0x06
> +#define XLR_I2C_STARTXFR	0x07
> +#define XLR_I2C_BYTECNT		0x08
> +#define XLR_I2C_HDSTATIM	0x09
> +
> +/* XLR I2C REGISTERS FLAGS */
> +#define XLR_I2C_BUS_BUSY	0x01
> +#define XLR_I2C_SDOEMPTY	0x02
> +#define XLR_I2C_RXRDY		0x04
> +#define XLR_I2C_ACK_ERR		0x08
> +#define XLR_I2C_ARB_STARTERR	0x30
> +
> +/* Register Values */
> +#define XLR_I2C_CFG_ADDR	0xF8
> +#define XLR_I2C_CFG_NOADDR	0xFA
> +#define XLR_I2C_STARTXFR_ND	0x02    /* No Data */
> +#define XLR_I2C_STARTXFR_RD	0x01    /* Read */
> +#define XLR_I2C_STARTXFR_WR	0x00    /* Write */
> +
> +#define MAX_RETRIES		5000 /* max retries per byte */
> +
> +/*
> + * On XLR/XLS, we need to use __raw_ IO to read the I2C registers
> + * because they are in the big-endian MMIO area on the SoC.
> + *
> + * The readl/writel implementation on XLR/XLS byteswaps, beacause
> + * those are for its little-endian PCI space (see arch/mips/Kconfig).
> + */

Good, thanks.

> +static inline void xlr_i2c_wreg(u32 __iomem *base, unsigned int reg, u32=
 val)
> +{
> +	__raw_writel(val, base + reg);
> +}
> +
> +static inline u32 xlr_i2c_rdreg(u32 __iomem *base, unsigned int reg)
> +{
> +	return __raw_readl(base + reg);
> +}
> +
> +struct xlr_i2c_private {
> +	struct i2c_adapter adap;
> +	u32 __iomem *iobase;
> +};
> +
> +static int xlr_i2c_tx(struct xlr_i2c_private *priv,  u16 len,
> +	u8 *buf, u16 addr)
> +{
> +	struct i2c_adapter *adap =3D &priv->adap;
> +	u32 i2c_status;
> +	int pos, retries;
> +	u8 offset, nb;
> +
> +	offset =3D buf[0];
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_ADDR, offset);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_ADDR);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len - 1);
> +
> +	retries =3D 0;
> +retry:
> +	pos =3D 1;
> +	if (len =3D=3D 1) {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_ND);
> +	} else {
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, buf[pos]);
> +		xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR,
> +				XLR_I2C_STARTXFR_WR);
> +	}
> +
> +	while (1) {
> +		if (retries++ > MAX_RETRIES) {
> +			dev_err(&adap->dev, "I2C transmit timeout\n");
> +			return -ETIMEDOUT;
> +		}

Still no. A device usually fails after trying for a specific period of time,
not after a number of retries. You need to work with jiffies here and
time_after/time_before. Check drivers/misc/eeprom/at24.c for an example.
Or check the second part of my talk from Prague :)
http://free-electrons.com/blog/elce-2011-videos/

> +
> +		i2c_status =3D xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
> +
> +		if (i2c_status & XLR_I2C_SDOEMPTY) {
> +			pos++;
> +			retries =3D 0;
> +			nb =3D (pos < len) ? buf[pos] : 0;
> +			xlr_i2c_wreg(priv->iobase, XLR_I2C_DATAOUT, nb);
> +		}
> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;

This will be an endless loop if the STARTERR condition remains? Also this g=
oto
jumping out of the while loop is not nice. It might help to rearrange the
loops.

> +
> +		if (i2c_status & XLR_I2C_ACK_ERR)
> +			return -EIO;
> +
> +		if (i2c_status & XLR_I2C_BUS_BUSY) {
> +			udelay(1);
> +			continue;
> +		}
> +
> +		if (pos >=3D len)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xlr_i2c_rx(struct xlr_i2c_private *priv, u16 len, u8 *buf, u1=
6 addr)
> +{
> +	struct i2c_adapter *adap =3D &priv->adap;
> +	u32 i2c_status;
> +	int pos, retries;
> +
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_CFG, XLR_I2C_CFG_NOADDR);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_BYTECNT, len);
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_DEVADDR, addr);
> +
> +	retries =3D 0;
> +	pos =3D 0;
> +retry:
> +	xlr_i2c_wreg(priv->iobase, XLR_I2C_STARTXFR, XLR_I2C_STARTXFR_RD);
> +
> +	while (1) {
> +		if (retries++ > MAX_RETRIES) {
> +			dev_err(&adap->dev, "I2C receive timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		i2c_status =3D xlr_i2c_rdreg(priv->iobase, XLR_I2C_STATUS);
> +		if (i2c_status & XLR_I2C_RXRDY) {
> +			buf[pos++] =3D (u8)xlr_i2c_rdreg(priv->iobase,
> +					XLR_I2C_DATAIN);
> +			retries =3D 0;
> +		}

comments from above also here.

> +
> +		if (i2c_status & XLR_I2C_ARB_STARTERR)
> +			goto retry;
> +
> +		if (i2c_status & XLR_I2C_ACK_ERR) {
> +			dev_err(&adap->dev, "I2C receive ACK error\n");
> +			return -EIO;
> +		}
> +
> +		if ((i2c_status & XLR_I2C_BUS_BUSY) =3D=3D 0)
> +			break;
> +		udelay(1);
> +	}
> +	return 0;
> +}
> +
> +static int xlr_i2c_xfer(struct i2c_adapter *adap,
> +	struct i2c_msg *msgs, int num)
> +{
> +	struct i2c_msg *msg;
> +	int i;
> +	int ret =3D 0;
> +	struct xlr_i2c_private *priv =3D i2c_get_adapdata(adap);
> +
> +	for (i =3D 0; ret =3D=3D 0 && i < num; i++) {
> +		msg =3D &msgs[i];
> +		if (msg->flags & I2C_M_RD)
> +			ret =3D xlr_i2c_rx(priv, msg->len, &msg->buf[0],
> +					msg->addr);
> +		else
> +			ret =3D xlr_i2c_tx(priv, msg->len, &msg->buf[0],
> +					msg->addr);
> +	}
> +
> +	return (ret !=3D 0) ? ret : num;
> +}
> +
> +static u32 xlr_func(struct i2c_adapter *adap)
> +{
> +	/* Emulate SMBUS over I2C */
> +	return I2C_FUNC_SMBUS_EMUL | I2C_FUNC_I2C;
> +}
> +
> +static struct i2c_algorithm xlr_i2c_algo =3D {
> +	.master_xfer	=3D xlr_i2c_xfer,
> +	.functionality	=3D xlr_func,
> +};
> +
> +static int __devinit xlr_i2c_probe(struct platform_device *pdev)
> +{
> +	struct xlr_i2c_private  *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENXIO;

You don't have to check res, devm_request_and_ioremap() will do it for you.

> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->iobase =3D devm_request_and_ioremap(&pdev->dev, res);
> +	if (!priv->iobase) {
> +		dev_err(&pdev->dev, "devm_request_and_ioremap failed\n");
> +		ret =3D -EBUSY;
> +		goto err1;
> +	}
> +
> +	priv->adap.dev.parent =3D &pdev->dev;
> +	priv->adap.owner	=3D THIS_MODULE;
> +	priv->adap.algo_data	=3D priv;
> +	priv->adap.algo		=3D &xlr_i2c_algo;
> +	priv->adap.nr		=3D pdev->id;
> +	priv->adap.class	=3D I2C_CLASS_HWMON;
> +	snprintf(priv->adap.name, sizeof(priv->adap.name), "xlr-i2c");
> +
> +	platform_set_drvdata(pdev, priv);
> +	i2c_set_adapdata(&priv->adap, priv);
> +	ret =3D i2c_add_numbered_adapter(&priv->adap);
> +
> +	if (ret < 0) {
> +		dev_err(&priv->adap.dev, "Failed to add i2c bus.\n");
> +		goto err2;
> +	}
> +
> +	dev_info(&priv->adap.dev, "Added I2C Bus.\n");
> +	return 0;
> +err2:
> +	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
> +	devm_iounmap(&pdev->dev, priv->iobase);

You don't need to free devm_* resources. That's the main point of it :)

> +	platform_set_drvdata(pdev, NULL);
> +err1:
> +	devm_kfree(&pdev->dev, priv);
> +	return ret;
> +}
> +
> +static int __devexit xlr_i2c_remove(struct platform_device *pdev)
> +{
> +	struct xlr_i2c_private *priv;
> +	struct resource *res;
> +
> +	priv =3D platform_get_drvdata(pdev);
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	i2c_del_adapter(&priv->adap);
> +	devm_release_mem_region(&pdev->dev, res->start, resource_size(res));
> +	devm_iounmap(&pdev->dev, priv->iobase);
> +	devm_kfree(&pdev->dev, priv);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static struct platform_driver xlr_i2c_driver =3D {
> +	.probe  =3D xlr_i2c_probe,
> +	.remove =3D __devexit_p(xlr_i2c_remove),
> +	.driver =3D {
> +		.name   =3D "xlr-i2cbus",
> +		.owner  =3D THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(xlr_i2c_driver);
> +
> +MODULE_AUTHOR("Ganesan Ramalingam <ganesanr-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>");
> +MODULE_DESCRIPTION("XLR/XLS SoC I2C Controller driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:xlr-i2cbus");
> --=20
> 1.7.5.4
>=20

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk8XOSYACgkQD27XaX1/VRtK1QCeJz+hFik9L/L9gREGy97EuTd3
C0wAnAqIDdn+SIDfQcW8TM62xBLkeQ6H
=WvBQ
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
