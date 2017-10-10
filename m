From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2] i2c: piix4: Disable completely the IMC during SMBUS_BLOCK_DATA
Date: Tue, 10 Oct 2017 14:48:58 +0200
Message-ID: <20171010124858.2247-1-ricardo.ribalda@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:48959 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbdJJMtE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 10 Oct 2017 08:49:04 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

SMBUS_BLOCK_DATA transactions might fail due to a race condition with
the IMC (Integrated Micro Controller), even when the IMC semaphore
is used.

This bug has been reported and confirmed by AMD, who suggested as a
solution an IMC firmware upgrade (obtained via BIOS update) and
disabling the IMC during SMBUS_BLOCK_DATA transactions.

Even without the IMC upgrade, the SMBUS is much more stable with this
patch.

Tested on a Bettong-alike board.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
v2: Suggestions by Jean Delvare <jdelvare@suse.de>

-Fix function definitions (static)
-Add register definition
-Use muxed_io interface
-Improve comments
-Keep old timeout
-Rebase


 drivers/i2c/busses/i2c-piix4.c | 132 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 01f767ee4546..04ade552d426 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -85,6 +85,9 @@
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
 
+#define IMC_SMB_IDX			0x3e
+#define IMC_SMB_DATA			0x3f
+
 /*
  * SB800 port is selected by bits 2:1 of the smb_en register (0x2c)
  * or the smb_sel register (0x2e), depending on bit 0 of register 0x2f.
@@ -168,6 +171,7 @@ struct i2c_piix4_adapdata {
 	/* SB800 */
 	bool sb800_main;
 	u8 port;		/* Port number, shifted */
+	bool notify_imc;
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -594,6 +598,67 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 	return 0;
 }
 
+static uint8_t piix4_imc_read(uint8_t idx)
+{
+	outb_p(idx, IMC_SMB_IDX);
+	return inb_p(IMC_SMB_DATA);
+}
+
+static void piix4_imc_write(uint8_t idx, uint8_t value)
+{
+	outb_p(idx, IMC_SMB_IDX);
+	outb_p(value, IMC_SMB_DATA);
+}
+
+static int piix4_imc_sleep(void)
+{
+	int timeout = MAX_TIMEOUT;
+
+	if (!request_muxed_region(IMC_SMB_IDX, 2, "kerncz_imc_idx"))
+		return -EBUSY;
+
+	/* clear response register */
+	piix4_imc_write(0x82, 0x00);
+	/* request ownership flag */
+	piix4_imc_write(0x83, 0xB4);
+	/* Kick off IMC Mailbox command 96 */
+	piix4_imc_write(0x80, 0x96);
+
+	while (timeout--) {
+		if (piix4_imc_read(0x82) == 0xfa) {
+			release_region(IMC_SMB_IDX, 2);
+			return 0;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	release_region(IMC_SMB_IDX, 2);
+	return -ETIMEDOUT;
+}
+
+static void piix4_imc_wakeup(void)
+{
+	int timeout = MAX_TIMEOUT;
+
+	if (!request_muxed_region(IMC_SMB_IDX, 2, "kerncz_imc_idx"))
+		return;
+
+	/* clear response register */
+	piix4_imc_write(0x82, 0x00);
+	/* release ownership flag */
+	piix4_imc_write(0x83, 0xB5);
+	/* Kick off IMC Mailbox command 96 */
+	piix4_imc_write(0x80, 0x96);
+
+	while (timeout--) {
+		if (piix4_imc_read(0x82) == 0xfa)
+			break;
+		usleep_range(1000, 2000);
+	}
+
+	release_region(IMC_SMB_IDX, 2);
+}
+
 /*
  * Handles access to multiple SMBus ports on the SB800.
  * The port is selected by bits 2:1 of the smb_en register (0x2c).
@@ -634,6 +699,41 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 		return -EBUSY;
 	}
 
+	/*
+	 * Notify the IMC (Integrated Micro Controller) if required.
+	 * Among other responsibilities, the IMC is in charge of monitoring
+	 * the System fans and temperature sensors, and act accordingly.
+	 * All this is done through SMBus and can/will collide
+	 * with our transactions if they are long (BLOCK_DATA).
+	 * Therefore we need to request the ownership flag during those
+	 * transactions.
+	 */
+	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc) {
+		int ret;
+
+		ret = piix4_imc_sleep();
+		switch (ret) {
+		case -EBUSY:
+			dev_warn(&adap->dev,
+				 "IMC base address index region 0x%x already in use.\n",
+				 IMC_SMB_IDX);
+			break;
+		case -ETIMEDOUT:
+			dev_warn(&adap->dev,
+				 "Failed to communicate with the IMC.\n");
+			break;
+		default:
+			break;
+		}
+
+		/* If IMC communication fails do not retry*/
+		if (ret) {
+			dev_warn(&adap->dev,
+				 "Continuing without IMC notification.\n");
+			adapdata->notify_imc = false;
+		}
+	}
+
 	outb_p(piix4_port_sel_sb800, SB800_PIIX4_SMB_IDX);
 	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
@@ -650,6 +750,9 @@ static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
 	/* Release the semaphore */
 	outb_p(smbslvcnt | 0x20, SMBSLVCNT);
 
+	if ((size == I2C_SMBUS_BLOCK_DATA) && adapdata->notify_imc)
+		piix4_imc_wakeup();
+
 	mutex_unlock(&piix4_mutex_sb800);
 
 	return retval;
@@ -701,7 +804,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     bool sb800_main, u8 port,
+			     bool sb800_main, u8 port, bool notify_imc,
 			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
@@ -729,6 +832,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adapdata->smba = smba;
 	adapdata->sb800_main = sb800_main;
 	adapdata->port = port << piix4_port_shift_sb800;
+	adapdata->notify_imc = notify_imc;
 
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
@@ -750,14 +854,15 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
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
@@ -791,6 +896,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		bool notify_imc = false;
 		is_sb800 = true;
 
 		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
@@ -800,6 +906,20 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return -EBUSY;
 		}
 
+		if (dev->vendor == PCI_VENDOR_ID_AMD &&
+		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+			u8 imc;
+
+			/*
+			 * Detect if IMC is active or not, this method is
+			 * described on coreboot's AMD IMC notes
+			 */
+			pci_bus_read_config_byte(dev->bus, PCI_DEVFN(0x14, 3),
+						 0x40, &imc);
+			if (imc & 0x80)
+				notify_imc = true;
+		}
+
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
 		if (retval < 0) {
@@ -811,7 +931,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		 * Try to register multiplexed main SMBus adapter,
 		 * give up if we can't
 		 */
-		retval = piix4_add_adapters_sb800(dev, retval);
+		retval = piix4_add_adapters_sb800(dev, retval, notify_imc);
 		if (retval < 0) {
 			release_region(SB800_PIIX4_SMB_IDX, 2);
 			return retval;
@@ -822,7 +942,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, false, 0, "",
+		retval = piix4_add_adapter(dev, retval, false, 0, false, "",
 					   &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
@@ -849,7 +969,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, false, 0,
+		piix4_add_adapter(dev, retval, false, 0, false,
 				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
 	}
-- 
2.14.2
