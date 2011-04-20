From: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2.6.39-rc3] i2c-i801: SMBus patch for Intel Panther Point DeviceIDs
Date: Wed, 20 Apr 2011 11:33:39 -0700
Message-ID: <201104201133.39979.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch adds the SMBus controller DeviceID for the Intel Panther Point PCH.

Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
--- linux-2.6.39-rc3/Documentation/i2c/busses/i2c-i801.orig	2011-04-11 17:21:51.000000000 -0700
+++ linux-2.6.39-rc3/Documentation/i2c/busses/i2c-i801	2011-04-14 11:56:59.000000000 -0700
@@ -19,6 +19,7 @@
   * Intel 6 Series (PCH)
   * Intel Patsburg (PCH)
   * Intel DH89xxCC (PCH)
+  * Intel Panther Point (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
--- linux-2.6.39-rc3/drivers/i2c/busses/Kconfig.orig	2011-04-11 17:21:51.000000000 -0700
+++ linux-2.6.39-rc3/drivers/i2c/busses/Kconfig	2011-04-14 12:02:27.000000000 -0700
@@ -101,6 +101,7 @@
 	    6 Series (PCH)
 	    Patsburg (PCH)
 	    DH89xxCC (PCH)
+	    Panther Point (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
--- linux-2.6.39-rc3/drivers/i2c/busses/i2c-i801.c.orig	2011-04-11 17:21:51.000000000 -0700
+++ linux-2.6.39-rc3/drivers/i2c/busses/i2c-i801.c	2011-04-14 12:03:57.000000000 -0700
@@ -50,6 +50,7 @@
   Patsburg (PCH) IDF    0x1d71     32     hard     yes     yes     yes
   Patsburg (PCH) IDF    0x1d72     32     hard     yes     yes     yes
   DH89xxCC (PCH)        0x2330     32     hard     yes     yes     yes
+  Panther Point (PCH)   0x1e22     32     hard     yes     yes     yes
 
   Features supported by this driver:
   Software PEC                     no
@@ -623,6 +624,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PANTHERPOINT_SMBUS) },
 	{ 0, }
 };
 
