From: Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Mediatek MT2701 i2c binding
Date: Fri, 26 May 2017 15:35:06 +0800
Message-ID: <1495784107-6711-2-git-send-email-jun.gao@mediatek.com>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:50721 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1163733AbdEZHfT (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 26 May 2017 03:35:19 -0400
In-Reply-To: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Jun Gao <jun.gao@mediatek.com>

From: Jun Gao <jun.gao@mediatek.com>

Add MT2701 i2c binding to i2c-mt6577.txt and there is no need to
modify i2c driver.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
index 0ce6fa3..52f2023 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -4,11 +4,12 @@ The Mediatek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
-      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
-      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
-      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
-      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
+	"mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
+	"mediatek,mt6577-i2c": for Mediatek MT6577
+	"mediatek,mt6589-i2c": for Mediatek MT6589
+	"mediatek,mt8127-i2c": for Mediatek MT8127
+	"mediatek,mt8135-i2c": for Mediatek MT8135
+	"mediatek,mt8173-i2c": for Mediatek MT8173
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
1.8.1.1
