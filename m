From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] i2c-eg20t: correct the driver init order of pch_i2c_probe()
Date: Tue, 29 Nov 2011 15:19:10 +0800
Message-ID: <1322551151-28580-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, tomoya-linux-8lRStDepK8iSL1NxhRU65dBPR1lH4CV8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Before registering an adapter to i2c subsystem, we need make sure
driver is ready for incoming i2c xfer, becasue the i2c_add_adapter()
may trigger a i2c device driver's proble function which may start
some real i2c xfer. I met this issue when integrating a TSC2007 i2c
touch screen device with the i2c-eg20t driver.

This patch will call request_irq() and hw init before calling
i2c_add_adapter().

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-eg20t.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 8cebef4..18936ac 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -893,6 +893,13 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 	/* Set the number of I2C channel instance */
 	adap_info->ch_num = id->driver_data;
 
+	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
+		  KBUILD_MODNAME, adap_info);
+	if (ret) {
+		pch_pci_err(pdev, "request_irq FAILED\n");
+		goto err_request_irq;
+	}
+
 	for (i = 0; i < adap_info->ch_num; i++) {
 		pch_adap = &adap_info->pch_data[i].pch_adapter;
 		adap_info->pch_i2c_suspended = false;
@@ -910,28 +917,23 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 
 		pch_adap->dev.parent = &pdev->dev;
 
+		pch_i2c_init(&adap_info->pch_data[i]);
 		ret = i2c_add_adapter(pch_adap);
 		if (ret) {
 			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
-			goto err_i2c_add_adapter;
+			goto err_add_adapter;
 		}
-
-		pch_i2c_init(&adap_info->pch_data[i]);
-	}
-	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
-		  KBUILD_MODNAME, adap_info);
-	if (ret) {
-		pch_pci_err(pdev, "request_irq FAILED\n");
-		goto err_i2c_add_adapter;
 	}
 
 	pci_set_drvdata(pdev, adap_info);
 	pch_pci_dbg(pdev, "returns %d.\n", ret);
 	return 0;
 
-err_i2c_add_adapter:
+err_add_adapter:
 	for (j = 0; j < i; j++)
 		i2c_del_adapter(&adap_info->pch_data[j].pch_adapter);
+	free_irq(pdev->irq, adap_info);
+err_request_irq:
 	pci_iounmap(pdev, base_addr);
 err_pci_iomap:
 	pci_release_regions(pdev);
-- 
1.7.1
