From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH v3 3/5] i2c: img-scb: add handle for stop detected interrupt
Date: Thu, 19 Nov 2015 09:35:15 +0000
Message-ID: <1447925717-25297-4-git-send-email-sifan.naeem@imgtec.com>
References: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:42999 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757770AbbKSJfW (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 04:35:22 -0500
In-Reply-To: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>

Stop Detected interrupt is triggered when a Stop bit is detected on
the bus, which indicates the end of the current transfer.

When the end of a transfer is indicated by the Stop Detected interrupt,
drain the FIFO and signal completion for the transaction.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
---
 drivers/i2c/busses/i2c-img-scb.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 0af554a16ae5..f416010a0b49 100644
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
@@ -865,6 +867,13 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 
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
