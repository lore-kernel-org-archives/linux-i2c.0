From: Joe Perches <joe@perches.com>
Subject: [PATCH 08/16] i2c: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
Date: Sun, 28 Oct 2012 01:05:46 -0700
Message-ID: <3e4988b083a8b5d03a458aabc18042cedb3dbd8a.1351411047.git.joe@perches.com>
References: <cover.1351411047.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1351411047.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
and reducing object size is good.
Coalesce formats for easier grep.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/i2c/busses/i2c-piix4.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 8bbd6ec..f7216ed 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -204,9 +204,8 @@ static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
 			 */
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
 					      temp | 1);
-			dev_printk(KERN_NOTICE, &PIIX4_dev->dev,
-				"WARNING: SMBus interface has been "
-				"FORCEFULLY ENABLED!\n");
+			dev_notice(&PIIX4_dev->dev,
+				   "WARNING: SMBus interface has been FORCEFULLY ENABLED!\n");
 		} else {
 			dev_err(&PIIX4_dev->dev,
 				"Host SMBus controller not enabled!\n");
-- 
1.7.8.112.g3fd21
