From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [v1] i2c: busses: i2c-designware-pcidrv:- Unmap region obtained by pcim_iomap_regions
Date: Fri, 23 Dec 2016 15:41:33 +0530
Message-ID: <1482487893-17589-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36222 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754631AbcLWKLp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 23 Dec 2016 05:11:45 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Release IO memory mapping, if i2c_dw_pci_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index d6423cf..75e6e27 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -228,8 +228,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		r = -ENOMEM;
+		goto error;
+	}
 
 	dev->clk = NULL;
 	dev->controller = controller;
@@ -241,7 +243,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	if (controller->setup) {
 		r = controller->setup(pdev, controller);
 		if (r)
-			return r;
+			goto error;
 	}
 
 	dev->functionality = controller->functionality |
@@ -270,7 +272,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 
 	r = i2c_dw_probe(dev);
 	if (r)
-		return r;
+		goto error;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -278,6 +280,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	pm_runtime_allow(&pdev->dev);
 
 	return 0;
+error:
+	pcim_iounmap_regions(pdev, 1 << 0);
 }
 
 static void i2c_dw_pci_remove(struct pci_dev *pdev)
-- 
1.7.9.5
