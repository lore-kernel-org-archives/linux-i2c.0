From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/6] i2c: ismt: improve usage of devres API
Date: Wed, 16 Sep 2015 17:23:58 +0300
Message-ID: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

pcim_release() will release any requested region. There is no need to duplicate
this effort in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index f994712..b7a68b5 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -904,8 +904,7 @@ ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	priv->smba = pcim_iomap(pdev, SMBBAR, len);
 	if (!priv->smba) {
 		dev_err(&pdev->dev, "Unable to ioremap SMBus BAR\n");
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 
 	if ((pci_set_dma_mask(pdev, DMA_BIT_MASK(64)) != 0) ||
@@ -915,32 +914,26 @@ ismt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 						 DMA_BIT_MASK(32)) != 0)) {
 			dev_err(&pdev->dev, "pci_set_dma_mask fail %p\n",
 				pdev);
-			err = -ENODEV;
-			goto fail;
+			return -ENODEV;
 		}
 	}
 
 	err = ismt_dev_init(priv);
 	if (err)
-		goto fail;
+		return err;
 
 	ismt_hw_init(priv);
 
 	err = ismt_int_init(priv);
 	if (err)
-		goto fail;
+		return err;
 
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add SMBus iSMT adapter\n");
-		err = -ENODEV;
-		goto fail;
+		return -ENODEV;
 	}
 	return 0;
-
-fail:
-	pci_release_region(pdev, SMBBAR);
-	return err;
 }
 
 /**
@@ -952,7 +945,6 @@ static void ismt_remove(struct pci_dev *pdev)
 	struct ismt_priv *priv = pci_get_drvdata(pdev);
 
 	i2c_del_adapter(&priv->adapter);
-	pci_release_region(pdev, SMBBAR);
 }
 
 /**
-- 
2.5.1
