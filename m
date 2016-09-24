From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: axxia: disable clks in case of failure in probe
Date: Sat, 24 Sep 2016 11:30:17 +0200
Message-ID: <20160924093017.GI1434@katana>
References: <20160922175703.GE1861@katana>
 <1474622126-1996-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58946 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753763AbcIXJaY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 24 Sep 2016 05:30:24 -0400
Content-Disposition: inline
In-Reply-To: <1474622126-1996-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 11:15:26AM +0200, Alexey Khoroshilov wrote:
> axxia_i2c_probe() does not disable clock in case of failure
> in i2c_add_adapter(). Also it ignores returned value from
> clk_prepare_enable().
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied to for-next, thanks!

Please use "V2" in subject (git has a '-v<n>' parameter for that) and
provide a changelog below "---" next time. Also, try to add the driver
author or recently active people on that driver so we can have tests on
HW.


--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5kepAAoJEBQN5MwUoCm2MXcP/jvv6kGoGxXjwaq8cbDkqZ/U
lgXojmUw571c029XeIRveTl205uboIB0OditssfFgg/mvdj8IUlstEFt1vt3oCRJ
oxyuuk3mJGBqDylTn7I6OQL/Tga4NQV0jcLr9p5kUAIJoArUcqzcYLqX6CX1dwpb
GooA07U8BVHwaoQBsrwCV1ifMTbZS28ZNVUPCrnKdcBwWhKWw2lnIXww14hZF1tZ
6gwYV9X5rsXmY/23axuM1B9gvqOGWQMGgEzB4t34i0lGioL1ZD01pqVdGOFWGjxb
oxWkyNymo2OkpaEk+yqdfxKdEveqaY0uGKKDjV/kbnS0Rd+B9gbEFjLc+XNLX3oI
mbBPPZItX5YLUmO/P49BMJ6qNPhvqeQtDncKbp6U0DPRuD+4SpZSiLynWbKzyNMN
k/zhL35L05ZN0TXI1muicu1AGL0vomcOFL0+NXN9waPEaIeZywrf3U5ELy/i4HKc
78QS3aAWYnc1fpHNtBZs1BS7RYwpsDttecyGrM/3c2tV324ptx+tN8vHMSXH8TSP
ZWLMseWmEOlIuphayie/+07hU8ukq+1KrlHvCHsB7D63hnp8W0sfTNjUiUr71MZb
c2wMxvpm0V6DV2jsfurGPoC3yEArVCwtBFw7dLwetvUhoc8FFzQFFsVkBkNvy3qr
4UBEFcbBQVJQe239A5u8
=bYBO
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
