From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Patch V2] i2c: imx: init bus recovery info before adding i2c
 adapter
Date: Wed, 9 Dec 2015 11:16:53 +0100
Message-ID: <20151209101652.GA2305@katana>
References: <1449630502-14835-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34587 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbbLIKQ7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 9 Dec 2015 05:16:59 -0500
Content-Disposition: inline
In-Reply-To: <1449630502-14835-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: u.kleine-koenig@pengutronix.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de, r49496@freescale.com


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2015 at 11:08:22AM +0800, Gao Pan wrote:
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

Applied to for-current, thanks!


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZ/+UAAoJEBQN5MwUoCm2qGYP/iKzbXqz7NJGCDGfDovp9QZI
F+0O5Hxsi9fRbHq/OGGMa8aywf4LQP/SvWi4b7GKlua6AQzjNU/vfSSNRHdU4YvI
eHab0HqBVh7s5ifpW3W5NOp6rb2sgCLl9vaDGaFOAoUBzm3a8giCj1hKBx91obPE
Dxh1vPgW4ANqdtvyjMIEO+SjIFKX0/zS3Ihoupps8a2uHG2azO9gPeDpvyO1U/sW
/YlBfXWaz87coIIYR0FZJx/cvuSiO/ZZBNW3KCPoI1iroZKNOqg/DYQqfIYr7g2H
ZFVCFy2M7TEVgc1hu1eUZceUR6XE2AT7GRSu0AJCz1cqXQFE41DNrVDbZrqGf80a
eOVIXaNICjE+YlnhlGU9lmEynvTkZ7JaGsxZ0CKcrWsMu7kHdPeRvxJIEqpQ6LwY
tjhRHRdUoQNi7r4pIVRyt4HRGFBCF4FTP2xaVEAgOOPfr5wI+rGr4cJoAjgvTbU7
V93zKzh+nhzIgmg7paT4EbBMbHkVoek2delGrW2sORhjIpoLPr2zJIBQczgK5kC1
MEGR+qiULyM/qxreianUk0S992cTT5dZGTus6URv3UnG2xJblefWwhOD4eA31Vsk
Jfpuos7+2M+9J2QFRgUsFFa2vOJpA8Pb1zRfotsF3Or9iUIQCV6/3TAJO53+U9in
miR5rwvvAntlZ6U7IyI2
=9NWf
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
