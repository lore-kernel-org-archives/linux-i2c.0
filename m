From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 14/21] i2c: mxs: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 16:53:23 +0200
Message-ID: <20180514145330.4857-15-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514145330.4857-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

Because it looks neater.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/busses/i2c-mxs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index e617bd600794..f62ae3d42232 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -180,9 +180,10 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 	struct dma_async_tx_descriptor *desc;
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
 
+	i2c->addr_data = i2c_8bit_addr_from_msg(msg);
+
 	if (msg->flags & I2C_M_RD) {
 		i2c->dma_read = true;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_READ;
 
 		/*
 		 * SELECT command.
@@ -240,7 +241,6 @@ static int mxs_i2c_dma_setup_xfer(struct i2c_adapter *adap,
 		}
 	} else {
 		i2c->dma_read = false;
-		i2c->addr_data = (msg->addr << 1) | I2C_SMBUS_WRITE;
 
 		/*
 		 * WRITE command.
@@ -371,7 +371,7 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 			struct i2c_msg *msg, uint32_t flags)
 {
 	struct mxs_i2c_dev *i2c = i2c_get_adapdata(adap);
-	uint32_t addr_data = msg->addr << 1;
+	uint32_t addr_data = i2c_8bit_addr_from_msg(msg);
 	uint32_t data = 0;
 	int i, ret, xlen = 0, xmit = 0;
 	uint32_t start;
@@ -411,8 +411,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 */
 		BUG_ON(msg->len > 4);
 
-		addr_data |= I2C_SMBUS_READ;
-
 		/* SELECT command. */
 		mxs_i2c_pio_trigger_write_cmd(i2c, MXS_CMD_I2C_SELECT,
 					      addr_data);
@@ -450,7 +448,6 @@ static int mxs_i2c_pio_setup_xfer(struct i2c_adapter *adap,
 		 * fast enough. It is possible to transfer arbitrary amount
 		 * of data using PIO write.
 		 */
-		addr_data |= I2C_SMBUS_WRITE;
 
 		/*
 		 * The LSB of data buffer is the first byte blasted across
-- 
2.11.0
