From: Daniel J Blueman <daniel-JCXMqzvhRcvYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] Fix Intel PIIX4 I2C driver build failure
Date: Fri,  5 Oct 2012 12:21:11 +0800
Message-ID: <1349410871-17140-1-git-send-email-daniel@quora.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel J Blueman <daniel-JCXMqzvhRcvYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix build failure in Intel PIIX4 I2C driver.

Signed-off-by: Daniel J Blueman <daniel-JCXMqzvhRcvYtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-piix4.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index ef511df..8bbd6ec 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -37,6 +37,7 @@
 #include <linux/stddef.h>
 #include <linux/ioport.h>
 #include <linux/i2c.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
-- 
1.7.9.5
