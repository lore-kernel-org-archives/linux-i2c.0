From: Xudong Chen <xudong.chen@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: Add I2C bindings for mt65xx/mt81xx.
Date: Wed, 29 Oct 2014 13:37:36 +0800
Message-ID: <1414561058-23803-2-git-send-email-xudong.chen@mediatek.com>
References: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1414561058-23803-1-git-send-email-xudong.chen@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>, arm@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Xudong Chen <xudong.chen@mediatek.com>, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, YH Chen <yh.chen@mediatek.com>, linux-kernel@vger.kernel.org, Nathan Chung <nathan.chung@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Add devicetree bindings for Mediatek Soc I2C driver.

Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
---
 .../devicetree/bindings/i2c/i2c-mt6577.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt6577.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
new file mode 100644
index 0000000..b4012c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
@@ -0,0 +1,37 @@
+* Mediatek's I2C controller
+
+The Mediatek's I2C controller is used to interface with I2C devices.
+
+Required properties:
+  - compatible: value should be either of the following.
+      (a) "mtk,mt6577-i2c", for i2c compatible with mt6577 i2c.
+      (b) "mtk,mt8127-i2c", for i2c compatible with mt8127 i2c.
+      (c) "mtk,mt8135-i2c", for i2c compatible with mt8135 i2c.
+  - reg: physical base address of the controller and dma base, length of memory mapped
+    region.
+  - interrupts: interrupt number to the cpu.
+  - clock-div: the fixed value for frequency divider of clock source in i2c module.
+    Each IC may be different.
+  - clocks: clock name from clock manager
+  - clock-names: clock name used in i2c driver probe
+
+Optional properties:
+  - clock-frequency: Frequency in Hz of the bus when transfer, the default value is 100000.
+  - mediatek,have-pmic: platform can control i2c form special pmic side.
+  - mediatek,have-dcm: platform has DCM(hardware digital clock manager) property.
+  - mediatek,use-push-pull: IO use push-pull mode.
+
+Example:
+
+	i2c0: i2c@1100d000 {
+			compatible = "mediatek,mt6577-i2c";
+			reg = <0x1100d000 0x70>,
+			      <0x11000300 0x80>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
+			clock-frequency = <100000>;
+			mediatek,have-pmic;
+			clock-div = <16>;
+			clocks = <&i2c0_ck>, <&ap_dma_ck>;
+			clock-names = "main", "dma";
+	};
+
-- 
1.8.1.1.dirty
