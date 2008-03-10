From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Remove trailing spaces from i2c/busses/Kconfig
Date: Mon, 10 Mar 2008 12:38:51 +0100
Message-ID: <20080310113851.GA20100@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1105253304164566251=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: I2C Mailing List <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============1105253304164566251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Subject: remove trailing whitespaces in i2c/busses/Kconfig
=46rom: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

Index: linux-playground/drivers/i2c/busses/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-playground.orig/drivers/i2c/busses/Kconfig	2008-03-10 12:11:24.00=
0000000 +0100
+++ linux-playground/drivers/i2c/busses/Kconfig	2008-03-10 12:12:11.0000000=
00 +0100
@@ -135,7 +135,7 @@
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-elektor.
=20
 config I2C_GPIO
@@ -190,7 +190,7 @@
 	select I2C_ALGOBIT
 	help
 	  If you say yes to this option, support will be included for the Intel
-	  810/815 family of mainboard I2C interfaces.  Specifically, the=20
+	  810/815 family of mainboard I2C interfaces.  Specifically, the
 	  following versions of the chipset are supported:
 	    i810AA
 	    i810AB
@@ -248,8 +248,8 @@
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on IBM_OCP
 	help
-	  Say Y here if you want to use IIC peripheral found on=20
-	  embedded IBM PPC 4xx based systems.=20
+	  Say Y here if you want to use IIC peripheral found on
+	  embedded IBM PPC 4xx based systems.
=20
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ibm_iic.
@@ -269,7 +269,7 @@
 	depends on ARCH_IXP2000
 	select I2C_ALGOBIT
 	help
-	  Say Y here if you have an Intel IXP2000 (2400, 2800, 2850) based=20
+	  Say Y here if you have an Intel IXP2000 (2400, 2800, 2850) based
 	  system and are using GPIO lines for an I2C bus.
=20
 	  This support is also available as a module. If so, the module
@@ -354,7 +354,7 @@
 	  on the parport driver.  This is meant for embedded systems. Don't say
 	  Y here if you intend to say Y or M there.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-parport.
=20
 config I2C_PARPORT_LIGHT
@@ -372,12 +372,12 @@
 	  the clean but heavy parport handling is not an option.  The
 	  drawback is a reduced portability and the impossibility to
 	  daisy-chain other parallel port devices.
-	 =20
+
 	  Don't say Y here if you said Y or M to i2c-parport.  Saying M to
 	  both is possible but both modules should not be loaded at the same
 	  time.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-parport-light.
=20
 config I2C_PASEMI
@@ -401,7 +401,7 @@
=20
 	  This driver is deprecated in favor of the savagefb driver.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-prosavage.
=20
 config I2C_S3C2410
@@ -417,7 +417,7 @@
 	depends on PCI
 	select I2C_ALGOBIT
 	help
-	  If you say yes to this option, support will be included for the=20
+	  If you say yes to this option, support will be included for the
 	  S3 Savage 4 I2C interface.
=20
 	  This driver is deprecated in favor of the savagefb driver.
@@ -452,7 +452,7 @@
=20
 	  If you don't know what to do here, say N.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called scx200_i2c.
=20
 	  This driver is deprecated and will be dropped soon. Use i2c-gpio
@@ -483,14 +483,14 @@
=20
 	  If you don't know what to do here, say N.
=20
-	  This support is also available as a module.  If so, the module=20
+	  This support is also available as a module.  If so, the module
 	  will be called scx200_acb.
=20
 config I2C_SIS5595
 	tristate "SiS 5595"
 	depends on PCI
 	help
-	  If you say yes to this option, support will be included for the=20
+	  If you say yes to this option, support will be included for the
 	  SiS5595 SMBus (a subset of I2C) interface.
=20
 	  This driver can also be built as a module.  If so, the module
@@ -500,7 +500,7 @@
 	tristate "SiS 630/730"
 	depends on PCI
 	help
-	  If you say yes to this option, support will be included for the=20
+	  If you say yes to this option, support will be included for the
 	  SiS630 and SiS730 SMBus (a subset of I2C) interface.
=20
 	  This driver can also be built as a module.  If so, the module
@@ -634,7 +634,7 @@
 	help
 	  This driver supports ISA boards using the Philips PCA9564
 	  parallel bus to I2C bus controller.
-	 =20
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pca-isa.
=20
--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1R3LD27XaX1/VRsRAsH6AJ9oE27p+qWV7iP1YFqwkGgmjWh/4QCaApW9
aF+DsS3rE45HIbFQYNVgKEI=
=vSB6
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


--===============1105253304164566251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1105253304164566251==--
