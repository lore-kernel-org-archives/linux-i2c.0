From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c : busses : emev2 : Handle return value of
 clk_prepare_enable
Date: Mon, 19 Jun 2017 19:01:44 +0200
Message-ID: <20170619170144.aecnztmhjkdjzrxe@ninjato>
References: <302ae3da44202f585419ca80770426f98768b410.1495634283.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qj5bb2nd5jxq74ox"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <302ae3da44202f585419ca80770426f98768b410.1495634283.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--qj5bb2nd5jxq74ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2017 at 07:31:06PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to for-next, thanks!


--qj5bb2nd5jxq74ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllIA3QACgkQFA3kzBSg
KbZ3DQ/+Nog8KNpuwbI4NBXyk2aXqq4XePpao2tujZ5TarI+ECmdKdDleAHyxKll
GrZ8TnvzZo2ITNKGCLZi4NxZaz4OLl34NZcE/NVs4G5jy0IunQroY0bz/ZNMcdJb
zLkYeOZp/88Bfla+LIsUs7jcFe+VLCqkx11alCqtQNenwGPR8GWCBg4fXOgW8XUi
753klxH1dsKPb2tMhHK3z+EnzcppsXwLoqEuvf9JWpR/nI5Z7bG6uzcON6CoBDwZ
cVT/FPBZQ0ca12Jbey3izdSx3yj4UY2pt/VgNqhWO8I9kM9b+xuuhlB5u5VD+KRF
jV/WxufBATQK/z6LmOSGUnXGumz6L3BCD1d/l0EpnhvrGVDzZiDtbQOwpCNjKnos
gzdDMqoEVbnpCdQHPmaSxVqKvYcwIGFpOcpjtejf4xz0qQTCFKZLKAqJtU3SnxBS
4kA5kZMTEhG0KocrOQygoNE5jbxApgd8rZCXJ/OAe7MVyOvdpT8DgLurcu4Hc/yr
L1RUX8xU+1lNFITtG3nks3IRHHns2HR7PWR8Y+Fh6LYh3McTsCloJCdlwlTy5Q/T
Qr4zFkaO0chBeJ8VuwWr5u0psnK3LAhgLq822XmR1Tg+GAs1fvSx4otlYvZF2rcT
xeciCGUBNDjN3RwXdYzsF1xsMYW80kdTUv5bC45o5UX8lRDSjk0=
=0Z12
-----END PGP SIGNATURE-----

--qj5bb2nd5jxq74ox--
