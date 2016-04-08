From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2] i2c: ismt: Add Intel DNV PCI ID
Date: Fri,  8 Apr 2016 15:41:08 +0300
Message-ID: <1460119268-23338-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15923 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbcDHMlR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Apr 2016 08:41:17 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, scott.lawson@intel.com, alexandra.yates@intel.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

Intel DNV has the same iSMT SMBus host controller than Intel Avoton. Add
DNV PCI ID to the list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
Wolfram,

This is the same patch that conflicted with another patch by Alexandra [1].
We have now verified that it is the iSMT driver that is compatible with
this particular PCI ID (not i2c-i801.c). Not tested on a real hardware as I
do not have such machine available.

v2: Order PCI IDs by their value

[1] https://patchwork.ozlabs.org/patch/584758/

 drivers/i2c/busses/i2c-ismt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 7ba795b24e75..1c8707710098 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -75,6 +75,7 @@
 /* PCI DIDs for the Intel SMBus Message Transport (SMT) Devices */
 #define PCI_DEVICE_ID_INTEL_S1200_SMT0	0x0c59
 #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
+#define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac
 #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
 
 #define ISMT_DESC_ENTRIES	2	/* number of descriptor entries */
@@ -180,6 +181,7 @@ struct ismt_priv {
 static const struct pci_device_id ismt_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
 	{ 0, }
 };
-- 
2.8.0.rc3
