From: qii wang <qii.wang@mediatek.com>
Subject: [PATCH v3 0/6] add i2c support for mt7629 and mt8183
Date: Mon, 21 Jan 2019 15:59:28 +0800
Message-ID: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

This series are based on 5.0-rc1 and provide six patches to support
mt7629 and mt8183 IC.

Main changes compared to v2:
--update commit message
--add Reviewed-by from Rob Herring, Nicolas and Sean

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

qii wang (6):
  dt-bindings: i2c: Add Mediatek MT7629 i2c binding
  i2c: mediatek: speeds is replaced by macros definitions
  i2c: mediatek: remove completion_done()
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add i2c support for MediaTek MT8183

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    7 +-
 drivers/i2c/busses/i2c-mt65xx.c                   |  288 ++++++++++++++++-----
 2 files changed, 227 insertions(+), 68 deletions(-)

-- 
1.7.9.5
