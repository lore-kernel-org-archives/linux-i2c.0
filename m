From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mux: mlxcpld: fix i2c mux selection caching
Date: Sun, 18 Dec 2016 08:56:23 +0100
Message-ID: <20161218075622.GA4165@katana>
References: <1482006551-23108-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47512 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbcLRH4Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Dec 2016 02:56:25 -0500
Content-Disposition: inline
In-Reply-To: <1482006551-23108-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@mellanox.com>, Michael Shych <michaelsh@mellanox.com>, linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 17, 2016 at 09:29:11PM +0100, Peter Rosin wrote:
> smbus functions return -ve on error, 0 on success.  However,
> __i2c_transfer() have a different return signature - -ve on error, or
> number of buffers transferred (which may be zero or greater.)
>=20
> The upshot of this is that the sense of the text is reversed when using
> the mux on a bus supporting the master_xfer method: we cache the value
> and never retry if we fail to transfer any buffers, but if we succeed,
> we clear the cached value
>=20
> Fix this by making mlxcpld_mux_reg_write() return a -ve error code for
> all failure cases, just as was done in commit 7f638c1cb0a1 ("i2c: mux:
> pca954x: fix i2c mux selection caching")
>=20
> This also aligns the implementations of these two muxes in this area.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Fixed the commit message and applied to for-current, thanks!


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVkEmAAoJEBQN5MwUoCm2kHAP/icPoNGM9on4KJNjxofzxYef
H8wZrCIb3BQlx+wObbgXLq84BJ4nx0QomLr3dXMnCkJGwP1zhwEWNEEZFo6eZDi4
vsofYPCg/xy+JD2Kh20eK8/0bgaW7+IXw3almsWCF/Ph/UEGhBLv+8i6ltHnbMX0
5+xSmB9IEtbErqbrfTudxd1ozYasolNyLPHexIGTbUjNuOMOCLT16GLhIrgheAPO
CrGRZDWnYaYjuV3Ij73nJff5B+rt8rfT+h6Z711tZB00AY5l//CJj39vn/L4p38b
h0mm0gnmfdiHf9GUSqbne61n/orDSf28S1ePIm6PE27y5IGwQd7khp1SMr7hItjH
laTIS6nbz/vrXIWaigN9q+lNiEMXA4HY7hEMdBwJ9LH8LxR3IQVvUrLSmhQBYUsl
uZBaWt322dXe+v26gvaFGnsbU4d7R2nni7E86eIx6WmtWaT0PxqoCcwCRWFiFgb5
ABMLQSAi66Cyl6SYt0ZgoY+ChuTVFgiX+t82A1KknzXbE5LeZU8QFwU/7oYoFYjr
6ZM/gzQSB69DMud3orxhx5m8YGJnynZZ4td68kg0627JnFMSQTawujdYg4VzGiHT
h4xOooi9AGqZRt8aUoEMztDzbAz7JeBI+3HzlK8PiyVYkimSUPg+OB4NSNMdw67y
eYgS7Hs3/c9PJ4zOatuh
=lxNy
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
