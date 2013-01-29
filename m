From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4] Cleanup
Date: Tue, 29 Jan 2013 21:22:26 +0100
Message-ID: <1359490946-24005-1-git-send-email-amaury.decreme@gmail.com>
References: <20130129103151.21262d1d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130129103151.21262d1d-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch corrects checkpatch errors.

The changes has also been removed as it has less meaning with version
control tools.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c | 214 ++++++++++++++++++++------------=
--------
 1 file changed, 109 insertions(+), 105 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index 424545b..36a9556 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -17,25 +17,6 @@
 */
=20
 /*
-   Changes:
-   24.08.2002
-   	Fixed the typo in sis630_access (Thanks to Mark M. Hoffman)
-	Changed sis630_transaction.(Thanks to Mark M. Hoffman)
-   18.09.2002
-	Added SIS730 as supported.
-   21.09.2002
-	Added high_clock module option.If this option is set
-	used Host Master Clock 56KHz (default 14KHz).For now we save old Host
-	Master Clock and after transaction completed restore (otherwise
-	it's confuse BIOS and hung Machine).
-   24.09.2002
-	Fixed typo in sis630_access
-	Fixed logical error by restoring of Host Master Clock
-   31.07.2003
-   	Added block data read/write support.
-*/
-
-/*
    Status: beta
=20
    Supports:
@@ -150,9 +131,10 @@ static inline void sis630_write(u8 reg, u8 data)
 	outb(data, smbus_base + reg);
 }
=20
-static int sis630_transaction_start(struct i2c_adapter *adap, int size=
, u8 *oldclock)
+static int sis630_transaction_start(struct i2c_adapter *adap, int size=
,
+				    u8 *oldclock)
 {
-        int temp;
+	int temp;
=20
 	/* Make sure the SMBus host is ready to start transmitting. */
 	temp =3D sis630_read(SMB_CNT);
@@ -165,17 +147,18 @@ static int sis630_transaction_start(struct i2c_ad=
apter *adap, int size, u8 *oldc
 		if (temp & (SMB_PROBE | SMB_HOSTBUSY)) {
 			dev_dbg(&adap->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
-                } else {
+		} else {
 			dev_dbg(&adap->dev, "Successful!\n");
 		}
-        }
+	}
=20
 	/* save old clock, so we can prevent machine for hung */
 	*oldclock =3D sis630_read(SMB_CNT);
=20
 	dev_dbg(&adap->dev, "saved clock 0x%02x\n", *oldclock);
=20
-	/* disable timeout interrupt , set Host Master Clock to 56KHz if requ=
ested */
+	/* disable timeout interrupt,
+	 * set Host Master Clock to 56KHz if requested */
 	if (high_clock)
 		sis630_write(SMB_CNT, SMBCLK_SEL);
 	else
@@ -228,7 +211,8 @@ static void sis630_transaction_end(struct i2c_adapt=
er *adap, u8 oldclock)
 	/* clear all status "sticky" bits */
 	sis630_write(SMB_STS, 0xFF);
=20
-	dev_dbg(&adap->dev, "SMB_CNT before clock restore 0x%02x\n", sis630_r=
ead(SMB_CNT));
+	dev_dbg(&adap->dev,
+		"SMB_CNT before clock restore 0x%02x\n", sis630_read(SMB_CNT));
=20
 	/*
 	 * restore old Host Master Clock if high_clock is set
@@ -237,7 +221,8 @@ static void sis630_transaction_end(struct i2c_adapt=
er *adap, u8 oldclock)
 	if (high_clock && !(oldclock & SMBCLK_SEL))
 		sis630_write(SMB_CNT, sis630_read(SMB_CNT) & ~SMBCLK_SEL);
=20
-	dev_dbg(&adap->dev, "SMB_CNT after clock restore 0x%02x\n", sis630_re=
ad(SMB_CNT));
+	dev_dbg(&adap->dev,
+		"SMB_CNT after clock restore 0x%02x\n", sis630_read(SMB_CNT));
 }
=20
 static int sis630_transaction(struct i2c_adapter *adap, int size)
@@ -254,7 +239,8 @@ static int sis630_transaction(struct i2c_adapter *a=
dap, int size)
 	return result;
 }
=20
-static int sis630_block_data(struct i2c_adapter *adap, union i2c_smbus=
_data *data, int read_write)
+static int sis630_block_data(struct i2c_adapter *adap,
+			     union i2c_smbus_data *data, int read_write)
 {
 	int i, len =3D 0, rc =3D 0;
 	u8 oldclock =3D 0;
@@ -266,22 +252,26 @@ static int sis630_block_data(struct i2c_adapter *=
adap, union i2c_smbus_data *dat
 		else if (len > 32)
 			len =3D 32;
 		sis630_write(SMB_COUNT, len);
-		for (i=3D1; i <=3D len; i++) {
-			dev_dbg(&adap->dev, "set data 0x%02x\n", data->block[i]);
+		for (i =3D 1; i <=3D len; i++) {
+			dev_dbg(&adap->dev,
+				"set data 0x%02x\n", data->block[i]);
 			/* set data */
-			sis630_write(SMB_BYTE+(i-1)%8, data->block[i]);
-			if (i=3D=3D8 || (len<8 && i=3D=3Dlen)) {
-				dev_dbg(&adap->dev, "start trans len=3D%d i=3D%d\n",len ,i);
+			sis630_write(SMB_BYTE + (i - 1) % 8, data->block[i]);
+			if (i =3D=3D 8 || (len < 8 && i =3D=3D len)) {
+				dev_dbg(&adap->dev,
+					"start trans len=3D%d i=3D%d\n", len, i);
 				/* first transaction */
 				rc =3D sis630_transaction_start(adap,
 						SIS630_BLOCK_DATA, &oldclock);
 				if (rc)
 					return rc;
-			}
-			else if ((i-1)%8 =3D=3D 7 || i=3D=3Dlen) {
-				dev_dbg(&adap->dev, "trans_wait len=3D%d i=3D%d\n",len,i);
-				if (i>8) {
-					dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",len,i);
+			} else if ((i - 1) % 8 =3D=3D 7 || i =3D=3D len) {
+				dev_dbg(&adap->dev,
+					"trans_wait len=3D%d i=3D%d\n", len, i);
+				if (i > 8) {
+					dev_dbg(&adap->dev,
+						"clear smbary_sts"
+						" len=3D%d i=3D%d\n", len, i);
 					/*
 					   If this is not first transaction,
 					   we must clear sticky bit.
@@ -292,13 +282,13 @@ static int sis630_block_data(struct i2c_adapter *=
adap, union i2c_smbus_data *dat
 				rc =3D sis630_transaction_wait(adap,
 						SIS630_BLOCK_DATA);
 				if (rc) {
-					dev_dbg(&adap->dev, "trans_wait failed\n");
+					dev_dbg(&adap->dev,
+						"trans_wait failed\n");
 					break;
 				}
 			}
 		}
-	}
-	else {
+	} else {
 		/* read request */
 		data->block[0] =3D len =3D 0;
 		rc =3D sis630_transaction_start(adap,
@@ -319,18 +309,22 @@ static int sis630_block_data(struct i2c_adapter *=
adap, union i2c_smbus_data *dat
 			if (data->block[0] > 32)
 				data->block[0] =3D 32;
=20
-			dev_dbg(&adap->dev, "block data read len=3D0x%x\n", data->block[0])=
;
+			dev_dbg(&adap->dev,
+				"block data read len=3D0x%x\n", data->block[0]);
=20
-			for (i=3D0; i < 8 && len < data->block[0]; i++,len++) {
-				dev_dbg(&adap->dev, "read i=3D%d len=3D%d\n", i, len);
-				data->block[len+1] =3D sis630_read(SMB_BYTE+i);
+			for (i =3D 0; i < 8 && len < data->block[0]; i++, len++) {
+				dev_dbg(&adap->dev,
+					"read i=3D%d len=3D%d\n", i, len);
+				data->block[len + 1] =3D sis630_read(SMB_BYTE +
+								   i);
 			}
=20
-			dev_dbg(&adap->dev, "clear smbary_sts len=3D%d i=3D%d\n",len,i);
+			dev_dbg(&adap->dev,
+				"clear smbary_sts len=3D%d i=3D%d\n", len, i);
=20
 			/* clear SMBARY_STS */
 			sis630_write(SMB_STS, BYTE_DONE_STS);
-		} while(len < data->block[0]);
+		} while (len < data->block[0]);
 	}
=20
 	sis630_transaction_end(adap, oldclock);
@@ -346,42 +340,47 @@ static s32 sis630_access(struct i2c_adapter *adap=
, u16 addr,
 	int status;
=20
 	switch (size) {
-		case I2C_SMBUS_QUICK:
-			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
-			size =3D SIS630_QUICK;
-			break;
-		case I2C_SMBUS_BYTE:
-			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
-			if (read_write =3D=3D I2C_SMBUS_WRITE)
-				sis630_write(SMB_CMD, command);
-			size =3D SIS630_BYTE;
-			break;
-		case I2C_SMBUS_BYTE_DATA:
-			sis630_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
-			sis630_write(SMB_CMD, command);
-			if (read_write =3D=3D I2C_SMBUS_WRITE)
-				sis630_write(SMB_BYTE, data->byte);
-			size =3D SIS630_BYTE_DATA;
-			break;
-		case I2C_SMBUS_PROC_CALL:
-		case I2C_SMBUS_WORD_DATA:
-			sis630_write(SMB_ADDR,((addr & 0x7f) << 1) | (read_write & 0x01));
+	case I2C_SMBUS_QUICK:
+		sis630_write(SMB_ADDR,
+			     ((addr & 0x7f) << 1) | (read_write & 0x01));
+		size =3D SIS630_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		sis630_write(SMB_ADDR,
+			     ((addr & 0x7f) << 1) | (read_write & 0x01));
+		if (read_write =3D=3D I2C_SMBUS_WRITE)
 			sis630_write(SMB_CMD, command);
-			if (read_write =3D=3D I2C_SMBUS_WRITE) {
-				sis630_write(SMB_BYTE, data->word & 0xff);
-				sis630_write(SMB_BYTE + 1,(data->word & 0xff00) >> 8);
-			}
-			size =3D (size =3D=3D I2C_SMBUS_PROC_CALL ? SIS630_PCALL : SIS630_W=
ORD_DATA);
-			break;
-		case I2C_SMBUS_BLOCK_DATA:
-			sis630_write(SMB_ADDR,((addr & 0x7f) << 1) | (read_write & 0x01));
-			sis630_write(SMB_CMD, command);
-			size =3D SIS630_BLOCK_DATA;
-			return sis630_block_data(adap, data, read_write);
-		default:
-			dev_warn(&adap->dev, "Unsupported transaction %d\n",
-				 size);
-			return -EOPNOTSUPP;
+		size =3D SIS630_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		sis630_write(SMB_ADDR,
+			     ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis630_write(SMB_CMD, command);
+		if (read_write =3D=3D I2C_SMBUS_WRITE)
+			sis630_write(SMB_BYTE, data->byte);
+		size =3D SIS630_BYTE_DATA;
+		break;
+	case I2C_SMBUS_PROC_CALL:
+	case I2C_SMBUS_WORD_DATA:
+		sis630_write(SMB_ADDR,
+			     ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis630_write(SMB_CMD, command);
+		if (read_write =3D=3D I2C_SMBUS_WRITE) {
+			sis630_write(SMB_BYTE, data->word & 0xff);
+			sis630_write(SMB_BYTE + 1, (data->word & 0xff00) >> 8);
+		}
+		size =3D (size =3D=3D I2C_SMBUS_PROC_CALL ?
+			SIS630_PCALL : SIS630_WORD_DATA);
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		sis630_write(SMB_ADDR,
+			     ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis630_write(SMB_CMD, command);
+		size =3D SIS630_BLOCK_DATA;
+		return sis630_block_data(adap, data, read_write);
+	default:
+		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
+		return -EOPNOTSUPP;
 	}
=20
 	status =3D sis630_transaction(adap, size);
@@ -393,15 +392,16 @@ static s32 sis630_access(struct i2c_adapter *adap=
, u16 addr,
 		return 0;
 	}
=20
-	switch(size) {
-		case SIS630_BYTE:
-		case SIS630_BYTE_DATA:
-			data->byte =3D sis630_read(SMB_BYTE);
-			break;
-		case SIS630_PCALL:
-		case SIS630_WORD_DATA:
-			data->word =3D sis630_read(SMB_BYTE) + (sis630_read(SMB_BYTE + 1) <=
< 8);
-			break;
+	switch (size) {
+	case SIS630_BYTE:
+	case SIS630_BYTE_DATA:
+		data->byte =3D sis630_read(SMB_BYTE);
+		break;
+	case SIS630_PCALL:
+	case SIS630_WORD_DATA:
+		data->word =3D sis630_read(SMB_BYTE) +
+			     (sis630_read(SMB_BYTE + 1) << 8);
+		break;
 	}
=20
 	return 0;
@@ -409,9 +409,9 @@ static s32 sis630_access(struct i2c_adapter *adap, =
u16 addr,
=20
 static u32 sis630_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BY=
TE_DATA |
-		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_PROC_CALL |
-		I2C_FUNC_SMBUS_BLOCK_DATA;
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_BLOCK_DATA;
 }
=20
 static int sis630_setup(struct pci_dev *sis630_dev)
@@ -423,19 +423,19 @@ static int sis630_setup(struct pci_dev *sis630_de=
v)
 	unsigned short acpi_base;
=20
 	/* check for supported SiS devices */
-	for (i=3D0; supported[i] > 0 ; i++) {
-		if ((dummy =3D pci_get_device(PCI_VENDOR_ID_SI, supported[i], dummy)=
))
+	for (i =3D 0; supported[i] > 0; i++) {
+		dummy =3D pci_get_device(PCI_VENDOR_ID_SI, supported[i], dummy);
+		if (dummy)
 			break; /* found */
 	}
=20
 	if (dummy) {
 		pci_dev_put(dummy);
-	}
-        else if (force) {
-		dev_err(&sis630_dev->dev, "WARNING: Can't detect SIS630 compatible d=
evice, but "
+	} else if (force) {
+		dev_err(&sis630_dev->dev,
+			"WARNING: Can't detect SIS630 compatible device, but "
 			"loading because of force option enabled\n");
- 	}
-	else {
+	} else {
 		return -ENODEV;
 	}
=20
@@ -443,7 +443,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 	   Enable ACPI first , so we can accsess reg 74-75
 	   in acpi io space and read acpi base addr
 	*/
-	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG,&b)) {
+	if (pci_read_config_byte(sis630_dev, SIS630_BIOS_CTL_REG, &b)) {
 		dev_err(&sis630_dev->dev, "Error: Can't read bios ctl reg\n");
 		retval =3D -ENODEV;
 		goto exit;
@@ -457,8 +457,10 @@ static int sis630_setup(struct pci_dev *sis630_dev=
)
 	}
=20
 	/* Determine the ACPI base address */
-	if (pci_read_config_word(sis630_dev,SIS630_ACPI_BASE_REG,&acpi_base))=
 {
-		dev_err(&sis630_dev->dev, "Error: Can't determine ACPI base address\=
n");
+	if (pci_read_config_word(sis630_dev,
+				 SIS630_ACPI_BASE_REG, &acpi_base)) {
+		dev_err(&sis630_dev->dev,
+			"Error: Can't determine ACPI base address\n");
 		retval =3D -ENODEV;
 		goto exit;
 	}
@@ -516,12 +518,14 @@ static DEFINE_PCI_DEVICE_TABLE(sis630_ids) =3D {
 	{ 0, }
 };
=20
-MODULE_DEVICE_TABLE (pci, sis630_ids);
+MODULE_DEVICE_TABLE(pci, sis630_ids);
=20
 static int sis630_probe(struct pci_dev *dev, const struct pci_device_i=
d *id)
 {
 	if (sis630_setup(dev)) {
-		dev_err(&dev->dev, "SIS630 comp. bus not detected, module not insert=
ed.\n");
+		dev_err(&dev->dev,
+			"SIS630 compatible bus not detected, "
+			"module not inserted.\n");
 		return -ENODEV;
 	}
=20
--=20
1.7.12.4
