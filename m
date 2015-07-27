From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/7] i2c: img-scb: add handle for stop detected interrupt
Date: Mon, 27 Jul 2015 12:56:01 +0100
Message-ID: <1437998162-32724-7-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Stop Detected interrupt is triggered when a Stop bit is detected on
the bus, which indicates the end of the current transfer.

When the end of a transfer is indicated by the Stop bit interrupt,
drain the FIFO and signal completion for the transaction. But if the
interrupt was triggered before all data is written to the fifo or with
more data expected return error with transfer complete signal.

Halting the bus is no longer necessary after a stop bit is detected
on the bus, as there cannot be a repeated start transfer when the stop
bit has been issued, hence remove the transaction halt bit.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 10141a9..90faf48 100644
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
@@ -907,6 +909,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 				return ISR_COMPLETE(0);
 			}
 		}
+		if (int_status & INT_STOP_DETECTED) {
+			int ret;
+			/*
+			 * Stop bit indicates the end of the transfer, it means
+			 * we should read all the data (or drain the FIFO). We
+			 * must signal completion for this transaction.
+			 */
+			img_i2c_transaction_halt(i2c, false);
+			img_i2c_read_fifo(i2c);
+			ret = (i2c->msg.len == 0) ? 0 : EIO;
+			return ISR_COMPLETE(ret);
+		}
 	} else {
 		if (int_status & INT_FIFO_EMPTY) {
 			if (i2c->msg.len == 0) {
@@ -916,6 +930,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 			}
 			img_i2c_write_fifo(i2c);
 		}
+		if (int_status & INT_STOP_DETECTED) {
+			int ret;
+
+			img_i2c_transaction_halt(i2c, false);
+			/*
+			 * Stop bit indicates the end of a transfer and if the
+			 * transfer has ended before all data is written to the
+			 * fifo, return an error with transfer complete signal.
+			 */
+			ret = (i2c->msg.len == 0) ? 0 : EIO;
+			return ISR_COMPLETE(ret);
+		}
 	}
 
 	return 0;
-- 
1.7.9.5
