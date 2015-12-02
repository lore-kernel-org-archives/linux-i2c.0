From: Gao Pan <b54642@freescale.com>
Subject: [Patch V1] imx: i2c: fix i2c resource leak with dma transfer
Date: Wed, 2 Dec 2015 17:52:38 +0800
Message-ID: <1449049958-6820-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bn1bon0135.outbound.protection.outlook.com ([157.56.111.135]:46442
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932561AbbLBKJA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 2 Dec 2015 05:09:00 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, b54642@freescale.com, kernel@pengutronix.de, s.hauer@pengutronix.de, p.zabel@pengutronix.de, yao.yuan@freescale.com

In i2c_imx_dma_xfer(), when dmaengine_prep_slave_single() returns
NULL, the context goto label err_desc and then return. However,
the memory allocated by dmaengine_prep_slave_single() has not been
freed yet, which leads to resource leak.

(reported by coverity check)

Signed-off-by: Gao Pan <b54642@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 0ab8424..6dcfff5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -397,6 +397,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 
 err_submit:
 err_desc:
+	dmaengine_terminate_all(dma->chan_using);
 	dma_unmap_single(chan_dev, dma->dma_buf,
 			dma->dma_len, dma->dma_data_dir);
 err_map:
-- 
1.9.1
