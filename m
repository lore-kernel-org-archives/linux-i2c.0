From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 08:52:38 +0100
Message-ID: <20151112075238.GA1551@katana>
References: <1447313109-23583-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151112074447.GA24008@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52973 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbKLHwp (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 Nov 2015 02:52:45 -0500
Content-Disposition: inline
In-Reply-To: <20151112074447.GA24008@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2015 at 08:44:47AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Thu, Nov 12, 2015 at 08:25:09AM +0100, LABBE Corentin wrote:
> > of_match_device could return NULL, and so cause a NULL pointer
> > dereference later.
> >=20
> > Reported-by: coverity (CID 1130036)
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/i2c/busses/i2c-rcar.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rca=
r.c
> > index b0ae560..d2bdbda 100644
> > --- a/drivers/i2c/busses/i2c-rcar.c
> > +++ b/drivers/i2c/busses/i2c-rcar.c
> > @@ -639,6 +639,7 @@ static int rcar_i2c_probe(struct platform_device *p=
dev)
> >  	struct device *dev =3D &pdev->dev;
> >  	u32 bus_speed;
> >  	int irq, ret;
> > +	const struct of_device_id *of_id;
> > =20
> >  	priv =3D devm_kzalloc(dev, sizeof(struct rcar_i2c_priv), GFP_KERNEL);
> >  	if (!priv)
> > @@ -653,7 +654,10 @@ static int rcar_i2c_probe(struct platform_device *=
pdev)
> >  	bus_speed =3D 100000; /* default 100 kHz */
> >  	of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);
> > =20
> > -	priv->devtype =3D (enum rcar_i2c_type)of_match_device(rcar_i2c_dt_ids=
, dev)->data;
> > +	of_id =3D of_match_device(rcar_i2c_dt_ids, dev);
> > +	if (!of_id)
> > +		return -ENODEV;
> > +	priv->devtype =3D (enum rcar_i2c_type)of_id->data;
>=20
> This is nearly an open coding of of_device_get_match_data. Maybe using
>=20
> 	priv->devtype =3D (enum rcar_i2c_type)of_device_get_match_data(dev)
>=20
> if good enough?=20
>=20
> Other than that, the NULL pointer dereference should only happen if the
> device was bound using the driver name. That might be worth to point out
> in the commit log. So maybe make (in a separate patch) the probe
> function fail when probed by name?

RCar is a DT only platform.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWREVGAAoJEBQN5MwUoCm2nEgP/0GUOOV5SnIcX3tBalxWo0iJ
5xN+NT367TQNDKB+JJqvoqGOcFFMfKq3YL6rKSdMcTmvYMqgLb4wSLwWvSdTF6zS
gJ9aL3btz4RcZO/zteNJTif9SHf8IVBTAkNjBuu6G0ipZ+jGt/M4OvFNGxwbOi84
ax+KXBKlHdADTkMVdMbqphx/gR8r3wg8hEcYFBe5L13lq71BwwqP9XnNwlmLbShQ
6MZs8TohbyoX8YH3HKy9Odu+saMBkLuA0CiZzt2NW2ddpgaiOcUGXWBKVsCIeIVQ
O62GLw/9bB4SWsdVXHJYJYQ4l6cCVHgHKzR9nA0NZwMOyj37u77tokSBDRJ/8Ck/
mFwWhYC5PEBirbS3VjZMowCCg5pAuSksGSIV5auIK0HA/SEnJgNUFCW5QW01y1C/
eCSw3CLV6fE0fYS3AV+c1nNhLbPVfVwgKg4l1wnRwCMVvFxNA28/bT4cer6ydZDS
iysHI37j941IonGYhQ3EDRzruh4cCAjhUmqIGO5KvnnpuB3pSKiRh0aSCxTk9yGE
nwJu9/etcJbpeCjB0YMmrLk17EkA+QjZVc77bdJhcmz1nP/2Ykh+/17QtG0+XbmO
rozsL0ceyKaFGgWZmMCpbkPmG6M+QstEqf/WW7xImACAiMBSzR14M9kb+um08GBW
1yWxcv1An34mjznkfq0E
=3bSH
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
