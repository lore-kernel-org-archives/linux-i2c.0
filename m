From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/5] i2c: img-scb: remove fifo EMPTYING interrupts handle
Date: Fri, 14 Aug 2015 16:50:43 +0100
Message-ID: <1439567447-8139-3-git-send-email-sifan.naeem@imgtec.com>
References: <1439567447-8139-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567447-8139-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that we are using the transaction halt interrupt to safely control
repeated start transfers, we no longer need to handle the fifo
emptying interrupts. 

Handling this interrupt along with Transaction Halt interrupt can
cause erratic behaviour.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index ad1d1df943db..75a44e794d75 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -154,7 +154,6 @@
 #define INT_TIMING			BIT(18)
 
 #define INT_FIFO_FULL_FILLING	(INT_FIFO_FULL  | INT_FIFO_FILLING)
-#define INT_FIFO_EMPTY_EMPTYING	(INT_FIFO_EMPTY | INT_FIFO_EMPTYING)
 
 /* Level interrupts need clearing after handling instead of before */
 #define INT_LEVEL			0x01e00
@@ -176,8 +175,7 @@
 					 INT_WRITE_ACK_ERR    | \
 					 INT_FIFO_FULL        | \
 					 INT_FIFO_FILLING     | \
-					 INT_FIFO_EMPTY       | \
-					 INT_FIFO_EMPTYING)
+					 INT_FIFO_EMPTY)
 
 #define INT_ENABLE_MASK_WAITSTOP	(INT_SLAVE_EVENT      | \
 					 INT_ADDR_ACK_ERR     | \
@@ -882,16 +880,8 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 				return ISR_WAITSTOP;
 		}
 	} else {
-		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
-			/*
-			 * The write fifo empty indicates that we're in the
-			 * last byte so it's safe to start a new write
-			 * transaction without losing any bytes from the
-			 * previous one.
-			 * see 2.3.7 Repeated Start Transactions.
-			 */
-			if ((int_status & INT_FIFO_EMPTY) &&
-			    i2c->msg.len == 0)
+		if (int_status & INT_FIFO_EMPTY) {
+			if (i2c->msg.len == 0)
 				return ISR_WAITSTOP;
 			img_i2c_write_fifo(i2c);
 		}
-- 
1.7.9.5
