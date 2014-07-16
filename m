From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: s6000: remove duplicate driver
Date: Wed, 16 Jul 2014 19:11:52 +0200
Message-ID: <20140716171152.GA2759@katana>
References: <1404915923-3278-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404915923-3278-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 04:25:23PM +0200, Wolfram Sang wrote:
> It turned out that the s6000 simply has a designware IP core and should
> use the designated driver for it which is way more maintained and
> feature complete. There are currently no users in tree, and not even a
> toolchain for s6000 seems to be available. So, simply remove this
> duplicate. If someone needs assistance in converting to the designware
> driver, the i2c list will be there to help.
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTxrJYAAoJEBQN5MwUoCm2JGgP/iwjKIS5AUxEY65iZx2+/2hM
2jtMDQwWnNV98aF8YEhOeyLvrC0umo2bTt2+G7udq3/q14ex9c31EDY2eT8GGefh
gJHRkdIE/L42uKNT7+k/6MgWmI/S6i1Xk50Nw2HBVR4lTzAMBcn/Z24QtiJyzMhd
UWfoLGpLiq90HhQO+BKG0lhBumYdv6lDUiKX5gfqdSqzJEpWQfu9oFjGmuNg7qg7
9tOmDc8VJLbGhH5OIPTMeQHWMfurzxgbwmLC9LquhcG958cWIMuUKqjGwfNaxEvj
L30dheDl9vK1gGRk9rgpyJutNZXAPrQiaN9130ppXNUibk9Um/Ew6fwHn1ITXbse
PvDOd91Uikc2FHlt+JzkEISNWEI0StBzvooQ79uSWC4PPiWbR2dxj5mT/bTqgLLK
TVruTm1a7x7mqH9/tCpnifyAAE76jWHTUFEbK/Kx1QzLOpfS5jx77eslfcqQJD0i
ols12tYq48wrubGxJ01Qd7gD/hVamYNYYyJbYxLsEc/TcolLE07wECTe0GABxNU7
8t7E/uMMbNNaUa1D8y06f3vQbEz5JpcpffHteAVO847/WeLyWFpUp5eSHqbg7KyA
MetoGpq04JSdd67opwxIXsRunCQBCV3B/0mVqyimhuUj86yYFc6MltGx6Kdfmxib
SmqAliHgOWmsOIJVFJ+K
=MyaR
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
