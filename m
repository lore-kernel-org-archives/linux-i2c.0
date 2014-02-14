From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
Date: Fri, 14 Feb 2014 08:44:07 +0100
Message-ID: <20140214074407.GA2569@katana>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
 <20140213082630.GA3119@katana>
 <20140213225248.GB15350@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140213225248.GB15350@lukather>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > For non-a10, That should be at least
> >=20
> > 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-a10-i2c";
> >=20
> > or
> >=20
> > 	compatible =3D "allwinner,sun4i-a13-i2c", "allwinner,sun4i-i2c";
> >=20
> > depending on the outcome above.
> >=20
> > Or is my knowledge outdated already?
> >=20
>=20
> Since they are strictly compatible, we don't need to introduce any
> different compatible string here.

You never know all errata in advance. From what I know, one should
always use the specfic naming first, and then the generic fallback. So,
in case a distinction is needed later (think errata), then one doesn't
need to change the devicetrees.


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS/clHAAoJEBQN5MwUoCm21xkQAJEvbHtb3Mkklv4qLf+2QQvX
X5kXko4ZnmCAZQg0Fe7e1UR+pd23XVWa4PthyMbubN8gehP6W2N91WeEx+QMgsFT
ZzHdcklWU/klZgmFt2ebQ7qvRZ4XdGwzK+i1UMyD5LpR3A6fVxX6AHOBh88Mo4+I
0AzsvJss5asQZcs5sroiXYwLTQ7qRwmBlYhkvyng51AwKVDK+h+0++c4GTvpGWn/
A3vdsFVc4Tf7p5xmEhFQBfODanRBBQSifMwIJ7w8ra8EP/91qzc2oU8ImaToeswQ
YB6M1GfuMP3ICPt9/30NHIJoqmlx0RXlTBYhQrTxKqDZB1NVO/UgCGDl7FbS+UwT
DRXvOaHLK9GchJ4zCTqScrPw4rZD2OHQCB67NRl/t7ds2mNVuZz5zdeQ6fFHbxDt
jHpZy5/7zZKs47NspcRclqJuEFui7CuB82WvB0WaG0Wk2EupDr9mL3dNc9mYb+k3
ovYGFp0GC0gf+MAdN63liEagCp091RkJx6EjR4NEfNp9erosJYVZpXLcdp6icHuE
5mjMtr9TKK0OmfuyYky+ddnnfCIVx+eNa4ANCtf7nqdXKU+99gd80KoF6oggvE5V
iMoPIkpFn/y6Cmdqke1e+1u+sxf6QmSgsaybPK9fsAuKlj74hNInrB5gOLpfSmoV
jqjgShw63d/1yVsoBYT4
=oeWB
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
