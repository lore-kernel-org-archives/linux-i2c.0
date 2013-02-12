From: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] i2c-i801: Add Device IDs for Intel Wellsburg PCH
Date: Tue, 12 Feb 2013 14:04:02 -0800
Message-ID: <1360706642-2399-1-git-send-email-james.d.ralston@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds the SMBus Device IDs for the Intel Wellsburg PCH

Signed-off-by: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Change notes for v2:
* Rebased on [PATCH v2] i2c-i801: SMBus patch for Intel Avoton DeviceIDs
* Added 3 Device IDs for additional SMBus Devices

 Documentation/i2c/busses/i2c-i801 |    1 +
 drivers/i2c/busses/Kconfig        |    1 +
 drivers/i2c/busses/i2c-i801.c     |   12 ++++++++++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index 8d71d57..d55b8ab 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -23,6 +23,7 @@ Supported adapters:
   * Intel Lynx Point (PCH)
   * Intel Lynx Point-LP (PCH)
   * Intel Avoton (SOC)
+  * Intel Wellsburg (PCH)
    Datasheets: Publicly available at the Intel website
 
 On Intel Patsburg and later chipsets, both the normal host SMBus controller
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 77d2887..059a481 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -107,6 +107,7 @@ config I2C_I801
 	    Lynx Point (PCH)
 	    Lynx Point-LP (PCH)
 	    Avoton (SOC)
+	    Wellsburg (PCH)
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index b00c29d..c257a16 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -54,6 +54,10 @@
   Lynx Point (PCH)      0x8c22     32     hard     yes     yes     yes
   Lynx Point-LP (PCH)   0x9c22     32     hard     yes     yes     yes
   Avoton (SOC)          0x1f3c     32     hard     yes     yes     yes
+  Wellsburg (PCH)       0x8d22     32     hard     yes     yes     yes
+  Wellsburg (PCH)       0x8d7d     32     hard     yes     yes     yes
+  Wellsburg (PCH)       0x8d7e     32     hard     yes     yes     yes
+  Wellsburg (PCH)       0x8d7f     32     hard     yes     yes     yes
 
   Features supported by this driver:
   Software PEC                     no
@@ -167,6 +171,10 @@
 #define PCI_DEVICE_ID_INTEL_DH89XXCC_SMBUS	0x2330
 #define PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS	0x3b30
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS	0x8c22
+#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS0	0x8d22
+#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS1	0x8d7d
+#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS2	0x8d7e
+#define PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS3	0x8d7f
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS	0x9c22
 
 struct i801_mux_config {
@@ -801,6 +809,10 @@ static DEFINE_PCI_DEVICE_TABLE(i801_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LYNXPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WELLSBURG_SMBUS3) },
 	{ 0, }
 };
 
-- 
1.7.7.6
