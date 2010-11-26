From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 1/3] i2c i2c-mv64xxx: send repeated START between messages in xfer
Date: Fri, 26 Nov 2010 17:06:56 +0100
Message-ID: <1290787616-27106-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As stated into file include/linux/i2c.h we must send a repeated START
between messages in the same xfer groupset:

 * Except when I2C "protocol mangling" is used, all I2C adapters implement
 * the standard rules for I2C transactions.  Each transaction begins with a
 * START.  That is followed by the slave address, and a bit encoding read
 * versus write.  Then follow all the data bytes, possibly including a byte
 * with SMBus PEC.  The transfer terminates with a NAK, or when all those
 * bytes have been transferred and ACKed.  If this is the last message in a
 * group, it is followed by a STOP.  Otherwise it is followed by the next
 * @i2c_msg transaction segment, beginning with a (repeated) START.

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Signed-off-by: Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |   45 ++++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index c965a24..2cbc5ee 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -59,6 +59,7 @@ enum {
 	MV64XXX_I2C_STATE_INVALID,
 	MV64XXX_I2C_STATE_IDLE,
 	MV64XXX_I2C_STATE_WAITING_FOR_START_COND,
+	MV64XXX_I2C_STATE_WAITING_FOR_RESTART,
 	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
 	MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
@@ -70,6 +71,7 @@ enum {
 	MV64XXX_I2C_ACTION_INVALID,
 	MV64XXX_I2C_ACTION_CONTINUE,
 	MV64XXX_I2C_ACTION_SEND_START,
+	MV64XXX_I2C_ACTION_SEND_RESTART,
 	MV64XXX_I2C_ACTION_SEND_ADDR_1,
 	MV64XXX_I2C_ACTION_SEND_ADDR_2,
 	MV64XXX_I2C_ACTION_SEND_DATA,
@@ -91,6 +93,7 @@ struct mv64xxx_i2c_data {
 	u32			addr2;
 	u32			bytes_left;
 	u32			byte_posn;
+	u32			send_stop;
 	u32			block;
 	int			rc;
 	u32			freq_m;
@@ -159,8 +162,15 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 		if ((drv_data->bytes_left == 0)
 				|| (drv_data->aborting
 					&& (drv_data->byte_posn != 0))) {
-			drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-			drv_data->state = MV64XXX_I2C_STATE_IDLE;
+			if (drv_data->send_stop) {
+				drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+				drv_data->state = MV64XXX_I2C_STATE_IDLE;
+			} else {
+				drv_data->action =
+					MV64XXX_I2C_ACTION_SEND_RESTART;
+				drv_data->state =
+					MV64XXX_I2C_STATE_WAITING_FOR_RESTART;
+			}
 		} else {
 			drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
 			drv_data->state =
@@ -228,6 +238,15 @@ static void
 mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 {
 	switch(drv_data->action) {
+	case MV64XXX_I2C_ACTION_SEND_RESTART:
+		drv_data->cntl_bits |= MV64XXX_I2C_REG_CONTROL_START;
+		drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_INTEN;
+		writel(drv_data->cntl_bits,
+			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
+		drv_data->block = 0;
+		wake_up_interruptible(&drv_data->waitq);
+		break;
+
 	case MV64XXX_I2C_ACTION_CONTINUE:
 		writel(drv_data->cntl_bits,
 			drv_data->reg_base + MV64XXX_I2C_REG_CONTROL);
@@ -386,7 +405,8 @@ mv64xxx_i2c_wait_for_completion(struct mv64xxx_i2c_data *drv_data)
 }
 
 static int
-mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg)
+mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg,
+				int is_first, int is_last)
 {
 	unsigned long	flags;
 
@@ -406,10 +426,18 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data *drv_data, struct i2c_msg *msg)
 			drv_data->bytes_left--;
 		}
 	} else {
-		drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
-		drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+		if (is_first) {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_START;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+		} else {
+			drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
+			drv_data->state =
+				MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK;
+		}
 	}
 
+	drv_data->send_stop = is_last;
 	drv_data->block = 1;
 	mv64xxx_i2c_do_action(drv_data);
 	spin_unlock_irqrestore(&drv_data->lock, flags);
@@ -437,9 +465,12 @@ mv64xxx_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	struct mv64xxx_i2c_data *drv_data = i2c_get_adapdata(adap);
 	int	i, rc;
 
-	for (i=0; i<num; i++)
-		if ((rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i])) < 0)
+	for (i = 0; i < num; i++) {
+		rc = mv64xxx_i2c_execute_msg(drv_data, &msgs[i],
+						i == 0, i + 1 == num);
+		if (rc < 0)
 			return rc;
+	}
 
 	return num;
 }
-- 
1.7.1
