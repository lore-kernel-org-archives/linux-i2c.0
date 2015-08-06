From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFT 1/2] i2c: rcar: add support for r8a7795 (R-Car H3)
Date: Thu, 6 Aug 2015 02:38:49 +0200
Message-ID: <20150806003849.GA1743@katana>
References: <1438780706-20945-1-git-send-email-wsa@the-dreams.de>
 <1438780706-20945-2-git-send-email-wsa@the-dreams.de>
 <4463128.lAKghhIhbx@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4463128.lAKghhIhbx@avalon>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 03:34:05AM +0300, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Wednesday 05 August 2015 15:18:25 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> >=20
> > Enable the I2C core for this SoC. I add a new type because this version
> > has new features (e.g. DMA) which will be added somewhen later.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
=2E..
> > @@ -625,6 +627,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] =
=3D {
> >  	{ .compatible =3D "renesas,i2c-r8a7792", .data =3D (void *)I2C_RCAR_G=
EN2 },
> >  	{ .compatible =3D "renesas,i2c-r8a7793", .data =3D (void *)I2C_RCAR_G=
EN2 },
> >  	{ .compatible =3D "renesas,i2c-r8a7794", .data =3D (void *)I2C_RCAR_G=
EN2 },
> > +	{ .compatible =3D "renesas,i2c-r8a7795", .data =3D (void *)I2C_RCAR_G=
EN3 },
>=20
> If H3 is compatible with Gen2, can't you just use I2C_RCAR_GEN2 here ? Yo=
u can=20
> always add I2C_RCAR_GEN3 later if you find differences.

Is the patch description not clear enough?


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVwqyZAAoJEBQN5MwUoCm2qGgP/RTlsW8jYLh59f+UPey0VFqv
IdWX3EYZ2fQ3B0f7PVCvyqIIc+ZbvgTWafbnbidW8xUTNJVOZJ47ywsG49a1dEXQ
6MkQRjIEpmyJ/ZXPIOCs3ocQEQYyZybbMJ0xV80uvuLMuOW7qx39nofFr0WvXF2y
fGewycX+FrgjRRszzS96lFw3ZQeyMSBfWeJxvMG9Ndk1arbb/IuHhSfwpJrG1XMh
4zVKwmt+t7E6FxSyEeSHEarr9ksK1ybqqvGk0uljGEzbQlbALFw6IVXzy2GfFoDu
A5DjWRWINc9M/d8i5vYf8Zci+iXwfjWF1s50HKy2KOS09zgKB7fziP6BQ7OJKaxM
rQ43HXhssCsRdfbB9o90HM8Lm8Kb6n783zsKB6ZHpAYOkiOn8+zmW5g6SnuMRKlS
I4vHoIvL8+baZqYdGw0unVyceYP1fnfsb46nWqNJsd6laE6ppTxF6dd5lMyXfq4w
+n0e2y3qs0L/UCNXJT7sVvoo+LE3E3B1wiIQT03+18nWCvfPoWoxvbE+oR209h3F
RG2zhjlyrLb1hZbON4YECdxAReS/v/arTK1aTHXRotdpNCYR8mDMSrF4RUmlpupC
7rBnZAzE487Wt2y2O57DuzNWUiVO+zEihd05j2qFDVPfCaWWlt1aRhVYgxZG+JYC
b/oZw9tjQd8Flw8mbKLD
=t7Ar
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
