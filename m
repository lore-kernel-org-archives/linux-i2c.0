From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH 3/5] ARM: dts: Add I2C1 support for STM32F429 SoC
Date: Wed, 11 May 2016 17:36:12 +0200
Message-ID: <1462980974-22091-4-git-send-email-cedric.madianga@gmail.com>
References: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462980974-22091-1-git-send-email-cedric.madianga@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mcoquelin.stm32@gmail.com, patrice.chotard@st.com, wsa@the-dreams.de, robh+dt@kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 434d4b9..cbfeb4e 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -323,6 +323,18 @@
 					slew-rate = <2>;
 				};
 			};
+
+			i2c1_sda_pin: i2c1_sda@0 {
+				pins {
+					pinmux = <STM32F429_PB9_FUNC_I2C1_SDA>;
+					drive-open-drain;
+				};
+			};
+			i2c1_scl_pin: i2c1_scl@0 {
+				pins {
+					pinmux = <STM32F429_PB6_FUNC_I2C1_SCL>;
+				};
+			};
 		};
 
 		rcc: rcc@40023800 {
@@ -395,6 +407,18 @@
 			interrupts = <80>;
 			clocks = <&rcc 0 38>;
 		};
+
+		i2c1: i2c@40005400 {
+			compatible = "st,i2c-stm32f4";
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
