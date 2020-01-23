From: Alain Volmat <alain.volmat@st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: use st,stm32mp15-i2c compatible for stm32mp151
Date: Thu, 23 Jan 2020 17:12:49 +0100
Message-ID: <1579795970-22319-5-git-send-email-alain.volmat@st.com>
References: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1579795970-22319-1-git-send-email-alain.volmat@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com, alain.volmat@st.com
List-Id: linux-i2c@vger.kernel.org

Replace previous st,stm32f7-i2c compatible with st,stm32mp15-i2c
for the platform stm32mp151.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 02918dd6cf25..2dbf32ca9b36 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -474,7 +474,7 @@
 		};
 
 		i2c1: i2c@40012000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x40012000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
@@ -488,7 +488,7 @@
 		};
 
 		i2c2: i2c@40013000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x40013000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
@@ -502,7 +502,7 @@
 		};
 
 		i2c3: i2c@40014000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x40014000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
@@ -516,7 +516,7 @@
 		};
 
 		i2c5: i2c@40015000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x40015000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
@@ -1468,7 +1468,7 @@
 		};
 
 		i2c4: i2c@5c002000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x5c002000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
@@ -1504,7 +1504,7 @@
 		};
 
 		i2c6: i2c@5c009000 {
-			compatible = "st,stm32f7-i2c";
+			compatible = "st,stm32mp15-i2c";
 			reg = <0x5c009000 0x400>;
 			interrupt-names = "event", "error";
 			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.7.4
