From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: add driver for Freescale i.MX28
Date: Mon, 7 Feb 2011 18:21:38 +0100
Message-ID: <20110207172138.GD3123@pengutronix.de>
References: <1295866245-30203-1-git-send-email-w.sang@pengutronix.de>
 <4D40C419.8080508@fluff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D40C419.8080508-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

thanks for the review.

> > +#include <mach/common.h>
>=20
> do we actually use anything from the above?

Yes, mxs_reset_block() is from there. The original driver resets the
whole core after some error conditions. I cannot verify if it is
needed or not, because I sadly cannot create these error conditions
here.

> > +static void mxs_i2c_pioq_setup_write(struct mxs_i2c_dev *i2c,
> > +				    u8 addr, u8 *buf, int len, int flags)
> > +{
> > +	u32 data;
> > +	int i, shifts_left;
> > +
> > +	data =3D MXS_CMD_I2C_WRITE | MXS_I2C_CTRL0_XFER_COUNT(len + 1) | flag=
s;
> > +	__raw_writel(data, i2c->regs + MXS_I2C_QUEUECMD);
> > +
> > +	/* Start with address, then append buffer */
> > +	data =3D ((addr << 1) | I2C_SMBUS_WRITE) << 24;
> > +
> > +	for (i =3D 0; i < len; i++) {
> > +		data >>=3D 8;
> > +		data |=3D buf[i] << 24;
> > +		if ((i & 3) =3D=3D 2)
> > +			__raw_writel(data, i2c->regs + MXS_I2C_DATA);
> > +	}
> > +
> > +	shifts_left =3D 24 - (i & 3) * 8;
> > +	if (shifts_left)
> > +		__raw_writel(data >> shifts_left, i2c->regs + MXS_I2C_DATA);
> > +}
>=20
> I'm going to have a think about the above, since it looks rather
> hard to understand. Any chance of re-writing this?

Will proper comments do? Like

/*
 * We have to copy the slave address (u8) and buffer (lots of u8) into
 * the data register (u32). To achieve that, the u8 are put into the
 * MSBs of 'data' which is then shifted for the next u8. When
 * apropriate, 'data' is written to MXS_I2C_DATA.
 */

? I tried a few versions and liked this best so far...

>=20
> > +static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
> > +{
> > +	unsigned long timeout =3D jiffies + msecs_to_jiffies(1000);
> > +
> > +	while (__raw_readl(i2c->regs + MXS_I2C_QUEUESTAT)
> > +			& MXS_I2C_QUEUESTAT_RD_QUEUE_EMPTY) {
> > +			if (time_after(jiffies, timeout))
> > +				return -ETIMEDOUT;
> > +			cond_resched();
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> surely there's a relevant wait_event here?

Have to check...

> > +static int __devinit mxs_i2c_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct mxs_i2c_dev *i2c;
> > +	struct i2c_adapter *adap;
> > +	struct resource *res;
> > +	resource_size_t res_size;
> > +	int err, irq;
> > +
> > +	i2c =3D devm_kzalloc(dev, sizeof(struct mxs_i2c_dev), GFP_KERNEL);
> > +	if (!i2c)
> > +		return -ENOMEM;
>=20
> Possibly be worth printing an error.

Do you insist on it? I'd think that

[    0.580000] mxs-i2c: probe of mxs-i2c.0 failed with error -12

is telling enough?


> > +	i2c->regs =3D devm_ioremap_nocache(dev, res->start, res_size);
> > +	if (!i2c->regs)
> > +		return -EBUSY;
>=20
> Maybe there should be a devm request to do all of the above in one go.

"should" =3D=3D would be nice if you make one

  or

"should" =3D=3D have a look for one (which I couldn't find)


The rest you mentioned is already fixed here.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1QKiIACgkQD27XaX1/VRsP6QCgjkJtLBQt5DqY2TO7zcfY1Wth
bqEAn1DGoZPeyhPqSeNZslyckq7VkBkk
=BCXR
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
