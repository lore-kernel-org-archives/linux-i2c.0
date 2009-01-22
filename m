From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-nforce2: Add support for MCP67, MCP73 and MCP79
Date: Thu, 22 Jan 2009 10:19:01 +0100
Message-ID: <20090122101901.1348a734@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Oleg Ryjkov <olegr-9In5xhLTQnA@public.gmane.org>, Malcolm Lalkaka <mlalkaka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The MCP79 appears to be compatible with the previous nForce chips as
far as the SMBus controller is concerned. The MCP67 and MCP73 were not
tested yet but I'd be very surprised if they weren't compatible too.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Oleg Ryjkov <olegr-9In5xhLTQnA@public.gmane.org>
Cc: Malcolm Lalkaka <mlalkaka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Testers welcome, of course.

 Documentation/i2c/busses/i2c-nforce2 |   11 +++++++----
 drivers/i2c/busses/i2c-nforce2.c     |   10 ++++++++--
 include/linux/pci_ids.h              |    3 +++
 3 files changed, 18 insertions(+), 6 deletions(-)

--- linux-2.6.29-rc2.orig/Documentation/i2c/busses/i2c-nforce2	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.29-rc2/Documentation/i2c/busses/i2c-nforce2	2009-01-22 09:47:20.000000000 +0100
@@ -7,10 +7,13 @@ Supported adapters:
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
+  * nForce MCP79               10de:0AA2
 
 Datasheet: not publicly available, but seems to be similar to the
            AMD-8111 SMBus 2.0 adapter.
--- linux-2.6.29-rc2.orig/drivers/i2c/busses/i2c-nforce2.c	2009-01-21 11:29:51.000000000 +0100
+++ linux-2.6.29-rc2/drivers/i2c/busses/i2c-nforce2.c	2009-01-22 09:53:54.000000000 +0100
@@ -31,10 +31,13 @@
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
+    nForce MCP79		0AA2
 
     This driver supports the 2 SMBuses that are included in the MCP of the
     nForce2/3/4/5xx chipsets.
@@ -315,6 +318,9 @@ static struct pci_device_id nforce2_ids[
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP61_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP65_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS) },
 	{ 0 }
 };
 
--- linux-2.6.29-rc2.orig/include/linux/pci_ids.h	2009-01-17 09:06:21.000000000 +0100
+++ linux-2.6.29-rc2/include/linux/pci_ids.h	2009-01-22 09:52:15.000000000 +0100
@@ -1235,6 +1235,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NVENET_21              0x0451
 #define PCI_DEVICE_ID_NVIDIA_NVENET_22              0x0452
 #define PCI_DEVICE_ID_NVIDIA_NVENET_23              0x0453
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP67_SMBUS     0x0542
 #define PCI_DEVICE_ID_NVIDIA_NVENET_24              0x054C
 #define PCI_DEVICE_ID_NVIDIA_NVENET_25              0x054D
 #define PCI_DEVICE_ID_NVIDIA_NVENET_26              0x054E
@@ -1250,6 +1251,8 @@
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
