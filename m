From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 05/12] i2c: pmcmsp: use core to detect 'no zero length' quirk
Date: Mon, 23 Jul 2018 22:26:09 +0200
Message-ID: <20180723202617.15230-6-wsa+renesas@sang-engineering.com>
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

 drivers/i2c/busses/i2c-pmcmsp.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index dae8ac618a52..0829cb696d9d 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -444,16 +444,6 @@ static enum pmcmsptwi_xfer_result pmcmsptwi_xfer_cmd(
 {
 	enum pmcmsptwi_xfer_result retval;
 
-	if ((cmd->type == MSP_TWI_CMD_WRITE && cmd->write_len == 0) ||
-	    (cmd->type == MSP_TWI_CMD_READ && cmd->read_len == 0) ||
-	    (cmd->type == MSP_TWI_CMD_WRITE_READ &&
-	    (cmd->read_len == 0 || cmd->write_len == 0))) {
-		dev_err(&pmcmsptwi_adapter.dev,
-			"%s: Cannot transfer less than 1 byte\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	mutex_lock(&data->lock);
 	dev_dbg(&pmcmsptwi_adapter.dev,
 		"Setting address to 0x%04x\n", cmd->addr);
@@ -532,11 +522,6 @@ static int pmcmsptwi_master_xfer(struct i2c_adapter *adap,
 		cmd.write_data = msg->buf;
 	}
 
-	if (msg->len == 0) {
-		dev_err(&adap->dev, "Zero-byte messages unsupported\n");
-		return -EINVAL;
-	}
-
 	cmd.addr = msg->addr;
 
 	if (msg->flags & I2C_M_TEN) {
@@ -578,7 +563,7 @@ static u32 pmcmsptwi_i2c_func(struct i2c_adapter *adapter)
 }
 
 static const struct i2c_adapter_quirks pmcmsptwi_i2c_quirks = {
-	.flags = I2C_AQ_COMB_WRITE_THEN_READ,
+	.flags = I2C_AQ_COMB_WRITE_THEN_READ | I2C_AQ_NO_ZERO_LEN,
 	.max_write_len = MSP_MAX_BYTES_PER_RW,
 	.max_read_len = MSP_MAX_BYTES_PER_RW,
 	.max_comb_1st_msg_len = MSP_MAX_BYTES_PER_RW,
-- 
2.11.0
