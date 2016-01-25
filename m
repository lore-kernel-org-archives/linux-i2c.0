From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] i2c-piix4: Fully initialize SB800 before it is registered
Date: Mon, 25 Jan 2016 12:17:07 +0100
Message-ID: <20160125121707.7109c0d3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59079 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755674AbcAYLRL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 25 Jan 2016 06:17:11 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Christian Fetzer <fetzer.ch@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

This closes a race window where I2C device drivers attempt to access
I2C buses which aren't fully initialized yet.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Christian Fetzer <fetzer.ch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-piix4.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- linux-4.5-rc0.orig/drivers/i2c/busses/i2c-piix4.c	2016-01-22 14:06:31.336751852 +0100
+++ linux-4.5-rc0/drivers/i2c/busses/i2c-piix4.c	2016-01-25 12:08:07.812116538 +0100
@@ -627,6 +627,7 @@ static struct i2c_adapter *piix4_main_ad
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
+			     bool sb800_main, unsigned short port,
 			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
@@ -641,7 +642,8 @@ static int piix4_add_adapter(struct pci_
 
 	adap->owner = THIS_MODULE;
 	adap->class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
-	adap->algo = &smbus_algorithm;
+	adap->algo = sb800_main ? &piix4_smbus_algorithm_sb800
+				: &smbus_algorithm;
 
 	adapdata = kzalloc(sizeof(*adapdata), GFP_KERNEL);
 	if (adapdata == NULL) {
@@ -651,6 +653,8 @@ static int piix4_add_adapter(struct pci_
 	}
 
 	adapdata->smba = smba;
+	adapdata->sb800_main = sb800_main;
+	adapdata->port = port;
 
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
@@ -680,17 +684,11 @@ static int piix4_add_adapters_sb800(stru
 	int retval;
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
-		retval = piix4_add_adapter(dev, smba,
+		retval = piix4_add_adapter(dev, smba, true, port,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
 			goto error;
-
-		piix4_main_adapters[port]->algo = &piix4_smbus_algorithm_sb800;
-
-		adapdata = i2c_get_adapdata(piix4_main_adapters[port]);
-		adapdata->sb800_main = true;
-		adapdata->port = port;
 	}
 
 	return retval;
@@ -748,7 +746,7 @@ static int piix4_probe(struct pci_dev *d
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval, "main",
+		retval = piix4_add_adapter(dev, retval, false, 0, "main",
 					   &piix4_main_adapters[0]);
 		if (retval < 0)
 			return retval;
@@ -775,7 +773,8 @@ static int piix4_probe(struct pci_dev *d
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, piix4_aux_port_name_sb800,
+		piix4_add_adapter(dev, retval, false, 0,
+				  piix4_aux_port_name_sb800,
 				  &piix4_aux_adapter);
 	}
 


-- 
Jean Delvare
SUSE L3 Support
