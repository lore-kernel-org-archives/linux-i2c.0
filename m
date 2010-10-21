From: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2.6.36-next-20101021] SMBus patch for Intel Patsburg DeviceIDs
Date: Thu, 21 Oct 2010 11:04:51 -0700
Message-ID: <201010211104.51630.seth.heasley__41640.7740595334$1287685225$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org
Cc: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch adds support for the Intel Patsburg PCH SMBus Controller.

Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--- linux-2.6.35.7/include/linux/pci_ids.h.orig	2010-10-20 16:10:02.000000000 -0700
+++ linux-2.6.35.7/include/linux/pci_ids.h	2010-10-20 16:09:01.000000000 -0700
@@ -2423,6 +2423,7 @@
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS	0x1c22
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f
+#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS	0x1d22
 #define PCI_DEVICE_ID_INTEL_PATSBURG_LPC	0x1d40
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
--- linux-2.6.35.7/drivers/i2c/busses/Kconfig.orig	2010-10-20 16:13:38.000000000 -0700
+++ linux-2.6.35.7/drivers/i2c/busses/Kconfig	2010-10-20 16:10:55.000000000 -0700
@@ -99,6 +99,7 @@
 	    ICH10
 	    5/3400 Series (PCH)
 	    Cougar Point (PCH)
+	    Patsburg (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
--- linux-2.6.35.7/drivers/i2c/busses/i2c-i801.c.orig	2010-10-20 16:12:06.000000000 -0700
+++ linux-2.6.35.7/drivers/i2c/busses/i2c-i801.c	2010-10-20 16:12:27.000000000 -0700
@@ -43,6 +43,7 @@
   ICH10                 0x3a60     32     hard     yes     yes     yes
   5/3400 Series (PCH)   0x3b30     32     hard     yes     yes     yes
   Cougar Point (PCH)    0x1c22     32     hard     yes     yes     yes
+  Patsburg (PCH)        0x1d22     32     hard     yes     yes     yes
 
   Features supported by this driver:
   Software PEC                     no
@@ -592,6 +593,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS) },
 	{ 0, }
 };
 
--- linux-2.6.35.7/Documentation/i2c/busses/i2c-i801.orig	2010-10-20 16:16:01.000000000 -0700
+++ linux-2.6.35.7/Documentation/i2c/busses/i2c-i801	2010-10-20 16:15:17.000000000 -0700
@@ -15,8 +15,9 @@
   * Intel 82801I (ICH9)
   * Intel EP80579 (Tolapai)
   * Intel 82801JI (ICH10)
-  * Intel 3400/5 Series (PCH)
+  * Intel 5/3400 Series (PCH)
   * Intel Cougar Point (PCH)
+  * Intel Patsburg (PCH)
    Datasheets: Publicly available at the Intel website
 
 Authors: 
