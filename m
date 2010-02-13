From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 4/5] i2c-parport-light: Add SMBus alert support
Date: Sat, 13 Feb 2010 23:09:17 +0100
Message-ID: <20100213230917.78f60c16@hyperion.delvare>
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

Add support for the SMBus alert mechanism to the i2c-parport-light
driver. The ADM1032 evaluation board at least is properly wired for
this.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Trent Piepho <tpiepho-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 Documentation/i2c/busses/i2c-parport-light |   11 +++++++
 drivers/i2c/busses/Kconfig                 |    1 
 drivers/i2c/busses/i2c-parport-light.c     |   42 ++++++++++++++++++++++++++--
 3 files changed, 51 insertions(+), 3 deletions(-)

--- linux-2.6.33-rc8.orig/Documentation/i2c/busses/i2c-parport-light	2010-02-13 22:31:35.000000000 +0100
+++ linux-2.6.33-rc8/Documentation/i2c/busses/i2c-parport-light	2010-02-13 22:34:52.000000000 +0100
@@ -9,3 +9,14 @@ parport handling is not an option. The d
 and the impossibility to daisy-chain other parallel port devices.                 
   
 Please see i2c-parport for documentation.
+
+Module parameters:
+
+* type: type of adapter (see i2c-parport or modinfo)
+
+* base: base I/O address
+  Default is 0x378 which is fairly common for parallel ports, at least on PC.
+
+* irq: optional IRQ
+  This must be passed if you want SMBus alert support, assuming your adapter
+  actually supports this.
--- linux-2.6.33-rc8.orig/drivers/i2c/busses/Kconfig	2010-02-13 22:34:09.000000000 +0100
+++ linux-2.6.33-rc8/drivers/i2c/busses/Kconfig	2010-02-13 22:34:52.000000000 +0100
@@ -595,6 +595,7 @@ config I2C_PARPORT
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
 	select I2C_ALGOBIT
+	select I2C_SMBUS
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
--- linux-2.6.33-rc8.orig/drivers/i2c/busses/i2c-parport-light.c	2010-02-13 22:31:36.000000000 +0100
+++ linux-2.6.33-rc8/drivers/i2c/busses/i2c-parport-light.c	2010-02-13 22:34:52.000000000 +0100
@@ -1,7 +1,7 @@
 /* ------------------------------------------------------------------------ *
  * i2c-parport-light.c I2C bus over parallel port                           *
  * ------------------------------------------------------------------------ *
-   Copyright (C) 2003-2007 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+   Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
    
    Based on older i2c-velleman.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
@@ -32,6 +32,7 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/i2c-smbus.h>
 #include <asm/io.h>
 #include "i2c-parport.h"
 
@@ -44,6 +45,10 @@ static u16 base;
 module_param(base, ushort, 0);
 MODULE_PARM_DESC(base, "Base I/O address");
 
+static int irq;
+module_param(irq, int, 0);
+MODULE_PARM_DESC(irq, "IRQ (optional)");
+
 /* ----- Low-level parallel port access ----------------------------------- */
 
 static inline void port_write(unsigned char p, unsigned char d)
@@ -120,6 +125,16 @@ static struct i2c_adapter parport_adapte
 	.name		= "Parallel port adapter (light)",
 };
 
+/* SMBus alert support */
+static struct i2c_smbus_alert_setup alert_data = {
+	.alert_edge_triggered	= 1,
+};
+static struct i2c_client *ara;
+static struct lineop parport_ctrl_irq = {
+	.val		= (1 << 4),
+	.port		= CTRL,
+};
+
 static int __devinit i2c_parport_probe(struct platform_device *pdev)
 {
 	int err;
@@ -136,13 +151,31 @@ static int __devinit i2c_parport_probe(s
 
 	parport_adapter.dev.parent = &pdev->dev;
 	err = i2c_bit_add_bus(&parport_adapter);
-	if (err)
+	if (err) {
 		dev_err(&pdev->dev, "Unable to register with I2C\n");
-	return err;
+		return err;
+	}
+
+	/* Setup SMBus alert if supported */
+	if (adapter_parm[type].smbus_alert && irq) {
+		alert_data.irq = irq;
+		ara = i2c_setup_smbus_alert(&parport_adapter, &alert_data);
+		if (ara)
+			line_set(1, &parport_ctrl_irq);
+		else
+			dev_warn(&pdev->dev, "Failed to register ARA client\n");
+	}
+
+	return 0;
 }
 
 static int __devexit i2c_parport_remove(struct platform_device *pdev)
 {
+	if (ara) {
+		line_set(0, &parport_ctrl_irq);
+		i2c_unregister_device(ara);
+		ara = NULL;
+	}
 	i2c_del_adapter(&parport_adapter);
 
 	/* Un-init if needed (power off...) */
@@ -209,6 +242,9 @@ static int __init i2c_parport_init(void)
 	if (!request_region(base, 3, DRVNAME))
 		return -EBUSY;
 
+	if (irq != 0)
+		pr_info(DRVNAME ": using irq %d\n", irq);
+
         if (!adapter_parm[type].getscl.val)
 		parport_algo_data.getscl = NULL;
 

-- 
Jean Delvare
