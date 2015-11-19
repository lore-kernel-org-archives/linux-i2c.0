From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v5 2/3] i2c-piix4: Add support for multiplexed main adapter in SB800
Date: Thu, 19 Nov 2015 20:13:48 +0100
Message-ID: <1447960429-19256-3-git-send-email-fetzer.ch@gmail.com>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34828 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161230AbbKSTOA (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 14:14:00 -0500
Received: by wmdw130 with SMTP id w130so253369366wmd.0
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2015 11:13:59 -0800 (PST)
In-Reply-To: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com, fetzer.ch@gmail.com, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

The SB800 chipset supports a multiplexed main SMBus controller with
four ports. The multiplexed ports share the same SMBus address and
register set. The port is selected by bits 2:1 of the smb_en register
(0x2C).

Only one port can be active at any point in time therefore a mutex is
needed in order to synchronize access.

Additionally, the commit avoids requesting and releasing the SMBus base
address index region on every multiplexed transfer by moving the
request_region call into piix4_probe.

Tested on HP ProLiant MicroServer G7 N54L (where this patch adds
support to access sensor data from the w83795adg).

Cc: Thomas Brandon <tbrandonau@gmail.com>
Cc: Eddi De Pieri <eddi@depieri.net>
Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-piix4.c | 169 +++++++++++++++++++++++++++++++++++------
 1 file changed, 147 insertions(+), 22 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 9c32eb1..6b4231d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -23,6 +23,9 @@
 
    Note: we assume there can only be one device, with one or more
    SMBus interfaces.
+   The device can register multiple i2c_adapters (up to PIIX4_MAX_ADAPTERS).
+   For devices supporting multiple ports the i2c_adapter should provide
+   an i2c_algorithm to access them.
 */
 
 #include <linux/module.h>
@@ -37,6 +40,7 @@
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 
 
 /* PIIX4 SMBus address offsets */
@@ -78,6 +82,13 @@
 /* Multi-port constants */
 #define PIIX4_MAX_ADAPTERS 4
 
+/* SB800 constants */
+#define SB800_PIIX4_SMB_IDX		0xcd6
+
+/* SB800 port is selected by bits 2:1 of the smb_en register (0x2c) */
+#define SB800_PIIX4_PORT_IDX		0x2c
+#define SB800_PIIX4_PORT_IDX_MASK	0x06
+
 /* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
@@ -127,6 +138,11 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
+
+	/* SB800 */
+	bool sb800_main;
+	unsigned short port;
+	struct mutex *mutex;
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -232,7 +248,6 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 			     const struct pci_device_id *id, u8 aux)
 {
 	unsigned short piix4_smba;
-	unsigned short smba_idx = 0xcd6;
 	u8 smba_en_lo, smba_en_hi, smb_en, smb_en_status;
 	u8 i2ccfg, i2ccfg_offset = 0x10;
 
@@ -254,16 +269,10 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		smb_en = (aux) ? 0x28 : 0x2c;
 
-	if (!request_region(smba_idx, 2, "smba_idx")) {
-		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
-			"0x%x already in use!\n", smba_idx);
-		return -EBUSY;
-	}
-	outb_p(smb_en, smba_idx);
-	smba_en_lo = inb_p(smba_idx + 1);
-	outb_p(smb_en + 1, smba_idx);
-	smba_en_hi = inb_p(smba_idx + 1);
-	release_region(smba_idx, 2);
+	outb_p(smb_en, SB800_PIIX4_SMB_IDX);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+	outb_p(smb_en + 1, SB800_PIIX4_SMB_IDX);
+	smba_en_hi = inb_p(SB800_PIIX4_SMB_IDX + 1);
 
 	if (!smb_en) {
 		smb_en_status = smba_en_lo & 0x10;
@@ -527,6 +536,43 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 	return 0;
 }
 
+/*
+ * Handles access to multiple SMBus ports on the SB800.
+ * The port is selected by bits 2:1 of the smb_en register (0x2c).
+ * Returns negative errno on error.
+ *
+ * Note: The selected port must be returned to the initial selection to avoid
+ * problems on certain systems.
+ */
+static s32 piix4_access_sb800(struct i2c_adapter *adap, u16 addr,
+		 unsigned short flags, char read_write,
+		 u8 command, int size, union i2c_smbus_data *data)
+{
+	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
+	u8 smba_en_lo;
+	u8 port;
+	int retval;
+
+	mutex_lock(adapdata->mutex);
+
+	outb_p(SB800_PIIX4_PORT_IDX, SB800_PIIX4_SMB_IDX);
+	smba_en_lo = inb_p(SB800_PIIX4_SMB_IDX + 1);
+
+	port = adapdata->port;
+	if ((smba_en_lo & SB800_PIIX4_PORT_IDX_MASK) != (port << 1))
+		outb_p((smba_en_lo & ~SB800_PIIX4_PORT_IDX_MASK) | (port << 1),
+		       SB800_PIIX4_SMB_IDX + 1);
+
+	retval = piix4_access(adap, addr, flags, read_write,
+			      command, size, data);
+
+	outb_p(smba_en_lo, SB800_PIIX4_SMB_IDX + 1);
+
+	mutex_unlock(adapdata->mutex);
+
+	return retval;
+}
+
 static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -539,6 +585,11 @@ static const struct i2c_algorithm smbus_algorithm = {
 	.functionality	= piix4_func,
 };
 
+static const struct i2c_algorithm piix4_smbus_algorithm_sb800 = {
+	.smbus_xfer	= piix4_access_sb800,
+	.functionality	= piix4_func,
+};
+
 static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3) },
@@ -614,6 +665,53 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	return 0;
 }
 
+static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
+{
+	struct mutex *mutex;
+	struct i2c_piix4_adapdata *adapdata;
+	int port;
+	int retval;
+
+	mutex = kzalloc(sizeof(*mutex), GFP_KERNEL);
+	if (mutex == NULL)
+		return -ENOMEM;
+
+	mutex_init(mutex);
+
+	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
+		retval = piix4_add_adapter(dev, smba,
+					   &piix4_main_adapters[port]);
+		if (retval < 0)
+			goto error;
+
+		piix4_main_adapters[port]->algo = &piix4_smbus_algorithm_sb800;
+
+		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
+		adapdata->sb800_main = true;
+		adapdata->port = port;
+		adapdata->mutex = mutex;
+	}
+
+	return retval;
+
+error:
+	dev_err(&dev->dev,
+		"Error setting up SB800 adapters. Unregistering!\n");
+	while (--port >= 0) {
+		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
+		if (adapdata->smba) {
+			i2c_del_adapter(piix4_main_adapters[port]);
+			kfree(adapdata);
+			kfree(piix4_main_adapters[port]);
+			piix4_main_adapters[port] = NULL;
+		}
+	}
+
+	kfree(mutex);
+
+	return retval;
+}
+
 static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
@@ -621,20 +719,41 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD)
+	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
+			dev_err(&dev->dev,
+			"SMBus base address index region 0x%x already in use!\n",
+			SB800_PIIX4_SMB_IDX);
+			return -EBUSY;
+		}
+
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
-	else
-		retval = piix4_setup(dev, id);
+		if (retval < 0) {
+			release_region(SB800_PIIX4_SMB_IDX, 2);
+			return retval;
+		}
 
-	/* If no main SMBus found, give up */
-	if (retval < 0)
-		return retval;
+		/*
+		 * Try to register multiplexed main SMBus adapter,
+		 * give up if we can't
+		 */
+		retval = piix4_add_adapters_sb800(dev, retval);
+		if (retval < 0) {
+			release_region(SB800_PIIX4_SMB_IDX, 2);
+			return retval;
+		}
+	} else {
+		retval = piix4_setup(dev, id);
+		if (retval < 0)
+			return retval;
 
-	/* Try to register main SMBus adapter, give up if we can't */
-	retval = piix4_add_adapter(dev, retval, &piix4_main_adapters[0]);
-	if (retval < 0)
-		return retval;
+		/* Try to register main SMBus adapter, give up if we can't */
+		retval = piix4_add_adapter(dev, retval,
+					   &piix4_main_adapters[0]);
+		if (retval < 0)
+			return retval;
+	}
 
 	/* Check for auxiliary SMBus on some AMD chipsets */
 	retval = -ENODEV;
@@ -669,7 +788,13 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		release_region(adapdata->smba, SMBIOSIZE);
+		if (adapdata->port == 0) {
+			release_region(adapdata->smba, SMBIOSIZE);
+			if (adapdata->sb800_main) {
+				kfree(adapdata->mutex);
+				release_region(SB800_PIIX4_SMB_IDX, 2);
+			}
+		}
 		kfree(adapdata);
 		kfree(adap);
 	}
-- 
1.9.1
