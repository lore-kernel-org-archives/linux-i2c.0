From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/6] i2c: ismt: PCI core handles power state for us
Date: Wed, 16 Sep 2015 17:23:59 +0300
Message-ID: <1442413443-123579-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1442413443-123579-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442413443-123579-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Neil Horman <nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There is no need to repeat the work that is already done in the PCI driver
core. Remove suspend and resume callbacks.

Note that there is no more calls performed to enable or disable a PCI
device during suspend-resume cycle. Nowadays they seems to be
superflous. Someone can read more in [1].

[1] https://www.kernel.org/doc/ols/2009/ols2009-pages-319-330.pdf

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-ismt.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index b7a68b5..570b0a0 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -947,44 +947,11 @@ static void ismt_remove(struct pci_dev *pdev)
 	i2c_del_adapter(&priv->adapter);
 }
 
-/**
- * ismt_suspend() - place the device in suspend
- * @pdev: PCI-Express device
- * @mesg: PM message
- */
-#ifdef CONFIG_PM
-static int ismt_suspend(struct pci_dev *pdev, pm_message_t mesg)
-{
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, mesg));
-	return 0;
-}
-
-/**
- * ismt_resume() - PCI resume code
- * @pdev: PCI-Express device
- */
-static int ismt_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	return pci_enable_device(pdev);
-}
-
-#else
-
-#define ismt_suspend NULL
-#define ismt_resume NULL
-
-#endif
-
 static struct pci_driver ismt_driver = {
 	.name = "ismt_smbus",
 	.id_table = ismt_ids,
 	.probe = ismt_probe,
 	.remove = ismt_remove,
-	.suspend = ismt_suspend,
-	.resume = ismt_resume,
 };
 
 module_pci_driver(ismt_driver);
-- 
2.5.1
