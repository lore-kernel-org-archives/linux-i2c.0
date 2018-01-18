From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 4/4] i2c: xlp9xx: Check for Bus state after every transfer
Date: Thu, 18 Jan 2018 05:39:24 +0000
Message-ID: <1516253964-4615-4-git-send-email-george.cherian@cavium.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>
List-Id: linux-i2c@vger.kernel.org

I2C bus enters the STOP condition after the DATA_DONE interrupt is raised.
Essentially the driver should be checking the bus state before sending
the next transaction. In case the next transaction is initiated while the
bus is busy, the prior transactions stop condition is not acheived.
Add the check to make sure the bus is not busy before next transaction.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 1f6d780..fa9d5ee 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 
 #define XLP9XX_I2C_DIV			0x0
 #define XLP9XX_I2C_CTRL			0x1
@@ -36,6 +37,8 @@
 #define XLP9XX_I2C_TIMEOUT		0X10
 #define XLP9XX_I2C_GENCALLADDR		0x11
 
+#define XLP9XX_I2C_STATUS_BUSY		BIT(0)
+
 #define XLP9XX_I2C_CMD_START		BIT(7)
 #define XLP9XX_I2C_CMD_STOP		BIT(6)
 #define XLP9XX_I2C_CMD_READ		BIT(5)
@@ -71,6 +74,7 @@
 #define XLP9XX_I2C_HIGH_FREQ		400000
 #define XLP9XX_I2C_FIFO_SIZE		0x80U
 #define XLP9XX_I2C_TIMEOUT_MS		1000
+#define XLP9XX_I2C_BUSY_TIMEOUT		50
 
 #define XLP9XX_I2C_FIFO_WCNT_MASK	0xff
 #define XLP9XX_I2C_STATUS_ERRMASK	(XLP9XX_I2C_INTEN_ARLOST | \
@@ -264,7 +268,8 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 			       int last_msg)
 {
 	unsigned long timeleft;
-	u32 intr_mask, cmd, val, len;
+	u32 intr_mask, cmd, val, len, status;
+	u32 busy_timeout = XLP9XX_I2C_BUSY_TIMEOUT;
 
 	priv->msg_buf = msg->buf;
 	priv->msg_buf_remaining = priv->msg_len = msg->len;
@@ -351,6 +356,19 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 		return -ETIMEDOUT;
 	}
 
+	while (last_msg && busy_timeout) {
+		status = xlp9xx_read_i2c_reg(priv, XLP9XX_I2C_STATUS);
+		if ((status & XLP9XX_I2C_STATUS_BUSY) == 0)
+			break;
+
+		busy_timeout--;
+		udelay(1);
+	}
+
+	if (!busy_timeout) {
+		dev_dbg(priv->dev, "i2c bus busy for too long after transfer\n");
+		return -EIO;
+	}
 	/* update msg->len with actual received length */
 	if (msg->flags & I2C_M_RECV_LEN)
 		msg->len = priv->msg_len;
-- 
2.1.4
