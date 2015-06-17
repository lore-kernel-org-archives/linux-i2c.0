From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] i2c: mux: pca954x: Use __i2c_transfer because of
 quirks
Date: Wed, 17 Jun 2015 14:36:48 +0200
Message-ID: <20150617123648.GC13393@katana>
References: <557AD35C.2070406@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <557AD35C.2070406-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?=C5=81ukasz?= Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2015 at 02:41:00PM +0200, Alexander Sverdlin wrote:
> pca9541 and pca954x are calling master_xfer() of the parent adapter direc=
tly
> thus bypassing the quirks checks of the adapter. Use __i2c_transfer() ins=
tead.
>=20
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Tested-by: =C5=81ukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Applied to for-next with stable added, thanks!


--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgWngAAoJEBQN5MwUoCm21T8P/3h4mxayMz70hMMsKwueHRMy
f9AN8GYytKz8EowZc7e8XWvh0DUj7ksAKe28bUP3Dw25FtNk5Q98qOMWofZX6TmQ
av0o8Ix1kClHL4GZe5EgUgh276Qzl/uifdKjQ0ZuRoLhSZu+iwr2TRu2m6W6KNA1
QCOSakTpE7Dm4yDYWokIHZbsEstLk0qoCI0kC88sTS8P/qo/KRZwhMxvLq9iTDXy
TuN+6dN1lLyDHglPg5AjsqV7//4i2PzmmglbJj+KQrXCFsVKH/M+lW1CUqBw29dQ
TuOMouIv+8oBRHONjMtOO7Ubq1kiR0vHO94JpfP5cCPHOOtKDpZ/3ZfeCI0/azjH
J/MIu74nrPwMKz1kiOAPY5X5mkayMkCvE4lelRY9vrCmXMW1tS3/AxtS3+2Soj6J
8SoeVc64WF03iBPmn+mtGT9IeezIfh0yTJwwPijhIB5A/rISvBmRts6tBQMEYWcp
BEs3LZAxcs35RzrDRIqUhVbfurr6IV9UJ7BGJxAQgvwZ4EnZVdl/0WIPTbn4jbdK
y0+VqKrPL6ENPwbNq6/bQSHCPEOFtUsxSkUAECqt9Vyt6zP04Mx7Q16t9RF2xvTv
wXjSwygh79o9ylZAEhTy/f+2GgEPxm/5GusDYlFjb7mVG1bP9bYuluaZ9kdTIXd+
054Stu9zJ5yvH19V9Ki5
=AMrG
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
