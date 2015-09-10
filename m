From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 5/7] i2c: img-scb: use line_status instead of i2c->line_status
Date: Thu, 10 Sep 2015 15:50:05 +0100
Message-ID: <1441896607-16310-6-git-send-email-sifan.naeem@imgtec.com>
References: <1441896607-16310-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441896607-16310-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c->line_status accumulates the line status bits that have been seen
with each interrupt. As we're only interested in that bit from the
current interrupt, refer to line_status (the argument to img_i2c_auto)
instead of i2c->line_status.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index e4daebcdf824..049d193d01ac 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -857,7 +857,7 @@ static unsigned int img_i2c_auto(struct img_i2c *i2c,
 	}
 
 	/* Enable transaction halt on start bit */
-	if (!i2c->last_msg && i2c->line_status & LINESTAT_START_BIT_DET) {
+	if (!i2c->last_msg && line_status & LINESTAT_START_BIT_DET) {
 		img_i2c_transaction_halt(i2c, true);
 		/* we're no longer interested in the slave event */
 		i2c->int_enable &= ~INT_SLAVE_EVENT;
-- 
1.7.9.5
