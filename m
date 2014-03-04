From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v3 3/5] ARM: sun6i: Enable the I2C controllers
Date: Tue,  4 Mar 2014 17:28:39 +0100
Message-ID: <1393950521-4173-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBLEA3CMAKGQEYS3SBUA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1393950521-4173-1-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The A31 has 4 I2C controllers that are the same than the one in the
other Allwinner SoCs, except for the fact that they are asserted in
reset by the reset unit.

Add these i2c controllers to the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index af6f87c..22d3eae 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -359,6 +359,46 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c@01c2ac00 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2ac00 0x400>;
+			interrupts = <0 6 4>;
+			clocks = <&apb2_gates 0>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@01c2b000 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b000 0x400>;
+			interrupts = <0 7 4>;
+			clocks = <&apb2_gates 1>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 1>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@01c2b400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b400 0x400>;
+			interrupts = <0 8 4>;
+			clocks = <&apb2_gates 2>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@01c2b800 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01c2b800 0x400>;
+			interrupts = <0 9 4>;
+			clocks = <&apb2_gates 3>;
+			clock-frequency = <100000>;
+			resets = <&apb2_rst 3>;
+			status = "disabled";
+		};
+
 		spi0: spi@01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
-- 
1.9.0
