From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3] i2c: pnx: Use devm_*() functions
Date: Thu, 16 Jan 2014 11:13:07 +0100
Message-ID: <20140116101307.GB2617@katana>
References: <002201cf10be$4ac30840$e04918c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002201cf10be$4ac30840$e04918c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 09:19:30AM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied to for-next, thanks!


--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS17CzAAoJEBQN5MwUoCm2qyoP/RybosxOPYceql3WQXIRa6CI
vdQEVU5OQjJqFBWsn3geh1ErzYYLjE0GlBuyqVyxSudOTs1fUlH+Fc3/b7QChKV8
Wjis/dWQ2ioLEW79QMMg7glLNcTkPpOzYgbB3/3pv5rrAg8gX+OgdkSKjqXQjwd2
l2R0MLE8LWZoUwp+M1VZ2/O/cBtCGgfW3y7Q4AGCaw19HpoXm3nGEXoOQfS+oirU
xwxOhMLYQkBedLx137qh1PNqAkLXtK8lOORd82/oX3jXDqvmuyEoKOB6pCQfMOb1
1QH2QnBkQuiIyzm1jX6nyb2rMJJn3MIMneQQ2KRBBLot4AK66lNc65aFlquRuLBZ
uLbh9g5EU/W31lh+HKU+AsLSxp293RZlZCLaW2MMoqMIm82Ap3pX44RcR5py33TY
3rpadFmRzxiqD12Y4IqX9jk28N/3MMwnPR2EE42M/TtK7QXFXN01LYbZwZ1Ql+ye
gxT9Hq9aJIoanU8hf7R7Se+Wk1/aO9pbbArYyLQ/kMX7p1ppaAEcp1v4Kqkduzfe
YGVi6lnc7DTZvXVm+m88jLoH6H81bUhePaN4wOvk1YwjZdjcQ/JG12PkCAACTLY0
7NsiAQgy4qx2XMnNUxLeqfdzjakcnsK2yj2ejnZGyEoUhXvYUODaa1OzBeWyutuY
BzfK/oryXYsFZlHjhaE8
=Gego
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
