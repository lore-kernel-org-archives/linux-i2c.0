From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] I2C-PIIX4: Use common error handling code in piix4_probe()
Date: Wed, 25 Oct 2017 13:40:55 +0200
Message-ID: <be36ce5f-9e75-6c05-86a2-ea8368f09dc1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Oct 2017 13:30:18 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-piix4.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 0ecdb47a23ab..22cc56e9f304 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -780,20 +780,16 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 		/* base address location etc changed in SB800 */
 		retval = piix4_setup_sb800(dev, id, 0);
-		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
-			return retval;
-		}
+		if (retval < 0)
+			goto release_region;
 
 		/*
 		 * Try to register multiplexed main SMBus adapter,
 		 * give up if we can't
 		 */
 		retval = piix4_add_adapters_sb800(dev, retval);
-		if (retval < 0) {
-			release_region(SB800_PIIX4_SMB_IDX, 2);
-			return retval;
-		}
+		if (retval < 0)
+			goto release_region;
 	} else {
 		retval = piix4_setup(dev, id);
 		if (retval < 0)
@@ -833,6 +829,10 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	}
 
 	return 0;
+
+release_region:
+	release_region(SB800_PIIX4_SMB_IDX, 2);
+	return retval;
 }
 
 static void piix4_adap_remove(struct i2c_adapter *adap)
-- 
2.14.3
