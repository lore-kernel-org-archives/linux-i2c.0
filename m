From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: pca954x: fix dependencies
Date: Fri, 27 Jun 2014 14:25:30 +0200
Message-ID: <20140627122529.GG2641@katana>
References: <1402319473-14993-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8bBEDOJVaa9YlTAt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1402319473-14993-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8bBEDOJVaa9YlTAt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2014 at 03:11:13PM +0200, Linus Walleij wrote:
> This driver causes the following randconfig build error:
>=20
> drivers/i2c/muxes/i2c-mux-pca954x.c: In function =E2=80=98pca954x_probe=
=E2=80=99:
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:2: error: implicit declaration
> of function =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>   ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:204:7: warning: assignment makes
> pointer from integer without a cast [enabled by default]
>   gpio =3D devm_gpiod_get(&client->dev, "reset");
>        ^
> drivers/i2c/muxes/i2c-mux-pca954x.c:206:3: error: implicit declaration
> of function =E2=80=98gpiod_direction_output=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>    gpiod_direction_output(gpio, 0);
>    ^
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/i2c/muxes/i2c-mux-pca954x.o] Error 1
>=20
> This is because it is getting compiled without gpiolib, so
> introduce an explicit dependency.
>=20
> Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied to for-current, thanks!


--8bBEDOJVaa9YlTAt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTrWK5AAoJEBQN5MwUoCm2j0cP/iMS8htam71IVHvcOpjaeueQ
ibjtg8YqPcWUGmm+9deKLTs8l2PGJFLgchl/dMYn9hCl2nHUQk7XAUrqt4R9hNp2
6BUCVgNIPIsoUslNI5zSLDossr7W6oC6IcL9/dFkUQ7Iuu9YqG21N4q7bkkMuCVa
UWu9/KxA00nmelBIlUQMDF/Gk9aPid1QycXngGrFn++Fk9g2qaN74INu3BNbH4Ru
2CaTpqwu6zyO8Se5ZkuW9oH2PDlInfZj66dSioZ4lGe8zEgLE6WzPv5r9ctKrxax
EBCjM85oRgacaz8rQJQ22q4WQ0cAkw4xb3Yv8wODzKoAhfhTnvmOqnc86LWohK+p
VEYj6osrJVpR6gFjB1oFhu5FVf1/2CYImyr2z/8Zmd5k+NH4l6a9j4LwCFdo7nm/
eqkctI63MViACJHnsQAAvpNWdgUzGZLx4yueYLWHhyvrnBb+FfAM93e8jk746J6d
5CXuH3tmo3WdQMh65bc/iSfad5N9pWFD7G2K+mKnGhLIuEZrrOM5muSt+ij2sRQc
MqFsD+mwXoU7uRqHO1k0VZHVUvs5flubffmZrHAFzTNNdFZo/JZeV4LQWAD0w363
AF8X/Ko5Rg0zNv/4Xl7eKjdb04gff56K/jHJMW2ENwU+8/hSCO/deRdjaP7E819h
ZQ3CT4xT6DknwozrDqBJ
=qO35
-----END PGP SIGNATURE-----

--8bBEDOJVaa9YlTAt--
