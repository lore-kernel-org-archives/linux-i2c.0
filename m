From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] i2c-parport: start using pr_fmt
Date: Fri, 12 Jun 2015 12:47:14 +0530
Message-ID: <1434093434-30834-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Start using pr_fmt and convert all remaining printk to use
pr_* family of macros.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/i2c/busses/i2c-parport.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 9b94c3d..d53bf0b 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -20,6 +20,8 @@
    GNU General Public License for more details.
  * ------------------------------------------------------------------------ */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
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
 
@@ -215,7 +217,7 @@ static void i2c_parport_attach(struct parport *port)
 	adapter->adapter.dev.parent = port->physport->dev;
 
 	if (parport_claim_or_block(adapter->pdev) < 0) {
-		printk(KERN_ERR "i2c-parport: Could not claim parallel port\n");
+		pr_err("Could not claim parallel port\n");
 		goto err_unregister;
 	}
 
@@ -230,7 +232,7 @@ static void i2c_parport_attach(struct parport *port)
 	}
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
-		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
+		pr_err("Unable to register with I2C\n");
 		goto err_unregister;
 	}
 
@@ -242,8 +244,7 @@ static void i2c_parport_attach(struct parport *port)
 		if (adapter->ara)
 			parport_enable_irq(port);
 		else
-			printk(KERN_WARNING "i2c-parport: Failed to register "
-			       "ARA client\n");
+			pr_warn("Failed to register ARA client\n");
 	}
 
 	/* Add the new adapter to the list */
@@ -298,12 +299,12 @@ static struct parport_driver i2c_parport_driver = {
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
