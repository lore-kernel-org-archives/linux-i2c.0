From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: piix4: Fix request_region size
Date: Thu, 9 Feb 2017 17:14:04 +0100
Message-ID: <20170209161404.vzqzvxddsxnet5tz@ninjato>
References: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pkd644r6n2qhassa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170127145930.13055-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--pkd644r6n2qhassa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 03:59:30PM +0100, Ricardo Ribalda Delgado wrote:
> Since '701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")' we
> are using the SMBSLVCNT register at offset 0x8. We need to request it.
>=20
> Fixes: 701dc207bf55 ("i2c: piix4: Avoid race conditions with IMC")
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Applied to for-current, thanks!


--pkd644r6n2qhassa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliclUwACgkQFA3kzBSg
Kbb61Q/9FBdaBPqtIO4XyTBdAqkV8XcZTI1Z5cC03yT148Ek8qY8t5RcFVrb9aIY
D11bj4GYC+tsiwlhDoekWKGzf5zfeIAn2a+FAWlOXUoKn5sZPmDiDR7VjZvU/0ON
2QmlGhX4gBjX++7+l0YJCc3zCohedFqC6KmF31yl/B3WVP4Qvk4jmIvWsnOyYRKa
f3EipROnfW74JXR0p02956XvcFr9PrCFXsiy8Shl6ts8gGpX/De3/TglPXjfAO1k
HFjFYnoNdbCvTo0DJnFfS9b5Go+GG8PX/6+kblW1Nh/JW0N2ZaXuILbVTW3vEcqh
KrOiNUBR58mDfU6HNQMNHDLJEBqievZCdUdGF8fpgyMUCPFA+SztU66fG65uVytW
czr5xNpdXpdVNc/9yVnVKNckA2WSKstomGfl0UhZMyfdI81HzAqhr9V+ntllSEAc
OJmHXG1804ntjmPy5uqOuNpxRk8AEdofTIfBXPAUarRaypLYSmHJG0GjfBh5qtdb
Gdv9m6iBVnKJB0XMZkiVUdA+YERVSbJ2i97em7ICZnQLQUguw7Cij6cALUf9m3hk
J74OVRdIG5aNQxriZs4+dONCPxZcIl16A7AN0CTaPsL4cRj5pFbWNS0fJ1rv9ZuJ
lhP3iKI77JRl982zuW63cClCYpEl0CpwKLqzWgygUdwVA0h1EUc=
=lFX3
-----END PGP SIGNATURE-----

--pkd644r6n2qhassa--
