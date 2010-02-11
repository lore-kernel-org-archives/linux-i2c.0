From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: Give powered devices some time to settle
Date: Thu, 11 Feb 2010 12:16:32 +0100
Message-ID: <20100211121632.3a7d0b8a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When the i2c-parport adapter is reponsible for powering devices, it
would seem reasonable to give them some time to settle before trying
to access them.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport-light.c |    6 +++++-
 drivers/i2c/busses/i2c-parport.c       |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

--- linux-2.6.33-rc7.orig/drivers/i2c/busses/i2c-parport-light.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc7/drivers/i2c/busses/i2c-parport-light.c	2010-02-11 12:11:27.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
 #include <linux/i2c.h>
@@ -127,8 +128,11 @@ static int __devinit i2c_parport_probe(s
 	parport_setsda(NULL, 1);
 	parport_setscl(NULL, 1);
 	/* Other init if needed (power on...) */
-	if (adapter_parm[type].init.val)
+	if (adapter_parm[type].init.val) {
 		line_set(1, &adapter_parm[type].init);
+		/* Give powered devices some time to settle */
+		msleep(100);
+	}
 
 	parport_adapter.dev.parent = &pdev->dev;
 	err = i2c_bit_add_bus(&parport_adapter);
--- linux-2.6.33-rc7.orig/drivers/i2c/busses/i2c-parport.c	2010-02-11 11:39:03.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/busses/i2c-parport.c	2010-02-11 12:03:40.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -185,8 +186,11 @@ static void i2c_parport_attach (struct p
 	parport_setsda(port, 1);
 	parport_setscl(port, 1);
 	/* Other init if needed (power on...) */
-	if (adapter_parm[type].init.val)
+	if (adapter_parm[type].init.val) {
 		line_set(port, 1, &adapter_parm[type].init);
+		/* Give powered devices some time to settle */
+		msleep(100);
+	}
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
 		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");


-- 
Jean Delvare
