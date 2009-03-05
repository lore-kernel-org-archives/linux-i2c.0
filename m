From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-nforce2: Add support for MCP67, MCP73, MCP78S and MCP79
Date: Thu, 5 Mar 2009 15:40:43 +0100
Message-ID: <20090305154043.7b6e7f99@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Oleg Ryjkov <olegr-9In5xhLTQnA@public.gmane.org>, Malcolm Lalkaka <mlalkaka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zbigniew Luszpinski <zbiggy-h7QdYz1kt/Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The MCP78S and MCP79 appear to be compatible with the previous nForce
chips as far as the SMBus controller is concerned. The MCP67 and MCP73
were not tested yet but I'd be very surprised if they weren't
compatible too.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Oleg Ryjkov <olegr-9In5xhLTQnA@public.gmane.org>
Cc: Malcolm Lalkaka <mlalkaka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zbigniew Luszpinski <zbiggy-h7QdYz1kt/Q@public.gmane.org>
---
Updated patch also adding the MCP78S device ID.

 Documentation/i2c/busses/i2c-nforce2 |   12 ++++++++----
 drivers/i2c/busses/i2c-nforce2.c     |   12 ++++++++++--
 include/linux/pci_ids.h              |    4 ++++
 3 files changed, 22 insertions(+), 6 deletions(-)

--- linux-2.6.29-rc7.orig/Documentation/i2c/busses/i2c-nforce2	2009-03-04 15:29:06.000000000 +0100
+++ linux-2.6.29-rc7/Documentation/i2c/busses/i2c-nforce2	2009-03-05 10:13:54.000000000 +0100
@@ -7,10 +7,14 @@ Supported adapters:
   * nForce3 250Gb MCP          10de:00E4 
   * nForce4 MCP                10de:0052
   * nForce4 MCP-04             10de:0034
-  * nForce4 MCP51              10de:0264
-  * nForce4 MCP55              10de:0368
-  * nForce4 MCP61              10de:03EB
-  * nForce4 MCP65              10de:0446
+  * nForce MCP51               10de:0264
+  * nForce MCP55               10de:0368
+  * nForce MCP61               10de:03EB
+  * nForce MCP65               10de:0446
+  * nForce MCP67               10de:0542
+  * nForce MCP73               10de:07D8
+  * nForce MCP78S              10de:0752
+  * nForce MCP79               10de:0AA2
 
 Datasheet: not publicly available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.
--- linux-2.6.29-rc7.orig/drivers/i2c/busses/i2c-nforce2.c	2009-03-04 15:29:06.000000000 +0100
+++ linux-2.6.29-rc7/drivers/i2c/busses/i2c-nforce2.c	2009-03-05 10:14:58.000000000 +0100
@@ -31,10 +31,14 @@
     nForce3 250Gb MCP		00E4
     nForce4 MCP			0052
     nForce4 MCP-04		0034
-    nForce4 MCP51		0264
-    nForce4 MCP55		0368
+    nForce MCP51		0264
+    nForce MCP55		0368
     nForce MCP61		03EB
     nForce MCP65		0446
+    nForce MCP67		0542
+    nForce MCP73		07D8
+    nForce MCP78S		0752
+    nForce MCP79		0AA2
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4/5xx chipsets.
@@ -315,6 +319,10 @@ static struct pci_device_id nforce2_ids[
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS) },
 	{ 0 }
 };
 
--- linux-2.6.29-rc7.orig/include/linux/pci_ids.h	2009-03-04 15:33:37.000000000 +0100
+++ linux-2.6.29-rc7/include/linux/pci_ids.h	2009-03-05 10:12:56.000000000 +0100
@@ -1235,6 +1235,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
 #define PCI_DEVICE_ID_NVIDIA_NVENET_23              0x0453
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SMBUS     0x0542
 #define PCI_DEVICE_ID_NVIDIA_NVENET_24              0x054C
 #define PCI_DEVICE_ID_NVIDIA_NVENET_25              0x054D
 #define PCI_DEVICE_ID_NVIDIA_NVENET_26              0x054E
@@ -1245,11 +1246,14 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_31              0x07DF
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_IDE       0x0560
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_IDE       0x056C
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS    0x0752
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
 #define PCI_DEVICE_ID_NVIDIA_NVENET_32              0x0760
 #define PCI_DEVICE_ID_NVIDIA_NVENET_33              0x0761
 #define PCI_DEVICE_ID_NVIDIA_NVENET_34              0x0762
 #define PCI_DEVICE_ID_NVIDIA_NVENET_35              0x0763
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
 #define PCI_DEVICE_ID_NVIDIA_NVENET_36              0x0AB0
 #define PCI_DEVICE_ID_NVIDIA_NVENET_37              0x0AB1
 #define PCI_DEVICE_ID_NVIDIA_NVENET_38              0x0AB2


-- 
Jean Delvare
