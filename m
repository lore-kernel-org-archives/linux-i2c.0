From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v3 1/5] i2c: i2c-mpc: various coding style fixes
Date: Tue, 07 Apr 2009 10:20:53 +0200
Message-ID: <20090407082231.177941706@denx.de>
References: <20090407082052.477328750@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=i2c-mpc-coding-style.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix errors reported by checkpatch (indention, long lines, trailing
white space, etc.).

Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

Index: linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-galak.orig/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:09.400719216 +0200
+++ linux-2.6-galak/drivers/i2c/busses/i2c-mpc.c	2009-04-07 10:09:13.271719088 +0200
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_i2c.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/fsl_devices.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -28,10 +28,10 @@
 
 #define DRV_NAME "mpc-i2c"
 
-#define MPC_I2C_FDR 	0x04
-#define MPC_I2C_CR	0x08
-#define MPC_I2C_SR	0x0c
-#define MPC_I2C_DR	0x10
+#define MPC_I2C_FDR   0x04
+#define MPC_I2C_CR    0x08
+#define MPC_I2C_SR    0x0c
+#define MPC_I2C_DR    0x10
 #define MPC_I2C_DFSRR 0x14
 
 #define CCR_MEN  0x80
@@ -58,7 +58,7 @@
 	u32 flags;
 };
 
-static __inline__ void writeccr(struct mpc_i2c *i2c, u32 x)
+static inline void writeccr(struct mpc_i2c *i2c, u32 x)
 {
 	writeb(x, i2c->base + MPC_I2C_CR);
 }
@@ -100,8 +100,7 @@
 	u32 x;
 	int result = 0;
 
-	if (i2c->irq == NO_IRQ)
-	{
+	if (i2c->irq == NO_IRQ) {
 		while (!(readb(i2c->base + MPC_I2C_SR) & CSR_MIF)) {
 			schedule();
 			if (time_after(jiffies, orig_jiffies + timeout)) {
@@ -176,7 +175,7 @@
 }
 
 static int mpc_write(struct mpc_i2c *i2c, int target,
-		     const u8 * data, int length, int restart)
+		     const u8 *data, int length, int restart)
 {
 	int i, result;
 	unsigned timeout = i2c->adap.timeout;
@@ -207,7 +206,7 @@
 }
 
 static int mpc_read(struct mpc_i2c *i2c, int target,
-		    u8 * data, int length, int restart)
+		    u8 *data, int length, int restart)
 {
 	unsigned timeout = i2c->adap.timeout;
 	int i, result;
@@ -311,7 +310,8 @@
 	.timeout = HZ,
 };
 
-static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
+static int __devinit fsl_i2c_probe(struct of_device *op,
+				   const struct of_device_id *match)
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
@@ -341,11 +341,12 @@
 		result = request_irq(i2c->irq, mpc_i2c_isr,
 				     IRQF_SHARED, "i2c-mpc", i2c);
 		if (result < 0) {
-			printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
+			printk(KERN_ERR
+			       "i2c-mpc - failed to attach interrupt\n");
 			goto fail_request;
 		}
 	}
-	
+
 	mpc_i2c_setclock(i2c);
 
 	dev_set_drvdata(&op->dev, i2c);
@@ -368,7 +369,7 @@
 	free_irq(i2c->irq, i2c);
  fail_request:
 	irq_dispose_mapping(i2c->irq);
- 	iounmap(i2c->base);
+	iounmap(i2c->base);
  fail_map:
 	kfree(i2c);
 	return result;
@@ -414,7 +415,7 @@
 
 	rv = of_register_platform_driver(&mpc_i2c_driver);
 	if (rv)
-		printk(KERN_ERR DRV_NAME 
+		printk(KERN_ERR DRV_NAME
 		       " of_register_platform_driver failed (%i)\n", rv);
 	return rv;
 }
@@ -428,6 +429,6 @@
 module_exit(fsl_i2c_exit);
 
 MODULE_AUTHOR("Adrian Cox <adrian-nKrwMtk+6Wm9FHfhHBbuYA@public.gmane.org>");
-MODULE_DESCRIPTION
-    ("I2C-Bus adapter for MPC107 bridge and MPC824x/85xx/52xx processors");
+MODULE_DESCRIPTION("I2C-Bus adapter for MPC107 bridge and "
+		   "MPC824x/85xx/52xx processors");
 MODULE_LICENSE("GPL");
