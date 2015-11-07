From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v3 5/5] i2c-piix4: Add adapter port name support for SB800 chipset
Date: Sat,  7 Nov 2015 12:35:26 +0100
Message-ID: <1446896126-13369-6-git-send-email-fetzer.ch@gmail.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35674 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbbKGLfx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 Nov 2015 06:35:53 -0500
Received: by wicll6 with SMTP id ll6so44348861wic.0
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2015 03:35:51 -0800 (PST)
In-Reply-To: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

This patch adds support for port names for the SB800 chipset.
Since the chipset supports a multiplexed main SMBus controller, adding
the channel name to the adapter name is necessary to differentiate the
ports better (for example in sensors output).

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-piix4.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 4beaa3d..47a221d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -135,6 +135,10 @@ static const struct dmi_system_id piix4_dmi_ibm[] = {
 /* SB800 globals */
 DEFINE_MUTEX(piix4_mutex_sb800);
 static bool piix4_smb_idx_sb800;
+static const char *piix4_main_port_names_sb800[PIIX4_MAX_ADAPTERS] = {
+	"SDA0", "SDA2", "SDA3", "SDA4"
+};
+static const char *piix4_aux_port_name_sb800 = "SDA1";
 
 struct i2c_piix4_adapdata {
 	unsigned short smba;
@@ -617,7 +621,7 @@ static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
-			     struct i2c_adapter **padap)
+			     const char *name, struct i2c_adapter **padap)
 {
 	struct i2c_adapter *adap;
 	struct i2c_piix4_adapdata *adapdata;
@@ -646,7 +650,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	adap->dev.parent = &dev->dev;
 
 	snprintf(adap->name, sizeof(adap->name),
-		"SMBus PIIX4 adapter at %04x", smba);
+		"SMBus PIIX4 adapter %s at %04x", name, smba);
 
 	i2c_set_adapdata(adap, adapdata);
 
@@ -671,6 +675,7 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba)
 
 	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
 		retval = piix4_add_adapter(dev, smba,
+					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
 		if (retval < 0)
 			goto error;
@@ -731,7 +736,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return retval;
 
 		/* Try to register main SMBus adapter, give up if we can't */
-		retval = piix4_add_adapter(dev, retval,
+		retval = piix4_add_adapter(dev, retval, "main",
 					   &piix4_main_adapters[0]);
 	}
 
@@ -760,7 +765,8 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
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
