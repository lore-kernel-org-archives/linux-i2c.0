From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 1/2] i2c: rk3x: switch to i2c generic dt parsing
Date: Thu, 14 Apr 2016 20:39:23 +0200
Message-ID: <20160414183922.GA2338@katana>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-2-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43618 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755052AbcDNSje (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 14:39:34 -0400
Content-Disposition: inline
In-Reply-To: <1458147438-62387-2-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 17, 2016 at 12:57:17AM +0800, David Wu wrote:
> Switch to the new generic functions: i2c_parse_fw_timings().
>=20
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Yay, what a nice diffstat :) Applied to for-next, thanks!


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXD+PaAAoJEBQN5MwUoCm2aQ8P/ij2IxtQ4APPokpTuTj9sBlZ
zxr0dDqp1KE81y83Pr8eSEYe6wJzaB/RR6jJqxqXieZlb1wpGHuh/L1HpxpL0jj9
kLO6NkQt/Yl9CsDEYc6ITk1GVRmDFs0GLMWAjN6SHLbGBmoL802rwG9X5NsAyNqr
OuAJeXXkLo5R04XSXwnbmXLAQxEN91w1NmhP8LwqJwdLEcDqwTPTYp2k9t/IiESk
OB5UrBwA0I2M3T84A56KuzO2fxOQIojDSBEWFoffpKtRkO9+UK0wGuvlcfhG8L1W
Op2CjG5twa5jY6TqsccO8GuNR2mcTQc3Z0LH/r2YzkhyJzF22FrEsasLSb1M36AF
RyuLFSAdCDREXM872XxlToc+ZnjxrDeSg9L7EPgjH8OGy5rMZecvqSycir06CRbS
OqP21kEvoDB/Aok1mk73T1vyEzde3c9S9FKLLpEQRjGpT233riwblj0fTyY27Rgz
kFEHe+8sn3UF4D7ga8zb06Z7XiLaccGxxLdN9DAZRqd3XRS6Q7KFBY3AIt7N8/6b
/J+UqfMeDvLmfrmgvNlIj5c8vfQrEGl7iMP6F55085kiz4ItL+WBse9N/zdc1XGX
YXp9SqxB2IiKuvNhpNOendzB73Kqjd1jULltgEXkyES3kyQEbJayBD8pEHe3nc3S
CZ+lv1ky3cp9eKDosiMc
=OAWa
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
