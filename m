Return-Path: <linux-i2c-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3439C43214
	for <linux-i2c@archiver.kernel.org>; Sat, 28 Aug 2021 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70B160EBA
	for <linux-i2c@archiver.kernel.org>; Sat, 28 Aug 2021 10:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhH1KwO (ORCPT <rfc822;linux-i2c@archiver.kernel.org>);
        Sat, 28 Aug 2021 06:52:14 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:34318 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233763AbhH1KwJ (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Sat, 28 Aug 2021 06:52:09 -0400
X-UUID: 8bc10a0750024c6fa5912d7948068cff-20210828
X-UUID: 8bc10a0750024c6fa5912d7948068cff-20210828
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <kewei.xu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1669177796; Sat, 28 Aug 2021 18:51:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 28 Aug 2021 18:51:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 28 Aug 2021 18:51:09 +0800
From:   Kewei Xu <kewei.xu@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <qii.wang@mediatek.com>, <liguo.zhang@mediatek.com>,
        <caiyu.chen@mediatek.com>, <ot_daolong.zhu@mediatek.com>,
        <yuhan.wei@mediatek.com>, <kewei.xu@mediatek.com>
Subject: [PATCH v6 2/7] i2c: mediatek: Reset the handshake signal between i2c and dma
Date:   Sat, 28 Aug 2021 18:50:54 +0800
Message-ID: <1630147859-17031-3-git-send-email-kewei.xu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1630147859-17031-1-git-send-email-kewei.xu@mediatek.com>
References: <1630147859-17031-1-git-send-email-kewei.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-i2c.vger.kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org

Due to changes in the hardware design of the handshaking signal
between i2c and dma, it is necessary to reset the handshaking
signal before each transfer to ensure that the multi-msgs can
be transferred correctly.

Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 2661ed0..7a1c538 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -47,6 +48,9 @@
 #define I2C_RD_TRANAC_VALUE		0x0001
 #define I2C_SCL_MIS_COMP_VALUE		0x0000
 #define I2C_CHN_CLR_FLAG		0x0000
+#define I2C_CLR_DEBUGCTR		0x0000
+#define I2C_RELIABILITY			0x0010
+#define I2C_DMAACK_ENABLE		0x0008
 
 #define I2C_DMA_CON_TX			0x0000
 #define I2C_DMA_CON_RX			0x0001
@@ -842,6 +846,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 	u16 restart_flag = 0;
 	u16 dma_sync = 0;
 	u32 reg_4g_mode;
+	u32 reg_dma_reset;
 	u8 *dma_rd_buf = NULL;
 	u8 *dma_wr_buf = NULL;
 	dma_addr_t rpaddr = 0;
@@ -855,6 +860,27 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
 
 	reinit_completion(&i2c->msg_complete);
 
+	if (i2c->dev_comp->apdma_sync && i2c->op != I2C_MASTER_WRRD && num > 1) {
+		mtk_i2c_writew(i2c, I2C_CLR_DEBUGCTR, OFFSET_DEBUGCTRL);
+		writel(I2C_DMA_HANDSHAKE_RST | I2C_DMA_WARM_RST,
+		       i2c->pdmabase + OFFSET_RST);
+
+		ret = readw_poll_timeout(i2c->pdmabase + OFFSET_RST,
+					 reg_dma_reset,
+					 !(reg_dma_reset & I2C_DMA_WARM_RST),
+					 0, 100);
+		if (ret) {
+			dev_err(i2c->dev, "DMA warm reset timeout\n");
+			return -ETIMEDOUT;
+		}
+
+		writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);
+		mtk_i2c_writew(i2c, I2C_HANDSHAKE_RST, OFFSET_SOFTRESET);
+		mtk_i2c_writew(i2c, I2C_CHN_CLR_FLAG, OFFSET_SOFTRESET);
+		mtk_i2c_writew(i2c, I2C_RELIABILITY | I2C_DMAACK_ENABLE,
+			       OFFSET_DEBUGCTRL);
+	}
+
 	control_reg = mtk_i2c_readw(i2c, OFFSET_CONTROL) &
 			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
 	if ((i2c->speed_hz > I2C_MAX_FAST_MODE_PLUS_FREQ) || (left_num >= 1))
-- 
1.9.1

