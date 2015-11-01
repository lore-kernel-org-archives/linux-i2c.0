From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 5/5] i2c-piix4: Add adapter port name support for SB800 chipset
Date: Sun,  1 Nov 2015 17:32:09 +0100
Message-ID: <1446395529-9987-6-git-send-email-fetzer.ch@gmail.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35548 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKAQvL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:51:11 -0500
Received: by wmll128 with SMTP id l128so5985396wml.2
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:51:10 -0800 (PST)
In-Reply-To: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

This patch adds support for port names for the SB800 chipset.
Since the chipset supports a multiplexed main SMBus controller, adding
the channel name to the adapter name is necessary to differentiate the
ports better (for example in sensors output).

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 54f8af5..18ea5d7 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -132,6 +132,10 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 /* SB800 globals */
 DEFINE_MUTEX(piix4_mutex_sb800);
 static unsigned short piix4_smb_idx_sb800;
+static const char *piix4_main_port_names_sb800[4] = {
+	"SDA0", "SDA2", "SDA3", "SDA4"
+};
+static const char *piix4_aux_port_name_sb800 = "SDA1";
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
@@ -613,7 +617,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     struct i2c_adapter **padap)
+			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
 	struct i2c_piix4_adapdata *adapdata;
@@ -642,7 +646,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adap->dev.parent = &dev->dev;
 
 	snprintf(adap->name, sizeof(adap->name),
-		"SMBus PIIX4 adapter at %04x", smba);
+		"SMBus PIIX4 adapter %s at %04x", name, smba);
 
 	i2c_set_adapdata(adap, adapdata);
 
@@ -667,6 +671,7 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
 		retval = piix4_add_adapter(dev, smba,
+					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
 			goto error;
@@ -726,7 +731,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval,
+		retval = piix4_add_adapter(dev, retval, "",
 					   &piix4_main_adapters[0]);
 	}
 
@@ -755,7 +760,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-		piix4_add_adapter(dev, retval, &piix4_aux_adapter);
+		piix4_add_adapter(dev, retval, piix4_aux_port_name_sb800,
+				  &piix4_aux_adapter);
 	}
 
 	return 0;
-- 
1.9.1
