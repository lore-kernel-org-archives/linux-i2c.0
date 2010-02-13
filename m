From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/5] i2c-parport: Add SMBus alert support
Date: Sat, 13 Feb 2010 23:08:32 +0100
Message-ID: <20100213230832.4eff0a8b@hyperion.delvare>
References: <20100213230438.31fd0fd7@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100213230438.31fd0fd7-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for the SMBus alert mechanism to the i2c-parport driver.
The ADM1032 evaluation board at least is properly wired for this.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/i2c/busses/i2c-parport |    3 ++
 drivers/i2c/busses/Kconfig           |    1 
 drivers/i2c/busses/i2c-parport.c     |   37 ++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-parport.h     |    4 ++-
 4 files changed, 42 insertions(+), 3 deletions(-)

--- linux-2.6.33-rc7.orig/Documentation/i2c/busses/i2c-parport	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/Documentation/i2c/busses/i2c-parport	2010-02-12 14:20:39.000000000 +0100
@@ -29,6 +29,9 @@ can be easily added when needed.
 Earlier kernels defaulted to type=0 (Philips).  But now, if the type
 parameter is missing, the driver will simply fail to initialize.
 
+SMBus alert support is available on adapters which have this line properly
+connected to the parallel port's interrupt pin.
+
 
 Building your own adapter
 -------------------------
--- linux-2.6.33-rc7.orig/drivers/i2c/busses/Kconfig	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/busses/Kconfig	2010-02-12 14:20:39.000000000 +0100
@@ -571,6 +571,7 @@ config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
 	select I2C_ALGOBIT
+	select I2C_SMBUS
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
--- linux-2.6.33-rc7.orig/drivers/i2c/busses/i2c-parport.c	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/busses/i2c-parport.c	2010-02-12 14:20:39.000000000 +0100
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport.c I2C bus over parallel port                                 *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    Based on older i2c-philips-par.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
@@ -31,6 +31,7 @@
 #include <linux/parport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/i2c-smbus.h>
 #include "i2c-parport.h"
 
 /* ----- Device list ------------------------------------------------------ */
@@ -39,6 +40,8 @@ struct i2c_par {
 	struct pardevice *pdev;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data algo_data;
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
 	struct i2c_par *next;
 };
 
@@ -144,6 +147,19 @@ static struct i2c_algo_bit_data parport_
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
 
+void i2c_parport_irq(void *data)
+{
+	struct i2c_par *adapter = data;
+	struct i2c_client *ara = adapter->ara;
+
+	if (ara) {
+		dev_dbg(&ara->dev, "SMBus alert received\n");
+		i2c_handle_smbus_alert(ara);
+	} else
+		dev_dbg(&adapter->adapter.dev,
+			"SMBus alert received but no ARA client!\n");
+}
+
 static void i2c_parport_attach (struct parport *port)
 {
 	struct i2c_par *adapter;
@@ -155,8 +171,9 @@ static void i2c_parport_attach (struct p
 	}
 
 	pr_debug("i2c-parport: attaching to %s\n", port->name);
+	parport_disable_irq(port);
 	adapter->pdev = parport_register_device(port, "i2c-parport",
-		NULL, NULL, NULL, PARPORT_FLAG_EXCL, NULL);
+		NULL, NULL, i2c_parport_irq, PARPORT_FLAG_EXCL, adapter);
 	if (!adapter->pdev) {
 		printk(KERN_ERR "i2c-parport: Unable to register with parport\n");
 		goto ERROR0;
@@ -197,6 +214,18 @@ static void i2c_parport_attach (struct p
 		goto ERROR1;
 	}
 
+	/* Setup SMBus alert if supported */
+	if (adapter_parm[type].smbus_alert) {
+		adapter->alert_data.alert_edge_triggered = 1;
+		adapter->ara = i2c_setup_smbus_alert(&adapter->adapter,
+						     &adapter->alert_data);
+		if (adapter->ara)
+			parport_enable_irq(port);
+		else
+			printk(KERN_WARNING "i2c-parport: Failed to register "
+			       "ARA client\n");
+	}
+
 	/* Add the new adapter to the list */
 	adapter->next = adapter_list;
 	adapter_list = adapter;
@@ -217,6 +246,10 @@ static void i2c_parport_detach (struct p
 	for (prev = NULL, adapter = adapter_list; adapter;
 	     prev = adapter, adapter = adapter->next) {
 		if (adapter->pdev->port == port) {
+			if (adapter->ara) {
+				parport_disable_irq(port);
+				i2c_unregister_device(adapter->ara);
+			}
 			i2c_del_adapter(&adapter->adapter);
 
 			/* Un-init if needed (power off...) */
--- linux-2.6.33-rc7.orig/drivers/i2c/busses/i2c-parport.h	2010-02-12 14:20:30.000000000 +0100
+++ linux-2.6.33-rc7/drivers/i2c/busses/i2c-parport.h	2010-02-12 14:20:39.000000000 +0100
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport.h I2C bus over parallel port                                 *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2004 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
@@ -38,6 +38,7 @@ struct adapter_parm {
 	struct lineop getsda;
 	struct lineop getscl;
 	struct lineop init;
+	unsigned int smbus_alert:1;
 };
 
 static struct adapter_parm adapter_parm[] = {
@@ -73,6 +74,7 @@ static struct adapter_parm adapter_parm[
 		.setscl	= { 0x01, DATA, 1 },
 		.getsda	= { 0x10, STAT, 1 },
 		.init	= { 0xf0, DATA, 0 },
+		.smbus_alert = 1,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{

-- 
Jean Delvare
