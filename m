From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v2 1/5] i2c-piix4: Optionally release smba in piix4_adap_remove
Date: Sun,  1 Nov 2015 17:32:05 +0100
Message-ID: <1446395529-9987-2-git-send-email-fetzer.ch@gmail.com>
References: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33091 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbbKAQcv (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 1 Nov 2015 11:32:51 -0500
Received: by wijp11 with SMTP id p11so37912079wij.0
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2015 08:32:50 -0800 (PST)
In-Reply-To: <1446395529-9987-1-git-send-email-fetzer.ch@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, galandilias@gmail.com, Christian Fetzer <fetzer.ch@gmail.com>

This is in preparation to support the multiplexed SMBus main controller
in the SB800 chipset where the controller address is shared among
the four multiplexed ports. As such the address region should be
only freed for the first multiplexed adapter to avoid double free
warnings.

Signed-off-by: Christian Fetzer <fetzer.ch@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 630bce6..97d2165 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -660,13 +660,14 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void piix4_adap_remove(struct i2c_adapter *adap)
+static void piix4_adap_remove(struct i2c_adapter *adap, int free_smba)
 {
 	struct i2c_piix4_adapdata *adapdata = i2c_get_adapdata(adap);
 
 	if (adapdata->smba) {
 		i2c_del_adapter(adap);
-		release_region(adapdata->smba, SMBIOSIZE);
+		if (free_smba)
+			release_region(adapdata->smba, SMBIOSIZE);
 		kfree(adapdata);
 		kfree(adap);
 	}
@@ -675,12 +676,12 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 static void piix4_remove(struct pci_dev *dev)
 {
 	if (piix4_main_adapter) {
-		piix4_adap_remove(piix4_main_adapter);
+		piix4_adap_remove(piix4_main_adapter, 1);
 		piix4_main_adapter = NULL;
 	}
 
 	if (piix4_aux_adapter) {
-		piix4_adap_remove(piix4_aux_adapter);
+		piix4_adap_remove(piix4_aux_adapter, 1);
 		piix4_aux_adapter = NULL;
 	}
 }
-- 
1.9.1
