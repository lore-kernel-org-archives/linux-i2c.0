From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Drop stray references to lm_sensors
Date: Mon, 16 Jun 2008 13:59:56 +0200
Message-ID: <20080616135956.233c2b6d@hyperion.delvare>
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

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-ali1535.c |    2 --
 drivers/i2c/busses/i2c-ali15x3.c |    2 --
 drivers/i2c/busses/i2c-amd756.c  |    3 ---
 drivers/i2c/busses/i2c-hydra.c   |    3 ---
 drivers/i2c/busses/i2c-i801.c    |    2 --
 drivers/i2c/busses/i2c-piix4.c   |    2 --
 drivers/i2c/busses/i2c-sis5595.c |    2 --
 drivers/i2c/busses/i2c-sis630.c  |    3 ---
 drivers/i2c/busses/i2c-sis96x.c  |    3 ---
 drivers/i2c/busses/i2c-via.c     |    3 ---
 drivers/i2c/busses/i2c-viapro.c  |    2 --
 drivers/i2c/busses/i2c-voodoo3.c |    2 --
 drivers/i2c/chips/eeprom.c       |    2 --
 drivers/i2c/chips/pcf8574.c      |    2 --
 drivers/i2c/chips/pcf8591.c      |    2 --
 15 files changed, 35 deletions(-)

--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-ali1535.c	2008-06-16 13:26=
:02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-ali1535.c	2008-06-16 13:57:55.0=
00000000 +0200
@@ -1,6 +1,4 @@
 /*
-    i2c-ali1535.c - Part of lm_sensors, Linux kernel modules for hardware
-                    monitoring
     Copyright (c) 2000  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, =

                         Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, =

                         Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-ali15x3.c	2008-06-16 13:26=
:02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-ali15x3.c	2008-06-16 13:57:34.0=
00000000 +0200
@@ -1,6 +1,4 @@
 /*
-    ali15x3.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org> and
     Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-amd756.c	2008-06-16 13:26:=
02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-amd756.c	2008-06-16 13:57:16.00=
0000000 +0200
@@ -1,7 +1,4 @@
 /*
-    amd756.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
-
     Copyright (c) 1999-2002 Merlin Hughes <merlin-/9H/vdrqoiodnm+yROfE0A@public.gmane.org>
 =

     Shamelessly ripped from i2c-piix4.c:
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-hydra.c	2008-04-17 04:49:4=
4.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-hydra.c	2008-06-16 13:57:47.000=
000000 +0200
@@ -1,7 +1,4 @@
 /*
-    i2c-hydra.c - Part of lm_sensors,  Linux kernel modules
-                  for hardware monitoring
-
     i2c Support for the Apple `Hydra' Mac I/O
 =

     Copyright (c) 1999-2004 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-i801.c	2008-06-16 13:26:02=
.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-i801.c	2008-06-16 13:57:51.0000=
00000 +0200
@@ -1,6 +1,4 @@
 /*
-    i2c-i801.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, and Mark D. Studebaker
     <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-piix4.c	2008-06-16 13:26:0=
2.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-piix4.c	2008-06-16 13:57:27.000=
000000 +0200
@@ -1,6 +1,4 @@
 /*
-    piix4.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1998 - 2002 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
 =

--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-sis5595.c	2008-06-16 13:26=
:02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-sis5595.c	2008-06-16 13:57:24.0=
00000000 +0200
@@ -1,6 +1,4 @@
 /*
-    sis5595.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
 =

--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-sis630.c	2008-06-16 13:26:=
02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-sis630.c	2008-06-16 13:57:31.00=
0000000 +0200
@@ -1,7 +1,4 @@
 /*
-    i2c-sis630.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
-
     Copyright (c) 2002,2003 Alexander Malysh <amalysh-S0/GAf8tV78@public.gmane.org>
 =

     This program is free software; you can redistribute it and/or modify
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-sis96x.c	2008-06-16 13:26:=
02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-sis96x.c	2008-06-16 13:57:37.00=
0000000 +0200
@@ -1,7 +1,4 @@
 /*
-    sis96x.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
-
     Copyright (c) 2003 Mark M. Hoffman <mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org>
 =

     This program is free software; you can redistribute it and/or modify
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-via.c	2008-06-16 13:26:02.=
000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-via.c	2008-06-16 13:57:59.00000=
0000 +0200
@@ -1,7 +1,4 @@
 /*
-    i2c-via.c - Part of lm_sensors,  Linux kernel modules
-                for hardware monitoring
-
     i2c Support for Via Technologies 82C586B South Bridge
 =

     Copyright (c) 1998, 1999 Ky=F6sti M=E4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-viapro.c	2008-06-16 13:26:=
02.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-viapro.c	2008-06-16 13:57:20.00=
0000000 +0200
@@ -1,6 +1,4 @@
 /*
-    i2c-viapro.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1998 - 2002  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>, Ky=F6sti M=E4lkki <kmalkki@cc.h=
ut.fi>,
     Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/busses/i2c-voodoo3.c	2008-04-17 04:49=
:44.000000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/busses/i2c-voodoo3.c	2008-06-16 13:57:41.0=
00000000 +0200
@@ -1,6 +1,4 @@
 /*
-    voodoo3.c - Part of lm_sensors, Linux kernel modules for hardware
-              monitoring
     Copyright (c) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
     Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
     Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org>, and
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/eeprom.c	2008-06-16 13:26:02.00=
0000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/eeprom.c	2008-06-16 13:56:51.0000000=
00 +0200
@@ -1,6 +1,4 @@
 /*
-    eeprom.c - Part of lm_sensors, Linux kernel modules for hardware
-               monitoring
     Copyright (C) 1998, 1999  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
 			       Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
     Copyright (C) 2003 Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/pcf8574.c	2008-04-17 04:49:44.0=
00000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/pcf8574.c	2008-06-16 13:56:55.000000=
000 +0200
@@ -1,6 +1,4 @@
 /*
-    pcf8574.c - Part of lm_sensors, Linux kernel modules for hardware
-             monitoring
     Copyright (c) 2000  Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, =

                         Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
                         Dan Eaton <dan.eaton-RtyX3GHucphnQYSypqKXDg@public.gmane.org>
--- linux-2.6.26-rc6.orig/drivers/i2c/chips/pcf8591.c	2008-04-17 04:49:44.0=
00000000 +0200
+++ linux-2.6.26-rc6/drivers/i2c/chips/pcf8591.c	2008-06-16 13:57:05.000000=
000 +0200
@@ -1,6 +1,4 @@
 /*
-    pcf8591.c - Part of lm_sensors, Linux kernel modules for hardware
-                monitoring
     Copyright (C) 2001-2004 Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org>
     Ported to Linux 2.6 by Aurelien Jarno <aurelien-rXXEIb44qovR7s880joybQ@public.gmane.org> with =

     the help of Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>


-- =

Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
