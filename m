From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: don't account as iowait
Date: Fri, 7 Nov 2014 18:57:11 +0100
Message-ID: <20141107175711.GF3656@katana>
References: <1415045776-6373-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415045776-6373-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Simon Lindgren <simon-IfRblWqrl23QT0dZR+AlfA@public.gmane.org>, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 09:16:16PM +0100, Wolfram Sang wrote:
> iowait is for blkio [1]. I2C shouldn't use it.
>=20
> [1] https://lkml.org/lkml/2014/11/3/317
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Added stable, applied to for-current, thanks!


--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQf2AAoJEBQN5MwUoCm2pjEQAJiUvyAmrsfSczRsv2DjD1tU
5CXzfODSdtOkJkMTANwMe9dIwJCXJ2DVlG2a4068kouYG9rO2DW0Gg3JrIEV8Txf
pqlLzepJ6RSQQePBLh5ZMlroJQQaRRI4oyzEHrml1BxlTPMeYVUuvzmpHgGJZ5wD
96K52kgaIpQBWyhiTCYuTBKDKlTaR7dl54HddlMARLOJTA0Gm3MLHvQluJoAMP64
4L4MPiiFUp5F3TNeSPwTpGm/4vFj1/RdkJIBCp+sVJW4CGELQbWuiYsUbTTMNsuS
B2Hm1hVwH6jvTxG6b9J30OJh/bRlbO0aTjdLc0EVFwdISapHXZhBI/+8Visp+uz2
gl3im779c5hDyRb+xze9xD0I7uHBeNHbMe1ahccYu5l+M2EXd0Dxdro8Ss3pSbSZ
ls20sp/ekn09sZ2J+ICm9Wyt9rL4Vo4lRqxoys9veIR4P+0HD3o5ppm0f03CCq1h
i/Zoyd7P+fEFqwwku43bOrE/mHQIb77cR9cyPX5hQjLetJCZHrcDsHmiXaEmZEuj
Gd6mEnQyqUPBM4MCnBEMnoLgarUZGwIaF9QbEnl/jzBksLCM+jjwOBVryQZ9pB2k
B6v6rtQotjzWXGDr8vY53BD1ina373UI6SDucq0oraK+YeJAhFQU5CYLDwKVLVB8
KHlaNOBblJ3h865XCoYF
=DfYd
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--
