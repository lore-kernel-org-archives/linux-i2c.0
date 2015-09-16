From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/6] i2c: ismt: issue a warning when fail to request MSI
Date: Wed, 16 Sep 2015 17:24:02 +0300
Message-ID: <1442413443-123579-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442413443-123579-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Issue the warning in all error paths when unable to register MSI or its
handler.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index 3bc4bad..48e0693 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -788,11 +788,8 @@ static int ismt_int_init(struct ismt_priv *priv)
 
 	/* Try using MSI interrupts */
 	err = pci_enable_msi(priv->pci_dev);
-	if (err) {
-		dev_warn(&priv->pci_dev->dev,
-			 "Unable to use MSI interrupts, falling back to legacy\n");
+	if (err)
 		goto intx;
-	}
 
 	err = devm_request_irq(&priv->pci_dev->dev,
 			       priv->pci_dev->irq,
@@ -805,10 +802,13 @@ static int ismt_int_init(struct ismt_priv *priv)
 		goto intx;
 	}
 
-	goto done;
+	return 0;
 
 	/* Try using legacy interrupts */
 intx:
+	dev_warn(&priv->pci_dev->dev,
+		 "Unable to use MSI interrupts, falling back to legacy\n");
+
 	err = devm_request_irq(&priv->pci_dev->dev,
 			       priv->pci_dev->irq,
 			       ismt_do_interrupt,
@@ -820,7 +820,6 @@ intx:
 		return err;
 	}
 
-done:
 	return 0;
 }
 
-- 
2.5.1
