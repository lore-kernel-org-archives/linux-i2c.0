From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: convert gpio-i2cmux to use module_platform_driver()
Date: Sun, 08 Jan 2012 09:35:52 +0800
Message-ID: <1325986552.4442.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch converts gpio-i2cmux to use the module_platform_driver() macro which
makes the code smaller and a bit simpler.

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/gpio-i2cmux.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/muxes/gpio-i2cmux.c b/drivers/i2c/muxes/gpio-i2cmux.c
index 7b6ce62..e5fa695 100644
--- a/drivers/i2c/muxes/gpio-i2cmux.c
+++ b/drivers/i2c/muxes/gpio-i2cmux.c
@@ -165,18 +165,7 @@ static struct platform_driver gpiomux_driver = {
 	},
 };
 
-static int __init gpiomux_init(void)
-{
-	return platform_driver_register(&gpiomux_driver);
-}
-
-static void __exit gpiomux_exit(void)
-{
-	platform_driver_unregister(&gpiomux_driver);
-}
-
-module_init(gpiomux_init);
-module_exit(gpiomux_exit);
+module_platform_driver(gpiomux_driver);
 
 MODULE_DESCRIPTION("GPIO-based I2C multiplexer driver");
 MODULE_AUTHOR("Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>");
-- 
1.7.5.4
