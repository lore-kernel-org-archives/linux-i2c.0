From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [rtc-linux] i2c/rtc init dependency problem
Date: Thu, 24 Sep 2009 17:19:53 +0200
Message-ID: <20090924151953.GD3154@pengutronix.de>
References: <152584230909240758h674ffe3cw4d5e6baef5efc9b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <152584230909240758h674ffe3cw4d5e6baef5efc9b8-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Alexander Bigga <ab-g5CePrrZ5ROELgA04lAiVw@public.gmane.org>, Paul Gortmaker <p_gortmaker-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Does this patch work for you? I can't test but made a similar one recently.=
=2E.

=3D=3D=3D snip

Subject: [PATCH] i2c-iop3xx: make bus available early

As I2C is used by PMICs also, make the busses available early via
subsys_initcall().

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---

 drivers/i2c/busses/i2c-iop3xx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3x=
x.c
index a75c75e..922fa3f 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -535,6 +535,7 @@ i2c_iop3xx_init (void)
 {
 	return platform_driver_register(&iop3xx_i2c_driver);
 }
+subsys_initcall(i2c_iop3xx_init);
=20
 static void __exit=20
 i2c_iop3xx_exit (void)
@@ -542,9 +543,7 @@ i2c_iop3xx_exit (void)
 	platform_driver_unregister(&iop3xx_i2c_driver);
 	return;
 }
-
-module_init (i2c_iop3xx_init);
-module_exit (i2c_iop3xx_exit);
+module_exit(i2c_iop3xx_exit);
=20
 MODULE_AUTHOR("D-TACQ Solutions Ltd <www.d-tacq.com>");
 MODULE_DESCRIPTION("IOP3xx iic algorithm and driver");
--=20
1.6.3.3


--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq7jhkACgkQD27XaX1/VRt0FQCfbqojwELWI12lk+iqggSQ2h9B
GN8An0nmSUPywMXL+olXBW3NfZvh1+gX
=0thh
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
