From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH] i2c: ocores: rework clk code to handle NULL cookie
Date: Thu, 19 Feb 2015 17:37:04 +0100
Message-ID: <1424363824-6093-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

For, !HAVE_CLK the clk API returns a NULL cookie. Rework the
initialization code to handle that. If clk_get_rate() delivers 0, we use
the fallback mechanisms. The patch is pretty easy when ignoring white
space issues (git diff -b).

Suggested-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---

Max, can you please test/review. I can only compile-test. This is the outcome
of this thread: https://lkml.org/lkml/2015/2/5/544

 drivers/i2c/busses/i2c-ocores.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 3fc76b6ffcaade..abf5db7e441eba 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -354,20 +354,24 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
 		if (clock_frequency_present)
 			i2c->bus_clock_khz = clock_frequency / 1000;
-	} else if (of_property_read_u32(np, "opencores,ip-clock-frequency",
-					&val)) {
-		if (!clock_frequency_present) {
-			dev_err(&pdev->dev,
-				"Missing required parameter 'opencores,ip-clock-frequency'\n");
-			return -ENODEV;
+	}
+
+	if (i2c->ip_clock_khz == 0) {
+		if (of_property_read_u32(np, "opencores,ip-clock-frequency",
+						&val)) {
+			if (!clock_frequency_present) {
+				dev_err(&pdev->dev,
+					"Missing required parameter 'opencores,ip-clock-frequency'\n");
+				return -ENODEV;
+			}
+			i2c->ip_clock_khz = clock_frequency / 1000;
+			dev_warn(&pdev->dev,
+				 "Deprecated usage of the 'clock-frequency' property, please update to 'opencores,ip-clock-frequency'\n");
+		} else {
+			i2c->ip_clock_khz = val / 1000;
+			if (clock_frequency_present)
+				i2c->bus_clock_khz = clock_frequency / 1000;
 		}
-		i2c->ip_clock_khz = clock_frequency / 1000;
-		dev_warn(&pdev->dev,
-			 "Deprecated usage of the 'clock-frequency' property, please update to 'opencores,ip-clock-frequency'\n");
-	} else {
-		i2c->ip_clock_khz = val / 1000;
-		if (clock_frequency_present)
-			i2c->bus_clock_khz = clock_frequency / 1000;
 	}
 
 	of_property_read_u32(pdev->dev.of_node, "reg-io-width",
@@ -518,6 +522,7 @@ static int ocores_i2c_resume(struct device *dev)
 	struct ocores_i2c *i2c = dev_get_drvdata(dev);
 
 	if (!IS_ERR(i2c->clk)) {
+		unsigned long rate;
 		int ret = clk_prepare_enable(i2c->clk);
 
 		if (ret) {
@@ -525,7 +530,9 @@ static int ocores_i2c_resume(struct device *dev)
 				"clk_prepare_enable failed: %d\n", ret);
 			return ret;
 		}
-		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
+		rate = clk_get_rate(i2c->clk) / 1000;
+		if (rate)
+			i2c->ip_clock_khz = rate;
 	}
 	return ocores_init(dev, i2c);
 }
-- 
2.1.4
