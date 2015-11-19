From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH v3 1/5] i2c: img-scb: support I2C_M_IGNORE_NAK
Date: Thu, 19 Nov 2015 09:35:13 +0000
Message-ID: <1447925717-25297-2-git-send-email-sifan.naeem@imgtec.com>
References: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:62811 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbbKSJfV (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Nov 2015 04:35:21 -0500
In-Reply-To: <1447925717-25297-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, James Hogan <James.Hogan@imgtec.com>, linux-i2c@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Sifan Naeem <sifan.naeem@imgtec.com>

This commit adds support for the I2C_M_IGNORE_NAK protocol
modification.

Such behaviour can only be implemented in atomic mode. So, if a
transaction contains a message with such flag the drivers
switches to atomic mode. The implementation consists simply in
treating NAKs as ACKs.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
Acked-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: James Hartley <james.hartley@imgtec.com>
---
 drivers/i2c/busses/i2c-img-scb.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 3795fe130ef2..c92bcf7c204f 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -750,7 +750,9 @@ static unsigned int img_i2c_atomic(struct img_i2c *i2c,
 			next_cmd = CMD_RET_ACK;
 		break;
 	case CMD_RET_ACK:
-		if (i2c->line_status & LINESTAT_ACK_DET) {
+		if (i2c->line_status & LINESTAT_ACK_DET ||
+		    (i2c->line_status & LINESTAT_NACK_DET &&
+		    i2c->msg.flags & I2C_M_IGNORE_NAK)) {
 			if (i2c->msg.len == 0) {
 				next_cmd = CMD_GEN_STOP;
 			} else if (i2c->msg.flags & I2C_M_RD) {
@@ -1017,20 +1019,23 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		return -EIO;
 
 	for (i = 0; i < num; i++) {
-		if (likely(msgs[i].len))
-			continue;
 		/*
 		 * 0 byte reads are not possible because the slave could try
 		 * and pull the data line low, preventing a stop bit.
 		 */
-		if (unlikely(msgs[i].flags & I2C_M_RD))
+		if (!msgs[i].len && msgs[i].flags & I2C_M_RD)
 			return -EIO;
 		/*
 		 * 0 byte writes are possible and used for probing, but we
 		 * cannot do them in automatic mode, so use atomic mode
 		 * instead.
+		 *
+		 * Also, the I2C_M_IGNORE_NAK mode can only be implemented
+		 * in atomic mode.
 		 */
-		atomic = true;
+		if (!msgs[i].len ||
+		    (msgs[i].flags & I2C_M_IGNORE_NAK))
+			atomic = true;
 	}
 
 	ret = clk_prepare_enable(i2c->scb_clk);
-- 
1.7.9.5
