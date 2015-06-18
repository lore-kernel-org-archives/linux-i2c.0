From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] i2c-parport: start using pr_fmt
Date: Thu, 18 Jun 2015 18:33:47 +0530
Message-ID: <1434632627-18955-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434632627-18955-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434632627-18955-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Start using pr_fmt and convert all remaining printk to use
pr_* family of macros.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 3794f7d..881fe32 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -20,6 +20,8 @@
    GNU General Public License for more details.
  * ------------------------------------------------------------------------ */
 
+#define pr_fmt(fmt) "i2c-parport: " fmt
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -176,13 +178,13 @@ static void i2c_parport_attach(struct parport *port)
 			break;
 	}
 	if (i == MAX_DEVICE) {
-		pr_debug("i2c-parport: Not using parport%d.\n", port->number);
+		pr_debug("Not using parport%d.\n", port->number);
 		return;
 	}
 
 	adapter = kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
 	if (adapter == NULL) {
-		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
+		pr_err("Failed to kzalloc\n");
 		return;
 	}
 	memset(&i2c_parport_cb, 0, sizeof(i2c_parport_cb));
@@ -190,12 +192,12 @@ static void i2c_parport_attach(struct parport *port)
 	i2c_parport_cb.irq_func = i2c_parport_irq;
 	i2c_parport_cb.private = adapter;
 
-	pr_debug("i2c-parport: attaching to %s\n", port->name);
+	pr_debug("attaching to %s\n", port->name);
 	parport_disable_irq(port);
 	adapter->pdev = parport_register_dev_model(port, "i2c-parport",
 						   &i2c_parport_cb, i);
 	if (!adapter->pdev) {
-		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
+		pr_err("Unable to register with parport\n");
 		goto err_free;
 	}
 
@@ -299,12 +301,12 @@ static struct parport_driver i2c_parport_driver = {
 static int __init i2c_parport_init(void)
 {
 	if (type < 0) {
-		printk(KERN_WARNING "i2c-parport: adapter type unspecified\n");
+		pr_warn("adapter type unspecified\n");
 		return -ENODEV;
 	}
 
 	if (type >= ARRAY_SIZE(adapter_parm)) {
-		printk(KERN_WARNING "i2c-parport: invalid type (%d)\n", type);
+		pr_warn("invalid type (%d)\n", type);
 		return -ENODEV;
 	}
 
-- 
1.8.1.2
