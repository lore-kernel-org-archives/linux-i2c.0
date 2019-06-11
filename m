From: Qii Wang <qii.wang@mediatek.com>
Subject: [PATCH 0/2] Add support for AC timing adjustment
Date: Tue, 11 Jun 2019 16:11:53 +0800
Message-ID: <1560240715-22595-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, matthias.bgg@gmail.com, robh+dt@kernel.org
List-Id: linux-i2c@vger.kernel.org

This series are based on 5.2-rc1, we provide two patches to
support AC timing adjustment.

Qii Wang (2):
  dt-bindings: i2c: Add MediaTek i2c AC timing binding
  i2c: mediatek: Add i2c AC timing adjust support

 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |   11 +++
 drivers/i2c/busses/i2c-mt65xx.c                    |   94 +++++++++++++++++---
 2 files changed, 93 insertions(+), 12 deletions(-)

-- 
1.7.9.5
