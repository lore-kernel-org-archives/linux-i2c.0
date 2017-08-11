From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 02/13] i2c: rk3x: add support for rv1108
Date: Fri, 11 Aug 2017 11:39:13 +0800
Message-ID: <1502422753-30725-1-git-send-email-andy.yan@rock-chips.com>
References: <1502422578-30611-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1502422578-30611-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Support for the i2c controller on rv1108 soc.

Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Reviewed-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 drivers/i2c/busses/i2c-rk3x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index df22066..fe23457 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1131,6 +1131,11 @@ static const struct i2c_algorithm rk3x_i2c_algorithm = {
 	.functionality		= rk3x_i2c_func,
 };
 
+static const struct rk3x_i2c_soc_data rv1108_soc_data = {
+	.grf_offset = -1,
+	.calc_timings = rk3x_i2c_v1_calc_timings,
+};
+
 static const struct rk3x_i2c_soc_data rk3066_soc_data = {
 	.grf_offset = 0x154,
 	.calc_timings = rk3x_i2c_v0_calc_timings,
@@ -1158,6 +1163,10 @@ static const struct rk3x_i2c_soc_data rk3399_soc_data = {
 
 static const struct of_device_id rk3x_i2c_match[] = {
 	{
+		.compatible = "rockchip,rv1108-i2c",
+		.data = (void *)&rv1108_soc_data
+	},
+	{
 		.compatible = "rockchip,rk3066-i2c",
 		.data = (void *)&rk3066_soc_data
 	},
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
