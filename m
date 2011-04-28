From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: Fix adapter list handling
Date: Thu, 28 Apr 2011 17:56:53 +0200
Message-ID: <20110428175653.213f4fac@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use a standard list with proper locking to handle the list of
adapters. Thankfully it only matters on systems with more than one
parallel port, which are very rare.

Thanks to Lukasz Kapiec for reporting the problem to me.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/i2c/busses/i2c-parport.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- linux-2.6.39-rc5.orig/drivers/i2c/busses/i2c-parport.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.39-rc5/drivers/i2c/busses/i2c-parport.c	2011-04-28 17:15:43.000000000 +0200
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport.c I2C bus over parallel port                                 *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2011 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    Based on older i2c-philips-par.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
@@ -33,6 +33,8 @@
 #include <linux/i2c-algo-bit.h>
 #include <linux/i2c-smbus.h>
 #include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
 #include "i2c-parport.h"
 
 /* ----- Device list ------------------------------------------------------ */
@@ -43,10 +45,11 @@ struct i2c_par {
 	struct i2c_algo_bit_data algo_data;
 	struct i2c_smbus_alert_setup alert_data;
 	struct i2c_client *ara;
-	struct i2c_par *next;
+	struct list_head node;
 };
 
-static struct i2c_par *adapter_list;
+static LIST_HEAD(adapter_list);
+static DEFINE_MUTEX(adapter_list_lock);
 
 /* ----- Low-level parallel port access ----------------------------------- */
 
@@ -228,8 +231,9 @@ static void i2c_parport_attach (struct p
 	}
 
 	/* Add the new adapter to the list */
-	adapter->next = adapter_list;
-	adapter_list = adapter;
+	mutex_lock(&adapter_list_lock);
+	list_add_tail(&adapter->node, &adapter_list);
+	mutex_unlock(&adapter_list_lock);
         return;
 
 ERROR1:
@@ -241,11 +245,11 @@ ERROR0:
 
 static void i2c_parport_detach (struct parport *port)
 {
-	struct i2c_par *adapter, *prev;
+	struct i2c_par *adapter, *_n;
 
 	/* Walk the list */
-	for (prev = NULL, adapter = adapter_list; adapter;
-	     prev = adapter, adapter = adapter->next) {
+	mutex_lock(&adapter_list_lock);
+	list_for_each_entry_safe(adapter, _n, &adapter_list, node) {
 		if (adapter->pdev->port == port) {
 			if (adapter->ara) {
 				parport_disable_irq(port);
@@ -259,14 +263,11 @@ static void i2c_parport_detach (struct p
 				
 			parport_release(adapter->pdev);
 			parport_unregister_device(adapter->pdev);
-			if (prev)
-				prev->next = adapter->next;
-			else
-				adapter_list = adapter->next;
+			list_del(&adapter->node);
 			kfree(adapter);
-			return;
 		}
 	}
+	mutex_unlock(&adapter_list_lock);
 }
 
 static struct parport_driver i2c_parport_driver = {


-- 
Jean Delvare
