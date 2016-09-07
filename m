From: Yadi Hu <yadi.hu@windriver.com>
Subject: [PATCH] i2c-eg20t: fix race between i2c init and interrupt enable
Date: Wed, 7 Sep 2016 17:25:37 +0800
Message-ID: <1473240337-5694-2-git-send-email-yadi.hu@windriver.com>
References: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:61447 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbcIGJ12 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 7 Sep 2016 05:27:28 -0400
In-Reply-To: <1473240337-5694-1-git-send-email-yadi.hu@windriver.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: yadi.hu@windriver.com, wsa@the-dreams.de, jdelvare@suse.de
Cc: linux-i2c@vger.kernel.org

From: "Yadi.hu" <yadi.hu@windriver.com>

the eg20t driver call request_irq() function before the pch_base_address, 
base address of i2c controller's register, isassigned an effective value.

it is one possible scenario that an interrupt which isn't inside eg20t 
arrives immediately after request_irq() is executed when i2c controller 
shares an interrupt number with others.  since the interrupt handler 
pch_i2c_handler() has already active as shared action, it will be called 
and read its own register to determine if this interrupt is from itself.

At that moment, since base address of i2c registers is not remapped 
in kernel space yet,so the INT handler will access an illegal address
and then a error occurs.

the new patch adds a check point on interrupt handler in case field
'pch_base_address' has not been initialed.

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
---
 drivers/i2c/busses/i2c-eg20t.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 137125b..4ac8a49 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -152,6 +152,7 @@ struct i2c_algo_pch_data {
 	int pch_buff_mode_en;
 	u32 pch_event_flag;
 	bool pch_i2c_xfer_in_progress;
+	bool initflag;
 };
 
 /**
@@ -635,6 +636,8 @@ static irqreturn_t pch_i2c_handler(int irq, void *pData)
 	u32 mode;
 
 	for (i = 0, flag = 0; i < adap_info->ch_num; i++) {
+		if (!adap_info->pch_data[i].initflag)
+			continue;
 		p = adap_info->pch_data[i].pch_base_address;
 		mode = ioread32(p + PCH_I2CMOD);
 		mode &= BUFFER_MODE | EEPROM_SR_MODE;
@@ -783,6 +786,7 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 	for (i = 0; i < adap_info->ch_num; i++) {
 		pch_adap = &adap_info->pch_data[i].pch_adapter;
 		adap_info->pch_i2c_suspended = false;
+		adap_info->pch_data[i].initflag = false;
 
 		adap_info->pch_data[i].p_adapter_info = adap_info;
 
@@ -806,6 +810,7 @@ static int pch_i2c_probe(struct pci_dev *pdev,
 			pch_pci_err(pdev, "i2c_add_adapter[ch:%d] FAILED\n", i);
 			goto err_add_adapter;
 		}
+		adap_info->pch_data[i].initflag = true;
 	}
 
 	pci_set_drvdata(pdev, adap_info);
-- 
2.9.3
