From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: imx: add retries for i2c-0 on Ventana boards
Date: Sat, 9 Jul 2016 11:31:03 +0900
Message-ID: <20160709023102.GA4547@tetsubishi>
References: <1467900229-5262-1-git-send-email-tharvey@gateworks.com>
 <20160708062846.GI16643@pengutronix.de>
 <CAJ+vNU2QLTh7-tbLB_b2S04+pMg3VFjN2kk8T2d6x1okdmbx1A@mail.gmail.com>
 <20160708210714.GK16643@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37423 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbcGICbT (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Jul 2016 22:31:19 -0400
Content-Disposition: inline
In-Reply-To: <20160708210714.GK16643@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > The issue I have is that the i2c device emulates several other devices
> > with existing drivers (pca953x, ds1672, at24) and those drivers don't
> > have any retry mechanism in place for a retry.
> >=20
> > Maybe if I converted those drivers to use regmap I could implement a
> > regmap with retries in the mfd driver for my device?
>=20
> Wolfram: what do you think?

What NAK means is device specific IMO, so to do it generally at regmap
level is convenient but wrong. at24 already has retry support because it
may be accessed while in an erase cycle. I don't know the other devices.
You need to discuss with the driver authors/maintainers if a NAK can
generally mean "let's retry" or if you need a seperate i2c_device_id for
your variant which then handles the NAK differently.


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXgGHlAAoJEBQN5MwUoCm2mBMP/2rXlH1rUNoL+l4PMuJ/+e0W
AZ/O9isA8hHfJ4zUC9NNtR2wMXrESqm0nlaxLl2TMu+cH84XcNU4slKzyDG+6/Wa
jujZjIzSt/lG7EjcvHn5YXUECmn9axU2/+t1GXRC19ErZnjIYJlP7z2NnSoNTMQ1
2OYnRKgl7JUqMAeLCJsxDK4TjNmZZ+Vtsc9gNeEO3YLb1j5ivdRCXrr2I1/h+5Qg
QmuLEC37cMgHcCDBWahVoXb4z1w65BeQXMGjTm7jFmNCzU8dMWnslGyHhJa07kJH
594CgQC6NdHhYeGX56MaPpLRr3zkm1rKE5qwHNk08z98T/xMGTsTpzuLxGGKBuQk
FaiGUIuxSyli9MSgCkAk0xEyVyFmfGl6rlD9SpAnylHAVi1q03R6FiQx6FZD/16C
6iNCqRRyfQLP5+iXuJ6AI7oKYnZJUbly1eMzqC9upnppLHkQHg0JgtCtnrXxuPgI
zcZ2jhiNLqngslv6h+kj2pqSDD8jbr/XDkmLnp07VhFJtnXZk7gOb1nyao8y7VDH
xy3Zy6bALpxAd/8Sw//qpoAUkXhNsi3BSNP2yiwOyEubhKgSafvlFK4YBGQ+ddLX
kyhEXEUT5xvpXrlWN7KEG+U5YfuNlwOBvyhIpieK0ALs67NEYKTRJzv+iL3F2HKm
3Q8Apz2DAqex6LM7DqRZ
=EcHD
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
