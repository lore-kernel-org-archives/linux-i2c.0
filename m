From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: imx: Improve message log when DMA is not used
Date: Sun, 3 Jan 2016 19:20:53 +0100
Message-ID: <20160103182053.GC1522@katana>
References: <1446394972-19463-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55842 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbcACSU4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 3 Jan 2016 13:20:56 -0500
Content-Disposition: inline
In-Reply-To: <1446394972-19463-1-git-send-email-festevam@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 01, 2015 at 02:22:51PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> When DMA cannot be used, it is better to state that the I2C controller
> will operate in PIO mode.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to for-next, thanks!


--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWiWaFAAoJEBQN5MwUoCm2+yMP/0VkDjo4G53CbzbmbNnCmNy+
/CrJZop+MKJCSx/n670xU1VSD9w2WIWCo4pcBnQi0fNSlp3t50eUn8QfA8/G2vTF
ze05TSPnbluT2XxM/32j5oeMh5YsbzeCyAmcPgeXaQPVOI5fnWqipYXEzYjKSX1M
nwqP8BFiqPkbfn4ZFbHvmVDqgQhCIE3QRA2csD5f2wy8LKZy5R42mNszn2z7IsEg
RyLYNk8YlPnjU7Bm9qHynIpTyuj1Tm4Zw0cYk9TgzrPDF81DgtnnbP3jQyplLtRx
ohb4H9uyb8dEvUboEUfy+3pecklWNwRczqgAjBhPepIHf6PKJJUnaQ/Fgwjn0dp/
xf1hsrxMFhDol7EtWFfc1OAEPUgVbIhFUbF3zuHFkhYkSZ2ND0Me3vBmJ+j7as9w
jrB3HRRDtDMchNWJLx1O9hBD24oZHlz4TFJeH0O6hqHY7T2AOBxfiRV4tpgfqRew
R9C4u81dDgOaLHATmY8aPB/ixKRgP3vF3s5Tf+N0jhViBgLRTf8xQCfs+xUVbeg+
M+KMGcw3bQdtqlbqpaGsl0okuIkOQKF/5hhbE56TIJ6RcUuMYdnIoPxYMIdgPtMC
M3JAQDr3vTJJoQbSEvgU+zcFavUewFHTJ2Kb1eY8/+CHEjPfkSdyvIwNChBhdAqt
v2UOukgCA4cADAD5Zlwp
=Nmx3
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
