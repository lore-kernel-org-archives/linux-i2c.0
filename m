From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: add Renesas R-Car I2C driver
Date: Mon, 8 Oct 2012 11:47:48 +0200
Message-ID: <20121008094748.GB22051@pengutronix.de>
References: <871uk04aa2.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2ctETiVdyKBd_MxY2Ts=1XMPa_cdEJRkQpEySL6du9oLmw@mail.gmail.com>
 <878vczd1hw.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cs5pFpVjqa_MFCLTFqdCo6SSm-1Ep=WtJ7fpABzWEGD9w@mail.gmail.com>
 <20120828101259.409b410b@endymion.delvare>
 <874nnnct03.wl%kuninori.morimoto.gx@renesas.com>
 <CAM=Q2cuGiNnduVa+nnNV_02dYwfrSJoFGesiFBm6Q5U3SGQXpQ@mail.gmail.com>
 <877gred4u1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877gred4u1.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 27, 2012 at 11:44:25PM -0700, Kuninori Morimoto wrote:
> R-Car I2C is similar with SH7760 I2C.
> But the SH7760 I2C driver had many workaround operations, since H/W had b=
ugs.
> Thus, it was pointless to keep compatible between SH7760 and R-Car I2C dr=
ivers.
> This patch creates new Renesas R-Car I2C driver.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Only minor issues which might be fixed later. Applied to -next.

> +static void rcar_i2c_write(struct rcar_i2c_priv *priv, int reg, u32 val)
> +{
> +	writel(val, priv->io + reg);
> +}
> +
> +static u32 rcar_i2c_read(struct rcar_i2c_priv *priv, int reg)
> +{
> +	return readl(priv->io + reg);
> +}

Not sure if those needed encapsulation.

=2E..

> +static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
> +{
> +	struct i2c_msg *msg =3D priv->msg;
> +
> +	/*
> +	 * FIXME
> +	 * sometimes, unknown interrupt happened.
> +	 * Do nothing
> +	 */
> +	if (!(msr & MDE))
> +		return 0;

Uh, is this a known hardware flaw?

=2E..

> +static int __devinit rcar_i2c_probe(struct platform_device *pdev)
> +{
> +	struct i2c_rcar_platform_data *pdata =3D pdev->dev.platform_data;
> +	struct rcar_i2c_priv *priv;
> +	struct i2c_adapter *adap;
> +	struct resource *res;
> +	struct device *dev =3D &pdev->dev;
> +	u32 bus_speed;
> +	int ret;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "no mmio resources\n");
> +		return -ENODEV;
> +	}
> +
> +	priv =3D devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(dev, "no mem for private data\n");
> +		return -ENOMEM;
> +	}
> +
> +	bus_speed =3D 100000; /* default 100 kHz */
> +	if (pdata && pdata->bus_speed)
> +		bus_speed =3D pdata->bus_speed;
> +	ret =3D rcar_i2c_clock_calculate(priv, bus_speed, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv->io =3D devm_ioremap(dev, res->start, resource_size(res));

devm_request_mem_region is missing. Or use the helper
devm_request_and_ioremap.

> +	if (!priv->io) {
> +		dev_err(dev, "cannot ioremap\n");
> +		return -ENODEV;
> +	}
> +
> +	priv->irq =3D platform_get_irq(pdev, 0);
> +	init_waitqueue_head(&priv->wait);
> +	spin_lock_init(&priv->lock);
> +
> +	adap			=3D &priv->adap;
> +	adap->nr		=3D pdev->id;
> +	adap->algo		=3D &rcar_i2c_algo;
> +	adap->class		=3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	adap->retries		=3D 3;

Do you really need the class?

Rest looks good.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlByoUQACgkQD27XaX1/VRvRtwCeIgvF5qRUPSk/NkcaPadIw7Ab
qBEAnictQfJpjCXbeAIUJlSK+p2qVlUK
=vpMJ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
