From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: [PATCH 3/9] I2C: i2c-ocores: Can add I2C devices to the bus
Date: Fri, 05 Jun 2009 15:40:32 +0200
Message-ID: <4A292050.7010602@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is sometimes a need for the ocores driver to add devices to the
bus when installed.

i2c_register_board_info can not always be used, because the I2C devices
 are not known at an early state, they could for instance be connected
 on a I2C bus on a PCI device which has the Open Cores IP.

i2c_new_device can not be used in all cases either since the resulting
bus nummer might be unknown.

The solution is the pass a list of I2C devices in the platform data to
the Open Cores driver. This is useful for MFD drivers.

Signed-off-by: Richard R=F6jfors <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
---
Index: linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(revision 861)
+++ linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(working copy)
@@ -216,6 +216,7 @@
 	struct ocores_i2c_platform_data *pdata;
 	struct resource *res, *res2;
 	int ret;
+	int i;

 	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
@@ -271,6 +272,10 @@
 		goto add_adapter_failed;
 	}

+	/* add in known devices to the bus */
+	for (i =3D 0; i < pdata->num_devices; i++)
+		i2c_new_device(&i2c->adap, pdata->devices + i);
+
 	return 0;

 add_adapter_failed:
Index: linux-2.6.30-rc7/Documentation/i2c/busses/i2c-ocores
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/Documentation/i2c/busses/i2c-ocores	(revision 861)
+++ linux-2.6.30-rc7/Documentation/i2c/busses/i2c-ocores	(working copy)
@@ -20,6 +20,8 @@
 dev.platform_data of the device should also point to a struct
 ocores_i2c_platform_data (see linux/i2c-ocores.h) describing the
 distance between registers and the input clock speed.
+There is also a possibility to attach a list of i2c_board_info which
+the i2c-ocores driver will add to the bus upon creation.

 E.G. something like:

@@ -36,9 +38,24 @@
 	},
 };

+/* optional board info */
+struct i2c_board_info ocores_i2c_board_info[] =3D {
+	{
+		I2C_BOARD_INFO("tsc2003", 0x48),
+		.platform_data =3D &tsc2003_platform_data,
+		.irq =3D TSC_IRQ
+	},
+	{
+		I2C_BOARD_INFO("adv7180", 0x42 >> 1),
+		.irq =3D ADV_IRQ
+	}
+};
+
 static struct ocores_i2c_platform_data myi2c_data =3D {
 	.regstep	=3D 2,		/* two bytes between registers */
 	.clock_khz	=3D 50000,	/* input clock of 50MHz */
+	.devices	=3D ocores_i2c_board_info, /* optional table of devices */
+	.num_devices	=3D ARRAY_SIZE(ocores_i2c_board_info), /* table size */
 };

 static struct platform_device myi2c =3D {
Index: linux-2.6.30-rc7/include/linux/i2c-ocores.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/include/linux/i2c-ocores.h	(revision 861)
+++ linux-2.6.30-rc7/include/linux/i2c-ocores.h	(working copy)
@@ -14,6 +14,8 @@
 struct ocores_i2c_platform_data {
 	u32 regstep;   /* distance between registers */
 	u32 clock_khz; /* input clock in kHz */
+	u8 num_devices; /* number of devices in the devices list */
+	struct i2c_board_info const *devices; /* devices connected to the bus=
 */
 };

 #endif /* _LINUX_I2C_OCORES_H */
