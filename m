From: Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH 0/3] Add i2c dt-binding and compatible for Mediatek MT2712
Date: Tue, 19 Dec 2017 14:51:00 +0800
Message-ID: <1513666263-6443-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:31418 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S937433AbdLSGvO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Dec 2017 01:51:14 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

This patch series based on v4.15-rc1, include MT2712 i2c dt-binding, compatible
and i2c module clock enable.

Jun Gao (3):
  dt-bindings: i2c: Add MediaTek MT2712 i2c binding
  i2c: mediatek: Add i2c compatible for MediaTek MT2712
  i2c: mediatek: Enable i2c module clock before i2c registers access.

 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |  1 +
 drivers/i2c/busses/i2c-mt65xx.c                   | 40 ++++++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)
