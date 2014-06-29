From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH] i2c-i801: Add device ID for Intel Wildcat Point PCH
Date: Sun, 29 Jun 2014 21:00:54 +0200
Message-ID: <20140629210054.6a51c91f@endymion.delvare>
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

 Documentation/i2c/busses/i2c-i801 |    1 +
 drivers/i2c/busses/Kconfig        |    1 +
 drivers/i2c/busses/i2c-i801.c     |    3 +++
 3 files changed, 5 insertions(+)

--- linux-3.16-rc2.orig/Documentation/i2c/busses/i2c-i801	2014-06-16 05:45:28.000000000 +0200
+++ linux-3.16-rc2/Documentation/i2c/busses/i2c-i801	2014-06-29 20:49:27.079679858 +0200
@@ -25,6 +25,7 @@ Supported adapters:
   * Intel Avoton (SOC)
   * Intel Wellsburg (PCH)
   * Intel Coleto Creek (PCH)
+  * Intel Wildcat Point (PCH)
   * Intel Wildcat Point-LP (PCH)
   * Intel BayTrail (SOC)
    Datasheets: Publicly available at the Intel website
--- linux-3.16-rc2.orig/drivers/i2c/busses/Kconfig	2014-06-23 10:45:34.372425164 +0200
+++ linux-3.16-rc2/drivers/i2c/busses/Kconfig	2014-06-29 20:48:02.904000652 +0200
@@ -109,6 +109,7 @@ config I2C_I801
 	    Avoton (SOC)
 	    Wellsburg (PCH)
 	    Coleto Creek (PCH)
+	    Wildcat Point (PCH)
 	    Wildcat Point-LP (PCH)
 	    BayTrail (SOC)
 
--- linux-3.16-rc2.orig/drivers/i2c/busses/i2c-i801.c	2014-06-25 18:19:11.531786078 +0200
+++ linux-3.16-rc2/drivers/i2c/busses/i2c-i801.c	2014-06-29 20:49:14.062420369 +0200
@@ -59,6 +59,7 @@
  * Wellsburg (PCH) MS      0x8d7e    32     hard     yes     yes     yes
  * Wellsburg (PCH) MS      0x8d7f    32     hard     yes     yes     yes
  * Coleto Creek (PCH)      0x23b0    32     hard     yes     yes     yes
+ * Wildcat Point (PCH)     0x8ca2    32     hard     yes     yes     yes
  * Wildcat Point-LP (PCH)  0x9ca2    32     hard     yes     yes     yes
  * BayTrail (SOC)          0x0f12    32     hard     yes     yes     yes
  *
@@ -175,6 +176,7 @@
 #define PCI_DEVICE_ID_INTEL_COLETOCREEK_SMBUS	0x23b0
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
+#define PCI_DEVICE_ID_INTEL_WILDCATPOINT_SMBUS	0x8ca2
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS	0x8d22
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS0	0x8d7d
 #define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS_MS1	0x8d7e
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
