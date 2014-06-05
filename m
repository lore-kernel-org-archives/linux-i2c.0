From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: pca954x: Fix compilation without CONFIG_GPIOLIB
Date: Thu, 5 Jun 2014 15:11:23 +0200
Message-ID: <20140605131123.GA2837@katana>
References: <CA+r1Zhi9Qd4aZ2WJ02K4Gv=zg7QvG+r=t2VpiXRKXcYRc1vt=A@mail.gmail.com>
 <1401900992-16581-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401900992-16581-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 04, 2014 at 06:56:32PM +0200, Laurent Pinchart wrote:
> The pca954x driver recently switched to the GPIO descriptor API without
> including the correct <linux/gpio/consumer.h> header. This breaks
> compilation without CONFIG_GPIOLIB.
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
> Fix it by including the right header.
>=20
> Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Applied to for-next, thanks!


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTkGx7AAoJEBQN5MwUoCm26ZMP/irveKFJYHwzFytMwXgURcIL
b+ujBwBPeBwtrWKWus96Ye6lk527d0hJRLMjemyT+M1IfGaUsKTJ4ivXcOq7Hfix
KxEeV6yv3h9Epuxe/STzOQW3FqMYH3gLi4OK/bvyyOwDNKrN9vb7cVRgWSF+egWv
qLLK+c8Y7/xNH6XG14bBBdncyKg73WFD4SWthL3zx/whX3/XZsGYnv1TvOfKw2R8
UVVq96gam6sEN+GbvYiqARqm5m6QScr88TmXF3fKF+qGrHQ6Xtr3fb1hqsuu1yhr
xChacX4zIZy0TrNHpB/UjdyajrV+gHhJeCRtMe8T/W9nY5Y5jeav8NL8/PFdb2Ja
EWCTnuE6N/jg92qEDuwFbSFEme+qHLP8Gf18s1F2zgzz2VLiv7F+PqtodBTT9/Zf
5ad40MsYU0doHs0B369AwK+M8iG/tB0YjLSp87192ScoYCm62Sz6wlX8LkoylGJB
o3vKxvf8TRXhPnz2rOyz27GNGb3wvBj2+xaiZ+Ueoid+6pICPXCo6w/2Jvu9vz+R
DpbspKPrOHpohmMiCz2XeMxOMs4fslMSVwyaS3SNbdETRvA2NM33XO1u4SwMZsrd
vHa5cXETkUUW4nCu9zcPjzRiN7ZkusIqWVk587TnL3iDzgQAmsAJslRoKTjoHyAy
puBO6JCFDOwOyEjE1ksF
=4lr5
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
