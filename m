From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 5/6] Misc: display unsigned hex
Date: Fri,  4 Jan 2013 14:13:34 +0100
Message-ID: <1357305215-17643-6-git-send-email-amaury.decreme@gmail.com>
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

This patch corrects the display of unsigned hex values.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index 792bb79..4bc970d 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -152,18 +152,18 @@ static inline void sis630_write(u8 reg, u8 data)
=20
 static int sis630_transaction_start(struct i2c_adapter *adap, int size=
, u8 *oldclock)
 {
-        int temp;
+	u8 temp;
=20
 	/* Make sure the SMBus host is ready to start transmitting. */
 	temp =3D sis630_read(SMB_CNT);
 	if ((temp & (SMB_PROBE | SMB_HOSTBUSY)) !=3D 0x00) {
-		dev_dbg(&adap->dev, "SMBus busy (%02x). Resetting...\n", temp);
+		dev_dbg(&adap->dev, "SMBus busy (%02hx). Resetting...\n", temp);
 		/* kill smbus transaction */
 		sis630_write(SMBHOST_CNT, SMB_KILL);
=20
 		temp =3D sis630_read(SMB_CNT);
 		if (temp & (SMB_PROBE | SMB_HOSTBUSY)) {
-			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
+			dev_dbg(&adap->dev, "Failed! (%02hx)\n", temp);
 			return -EBUSY;
                 } else {
 			dev_dbg(&adap->dev, "Successful!\n");
@@ -173,7 +173,7 @@ static int sis630_transaction_start(struct i2c_adap=
ter *adap, int size, u8 *oldc
 	/* save old clock, so we can prevent machine for hung */
 	*oldclock =3D sis630_read(SMB_CNT);
=20
-	dev_dbg(&adap->dev, "saved clock 0x%02x\n", *oldclock);
+	dev_dbg(&adap->dev, "saved clock 0x%02hx\n", *oldclock);
=20
 	/* disable timeout interrupt , set Host Master Clock to 56KHz if requ=
ested */
 	if (high_clock)
@@ -193,7 +193,8 @@ static int sis630_transaction_start(struct i2c_adap=
ter *adap, int size, u8 *oldc
=20
 static int sis630_transaction_wait(struct i2c_adapter *adap, int size)
 {
-	int temp, result =3D 0, timeout =3D 0;
+	u8 temp;
+	int result =3D 0, timeout =3D 0;
=20
 	/* We will always wait for a fraction of a second! */
 	do {
@@ -228,7 +229,8 @@ static void sis630_transaction_end(struct i2c_adapt=
er *adap, u8 oldclock)
 	/* clear all status "sticky" bits */
 	sis630_write(SMB_STS, 0xFF);
=20
-	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n", sis630_r=
ead(SMB_CNT));
+	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02hx\n",
+		sis630_read(SMB_CNT));
=20
 	/*
 	 * restore old Host Master Clock if high_clock is set
@@ -237,7 +239,8 @@ static void sis630_transaction_end(struct i2c_adapt=
er *adap, u8 oldclock)
 	if (high_clock && !(oldclock & SMBCLK_SEL))
 		sis630_write(SMB_CNT, sis630_read(SMB_CNT) & ~SMBCLK_SEL);
=20
-	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n", sis630_re=
ad(SMB_CNT));
+	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02hx\n",
+		sis630_read(SMB_CNT));
 }
=20
 static int sis630_transaction(struct i2c_adapter *adap, int size)
@@ -266,8 +269,8 @@ static int sis630_block_data(struct i2c_adapter *ad=
ap, union i2c_smbus_data *dat
 		else if (len > 32)
 			len =3D 32;
 		sis630_write(SMB_COUNT, len);
-		for (i=3D1; i <=3D len; i++) {
-			dev_dbg(&adap->dev, "set data 0x%02x\n", data->block[i]);
+		for (i =3D 1; i <=3D len; i++) {
+			dev_dbg(&adap->dev, "set data 0x%02hx\n", data->block[i]);
 			/* set data */
 			sis630_write(SMB_BYTE+(i-1)%8, data->block[i]);
 			if (i=3D=3D8 || (len<8 && i=3D=3Dlen)) {
@@ -319,7 +322,7 @@ static int sis630_block_data(struct i2c_adapter *ad=
ap, union i2c_smbus_data *dat
 			if (data->block[0] > 32)
 				data->block[0] =3D 32;
=20
-			dev_dbg(&adap->dev, "block data read len=3D0x%x\n", data->block[0])=
;
+			dev_dbg(&adap->dev, "block data read len=3D0x%hx\n", data->block[0]=
);
=20
 			for (i=3D0; i < 8 && len < data->block[0]; i++,len++) {
 				dev_dbg(&adap->dev, "read i=3D%d len=3D%d\n", i, len);
@@ -463,7 +466,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 		goto exit;
 	}
=20
-	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04x\n", acpi_base);
+	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04hx\n", acpi_base);
=20
 	if (supported[i] =3D=3D PCI_DEVICE_ID_SI_760)
 		smbus_base =3D acpi_base + 0xE0;
--=20
1.7.8.6
