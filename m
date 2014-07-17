From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2] i2c-i801: Add device ID for Intel Wildcat Point PCH
Date: Thu, 17 Jul 2014 15:04:41 +0200
Message-ID: <20140717150441.7e24cd1d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
Untested, but the datasheet show full compatibility with previous
chipsets.

Changes since v1:
 * Rebased, no other change

 Documentation/i2c/busses/i2c-i801 |    1 +
 drivers/i2c/busses/Kconfig        |    1 +
 drivers/i2c/busses/i2c-i801.c     |    3 +++
 3 files changed, 5 insertions(+)

--- linux-3.16-rc4.orig/Documentation/i2c/busses/i2c-i801	2014-07-17 12:59:12.569368248 +0200
+++ linux-3.16-rc4/Documentation/i2c/busses/i2c-i801	2014-07-17 13:02:02.011437148 +0200
@@ -25,6 +25,7 @@ Supported adapters:
   * Intel Avoton (SOC)
   * Intel Wellsburg (PCH)
   * Intel Coleto Creek (PCH)
+  * Intel Wildcat Point (PCH)
   * Intel Wildcat Point-LP (PCH)
   * Intel BayTrail (SOC)
    Datasheets: Publicly available at the Intel website
--- linux-3.16-rc4.orig/drivers/i2c/busses/Kconfig	2014-07-17 12:59:12.569368248 +0200
+++ linux-3.16-rc4/drivers/i2c/busses/Kconfig	2014-07-17 13:02:02.011437148 +0200
@@ -109,6 +109,7 @@ config I2C_I801
 	    Avoton (SOC)
 	    Wellsburg (PCH)
 	    Coleto Creek (PCH)
+	    Wildcat Point (PCH)
 	    Wildcat Point-LP (PCH)
 	    BayTrail (SOC)
 
--- linux-3.16-rc4.orig/drivers/i2c/busses/i2c-i801.c	2014-07-17 12:59:12.570368267 +0200
+++ linux-3.16-rc4/drivers/i2c/busses/i2c-i801.c	2014-07-17 13:02:02.012437163 +0200
@@ -59,6 +59,7 @@
  * Wellsburg (PCH) MS		0x8d7e	32	hard	yes	yes	yes
  * Wellsburg (PCH) MS		0x8d7f	32	hard	yes	yes	yes
  * Coleto Creek (PCH)		0x23b0	32	hard	yes	yes	yes
+ * Wildcat Point (PCH)		0x8ca2	32	hard	yes	yes	yes
  * Wildcat Point-LP (PCH)	0x9ca2	32	hard	yes	yes	yes
  * BayTrail (SOC)		0x0f12	32	hard	yes	yes	yes
  *
@@ -175,6 +176,7 @@
 #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS		0x23b0
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS		0x3b30
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS		0x8c22
+#define PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS		0x8ca2
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS		0x8d22
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS0		0x8d7d
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1		0x8d7e
@@ -823,6 +825,7 @@ static const struct pci_device_id i801_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS2) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BAYTRAIL_SMBUS) },
 	{ 0, }


-- 
Jean Delvare
SUSE L3 Support
