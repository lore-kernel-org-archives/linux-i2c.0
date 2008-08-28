From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.27-rc4][RESEND] i2c-i801: SMBus patch for Intel Ibex Peak DeviceIDs
Date: Thu, 28 Aug 2008 15:43:00 -0700
Message-ID: <200808281543.00557.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, khali@linux-fr.org, i2c@lm-sensors.org, linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org
Cc: seth.heasley@intel.com
List-Id: linux-i2c@vger.kernel.org

This patch adds the Intel Ibex Peak (PCH) SMBus Controller DeviceIDs.

Changes are reflected in i2c-i801.c in response to updates to pci_ids.h.  The SMBus Controller is now referred to as PCI_DEVICE_ID_INTEL_PCH_SMBUS, a change to the old naming convention of PCI_DEVICE_ID_INTEL_PCH_x.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6/Documentation/i2c/busses/i2c-i801.orig	2008-08-28 10:11:27.000000000 -0700
+++ linux-2.6/Documentation/i2c/busses/i2c-i801	2008-08-28 10:25:24.000000000 -0700
@@ -13,8 +13,9 @@
   * Intel 631xESB/632xESB (ESB2)
   * Intel 82801H (ICH8)
   * Intel 82801I (ICH9)
-  * Intel Tolapai
-  * Intel ICH10
+  * Intel EP80579 (Tolapai)
+  * Intel 82801JI (ICH10)
+  * Intel PCH
    Datasheets: Publicly available at the Intel website
 
 Authors: 
@@ -32,7 +33,7 @@
 -----------
 
 The ICH (properly known as the 82801AA), ICH0 (82801AB), ICH2 (82801BA),
-ICH3 (82801CA/CAM) and later devices are Intel chips that are a part of
+ICH3 (82801CA/CAM) and later devices (PCH) are Intel chips that are a part of
 Intel's '810' chipset for Celeron-based PCs, '810E' chipset for
 Pentium-based PCs, '815E' chipset, and others.
 
--- linux-2.6/drivers/i2c/busses/i2c-i801.c.orig	2008-08-27 11:52:45.000000000 -0700
+++ linux-2.6/drivers/i2c/busses/i2c-i801.c	2008-08-28 15:01:14.000000000 -0700
@@ -577,6 +577,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_SMBUS) },
 	{ 0, }
 };
 
@@ -600,6 +601,7 @@
 	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
 	case PCI_DEVICE_ID_INTEL_ICH10_4:
 	case PCI_DEVICE_ID_INTEL_ICH10_5:
+	case PCI_DEVICE_ID_INTEL_PCH_SMBUS:
 		i801_features |= FEATURE_I2C_BLOCK_READ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
--- linux-2.6/drivers/i2c/busses/Kconfig.orig	2008-08-27 12:11:03.000000000 -0700
+++ linux-2.6/drivers/i2c/busses/Kconfig	2008-08-27 12:11:24.000000000 -0700
@@ -97,6 +97,7 @@
 	    ICH9
 	    Tolapai
 	    ICH10
+	    PCH
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
