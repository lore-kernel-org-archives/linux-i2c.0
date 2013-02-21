From: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] i2c: iSMT SMBus patch for Intel Avoton DeviceIDs
Date: Thu, 21 Feb 2013 14:30:43 -0800
Message-ID: <1361485843-13560-1-git-send-email-seth.heasley@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds the iSMT SMBus Controller DeviceIDs for the Intel Avoton SOC.

Signed-off-by: Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 3f7a9cb..45bccf1 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -80,6 +80,7 @@
 /* PCI DIDs for the Intel SMBus Message Transport (SMT) Devices */
 #define PCI_DEVICE_ID_INTEL_S1200_SMT0	0x0c59
 #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
+#define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
 
 #define ISMT_DESC_ENTRIES	32	/* number of descriptor entries */
 #define ISMT_MAX_RETRIES	3	/* number of SMBus retries to attempt */
@@ -185,6 +186,7 @@ struct ismt_priv {
 static const DEFINE_PCI_DEVICE_TABLE(ismt_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
 	{ 0, }
 };
 
-- 
1.7.4.4
