From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/6] Cosmetics: hex to constants for SMBus commands
Date: Fri,  4 Jan 2013 14:13:33 +0100
Message-ID: <1357305215-17643-5-git-send-email-amaury.decreme@gmail.com>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch replaces hexadecimal values by constants for SMBus commands
and bit masks.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c |   45 ++++++++++++++++++++++++++-----=
-------
 1 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index e152d36..792bb79 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -81,6 +81,21 @@
 #define SMB_COUNT		0x07	/* byte count */
 #define SMB_BYTE		0x08	/* ~0x8F data byte field */
=20
+/* SMB_STS register */
+#define BYTE_DONE_STS		0x10	/* Byte Done Status / Block Array */
+#define SMBCOL_STS		0x04	/* Collision */
+#define SMBERR_STS		0x02	/* Device error */
+
+/* SMB_CNT register */
+#define MSTO_EN			0x40	/* Host Master Timeout Enable */
+#define SMBCLK_SEL		0x20	/* Host master clock selection */
+#define SMB_PROBE		0x02	/* Bus Probe/Slave busy */
+#define SMB_HOSTBUSY		0x01	/* Host Busy */
+
+/* SMBHOST_CNT register */
+#define SMB_KILL		0x20	/* Kill */
+#define SMB_START		0x10	/* Start */
+
 /* register count for request_region
  * As we don't use SMB_PCOUNT, 20 is ok for SiS630 and SiS964
  */
@@ -140,12 +155,14 @@ static int sis630_transaction_start(struct i2c_ad=
apter *adap, int size, u8 *oldc
         int temp;
=20
 	/* Make sure the SMBus host is ready to start transmitting. */
-	if ((temp =3D sis630_read(SMB_CNT) & 0x03) !=3D 0x00) {
-		dev_dbg(&adap->dev, "SMBus busy (%02x).Resetting...\n",temp);
+	temp =3D sis630_read(SMB_CNT);
+	if ((temp & (SMB_PROBE | SMB_HOSTBUSY)) !=3D 0x00) {
+		dev_dbg(&adap->dev, "SMBus busy (%02x). Resetting...\n", temp);
 		/* kill smbus transaction */
-		sis630_write(SMBHOST_CNT, 0x20);
+		sis630_write(SMBHOST_CNT, SMB_KILL);
=20
-		if ((temp =3D sis630_read(SMB_CNT) & 0x03) !=3D 0x00) {
+		temp =3D sis630_read(SMB_CNT);
+		if (temp & (SMB_PROBE | SMB_HOSTBUSY)) {
 			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
                 } else {
@@ -160,16 +177,16 @@ static int sis630_transaction_start(struct i2c_ad=
apter *adap, int size, u8 *oldc
=20
 	/* disable timeout interrupt , set Host Master Clock to 56KHz if requ=
ested */
 	if (high_clock)
-		sis630_write(SMB_CNT, 0x20);
+		sis630_write(SMB_CNT, SMBCLK_SEL);
 	else
-		sis630_write(SMB_CNT, (*oldclock & ~0x40));
+		sis630_write(SMB_CNT, (*oldclock & ~MSTO_EN));
=20
 	/* clear all sticky bits */
 	temp =3D sis630_read(SMB_STS);
 	sis630_write(SMB_STS, temp & 0x1e);
=20
 	/* start the transaction by setting bit 4 and size */
-	sis630_write(SMBHOST_CNT,0x10 | (size & 0x07));
+	sis630_write(SMBHOST_CNT, SMB_START | (size & 0x07));
=20
 	return 0;
 }
@@ -193,12 +210,12 @@ static int sis630_transaction_wait(struct i2c_ada=
pter *adap, int size)
 		result =3D -ETIMEDOUT;
 	}
=20
-	if (temp & 0x02) {
+	if (temp & SMBERR_STS) {
 		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 		result =3D -ENXIO;
 	}
=20
-	if (temp & 0x04) {
+	if (temp & SMBCOL_STS) {
 		dev_err(&adap->dev, "Bus collision!\n");
 		result =3D -EAGAIN;
 	}
@@ -217,8 +234,8 @@ static void sis630_transaction_end(struct i2c_adapt=
er *adap, u8 oldclock)
 	 * restore old Host Master Clock if high_clock is set
 	 * and oldclock was not 56KHz
 	 */
-	if (high_clock && !(oldclock & 0x20))
-		sis630_write(SMB_CNT,(sis630_read(SMB_CNT) & ~0x20));
+	if (high_clock && !(oldclock & SMBCLK_SEL))
+		sis630_write(SMB_CNT, sis630_read(SMB_CNT) & ~SMBCLK_SEL);
=20
 	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n", sis630_re=
ad(SMB_CNT));
 }
@@ -270,7 +287,7 @@ static int sis630_block_data(struct i2c_adapter *ad=
ap, union i2c_smbus_data *dat
 					   we must clear sticky bit.
 					   clear SMBARY_STS
 					*/
-					sis630_write(SMB_STS,0x10);
+					sis630_write(SMB_STS, BYTE_DONE_STS);
 				}
 				rc =3D sis630_transaction_wait(adap,
 						SIS630_BLOCK_DATA);
@@ -312,8 +329,8 @@ static int sis630_block_data(struct i2c_adapter *ad=
ap, union i2c_smbus_data *dat
 			dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",len,i);
=20
 			/* clear SMBARY_STS */
-			sis630_write(SMB_STS,0x10);
-		} while(len < data->block[0]);
+			sis630_write(SMB_STS, BYTE_DONE_STS);
+		} while (len < data->block[0]);
 	}
=20
 	sis630_transaction_end(adap, oldclock);
--=20
1.7.8.6
