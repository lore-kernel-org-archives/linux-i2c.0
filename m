From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.25-rc1] i2c-i801: SMBus patch for Intel ICH10 DeviceID's
Date: Mon, 11 Feb 2008 16:45:17 -0800
Message-ID: <39B20DF628532344BC7A2692CB6AEE07024DFA4C@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761502AbYBLArY@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, linux-kernel@vger.kernel.org, gregkh@suse.de, "Gaston, Jason D" <jason.d.gaston@intel.com>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

This patch adds the Intel ICH10 SMBus Controller DeviceID's and updates
Tolapai support.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>


--- linux-2.6.25-rc1/Documentation/i2c/busses/i2c-i801.orig
2008-02-11 15:17:33.000000000 -0800
+++ linux-2.6.25-rc1/Documentation/i2c/busses/i2c-i801	2008-02-11
15:18:13.000000000 -0800
@@ -12,8 +12,9 @@
   * Intel 82801G (ICH7)
   * Intel 631xESB/632xESB (ESB2)
   * Intel 82801H (ICH8)
-  * Intel ICH9
+  * Intel 82801I (ICH9)
   * Intel Tolapai
+  * Intel ICH10
    Datasheets: Publicly available at the Intel website
 
 Authors: 
--- linux-2.6.25-rc1/drivers/i2c/busses/i2c-i801.c.orig	2008-02-11
15:10:52.000000000 -0800
+++ linux-2.6.25-rc1/drivers/i2c/busses/i2c-i801.c	2008-02-11
16:30:11.000000000 -0800
@@ -40,7 +40,9 @@
   82801G   (ICH7)       0x27da     32     hard     yes     yes     yes
   82801H   (ICH8)       0x283e     32     hard     yes     yes     yes
   82801I   (ICH9)       0x2930     32     hard     yes     yes     yes
-  Tolapai               0x5032     32     hard     yes     ?       ?
+  Tolapai               0x5032     32     hard     yes     yes     yes
+  ICH10                 0x3a30     32     hard     yes     yes     yes
+  ICH10                 0x3a60     32     hard     yes     yes     yes
 
   Features supported by this driver:
   Software PEC                     no
@@ -588,6 +590,8 @@
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH8_5) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH9_6) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TOLAPAI_1)
},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_4)
},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5)
},
 	{ 0, }
 };
 
@@ -608,10 +612,12 @@
 	case PCI_DEVICE_ID_INTEL_ESB2_17:
 	case PCI_DEVICE_ID_INTEL_ICH8_5:
 	case PCI_DEVICE_ID_INTEL_ICH9_6:
+	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
+	case PCI_DEVICE_ID_INTEL_ICH10_4:
+	case PCI_DEVICE_ID_INTEL_ICH10_5:
 		i801_features |= FEATURE_I2C_BLOCK_READ;
 		/* fall through */
 	case PCI_DEVICE_ID_INTEL_82801DB_3:
-	case PCI_DEVICE_ID_INTEL_TOLAPAI_1:
 		i801_features |= FEATURE_SMBUS_PEC;
 		i801_features |= FEATURE_BLOCK_BUFFER;
 		break;
--- linux-2.6.25-rc1/drivers/i2c/busses/Kconfig.orig	2008-02-11
15:10:18.000000000 -0800
+++ linux-2.6.25-rc1/drivers/i2c/busses/Kconfig	2008-02-11
16:32:10.000000000 -0800
@@ -177,6 +177,8 @@
 	    ESB2
 	    ICH8
 	    ICH9
+	    Tolapai
+	    ICH10
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
--- linux-2.6.25-rc1/include/linux/pci_ids.h.orig	2008-02-11
15:18:58.000000000 -0800
+++ linux-2.6.25-rc1/include/linux/pci_ids.h	2008-02-11
15:20:45.000000000 -0800
@@ -2373,6 +2373,12 @@
 #define PCI_DEVICE_ID_INTEL_MCH_PC1	0x359a
 #define PCI_DEVICE_ID_INTEL_E7525_MCH	0x359e
 #define PCI_DEVICE_ID_INTEL_IOAT_CNB	0x360b
+#define PCI_DEVICE_ID_INTEL_ICH10_0	0x3a14
+#define PCI_DEVICE_ID_INTEL_ICH10_1	0x3a16
+#define PCI_DEVICE_ID_INTEL_ICH10_2	0x3a18
+#define PCI_DEVICE_ID_INTEL_ICH10_3	0x3a1a
+#define PCI_DEVICE_ID_INTEL_ICH10_4	0x3a30
+#define PCI_DEVICE_ID_INTEL_ICH10_5	0x3a60
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
 #define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
 #define PCI_DEVICE_ID_INTEL_TOLAPAI_0	0x5031
