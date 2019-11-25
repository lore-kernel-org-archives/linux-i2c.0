From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: Fix Kconfig indentation
Date: Mon, 25 Nov 2019 17:14:37 +0100
Message-ID: <20191125161437.GG2412@kunai>
References: <1574306363-29424-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1574306363-29424-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 04:19:23AM +0100, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20

Applied to for-next, thanks!


--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl3b/ekACgkQFA3kzBSg
Kbb6Dw/+Ks+oW66Ewx9sGutW77moMaAFtueUpDSg6a/d/RUMFhP8/Nrija1GMVsa
mVNbLWaTUrr89OGj2m3yDkSX25TaE986bT31dvZ7nn+5BQjys3TzIB8Am08Z+Fv1
ZKX5dvS/MB+cFwIvEZK4TPNgza3+OxynjHrZBNTGQXCFG9qfpAs+nlU0Dfb4kDB2
t9l4S/Pf2ajOp+NPAB/96PPmzZfgIbTfojl3wGZz7XPAE3R5bfrwfhpLtoV4IVN9
0MFQkUlkMDApfec9tp5aa7YhNpNCsgLq9o+ZVQ4TEu5nogdHFD3Zkm1NVejSsXc6
P/Aamelb/Xjb3F0JLR7i1oZkNEmaVijtZIe4TSHCziNDAx5+ygwgXCbHZoEui096
sSaB6jNGIHdMAblxJE9sHRwifiD/xhfzuELMC5i93Xfw1UrNo0Izi3wb6MhUAQ6/
ZKxsrGN3Vpe3ITaTJsyCR8oGgKUcJj0K7gT6iIoEjGMcZr2T4H9cARI3wgsLbxgv
hZL5Wzcxnr0uA94X1daw6FvxTqj2jHow3nRuRsaNGisefnR99+k53EE0EUvAPVlk
wLCd6v5iZCzF00y8WnAxVKX2+9LfrKsccNvsTaH4y2jkM+LbWoP4cjgrzSHeDfMf
D1nbmAaQ8ajjF3+dMiH/sSWlXzwEDOSlQOIvpENSv2hZKufIpQY=
=20eQ
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
