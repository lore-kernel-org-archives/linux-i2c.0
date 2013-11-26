From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: i2c-diolan-u2c: different usb endpoints for
 DLN-2-U2C
Date: Tue, 26 Nov 2013 13:51:40 +0100
Message-ID: <20131126125140.GF7427@katana>
References: <1385305043-23626-1-git-send-email-mvogt1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385305043-23626-1-git-send-email-mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2013 at 03:57:23PM +0100, Martin Vogt wrote:
> The previous diolan adapter uses other out/in endpoints than
> the current DLN-2-U2C in compatibility mode.
> They changed from 0x2/0x84 to 0x3/0x83.
> This patch gets the endpoints from the usb interface, instead
> of hardcode them in the driver.
>=20
> This was tested on a current DLN-2-U2C board.
>=20
> Signed-off-by: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-current, thanks!


--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlJlbAAoJEBQN5MwUoCm2kHcQAIDcdI3aiAr4bVDSYmli0TCL
R+RDA0eINSxvhq+cQhg4pu1u7sSIlP76nBNyQLQfPoU3mkRqtIvKoZVlh43Sp6fS
jU4/K23pW247t2uVQEVe20vOCkIdlBbliCHUf0JZ4waLalL3WMqDLcyta7UHxzLy
E/uLMoBOACOtzhNVZlNKTIIf1afhDBMuc1OBg5LBmH4mKelHYoFYsYuiIs721w3a
QZHH1XqmMuzd6d3FRmO8JcZ45+6pA2+4Mk5DF8dkUakM85J4nN+ftb4+hwRqNvdU
JPqXuI/PnLPfPCjXsAgp9YnUuKucYqepf5xNnMzqhPYQ6qbNg/9RD87WFa9cyLkA
R67lRJP19brus/Df4DWMRH7Ymt1cn7xyy6UGICWUvwe/h/aKY1F3JZLIvfd50RwB
w2JO27FXelqbrof/fQnoNRHeGSDccBlqEbBuWdFkNhS3eH1BNmsfrdd5nU0nDitz
QKIFP+m8nEnbrzysNBTs+vmZUwq5A1iXsJOVfMWp15TD3ldQZo2egeVDm49Zns/R
13YVocav/Z0OZprM/Ycmq7q+HUjhsKFaWb7RTjtmfYMwYLOWzETlEmaaGK69VIRm
iyqdf5J7flhN0oMEMvv9p/di2r4JemxE2LmL6zdFsphlgcLToEiQGtk8RbholGLx
3qEFNrNdcuurqiV67pS3
=HLir
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
