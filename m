From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/7] i2c: img-scb: support repeated starts on IP v3.3
Date: Mon, 27 Jul 2015 12:55:57 +0100
Message-ID: <1437998162-32724-3-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In version 3.3 of the IP when transaction halt is set, an interrupt
will be generated after each byte of a transfer instead of after
every transfer but before the stop bit.
Due to this behaviour we have to be careful that every time we
release the transaction halt we have to re-enable it straight away
so that we only process a single byte, not doing so will result in
all remaining bytes been processed and a stop bit being issued,
which will prevent us having a repeated start.

This change will have no effect on earlier versions of the IP.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   43 +++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 31cd8c3..24b09fe 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -525,7 +525,17 @@ static void img_i2c_soft_reset(struct img_i2c *i2c)
 	img_i2c_writel(i2c, SCB_INT_MASK_REG, i2c->int_enable);
 }
 
-/* enable or release transaction halt for control of repeated starts */
+/*
+ * Enable or release transaction halt for control of repeated starts.
+ * In version 3.3 of the IP when transaction halt is set, an interrupt
+ * will be generated after each byte of a transfer instead of after
+ * every transfer but before the stop bit.
+ * Due to this behaviour we have to be careful that every time we
+ * release the transaction halt we have to re-enable it straight away
+ * so that we only process a single byte, not doing so will result in
+ * all remaining bytes been processed and a stop bit being issued,
+ * which will prevent us having a repeated start.
+ */
 static void img_i2c_transaction_halt(struct img_i2c *i2c, bool t_halt)
 {
 	u32 val;
@@ -594,7 +604,6 @@ static void img_i2c_read(struct img_i2c *i2c)
 	img_i2c_writel(i2c, SCB_READ_ADDR_REG, i2c->msg.addr);
 	img_i2c_writel(i2c, SCB_READ_COUNT_REG, i2c->msg.len);
 
-	img_i2c_transaction_halt(i2c, false);
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
 }
 
@@ -608,7 +617,6 @@ static void img_i2c_write(struct img_i2c *i2c)
 	img_i2c_writel(i2c, SCB_WRITE_ADDR_REG, i2c->msg.addr);
 	img_i2c_writel(i2c, SCB_WRITE_COUNT_REG, i2c->msg.len);
 
-	img_i2c_transaction_halt(i2c, false);
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
 	img_i2c_write_fifo(i2c);
 
@@ -1090,12 +1098,31 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		i2c->last_msg = (i == num - 1);
 		reinit_completion(&i2c->msg_complete);
 
-		if (atomic)
+		if (atomic) {
 			img_i2c_atomic_start(i2c);
-		else if (msg->flags & I2C_M_RD)
-			img_i2c_read(i2c);
-		else
-			img_i2c_write(i2c);
+		} else {
+			/*
+			 * Enable transaction halt if not the last message in
+			 * the queue so that we can control repeated starts.
+			 */
+			img_i2c_transaction_halt(i2c, !i2c->last_msg);
+
+			if (msg->flags & I2C_M_RD)
+				img_i2c_read(i2c);
+			else
+				img_i2c_write(i2c);
+
+			/*
+			 * Release and then enable transaction halt, to
+			 * allow only a single byte to proceed.
+			 * This doesn't have an effect on the initial transfer
+			 * but will allow the following transfers to start
+			 * processing if the previous transfer was marked as
+			 * complete while the i2c block was halted.
+			 */
+			img_i2c_transaction_halt(i2c, false);
+			img_i2c_transaction_halt(i2c, !i2c->last_msg);
+		}
 		spin_unlock_irqrestore(&i2c->lock, flags);
 
 		time_left = wait_for_completion_timeout(&i2c->msg_complete,
-- 
1.7.9.5
