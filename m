From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 20/24] staging/go7007: fix dangling pointers
Date: Sat, 20 Mar 2010 15:13:01 +0100
Message-ID: <1269094385-16114-21-git-send-email-w.sang@pengutronix.de>
References: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1269094385-16114-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org
List-Id: linux-i2c@vger.kernel.org

Fix I2C-drivers which missed setting clientdata to NULL before freeing the
structure it points to. Also fix drivers which do this _after_ the structure
was freed already.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

Found using coccinelle, then reviewed. Full patchset is available via
kernel-janitors, linux-i2c, and LKML.
---
 drivers/staging/go7007/wis-saa7113.c |    1 +
 drivers/staging/go7007/wis-saa7115.c |    1 +
 drivers/staging/go7007/wis-tw9903.c  |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/go7007/wis-saa7113.c b/drivers/staging/go7007/wis-saa7113.c
index d196e16..26365af 100644
--- a/drivers/staging/go7007/wis-saa7113.c
+++ b/drivers/staging/go7007/wis-saa7113.c
@@ -288,6 +288,7 @@ static int wis_saa7113_probe(struct i2c_client *client,
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR
 			"wis-saa7113: error initializing SAA7113\n");
+		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
diff --git a/drivers/staging/go7007/wis-saa7115.c b/drivers/staging/go7007/wis-saa7115.c
index 0f2b4a0..0d71f6a 100644
--- a/drivers/staging/go7007/wis-saa7115.c
+++ b/drivers/staging/go7007/wis-saa7115.c
@@ -421,6 +421,7 @@ static int wis_saa7115_probe(struct i2c_client *client,
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR
 			"wis-saa7115: error initializing SAA7115\n");
+		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
diff --git a/drivers/staging/go7007/wis-tw9903.c b/drivers/staging/go7007/wis-tw9903.c
index f97e2be..c21b88a 100644
--- a/drivers/staging/go7007/wis-tw9903.c
+++ b/drivers/staging/go7007/wis-tw9903.c
@@ -293,6 +293,7 @@ static int wis_tw9903_probe(struct i2c_client *client,
 
 	if (write_regs(client, initial_registers) < 0) {
 		printk(KERN_ERR "wis-tw9903: error initializing TW9903\n");
+		i2c_set_clientdata(client, NULL);
 		kfree(dec);
 		return -ENODEV;
 	}
-- 
1.7.0
