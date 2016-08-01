From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c: slave support framework improvements
Date: Mon, 1 Aug 2016 12:46:05 +0200
Message-ID: <20160801104605.GA1689@katana>
References: <20160725094117.GB3376@katana>
 <1391831469440835@web19h.yandex.ru>
 <499754e2-f60a-5170-21f3-d756f768dd0d@axentia.se>
 <168841469551868@web14h.yandex.ru>
 <20160728074157.GA2693@katana>
 <9bf9e528-de4a-df4d-fed4-ee1afbfb609a@axentia.se>
 <20160728083914.GC2693@katana>
 <c72d3c73-30e4-1ee0-f763-99027e35051f@axentia.se>
 <20160728091514.GA17499@katana>
 <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:56915 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbcHALdD (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Aug 2016 07:33:03 -0400
Content-Disposition: inline
In-Reply-To: <abd15f46-48d3-f8cc-c2bc-3cb861c2ca3c@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Kachalov Anton <mouse@mayc.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I don't see where the conflict is prevented even if everything is
> registered properly with in-kernel drivers, and it looks trivial to
> prevent.

You can prevent it, if and only if, all devices on the bus have a kernel
driver attached. This is a kind of "corner case" to me. According to my
experience, this scenario does not happen too often. And for sure not
often enough so I could rate it as "the kernel can reliably protect you
=66rom this address conflict". I'd rather be honest here and say: "the
kernel can't protect you from this setup, you have to design your I2C
bus carefully". Which is especially true in multi-master setups.

With that in mind, nothing is lost giving i2c slaves a seperate address
space. We gain loopback operation and (bug) reports are also easier to
understand because one can easily see from logs if somebody is operating
an i2c client driver or an i2c slave backend.

Makes sense?


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXnyhtAAoJEBQN5MwUoCm2BB0P/3bq0abz8ZYutNJo87ZTabvg
mJt5S/9BeH6GlB40LiHcjAoO7xl2SQGNebo+mfxgDGRdhUURPsvNvJ+XUS8g4iPn
LyZF6l9UsgqLjKwdRYRnOCW8L9O+qn1+Nv2Kae9jJk6eFGPtj/NIhaor6SXMe9gl
QEfR++cuduc3ksfquLPL0Whab0jqhofcSZQZBgThlo2wqCN9Zx3MFgMhi/JGZ3F2
m/Br8hvfmRVpagW+n844zCVVRTySf/9BM8HdKD3FTZ/CYOJWAofxnSBdFG2hRaao
F9IKa24nKfYq1IosGx7K4QpE34RKQMIOcRQVTGYoUUECsyl9F+MYX5eAzxFYPV5w
PeTOrVZtjwCw6wbOrM1O8icjxCeCImM4Ykh2UTqmmvYI5me0MFxM/kKM5TxuXkJG
XZ4+SgrM+Pu141toSAQ1/JDx65tt1/3WNvlxG/GICUbUHlN0DQdLOHF2C5VjSfiX
8VC6QMkbiHlv+lLE5S4V11xhqAaZlGbu8Yyu59+bJdX94BmLKlq07x5zk4flfM4J
1NZxzlvXDji59iKzj1mCRWR2tndAE2ejwJhsOf32gnbbCJASJDO3e6J+dQlRIatq
hP91vZmogK/cPYDNEGg5DtP0MXZWNBA3WISwJh+j5/L7ylGfibWs78ZTvKfUE+qf
dBCFmdahipGRIh/RhgDL
=Honu
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
