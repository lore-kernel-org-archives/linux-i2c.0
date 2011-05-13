From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 13/14] i2c/i2c-nomadik: break out single messsage transmission
Date: Fri, 13 May 2011 12:31:01 +0200
Message-ID: <1305282661-20932-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reduce code size in the message transfer function by factoring out
a single-message transfer function.

Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   80 +++++++++++++++++++++++---------------
 1 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index fa7b106..0c731ca 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -525,6 +525,51 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 }
 
 /**
+ * nmk_i2c_xfer_one() - transmit a single I2C message
+ * @dev: device with a message encoded into it
+ * @flags: message flags
+ */
+static int nmk_i2c_xfer_one(struct nmk_i2c_dev *dev, u16 flags)
+{
+	int status;
+
+	if (flags & I2C_M_RD) {
+		/* read operation */
+		dev->cli.operation = I2C_READ;
+		status = read_i2c(dev);
+	} else {
+		/* write operation */
+		dev->cli.operation = I2C_WRITE;
+		status = write_i2c(dev);
+	}
+
+	if (status || (dev->result)) {
+		u32 i2c_sr;
+		u32 cause;
+
+		i2c_sr = readl(dev->virtbase + I2C_SR);
+		/*
+		 * Check if the controller I2C operation status
+		 * is set to ABORT(11b).
+		 */
+		if (((i2c_sr >> 2) & 0x3) == 0x3) {
+			/* get the abort cause */
+			cause =	(i2c_sr >> 4) & 0x7;
+			dev_err(&dev->pdev->dev, "%s\n", cause
+				>= ARRAY_SIZE(abort_causes) ?
+				"unknown reason" :
+				abort_causes[cause]);
+		}
+
+		(void) init_hw(dev);
+
+		status = status ? status : dev->result;
+	}
+
+	return status;
+}
+
+/**
  * nmk_i2c_xfer() - I2C transfer function used by kernel framework
  * @i2c_adap: Adapter pointer to the controller
  * @msgs: Pointer to data to be written.
@@ -576,9 +621,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 {
 	int status;
 	int i;
-	u32 cause;
 	struct nmk_i2c_dev *dev = i2c_get_adapdata(i2c_adap);
-	u32 i2c_sr;
 	int j;
 
 	dev->busy = true;
@@ -593,6 +636,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (status)
 		goto out;
 
+	/* Attempt three times to send the message queue */
 	for (j = 0; j < 3; j++) {
 		/* setup the i2c controller */
 		setup_i2c_controller(dev);
@@ -611,37 +655,9 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			dev->stop = (i < (num_msgs - 1)) ? 0 : 1;
 			dev->result = 0;
 
-			if (msgs[i].flags & I2C_M_RD) {
-				/* it is a read operation */
-				dev->cli.operation = I2C_READ;
-				status = read_i2c(dev);
-			} else {
-				/* write operation */
-				dev->cli.operation = I2C_WRITE;
-				status = write_i2c(dev);
-			}
-			if (status || (dev->result)) {
-				i2c_sr = readl(dev->virtbase + I2C_SR);
-				/*
-				 * Check if the controller I2C operation status
-				 * is set to ABORT(11b).
-				 */
-				if (((i2c_sr >> 2) & 0x3) == 0x3) {
-					/* get the abort cause */
-					cause =	(i2c_sr >> 4)
-						& 0x7;
-					dev_err(&dev->pdev->dev, "%s\n", cause
-						>= ARRAY_SIZE(abort_causes) ?
-						"unknown reason" :
-						abort_causes[cause]);
-				}
-
-				(void) init_hw(dev);
-
-				status = status ? status : dev->result;
-
+			status = nmk_i2c_xfer_one(dev, msgs[i].flags);
+			if (status != 0)
 				break;
-			}
 		}
 		if (status == 0)
 			break;
-- 
1.7.5.1
