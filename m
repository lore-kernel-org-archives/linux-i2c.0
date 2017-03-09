From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: m65xx: drop superfluous quirk structure
Date: Thu, 9 Mar 2017 15:41:13 +0100
Message-ID: <20170309144113.h7zf6adw7lxhmspk@ninjato>
References: <20170227192505.6449-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qrpjwrvy7qiwnmyy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46324 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754747AbdCIOtG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 9 Mar 2017 09:49:06 -0500
Content-Disposition: inline
In-Reply-To: <20170227192505.6449-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Eddie Huang <eddie.huang@mediatek.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Kurtz <djkurtz@chromium.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>


--qrpjwrvy7qiwnmyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 08:25:05PM +0100, Wolfram Sang wrote:
> All length fields in Linux I2C are u16, so a HW length limitation of 16
> bit lengths is not a limitation. Remove the quirk structure.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-current, thanks!


--qrpjwrvy7qiwnmyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAljBaYkACgkQFA3kzBSg
KbYr2Q/+Khr81J6WNUDZj8SKSH7VqIVxMcCFLjXY956u74TY4bBuEIlbtsBZwMEZ
1+IjBiHFUM2Vldm9ncUqn816wZ9kO5Un6dn5aDzEcRjH//XxRKaLq6aSkqjqWlXD
PQexi5tu9PizD+LnerAdjt/ADWXglmfe9X1m+1NfetzHGREqFoiWPvGjCGq4kwZv
YhyugYXpgb4osQgJKhwt/rPASOWblJtnw5NdCEXk8KSmr5voRMzy9mPxRrgggWfd
IwkfvMIROK+XDcETYD5KPCpuXRp0nynLUnGuSnBlYBp4vJLdjwDYGAKSkzE06g/D
EZMm8WSpseg8yyzFKVl+SURPEypQOtxORYX2r1zA/SYUJnw4NMre8+gZGU6gzaPE
1+WfKwsUFfKjeZN3D/qE2zrBJXrO9TYgpZIFzoHaCpF4cB/j526tx0hm6dtD+xRG
9Ud92XnqvBKz7Au4knmvwFGwdPz3Rcdeh/l1opOHmYdOKVSWVHsP/ZWAbwSo23zf
pyk500MJtMSMcGh+Pjdtsy1nMjpXe/nMyWMMoPfLLytAUecxVNyAIcDXe164OKxp
z4DkG0r4FJXaSoLt/049BPh4IWUaQ7tzo/ha6+axcNdClQ25AhwZWzVi29YE28VV
/+T493ebHYMlaY4EIy+JfKd0aU9qOnPGWHVFf3ykA6lb0yFJQvw=
=VBng
-----END PGP SIGNATURE-----

--qrpjwrvy7qiwnmyy--
