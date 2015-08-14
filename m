From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/7] i2c: img-scb: enable fencing for all versions of the ip
Date: Fri, 14 Aug 2015 16:50:18 +0100
Message-ID: <1439567424-8094-2-git-send-email-sifan.naeem@imgtec.com>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567424-8094-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The code to read from the master read fifo, and write to the master
write fifo, checks a bit in an SCB register before every byte to
ensure that the fifo is not full (write fifo) or empty (read fifo).
Due to clock domain crossing inside the SCB block the updated value
of this bit is only visible after 2 cycles.

The scb_wr_rd_fence() function does 2 dummy writes (to the read-only
revision register), and it's called before reading from or writing to the
fifos to ensure that subsequent reads of the fifo status bits do not read
stale values.

As the 2 dummy writes are required in all versions of the ip, the version
check is dropped.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 00ffd6613680..5c3c61586d4a 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -278,8 +278,6 @@
 #define ISR_COMPLETE(err)	(ISR_COMPLETE_M | (ISR_STATUS_M & (err)))
 #define ISR_FATAL(err)		(ISR_COMPLETE(err) | ISR_FATAL_M)
 
-#define REL_SOC_IP_SCB_2_2_1	0x00020201
-
 enum img_i2c_mode {
 	MODE_INACTIVE,
 	MODE_RAW,
@@ -1120,10 +1118,8 @@ static int img_i2c_init(struct img_i2c *i2c)
 		return -EINVAL;
 	}
 
-	if (rev == REL_SOC_IP_SCB_2_2_1) {
-		i2c->need_wr_rd_fence = true;
-		dev_info(i2c->adap.dev.parent, "fence quirk enabled");
-	}
+	/* Fencing enabled by default. */
+	i2c->need_wr_rd_fence = true;
 
 	bitrate_khz = i2c->bitrate / 1000;
 	clk_khz = clk_get_rate(i2c->scb_clk) / 1000;
-- 
1.7.9.5
