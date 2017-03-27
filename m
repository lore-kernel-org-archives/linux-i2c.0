From: <cl@rock-chips.com>
Subject: [PATCH v4 6/6] dt-bindings: document rockchip rk3328-evb board
Date: Mon, 27 Mar 2017 17:46:23 +0800
Message-ID: <1490607983-5599-1-git-send-email-cl@rock-chips.com>
References: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1490607650-18650-1-git-send-email-cl@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, kever.yang@rock-chips.com, dianders@chromium.org, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de, zhengxing@rock-chips.com, khilman@baylibre.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, Liang Chen <cl@rock-chips.com>, wxt@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, zhangqing@rock-chips.com, paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com, knaack.h@gmx.de, robh+dt@kernel.org, matthias.bgg@gmail.com, rocky.hao@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, david.wu@rock-chips.com, fabio.estevam@nxp.com, andy.yan@rock-chips.com, akpm@linux-foundation.org, shawnguo@kernel.org
List-Id: linux-i2c@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Use "rockchip,rk3328-evb" compatible string for Rockchip RK3328
evaluation board.

Signed-off-by: Liang Chen <cl@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
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
