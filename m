From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] i2c: Provide a stub for i2c_detect_slave_mode()
Date: Sat, 8 Jul 2017 21:55:45 +0200
Message-ID: <20170708195545.az4vgxqptrtdjv54@ninjato>
References: <20170706172617.39817-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u7t2akpeeoktg7a2"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34975 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753058AbdGHTzs (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 8 Jul 2017 15:55:48 -0400
Content-Disposition: inline
In-Reply-To: <20170706172617.39817-1-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Luis.Oliveira@synopsys.com, linux-next <linux-next@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--u7t2akpeeoktg7a2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 08:26:17PM +0300, Andy Shevchenko wrote:
> Drivers would like to call i2c_detect_slave_mode() even if !I2C_SLAVE.
> Give them what they want to,
>=20
> Otherwise kernel will not compile:
> drivers/i2c/busses/i2c-designware-platdrv.c: In function =E2=80=98dw_i2c_=
plat_probe=E2=80=99:
> drivers/i2c/busses/i2c-designware-platdrv.c:331:6: error: implicit declar=
ation of function =E2=80=98i2c_detect_slave_mode=E2=80=99 [-Werror=3Dimplic=
it-function-declaration]
>   if (i2c_detect_slave_mode(&pdev->dev))
>       ^~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> Fixes: 6e38cf3b4421 ("i2c: designware: Let slave adapter support be optio=
nal")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'll apply it and push out. Buildbot found this issue as well and should
give me a success report...

Thanks!


--u7t2akpeeoktg7a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllhOL0ACgkQFA3kzBSg
KbYd9w//WWmKkrb0wrA3qxBqTEf5I+GXB3jIZE21wOnCM3sHzUnEA0LSGy0fB8Ed
+tcCCiLzaPC2dlaqtt0c31dmjlthNgLV0mVSLhy9iVIBydTVtzy8UdewRdcWFP7K
Dlc18l73gntFMhiDeDAgZjQzpFBdl6LV02BhNha9GZExKKhCSYeIR7fW90K1B6nh
qgUyrGbEHrlMw8yNXrsU6vok1mLfDWyGk4/hqPjpNfqsZVlVclaANSzNAWsnXqvq
p1vpA6rWfj3G/PCMboHmD8h15I5iRW3yFR+cr/9X8ck8CO/d6jo9vr8AbGvG1Qtk
3KxZmFJR2gZv4Z34+VGlGQVwQHHBZm8X625rAx+nTIDHj9W9teTKcw5xPWtNL0QL
hJKk/1RMB33mNNxkLiZEHh8Y1984caDGaO70Wqtbvk8esr178Dk76pAGd0BX/c4z
6mXBgrflY07AWAw088+afPuvokFahofr3TBwKB6W2WRx2/LBLFmCsfZJKsdamUmQ
krguzZn4bROMpHZmd1vpbEpEklqqjQ8vGyJ1HWrror1fqum7dqC5XcHJddFCWCtY
ITi+Nv2WMVr9mGZqwAA9ic7GCGt8j7XRwsqUzhuM772p3Kut1cQLTLyn7NeKP433
PXyzZv8U+wKlVvpGyiwM7OcNsDMkvfadVb6+tJt3X0+9lw+d5ck=
=dGqX
-----END PGP SIGNATURE-----

--u7t2akpeeoktg7a2--
