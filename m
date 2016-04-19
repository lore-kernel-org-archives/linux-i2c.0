From: Martin Ayotte <martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/1] add missing UARTs pins and I2C
 entriesfor AllWinner H3 DTSI
Date: Tue, 19 Apr 2016 15:50:39 -0400
Message-ID: <CAKQ8BtjPhfJC+njOUvo-4ZQ+Oj==LqQEhJ1LQROjY85hswE9Mg@mail.gmail.com>
Reply-To: martinayotte-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDW4XUV4YULRBD4Y3K4AKGQE3AOPO4I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: Hans De Goede <jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jens Kuske <jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Jean=2DFran=C3=A7ois_Moine?= <moinejf-GANU6spQydw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi everyone,

This patch is submit to provide endusers access to additional UARTs on
AllWinner H3 SoC along with I2C ports.

Regards,
Martin.

---
 arch/arm/boot/dts/sun8i-h3.dtsi | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b..c947360d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -508,6 +508,48 @@
                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
             };

+            uart1_pins_a: uart1@0 {
+                allwinner,pins = "PG6", "PG7";
+                allwinner,function = "uart1";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            uart2_pins_a: uart2@0 {
+                allwinner,pins = "PA0", "PA1";
+                allwinner,function = "uart2";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            uart3_pins_a: uart3@0 {
+                allwinner,pins = "PA13", "PA14";
+                allwinner,function = "uart3";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c0_pins_a: i2c0@0 {
+                allwinner,pins = "PA11", "PA12";
+                allwinner,function = "i2c0";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c1_pins_a: i2c1@0 {
+                allwinner,pins = "PA18", "PA19";
+                allwinner,function = "i2c1";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
+            i2c2_pins_a: i2c2@0 {
+                allwinner,pins = "PE12", "PE13";
+                allwinner,function = "i2c2";
+                allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+                allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+            };
+
             mmc0_pins_a: mmc0@0 {
                 allwinner,pins = "PF0", "PF1", "PF2", "PF3",
                          "PF4", "PF5";
@@ -626,6 +668,39 @@
             status = "disabled";
         };

+        i2c0: i2c@01c2ac00 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2ac00 0x400>;
+            interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 96>;
+            resets = <&apb2_rst 0>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c1: i2c@01c2b000 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2b000 0x400>;
+            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 97>;
+            resets = <&apb2_rst 1>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
+        i2c2: i2c@01c2b400 {
+            compatible = "allwinner,sun6i-a31-i2c";
+            reg = <0x01c2b400 0x400>;
+            interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&bus_gates 98>;
+            resets = <&apb2_rst 2>;
+            status = "disabled";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+
         gic: interrupt-controller@01c81000 {
             compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
             reg = <0x01c81000 0x1000>,
-- 
2.7.4
