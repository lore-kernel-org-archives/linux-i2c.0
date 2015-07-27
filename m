From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] i2c: img-scb: mark transaction as complete when no more data to write
Date: Mon, 27 Jul 2015 12:55:59 +0100
Message-ID: <1437998162-32724-5-git-send-email-sifan.naeem@imgtec.com>
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

This doesn't affect the older versions of the IP.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index e27c3e0..efad4d7 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -911,16 +911,11 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 		}
 	} else {
 		if (int_status & INT_FIFO_EMPTY_EMPTYING) {
-			/*
-			 * The write fifo empty indicates that we're in the
-			 * last byte so it's safe to start a new write
-			 * transaction without losing any bytes from the
-			 * previous one.
-			 * see 2.3.7 Repeated Start Transactions.
-			 */
-			if ((int_status & INT_FIFO_EMPTY) &&
-			    i2c->msg.len == 0)
-				return ISR_WAITSTOP;
+			if (i2c->msg.len == 0) {
+				if (i2c->last_msg)
+					return ISR_WAITSTOP;
+				return ISR_COMPLETE(0);
+			}
 			img_i2c_write_fifo(i2c);
 		}
 	}
-- 
1.7.9.5
