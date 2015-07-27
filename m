From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 7/7] i2c: img-scb: add handle for Master halt interrupt
Date: Mon, 27 Jul 2015 12:56:02 +0100
Message-ID: <1437998162-32724-8-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Master halt is issued after each byte of a transaction is processed in
IP version 3.3.
Master halt will stall the bus by holding the SCK line low until the
halt bit in the scb_general_control is cleared.

After the last byte of a transfer is processed we can use the Master
Halt interrupt to facilitate a repeated start transfer without
issuing a stop bit.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 90faf48..df3d25a 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -151,6 +151,7 @@
 #define INT_FIFO_EMPTYING		BIT(12)
 #define INT_TRANSACTION_DONE		BIT(15)
 #define INT_SLAVE_EVENT			BIT(16)
+#define INT_MASTER_HALTED		BIT(17)
 #define INT_TIMING			BIT(18)
 #define INT_STOP_DETECTED		BIT(19)
 
@@ -177,6 +178,7 @@
 					 INT_FIFO_FULL        | \
 					 INT_FIFO_FILLING     | \
 					 INT_FIFO_EMPTY       | \
+					 INT_MASTER_HALTED    | \
 					 INT_STOP_DETECTED)
 
 #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
@@ -901,6 +903,17 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
 
 	if (i2c->msg.flags & I2C_M_RD) {
+		if (int_status & INT_MASTER_HALTED) {
+			img_i2c_read_fifo(i2c);
+			if (i2c->msg.len == 0)
+				return ISR_COMPLETE(0);
+			/*
+			 * Release and then enable transaction halt, to
+			 * allow only a single byte to proceed.
+			 */
+			img_i2c_transaction_halt(i2c, false);
+			img_i2c_transaction_halt(i2c, !i2c->last_msg);
+		}
 		if (int_status & INT_FIFO_FULL_FILLING) {
 			img_i2c_read_fifo(i2c);
 			if (i2c->msg.len == 0) {
@@ -922,6 +935,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 			return ISR_COMPLETE(ret);
 		}
 	} else {
+		if (int_status & INT_MASTER_HALTED) {
+			if ((int_status & INT_FIFO_EMPTY) &&
+			    i2c->msg.len == 0)
+				return ISR_COMPLETE(0);
+			img_i2c_write_fifo(i2c);
+			/*
+			 * Release and then enable transaction halt, to
+			 * allow only a single byte to proceed.
+			 */
+			img_i2c_transaction_halt(i2c, false);
+			img_i2c_transaction_halt(i2c, !i2c->last_msg);
+		}
 		if (int_status & INT_FIFO_EMPTY) {
 			if (i2c->msg.len == 0) {
 				if (i2c->last_msg)
-- 
1.7.9.5
