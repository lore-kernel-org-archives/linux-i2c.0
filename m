From: Christian Fetzer <fetzer.ch@gmail.com>
Subject: [PATCH v3 1/5] i2c-piix4: Optionally release smba in piix4_adap_remove
Date: Sat,  7 Nov 2015 12:35:22 +0100
Message-ID: <1446896126-13369-2-git-send-email-fetzer.ch@gmail.com>
References: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37826 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbbKGLfk (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sat, 7 Nov 2015 06:35:40 -0500
Received: by wmll128 with SMTP id l128so59999313wml.0
        for <linux-i2c@vger.kernel.org>; Sat, 07 Nov 2015 03:35:39 -0800 (PST)
In-Reply-To: <1446896126-13369-1-git-send-email-fetzer.ch@gmail.com>
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
index 630bce6..e78b982 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -660,13 +660,14 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	return 0;
 }
 
-static void piix4_adap_remove(struct i2c_adapter *adap)
+static void piix4_adap_remove(struct i2c_adapter *adap, bool free_smba)
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
+		piix4_adap_remove(piix4_main_adapter, true);
 		piix4_main_adapter = NULL;
 	}
 
 	if (piix4_aux_adapter) {
-		piix4_adap_remove(piix4_aux_adapter);
+		piix4_adap_remove(piix4_aux_adapter, true);
 		piix4_aux_adapter = NULL;
 	}
 }
-- 
1.9.1
