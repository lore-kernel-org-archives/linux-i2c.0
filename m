From: Federico Fuga <fuga@studiofuga.com>
Subject: [PATCH] i2c: mv64xxx: Implement I2C_M_RECV_LEN and I2C_FUNC_SMBUS_READ_BLOCK_DATA
Date: Sat, 18 Jan 2020 12:58:20 +0100
Message-ID: <20200118115820.9080-1-fuga@studiofuga.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:51905
        "EHLO egyptian.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727118AbgARL6r (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 18 Jan 2020 06:58:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
Cc: Federico Fuga <fuga@studiofuga.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

The i2c_mv64xxx driver doesn't implement the I2C_M_REC_LEN function
essential to allow blocks with variable length to be read from an i2c
 slave.
This is needed to implement the SMBus Read Block Data function.

This patch implements the function by changing the bytes_left and
msg len on the fly if the flag is specified.

It has been successfully tested on Allwinner A33 with a special
i2c chip that returns variable length blocks on reading.

Signed-off-by: Federico Fuga <fuga@studiofuga.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 67 +++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index a5a95ea5b81a..cff9cb20bcc9 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -128,6 +128,7 @@ struct mv64xxx_i2c_data {
 	u32			addr1;
 	u32			addr2;
 	u32			bytes_left;
+	u32         effective_length;
 	u32			byte_posn;
 	u32			send_stop;
 	u32			block;
@@ -333,7 +334,18 @@ static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
 {
 	drv_data->msg = drv_data->msgs;
 	drv_data->byte_posn = 0;
-	drv_data->bytes_left = drv_data->msg->len;
+
+    /* If we should retrieve the length from the buffer, make sure */
+	/* to read enough bytes to avoid sending the */
+	/* STOP bit after the read if the first byte */
+	if (drv_data->msg->flags & I2C_M_RECV_LEN) {
+		drv_data->effective_length = -1;
+		drv_data->bytes_left = 3;
+	} else {
+		drv_data->effective_length = drv_data->msg->len;
+		drv_data->bytes_left = drv_data->msg->len;
+	}
+
 	drv_data->aborting = 0;
 	drv_data->rc = 0;
 
@@ -342,6 +354,42 @@ static void mv64xxx_i2c_send_start(struct mv64xxx_i2c_data *drv_data)
 	       drv_data->reg_base + drv_data->reg_offsets.control);
 }
 
+static void
+mv64xxx_i2c_do_send_stop(struct mv64xxx_i2c_data *drv_data)
+{
+	drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
+	writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
+		drv_data->reg_base + drv_data->reg_offsets.control);
+	drv_data->block = 0;
+	if (drv_data->errata_delay)
+		udelay(5);
+
+	wake_up(&drv_data->waitq);
+}
+
+static void
+mv64xxx_i2c_do_read_data(struct mv64xxx_i2c_data *drv_data)
+{
+	u8 data;
+
+	data = readl(drv_data->reg_base + drv_data->reg_offsets.data);
+	drv_data->msg->buf[drv_data->byte_posn++] = data;
+
+	if (drv_data->effective_length == -1) {
+		/* length=0 should not be allowed, but is indeed possible.
+		 * To avoid locking the chip, we keep reading at least 2 bytes
+		 */
+		if (data < 1)
+			data = 1;
+		drv_data->effective_length = data+1;
+		drv_data->bytes_left = data+1;
+		drv_data->msg->len = data+1;
+	}
+
+	writel(drv_data->cntl_bits,
+		drv_data->reg_base + drv_data->reg_offsets.control);
+}
+
 static void
 mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 {
@@ -392,23 +440,13 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 		break;
 
 	case MV64XXX_I2C_ACTION_RCV_DATA:
-		drv_data->msg->buf[drv_data->byte_posn++] =
-			readl(drv_data->reg_base + drv_data->reg_offsets.data);
-		writel(drv_data->cntl_bits,
-			drv_data->reg_base + drv_data->reg_offsets.control);
+	    mv64xxx_i2c_do_read_data(drv_data);
 		break;
 
 	case MV64XXX_I2C_ACTION_RCV_DATA_STOP:
 		drv_data->msg->buf[drv_data->byte_posn++] =
 			readl(drv_data->reg_base + drv_data->reg_offsets.data);
-		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
-		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_STOP,
-			drv_data->reg_base + drv_data->reg_offsets.control);
-		drv_data->block = 0;
-		if (drv_data->errata_delay)
-			udelay(5);
-
-		wake_up(&drv_data->waitq);
+	    mv64xxx_i2c_do_send_stop(drv_data);
 		break;
 
 	case MV64XXX_I2C_ACTION_INVALID:
@@ -706,7 +744,8 @@ mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
 static u32
 mv64xxx_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR |
+		I2C_FUNC_SMBUS_READ_BLOCK_DATA | I2C_FUNC_SMBUS_EMUL;
 }
 
 static int
-- 
2.17.1
