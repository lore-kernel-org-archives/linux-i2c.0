From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] add I2C adapter driver for the netX family of processors
Date: Sat, 26 May 2012 14:35:56 +0200
Message-ID: <20120526123556.GB13919@pengutronix.de>
References: <201205261304.38501.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205261304.38501.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2012 at 01:04:38PM +0200, Juergen Beisert wrote:
> Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d2c5095..6c01f17 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -425,6 +425,16 @@ config I2C_IMX
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-imx.
> =20
> +config I2C_NETX
> +	tristate "NETX I2C interface"
> +	depends on ARCH_NETX
> +	help
> +	  Say Y here if you want to use the IIC bus controller on
> +	  the Hilscher netX processors.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-netx.
> +
>  config I2C_INTEL_MID
>  	tristate "Intel Moorestown/Medfield Platform I2C controller"
>  	depends on PCI
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 569567b..acbe444 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_I2C_SH7760)	+=3D i2c-sh7760.o
>  obj-$(CONFIG_I2C_SH_MOBILE)	+=3D i2c-sh_mobile.o
>  obj-$(CONFIG_I2C_SIMTEC)	+=3D i2c-simtec.o
>  obj-$(CONFIG_I2C_SIRF)		+=3D i2c-sirf.o
> +obj-$(CONFIG_I2C_NETX)		+=3D i2c-netx.o
>  obj-$(CONFIG_I2C_STU300)	+=3D i2c-stu300.o
>  obj-$(CONFIG_I2C_TEGRA)		+=3D i2c-tegra.o
>  obj-$(CONFIG_I2C_VERSATILE)	+=3D i2c-versatile.o

Kconfig and Makefile are sorted, please stick to that.

> diff --git a/drivers/i2c/busses/i2c-netx.c b/drivers/i2c/busses/i2c-netx.c
> new file mode 100644
> index 0000000..4a18996
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-netx.c
> @@ -0,0 +1,422 @@
> +/*
> + * Copyright (c) 2012 Juergen Beisert <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutron=
ix
> + * On behalf of Hilscher GmbH, http://www.hilscher.com/
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
> + * Note: the I2C master hardware on these chips is broken. The silicon c=
annot
> + * detect any ACK signals.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/i2c.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/platform_data/netx_iic.h>

I think I'd prefer "linux/i2c/..."

> +
> +#define NETX_I2C_CTRL 0x00
> +# define NETX_I2C_CTRL_ENABLE (1 << 0)
> +# define NETX_I2C_CTRL_SPEED(x) ((x) << 1)
> +# define NETX_I2C_CTRL_SLAVEID(x) (((x) & 0x7f) << 4)
> +# define NETX_I2C_CTRL_SLAVEMASK (0x7f << 4)
> +
> +#define NETX_I2C_DATA 0x04
> +# define NETX_I2C_DATA_SEND_STOP (1 << 8)
> +# define NETX_I2C_DATA_READ (1 << 9)
> +# define NETX_I2C_DATA_WRITE (0 << 9)
> +# define NETX_I2C_DATA_SEND_START (1 << 10)
> +# define NETX_I2C_DATA_BUSY (1 << 11)
> +# define NETX_I2C_DATA_EXECUTE (1 << 11)
> +# define NETX_I2C_DATA_RDF (1 << 12)
> +
> +struct netx_i2c {
> +	struct i2c_adapter adapter;
> +	unsigned time_idx; /* index into the bt table */
> +	void __iomem *regs;
> +};
> +
> +/* time per byte in [=B5s] at different clock speeds */

Please '[us]' to avoid unnecessary encoding issues.

> +static const unsigned bt[8] =3D {400, 200, 100, 50, 25, 16, 12, 10};
> +
> +static int netx_iic_is_busy(void __iomem *regs)
> +{
> +	u32 val =3D readl(regs + NETX_I2C_DATA);

Newline please.

> +	if (val & NETX_I2C_DATA_BUSY)
> +		return 1; /* still busy */
> +	return 0;

return !!(val & NETX_I2C_DATA_BUSY)?

> +}
> +
> +static void netx_iic_set_slaveid(void __iomem *regs, unsigned sid)
> +{
> +	u32 reg =3D readl(regs + NETX_I2C_CTRL) & ~NETX_I2C_CTRL_SLAVEMASK;
> +
> +	reg |=3D NETX_I2C_CTRL_SLAVEID(sid);
> +	writel(reg, regs + NETX_I2C_CTRL);
> +}
> +
> +static void netx_iic_read_cycle(void __iomem *regs, unsigned iic_flags)
> +{
> +	u32 val =3D iic_flags | NETX_I2C_DATA_READ | NETX_I2C_DATA_EXECUTE;

newline

> +	writel(val, regs + NETX_I2C_DATA);
> +}
> +
> +static u8 netx_iic_read_byte(void __iomem *regs)
> +{
> +	return readl(regs + NETX_I2C_DATA) & 0xff;
> +}
> +
> +static void netx_iic_write_byte(void __iomem *regs, unsigned byte,
> +							unsigned iic_flags)
> +{

Couldn't 'byte' be u8 instead of unsigned?

> +	u32 val =3D (byte & 0xff) | iic_flags | NETX_I2C_DATA_WRITE |
> +							NETX_I2C_DATA_EXECUTE;
> +	writel(val, regs + NETX_I2C_DATA);
> +}
> +
> +static void netx_iic_reset_controller(struct netx_i2c *this)
> +{
> +	writel(0, this->regs + NETX_I2C_CTRL);
> +	udelay(5);
> +	/* re-enable the controller and clear the bus */
> +	writel(NETX_I2C_CTRL_SPEED(this->time_idx) | NETX_I2C_CTRL_ENABLE,
> +			this->regs + NETX_I2C_CTRL);
> +	/* send some empty clocks to terminate all external statemachines */
> +	netx_iic_write_byte(this->regs, 0xff, 0);
> +	udelay(bt[this->time_idx]); /* wait, until this byte was sent */
> +}
> +
> +static int netx_iic_wait(struct netx_i2c *this, unsigned cnt)
> +{
> +	/* we have no interrupt :( */
> +	udelay(bt[this->time_idx] * cnt); /* wait the time for 'n' bytes */
> +	if (netx_iic_is_busy(this->regs)) { /* still busy? */
> +		/* wait a little bit more... */
> +		udelay((bt[this->time_idx] * cnt) >> 1);
> +		if (netx_iic_is_busy(this->regs)) { /* still busy? */
> +			/* no luck */
> +			netx_iic_reset_controller(this);
> +			return -ETIMEDOUT;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * This I2C master controller cannot handle sending the slave address wi=
thout
> + * a payload byte. Thus, we we need a special handling here to get the a=
ddress
> + * out.
> + */
> +static int netx_iic_start_transfer(struct netx_i2c *this, struct i2c_msg=
 *msg,
> +							unsigned iic_flags)
> +{
> +	int rc;
> +
> +	iic_flags |=3D NETX_I2C_DATA_SEND_START;
> +
> +	netx_iic_set_slaveid(this->regs, msg->addr);
> +
> +	if (msg->flags & I2C_M_RD) {
> +		dev_dbg(&this->adapter.dev,
> +			"Send address 0x%02X for reading\n", msg->addr);
> +		netx_iic_read_cycle(this->regs, iic_flags);
> +	} else {
> +		dev_dbg(&this->adapter.dev,
> +			"Send address 0x%02X and byte 0x%02X for writing\n",
> +			msg->addr, msg->buf[0]);
> +		netx_iic_write_byte(this->regs, msg->buf[0], iic_flags);
> +	}
> +
> +	rc =3D netx_iic_wait(this, 2);	/* addr + data */
> +	if (rc < 0) {
> +		dev_err(&this->adapter.dev, "Device addressing timeout\n");
> +		return rc;
> +	}
> +
> +	if (msg->flags & I2C_M_RD) {
> +		msg->buf[0] =3D netx_iic_read_byte(this->regs);
> +		dev_dbg(&this->adapter.dev,
> +				"Receiving byte 0x%02X\n", msg->buf[0]);
> +	}
> +
> +	return 0;
> +}
> +
> +/* set 'iic_flags' to 'NETX_I2C_DATA_SEND_STOP' if this is the last mess=
age */
> +static int netx_iic_read_data_stream(struct netx_i2c *this,
> +			struct i2c_msg *msg, int rec, unsigned iic_flags)
> +{
> +	unsigned u;
> +	int rc;
> +
> +	for (u =3D rec; u < msg->len; u++) {
> +		if (u =3D=3D (msg->len - 1)) { /* last byte? */
> +			netx_iic_read_cycle(this->regs, iic_flags);
> +			dev_dbg(&this->adapter.dev, "Last Byte read\n");
> +		} else {
> +			netx_iic_read_cycle(this->regs, 0);
> +		}
> +
> +		rc =3D netx_iic_wait(this, 1);
> +		if (rc < 0) {
> +			dev_dbg(&this->adapter.dev, "Read timeout\n");
> +			return rc;
> +		}
> +
> +		msg->buf[u] =3D netx_iic_read_byte(this->regs);
> +		dev_dbg(&this->adapter.dev, "Read Byte %02X\n", msg->buf[u]);
> +	}
> +
> +	return 0;
> +}
> +
> +/* set 'iic_flags' to 'NETX_I2C_DATA_SEND_STOP' if this is the last mess=
age */
> +static int netx_iic_write_data_stream(struct netx_i2c *this,
> +			struct i2c_msg *msg, int sent, unsigned iic_flags)
> +{
> +	unsigned u;
> +	int rc;
> +
> +	for (u =3D sent; u < msg->len; u++) {
> +		if (u =3D=3D (msg->len - 1)) { /* last byte? */
> +			netx_iic_write_byte(this->regs, msg->buf[u], iic_flags);
> +			dev_dbg(&this->adapter.dev,
> +				"Last byte '%02X' written\n", msg->buf[u]);
> +		} else {
> +			netx_iic_write_byte(this->regs, msg->buf[u], 0);
> +			dev_dbg(&this->adapter.dev,
> +				"byte '%02X' written\n", msg->buf[u]);
> +			rc =3D netx_iic_wait(this, 1);
> +			if (rc !=3D 0) {

if (netx_iic_wait(this, 1)) ?
Would save the rc-variable and still be readable.

> +				dev_dbg(&this->adapter.dev, "Write timeout\n");
> +				return rc;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int netx_iic_data_stream(struct netx_i2c *this, struct i2c_msg *m=
sg,
> +					int sent, int last_msg)
> +{
> +	unsigned iic_flags =3D last_msg ? NETX_I2C_DATA_SEND_STOP : 0;
> +
> +	if (msg->flags & I2C_M_RD)
> +		return netx_iic_read_data_stream(this, msg, sent, iic_flags);
> +
> +	return netx_iic_write_data_stream(this, msg, sent, iic_flags);
> +}
> +
> +static int netx_iic_xfer(struct i2c_adapter *adapter, struct i2c_msg *ms=
gs,
> +				int msg_cnt)
> +{
> +	unsigned flags =3D 0;
> +	int i, rc, sent;
> +	struct netx_i2c *this =3D i2c_get_adapdata(adapter);
> +
> +	dev_dbg(&this->adapter.dev, "Called to transfer %d messages\n",
> +								msg_cnt);

Drop this. There is a similar debug message in the core which can be
activated via Kconfig.

> +
> +	/* walk through the messages list */
> +	for (i =3D 0; i < msg_cnt; msgs++, i++) {
> +		/* read/write data in one message */
> +		sent =3D 0;
> +		if (!(msgs->flags & I2C_M_NOSTART)) {
> +			if (msgs->len < 1) {
> +				dev_err(&this->adapter.dev,
> +					"Cannot handle messages without data\n");
> +				return -EINVAL;
> +			}
> +
> +			if ((msgs->len =3D=3D 1) && ((i + 1) =3D=3D msg_cnt))
> +				flags |=3D NETX_I2C_DATA_SEND_STOP;
> +
> +			rc =3D netx_iic_start_transfer(this, msgs, flags);
> +			if (rc !=3D 0)
> +				return rc;
> +			sent =3D 1;
> +			/*
> +			 * the regular job here would be to wait for the ACK of
> +			 * the addressed device. But the ACK detection is broken
> +			 * in this I2C master hardware and cannot be used. So,
> +			 * we must continue blindly.
> +			 */
> +		} else
> +			dev_dbg(&this->adapter.dev, "Message without START\n");
> +
> +		if (msgs->len > sent) { /* still remaining data? */
> +			rc =3D netx_iic_data_stream(this, msgs, sent,
> +							(i + 1) =3D=3D msg_cnt);
> +			if (rc !=3D 0)
> +				return rc;
> +		}
> +	}
> +
> +	return i;
> +}
> +
> +static u32 netx_iic_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static struct i2c_algorithm netx_iic_algo =3D {
> +	.master_xfer =3D netx_iic_xfer,
> +	.functionality =3D netx_iic_func,
> +};
> +
> +static void __init netx_iic_set_speed(struct netx_i2c *this,
> +					struct netx_i2c_pdata *pdata)
> +{
> +	unsigned speed =3D ARRAY_SIZE(bt) - 1; /* start with 1 MHz (maximum) */
> +
> +	if (pdata->speed < 1000)
> +		speed--; /* 800 kHz */
> +	if (pdata->speed < 800)
> +		speed--; /* 600 kHz */
> +	if (pdata->speed < 600)
> +		speed--; /* 400 kHz */
> +	if (pdata->speed < 400)
> +		speed--; /* 200 kHz */
> +	if (pdata->speed < 200)
> +		speed--; /* 100 kHz */
> +	if (pdata->speed < 100)
> +		speed--; /* 50 kHz */
> +	if (pdata->speed < 50)
> +		speed--; /* 25 kHz (minimum) */
> +
> +	dev_dbg(&this->adapter.dev, "Setting up speed to index %u\n", speed);
> +
> +	writel(NETX_I2C_CTRL_SPEED(speed), this->regs + NETX_I2C_CTRL);
> +	this->time_idx =3D speed;
> +	netx_iic_reset_controller(this);
> +}
> +
> +static int __init netx_iic_probe(struct platform_device *pdev)
> +{
> +	struct netx_i2c *this;
> +	struct netx_i2c_pdata *pdata =3D pdev->dev.platform_data;
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret;
> +
> +	dev_dbg(&pdev->dev, "Probing IIC master device\n");

There is similar debug output in the driver core.

> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "can't get device resources\n");
> +		return -ENOENT;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +						NETX_IIC_DRIVER_NAME)) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		return -EBUSY;
> +	}
> +
> +	base =3D ioremap(res->start, resource_size(res));
> +	if (!base) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret =3D -EIO;
> +		goto fail1;
> +	}

If you use devm_request_and_ioremap() here...

> +
> +	this =3D kzalloc(sizeof(struct netx_i2c), GFP_KERNEL);
> +	if (!this) {
> +		dev_err(&pdev->dev, "can't allocate interface\n");
> +		ret =3D -ENOMEM;
> +		goto fail2;
> +	}

=2E.. and devm_kzalloc here, you can remove all error paths from this
function and heavily simplify remove().

> +
> +	/* accumulate all available info */
> +	this->regs =3D base;
> +	strcpy(this->adapter.name, pdev->name);
> +	this->adapter.owner =3D THIS_MODULE;
> +	this->adapter.algo =3D &netx_iic_algo;
> +	this->adapter.dev.parent  =3D &pdev->dev;
> +	this->adapter.nr =3D pdev->id;
> +	this->adapter.dev.of_node =3D pdev->dev.of_node; /* TODO */
> +
> +	i2c_set_adapdata(&this->adapter, this);
> +
> +	ret =3D i2c_add_numbered_adapter(&this->adapter);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "registration failed\n");
> +		goto fail3;
> +	}
> +
> +	netx_iic_set_speed(this, pdata);
> +
> +	platform_set_drvdata(pdev, this);
> +
> +	return 0;
> +
> +fail3:
> +	kfree(this);
> +fail2:
> +	iounmap(base);
> +fail1:
> +	release_mem_region(res->start, resource_size(res));
> +	return ret;
> +}
> +
> +static int __devexit netx_iic_remove(struct platform_device *pdev)
> +{
> +	struct netx_i2c *this =3D platform_get_drvdata(pdev);
> +	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	/* remove adapter */
> +	i2c_del_adapter(&this->adapter);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	/* disable the I2C unit */
> +	writel(0, this->regs + NETX_I2C_CTRL);
> +
> +	iounmap(this->regs);
> +	release_mem_region(res->start, resource_size(res));
> +	kfree(this);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id netx_iic_dt_ids[] =3D {
> +	{ .compatible =3D "hilscher,netx-i2c", },
> +	{ /* sentinel */ }
> +};

Please skip this. This platform has no DT support yet, and I prefer to
add it later when it gets added, so it has been tested then.

> +
> +static struct platform_driver netx_iic_driver =3D {
> +	.remove =3D __exit_p(netx_iic_remove),

__devexit_p!

> +	.driver =3D {
> +		.name =3D NETX_IIC_DRIVER_NAME,
> +		.owner =3D THIS_MODULE,
> +		.of_match_table =3D netx_iic_dt_ids,
> +	}
> +};
> +
> +static int __init netx_i2c_adap_init(void)
> +{
> +	return platform_driver_probe(&netx_iic_driver, netx_iic_probe);
> +}
> +subsys_initcall(netx_i2c_adap_init);
> +
> +static void __exit netx_i2c_adap_exit(void)
> +{
> +	platform_driver_unregister(&netx_iic_driver);
> +}
> +module_exit(netx_i2c_adap_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Juergen Beisert");
> +MODULE_DESCRIPTION("I2C adapter driver for netX I2C bus");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> diff --git a/include/linux/platform_data/netx_iic.h b/include/linux/platf=
orm_data/netx_iic.h
> new file mode 100644
> index 0000000..a3e9536
> --- /dev/null
> +++ b/include/linux/platform_data/netx_iic.h
> @@ -0,0 +1,10 @@
> +#ifndef PLATFORM_DATA_NETX_IIC_H
> +# define PLATFORM_DATA_NETX_IIC_H
> +
> +struct netx_i2c_pdata {
> +	unsigned speed;	/* in [kHz] */
> +};
> +
> +#define NETX_IIC_DRIVER_NAME "netx-iic"
> +
> +#endif

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/AziwACgkQD27XaX1/VRvpdACfZOli/VPz7bv3h1T/6hchV/xV
OaoAn2MtAr4P5MxgNNVstLa5wK0Sr2Gr
=rV+S
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
