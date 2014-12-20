From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: sh_mobile: fix uninitialized var when debug is enabled
Date: Sat, 20 Dec 2014 09:36:42 +0100
Message-ID: <1419064602-8529-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index a12297e7680a..440d5dbc8b5f 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -550,6 +550,7 @@ static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
 
 	chan = dma_request_slave_channel_reason(dev, chan_name);
 	if (IS_ERR(chan)) {
+		ret = PTR_ERR(chan);
 		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);
 		return chan;
 	}
-- 
2.1.3

