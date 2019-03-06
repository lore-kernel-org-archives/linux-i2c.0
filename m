From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 1/2] dt-bindings: i2c-stm32: remove extra spaces
Date: Wed, 6 Mar 2019 15:11:51 +0000
Message-ID: <1551885100-22207-2-git-send-email-bich.hemon@st.com>
References: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551885100-22207-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Pierre Yves MORDRET <pierre-yves.mordret@st.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Bich HEMON <bich.hemon@st.com>
List-Id: linux-i2c@vger.kernel.org

Remove extra spaces before colons.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 .../devicetree/bindings/i2c/i2c-stm32.txt          | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index 69240e1..7d054f1 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -1,11 +1,11 @@
 * I2C controller embedded in STMicroelectronics STM32 I2C platform
 
-Required properties :
-- compatible : Must be one of the following
+Required properties:
+- compatible: Must be one of the following
   - "st,stm32f4-i2c"
   - "st,stm32f7-i2c"
-- reg : Offset and length of the register set for the device
-- interrupts : Must contain the interrupt id for I2C event and then the
+- reg: Offset and length of the register set for the device
+- interrupts: Must contain the interrupt id for I2C event and then the
   interrupt id for I2C error.
 - resets: Must contain the phandle to the reset controller.
 - clocks: Must contain the input clock of the I2C instance.
@@ -14,25 +14,25 @@ Required properties :
 - #address-cells = <1>;
 - #size-cells = <0>;
 
-Optional properties :
-- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
+Optional properties:
+- clock-frequency: Desired I2C bus clock frequency in Hz. If not specified,
   the default 100 kHz frequency will be used.
   For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
   100000 and 400000.
   For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
   possible values are 100000, 400000 and 1000000.
-- i2c-scl-rising-time-ns : Only for STM32F7, I2C SCL Rising time for the board
+- i2c-scl-rising-time-ns: Only for STM32F7, I2C SCL Rising time for the board
   (default: 25)
-- i2c-scl-falling-time-ns : Only for STM32F7, I2C SCL Falling time for the board
+- i2c-scl-falling-time-ns: Only for STM32F7, I2C SCL Falling time for the board
   (default: 10)
   I2C Timings are derived from these 2 values
-- st,syscfg-fmp:  Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
+- st,syscfg-fmp: Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
   whether Fast Mode Plus speed is selected by slave.
-	1st cell : phandle to syscfg
-	2nd cell : register offset within SYSCFG
-	3rd cell : register bitmask for FMP bit
+	1st cell: phandle to syscfg
+	2nd cell: register offset within SYSCFG
+	3rd cell: register bitmask for FMP bit
 
-Example :
+Example:
 
 	i2c@40005400 {
 		compatible = "st,stm32f4-i2c";
-- 
1.9.1
