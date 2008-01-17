From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-viapro: Add support for the VT8237S
Date: Thu, 17 Jan 2008 15:03:50 +0100
Message-ID: <20080117150350.72d22aed@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add support for another variant of the VT8237. I couldn't test
I2C block support but I assume it is present as well.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/busses/i2c-viapro |    3 ++-
 drivers/i2c/busses/Kconfig          |    2 +-
 drivers/i2c/busses/i2c-viapro.c     |    6 +++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

--- linux-2.6.24-rc8.orig/Documentation/i2c/busses/i2c-viapro	2007-10-10 09=
:57:31.000000000 +0200
+++ linux-2.6.24-rc8/Documentation/i2c/busses/i2c-viapro	2008-01-17 14:45:0=
4.000000000 +0100
@@ -10,7 +10,7 @@ Supported adapters:
   * VIA Technologies, Inc. VT8231, VT8233, VT8233A
     Datasheet: available on request from VIA
 =

-  * VIA Technologies, Inc. VT8235, VT8237R, VT8237A, VT8251
+  * VIA Technologies, Inc. VT8235, VT8237R, VT8237A, VT8237S, VT8251
     Datasheet: available on request and under NDA from VIA
 =

   * VIA Technologies, Inc. CX700
@@ -46,6 +46,7 @@ Your lspci -n listing must show one of t
  device 1106:3177   (VT8235)
  device 1106:3227   (VT8237R)
  device 1106:3337   (VT8237A)
+ device 1106:3372   (VT8237S)
  device 1106:3287   (VT8251)
  device 1106:8324   (CX700)
 =

--- linux-2.6.24-rc8.orig/drivers/i2c/busses/Kconfig	2008-01-17 09:55:33.00=
0000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/busses/Kconfig	2008-01-17 14:44:42.0000000=
00 +0100
@@ -606,7 +606,7 @@ config I2C_VIAPRO
 	    VT8231
 	    VT8233/A
 	    VT8235
-	    VT8237R/A
+	    VT8237R/A/S
 	    VT8251
 	    CX700
 =

--- linux-2.6.24-rc8.orig/drivers/i2c/busses/i2c-viapro.c	2008-01-17 13:59:=
34.000000000 +0100
+++ linux-2.6.24-rc8/drivers/i2c/busses/i2c-viapro.c	2008-01-17 14:51:24.00=
0000000 +0100
@@ -4,7 +4,7 @@
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, Ky=F6sti M=E4lkki <kmalkki@cc.h=
ut.fi>,
     Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
-    Copyright (C) 2005 - 2007  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
+    Copyright (C) 2005 - 2008  Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
 =

     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -35,6 +35,7 @@
    VT8235             0x3177             yes
    VT8237R            0x3227             yes
    VT8237A            0x3337             yes
+   VT8237S            0x3372             yes
    VT8251             0x3287             yes
    CX700              0x8324             yes
 =

@@ -393,6 +394,7 @@ found:
 	case PCI_DEVICE_ID_VIA_8251:
 	case PCI_DEVICE_ID_VIA_8237:
 	case PCI_DEVICE_ID_VIA_8237A:
+	case PCI_DEVICE_ID_VIA_8237S:
 	case PCI_DEVICE_ID_VIA_8235:
 	case PCI_DEVICE_ID_VIA_8233A:
 	case PCI_DEVICE_ID_VIA_8233_0:
@@ -444,6 +446,8 @@ static struct pci_device_id vt596_ids[] =

 	  .driver_data =3D SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237A),
 	  .driver_data =3D SMBBA3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237S),
+	  .driver_data =3D SMBBA3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4),
 	  .driver_data =3D SMBBA1 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8251),


-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
