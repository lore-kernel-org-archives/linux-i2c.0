From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: meson: update doc description to fix build warnings
Date: Fri, 26 Jan 2018 18:34:08 +0100
Message-ID: <20180126173408.oytldtdhh3mlezak@ninjato>
References: <20180124070514.183119-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r2g4org7hkx2zpwv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35587 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeAZReK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 12:34:10 -0500
Content-Disposition: inline
In-Reply-To: <20180124070514.183119-1-yixun.lan@amlogic.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-i2c@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--r2g4org7hkx2zpwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 03:05:14PM +0800, Yixun Lan wrote:
> Add description for 'data' parameter and drop unused 'irq' memeber.
>=20
> Here is the warnings:
> drivers/i2c/busses/i2c-meson.c:103: warning: No description found for
> parameter 'data'
> drivers/i2c/busses/i2c-meson.c:103: warning: Excess struct member 'irq'
> description in 'meson_i2c'
>=20
> Suggested-by: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Applied to for-next, thanks!


--r2g4org7hkx2zpwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlprZowACgkQFA3kzBSg
KbZTvw//dGBrbqtIIG+p5rXjXo3c7fTnLki1ot6LV6QcSRlr6ljqExyebKH3BD89
Pn028A6PFuuMMTUSaI738rmuAuKw7QJhiiYJvuz15Fh/I+9xFNvlK0ziPo1VWVZ0
YVudPP/LRW4VLwVN7WpsPMvqjfHyA/4Z1TTLnZ5f6Ybc8AJX75toaKGXmYAgZuo3
hcZNaR0kFY5PWHWeXiBugvTYrD/102EqwXPShxV/zsw7m47Xk3sz9Hs7IWlrbBuA
aKgtJqimgwIaUS+JtjjpwMkyIXnUNTGxKGURznmNdc0tUke7+HPqMox921dAfHwu
yEJ/Q7uAsW9qKbnp7gj/hwr88po08cs+DKUC1LiTdTa86GzdvbnOkacbd+FVwDQw
d3GLA9gt8VfcEC4y/jSGoC2SbJinbW+TlVUES340Qzbesx/tFLcsWtZVT6dI+M0F
JeifkYohE/q4qEcdn+taCeITydpP6pqEC2zofHZaOM0yQ10jlfBXK8wbk2Ajs3tN
ZDZcm6v0S50QbfID18OIK3FBDBDV3PPpF9cQGo0nBTogFXlpk9Y5sVC8Erm1kl9V
B43y/2VFvnaZ111VbNhq1Jpq5rOTGZvqFQlxS6JhE1FVl1k0c8fLyqlfGQGVSVPZ
wFSGiJmbI3bAldT28meQaQDG9d/JjPSJ7OjnR8dP8AEgThxul3g=
=9FTr
-----END PGP SIGNATURE-----

--r2g4org7hkx2zpwv--
