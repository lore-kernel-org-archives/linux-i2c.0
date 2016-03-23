From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 03/14] i2c-octeon: Change adapter timeout and retry
 default values
Date: Wed, 23 Mar 2016 20:55:18 +0100
Message-ID: <20160323195517.GE19849@katana>
References: <cover.1458289385.git.jglauber@cavium.com>
 <dd3af500365eeeac662a097441259e90a0d3e303.1458289385.git.jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d8Lz2Tf5e5STOWUP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:48083 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756247AbcCWTzV (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 23 Mar 2016 15:55:21 -0400
Content-Disposition: inline
In-Reply-To: <dd3af500365eeeac662a097441259e90a0d3e303.1458289385.git.jglauber@cavium.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--d8Lz2Tf5e5STOWUP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 09:46:28AM +0100, Jan Glauber wrote:
> Convert the adapter timeout to 2 ms instead of a fixed number of
> jiffies and set retries to 10.

You describe what you change, but not why this is needed. Why 10
retries? And shouldn't that be 20ms seeing the HZ/50 ?

Also, please use "i2c: octeon: " as prefix in the subject.

Thanks,

   Wolfram

>=20
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/i2c/busses/i2c-octeon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-oct=
eon.c
> index 9240037..e616e4c 100644
> --- a/drivers/i2c/busses/i2c-octeon.c
> +++ b/drivers/i2c/busses/i2c-octeon.c
> @@ -414,7 +414,6 @@ static struct i2c_adapter octeon_i2c_ops =3D {
>  	.owner =3D THIS_MODULE,
>  	.name =3D "OCTEON adapter",
>  	.algo =3D &octeon_i2c_algo,
> -	.timeout =3D HZ / 50,
>  };
> =20
>  /* calculate and set clock divisors */
> @@ -541,6 +540,8 @@ static int octeon_i2c_probe(struct platform_device *p=
dev)
>  	octeon_i2c_set_clock(i2c);
> =20
>  	i2c->adap =3D octeon_i2c_ops;
> +	i2c->adap.timeout =3D msecs_to_jiffies(2);
> +	i2c->adap.retries =3D 10;
>  	i2c->adap.dev.parent =3D &pdev->dev;
>  	i2c->adap.dev.of_node =3D node;
>  	i2c_set_adapdata(&i2c->adap, i2c);
> --=20
> 1.9.1
>=20

--d8Lz2Tf5e5STOWUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW8vSlAAoJEBQN5MwUoCm2Ch4P+weQ7JfvVsu8JHE3V3g63L45
JW2DZ/+Z7AohAjniU5K/R0qZTE9O161yQSKC7FOWkti1S2fMiY8uQWIrWWLlyk2d
dlOPlSztGAjWztvmsWETG8ZIVwNCgitHYkHUoF7ws8QyXvdnn89dnQbWECUAdveZ
wMW7TB6zzUYPu+xQABObKq5d6BeY5ouZnFXyHArVTL7MTRh74MjxiEN2gqOHOINf
0KAbjVWCwNwB1JHQHU2hT1eI7a0k77+QbNlXhwClLvqdOkStAU04WAYfGuFehq62
Q3S9sgsbP3l1HIYFuLfl39iE4bRoGGCC7aUjRLbcl2ANFx5bb7kAthlyF7sUG6Qd
xO1hP7nA5EaR/pF+X2FE/tpLe8tfnZuGX8NklnGwx01ryfcqR42nO0IwdCB6TqPJ
/8pS7N32RmHaN9Am7y4cvAo1NQMrMbHLkp8znly+XowKVIhYIE6Q+/qgchpI7EfF
C/79iHdC2/un7DPdKCO9AK7m+8XJSt3sfdBD30ryK2wMacSQvVSE4gYlKbRZsLSi
YEWtwcwA6X7KCux42RxQVp0ldiwOMJwqKf2bW8zXL2cDd3X5CLbN5srbwLLYmoP/
TaK42Knzif7Ag9a2fMERYtX1+Pt3qLM3LC1edfUR52tjI2O32v39For4+Gkk1Mdz
KeiaYsQot1xkiIEtF96k
=E642
-----END PGP SIGNATURE-----

--d8Lz2Tf5e5STOWUP--
