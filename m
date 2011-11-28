From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH v4] OMAP: I2C: Fix the interrupt clearing in OMAP4
Date: Mon, 28 Nov 2011 20:10:12 +0530
Message-ID: <1322491212-8657-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, khilman@ti.com, ben-linux@fluff.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Vikram Pandita <vikram.pandita@ti.com>
List-Id: linux-i2c@vger.kernel.org

On OMAP4 we were writing 1 to  IRQENABLE_CLR which cleared only
the arbitration lost interrupt however for other ips (not OMAP_I2C_IP_VERSION_2)
we clear all the interrupts at idle. The patch intends to fix the same by writing 0 to the
IE register.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a43d002..abadc13 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -297,10 +297,8 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = dev->dev->platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (pdata->rev == OMAP_I2C_IP_VERSION_2)
-		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
-	else
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+
+	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
 
 	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
-- 
1.7.1

