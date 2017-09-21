From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] i2c: piix4: Disable completely the IMC during  SMBUS_BLOCK_DATA
Date: Thu, 21 Sep 2017 09:37:43 +0200
Message-ID: <20170921073743.3052-1-ricardo.ribalda@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32931 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdIUHhs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 21 Sep 2017 03:37:48 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

SMBUS_BLOCK_DATA transactions might fail due to a race condition with
the IMC, even when the IMC semaphore is used.

This bug has been reported and confirmed by AMD, who suggested as a
solution an IMC firmware upgrade (obtained via BIOS update) and
disabling the IMC during SMBUS_BLOCK_DATA transactions.

Even without the IMC upgrade, the smbus is much more stable with this
patch.

Tested on a Bettong-alike board.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 89 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0ecdb47a23ab..3b8a5eaad956 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -85,6 +85,8 @@
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
 
+#define IMC_SMB_IDX			0x3e
+
 /*
  * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
  * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
@@ -160,6 +162,8 @@ struct i2c_piix4_adapdata {
 	/* SB800 */
 	bool sb800_main;
 	u8 port;		/* Port number, shifted */
+
+	bool notify_imc;
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -572,6 +576,50 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 	return 0;
 }
 
+static uint8_t piix4_imc_read(uint8_t idx)
+{
+	outb_p(idx, IMC_SMB_IDX);
+	return inb_p(IMC_SMB_IDX + 1);
+}
+
+static void piix4_imc_write(uint8_t idx, uint8_t value)
+{
+	outb_p(idx, IMC_SMB_IDX);
+	outb_p(value, IMC_SMB_IDX + 1);
+}
+
+int piix4_imc_sleep(void)
+{
+	int timeout = MAX_TIMEOUT;
+
+	piix4_imc_write(0x82, 0x00);
+	piix4_imc_write(0x83, 0xB4);
+	piix4_imc_write(0x80, 0x96);
+
+	while (timeout--) {
+		if (piix4_imc_read(0x82) == 0xfa)
+			return 0;
+		usleep_range(1000, 2000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+void piix4_imc_wakeup(void)
+{
+	int timeout = MAX_TIMEOUT;
+
+	piix4_imc_write(0x82, 0x00);
+	piix4_imc_write(0x83, 0xB5);
+	piix4_imc_write(0x80, 0x96);
+
+	while (timeout--) {
+		if (piix4_imc_read(0x82) == 0xfa)
+			break;
+		usleep_range(1000, 2000);
+	}
+}
+
 /*
  * Handles access to multiple SMBus ports on the SB800.
  * The port is selected by bits 2:1 of the smb_en register (0x2c).
@@ -586,7 +634,7 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 	unsigned short piix4_smba = adapdata->smba;
-	int retries = MAX_TIMEOUT;
+	int retries = adapdata->notify_imc ? MAX_TIMEOUT * 2 : MAX_TIMEOUT;
 	int smbslvcnt;
 	u8 smba_en_lo;
 	u8 port;
@@ -612,6 +660,15 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		return -EBUSY;
 	}
 
+	/* Block data transfers require disabling the imc */
+	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
+		/* If IMC communication fails do not retry*/
+		if (piix4_imc_sleep()) {
+			dev_warn(&adap->dev,
+				 "Failed to communicate with the IMC, enable it and/or upgrade your BIOS.\n");
+			adapdata->notify_imc = false;
+		}
+
 	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
@@ -628,6 +685,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
+	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
+		piix4_imc_wakeup();
+
 	mutex_unlock(&piix4_mutex_sb800);
 
 	return retval;
@@ -679,7 +739,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     bool sb800_main, u8 port,
+			     bool sb800_main, u8 port, bool notify_imc,
 			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
@@ -707,6 +767,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adapdata->smba = smba;
 	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << 1;
+	adapdata->notify_imc = notify_imc;
 
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
@@ -728,14 +789,15 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	return 0;
 }
 
-static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
+static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
+				    bool notify_imc)
 {
 	struct i2c_piix4_adapdata *adapdata;
 	int port;
 	int retval;
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
-		retval = piix4_add_adapter(dev, smba, true, port,
+		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
@@ -769,6 +831,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		bool notify_imc = false;
 		is_sb800 = true;
 
 		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
@@ -778,6 +841,18 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return -EBUSY;
 		}
 
+		if (dev->vendor == PCI_VENDOR_ID_AMD &&
+		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+			if (!devm_request_region(&dev->dev, IMC_SMB_IDX, 2,
+						 "kerncz_imc_idx")) {
+				dev_warn(&dev->dev,
+					"IMC base address index region 0x%x already in use!\n",
+					SB800_PIIX4_SMB_IDX);
+			} else {
+				notify_imc = true;
+			}
+		}
+
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
 		if (retval < 0) {
@@ -789,7 +864,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		 * Try to register multiplexed main SMBus adapter,
 		 * give up if we can't
 		 */
-		retval = piix4_add_adapters_sb800(dev, retval);
+		retval = piix4_add_adapters_sb800(dev, retval, notify_imc);
 		if (retval < 0) {
 			release_region(SB800_PIIX4_SMB_IDX, 2);
 			return retval;
@@ -800,7 +875,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, false, 0, "",
+		retval = piix4_add_adapter(dev, retval, false, 0, false, "",
 					   &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
@@ -827,7 +902,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, false, 0,
+		piix4_add_adapter(dev, retval, false, 0, false,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
 	}
-- 
2.14.1
