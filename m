From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-i801: Move device ID definitions to driver
Date: Sat, 23 Apr 2011 09:58:08 +0200
Message-ID: <20110423095808.6f6ee01d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move the SMBus device ID definitions of recent devices from pci_ids.h
to the i2c-i801.c driver file. They don't have to be shared, as they
are clearly identified and only used in this driver. In the future,
such IDs will go to i2c-i801 directly. This will make adding support
for new devices much faster and easier, as it will avoid cross-
subsystem patch sets and merge conflicts.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-i801.c |    5 +++++
 include/linux/pci_ids.h       |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.39-rc4.orig/drivers/i2c/busses/i2c-i801.c	2011-04-23 09:51:18.000000000 +0200
+++ linux-2.6.39-rc4/drivers/i2c/busses/i2c-i801.c	2011-04-23 09:51:49.000000000 +0200
@@ -134,10 +134,15 @@
 				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
 				 SMBHSTSTS_INTR)
 
+/* Older devices have their ID defined in <linux/pci_ids.h> */
+#define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS	0x1c22
+#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS	0x1d22
 /* Patsburg also has three 'Integrated Device Function' SMBus controllers */
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0	0x1d70
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1	0x1d71
 #define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2	0x1d72
+#define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
+#define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
 
 struct i801_priv {
 	struct i2c_adapter adapter;
--- linux-2.6.39-rc4.orig/include/linux/pci_ids.h	2011-04-23 09:51:18.000000000 +0200
+++ linux-2.6.39-rc4/include/linux/pci_ids.h	2011-04-23 09:51:49.000000000 +0200
@@ -2477,15 +2477,12 @@
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
 #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
-#define PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS	0x1c22
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f
-#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS	0x1d22
 #define PCI_DEVICE_ID_INTEL_PATSBURG_LPC_0	0x1d40
 #define PCI_DEVICE_ID_INTEL_PATSBURG_LPC_1	0x1d41
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MIN	0x2310
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_LPC_MAX	0x231f
-#define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
 #define PCI_DEVICE_ID_INTEL_82801AA_0	0x2410
 #define PCI_DEVICE_ID_INTEL_82801AA_1	0x2411
 #define PCI_DEVICE_ID_INTEL_82801AA_3	0x2413
@@ -2696,7 +2693,6 @@
 #define PCI_DEVICE_ID_INTEL_ICH10_5	0x3a60
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MIN	0x3b00
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_LPC_MAX	0x3b1f
-#define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5


-- 
Jean Delvare
