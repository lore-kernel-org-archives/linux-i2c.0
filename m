From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-piix4: Various cleanups and minor fixes
Date: Fri, 16 May 2008 12:35:49 +0200
Message-ID: <20080516123549.34b10a15@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The i2c-piix4 driver was used recently as a model to write a new SMBus
host controller driver and this made me realize that the code of this
old driver wasn't exactly good. So, here are many cleanups and minor
fixes to this driver, so that these minor mistakes aren't duplicated
again:

* Delete unused structure.
* Delete needless forward function declaration.
* Properly announce the SMBus host controller as we find it.
* Spell it SMBus not SMB.
* Return -EBUSY instead of -ENODEV when the I/O region is already in
  use.
* Drop useless masks on the 7-bit address and the R/W bit.
* Reject block transaction requests with an invalid block length.
* Check and report block transaction replies with an invalid block
  length.
* Delete a useless comment.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |   41 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

--- linux-2.6.26-rc2.orig/drivers/i2c/busses/i2c-piix4.c	2008-05-16 08:45:52.000000000 +0200
+++ linux-2.6.26-rc2/drivers/i2c/busses/i2c-piix4.c	2008-05-16 10:47:13.000000000 +0200
@@ -42,13 +42,6 @@
 #include <asm/io.h>
 
 
-struct sd {
-	const unsigned short mfr;
-	const unsigned short dev;
-	const unsigned char fn;
-	const char *name;
-};
-
 /* PIIX4 SMBus address offsets */
 #define SMBHSTSTS	(0 + piix4_smba)
 #define SMBHSLVSTS	(1 + piix4_smba)
@@ -101,8 +94,6 @@ MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
 
-static int piix4_transaction(void);
-
 static unsigned short piix4_smba;
 static int srvrworks_csb5_delay;
 static struct pci_driver piix4_driver;
@@ -141,8 +132,6 @@ static int __devinit piix4_setup(struct 
 {
 	unsigned char temp;
 
-	dev_info(&PIIX4_dev->dev, "Found %s device\n", pci_name(PIIX4_dev));
-
 	if ((PIIX4_dev->vendor == PCI_VENDOR_ID_SERVERWORKS) &&
 	    (PIIX4_dev->device == PCI_DEVICE_ID_SERVERWORKS_CSB5))
 		srvrworks_csb5_delay = 1;
@@ -172,7 +161,7 @@ static int __devinit piix4_setup(struct 
 		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
 		piix4_smba &= 0xfff0;
 		if(piix4_smba == 0) {
-			dev_err(&PIIX4_dev->dev, "SMB base address "
+			dev_err(&PIIX4_dev->dev, "SMBus base address "
 				"uninitialized - upgrade BIOS or use "
 				"force_addr=0xaddr\n");
 			return -ENODEV;
@@ -180,9 +169,9 @@ static int __devinit piix4_setup(struct 
 	}
 
 	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
-		dev_err(&PIIX4_dev->dev, "SMB region 0x%x already in use!\n",
+		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
 			piix4_smba);
-		return -ENODEV;
+		return -EBUSY;
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
@@ -228,13 +217,13 @@ static int __devinit piix4_setup(struct 
 			"(or code out of date)!\n");
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
-	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
-	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
+	dev_info(&PIIX4_dev->dev,
+		 "SMBus Host Controller at 0x%x, revision %d\n",
+		 piix4_smba, temp);
 
 	return 0;
 }
 
-/* Another internally used function */
 static int piix4_transaction(void)
 {
 	int temp;
@@ -322,19 +311,19 @@ static s32 piix4_access(struct i2c_adapt
 		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -EOPNOTSUPP;
 	case I2C_SMBUS_QUICK:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
 		size = PIIX4_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
 		if (read_write == I2C_SMBUS_WRITE)
 			outb_p(command, SMBHSTCMD);
 		size = PIIX4_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
 		if (read_write == I2C_SMBUS_WRITE)
@@ -342,7 +331,7 @@ static s32 piix4_access(struct i2c_adapt
 		size = PIIX4_BYTE_DATA;
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
 		if (read_write == I2C_SMBUS_WRITE) {
@@ -352,15 +341,13 @@ static s32 piix4_access(struct i2c_adapt
 		size = PIIX4_WORD_DATA;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		outb_p((addr << 1) | read_write,
 		       SMBHSTADD);
 		outb_p(command, SMBHSTCMD);
 		if (read_write == I2C_SMBUS_WRITE) {
 			len = data->block[0];
-			if (len < 0)
-				len = 0;
-			if (len > 32)
-				len = 32;
+			if (len == 0 || len > I2C_SMBUS_BLOCK_MAX)
+				return -EINVAL;
 			outb_p(len, SMBHSTDAT0);
 			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 			for (i = 1; i <= len; i++)
@@ -390,6 +377,8 @@ static s32 piix4_access(struct i2c_adapt
 		break;
 	case PIIX4_BLOCK_DATA:
 		data->block[0] = inb_p(SMBHSTDAT0);
+		if (data->block[0] == 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
+			return -EPROTO;
 		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i = 1; i <= data->block[0]; i++)
 			data->block[i] = inb_p(SMBBLKDAT);


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
