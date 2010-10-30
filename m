From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: [PATCH 2/2] i2c-i801: Add PCI idents for Sandy Bridge SMBus
 controllers
Date: Sat, 30 Oct 2010 14:49:31 +0100 (BST)
Message-ID: <alpine.LFD.2.00.1010301448240.7306@dwoodhou-mobl2.ger.corp.intel.com>
References: <alpine.LFD.2.00.1010301445490.7306@dwoodhou-mobl2.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.2.00.1010301445490.7306-NkH8fLdbH5SKw1fGA2nhu27IUlhRatedral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
  drivers/i2c/busses/i2c-i801.c |   13 +++++++++++++
  1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 6e8c12c..415f58d 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -45,6 +45,10 @@
    ICH10                 0x3a60     32     hard     yes     yes     yes
    5/3400 Series (PCH)   0x3b30     32     hard     yes     yes     yes
    Cougar Point (PCH)    0x1c22     32     hard     yes     yes     yes
+  Sandy Bridge (PCH)    0x1d22     32     hard     yes     yes     yes
+  Sandy Bridge (EVA)    0x1d70     32     hard     yes     yes     yes
+  Sandy Bridge (EVA)    0x1d71     32     hard     yes     yes     yes
+  Sandy Bridge (EVA)    0x1d72     32     hard     yes     yes     yes

    Features supported by this driver:
    Software PEC                     no
@@ -127,6 +131,11 @@
  				 SMBHSTSTS_BUS_ERR | SMBHSTSTS_DEV_ERR | \
  				 SMBHSTSTS_INTR)

+#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_PCH	0x1d22
+#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA1	0x1d70
+#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA2	0x1d71
+#define PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA3	0x1d72
+
  struct i801_priv {
  	struct i2c_adapter adapter;
  	unsigned long smba;
@@ -602,6 +611,10 @@ static const struct pci_device_id i801_ids[] = {
  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH10_5) },
  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5_3400_SERIES_SMBUS) },
  	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_COUGARPOINT_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_PCH) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SANDYBRIDGE_SMBUS_EVA3) },
  	{ 0, }
  };

-- 
1.7.3.1


-- 
dwmw2
