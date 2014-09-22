From: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
Date: Mon, 22 Sep 2014 15:24:35 +0800
Message-ID: <1411370675-27866-1-git-send-email-zyw@rock-chips.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Some device using this bus, such as regulators, they should register
as early as possible, so the I2C bus master needs to be loaded early.
Therefore initialize via subsys_initcall() is better.

Signed-off-by: Chris Zhong <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

---

 drivers/i2c/busses/i2c-rk3x.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index e637c32..5b91901 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -760,7 +760,18 @@ static struct platform_driver rk3x_i2c_driver = {
 	},
 };
 
-module_platform_driver(rk3x_i2c_driver);
+static int __init rk3x_i2c_init_driver(void)
+{
+	return platform_driver_register(&rk3x_i2c_driver);
+}
+
+static void __exit rk3x_i2c_exit_driver(void)
+{
+	platform_driver_unregister(&rk3x_i2c_driver);
+}
+
+subsys_initcall(rk3x_i2c_init_driver);
+module_exit(rk3x_i2c_exit_driver);
 
 MODULE_DESCRIPTION("Rockchip RK3xxx I2C Bus driver");
 MODULE_AUTHOR("Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>");
-- 
1.7.9.5
