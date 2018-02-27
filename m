From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 2/3] i2c: xlp9xx: Handle NACK on DATA properly
Date: Tue, 27 Feb 2018 13:26:19 +0000
Message-ID: <1519737980-27997-2-git-send-email-george.cherian@cavium.com>
References: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519737980-27997-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>
List-Id: linux-i2c@vger.kernel.org

In case we receive NACK on DATA we shouldn't be resetting the controller,
rather we should issue STOP command. This will terminate the current
transaction and -EIO is returned.

While at that handle the SMBus Quick Command properly.
We shouldn't be setting the XLP9XX_I2C_CMD_READ/WRITE for such
transactions.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 42dd1fa..eb8913e 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -352,7 +352,9 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 
 	/* set cmd reg */
 	cmd = XLP9XX_I2C_CMD_START;
-	cmd |= (priv->msg_read ? XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRITE);
+	if (msg->len)
+		cmd |= (priv->msg_read ?
+			XLP9XX_I2C_CMD_READ : XLP9XX_I2C_CMD_WRITE);
 	if (last_msg)
 		cmd |= XLP9XX_I2C_CMD_STOP;
 
@@ -361,12 +363,12 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
 	timeleft = msecs_to_jiffies(XLP9XX_I2C_TIMEOUT_MS);
 	timeleft = wait_for_completion_timeout(&priv->msg_complete, timeleft);
 
-	if (priv->msg_err) {
+	if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR) {
 		dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
-		if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
-			xlp9xx_i2c_init(priv);
-		return (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) ?
-			-ENXIO : -EIO;
+		xlp9xx_write_i2c_reg(priv, XLP9XX_I2C_CMD, XLP9XX_I2C_CMD_STOP);
+		return -EIO;
+	} else if (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) {
+		return -ENXIO;
 	}
 
 	if (timeleft == 0) {
-- 
2.1.4
