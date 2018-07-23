From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 02/12] i2c: designware-master: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:06 +0200
Message-ID: <20180723202617.15230-3-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-designware-master.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index fc7c255c80af..a1717bff06a8 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -274,13 +274,6 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 			break;
 		}
 
-		if (msgs[dev->msg_write_idx].len == 0) {
-			dev_err(dev->dev,
-				"%s: invalid message length\n", __func__);
-			dev->msg_err = -EINVAL;
-			break;
-		}
-
 		if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
 			/* new i2c_msg */
 			buf = msgs[dev->msg_write_idx].buf;
@@ -523,6 +516,10 @@ static const struct i2c_algorithm i2c_dw_algo = {
 	.functionality = i2c_dw_func,
 };
 
+static const struct i2c_adapter_quirks i2c_dw_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 {
 	u32 stat;
@@ -718,6 +715,7 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 		 "Synopsys DesignWare I2C adapter");
 	adap->retries = 3;
 	adap->algo = &i2c_dw_algo;
+	adap->quirks = &i2c_dw_quirks;
 	adap->dev.parent = dev->dev;
 	i2c_set_adapdata(adap, dev);
 
-- 
2.11.0
