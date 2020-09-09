Return-Path: <SRS0=cz3S=CS=vger.kernel.org=linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032F4C43461
	for <linux-i2c@archiver.kernel.org>; Wed,  9 Sep 2020 04:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8F621D42
	for <linux-i2c@archiver.kernel.org>; Wed,  9 Sep 2020 04:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgIIENM (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:13:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11286 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbgIIENL (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Sep 2020 00:13:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 861915EBC3146D599CB2;
        Wed,  9 Sep 2020 12:13:09 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.172) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 12:12:58 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <linux-i2c@vger.kernel.org>, <wsa@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Gregory CLEMENT" <gregory.clement@bootlin.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] i2c: busses: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Wed, 9 Sep 2020 16:10:01 +1200
Message-ID: <20200909041001.5612-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.200.172]
X-CFilter-Loop: Reflected
Sender: linux-i2c-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

The code has been in a irq-disabled context since it is hard IRQ. There
is no necessity to do it again.

Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Akash Asthana <akashast@codeaurora.org>
Cc: Mukesh Savaliya <msavaliy@codeaurora.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c   | 5 ++---
 drivers/i2c/busses/i2c-owl.c       | 5 ++---
 drivers/i2c/busses/i2c-qcom-geni.c | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index 8d9d4ffdcd24..e0e45fc19b8f 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -496,11 +496,10 @@ static irqreturn_t
 mv64xxx_i2c_intr(int irq, void *dev_id)
 {
 	struct mv64xxx_i2c_data	*drv_data = dev_id;
-	unsigned long	flags;
 	u32		status;
 	irqreturn_t	rc = IRQ_NONE;
 
-	spin_lock_irqsave(&drv_data->lock, flags);
+	spin_lock(&drv_data->lock);
 
 	if (drv_data->offload_enabled)
 		rc = mv64xxx_i2c_intr_offload(drv_data);
@@ -517,7 +516,7 @@ mv64xxx_i2c_intr(int irq, void *dev_id)
 
 		rc = IRQ_HANDLED;
 	}
-	spin_unlock_irqrestore(&drv_data->lock, flags);
+	spin_unlock(&drv_data->lock);
 
 	return rc;
 }
diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 672f1f239bd6..618d3013d0b6 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -165,10 +165,9 @@ static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
 {
 	struct owl_i2c_dev *i2c_dev = _dev;
 	struct i2c_msg *msg = i2c_dev->msg;
-	unsigned long flags;
 	unsigned int stat, fifostat;
 
-	spin_lock_irqsave(&i2c_dev->lock, flags);
+	spin_lock(&i2c_dev->lock);
 
 	i2c_dev->err = 0;
 
@@ -208,7 +207,7 @@ static irqreturn_t owl_i2c_interrupt(int irq, void *_dev)
 			   OWL_I2C_STAT_IRQP, true);
 
 	complete_all(&i2c_dev->msg_complete);
-	spin_unlock_irqrestore(&i2c_dev->lock, flags);
+	spin_unlock(&i2c_dev->lock);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index dead5db3315a..8b4c35f47a70 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -210,9 +210,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	u32 dma;
 	u32 val;
 	struct i2c_msg *cur;
-	unsigned long flags;
 
-	spin_lock_irqsave(&gi2c->lock, flags);
+	spin_lock(&gi2c->lock);
 	m_stat = readl_relaxed(base + SE_GENI_M_IRQ_STATUS);
 	rx_st = readl_relaxed(base + SE_GENI_RX_FIFO_STATUS);
 	dm_tx_st = readl_relaxed(base + SE_DMA_TX_IRQ_STAT);
@@ -294,7 +293,7 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
 		complete(&gi2c->done);
 
-	spin_unlock_irqrestore(&gi2c->lock, flags);
+	spin_unlock(&gi2c->lock);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1


