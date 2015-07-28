From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] [trivial] i2c: Fix typo in i2c-bfin-twi.c
Date: Tue, 28 Jul 2015 20:11:23 +0900
Message-ID: <1438081883-23883-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, sonic.zhang@analog.com, wsa@the-dreams.de, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, bryan.wu@analog.com
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: linux-i2c@vger.kernel.org

This patch fix some typos found in a printk message and
MODULE_DESCRIPTION.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/i2c/busses/i2c-bfin-twi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index af162b4..025686d 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -692,7 +692,7 @@ static int i2c_bfin_twi_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iface);
 
-	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Contoller, "
+	dev_info(&pdev->dev, "Blackfin BF5xx on-chip I2C TWI Controller, "
 		"regs_base@%p\n", iface->regs_base);
 
 	return 0;
@@ -735,6 +735,6 @@ subsys_initcall(i2c_bfin_twi_init);
 module_exit(i2c_bfin_twi_exit);
 
 MODULE_AUTHOR("Bryan Wu, Sonic Zhang");
-MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Contoller Driver");
+MODULE_DESCRIPTION("Blackfin BF5xx on-chip I2C TWI Controller Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:i2c-bfin-twi");
-- 
2.5.0
