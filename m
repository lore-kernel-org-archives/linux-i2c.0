From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [v1] i2c: busses: i2c-designware-pcidrv:- Handle return NULL error from pcim_iomap_table
Date: Thu, 22 Dec 2016 17:09:19 +0530
Message-ID: <1482406759-13094-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jarkko.nikula@linux.intel.com, wsa@the-dreams.de
Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Here, If pcim_iomap_table will fail. It will return NULL.
Kernel can run into a NULL-pointer dereference.
This error check will avoid NULL pointer dereference.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index d6423cf..6a1907d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -235,6 +235,10 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	dev->controller = controller;
 	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
 	dev->base = pcim_iomap_table(pdev)[0];
+	if (!dev->base) {
+		dev_err(&pdev->dev, "I/O map table allocation failed\n");
+		return -ENOMEM;
+	}
 	dev->dev = &pdev->dev;
 	dev->irq = pdev->irq;
 
-- 
1.7.9.5
