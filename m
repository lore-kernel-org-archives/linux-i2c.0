From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH v3 4/5] i2c: img-scb: add handle for Master halt interrupt
Date: Thu, 19 Nov 2015 09:35:16 +0000
Message-ID: <1447925717-25297-5-git-send-email-sifan.naeem@imgtec.com>
References: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:30952 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758076AbbKSJfX (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 04:35:23 -0500
In-Reply-To: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>

Master halt is issued after each byte of a transaction is processed in
IP version 3.3.
Master halt will stall the bus by holding the SCK line low until the
halt bit in the scb_general_control is cleared.

After the last byte of a transfer is processed we can use the Master
Halt interrupt to facilitate a repeated start transfer without
issuing a stop bit.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Reviewed-by: James Hartley <james.hartley@imgtec.com>
---
 drivers/i2c/busses/i2c-img-scb.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index f416010a0b49..991118f837be 100644
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
@@ -875,18 +877,27 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	}
 
 	if (i2c->msg.flags & I2C_M_RD) {
-		if (int_status & INT_FIFO_FULL_FILLING) {
+		if (int_status & (INT_FIFO_FULL_FILLING | INT_MASTER_HALTED)) {
 			img_i2c_read_fifo(i2c);
 			if (i2c->msg.len == 0)
 				return ISR_WAITSTOP;
 		}
 	} else {
-		if (int_status & INT_FIFO_EMPTY) {
-			if (i2c->msg.len == 0)
+		if (int_status & (INT_FIFO_EMPTY | INT_MASTER_HALTED)) {
+			if ((int_status & INT_FIFO_EMPTY) &&
+			    i2c->msg.len == 0)
 				return ISR_WAITSTOP;
 			img_i2c_write_fifo(i2c);
 		}
 	}
+	if (int_status & INT_MASTER_HALTED) {
+		/*
+		 * Release and then enable transaction halt, to
+		 * allow only a single byte to proceed.
+		 */
+		img_i2c_transaction_halt(i2c, false);
+		img_i2c_transaction_halt(i2c, !i2c->last_msg);
+	}
 
 	return 0;
 }
-- 
1.7.9.5
