From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/4] dt-bindings: i2c-mtk: Add mt7623 binding
Date: Mon, 22 May 2017 11:40:21 +0200
Message-ID: <20170522094021.7837-4-matthias.bgg@gmail.com>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33010 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758209AbdEVJks (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 22 May 2017 05:40:48 -0400
In-Reply-To: <20170522094021.7837-1-matthias.bgg@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: wsa@the-dreams.de, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>

The mt7623 dtsi has support for the i2c block, but this is not documented.
Add the documentation for SoC mt7623 to de description.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index 060a9ec98215..aa36099dcee7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -6,6 +6,7 @@ Required properties:
   - compatible: value should be either of the following.
       "mediatek,mt6577-i2c": for i2c compatible with mt6577.
       "mediatek,mt6589-i2c": for i2c compatible with mt6589.
+      "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for i2c compatible with mt7623.
       "mediatek,mt8173-i2c": for i2c compatible with mt8173.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
-- 
2.12.0
