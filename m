From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: mediatek: add i2c resume support
Date: Fri, 23 Oct 2015 21:59:11 +0200
Message-ID: <20151023195911.GB1520@katana>
References: <1444123376-24448-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36658 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750923AbbJWT7R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 15:59:17 -0400
Content-Disposition: inline
In-Reply-To: <1444123376-24448-1-git-send-email-eddie.huang@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eddie Huang <eddie.huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Xudong Chen <xudong.chen@mediatek.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 06, 2015 at 05:22:56PM +0800, Eddie Huang wrote:
> From: Liguo Zhang <liguo.zhang@mediatek.com>
>=20
> mt65xx i2c controller initial setting will be cleared after system suspen=
d,
> so we should init mt65xx i2c controller again when system resume.
>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>

Applied to for-next, thanks!


--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKpGPAAoJEBQN5MwUoCm2CZcP/RwcU/qN3bTtgUwn3j8ThkYE
fDaKp5Bch+qEe+L3BQSTUr0+n0R5F/bsVTEcidxS+rKEEipcqbRt4WbVImdIBjCZ
ZgszU61iY0MG8T3VQ5hkUBo4XbCzP0bl17PU7s1PpkOJHXzZ6Uzlg1WMPLw/Qp8l
cSHgdho8qjXzwsrx+rN8tzpp+p2b6NgmL4IdvVMedLeLwwbk1GDSI4iTGQxT3jj9
7jq0eQAmAO5FIRDvrY8rUkNm9Ci9nzf1AZsoC/sc00mThReLpxPIs2KFjoTCfDHp
PqI11sk2Uo+m9PkDfe+Epiq22IeTG4HMhk5wk9m72xAOJ2oOb4FZ8i53H3rSkEO0
eNgM6i6hCSqfMhAdoEqD0CeH4L6wtF1BoQObiJbxGC57godZ+Qt+pk8HDxm9UcEi
iYlg25zqUUmzVY/yJTxAqC5moI9hjjf4bi7QS7lOAZk9Cxwy4TADDT2NEi+F1IZ/
oLW/lkBP0KSwjYBvOevg4vng+TBhxJF2OmBNJsGJu9850+l8xU2ajxDPyi6i/7y0
RQzrz2BSdpinqMBNHg6p5RqFNYxb6mfuO0UwVENXxxMH5BMgluryqaUQMvvKvS1J
Px3G5oyHtElq48H3hTq/bJNiz5W9SFZzRCXPUKz6HyVjyvmeS3PO6AMuM3nzO0JQ
3PELMadl5wFS3PWujVll
=Dwnu
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
