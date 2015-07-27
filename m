From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 3/7] i2c: img-scb: mark transaction as complete when all data is read
Date: Mon, 27 Jul 2015 12:55:58 +0100
Message-ID: <1437998162-32724-4-git-send-email-sifan.naeem@imgtec.com>
References: <1437998162-32724-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437998162-32724-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We can mark the transfer as complete without waiting for the stop
bit. This is important when handling repeated start transfers as
we have to start the next transfer without the stop bit being issued.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 24b09fe..e27c3e0 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -903,8 +903,11 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	if (i2c->msg.flags & I2C_M_RD) {
 		if (int_status & INT_FIFO_FULL_FILLING) {
 			img_i2c_read_fifo(i2c);
-			if (i2c->msg.len == 0)
-				return ISR_WAITSTOP;
+			if (i2c->msg.len == 0) {
+				if (i2c->last_msg)
+					return ISR_WAITSTOP;
+				return ISR_COMPLETE(0);
+			}
 		}
 	} else {
 		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
-- 
1.7.9.5
