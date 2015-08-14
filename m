From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/5] i2c: img-scb: add handle for stop detected interrupt
Date: Fri, 14 Aug 2015 16:50:44 +0100
Message-ID: <1439567447-8139-4-git-send-email-sifan.naeem@imgtec.com>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567447-8139-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Stop Detected interrupt is triggered when a Stop bit is detected on
the bus, which indicates the end of the current transfer.

When the end of a transfer is indicated by the Stop Detected interrupt,
drain the FIFO and signal completion for the transaction. But if the
interrupt was triggered before all data is written to the fifo or with
more data expected return error with transfer complete signal.

Halting the bus is no longer necessary after a stop bit is detected
on the bus, as there cannot be a repeated start transfer when the stop
bit has been issued, hence remove the transaction halt bit.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 75a44e794d75..17e13ff475bb 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -152,6 +152,7 @@
 #define INT_TRANSACTION_DONE		BIT(15)
 #define INT_SLAVE_EVENT			BIT(16)
 #define INT_TIMING			BIT(18)
+#define INT_STOP_DETECTED		BIT(19)
 
 #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  | INT_FIFO_FILLING)
 
@@ -175,7 +176,8 @@
 					 INT_WRITE_ACK_ERR    | \
 					 INT_FIFO_FULL        | \
 					 INT_FIFO_FILLING     | \
-					 INT_FIFO_EMPTY)
+					 INT_FIFO_EMPTY       | \
+					 INT_STOP_DETECTED)
 
 #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
 					 INT_ADDR_ACK_ERR     | \
@@ -873,6 +875,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
 
+	if (int_status & INT_STOP_DETECTED) {
+		/* Drain remaining data in FIFO and complete transaction */
+		if (i2c->msg.flags & I2C_M_RD)
+			img_i2c_read_fifo(i2c);
+		return ISR_COMPLETE(0);
+	}
+
 	if (i2c->msg.flags & I2C_M_RD) {
 		if (int_status & INT_FIFO_FULL_FILLING) {
 			img_i2c_read_fifo(i2c);
-- 
1.7.9.5
