From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/7] i2c: pca-platform: fix broken email address
Date: Mon, 20 Apr 2015 15:51:40 +0200
Message-ID: <1429537917-7433-3-git-send-email-wsa@the-dreams.de>
References: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

My Pengutronix address is not valid anymore, redirect people to the Pengutronix
kernel team.

Reported-by: Harald Geyer <harald@ccbib.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
These patches shall go via the individual subsystem trees.

 drivers/i2c/busses/i2c-pca-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 6336f02ec56682..3bd2e7d06e4bbe 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -285,6 +285,6 @@ static struct platform_driver i2c_pca_pf_driver = {
 
 module_platform_driver(i2c_pca_pf_driver);
 
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("I2C-PCA9564/PCA9665 platform driver");
 MODULE_LICENSE("GPL");
-- 
2.1.4
