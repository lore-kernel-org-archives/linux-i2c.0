From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 5/7] i2c: img-scb: remove start bit detected status after handling
Date: Fri, 14 Aug 2015 16:50:22 +0100
Message-ID: <1439567424-8094-6-git-send-email-sifan.naeem@imgtec.com>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567424-8094-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Remove start bit detected status after it is handled,
doing so will prevent this condition being hit for
every interrupt on a particular transfer.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index e4daebcdf824..200108dbd194 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -857,10 +857,18 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	}
 
 	/* Enable transaction halt on start bit */
-	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
-		img_i2c_transaction_halt(i2c, true);
-		/* we're no longer interested in the slave event */
-		i2c->int_enable &= ~INT_SLAVE_EVENT;
+	if (line_status & LINESTAT_START_BIT_DET) {
+		if (!i2c->last_msg) {
+			img_i2c_transaction_halt(i2c, true);
+			/* we're no longer interested in the slave event */
+			i2c->int_enable &= ~INT_SLAVE_EVENT;
+		}
+		/*
+		 * Remove start bit detected status after it is handled,
+		 * doing so will prevent this condition being hit for
+		 * every interrupt on a particular transfer.
+		 */
+		i2c->line_status &= ~LINESTAT_START_BIT_DET;
 	}
 
 	mod_timer(&i2c->check_timer, jiffies + msecs_to_jiffies(1));
-- 
1.7.9.5
