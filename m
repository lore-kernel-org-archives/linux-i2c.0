From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v5 1/3] i2c-piix4: Convert piix4_main_adapter to array
Date: Thu, 19 Nov 2015 20:13:47 +0100
Message-ID: <1447960429-19256-2-git-send-email-fetzer.ch@gmail.com>
References: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37895 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161230AbbKSTN5 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 14:13:57 -0500
Received: by wmec201 with SMTP id c201so131659322wme.1
        for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2015 11:13:56 -0800 (PST)
In-Reply-To: <1447960429-19256-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, galandilias@gmail.com, fetzer.ch@gmail.com

The SB800 chipset supports a multiplexed main SMBus controller with
four ports. Therefore the static variable piix4_main_adapter is
converted into a piix4_main_adapters array that can hold one
i2c_adapter for each multiplexed port.

The auxiliary adapter remains unchanged since it represents the second
(not multiplexed) SMBus controller on the SB800 chipset.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-piix4.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 630bce6..9c32eb1 100644
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
 
@@ -674,9 +677,13 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	if (piix4_main_adapter) {
-		piix4_adap_remove(piix4_main_adapter);
-		piix4_main_adapter = NULL;
+	int port = PIIX4_MAX_ADAPTERS;
+
+	while (--port >= 0) {
+		if (piix4_main_adapters[port]) {
+			piix4_adap_remove(piix4_main_adapters[port]);
+			piix4_main_adapters[port] = NULL;
+		}
 	}
 
 	if (piix4_aux_adapter) {
-- 
1.9.1
