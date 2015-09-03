From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-mux-reg: fix compilation warnings
Date: Thu, 3 Sep 2015 11:57:18 +0200
Message-ID: <20150903095718.GB720@katana>
References: <1441181021-4937-1-git-send-email-mike.rapoport@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441181021-4937-1-git-send-email-mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2015 at 11:03:41AM +0300, Mike Rapoport wrote:
> With CONFIG_OF=3Dn, the following warnings occur when compiling
> drivers/i2c/muxes/i2c-mux-reg.c:
>=20
>   CC      drivers/i2c/muxes/i2c-mux-reg.o
> drivers/i2c/muxes/i2c-mux-reg.c:170:13: warning: =E2=80=98struct gpiomux=
=E2=80=99 declared inside parameter list [enabled by default]
>       struct platform_device *pdev)
>              ^
> drivers/i2c/muxes/i2c-mux-reg.c:170:13: warning: its scope
> is only this definition or declaration, which is probably not what you wa=
nt [enabled by default]
> drivers/i2c/muxes/i2c-mux-reg.c: In function =E2=80=98i2c_mux_reg_probe=
=E2=80=99:
> drivers/i2c/muxes/i2c-mux-reg.c:201:3: warning: passing argument 1 of =E2=
=80=98i2c_mux_reg_probe_dt=E2=80=99 from incompatible pointer type [enabled=
 by default]
>    ret =3D i2c_mux_reg_probe_dt(mux, pdev);
>    ^
>=20
> Signed-off-by: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6Bl+AAoJEBQN5MwUoCm24MkP/0u5xiGYvW+Ljo/uUH1zu76X
tykCstlRgKcrUU6JClMhYFb0SCRV2BAknqh73kCDOnVtXjnB2cBWk9QxV+kHueVc
mdM3Yprm3Y1bC+aD+aTAzJL2no6VgTXT66g9wI126bzQqMcNjvTWDotFND8tSmdY
06A9DUMiAPRevNCTwpr9xXIbxIZUYRADZ6EhxS6Pj31ApXYQkJSr3I+mop/ppsQd
K3e9QLLn3Od/OkqWGe4Hv+ZP/BY061/dLZyRekk6dFzloqPdqG+tk43NOabpOPH0
jbwqLvL0h1jqm0pzFLg6Hx0VVDs8oZEdNoTOMN3w7LsvEvAwGrBmrXbhnDwnO4M3
PUQEaTnJEZEVj0c67JlAbIOekC6qWzDv//Yua89hlkytzptGZHDmXs5G3XWK1UPC
t10Ni1Gt5vHPkfOW2dmSh8pU/VhOp2be36MsYktdL3cVd2xMzN7dbLWjRMjEdoqq
gtFyHN6NKtOJXa48UB6+UDGHf2T4zMgFONfQ7T4lokVtgFEhgxJGKCLHfwtfMnZ4
XFNvgH/FX4eW4tHuEXLtcwiLDLaUX+nlyhE5o3RTAdYIKl6YqqayJUoZnINI4rjS
nGWeviyQVfp5StPTtWkCiRqYuUmqM0hVMxk97Fst3hsgmx89+kXm5Jh1ZWcshOaI
v9CmZqXnG540Lxo0rAjh
=HCkG
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
