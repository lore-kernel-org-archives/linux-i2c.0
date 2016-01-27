From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c-piix4: Better bus names
Date: Wed, 27 Jan 2016 14:40:33 +0100
Message-ID: <20160127144033.749e3652@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40089 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792AbcA0Nkg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 27 Jan 2016 08:40:36 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Christian Fetzer <fetzer.ch@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

The I2C bus names are supposed to be stable as they can be used by
userspace to uniquely identify a specific I2C bus. So restore the
original names for all legacy (pre-SB800) devices.

For SB800 devices and later, improve the names. "SDA" refers to the
serial data pin of each SMBus port, it's an implementation detail the
user doesn't need to know. Use "port" instead, which is easier to
understand.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Christian Fetzer <fetzer.ch@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-piix4.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-26 18:18:45.324952783 +0100
+++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-26 18:25:38.487310421 +0100
@@ -139,9 +139,9 @@ static const struct dmi_system_id piix4_
 /* SB800 globals */
 static DEFINE_MUTEX(piix4_mutex_sb800);
 static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
-	"SDA0", "SDA2", "SDA3", "SDA4"
+	" port 0", " port 2", " port 3", " port 4"
 };
-static const char *piix4_aux_port_name_sb800 = "SDA1";
+static const char *piix4_aux_port_name_sb800 = " port 1";
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
@@ -660,7 +660,7 @@ static int piix4_add_adapter(struct pci_
 	adap->dev.parent = &dev->dev;
 
 	snprintf(adap->name, sizeof(adap->name),
-		"SMBus PIIX4 adapter %s at %04x", name, smba);
+		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
 	i2c_set_adapdata(adap, adapdata);
 
@@ -712,11 +712,14 @@ error:
 static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
+	bool is_sb800 = false;
 
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
 	    dev->vendor == PCI_VENDOR_ID_AMD) {
+		is_sb800 = true;
+
 		if (!request_region(SB800_PIIX4_SMB_IDX, 2, "smba_idx")) {
 			dev_err(&dev->dev,
 			"SMBus base address index region 0x%x already in use!\n",
@@ -746,7 +749,7 @@ static int piix4_probe(struct pci_dev *d
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, false, 0, "main",
+		retval = piix4_add_adapter(dev, retval, false, 0, "",
 					   &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
@@ -774,7 +777,7 @@ static int piix4_probe(struct pci_dev *d
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
 		piix4_add_adapter(dev, retval, false, 0,
-				  piix4_aux_port_name_sb800,
+				  is_sb800 ? piix4_aux_port_name_sb800 : "",
 				  &piix4_aux_adapter);
 	}
 


-- 
Jean Delvare
SUSE L3 Support
