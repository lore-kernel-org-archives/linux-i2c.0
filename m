From: Yadi Hu <yadi.hu@windriver.com>
Subject: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Tue, 23 Aug 2016 17:07:19 +0800
Message-ID: <1471943239-21420-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44314 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbcHWJJL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 23 Aug 2016 05:09:11 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: yadi.hu@windriver.com, jdelvare@suse.com, khali@linux-fr.org, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org

From: Hu Yadi <Yadi.hu@windriver.com>

The driver executes request_irq() function before the base address
of i2c registers is remapped in kernel space. If i2c controller
shares an interrupt line with other devices,it is possible that
an interrupt arrives immediately after request_irq() is called.
Since the interrupt handler pch_i2c_handler() is active, it will
read its own register to determine if this interrupt was from
its device.
At this moment, base address of i2c registers is not remapped
in kernel space yet,so the INT handler access a unknown address
and a error occurs.

Signed-off-by: Hu Yadi <Yadi.hu@windriver.com>
---
 drivers/i2c/busses/i2c-eg20t.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index c811289..7a51ddc 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -893,15 +893,8 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 
 	/* Set the number of I2C channel instance */
 	adap_info->ch_num = id->driver_data;
-
-	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
-		  KBUILD_MODNAME, adap_info);
-	if (ret) {
-		pch_pci_err(pdev, "request_irq FAILED\n");
-		goto err_request_irq;
-	}
-
-	for (i = 0; i < adap_info->ch_num; i++) {
+	
+        for (i = 0; i < adap_info->ch_num; i++) {
 		pch_adap = &adap_info->pch_data[i].pch_adapter;
 		adap_info->pch_i2c_suspended = false;
 
@@ -928,15 +921,25 @@ static int __devinit pch_i2c_probe(struct pci_dev *pdev,
 		}
 	}
 
+
+
+	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
+		  KBUILD_MODNAME, adap_info);
+	if (ret) {
+		pch_pci_err(pdev, "request_irq FAILED\n");
+		goto err_request_irq;
+	}
+
 	pci_set_drvdata(pdev, adap_info);
 	pch_pci_dbg(pdev, "returns %d.\n", ret);
 	return 0;
 
+
+err_request_irq:
+	free_irq(pdev->irq, adap_info);
 err_add_adapter:
 	for (j = 0; j < i; j++)
 		i2c_del_adapter(&adap_info->pch_data[j].pch_adapter);
-	free_irq(pdev->irq, adap_info);
-err_request_irq:
 	pci_iounmap(pdev, base_addr);
 err_pci_iomap:
 	pci_release_regions(pdev);
-- 
1.7.5.4
