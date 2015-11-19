From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH v3 2/5] i2c: img-scb: remove fifo EMPTYING interrupts handle
Date: Thu, 19 Nov 2015 09:35:14 +0000
Message-ID: <1447925717-25297-3-git-send-email-sifan.naeem@imgtec.com>
References: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:29362 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680AbbKSJfV (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 04:35:21 -0500
In-Reply-To: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>

Now that we are using the transaction halt interrupt to safely control
repeated start transfers, we no longer need to handle the fifo
emptying interrupts.

Handling this interrupt along with Transaction Halt interrupt can
cause erratic behaviour.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
---
 drivers/i2c/busses/i2c-img-scb.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index c92bcf7c204f..0af554a16ae5 100644
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
@@ -874,16 +872,8 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
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
