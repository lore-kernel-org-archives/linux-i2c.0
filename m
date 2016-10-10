From: Hoan Tran <hotran@apm.com>
Subject: [PATCH] i2c: xgene: Avoid dma_buffer overrun
Date: Mon, 10 Oct 2016 10:13:10 -0700
Message-ID: <1476119590-21489-1-git-send-email-hotran@apm.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34630 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbcJJRNs (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Oct 2016 13:13:48 -0400
Received: by mail-pa0-f41.google.com with SMTP id rz1so57997953pab.1
        for <linux-i2c@vger.kernel.org>; Mon, 10 Oct 2016 10:13:48 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Phil Endecott <phil_gjouf_endecott@chezphil.org>, Loc Ho <lho@apm.com>, tnhuynh@apm.com, patches@apm.com, Hoan Tran <hotran@apm.com>

SMBus block command uses the first byte of buffer for the data length.
The dma_buffer should be increased by 1 to avoid the overrun issue.

Reported-by: Phil Endecott <phil_gjouf_endecott@chezphil.org>
Signed-off-by: Hoan Tran <hotran@apm.com>
---
 drivers/i2c/busses/i2c-xgene-slimpro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-xgene-slimpro.c b/drivers/i2c/busses/i2c-xgene-slimpro.c
index 4233f56..3c38029 100644
--- a/drivers/i2c/busses/i2c-xgene-slimpro.c
+++ b/drivers/i2c/busses/i2c-xgene-slimpro.c
@@ -105,7 +105,7 @@ struct slimpro_i2c_dev {
 	struct mbox_chan *mbox_chan;
 	struct mbox_client mbox_client;
 	struct completion rd_complete;
-	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX];
+	u8 dma_buffer[I2C_SMBUS_BLOCK_MAX + 1]; /* dma_buffer[0] is used for length */
 	u32 *resp_msg;
 };
 
-- 
1.9.1
