From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: robotfuzz-osif: drop pointless test
Date: Thu, 24 May 2018 22:17:17 +0200
Message-ID: <20180524201717.tyzatx7nvxwanb3f@ninjato>
References: <20180509194658.29106-1-peda@axentia.se>
 <20180509194658.29106-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xy43rgn7r2esjloo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509194658.29106-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--xy43rgn7r2esjloo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 09:46:58PM +0200, Peter Rosin wrote:
> In the for-loop test, ret will be either 0 or 1. So, the
> comparison is pointless. Drop it, and drop the initializer
> which is then also pointless.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!

Reading that function, it also seems this driver wrongly sends a STOP
after every message of a transfer. And not just at the end of the
transfer :(


--xy43rgn7r2esjloo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsHHcwACgkQFA3kzBSg
KbYQmw/+Naxi46bOC8GOCTpySPnLdHU09wTJYgBwHl07aZ3K9h9QZ3KkNiVHFRJs
91S+yDKWgNLe3JiSsjt6Hxn/+RRkSR0i5U07hZHKh4wiWOp6+hVYQw3E2LPPc2FQ
fH58+Ka2vqunPlvpGnVoAH6V9lvEy8TTIYMMsnzXackdDRAkiqHZ8CKUXJCWLcFY
1bXx126JYkFneY5aGicIyzulyNmfGo+NH3hv/1lMc5q7eJIOZiy7t6sSrgKNZP8F
fnYduB4TsTtqVp0dZaBiOO0OWpcHs482qgNJ3Zj7Yx4qMyL+mxn61PdxYx4junjG
W0pKbDzCHScQnBpA+SKfwneBrwAuZ54Q/2950jsjcGTOGkJbCpbpfBtJGoPdrPqy
ZZYnv8C3bxToSn0a1X3mncZouWWrY7bD+uDeAzreAad0zlXQF7tzxZbBNuWBQHTw
AuEXM49i8Dw/aGZkWvKv1yNWH2jShsH9Meu2NcozPYKQIqmGPQBbNz+NoU00LzxB
ujFG26OfR/ThstZFI/DX92m1GKGw1KwhOLM/cHF075hdFzRlXMi+7ttJMwQDk71N
ynX6eg4pDI5ozKqvnnpOhDlBhkeTWw+zkLlvrIXt7LcnsQiu9u6warYXh9cUDTjW
p5mvSQnSk6V74Ai95g0ZKiDEkouPgibJZAW5kfmzYd4WLnPTNK0=
=InVS
-----END PGP SIGNATURE-----

--xy43rgn7r2esjloo--
