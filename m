From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] Bugfixes for i2c-cpm.c
Date: Thu, 19 Jun 2008 15:09:22 +0200
Message-ID: <20080619130922.GF3860@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1970621783843099549=="
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
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============1970621783843099549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Bugfixes to the i2c-cpm driver

- enable correct interrupts (I2CER_TXE instead of I2CER_BUSY)
- replace forgotten iic with i2c
- fix typo (devided)
- prefix debug-output on init with 0x and add frequency

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-cpm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: drivers/i2c/busses/i2c-cpm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/i2c/busses/i2c-cpm.c.orig
+++ drivers/i2c/busses/i2c-cpm.c
@@ -241,7 +241,7 @@
 		eieio();
 		setbits16(&tbdf->cbd_sc, BD_SC_READY);
 	} else {
-		dev_dbg(&adap->dev, "cpm_iic_write(abyte=3D0x%x)\n", addr);
+		dev_dbg(&adap->dev, "cpm_i2c_write(abyte=3D0x%x)\n", addr);
=20
 		memcpy(tb+1, pmsg->buf, pmsg->len);
=20
@@ -350,7 +350,7 @@
 	}
 	/* Start transfer now */
 	/* Enable RX/TX/Error interupts */
-	out_8(&i2c_reg->i2cmr, I2CER_BUSY | I2CER_TXB | I2CER_RXB);
+	out_8(&i2c_reg->i2cmr, I2CER_TXE | I2CER_TXB | I2CER_RXB);
 	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
 	/* Chip bug, set enable here */
 	setbits8(&i2c_reg->i2mod, I2MOD_EN);	/* Enable */
@@ -553,8 +553,8 @@
=20
 	cpm_reset_i2c_params(cpm);
=20
-	dev_dbg(&cpm->ofdev->dev, "i2c_ram %p, i2c_addr 0x%04x\n",
-		cpm->i2c_ram, cpm->i2c_addr);
+	dev_dbg(&cpm->ofdev->dev, "i2c_ram 0x%p, i2c_addr 0x%04x, freq %d\n",
+		cpm->i2c_ram, cpm->i2c_addr, cpm->freq);
 	dev_dbg(&cpm->ofdev->dev, "tbase 0x%04x, rbase 0x%04x\n",
 		(u8 __iomem *)cpm->tbase - DPRAM_BASE,
 		(u8 __iomem *)cpm->rbase - DPRAM_BASE);
@@ -568,7 +568,7 @@
=20
 	/*
 	 * PDIV is set to 00 in i2mod, so brgclk/32 is used as input to the
-	 * i2c baud rate generator. This is devided by 2 x (DIV + 3) to get
+	 * i2c baud rate generator. This is divided by 2 x (DIV + 3) to get
 	 * the actual i2c bus frequency.
 	 */
 	brg =3D get_brgfreq() / (32 * 2 * cpm->freq) - 3;

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIWlqCD27XaX1/VRsRAtVlAKCckfiJDR+wB3eI2fRDbTWnkQ7WIwCbBdCp
3mBbSVcvfE7so4+APJZCyjM=
=KCib
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--


--===============1970621783843099549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============1970621783843099549==--
