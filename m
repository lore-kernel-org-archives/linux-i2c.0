From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: Fix misplaced parport_release call
Date: Tue, 25 Nov 2008 12:57:56 +0100
Message-ID: <20081125125756.1dad188d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We shouldn't release the parallel port until we are actually done with
it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.28-rc6.orig/drivers/i2c/busses/i2c-parport.c	2008-11-25 12:20:09.000000000 +0100
+++ linux-2.6.28-rc6/drivers/i2c/busses/i2c-parport.c	2008-11-25 12:21:27.000000000 +0100
@@ -189,8 +189,6 @@ static void i2c_parport_attach (struct p
 	if (adapter_parm[type].init.val)
 		line_set(port, 1, &adapter_parm[type].init);
 
-	parport_release(adapter->pdev);
-
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {
 		printk(KERN_ERR "i2c-parport: Unable to register with I2C\n");
 		goto ERROR1;
@@ -202,6 +200,7 @@ static void i2c_parport_attach (struct p
         return;
 
 ERROR1:
+	parport_release(adapter->pdev);
 	parport_unregister_device(adapter->pdev);
 ERROR0:
 	kfree(adapter);
@@ -221,6 +220,7 @@ static void i2c_parport_detach (struct p
 			if (adapter_parm[type].init.val)
 				line_set(port, 0, &adapter_parm[type].init);
 				
+			parport_release(adapter->pdev);
 			parport_unregister_device(adapter->pdev);
 			if (prev)
 				prev->next = adapter->next;


-- 
Jean Delvare
