From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: simtec: Convert to use devm_* APIs
Date: Tue, 12 Apr 2016 23:48:31 +0200
Message-ID: <20160412214831.GI1526@katana>
References: <1460449814.28557.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lqaZmxkhekPBfBzr"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59725 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755377AbcDLVsg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 12 Apr 2016 17:48:36 -0400
Content-Disposition: inline
In-Reply-To: <1460449814.28557.0.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Ben Dooks <ben@simtec.co.uk>, linux-i2c@vger.kernel.org


--lqaZmxkhekPBfBzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2016 at 04:30:14PM +0800, Axel Lin wrote:
> Use devm_* APIs to simplify the code a bit.
>=20
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks! Were you able to test it on hardware?


--lqaZmxkhekPBfBzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXDW0vAAoJEBQN5MwUoCm2JUYQAJN2SzkSwaXTqlS3C3xxZLcg
klduStn6QC/D4No4QfKz3p3H3ueAPOx43iTA6aa8lTgELMbuhd3UOMjcNuh6G2NB
exTw4X4Ocn3CxIZdAQc5F6VzGFRXl3+NSVf0fe3xPOfza6Kbd/7dA0G+Ed5AQZMl
wv+DIj1AyuuuOHborbXSRtZ/bPseEXmDDp8WBMtqEpo4CRqAIztr5xN0P5xk/pRR
lfoxqYussHFa8zkfa3H4uO+nETQSCAqljvWWKWiOXkw6afex2ON9Mr0aP68biOP3
rMz8YfXuCTKuAAV6KgQ1EDUU+mTdks/ae300J0SNxe7CMnaHrka40uALKtIGx2GX
P5gpTR+8mvq6DAyemUBNvN/6aQlUwBEkFTW3hHlgDMoHjWVbgz34YwKd2BILu/jP
W1eWjciUbfiF8sRR3xinN8H0I4MMuYmyUFmfvzMbfspgwXQcV0IHr96eccyfCdwX
vJqWYu8llCyksk1mBaPvpfrCIDILMnhf5SyNRAaMcJcRpTkt9fYzrVTQo+ewSQc8
2oPxVgxTht72fiQWiGNr5wbdjT9PZkMLEzZ3vU5IjXSZzdBf23PMLAU4ODYAImAv
Er3xPAjgX6QIZh4QEtxR+HVSUUQBuvJZAok8RujboBgEzpsWOp5YW9QSNAxsPoSC
08TWh03nDf+Rd/GIKJUg
=CRsD
-----END PGP SIGNATURE-----

--lqaZmxkhekPBfBzr--
