From: Qii Wang <qii.wang@mediatek.com>
Subject: [PATCH v6 0/6] add i2c support for mt8183
Date: Mon, 11 Mar 2019 13:40:34 +0800
Message-ID: <1552282840-12778-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com, robh@kernel.org
List-Id: linux-i2c@vger.kernel.org

This series are based on 5.0-rc1(i2c/for-next) and these series
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017570.html
http://lists.infradead.org/pipermail/linux-mediatek/2019-February/017320.html
http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017196.html 

We provide six patches to support mt8183 IC.

Main changes compared to v5:
--add i2c controller nodes in mt8183.dtsi
--add a note that old i2c controllers also have I2C_ARB_LOST bit
--add a flag(ltiming_adjust) to avoid unnecessary settings
--add Reviewed-by from Rob Herring, Nicolas and Matthias

Main changes compared to v4:
--modify the commit of arb clock dt-binding
--split a patch(3/3) into three(3/5 4/5 5/5)

Main changes compared to v3:
--remove the patches which have been applied to for-next
--remove i2c fallback for i3c controller 

Main changes compared to v2:
--update commit message
--add Reviewed-by from Rob Herring, Nicolas and Sean

Main changes compared to v1:
--remove useless dt-binding for mt7629
--split a patch into two(2/6 3/6)
--muti-user feature was dropped

Qii Wang (6):
  i2c: mediatek: Add offsets array for new i2c registers
  dt-bindings: i2c: Add Mediatek MT8183 i2c binding
  i2c: mediatek: Add arb clock in i2c driver
  i2c: mediatek: Add i2c and apdma sync in i2c driver
  i2c: mediatek: Add i2c support for MediaTek MT8183
  dts: arm64: mt8183: Add I2C nodes

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |   4 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi          | 190 ++++++++++++++++
 drivers/i2c/busses/i2c-mt65xx.c                   | 255 ++++++++++++++++------
 3 files changed, 387 insertions(+), 62 deletions(-)

-- 
1.9.1
