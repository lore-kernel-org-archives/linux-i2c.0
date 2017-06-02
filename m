From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 2/2] i2c: sh_mobile: drop needless check for of_node
Date: Fri, 2 Jun 2017 22:53:43 +0200
Message-ID: <20170602205343.etemzgwevmzyoibr@ninjato>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com>
 <20170518211140.12023-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="axcmssuclizmni2y"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170518211140.12023-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--axcmssuclizmni2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 11:11:40PM +0200, Wolfram Sang wrote:
> After removal of platform_data support, we can simplify OF handling.
> of_match_device() evaluates to NULL if !CONFIG_OF or if there is no node
> pointer for that device, so we can remove the check for the node ptr.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Fixed the assignment as mentioned by Geert (thanks!) and applied to
for-next, thanks!


--axcmssuclizmni2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkx0FcACgkQFA3kzBSg
Kbanfg/8Cg+AgqS+7eNtNJev3LFA1GeeoHXuTTVdNSPcChzKhZR26Tu6mo2lRCAH
e+9u5CXhhUw/SJmU010QwrsW5+KI20C3f4USLYdkHiBeGv6Q02m+Y7vAlXWK8g9e
+6puHVe80yMH4WXrNvR5TwQJQtqMUzUQSZVnAOdQZ1dn110J4E8BiIuSG5ogtYXX
HQ44P6AkzQxFYfYPLMoJlHWB4aNXIKs2ECJyG1cBAJH7flwBIIjVpw8F6DSBqHS4
4DoQsO8lgt0+nuektDSk73ukSjqhyODtmliXaeqNTZQsJMB/mgDFGmjyPi3D7o6m
b5PisIlf5kksct+8cHiMWkMaju/NgmR2HqvbrK7FArKUJZL0bSR6YR9v43tZp81f
odm49mOePNMeld3K3u4jK/QPDVF0kcnEHfD4+rjU5RaPILg9wznwXon6V05zolt9
TYPIO3pPhsMOhXiFFkB/sJUM6KKHKX5KrgWJ78Yznzw8qHCaVImDJg7aaZtjmeXf
Pq0YByAOjftMiSNpjErPGftjKn4kXQ/DcIjQBH5pp1eTtVQF1K1ABRRlrkdqnZnS
/zZ/s2lLOo/qEq5dkQ9J+rR3o3UMEyeVtHdm7UbkGbyH6wnPocYX1lEYXRWLoO0+
s7QE554CpXDmkXPzKUsV9F06RLiqddXv/B4Z6Cx9S59yEfcfywQ=
=axfk
-----END PGP SIGNATURE-----

--axcmssuclizmni2y--
