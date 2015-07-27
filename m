From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] i2c: img-scb: support I2C_M_IGNORE_NAK
Date: Mon, 27 Jul 2015 12:55:56 +0100
Message-ID: <1437998162-32724-2-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This commit adds support for the I2C_M_IGNORE_NAK protocol
modification.

Such behaviour can only be implemented in atomic mode. So, if a
transaction contains a message with such flag the drivers
switches to atomic mode. The implementation consists simply in
treating NAKs as ACKs.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 07a039c..31cd8c3 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -767,7 +767,9 @@ static unsigned int img_i2c_atomic(struct img_i2c *i2c,
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
@@ -1042,20 +1044,23 @@ static int img_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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
