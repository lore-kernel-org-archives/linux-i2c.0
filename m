From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 03/12] i2c: mxs: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:07 +0200
Message-ID: <20180723202617.15230-4-wsa+renesas@sang-engineering.com>
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

Only build tested.

 drivers/i2c/busses/i2c-mxs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index 642c58946d8d..7d79317a1046 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -567,9 +567,6 @@ static int mxs_i2c_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg,
 	dev_dbg(i2c->dev, "addr: 0x%04x, len: %d, flags: 0x%x, stop: %d\n",
 		msg->addr, msg->len, msg->flags, stop);
 
-	if (msg->len == 0)
-		return -EINVAL;
-
 	/*
 	 * The MX28 I2C IP block can only do PIO READ for transfer of to up
 	 * 4 bytes of length. The write transfer is not limited as it can use
@@ -683,6 +680,10 @@ static const struct i2c_algorithm mxs_i2c_algo = {
 	.functionality = mxs_i2c_func,
 };
 
+static const struct i2c_adapter_quirks mxs_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, uint32_t speed)
 {
 	/* The I2C block clock runs at 24MHz */
@@ -854,6 +855,7 @@ static int mxs_i2c_probe(struct platform_device *pdev)
 	strlcpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->algo = &mxs_i2c_algo;
+	adap->quirks = &mxs_i2c_quirks;
 	adap->dev.parent = dev;
 	adap->nr = pdev->id;
 	adap->dev.of_node = pdev->dev.of_node;
-- 
2.11.0
