From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 2/5] i2c-piix4: Convert piix4_main_adapter to array
Date: Sun,  1 Nov 2015 17:32:06 +0100
Message-ID: <1446395529-9987-3-git-send-email-fetzer.ch@gmail.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f193.google.com ([209.85.212.193]:36619 "EHLO
	mail-wi0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKAQcz (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:32:55 -0500
Received: by wibvt6 with SMTP id vt6so7813079wib.3
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:32:54 -0800 (PST)
In-Reply-To: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

The SB800 chipset supports a multiplexed main SMBus controller with
four ports. Therefore the static variable piix4_main_adapter is
converted into a piix4_main_adapters array that can hold one
i2c_adapter for each multiplexed port.

The auxiliary adapter remains unchanged since it represents the second
(not multiplexed) SMBus controller on the SB800 chipset.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 97d2165..35eeb0d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -75,6 +75,9 @@
 #define PIIX4_WORD_DATA		0x0C
 #define PIIX4_BLOCK_DATA	0x14
 
+/* Multi-port constants */
+#define PIIX4_MAX_ADAPTERS 4
+
 /* insmod parameters */
 
 /* If force is set to anything different from 0, we forcibly enable the
@@ -561,7 +564,7 @@ static const struct pci_device_id piix4_ids[] = {
 
 MODULE_DEVICE_TABLE (pci, piix4_ids);
 
-static struct i2c_adapter *piix4_main_adapter;
+static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
@@ -629,7 +632,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return retval;
 
 	/* Try to register main SMBus adapter, give up if we can't */
-	retval = piix4_add_adapter(dev, retval, &piix4_main_adapter);
+	retval = piix4_add_adapter(dev, retval, &piix4_main_adapters[0]);
 	if (retval < 0)
 		return retval;
 
@@ -675,9 +678,14 @@ static void piix4_adap_remove(struct i2c_adapter *adap, int free_smba)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	if (piix4_main_adapter) {
-		piix4_adap_remove(piix4_main_adapter, 1);
-		piix4_main_adapter = NULL;
+	int port;
+
+	for (port = PIIX4_MAX_ADAPTERS - 1; port >= 0; port--) {
+		if (piix4_main_adapters[port]) {
+			piix4_adap_remove(piix4_main_adapters[port],
+					  port == 0);
+			piix4_main_adapters[port] = NULL;
+		}
 	}
 
 	if (piix4_aux_adapter) {
-- 
1.9.1
