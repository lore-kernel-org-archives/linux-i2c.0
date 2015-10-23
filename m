From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-imx: Use -ENXIO as error in the NACK case
Date: Fri, 23 Oct 2015 22:27:53 +0200
Message-ID: <20151023202753.GH1520@katana>
References: <1445532080-30724-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36792 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765AbbJWU15 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 23 Oct 2015 16:27:57 -0400
Content-Disposition: inline
In-Reply-To: <1445532080-30724-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-i2c@vger.kernel.org


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2015 at 02:41:20PM -0200, Fabio Estevam wrote:
> According to Documentation/i2c/fault-codes the response to a bus NACK
> should be -ENXIO, so fix the error code.
>=20
> This change is similar to commit 6ff4b1051632 ("i2c: rcar: fix NACK
> error code").
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to for-next, thanks!


--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKphJAAoJEBQN5MwUoCm2WL0P/jVUAbYtApwLS9Wmhy1EHzms
UErBZ1Szw46KxHxpZ+mgOZMj6L6tuhln7lNCN2TPEFK37v9bwJmnhKZonb9smxiC
W4qg5tDed04WTZRFB33pVkMNicUedg6akezfkRB4y1ADyxdtaff3jV9PlmGZAhtG
g0wutSbJTnYtnYULf/HO6izXuEmf/wjlK42jZ5XtXbujykc4O3y72GvP/4KO2rAK
wgUKR9l4qLOX6Vtqsv28EsLPlhL4v4rd1dQdRb0dDJoXntiLgjlJoQsf8x54Enrk
xcgErICRENo9LZ6snTsBq6R2/0FLLEoOkDGbKgIBZxSBwD2geQrt3BUw+ABRGRcC
KhJ8H9sY3XUQznvELcjhegi5jQvRtZaFRVVWt0stGs2vpgR+7L5L03ZhrCc1xs9Z
OekqRdYDs/M7UzKfpBlLulp4uSmLPo93iuTlAx13MM4Tx+UYNhaYmpGoJU8iK8jt
nHAqSv/5swvh7cZ6r8dje2aAlBrHPWKoRLwgNBB9EbrOUQPd+5Lc/2TJqDPONb42
r62Hp69fPh7ozPjt8MdcXQjE9ru8WyE5ktBZyhDtH+zdUKz6bjiBbBwangKfSsVL
FA2ZLjDJvF0xLgMt1cbRbBjw3RgEtJ1tdJcgwbGfbOMLqpU5YcVRdWiRGtKHSGgH
qKgalIAldPiRDuw9qOOl
=RlZT
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
