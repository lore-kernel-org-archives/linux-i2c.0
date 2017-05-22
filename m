From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/4] dt-bindigns: i2c-mtk: Delete bindings
Date: Mon, 22 May 2017 11:40:20 +0200
Message-ID: <20170522094021.7837-3-matthias.bgg@gmail.com>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170522094021.7837-1-matthias.bgg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com
Cc: wsa@the-dreams.de, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: linux-i2c@vger.kernel.org

The bindings file list bindings for mt1827 and mt8135 but
these bindings are not supported by the driver. Remove the bindings.
Also do some minor style changes to the compatible documentation

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index 0ce6fa3242f0..060a9ec98215 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -4,11 +4,9 @@ The Mediatek's I2C controller is used to interface with I2C devices.
 
 Required properties:
   - compatible: value should be either of the following.
-      (a) "mediatek,mt6577-i2c", for i2c compatible with mt6577 i2c.
-      (b) "mediatek,mt6589-i2c", for i2c compatible with mt6589 i2c.
-      (c) "mediatek,mt8127-i2c", for i2c compatible with mt8127 i2c.
-      (d) "mediatek,mt8135-i2c", for i2c compatible with mt8135 i2c.
-      (e) "mediatek,mt8173-i2c", for i2c compatible with mt8173 i2c.
+      "mediatek,mt6577-i2c": for i2c compatible with mt6577.
+      "mediatek,mt6589-i2c": for i2c compatible with mt6589.
+      "mediatek,mt8173-i2c": for i2c compatible with mt8173.
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
-- 
2.12.0
