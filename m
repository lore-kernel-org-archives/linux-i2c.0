From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 07/12] i2c: rk3x: account for const type of
 of_device_id.data
Date: Thu, 18 Jan 2018 00:12:18 +0100
Message-ID: <20180117231218.e3xa5vq4mg6b6kta@ninjato>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ejd5npummacfocw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Heiko Stuebner <heiko@sntech.de>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--6ejd5npummacfocw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2018 at 02:28:03PM +0100, Julia Lawall wrote:
> This driver creates a number of const structures that it stores in
> the data field of an of_device_id array.
>=20
> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
>=20
> Furthermore, adding const to the declaration of the location that
> receives a const value from such a field ensures that the compiler
> will continue to check that the value is not modified.  The
> const-discarding cast on the extraction from the data field is thus
> no longer needed.
>=20
> Done using Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20

Applied to for-next, thanks!


--6ejd5npummacfocw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpf2FIACgkQFA3kzBSg
Kbbrdg//fpNwPY4hQ/GMvSiT+5PFjFzqtCxWALuyooPc2jsun9TL3RF8SE341817
jTZCDeEjn5HUJ0uWyl4vtso/Y7A8CYYTWVyT3nPYYNwFbz9Ct5OlcHWl0B2we3/J
VowannkdPOUx2sif0KNzcDMTXTy/+21vW7T7VCN1O74xWd6TW2B4LCkShAThGaJk
Yjsfu4OYvsC+R0B7Is3pM4pYOd+37scpV+x2ql6njxDjKHkaXID09tASaouh13cS
Tv+zhrtYLqpow7Z6hCBc/Djs+tIc/gHxOnJhM+Vp3B33op3UAs+qQOKS+wm7Kgrl
jtHnvJGLy7OJmZ5srDJGcBjutxmx+EWwUlhDQJUr4yy0D62n9yZCsx6IDtwa2iY4
AWlHft2so220vY+29w0pR6lXr2PxnDBNirOq5iY2gftrWAT6j+B5MtjYg5PoyxQV
xYTOcO5XWev3/TaEs7BbGFAndmrPeB/AuNAWp6xdLRCLgjmqOSfQzWIWH4CFWOl+
G0LfD3L7BI8aU9wLhiAY/vL/bP+8Y5/oY0UnGpYB71/SDAwo4bx0GW34KdU5f30e
bh8C9rfw4Ok85kCsVMbrqWTztbkg0uLXaU2TCadDoDVM+J2+xbBi2CVlITEPhBy+
kPNpgpVDXD3+wGKrirzw/qLHXI77911dIGv5oTh3dZE6z7Pitjo=
=peoi
-----END PGP SIGNATURE-----

--6ejd5npummacfocw--
