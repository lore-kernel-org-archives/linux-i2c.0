From: Yadi Hu <yadi.hu@windriver.com>
Subject: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Sun, 18 Sep 2016 18:52:31 +0800
Message-ID: <1474195951-7238-2-git-send-email-yadi.hu@windriver.com>
References: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:37636 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932140AbcIRKww (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Sep 2016 06:52:52 -0400
In-Reply-To: <1474195951-7238-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: yadi.hu@windriver.com, wsa@the-dreams.de, jdelvare@suse.de
Cc: linux-i2c@vger.kernel.org

From: "Yadi.hu" <yadi.hu@windriver.com>

the eg20t driver call request_irq() function before the pch_base_address,
base address of i2c controller's register, is assigned an effective value.

there is one possible scenario that an interrupt which isn't inside eg20t
arrives immediately after request_irq() is executed when i2c controller
shares an interrupt number with others. since the interrupt handler
pch_i2c_handler() has already active as shared action, it will be called
and read its own register to determine if this interrupt is from itself.

At that moment, since base address of i2c registers is not remapped
in kernel space yet,so the INT handler will access an illegal address
and then a error occurs.

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
---
 drivers/i2c/busses/i2c-eg20t.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 137125b..5ce71ce 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -773,13 +773,6 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 	/* Set the number of I2C channel instance */
 	adap_info->ch_num = id->driver_data;
 
-	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
-		  KBUILD_MODNAME, adap_info);
-	if (ret) {
-		pch_pci_err(pdev, "request_irq FAILED\n");
-		goto err_request_irq;
-	}
-
 	for (i = 0; i < adap_info->ch_num; i++) {
 		pch_adap = &adap_info->pch_data[i].pch_adapter;
 		adap_info->pch_i2c_suspended = false;
@@ -797,6 +790,17 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 
 		pch_adap->dev.of_node = pdev->dev.of_node;
 		pch_adap->dev.parent = &pdev->dev;
+	}
+
+	ret = request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
+		  KBUILD_MODNAME, adap_info);
+	if (ret) {
+		pch_pci_err(pdev, "request_irq FAILED\n");
+		goto err_request_irq;
+	}
+
+	for (i = 0; i < adap_info->ch_num; i++) {
+		pch_adap = &adap_info->pch_data[i].pch_adapter;
 
 		pch_i2c_init(&adap_info->pch_data[i]);
 
-- 
2.9.3
