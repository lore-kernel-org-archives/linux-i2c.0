From: =?UTF-8?B?UmljaGFyZCBSwprDtmpmb3Jz?=
	<richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
Subject: [PATCH] I2C: ocores can add I2C devices to the bus
Date: Tue, 02 Jun 2009 19:52:40 +0200
Message-ID: <4A2566E8.7080404@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, =?UTF-8?B?J1JpY2hhcmQgUsKaw7ZqZm9ycyc=?= <richard.rojfors.ext-l7gf1WXxx3uGw+nKnLezzg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is sometimes a need for the ocores driver to add devices to the b=
us when installed.

i2c_register_board_info can not always be used, because the I2C devices=
 are not known at an early state,
they could for instance be connected on a I2C bus on a PCI device which=
 has the Open Cores IP.

i2c_new_device can not be used in all cases either since the resulting =
bus nummer might be unknown.

The solution is the pass a list of I2C devices in the platform data to =
the Open Cores driver. Is
useful for MFD drivers for instance.


Signed-off-by: Richard R=C3=B6jfors <richard.rojfors.ext-l7gf1WXxx3ujphq+ikeySQ@public.gmane.org=
m>
---
Index: linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(revision 861)
+++ linux-2.6.30-rc7/drivers/i2c/busses/i2c-ocores.c	(revision 862)
@@ -216,6 +216,7 @@
 	struct ocores_i2c_platform_data *pdata;
 	struct resource *res, *res2;
 	int ret;
+	u8 i;

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
Index: linux-2.6.30-rc7/include/linux/i2c-ocores.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.30-rc7/include/linux/i2c-ocores.h	(revision 861)
+++ linux-2.6.30-rc7/include/linux/i2c-ocores.h	(revision 862)
@@ -14,6 +14,8 @@
 struct ocores_i2c_platform_data {
 	u32 regstep;   /* distance between registers */
 	u32 clock_khz; /* input clock in kHz */
+	u8 num_devices; /* number of devices in the devices list */
+	struct i2c_board_info const *devices; /* devices connected to the bus=
 */
 };

 #endif /* _LINUX_I2C_OCORES_H */
