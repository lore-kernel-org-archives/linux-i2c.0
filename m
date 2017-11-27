From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: use macro IS_ENABLED in header i2c.h
Date: Mon, 27 Nov 2017 18:32:44 +0100
Message-ID: <20171127173244.fu33wlds5mn673sa@ninjato>
References: <20171101200641.11323-1-contact@stefanchrist.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gemedkbicxkmnfpl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47732 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752780AbdK0Rcq (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 27 Nov 2017 12:32:46 -0500
Content-Disposition: inline
In-Reply-To: <20171101200641.11323-1-contact@stefanchrist.eu>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stefan Lengfeld <contact@stefanchrist.eu>
Cc: linux-i2c@vger.kernel.org


--gemedkbicxkmnfpl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2017 at 09:06:41PM +0100, Stefan Lengfeld wrote:
> From: Stefan Lengfeld <slengfeld@inovex.de>
>=20
> Using the macro IS_ENABLED to check the option CONFIG_I2C=3D(y|m) makes
> the code nicer.  No functional change.
>=20
> Signed-off-by: Stefan Lengfeld <contact@stefanchrist.eu>

Applied to for-next, thanks!


--gemedkbicxkmnfpl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlocTDwACgkQFA3kzBSg
KbY63A/+MHYRPodSy4sDWxX7NRAjlYE4bD+j6fxa5zpAoySvOAmMuYGeCEqyQVsO
j2CuFKbr4MBLb657jTmjWxahLzhacuadtILjxEK43zxOMQtqoVy0NgGMjIEKdNG+
Umc/4PMAkYIGsIWRaNN8cPba3/rNaEd9knykRrc9lsELCcRFArN1cXiIGusafXup
ysQ2sFcJ82lVTeVZCdGyNpes9oWIkCfPMFOvAWkfowDCT5NDDbuWzGveZnTs3Kn2
Xi/uP+MkmOqShUzfk40WenyEgCgjEy/+joIHxwX5YWbNlkXiOz/SynT+0l7VDx8R
0iEQqMCeRPwPljsB9wpfZ4XTUFjxS6p0d3SLv+6vliO3W3UaKGrRHu5T2+1svu67
sbC6eW7yu3pFRpLZriiugT49HEKq4ejDd2a7fbV2LtHgGxotOZh6MmewUCdhRuc2
515NfRBc5xYqWWaSOXtZ20VoxvXrz8Pm5odWx0g8dTcC+I9FAjMKDOxoB3ehnf/r
9ickb9Vi2WyEJ6HaXkx9CBl38U/mTcMufF81cuknGA009D4oeRr2DuKLuwRGIyH+
UzRXPr3+jjeTDiGJXuHU3piikpm4iBk3unjJtzABjueBHOQ6nSgts0lEoOLC0w5T
c1S7u8liLvDX6qM9QU0/Lw37lIF09C8lySRf05C8gy9xL5hrr0U=
=LyMh
-----END PGP SIGNATURE-----

--gemedkbicxkmnfpl--
