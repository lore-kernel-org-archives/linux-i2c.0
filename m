From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-stm32f7: fix documentation typo
Date: Thu, 17 May 2018 15:59:33 +0200
Message-ID: <20180517135933.mdh4femklasitbfy@ninjato>
References: <1526026825-2996-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3d6xzsp2p26embe4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526026825-2996-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Colin Ian King <colin.king@canonical.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--3d6xzsp2p26embe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 10:20:25AM +0200, Pierre-Yves MORDRET wrote:
> Some data structure members were either misspelled or missing.
>=20
> Fixes: aeb068c572 ("i2c: i2c-stm32f7: add driver")
> Fixes: 380b8a85e7 ("i2c: i2c-stm32f7: Add initial SMBus protocols support=
")
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Applied to for-next, thanks!


--3d6xzsp2p26embe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr9isUACgkQFA3kzBSg
KbbvMw/yA3QFPLmAoCRd5H4fuGFXhpgp9SLdgkF5Z46BGFpbJZaLbJbPnr55bcwS
+BazcdJfu1+oLmhOA4r1NPdj/5thrZyP9YNknq00hE2ur3FkIYogcS53ic/UtcKp
Y/jZwmcF08VmxUdJ81pfWJ31OdeOemvNu2betVkHgsTh4rFrBEEMFmPzkYajezYl
aNT3ROqBuTXbI/+zebwMzXFsfLtPA/K/RYTg9Y5uMLD08vei+yzoKQciuURy/QvQ
FNRYwypLHmEG8mbAZ/Z2OdScwlNSDaE8B2TdNfhGmto/DUwRwmRerm5qtEZrL3gt
VauMCUc3l9FZlYrkTbd7SauA1W4V4t9FdSTrujrFqxyTYaF13Uuma6xJMnZP//0o
WiSWvpwO1NzNhvAB4C93814c1go54FVF1s17dKk+cAUAmJmhrZHmlVFQm+Ytsg2G
EUjQyvXFqb5SeOW+aSFXNNc7RB2t6CvSGutqQigtJzogSfOEYRyybStEiw87WwnE
PZzishcGge88eKRjCJYxFJFinxZPic9ThY8hElmiJOvwOOXILpR4YqTj7wmg6Mxh
GT/BUguW2oHbpBoxTSwKbRzG4jPXZiWyFpWvpF75RTpbWy1kB3XITTPpkgHg6RCy
2yKof02o+wv6EL1x3i2r6uCRLVVzzXjMaz6mGJwJG+DHK50qoA==
=xu61
-----END PGP SIGNATURE-----

--3d6xzsp2p26embe4--
