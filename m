From: <cl@rock-chips.com>
Subject: [PATCH v2 2/6] dt-bindings: i2c: rk3x: add support for rk3328
Date: Thu, 16 Mar 2017 21:17:20 +0800
Message-ID: <1489670244-13328-3-git-send-email-cl@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
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

The rk3328 i2c is the same as rk3399

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
index bbc5a1e..e18445d 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
@@ -11,6 +11,7 @@ Required properties :
    - "rockchip,rk3188-i2c": for rk3188
    - "rockchip,rk3228-i2c": for rk3228
    - "rockchip,rk3288-i2c": for rk3288
+   - "rockchip,rk3328-i2c", "rockchip,rk3399-i2c": for rk3328
    - "rockchip,rk3399-i2c": for rk3399
  - interrupts : interrupt number
  - clocks: See ../clock/clock-bindings.txt
-- 
1.9.1
