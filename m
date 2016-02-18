From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] i2c: ismt: Add Intel DNV PCI ID
Date: Thu, 18 Feb 2016 16:54:33 +0200
Message-ID: <1455807273-133516-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:64088 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426069AbcBROyg (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 18 Feb 2016 09:54:36 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org

Intel DNV has the same iSMT SMBus host controller than Intel Avoton. Add
DNV PCI ID to the list of supported devices.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/i2c/busses/i2c-ismt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 7ba795b24e75..24c48e899a22 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -76,6 +76,7 @@
 #define PCI_DEVICE_ID_INTEL_S1200_SMT0	0x0c59
 #define PCI_DEVICE_ID_INTEL_S1200_SMT1	0x0c5a
 #define PCI_DEVICE_ID_INTEL_AVOTON_SMT	0x1f15
+#define PCI_DEVICE_ID_INTEL_DNV_SMT	0x19ac
 
 #define ISMT_DESC_ENTRIES	2	/* number of descriptor entries */
 #define ISMT_MAX_RETRIES	3	/* number of SMBus retries to attempt */
@@ -181,6 +182,7 @@ static const struct pci_device_id ismt_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_S1200_SMT1) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AVOTON_SMT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_DNV_SMT) },
 	{ 0, }
 };
 
-- 
2.7.0
