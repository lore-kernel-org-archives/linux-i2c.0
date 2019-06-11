From: Qii Wang <qii.wang@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: i2c: Add MediaTek i2c AC timing binding
Date: Tue, 11 Jun 2019 16:11:54 +0800
Message-ID: <1560240715-22595-2-git-send-email-qii.wang@mediatek.com>
References: <1560240715-22595-1-git-send-email-qii.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560240715-22595-1-git-send-email-qii.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, qii.wang@mediatek.com, matthias.bgg@gmail.com, robh+dt@kernel.org
List-Id: linux-i2c@vger.kernel.org

Add i2c AC timing binding to binding file. It can give the AC
timing parameters to meet I2C specification at different speed.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 .../devicetree/bindings/i2c/i2c-mt65xx.txt         |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
index 68f6d73..0f92813 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
@@ -30,6 +30,7 @@ Optional properties:
   - mediatek,have-pmic: platform can control i2c form special pmic side.
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
+  - ac-timing: give some AC timing parameters to meet i2c spec fully.
 
 Example:
 
@@ -43,5 +44,15 @@ Example:
 			clock-div = <16>;
 			clocks = <&i2c0_ck>, <&ap_dma_ck>;
 			clock-names = "main", "dma";
+			ac-timing =  /bits/ 16 <
+				0x8001	/* 0:ext */
+				0x0005	/* 1:inter_clk_div */
+				0x0102	/* 2:scl_hl_ratio */
+				0x0102	/* 3:hs_scl_hl_ratio */
+				0x0002	/* 4:scl_mis_comp */
+				0x0002	/* 5:sta_stop */
+				0x0002	/* 6:hs_sta_stop */
+				0x0002	/* 7:sda_timing */
+			>;
 	};
 
-- 
1.7.9.5
