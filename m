From: <qii.wang@mediatek.com>
Subject: [PATCH 0/5] add i2c support for mt7629 and mt8183
Date: Mon, 3 Dec 2018 21:32:49 +0800
Message-ID: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, ryder.lee@mediatek.com
List-Id: linux-i2c@vger.kernel.org

This series are based on 4.20-rc1 and provide five patches to support
mt7629 and mt8183 IC.

qii wang (5):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: remove useless code and replace definitions
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    8 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  299 ++++++++++++++++-----
 2 files changed, 239 insertions(+), 68 deletions(-)

-- 
1.7.9.5
