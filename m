From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 2/2] i2c: sh_mobile: avoid unused return
Date: Tue, 15 Aug 2017 22:36:24 +0200
Message-ID: <20170815203624.19274-3-erosca@de.adit-jv.com>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:35202 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdHOUp5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Aug 2017 16:45:57 -0400
In-Reply-To: <20170815203624.19274-1-erosca@de.adit-jv.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>

Fix smatch warning:
drivers/i2c/busses/i2c-sh_mobile.c:564 \
  sh_mobile_i2c_request_dma_chan() warn: unused return: ret = PTR_ERR()

Fixes: fe07adec730d ("i2c: sh_mobile: fix uninitialized var when debug is enabled")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 2e097d97d258..6f2aaeb7c4fa 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -561,8 +561,8 @@ static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
 
 	chan = dma_request_slave_channel_reason(dev, chan_name);
 	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);
+		dev_dbg(dev, "request_channel failed for %s (%ld)\n", chan_name,
+			PTR_ERR(chan));
 		return chan;
 	}
 
-- 
2.14.1
