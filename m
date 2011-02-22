From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: [PATCH v3 1/2] i2c: xiic: Add OF support for Xilinx i2c bus interface
Date: Tue, 22 Feb 2011 18:49:30 +0100
Message-ID: <1298396971-611-1-git-send-email-monstr@monstr.eu>
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
 drivers/i2c/busses/i2c-xiic.c |   37 +++++++++++++++++++++++++++++----=
----
 1 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xii=
c.c
index a9c419e..0b7647b 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -41,6 +41,11 @@
 #include <linux/io.h>
 #include <linux/slab.h>
=20
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_i2c.h>
+#include <linux/of_address.h>
+
 #define DRIVER_NAME "xiic-i2c"
=20
 enum xilinx_i2c_state {
@@ -426,7 +431,7 @@ static void xiic_process(struct xiic_i2c *i2c)
 			xiic_wakeup(i2c, STATE_ERROR);
=20
 	} else if (pend & (XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK))=
 {
-		/* Transmit register/FIFO is empty or =BD empty */
+		/* Transmit register/FIFO is empty or 1/2 empty */
=20
 		clr =3D pend &
 			(XIIC_INTR_TX_EMPTY_MASK | XIIC_INTR_TX_HALF_MASK);
@@ -704,10 +709,6 @@ static int __devinit xiic_i2c_probe(struct platfor=
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
@@ -730,6 +731,7 @@ static int __devinit xiic_i2c_probe(struct platform=
_device *pdev)
 	i2c->adap =3D xiic_adapter;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent =3D &pdev->dev;
+	i2c->adap.dev.of_node =3D of_node_get(pdev->dev.of_node);
=20
 	xiic_reinit(i2c);
=20
@@ -748,9 +750,16 @@ static int __devinit xiic_i2c_probe(struct platfor=
m_device *pdev)
 		goto add_adapter_failed;
 	}
=20
-	/* add in known devices to the bus */
-	for (i =3D 0; i < pdata->num_devices; i++)
-		i2c_new_device(&i2c->adap, pdata->devices + i);
+	dev_info(&pdev->dev, "mapped to 0x%08X, irq=3D%d\n",
+					(unsigned int)i2c->base, irq);
+
+	pdata =3D (struct xiic_i2c_platform_data *) pdev->dev.platform_data;
+	if (pdata) {
+		/* add in known devices to the bus */
+		for (i =3D 0; i < pdata->num_devices; i++)
+			i2c_new_device(&i2c->adap, pdata->devices + i);
+	}
+	of_i2c_register_devices(&i2c->adap);
=20
 	return 0;
=20
@@ -799,12 +808,24 @@ static int __devexit xiic_i2c_remove(struct platf=
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
+#else
+# define xilinx_iic_of_match NULL
+#endif
+
 static struct platform_driver xiic_i2c_driver =3D {
 	.probe   =3D xiic_i2c_probe,
 	.remove  =3D __devexit_p(xiic_i2c_remove),
 	.driver  =3D {
 		.owner =3D THIS_MODULE,
 		.name =3D DRIVER_NAME,
+		.of_match_table =3D xilinx_iic_of_match,
 	},
 };
=20
--=20
1.5.5.6
