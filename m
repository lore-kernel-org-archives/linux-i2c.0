From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Get rid of <linux/i2c-id.h>
Date: Sun, 30 Jan 2011 20:46:25 +0100
Message-ID: <20110130204625.101366e8@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The last remaining ID in <linux/i2c-id.h> is no longer used anywhere,
so we can finally get rid of it.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 include/linux/i2c-id.h |   37 -------------------------------------
 include/linux/i2c.h    |    1 -
 2 files changed, 38 deletions(-)

--- linux-2.6.38-rc2.orig/include/linux/i2c-id.h	2011-01-05 21:24:25.000000000 +0100
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,37 +0,0 @@
-/* ------------------------------------------------------------------------- */
-/*									     */
-/* i2c-id.h - identifier values for i2c drivers and adapters		     */
-/*									     */
-/* ------------------------------------------------------------------------- */
-/*   Copyright (C) 1995-1999 Simon G. Vogl
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
-/* ------------------------------------------------------------------------- */
-
-#ifndef LINUX_I2C_ID_H
-#define LINUX_I2C_ID_H
-
-/* Please note that I2C driver IDs are optional. They are only needed if a
-   legacy chip driver needs to identify a bus or a bus driver needs to
-   identify a legacy client. If you don't need them, just don't set them. */
-
-/*
- * ---- Adapter types ----------------------------------------------------
- */
-
-/* --- Bit algorithm adapters						*/
-#define I2C_HW_B_CX2388x	0x01001b /* connexant 2388x based tv cards */
-
-#endif /* LINUX_I2C_ID_H */
--- linux-2.6.38-rc2.orig/include/linux/i2c.h	2011-01-19 14:44:25.000000000 +0100
+++ linux-2.6.38-rc2/include/linux/i2c.h	2011-01-30 16:16:41.000000000 +0100
@@ -29,7 +29,6 @@
 #include <linux/types.h>
 #ifdef __KERNEL__
 #include <linux/module.h>
-#include <linux/i2c-id.h>
 #include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */


-- 
Jean Delvare
