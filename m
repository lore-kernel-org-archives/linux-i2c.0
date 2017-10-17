From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: riic: remove fixed clock restriction
Date: Wed, 18 Oct 2017 00:03:06 +0200
Message-ID: <20171017220306.p4h3wbp5c3uaexh4@ninjato>
References: <20171016183253.2291-1-chris.brandt@renesas.com>
 <SG2PR06MB11652F2C132728B93232119C8A4C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="riace2bgkydzteqi"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB11652F2C132728B93232119C8A4C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org


--riace2bgkydzteqi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Actually, if you want to hold off on this patch, I'm almost done with a=
=20
> real fix which is to calculate any frequency based on current parent=20
> clock and rise/fall timings specified in the DT as you suggested.

Sounds awesome! So, I'll wait a little how the formula goes. We can
always fall back to this patch if all fails... Thanks!


--riace2bgkydzteqi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmfhoACgkQFA3kzBSg
KbYOYA/+L9uhdrzFLdkzV3PQqsBI2hKqjgWCvnPzOvi/0WXNvZ2AGV8MLS4Cv0Go
d2KWzUsOJooIyjC3YxaKIJQU4O9HYQgiMYbUPI7/s/VccWVkNDDliWjtc75rlMiP
FVtrf+ArK7JJ7zRtuZvozWUkmz2M5qIJ8g28FeAYRPgQDnUz64SU5AubAByYeBXI
0y6lbF5NKK/sMLaCLLT/Ulbhabte8CSpG/2eOH+nl/UR75VmBo6dBAeFeCr7T76H
1jJ8mB3cUHRtX3B8YoONMU1c3HSakSyR1cWPz/sHsxrk+btmKpBFOAMJIeTbJAtE
FyNxpEzp641dLzMM33ouEaLUAySuCiX2cAaoqc3ZwFkDdQgwjUIbKk8U7L5pKf4C
IHxPCKfzUlW4xOJzzptf9qPjkK1xn9iYv9+mkBWuIEZXf5mLdq5VR/3rn0ytBSAt
0bG0ZgJNA5b6xARXB3RtWfvUql9SOA69pQnL8/uelyyie0lQsJK+3ck1kRtJXT/F
UZSAb6Cp2uyg13b5xvhGCwcO+HmYeOYbiSonqMKyTNsqdgAuapQe2tKurzeEZXtI
OeH5SZNk4a4Yy3818UnsfyQiz6llBoz5onmnRWChbPGmSIPLdOOVrYadHJyYqEQW
B1mjUhjpbvVwIBVLA+Tp3QQZsY3DQUtTyppRjvm7KDVVNGaEZeQ=
=IP1J
-----END PGP SIGNATURE-----

--riace2bgkydzteqi--
