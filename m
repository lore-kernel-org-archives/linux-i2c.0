From: Seth Heasley <seth.heasley@intel.com>
Subject: [PATCH 2.6.26.2][RESEND] irq: irq and pci_ids patch for Intel Ibex Peak DeviceIDs
Date: Mon, 11 Aug 2008 17:01:50 -0700
Message-ID: <200808111701.50662.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757637AbYHKX5M@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: i2c@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, khali@linux-fr.org, jbarnes@virtuousgeek.org
Cc: seth.heasley@intel.com
List-Id: linux-i2c@vger.kernel.org

Resend with proper whitespace.

This patch adds the Intel Ibex Peak (PCH) LPC and SMBus Controller DeviceIDs.

Signed-off-by: Seth Heasley <seth.heasley@intel.com>

--- linux-2.6.26.2/include/linux/pci_ids.h.orig	2008-08-08 11:07:41.000000000 -0700
+++ linux-2.6.26.2/include/linux/pci_ids.h	2008-08-08 11:22:31.000000000 -0700
@@ -2385,6 +2385,9 @@
 #define PCI_DEVICE_ID_INTEL_ICH10_3	0x3a1a
 #define PCI_DEVICE_ID_INTEL_ICH10_4	0x3a30
 #define PCI_DEVICE_ID_INTEL_ICH10_5	0x3a60
+#define PCI_DEVICE_ID_INTEL_PCH_0	0x3b10
+#define PCI_DEVICE_ID_INTEL_PCH_1	0x3b11
+#define PCI_DEVICE_ID_INTEL_PCH_2	0x3b30
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
 #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
 #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
--- linux-2.6.26.2/arch/x86/pci/irq.c.orig	2008-08-08 11:23:03.000000000 -0700
+++ linux-2.6.26.2/arch/x86/pci/irq.c	2008-08-08 11:24:02.000000000 -0700
@@ -589,6 +589,8 @@
 		case PCI_DEVICE_ID_INTEL_ICH10_1:
 		case PCI_DEVICE_ID_INTEL_ICH10_2:
 		case PCI_DEVICE_ID_INTEL_ICH10_3:
+		case PCI_DEVICE_ID_INTEL_PCH_0:
+		case PCI_DEVICE_ID_INTEL_PCH_1:
 			r->name = "PIIX/ICH";
 			r->get = pirq_piix_get;
 			r->set = pirq_piix_set;
