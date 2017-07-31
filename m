From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 06/14] ARM: dts: rockchip: add i2c dt node for rv1108
Date: Mon, 31 Jul 2017 18:13:39 +0800
Message-ID: <1501496019-21659-1-git-send-email-andy.yan@rock-chips.com>
References: <1501495449-21290-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501495449-21290-1-git-send-email-andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There are four i2c controllers on rv1108, add
device tree node for them.

Signed-off-by: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 arch/arm/boot/dts/rv1108.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 0da144c..a4d34d9 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -52,6 +52,10 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
@@ -154,11 +158,67 @@
 		status = "disabled";
 	};
 
+	i2c1: i2c@10240000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10240000 0x1000>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C1>, <&cru PCLK_I2C1>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_xfer>;
+		status = "disabled";
+	};
+
+	i2c2: i2c@10250000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10250000 0x1000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C2>, <&cru PCLK_I2C2>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2m1_xfer>;
+		status = "disabled";
+	};
+
+	i2c3: i2c@10260000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x10260000 0x1000>;
+		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C3>, <&cru PCLK_I2C3>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_xfer>;
+		status = "disabled";
+	};
+
 	grf: syscon@10300000 {
 		compatible = "rockchip,rv1108-grf", "syscon";
 		reg = <0x10300000 0x1000>;
 	};
 
+	i2c0: i2c@20000000 {
+		compatible = "rockchip,rv1108-i2c";
+		reg = <0x20000000 0x1000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&cru SCLK_I2C0_PMU>, <&cru PCLK_I2C0_PMU>;
+		clock-names = "i2c", "pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_xfer>;
+		status = "disabled";
+	};
+
 	pmugrf: syscon@20060000 {
 		compatible = "rockchip,rv1108-pmugrf", "syscon";
 		reg = <0x20060000 0x1000>;
@@ -330,6 +390,18 @@
 			input-enable;
 		};
 
+		pcfg_pull_none_smt: pcfg-pull-none-smt {
+			bias-disable;
+			input-schmitt-enable;
+		};
+
+		i2c0 {
+			i2c0_xfer: i2c0-xfer {
+				rockchip,pins = <0 RK_PB1 RK_FUNC_1 &pcfg_pull_none_smt>,
+						<0 RK_PB2 RK_FUNC_1 &pcfg_pull_none_smt>;
+			};
+		};
+
 		i2c1 {
 			i2c1_xfer: i2c1-xfer {
 				rockchip,pins = <2 RK_PD3 RK_FUNC_1 &pcfg_pull_up>,
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
