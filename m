From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 1/6] i2c: qup: Change qup_wait_writeready function to use for
 all timeouts
Date: Fri, 13 Mar 2015 23:19:47 +0530
Message-ID: <1426268992-19298-2-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, galak@codeaurora.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sricharan@codeaurora.org, agross@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

qup_wait_writeready waits only on a output fifo empty event.
Change the same function to accept the event and data length
to wait as parameters. This way the same function can be used for
timeouts in otherplaces as well.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
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
