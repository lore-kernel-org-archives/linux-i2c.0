From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V1] i2c: imx: init bus recovery info before adding i2c
 adapter
Date: Sat, 5 Dec 2015 20:07:36 +0100
Message-ID: <20151205190736.GD1597@katana>
References: <1449221594-29603-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37306 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbbLETHn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 5 Dec 2015 14:07:43 -0500
Content-Disposition: inline
In-Reply-To: <1449221594-29603-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 05:33:14PM +0800, Gao Pan wrote:
> During driver probe, i2c_imx_init_recovery_info() must come before
> i2c_add_numbered_adapter(), because the get/set_scl() functions
> are assigned in i2c_register_adapter() under the conditon that bus
> recover_info are initialized. Otherwise, get/set_scl() function
> pointers never get assigned.
>=20
> In such case, when i2c_generic_gpio_recovery() is used for bus recovery,
> there will be kernel crash because bri->set_scl is NULL.
>=20
> The solution to this bug is moving i2c_imx_init_recovery_info() before
> i2c_register_adapter().
>=20
> Signed-off-by: Gao Pan <b54642@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Makes sense, but I can't apply this one. What is it based on?


--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYzX4AAoJEBQN5MwUoCm2ucMP/RAWbKzY0LB3AvLfY+G4vpgh
nKa9cim7RKN5TQABYE9t6hoHedjH+yl5uAf4Mri1IhHEuZh9deGGQcj7qr2VYk3d
cgoZLMtZFtccF2yDmjt/oN7TM6Tvx55h278qZSmXYqAPULuKMa00FmvRCPkXyOR3
t755Q8oqtCg5NgAD3Av2KW1Gv+v3yalE+Fn8mLc8mMhztdLThKY1HGHZBiGpud2k
rEd1qnma/ZEuHKYx3fKuUYvPEs+AptgmknjZ+1upthWRoviEwztIDtG7bHXTUR1f
i3kSUYUo0rjq+hOJqE/ROY6hu4FJ4+X+d3ojcxaFbXjasVd3vOi8F74PAcHRGOsq
1/3qop4NnaS4zWm6FmjZY/1ihV8MuBtYY6MukO64fOKoOqjTL3mPIkMds0ynzTAi
n75E+/2/A2bLFUE826No/vq+xM0A48SDwgf/qsAzx8ZFYSAuYzaW5vXpqgoOJAwp
CtP6jubjsT26QOY+5CSyiyvrzYVICeNux6rzRpuEEqscdDE3CSM1eJukZXa+yNzr
WT/cn5yRBgN6rnBwh33KmTf+UlyMlgIdmOMLjGb3r04FQy+VutgJmjVzZmSillVq
fZcZ4glyeAT5Kxc38tgovbvN1RLa9hyP5cYvBQI2RgOgQTlrx1hYwR5AnBGrfMct
P9S+ESodAwkG8Yx4fhlF
=PpIs
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
