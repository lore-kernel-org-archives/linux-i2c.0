From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 1/2] i2c: rcar: avoid unused return
Date: Tue, 15 Aug 2017 22:36:23 +0200
Message-ID: <20170815203624.19274-2-erosca@de.adit-jv.com>
References: <20170815203624.19274-1-erosca@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:35204 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752612AbdHOUp5 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Aug 2017 16:45:57 -0400
In-Reply-To: <20170815203624.19274-1-erosca@de.adit-jv.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>

Fix smatch warning:
drivers/i2c/busses/i2c-rcar.c:628 \
  rcar_i2c_request_dma_chan() warn: unused return: ret = PTR_ERR()

Fixes: 73e8b0528346 ("i2c: rcar: add DMA support")
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/i2c/busses/i2c-rcar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 93c1a54981df..15d764afec3b 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -625,9 +625,8 @@ static struct dma_chan *rcar_i2c_request_dma_chan(struct device *dev,
 
 	chan = dma_request_chan(dev, chan_name);
 	if (IS_ERR(chan)) {
-		ret = PTR_ERR(chan);
-		dev_dbg(dev, "request_channel failed for %s (%d)\n",
-			chan_name, ret);
+		dev_dbg(dev, "request_channel failed for %s (%ld)\n",
+			chan_name, PTR_ERR(chan));
 		return chan;
 	}
 
-- 
2.14.1
