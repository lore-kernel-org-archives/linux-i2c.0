From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 12/17] i2c: i2c-rcar: deprecate class based instantiation
Date: Mon, 10 Feb 2014 11:04:06 +0100
Message-ID: <1392026654-5343-13-git-send-email-wsa@the-dreams.de>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Warn users that class based instantiation is going away soon in favour
of more robust probing and faster bootup times.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

This patch is a suggestion. Looking for an ack by someone who actually uses
the driver.

 drivers/i2c/busses/i2c-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2c2fd7c..a4951de 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -691,7 +691,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	adap			= &priv->adap;
 	adap->nr		= pdev->id;
 	adap->algo		= &rcar_i2c_algo;
-	adap->class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->class		= I2C_CLASS_HWMON | I2C_CLASS_SPD | I2C_CLASS_DEPRECATED;
 	adap->retries		= 3;
 	adap->dev.parent	= dev;
 	adap->dev.of_node	= dev->of_node;
-- 
1.8.5.1
