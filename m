From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 7/7] i2c: img-scb: verify support for requested bit rate
Date: Fri, 14 Aug 2015 16:50:24 +0100
Message-ID: <1439567424-8094-8-git-send-email-sifan.naeem@imgtec.com>
References: <1439567424-8094-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439567424-8094-1-git-send-email-sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Ionela Voinescu <Ionela.Voinescu-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The requested bit rate can be outside the range supported by the driver.
The maximum bit rate this driver supports at the moment is 400Khz.

If the requested bit rate is larger than the maximum supported by the
driver, set the bitrate to the maximum supported before bitrate_khz is
calculated.

Maximum speed supported by the driver can be increased to 1Mhz by
adding support for "fast plus mode" in the future.

Fixes: commit 27bce457d588 ("i2c: img-scb: Add Imagination Technologies I2C SCB driver")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Reviewed-by: James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-img-scb.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 6c21a7bd9a66..c16caaccc363 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1138,9 +1138,6 @@ static int img_i2c_init(struct img_i2c *i2c)
 	/* Fencing enabled by default. */
 	i2c->need_wr_rd_fence = true;
 
-	bitrate_khz = i2c->bitrate / 1000;
-	clk_khz = clk_get_rate(i2c->scb_clk) / 1000;
-
 	/* Determine what mode we're in from the bitrate */
 	timing = timings[0];
 	for (i = 0; i < ARRAY_SIZE(timings); i++) {
@@ -1149,6 +1146,17 @@ static int img_i2c_init(struct img_i2c *i2c)
 			break;
 		}
 	}
+	if (i2c->bitrate > timings[ARRAY_SIZE(timings) - 1].max_bitrate) {
+		dev_warn(i2c->adap.dev.parent,
+			 "requested bitrate (%d) is higher than the max bitrate supported (%d)\n",
+			 i2c->bitrate,
+			 timings[ARRAY_SIZE(timings) - 1].max_bitrate);
+		timing = timings[ARRAY_SIZE(timings) - 1];
+		i2c->bitrate = timing.max_bitrate;
+	}
+
+	bitrate_khz = i2c->bitrate / 1000;
+	clk_khz = clk_get_rate(i2c->scb_clk) / 1000;
 
 	/* Find the prescale that would give us that inc (approx delay = 0) */
 	prescale = SCB_OPT_INC * clk_khz / (256 * 16 * bitrate_khz);
-- 
1.7.9.5
