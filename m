From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] MAINTAINERS: i2c-imx: take over maintainership
Date: Wed, 14 Aug 2019 12:02:25 +0200
Message-ID: <20190814100224.GE1511@ninjato>
References: <20190812050817.23279-1-o.rempel@pengutronix.de>
 <20190812064811.427cy7ahim54odkk@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6882891228784259974=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190812064811.427cy7ahim54odkk@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Oleksij Rempel <o.rempel@pengutronix.de>, linux-i2c@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Chris Healy <cphealy@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============6882891228784259974==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Even without this patch the generic "ARM/FREESCALE IMX / MXC ARM
> ARCHITECTURE" entry matches the i2c-imx driver.

It matches, but it didn't work well, I am afraid. Quite some IMX patches
in patchwork waiting for attention:

http://patchwork.ozlabs.org/project/linux-i2c/list/?series=&submitter=&state=&q=imx&archive=&delegate=


--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1T3CwACgkQFA3kzBSg
KbajTQ//VgglyM7CZxyc+Ld+REfPtwJNbH4MOU3yt3/ZblEZli85uYDYMuJvdPvA
8ujNPD7em/qfmwlnrhzNOCeNmdwGXFcs+T9e8qKwqZIazJ/2xZ11Ub9KeR5gixk+
+udm0DqRtnx5q019zanKGsuXsNDIjyOCKOkcU0v+dA4qZVw7cEv7OECGvMg6Z0gM
UyW9Qp0l39DsKJqRdwT/ei7K+tQl6slFi1kpMvZsiIEX+GIUK4nCHdjnc86uAIoZ
82ZlrciTgBMmMAqydTFOdGkp6NV3+2iiSZ/58Kqj2THHGVo2VxR2eMUrLyNn2Z1O
GPid13ndoVd6DOuevS6Bn/E1OovR6hIeZ3PetslltKmW/XKRbWwXsyayQxyH1Tqb
Jsey2AN8YXmNPKNyTUnYTKg6zkvvvtfCvrtKMIlAvEIEEQd1KShBPpEbPUqlLUv8
6XnmQsjuuiDytZAETbdOs3edV/hZJebz9/WH60qJlXmAzFLdnLgcn7Mv2zlZh6jn
wkLE3CEa+JG4hcYgzMsL68I1ccwXM8yVuzKOrEVuFILNjgA47yJFYqwb5f7eLk3G
wHuIN15QyeJ5LWslyr1LsSP7ekGq18qYKTvf8/qNx0nFF5w088AlKunLVoAqJwlI
TwoMZhdY0qfi3SGXmUQEt3oz8i9d1pW0nK/maZqmXS/I6Vp6UKw=
=m4xx
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--


--===============6882891228784259974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6882891228784259974==--
