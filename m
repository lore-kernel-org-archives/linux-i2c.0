From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: xiic: Add OF support for Xilinx i2c bus interface
Date: Tue, 22 Feb 2011 15:22:09 +0100
Message-ID: <1298384530-14994-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, john.williams-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John.Linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add OF support to Xilinx i2c bus interface.
It is used on Microblaze systems.

Signed-off-by: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
---
 drivers/i2c/busses/i2c-xiic.c |   46 +++++++++++++++++++++++++++++++++=
+------
 1 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xii=
c.c
index a9c419e..4166570 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -2,6 +2,8 @@
  * i2c-xiic.c
  * Copyright (c) 2002-2007 Xilinx Inc.
  * Copyright (c) 2009-2010 Intel Corporation
+ * Copyright (c) 2010-2011 Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
+ * Copyright (c) 2010-2011 PetaLogix
  *
  * This program is free software; you can redistribute it and/or modif=
y
  * it under the terms of the GNU General Public License version 2 as
@@ -41,6 +43,13 @@
 #include <linux/io.h>
 #include <linux/slab.h>
=20
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_i2c.h>
+#include <linux/of_address.h>
+#endif
+
 #define DRIVER_NAME "xiic-i2c"
=20
 enum xilinx_i2c_state {
@@ -426,7 +435,7 @@ static void xiic_process(struct xiic_i2c *i2c)
 			xiic_wakeup(i2c, STATE_ERROR);
=20
 	} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK))=
 {
-		/* Transmit register/FIFO is empty or =BD empty */
+		/* Transmit register/FIFO is empty or 1/2 empty */
=20
 		clr =3D pend &
 			(XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK);
@@ -691,10 +700,12 @@ static struct i2c_adapter xiic_adapter =3D {
 static int __devinit xiic_i2c_probe(struct platform_device *pdev)
 {
 	struct xiic_i2c *i2c;
+#ifndef CONFIG_OF
 	struct xiic_i2c_platform_data *pdata;
+	u8 i;
+#endif
 	struct resource *res;
 	int ret, irq;
-	u8 i;
=20
 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -704,10 +715,6 @@ static int __devinit xiic_i2c_probe(struct platfor=
m_device *pdev)
 	if (irq < 0)
 		goto resource_missing;
=20
-	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
-	if (!pdata)
-		return -EINVAL;
-
 	i2c =3D kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
@@ -730,7 +737,9 @@ static int __devinit xiic_i2c_probe(struct platform=
_device *pdev)
 	i2c->adap =3D xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent =3D &pdev->dev;
-
+#ifdef CONFIG_OF
+	i2c->adap.dev.of_node =3D of_node_get(pdev->dev.of_node);
+#endif
 	xiic_reinit(i2c);
=20
 	spin_lock_init(&i2c->lock);
@@ -748,9 +757,20 @@ static int __devinit xiic_i2c_probe(struct platfor=
m_device *pdev)
 		goto add_adapter_failed;
 	}
=20
+	dev_info(&pdev->dev, "mapped to 0x%08X, irq=3D%d\n",
+					(unsigned int)i2c->base, irq);
+
+#ifndef CONFIG_OF
+	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
+	if (!pdata)
+		return -EINVAL;
+
 	/* add in known devices to the bus */
 	for (i =3D 0; i < pdata->num_devices; i++)
 		i2c_new_device(&i2c->adap, pdata->devices + i);
+#else
+	of_i2c_register_devices(&i2c->adap);
+#endif
=20
 	return 0;
=20
@@ -799,12 +819,24 @@ static int __devexit xiic_i2c_remove(struct platf=
orm_device* pdev)
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:"DRIVER_NAME);
=20
+#ifdef CONFIG_OF
+/* Match table for of_platform binding */
+static struct of_device_id __devinitdata xilinx_iic_of_match[] =3D {
+	{ .compatible =3D "xlnx,xps-iic-2.00.a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xilinx_iic_of_match);
+#endif
+
 static struct platform_driver xiic_i2c_driver =3D {
 	.probe   =3D xiic_i2c_probe,
 	.remove  =3D __devexit_p(xiic_i2c_remove),
 	.driver  =3D {
 		.owner =3D THIS_MODULE,
 		.name =3D DRIVER_NAME,
+#ifdef CONFIG_OF
+		.of_match_table =3D xilinx_iic_of_match,
+#endif
 	},
 };
=20
--=20
1.5.5.6
