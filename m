From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH v4] arm64: dts: add all hi6220 i2c nodes
Date: Wed, 2 Dec 2015 18:13:21 +0800
Message-ID: <1449051201-7288-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: pawel.moll@arm.com, puck.chen@hisilicon.com, galak@codeaurora.org, w.f@huawei.com, kong.kongxinwei@hisilicon.com, catalin.marinas@arm.com, liguozhu@hisilicon.com
List-Id: linux-i2c@vger.kernel.org

This patch adds all I2C nodes for the Hi6220 SoC. This hi6220 Soc
use this I2C IP of Synopsys Designware for HiKey board.

Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 34 +++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 82d2488..8cec56a 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -208,5 +208,39 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		i2c0: i2c@f7100000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7100000 0x0 0x1000>;
+			interrupts = <0 44 4>;
+			clocks = <&sys_ctrl HI6220_I2C0_CLK>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@f7101000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7101000 0x0 0x1000>;
+			clocks = <&sys_ctrl HI6220_I2C1_CLK>;
+			interrupts = <0 45 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@f7102000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0xf7102000 0x0 0x1000>;
+			clocks = <&sys_ctrl HI6220_I2C2_CLK>;
+			interrupts = <0 46 4>;
+			i2c-sda-hold-time-ns = <300>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.9.1
