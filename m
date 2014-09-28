From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 3/3] ARM: dts: hix5hd2: add i2c node
Date: Sun, 28 Sep 2014 12:22:09 +0800
Message-ID: <1411878129-19743-4-git-send-email-zhangfei.gao@linaro.org>
References: <1411878129-19743-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411878129-19743-1-git-send-email-zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, haifeng.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jchxue-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/hisi-x5hd2.dtsi |   60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/hisi-x5hd2.dtsi b/arch/arm/boot/dts/hisi-x5hd2.dtsi
index d3d99fb..17d0637 100644
--- a/arch/arm/boot/dts/hisi-x5hd2.dtsi
+++ b/arch/arm/boot/dts/hisi-x5hd2.dtsi
@@ -476,5 +476,65 @@
                         interrupts = <0 70 4>;
                         clocks = <&clock HIX5HD2_SATA_CLK>;
 		};
+
+		i2c0: i2c@b10000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb10000 0x1000>;
+			interrupts = <0 38 4>;
+			clocks = <&clock HIX5HD2_I2C0_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@b11000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb11000 0x1000>;
+			interrupts = <0 39 4>;
+			clocks = <&clock HIX5HD2_I2C1_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@b12000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb12000 0x1000>;
+			interrupts = <0 40 4>;
+			clocks = <&clock HIX5HD2_I2C2_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@b13000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb13000 0x1000>;
+			interrupts = <0 41 4>;
+			clocks = <&clock HIX5HD2_I2C3_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@b16000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb16000 0x1000>;
+			interrupts = <0 43 4>;
+			clocks = <&clock HIX5HD2_I2C4_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@b17000 {
+			compatible = "hisilicon,hix5hd2-i2c";
+			reg = <0xb17000 0x1000>;
+			interrupts = <0 44 4>;
+			clocks = <&clock HIX5HD2_I2C5_RST>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.9.5
