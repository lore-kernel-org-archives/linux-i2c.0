From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: mv64xxx: Fix some build warnings
Date: Wed, 18 Sep 2013 14:50:52 +0200
Message-ID: <1379508652-30348-1-git-send-email-treding@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some functions and variables are only used if the configuration selects
HAVE_CLK. Protect them with a corresponding #ifdef CONFIG_HAVE_CLK block
to avoid compiler warnings.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 5aead74..bfd870c 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -697,6 +697,7 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
 MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
 
 #ifdef CONFIG_OF
+#ifdef CONFIG_HAVE_CLK
 static int
 mv64xxx_calc_freq(const int tclk, const int n, const int m)
 {
@@ -726,16 +727,12 @@ mv64xxx_find_baud_factors(const u32 req_freq, const u32 tclk, u32 *best_n,
 		return false;
 	return true;
 }
+#endif
 
 static int
 mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		  struct device *dev)
 {
-	const struct of_device_id *device;
-	struct device_node *np = dev->of_node;
-	u32 bus_freq, tclk;
-	int rc = 0;
-
 	/* CLK is mandatory when using DT to describe the i2c bus. We
 	 * need to know tclk in order to calculate bus clock
 	 * factors.
@@ -744,6 +741,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 	/* Have OF but no CLK */
 	return -ENODEV;
 #else
+	const struct of_device_id *device;
+	struct device_node *np = dev->of_node;
+	u32 bus_freq, tclk;
+	int rc = 0;
+
 	if (IS_ERR(drv_data->clk)) {
 		rc = -ENODEV;
 		goto out;
-- 
1.8.4
