From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 10/12] i2c: rcar: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:14 +0200
Message-ID: <20180723202617.15230-11-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

 drivers/i2c/busses/i2c-rcar.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 2688520110d1..791a4aa34fdd 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -796,14 +796,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < num; i++) {
-		/* This HW can't send STOP after address phase */
-		if (msgs[i].len == 0) {
-			ret = -EOPNOTSUPP;
-			goto out;
-		}
+	for (i = 0; i < num; i++)
 		rcar_i2c_request_dma(priv, msgs + i);
-	}
 
 	/* init first message */
 	priv->msg = msgs;
@@ -890,6 +884,10 @@ static const struct i2c_algorithm rcar_i2c_algo = {
 	.unreg_slave	= rcar_unreg_slave,
 };
 
+static const struct i2c_adapter_quirks rcar_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
@@ -943,6 +941,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	adap->dev.parent = dev;
 	adap->dev.of_node = dev->of_node;
 	adap->bus_recovery_info = &rcar_i2c_bri;
+	adap->quirks = &rcar_i2c_quirks;
 	i2c_set_adapdata(adap, priv);
 	strlcpy(adap->name, pdev->name, sizeof(adap->name));
 
-- 
2.11.0
