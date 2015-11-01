From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 4/5] i2c-piix4: Add support for multiplexed main adapter in SB800
Date: Sun,  1 Nov 2015 17:32:08 +0100
Message-ID: <1446395529-9987-5-git-send-email-fetzer.ch@gmail.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:34894 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbKAQdC (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:33:02 -0500
Received: by wicuv6 with SMTP id uv6so7818901wic.2
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:33:00 -0800 (PST)
In-Reply-To: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>, Thomas Brandon <tbrandonau@gmail.com>, Eddi De Pieri <eddi@depieri.net>

The SB800 chipset supports a multiplexed main SMBus controller with
four ports. The multiplexed ports share the same SMBus address and
register set. The port is selected by bits 2:1 of the smb_en register
(0x2C).

Only one port can be active at any point in time therefore a mutex is
needed in order to synchronize access.

Tested on HP ProLiant MicroServer G7 N54L (where this patch adds
support to access sensor data from the w83795adg).

Cc: Thomas Brandon <tbrandonau@gmail.com>
Cc: Eddi De Pieri <eddi@depieri.net>
Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 102 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index d866b58..54f8af5 100644
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
@@ -126,10 +130,12 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 };
 
 /* SB800 globals */
+DEFINE_MUTEX(piix4_mutex_sb800);
 static unsigned short piix4_smb_idx_sb800;
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
+	unsigned short port;
 };
 
 static int piix4_setup(struct pci_dev *PIIX4_dev,
@@ -309,6 +315,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	else
 		dev_dbg(&PIIX4_dev->dev, "Using SMI# for SMBus\n");
 
+	mutex_init(&piix4_mutex_sb800);
+
 	dev_info(&PIIX4_dev->dev,
 		 "SMBus Host Controller at 0x%x, revision %d\n",
 		 piix4_smba, i2ccfg >> 4);
@@ -523,6 +531,42 @@ static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 	return 0;
 }
 
+/* Handles access to multiple SMBus ports on the SB800.
+ * The port is selected by bits 2:1 of the smb_en register (0x2C).
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
+	u8 smba_en_lo, smb_en = 0x2c;
+	u8 port;
+	int retval;
+
+	mutex_lock(&piix4_mutex_sb800);
+
+	outb_p(smb_en, piix4_smb_idx_sb800);
+	smba_en_lo = inb_p(piix4_smb_idx_sb800 + 1);
+
+	port = adapdata->port;
+	if ((smba_en_lo & 6) != (port << 1))
+		outb_p((smba_en_lo & ~6) | (port << 1),
+		       piix4_smb_idx_sb800 + 1);
+
+	retval = piix4_access(adap, addr, flags, read_write,
+			      command, size, data);
+
+	outb_p(smba_en_lo, piix4_smb_idx_sb800 + 1);
+
+	mutex_unlock(&piix4_mutex_sb800);
+
+	return retval;
+}
+
 static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
@@ -535,6 +579,11 @@ static const struct i2c_algorithm smbus_algorithm = {
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
@@ -610,6 +659,42 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	return 0;
 }
 
+static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
+{
+	unsigned short port;
+	int retval;
+	struct i2c_piix4_adapdata *adapdata;
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
+		adapdata->port = port;
+	}
+
+	return retval;
+
+error:
+	dev_err(&dev->dev, "Error setting up SB800 adapters. "
+		"Unregistering all adapters!\n");
+	for (port--; port >= 0; port--) {
+		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
+		if (adapdata->smba) {
+			i2c_del_adapter(piix4_main_adapters[port]);
+			kfree(adapdata);
+			kfree(piix4_main_adapters[port]);
+			piix4_main_adapters[port] = NULL;
+		}
+	}
+
+	return retval;
+}
+
 static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned short smba_idx = 0xcd6;
@@ -629,19 +714,26 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
+		if (retval < 0)
+			return retval;
+
+		/* Try to register multiplexed main SMBus adapter,
+		 * give up if we can't */
+		retval = piix4_add_adapters_sb800(dev, retval);
 	} else {
 		retval = piix4_setup(dev, id);
+		if (retval < 0)
+			return retval;
+
+		/* Try to register main SMBus adapter, give up if we can't */
+		retval = piix4_add_adapter(dev, retval,
+					   &piix4_main_adapters[0]);
 	}
 
 	/* If no main SMBus found, give up */
 	if (retval < 0)
 		return retval;
 
-	/* Try to register main SMBus adapter, give up if we can't */
-	retval = piix4_add_adapter(dev, retval, &piix4_main_adapters[0]);
-	if (retval < 0)
-		return retval;
-
 	/* Check for auxiliary SMBus on some AMD chipsets */
 	retval = -ENODEV;
 
-- 
1.9.1
