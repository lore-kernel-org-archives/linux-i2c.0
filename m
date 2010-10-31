From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH 2/2] i2c-i801: Add PCI idents for Patsburg 'IDF' SMBus
 controllers
Date: Sun, 31 Oct 2010 11:24:12 -0400
Message-ID: <1288538652.4570.52.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

These are the extra 'Integrated Device Function' SMBus controllers found
on the Patsburg chipset. Mention the absence of slave mode support.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Seth already added the host controller ID, calling it 'Patsburg'. So
I'll call it 'Patsburg' too, and just add the additional controllers.

We should probably add a column in the hardware support table indicating
which devices support slave mode. The Patsburg host does; the IDF
controllers don't. Not sure how many older devices have slave mode.

 Documentation/i2c/busses/i2c-i801 |    3 +++
 drivers/i2c/busses/i2c-i801.c     |   13 +++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/i2c/busses/i2c-i801 b/Documentation/i2c/busses/i2c-i801
index a417cb1..93fe76e 100644
--- a/Documentation/i2c/busses/i2c-i801
+++ b/Documentation/i2c/busses/i2c-i801
@@ -20,6 +20,9 @@ Supported adapters:
   * Intel Patsburg (PCH)
    Datasheets: Publicly available at the Intel website
 
+On Intel Patsburg and later chipsets, both the normal host SMBus controller
+and the additional 'Integrated Device Function' controllers are supported.
+
 Authors: 
 	Mark Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
 	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 404ca3f..d5d8a17 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -45,6 +45,9 @@
   5/3400 Series (PCH)   0x3b30     32     hard     yes     yes     yes
   Cougar Point (PCH)    0x1c22     32     hard     yes     yes     yes
   Patsburg (PCH)        0x1d22     32     hard     yes     yes     yes
+  Patsburg (PCH) IDF    0x1d70     32     hard     yes     yes     yes
+  Patsburg (PCH) IDF    0x1d71     32     hard     yes     yes     yes
+  Patsburg (PCH) IDF    0x1d72     32     hard     yes     yes     yes
 
   Features supported by this driver:
   Software PEC                     no
@@ -52,6 +55,8 @@
   Block buffer                     yes
   Block process call transaction   no
   I2C block read transaction       yes  (doesn't use the block buffer)
+  Slave mode                       no
+
 
   See the file Documentation/i2c/busses/i2c-i801 for details.
 */
@@ -127,6 +132,11 @@
 				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
 				 SMBHSTSTS_INTR)
 
+/* Patsburg also has three 'Integrated Device Function' SMBus controllers */
+#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0	0x1d70
+#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1	0x1d71
+#define PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2	0x1d72
+
 struct i801_priv {
 	struct i2c_adapter adapter;
 	unsigned long smba;
@@ -603,6 +613,9 @@ static const struct pci_device_id i801_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_PATSBURG_SMBUS_IDF2) },
 	{ 0, }
 };
 
-- 
1.7.3.1
