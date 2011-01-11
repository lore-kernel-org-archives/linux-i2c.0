From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] i2c-bfin-twi: move setup to the earlier subsys initcall
Date: Tue, 11 Jan 2011 00:25:09 -0500
Message-ID: <1294723509-18779-2-git-send-email-vapier@gentoo.org>
References: <1294723509-18779-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1294723509-18779-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Some systems using this bus sometimes have very basic devices such as
regulators on the bus, so the I2C bus master needs to be loaded early.
This also matches the behavior of many other I2C bus master drivers.
Therefore initialize via subsys_initcall().

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 1ee9d5a..52b545a 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -782,7 +782,7 @@ static void __exit i2c_bfin_twi_exit(void)
 	platform_driver_unregister(&i2c_bfin_twi_driver);
 }
 
-module_init(i2c_bfin_twi_init);
+subsys_initcall(i2c_bfin_twi_init);
 module_exit(i2c_bfin_twi_exit);
 
 MODULE_AUTHOR("Bryan Wu, Sonic Zhang");
-- 
1.7.4.rc1
