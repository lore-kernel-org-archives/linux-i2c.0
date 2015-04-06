From: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V2 1/6] i2c: qup: Change qup_wait_writeready function to use for all timeouts
Date: Tue,  7 Apr 2015 00:01:02 +0530
Message-ID: <1428345067-21878-2-git-send-email-sricharan@codeaurora.org>
References: <1428345067-21878-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428345067-21878-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org
Cc: srichara-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

qup_wait_writeready waits only on a output fifo empty event.
Change the same function to accept the event and data length
to wait as parameters. This way the same function can be used for
timeouts in otherplaces as well.

Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-qup.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4dad23b..49c6cba 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -221,26 +221,42 @@ static int qup_i2c_change_state(struct qup_i2c_dev *qup, u32 state)
 	return 0;
 }
 
-static int qup_i2c_wait_writeready(struct qup_i2c_dev *qup)
+/**
+ * qup_i2c_wait_ready - wait for a give number of bytes in tx/rx path
+ * @qup: The qup_i2c_dev device
+ * @op: The bit/event to wait on
+ * @val: value of the bit to wait on, 0 or 1
+ * @len: The length the bytes to be transferred
+ */
+static int qup_i2c_wait_ready(struct qup_i2c_dev *qup, int op, bool val,
+			      int len)
 {
 	unsigned long timeout;
 	u32 opflags;
 	u32 status;
+	u32 shift = __ffs(op);
 
-	timeout = jiffies + HZ;
+	len *= qup->one_byte_t;
+	/* timeout after a wait of twice the max time */
+	timeout = jiffies + len * 4;
 
 	for (;;) {
 		opflags = readl(qup->base + QUP_OPERATIONAL);
 		status = readl(qup->base + QUP_I2C_STATUS);
 
-		if (!(opflags & QUP_OUT_NOT_EMPTY) &&
-		    !(status & I2C_STATUS_BUS_ACTIVE))
-			return 0;
+		if (((opflags & op) >> shift) == val) {
+			if (op == QUP_OUT_NOT_EMPTY) {
+				if (!(status & I2C_STATUS_BUS_ACTIVE))
+					return 0;
+			} else {
+				return 0;
+			}
+		}
 
 		if (time_after(jiffies, timeout))
 			return -ETIMEDOUT;
 
-		usleep_range(qup->one_byte_t, qup->one_byte_t * 2);
+		usleep_range(len, len * 2);
 	}
 }
 
@@ -347,7 +363,7 @@ static int qup_i2c_write_one(struct qup_i2c_dev *qup, struct i2c_msg *msg)
 	} while (qup->pos < msg->len);
 
 	/* Wait for the outstanding data in the fifo to drain */
-	ret = qup_i2c_wait_writeready(qup);
+	ret = qup_i2c_wait_ready(qup, QUP_OUT_NOT_EMPTY, 0, 1);
 
 err:
 	disable_irq(qup->irq);
-- 
1.8.2.1
