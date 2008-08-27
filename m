From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.27-rc4] i2c-i801: SMBus patch for Intel Ibex Peak DeviceIDs
Date: Wed, 27 Aug 2008 16:52:37 -0700
Message-ID: <200808271652.37597.seth.heasley@intel.com>
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

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6/drivers/i2c/busses/Kconfig.orig	2008-08-27 12:11:03.000000000 -0700
+++ linux-2.6/drivers/i2c/busses/Kconfig	2008-08-27 12:11:24.000000000 -0700
@@ -97,6 +97,7 @@
 	    ICH9
 	    Tolapai
 	    ICH10
+	    PCH
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
--- linux-2.6/drivers/i2c/busses/i2c-i801.c.orig	2008-08-27 11:52:45.000000000 -0700
+++ linux-2.6/drivers/i2c/busses/i2c-i801.c	2008-08-27 12:10:50.000000000 -0700
@@ -577,6 +577,7 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PCH_32) },
 	{ 0, }
 };
 
@@ -600,6 +601,7 @@
 	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
 	case PCI_DEVICE_ID_INTEL_ICH10_4:
 	case PCI_DEVICE_ID_INTEL_ICH10_5:
+	case PCI_DEVICE_ID_INTEL_PCH_32:
 		i801_features |= FEATURE_I2C_BLOCK_READ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
