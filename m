From: Gao Pan <pandy.gao@nxp.com>
Subject: [Patch v1] imx: i2c: fix i2c resource leak with dma transfer
Date: Fri, 8 Jan 2016 13:33:15 +0800
Message-ID: <1452231195-18425-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0095.outbound.protection.outlook.com ([157.56.112.95]:61152
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751074AbcAHHHh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 8 Jan 2016 02:07:37 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, u.kleine-koenig@pengutronix.de
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com, pandy.gao@nxp.com, kernel@pengutronix.de

In i2c_imx_dma_xfer(), when dmaengine_submit() returns error,
the context goto label err_submit and then return. However, the
memory allocated for txdesc has not been freed yet, which
leads to resource leak.

Signed-off-by: Gao Pan <b54642@freescale.com>
Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 8b68dbf..a2b132c 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -387,6 +387,7 @@ static int i2c_imx_dma_xfer(struct imx_i2c_struct *i2c_imx,
 	return 0;
 
 err_submit:
+	dmaengine_terminate_all(dma->chan_using);
 err_desc:
 	dma_unmap_single(chan_dev, dma->dma_buf,
 			dma->dma_len, dma->dma_data_dir);
-- 
1.9.1
