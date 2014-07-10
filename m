From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 11/16] i2c: i2c-rcar: Drop class based scanning to improve bootup time
Date: Thu, 10 Jul 2014 13:46:31 +0200
Message-ID: <1404992799-3705-12-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This driver has been flagged to drop class based instantiation. The removal
improves boot-up time and is unneeded for embedded controllers. Users have been
warned to switch for some time now, so we can actually do the removal. Keep the
DEPRECATED flag, so the core can inform users that the behaviour finally
changed now. After another transition period, this flag can go, too.
While we are here, remove the indentation for the array setup because
such things always break after some time.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-rcar.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 899405923678..f3c7139dfa25 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -541,13 +541,13 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
 
-	adap			= &priv->adap;
-	adap->nr		= pdev->id;
-	adap->algo		= &rcar_i2c_algo;
-	adap->class		= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
-	adap->retries		= 3;
-	adap->dev.parent	= dev;
-	adap->dev.of_node	= dev->of_node;
+	adap = &priv->adap;
+	adap->nr = pdev->id;
+	adap->algo = &rcar_i2c_algo;
+	adap->class = I2C_CLASS_DEPRECATED;
+	adap->retries = 3;
+	adap->dev.parent = dev;
+	adap->dev.of_node = dev->of_node;
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
-- 
2.0.0
