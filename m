From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: Various cleanups
Date: Sun, 1 May 2011 18:17:14 +0200
Message-ID: <20110501181714.36df5b7f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

* Fix white space.
* Prefix defines with PORT_ to avoid collision with macros from
  <linux/parport.h>.
* Add const markers where possible.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport-light.c |   10 ++--
 drivers/i2c/busses/i2c-parport.c       |   20 ++++----
 drivers/i2c/busses/i2c-parport.h       |   74 +++++++++++++++---------=
--------
 3 files changed, 50 insertions(+), 54 deletions(-)

--- linux-2.6.39-rc5.orig/drivers/i2c/busses/i2c-parport.c	2011-05-01 1=
4:16:26.000000000 +0200
+++ linux-2.6.39-rc5/drivers/i2c/busses/i2c-parport.c	2011-05-01 15:27:=
04.000000000 +0200
@@ -2,13 +2,13 @@
  * i2c-parport.c I2C bus over parallel port                           =
      *
  * -------------------------------------------------------------------=
----- *
    Copyright (C) 2003-2011 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-  =20
+
    Based on older i2c-philips-par.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
    With some changes from:
    Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>
    Ky=F6sti M=E4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>
-  =20
+
    This program is free software; you can redistribute it and/or modif=
y
    it under the terms of the GNU General Public License as published b=
y
    the Free Software Foundation; either version 2 of the License, or
@@ -78,13 +78,13 @@ static unsigned char port_read_control(s
 	return parport_read_control(p);
 }
=20
-static void (*port_write[])(struct parport *, unsigned char) =3D {
+static void (* const port_write[])(struct parport *, unsigned char) =3D=
 {
 	port_write_data,
 	NULL,
 	port_write_control,
 };
=20
-static unsigned char (*port_read[])(struct parport *) =3D {
+static unsigned char (* const port_read[])(struct parport *) =3D {
 	port_read_data,
 	port_read_status,
 	port_read_control,
@@ -147,7 +147,7 @@ static const struct i2c_algo_bit_data pa
 	.getscl		=3D parport_getscl,
 	.udelay		=3D 10, /* ~50 kbps */
 	.timeout	=3D HZ,
-};=20
+};
=20
 /* ----- I2c and parallel port call-back functions and structures ----=
----- */
=20
@@ -164,10 +164,10 @@ void i2c_parport_irq(void *data)
 			"SMBus alert received but no ARA client!\n");
 }
=20
-static void i2c_parport_attach (struct parport *port)
+static void i2c_parport_attach(struct parport *port)
 {
 	struct i2c_par *adapter;
-=09
+
 	adapter =3D kzalloc(sizeof(struct i2c_par), GFP_KERNEL);
 	if (adapter =3D=3D NULL) {
 		printk(KERN_ERR "i2c-parport: Failed to kzalloc\n");
@@ -234,7 +234,7 @@ static void i2c_parport_attach (struct p
 	mutex_lock(&adapter_list_lock);
 	list_add_tail(&adapter->node, &adapter_list);
 	mutex_unlock(&adapter_list_lock);
-        return;
+	return;
=20
 ERROR1:
 	parport_release(adapter->pdev);
@@ -243,7 +243,7 @@ ERROR0:
 	kfree(adapter);
 }
=20
-static void i2c_parport_detach (struct parport *port)
+static void i2c_parport_detach(struct parport *port)
 {
 	struct i2c_par *adapter, *_n;
=20
@@ -260,7 +260,7 @@ static void i2c_parport_detach (struct p
 			/* Un-init if needed (power off...) */
 			if (adapter_parm[type].init.val)
 				line_set(port, 0, &adapter_parm[type].init);
-			=09
+
 			parport_release(adapter->pdev);
 			parport_unregister_device(adapter->pdev);
 			list_del(&adapter->node);
--- linux-2.6.39-rc5.orig/drivers/i2c/busses/i2c-parport.h	2010-08-02 0=
0:11:14.000000000 +0200
+++ linux-2.6.39-rc5/drivers/i2c/busses/i2c-parport.h	2011-05-01 16:35:=
13.000000000 +0200
@@ -2,7 +2,7 @@
  * i2c-parport.h I2C bus over parallel port                           =
      *
  * -------------------------------------------------------------------=
----- *
    Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-  =20
+
    This program is free software; you can redistribute it and/or modif=
y
    it under the terms of the GNU General Public License as published b=
y
    the Free Software Foundation; either version 2 of the License, or
@@ -18,13 +18,9 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * -------------------------------------------------------------------=
----- */
=20
-#ifdef DATA
-#undef DATA
-#endif
-
-#define DATA	0
-#define STAT	1
-#define CTRL	2
+#define PORT_DATA	0
+#define PORT_STAT	1
+#define PORT_CTRL	2
=20
 struct lineop {
 	u8 val;
@@ -41,61 +37,61 @@ struct adapter_parm {
 	unsigned int smbus_alert:1;
 };
=20
-static struct adapter_parm adapter_parm[] =3D {
+static const struct adapter_parm adapter_parm[] =3D {
 	/* type 0: Philips adapter */
 	{
-		.setsda	=3D { 0x80, DATA, 1 },
-		.setscl	=3D { 0x08, CTRL, 0 },
-		.getsda	=3D { 0x80, STAT, 0 },
-		.getscl	=3D { 0x08, STAT, 0 },
+		.setsda	=3D { 0x80, PORT_DATA, 1 },
+		.setscl	=3D { 0x08, PORT_CTRL, 0 },
+		.getsda	=3D { 0x80, PORT_STAT, 0 },
+		.getscl	=3D { 0x08, PORT_STAT, 0 },
 	},
 	/* type 1: home brew teletext adapter */
 	{
-		.setsda	=3D { 0x02, DATA, 0 },
-		.setscl	=3D { 0x01, DATA, 0 },
-		.getsda	=3D { 0x80, STAT, 1 },
+		.setsda	=3D { 0x02, PORT_DATA, 0 },
+		.setscl	=3D { 0x01, PORT_DATA, 0 },
+		.getsda	=3D { 0x80, PORT_STAT, 1 },
 	},
 	/* type 2: Velleman K8000 adapter */
 	{
-		.setsda	=3D { 0x02, CTRL, 1 },
-		.setscl	=3D { 0x08, CTRL, 1 },
-		.getsda	=3D { 0x10, STAT, 0 },
+		.setsda	=3D { 0x02, PORT_CTRL, 1 },
+		.setscl	=3D { 0x08, PORT_CTRL, 1 },
+		.getsda	=3D { 0x10, PORT_STAT, 0 },
 	},
 	/* type 3: ELV adapter */
 	{
-		.setsda	=3D { 0x02, DATA, 1 },
-		.setscl	=3D { 0x01, DATA, 1 },
-		.getsda	=3D { 0x40, STAT, 1 },
-		.getscl	=3D { 0x08, STAT, 1 },
+		.setsda	=3D { 0x02, PORT_DATA, 1 },
+		.setscl	=3D { 0x01, PORT_DATA, 1 },
+		.getsda	=3D { 0x40, PORT_STAT, 1 },
+		.getscl	=3D { 0x08, PORT_STAT, 1 },
 	},
 	/* type 4: ADM1032 evaluation board */
 	{
-		.setsda	=3D { 0x02, DATA, 1 },
-		.setscl	=3D { 0x01, DATA, 1 },
-		.getsda	=3D { 0x10, STAT, 1 },
-		.init	=3D { 0xf0, DATA, 0 },
+		.setsda	=3D { 0x02, PORT_DATA, 1 },
+		.setscl	=3D { 0x01, PORT_DATA, 1 },
+		.getsda	=3D { 0x10, PORT_STAT, 1 },
+		.init	=3D { 0xf0, PORT_DATA, 0 },
 		.smbus_alert =3D 1,
 	},
 	/* type 5: ADM1025, ADM1030 and ADM1031 evaluation boards */
 	{
-		.setsda	=3D { 0x02, DATA, 1 },
-		.setscl	=3D { 0x01, DATA, 1 },
-		.getsda	=3D { 0x10, STAT, 1 },
+		.setsda	=3D { 0x02, PORT_DATA, 1 },
+		.setscl	=3D { 0x01, PORT_DATA, 1 },
+		.getsda	=3D { 0x10, PORT_STAT, 1 },
 	},
 	/* type 6: Barco LPT->DVI (K5800236) adapter */
 	{
-		.setsda	=3D { 0x02, DATA, 1 },
-		.setscl	=3D { 0x01, DATA, 1 },
-		.getsda	=3D { 0x20, STAT, 0 },
-		.getscl	=3D { 0x40, STAT, 0 },
-		.init	=3D { 0xfc, DATA, 0 },
+		.setsda	=3D { 0x02, PORT_DATA, 1 },
+		.setscl	=3D { 0x01, PORT_DATA, 1 },
+		.getsda	=3D { 0x20, PORT_STAT, 0 },
+		.getscl	=3D { 0x40, PORT_STAT, 0 },
+		.init	=3D { 0xfc, PORT_DATA, 0 },
 	},
 	/* type 7: One For All JP1 parallel port adapter */
 	{
-		.setsda	=3D { 0x01, DATA, 0 },
-		.setscl	=3D { 0x02, DATA, 0 },
-		.getsda	=3D { 0x80, STAT, 1 },
-		.init	=3D { 0x04, DATA, 1 },
+		.setsda	=3D { 0x01, PORT_DATA, 0 },
+		.setscl	=3D { 0x02, PORT_DATA, 0 },
+		.getsda	=3D { 0x80, PORT_STAT, 1 },
+		.init	=3D { 0x04, PORT_DATA, 1 },
 	},
 };
=20
--- linux-2.6.39-rc5.orig/drivers/i2c/busses/i2c-parport-light.c	2010-0=
8-02 00:11:14.000000000 +0200
+++ linux-2.6.39-rc5/drivers/i2c/busses/i2c-parport-light.c	2011-05-01 =
16:40:01.000000000 +0200
@@ -2,13 +2,13 @@
  * i2c-parport-light.c I2C bus over parallel port                     =
      *
  * -------------------------------------------------------------------=
----- *
    Copyright (C) 2003-2010 Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
-  =20
+
    Based on older i2c-velleman.c driver
    Copyright (C) 1995-2000 Simon G. Vogl
    With some changes from:
    Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>
    Ky=F6sti M=E4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>
-  =20
+
    This program is free software; you can redistribute it and/or modif=
y
    it under the terms of the GNU General Public License as published b=
y
    the Free Software Foundation; either version 2 of the License, or
@@ -114,7 +114,7 @@ static struct i2c_algo_bit_data parport_
 	.getscl		=3D parport_getscl,
 	.udelay		=3D 50,
 	.timeout	=3D HZ,
-};=20
+};
=20
 /* ----- Driver registration -----------------------------------------=
----- */
=20
@@ -132,7 +132,7 @@ static struct i2c_smbus_alert_setup aler
 static struct i2c_client *ara;
 static struct lineop parport_ctrl_irq =3D {
 	.val		=3D (1 << 4),
-	.port		=3D CTRL,
+	.port		=3D PORT_CTRL,
 };
=20
 static int __devinit i2c_parport_probe(struct platform_device *pdev)
@@ -245,7 +245,7 @@ static int __init i2c_parport_init(void)
 	if (irq !=3D 0)
 		pr_info(DRVNAME ": using irq %d\n", irq);
=20
-        if (!adapter_parm[type].getscl.val)
+	if (!adapter_parm[type].getscl.val)
 		parport_algo_data.getscl =3D NULL;
=20
 	/* Sets global pdev as a side effect */


--=20
Jean Delvare
