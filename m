From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] i2c: designware-pci: clarify a comment for Merrifield
Date: Mon, 20 Jun 2016 11:58:09 +0300
Message-ID: <1466413089-27352-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64693 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbcFTI6N (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 20 Jun 2016 04:58:13 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are more than 7 busses, but only 7 are user visible. Update comment
accordingly.

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2:
- fix typo
- add Ack
 drivers/i2c/busses/i2c-designware-pcidrv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index b66c31a..96f8230 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -125,10 +125,10 @@ static int mfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 static int mrfld_setup(struct pci_dev *pdev, struct dw_pci_controller *c)
 {
 	/*
-	 * On Intel Merrifield the i2c busses are enumerated [1..7]. So, we add
-	 * 1 to shift the default range. Besides that the first PCI slot
-	 * provides 4 functions, that's why we have to add 0 to the head slot
-	 * and 4 to the tail one.
+	 * On Intel Merrifield the user visible i2c busses are enumerated
+	 * [1..7]. So, we add 1 to shift the default range. Besides that the
+	 * first PCI slot provides 4 functions, that's why we have to add 0 to
+	 * the first slot and 4 to the next one.
 	 */
 	switch (PCI_SLOT(pdev->devfn)) {
 	case 8:
-- 
2.8.1
