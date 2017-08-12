From: Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v2 0/2] Add i2c dt-binding and compatible for Mediatek MT7622 SoC
Date: Sat, 12 Aug 2017 10:57:50 +0800
Message-ID: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch series based on v4.13-rc1, include MT7622 i2c dt-binding
and compatible.

changes since v1:
- Modify commit message
- Revise dt-binding documentation

Jun Gao (2):
  dt-bindings: i2c: Add MediaTek MT7622 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT7622

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 11 ++++++-----
 drivers/i2c/busses/i2c-mt65xx.c                   | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

--
1.8.1.1
