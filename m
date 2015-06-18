From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c-parport: use dev_*
Date: Thu, 18 Jun 2015 18:33:46 +0530
Message-ID: <1434632627-18955-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now parport is using device model so use dev_* macros instead of printk.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index 9b94c3d..3794f7d 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -215,7 +215,8 @@ static void i2c_parport_attach(struct parport *port)
 	adapter->adapter.dev.parent = port->physport->dev;
 
 	if (parport_claim_or_block(adapter->pdev) < 0) {
-		printk(KERN_ERR "i2c-parport: Could not claim parallel port\n");
+		dev_err(&adapter->pdev->dev,
+			"Could not claim parallel port\n");
 		goto err_unregister;
 	}
 
@@ -230,7 +231,7 @@ static void i2c_parport_attach(struct parport *port)
 	}
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
-		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
+		dev_err(&adapter->pdev->dev, "Unable to register with I2C\n");
 		goto err_unregister;
 	}
 
@@ -242,8 +243,8 @@ static void i2c_parport_attach(struct parport *port)
 		if (adapter->ara)
 			parport_enable_irq(port);
 		else
-			printk(KERN_WARNING "i2c-parport: Failed to register "
-			       "ARA client\n");
+			dev_warn(&adapter->pdev->dev,
+				 "Failed to register ARA client\n");
 	}
 
 	/* Add the new adapter to the list */
-- 
1.8.1.2
