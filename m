From: Luis de Bethencourt <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 3/4] i2c: rk3x: Fix module autoload for OF platform driver
Date: Thu, 17 Sep 2015 18:36:11 +0200
Message-ID: <20150917163611.GA26214@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
---
 drivers/i2c/busses/i2c-rk3x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 72e97e30..c1935eb 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -858,6 +858,7 @@ static const struct of_device_id rk3x_i2c_match[] = {
 	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
 
 static int rk3x_i2c_probe(struct platform_device *pdev)
 {
-- 
2.4.6
