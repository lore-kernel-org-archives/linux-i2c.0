From: <cl@rock-chips.com>
Subject: [PATCH v2 6/6] dt-bindings: document rockchip rk3328-evb board
Date: Thu, 16 Mar 2017 21:23:06 +0800
Message-ID: <1489670586-16120-1-git-send-email-cl@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, zhengxing@rock-chips.com, andy.yan@rock-chips.com, jay.xu@rock-chips.com, matthias.bgg@gmail.com, paweljarosz3691@gmail.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wxt@rock-chips.com, david.wu@rock-chips.com, linux-iio@vger.kernel.org, shawn.lin@rock-chips.com, akpm@linux-foundation.org, dianders@chromium.org, yamada.masahiro@socionext.com, catalin.marinas@arm.com, will.deacon@arm.com, afaerber@suse.de, shawnguo@kernel.org, khilman@baylibre.com, arnd@arndb.de, fabio.estevam@nxp.com, zhangqing@rock-chips.com, kever.yang@rock-chips.com
List-Id: linux-i2c@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
evaluation board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/arm/rockchip.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..17611cd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -141,3 +141,7 @@ Rockchip platforms device tree bindings
 - Tronsmart Orion R68 Meta
     Required root node properties:
       - compatible = "tronsmart,orion-r68-meta", "rockchip,rk3368";
+
+- Rockchip RK3328 evb:
+    Required root node properties:
+      - compatible = "rockchip,rk3328-evb", "rockchip,rk3328";
-- 
1.9.1
