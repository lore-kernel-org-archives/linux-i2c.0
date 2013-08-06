From: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH] i2c-tiny-usb: do not use stack as URB transfer_buffer
Date: Tue, 06 Aug 2013 14:17:42 +0300
Message-ID: <20130806111742.25265.94046.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Till Harbaum <till-RcHadlBFbzVAfugRpC6u6w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Patch fixes i2c-tiny-usb not to use stack as URB transfer_buffer. URB buffers
need to be DMA-able, which stack is not.

Patch is only compile tested.

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Jussi Kivilinna <jussi.kivilinna-X3B1VOXEql0@public.gmane.org>
---
 drivers/i2c/busses/i2c-tiny-usb.c |   49 ++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 0510636..e7d3b75 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -54,12 +54,16 @@ static int usb_write(struct i2c_adapter *adapter, int cmd,
 
 static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 {
-	unsigned char status;
+	unsigned char *pstatus;
 	struct i2c_msg *pmsg;
-	int i;
+	int i, ret;
 
 	dev_dbg(&adapter->dev, "master xfer %d messages:\n", num);
 
+	pstatus = kmalloc(sizeof(*pstatus), GFP_KERNEL);
+	if (!pstatus)
+		return -ENOMEM;
+
 	for (i = 0 ; i < num ; i++) {
 		int cmd = CMD_I2C_IO;
 
@@ -84,7 +88,8 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				     pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure reading data\n");
-				return -EREMOTEIO;
+				ret = -EREMOTEIO;
+				goto out;
 			}
 		} else {
 			/* write data */
@@ -93,36 +98,50 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				      pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure writing data\n");
-				return -EREMOTEIO;
+				ret = -EREMOTEIO;
+				goto out;
 			}
 		}
 
 		/* read status */
-		if (usb_read(adapter, CMD_GET_STATUS, 0, 0, &status, 1) != 1) {
+		if (usb_read(adapter, CMD_GET_STATUS, 0, 0, pstatus, 1) != 1) {
 			dev_err(&adapter->dev, "failure reading status\n");
-			return -EREMOTEIO;
+			ret = -EREMOTEIO;
+			goto out;
 		}
 
-		dev_dbg(&adapter->dev, "  status = %d\n", status);
-		if (status == STATUS_ADDRESS_NAK)
-			return -EREMOTEIO;
+		dev_dbg(&adapter->dev, "  status = %d\n", *pstatus);
+		if (*pstatus == STATUS_ADDRESS_NAK) {
+			ret = -EREMOTEIO;
+			goto out;
+		}
 	}
 
-	return i;
+	ret = i;
+out:
+	kfree(pstatus);
+	return ret;
 }
 
 static u32 usb_func(struct i2c_adapter *adapter)
 {
-	__le32 func;
+	__le32 *pfunc;
+	u32 ret;
+
+	pfunc = kmalloc(sizeof(*pfunc), GFP_KERNEL);
 
 	/* get functionality from adapter */
-	if (usb_read(adapter, CMD_GET_FUNC, 0, 0, &func, sizeof(func)) !=
-	    sizeof(func)) {
+	if (!pfunc || usb_read(adapter, CMD_GET_FUNC, 0, 0, pfunc,
+			       sizeof(*pfunc)) != sizeof(*pfunc)) {
 		dev_err(&adapter->dev, "failure reading functionality\n");
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
-	return le32_to_cpu(func);
+	ret = le32_to_cpup(pfunc);
+out:
+	kfree(pfunc);
+	return ret;
 }
 
 /* This is the actual algorithm we define */

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
