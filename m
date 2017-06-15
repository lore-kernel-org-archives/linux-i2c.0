From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: rcar: use correct length when unmapping DMA
Date: Thu, 15 Jun 2017 15:52:50 +0200
Message-ID: <20170615135250.jhfbxhcefp66aprp@ninjato>
References: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="efnxbmcngpeyhwj5"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
List-Id: linux-i2c@vger.kernel.org


--efnxbmcngpeyhwj5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 28, 2017 at 09:52:17AM +0200, Wolfram Sang wrote:
> Because we need to transfer some bytes with PIO, the msg length is not
> the length of the DMA buffer. Use the correct value which we used when
> doing the mapping.
>=20
> Fixes: 73e8b0528346e8 ("i2c: rcar: add DMA support")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--efnxbmcngpeyhwj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllCkS4ACgkQFA3kzBSg
KbZ/1w/9GCDXusf4wnjBEkQEqmdizG2fRNuI1kLnSySMWQBY28ChTDAgx99WS+Uu
nHg6g0uDBl9Jg+B8XLzf/t8pi2KKoPBcUX+IYrKDN5JuVPfMhP4ab5GBs33Df9Wp
UlGmRfXwrUznkB08CYQOvBjSx4A0/UxO0aPlfKBl1Pg1OuwjcQaoyUOE1OKW6zhp
XHNv+JCYGQJnjE8NDsO/UFlNEove31mzLj1PorkDcY5+2MF3JEKwSfc8q29BTvd6
fHv/UlUqDB3QnMlBz/9PETFeu9CP5/o44BeTyJWF/Ns9L700TEzmlnjsnQWUw/OT
IRxr1VZ7QELDTt6jGGlIbJW496VY4TICTmvSV5E3L5lvaz6+DT1D/1x1339EUgLO
1qJU7/SXWAwyiNeaqhP4V2y0PnnItcvJ9YFSlB5KxDP9xRU9IvzqiONhMD091vOA
9V80Na8TTMT4jv+l5MhGVY3JxxQm1bz5ccqbPkIfiim51MaaKLqYgkeMpLEr2l4Y
wb9pi13t9Imn/z5bjL6PkUTxQq4JCbHboALmEZmd2JCi9SoxDBepP5ded63nM+j2
SddvvXcbsE8Y9lJfgJDqezvW0aXjwcdr80HRgo0paMuIciIg4yXiTy//fEefy0/F
nELfkagWlNlqWsfZ8aHdTSnp+SgeyLjrOJkKF94LXQhE6nZxXv4=
=89JM
-----END PGP SIGNATURE-----

--efnxbmcngpeyhwj5--
