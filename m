From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: move trivial devices out of i2c subdir
Date: Tue, 7 Feb 2017 12:08:47 +0100
Message-ID: <20170207110847.iwikyplurumqi6qq@ninjato>
References: <20170126225544.5431-1-wsa@the-dreams.de>
 <20170126225544.5431-3-wsa@the-dreams.de>
 <20170201135045.yass267eakmlpyru@rob-hp-laptop>
 <20170201183539.GB2557@tetsubishi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tmqntnaublfzx4ua"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170201183539.GB2557@tetsubishi>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--tmqntnaublfzx4ua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 07:35:40PM +0100, Wolfram Sang wrote:
>=20
> > >  .../bindings/{i2c/trivial-devices.txt =3D> i2c-trivial-devices.txt} =
        | 0
> > >  1 file changed, 0 insertions(+), 0 deletions(-)
> > >  rename Documentation/devicetree/bindings/{i2c/trivial-devices.txt =
=3D> i2c-trivial-devices.txt} (100%)
> >=20
> > Just keep the same name. We can use it for SPI too at least.
>=20
> OK, will resend with your requested changes.

Thinking about it some more:

Shall I resend now or won't it be easier if I resend at the end of the
next merge window to reduce merge conflicts?


--tmqntnaublfzx4ua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliZqr8ACgkQFA3kzBSg
KbbvlA/+MFRQfiSsj5kIlfEdvGG2d0GCmompox0hao3oog83E6e7MJEoNoHfJjHu
t3nvDkyOSgWMudTagOgP2wR7Baof8OPk3xAqEaiNgAsvhV44nX5Kyc3FyTno04vz
K3LhzpyPA65PqAxeNAXBoxyxE9sdVFqd9Uj+pUaVTbMFRG2yTXdPOmVEyp+1dbt4
I7Rnquq2h0PnWk+ZveT1n+WIilnoCqT3YhpoqVpwzM8VNBNaDomWKPvsh3NClGCm
sOGoxM5gsbieUmEZByDXhqtt2vP7vdOV7SZTgQ+LvcWMinFvuPvDjYdnrV46nzSX
H77Szyt/biYooCz+zlyvI6GrltCcWFsnVILeSn8r5cSNs9uBdDvuOEzZ36W1wH+B
wPA8uvIfpPIw4TpEd24e/+ENcNoCb6nglkH3O2sha3thk+AHxRuPEyZlaEkQNZ9O
1k66yJV2WHh5xvJVnOFawP4DwBYBzI52s2qZ+SZ2zH1jj3QgYsTnZ87UVqMPqryf
iICEtjpHO45nLO3rfyIxIt75uKlaN7M3PxXjAL2V4IPhnCRB0dRU7g67qI8vVUVe
vDTWZTIvYBKUOjjsdM2wgkCYR6v6a0O3bhJhMADOMYwVuPk5t4Z3mUQE4XRrxrJ9
f7Uyavlo0O2655PijOmRISNIjHrmlGjhCiFkkRbQCSErg1DNuDw=
=FPVS
-----END PGP SIGNATURE-----

--tmqntnaublfzx4ua--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
