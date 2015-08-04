From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH 0/2] Mediatek I2C fixup
Date: Tue, 4 Aug 2015 19:44:51 +0800
Message-ID: <1438688693-60275-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This series provide two patches to optimize mediatek i2c driver.
The first patch will reset dma hardware in init function to make sure
hardware work in good state. The second patch fix i2c interrupt handling
for ACK error. All these patches base on v4.2-rc1.

Eddie Huang (2):
  i2c: mediatek: Reset DMA engine in hardware init function
  i2c: mediatek: Fixup i2c ack error interrupt handling

 drivers/i2c/busses/i2c-mt65xx.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
1.7.9.5
