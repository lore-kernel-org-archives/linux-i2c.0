From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2] i2c: at91: change log when dma configuration fails
Date: Fri, 13 May 2016 14:24:21 +0200
Message-ID: <1463142261-26321-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:58442 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbcEMMXx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 13 May 2016 08:23:53 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>

When the DMA configuration fails, there is a log reporting that we can't
use DMA and indicating the error number. When booting the kernel, it is
annoying to see this error number. Moreover, people can think something
is going wrong. It is not the case, it means that DMA can't be used but
it doesn't prevent to use i2c.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/i2c/busses/i2c-at91.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes:
- v2:
  - remove ret parameter

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 921d32b..6384d08 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1013,7 +1013,7 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 
 error:
 	if (ret != -EPROBE_DEFER)
-		dev_info(dev->dev, "can't use DMA, error %d\n", ret);
+		dev_info(dev->dev, "can't request DMA channels, continue without DMA support\n");
 	if (dma->chan_rx)
 		dma_release_channel(dma->chan_rx);
 	if (dma->chan_tx)
-- 
2.5.0
