From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-imx: Use the preferred form for passing a size
 of a struct
Date: Fri, 7 Nov 2014 18:41:55 +0100
Message-ID: <20141107174155.GB3656@katana>
References: <1415328275-13228-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415328275-13228-1-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2014 at 12:44:34AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>=20
> According to Documentation/CodingStyle - Chapter 14:
>=20
> "The preferred form for passing a size of a struct is the following:
>=20
> 	p =3D kmalloc(sizeof(*p), ...);
>=20
> The alternative form where struct name is spelled out hurts readability a=
nd
> introduces an opportunity for a bug when the pointer variable type is cha=
nged
> but the corresponding sizeof that is passed to a memory allocator is not."
>    =20
> So do it as recommeded.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Squashed the two and applied to for-next, thanks!


--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQRjAAoJEBQN5MwUoCm2dbsQAJYUoIaV532mjp7X3/d/M9LD
WTJwR0Wlg1xsqbURS8Uwc6eRcZHwM9x8j4T0/ApwAegLLAcq5p2seiHvIrawYOCt
/ZLZnrgiV2bIR5f2fm3+Dv2Tsr4PHRfupsz28TzdbKWLbNjsqB7cJPfH73Q/lBvI
XDHV2YZ0XDJRCOqs60HOD7oxpI+ZGYGDdoE6S2owqK340vlX0bZwGV29+rsgGssy
hlkYTU/sJU4F8I40RTG7ub1koQPdX0xs7QtAnBecApgWN5+cJJ7oQ3SbNlcHuM3x
0PnS2bvYBxhkQYuQzb8JUb4gXgf/mRaMtoixTlmqxq7avaNzZkqybzvplz+sp3ki
NJ6nlXt+6urDVEOQo/lxlM9NHRm7T8GrKVGlkVXiJTHJsx9qZoVU8kpuCe7ZG6Ek
10fx96c6k1spCqhf7xrIoBHGJC0CHRBEEz2TPF1tw5V7DMW5st/NcSSlmg1UUsNa
fIhBaF7bzY7UeAPwpjTf1kfBrM3GIuFRnJQqQrBkEPp9xmjUKXoMOYvlplU5sfxd
AWuUw5Y3o2+XNgL6vBySUL/Fvgq9LsZ+b+sJr/AiLRDjVAa/uvb3ZFE2AXDgak1X
itwPfoikPBzb3+5Kb07MIdDo54wdA/gJB5u2mCEx4BUFnD/XnMsy83p+4V+B9z+1
X7gX03t1J7uPdhfhQffu
=LMxY
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
