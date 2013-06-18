From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 2/2] i2c-mv64xxx: Abort the mv64xxx_of_config if clock-frequency is not provided
Date: Tue, 18 Jun 2013 17:40:24 +0200
Message-ID: <1371570024-11613-3-git-send-email-gregory.clement@free-electrons.com>
References: <1371570024-11613-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1371570024-11613-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>

This commit adds checking whether clock-frequency property acquisition
has succeeded. Do not waste time to find baud factors if there is no
information about the desired bus frequency in dts.

[gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org: Reword the commit log]

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Signed-off-by: Zbigniew Bodek <zbb-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 74f8fcb..de384a1 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -591,7 +591,11 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
 		goto out;
 	}
 	tclk = clk_get_rate(drv_data->clk);
-	of_property_read_u32(np, "clock-frequency", &bus_freq);
+
+	rc = of_property_read_u32(np, "clock-frequency", &bus_freq);
+	if (rc)
+		goto out;
+
 	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
 				       &drv_data->freq_n, &drv_data->freq_m)) {
 		rc = -EINVAL;
-- 
1.8.1.2
