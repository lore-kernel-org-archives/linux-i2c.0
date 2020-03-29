From: Adam Honse <calcprogrammer1@gmail.com>
Subject: [PATCH] i2c: Detect secondary SMBus controller on AMD AM4 chipsets
Date: Sun, 29 Mar 2020 12:44:40 -0500
Message-ID: <20200329174440.19342-1-calcprogrammer1@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36144 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgC2RpL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sun, 29 Mar 2020 13:45:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id l23so15558443otf.3
        for <linux-i2c@vger.kernel.org>; Sun, 29 Mar 2020 10:45:09 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org
Cc: Adam Honse <calcprogrammer1@gmail.com>

The AMD X370 and other AM4 chipsets (A/B/X 3/4/5 parts) and Threadripper equivalents have a secondary SMBus controller at I/O port address 0x0B20.  This bus is used by several manufacturers to control motherboard RGB lighting via embedded controllers.  I have been using this bus in my OpenRGB project to control the Aura RGB on many motherboards and ASRock also uses this bus for their Polychrome RGB controller.

See this kernel bug report: https://bugzilla.kernel.org/show_bug.cgi?id=202587

Thanks,

Adam Honse (calcprogrammer1@gmail.com)

---
 drivers/i2c/busses/i2c-piix4.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 30ded6422e7b..6068364b84f6 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -981,6 +981,11 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		retval = piix4_setup_sb800(dev, id, 1);
 	}
 
+	if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+		retval = piix4_setup_sb800(dev, id, 1);
+	}
+
 	if (retval > 0) {
 		/* Try to add the aux adapter if it exists,
 		 * piix4_add_adapter will clean up if this fails */
-- 
2.25.1
