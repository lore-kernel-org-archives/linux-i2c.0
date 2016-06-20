From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v3 3/5] ARM: dts: Add I2C1 support for STM32F429 SoC
Date: Mon, 20 Jun 2016 18:22:49 +0200
Message-ID: <1466439771-2741-4-git-send-email-cedric.madianga@gmail.com>
References: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466439771-2741-1-git-send-email-cedric.madianga@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: patrice.chotard@st.com, mcoquelin.stm32@gmail.com, wsa@the-dreams.de, robh+dt@kernel.org, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 434d4b9..4eaa107 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -323,6 +323,16 @@
 					slew-rate = <2>;
 				};
 			};
+
+			i2c1_pins_b: i2c1@0 {
+				pins1 {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
+					drive-open-drain;
+				};
+				pins2 {
+					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
+				};
+			};
 		};
 
 		rcc: rcc@40023800 {
@@ -395,6 +405,18 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		i2c1: i2c@40005400 {
+			compatible = "st,stm32f4-i2c";
+			reg = <0x40005400 0x400>;
+			interrupts = <31>,
+				     <32>;
+			resets = <&rcc 277>;
+			clocks = <&rcc 0 149>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
