From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/7] i2c: img-scb: remove fifo EMPTYING interrupts handle
Date: Mon, 27 Jul 2015 12:56:00 +0100
Message-ID: <1437998162-32724-6-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This interrupt could have been useful for repeated start transfers
as the current transfer could be marked as complete while it's
processing the final byte of the transfer.
But having to use the transaction halt interrupt to safely control
repeated start transfers, means handling of the fifo EMPTYING
interrupts is no longer necessary.

Handling this interrupt along with Transaction Halt interrupt can
cause erratic behaviour.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index efad4d7..10141a9 100644
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
@@ -910,7 +908,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 			}
 		}
 	} else {
-		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
+		if (int_status & INT_FIFO_EMPTY) {
 			if (i2c->msg.len == 0) {
 				if (i2c->last_msg)
 					return ISR_WAITSTOP;
-- 
1.7.9.5
