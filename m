From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v3 1/5] dt-bindings: i2c-stm32: Document the STM32F7 I2C bindings
Date: Fri, 1 Sep 2017 09:34:11 +0200
Message-ID: <1504251255-20469-2-git-send-email-pierre-yves.mordret@st.com>
References: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55616 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751354AbdIAHfV (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 1 Sep 2017 03:35:21 -0400
In-Reply-To: <1504251255-20469-1-git-send-email-pierre-yves.mordret@st.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Russell King <linux@armlinux.org.uk>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

This patch adds the documentation of device tree bindings for STM32F7 I2C

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Version history:
    v3:
        * None
    v2:
        * Remove i2c-timing binding in order to use generic bindings SCL
          Rising and Falling time instead
---
---
 .../devicetree/bindings/i2c/i2c-stm32.txt          | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index 78eaf7b..3b54899 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -1,7 +1,9 @@
 * I2C controller embedded in STMicroelectronics STM32 I2C platform
 
 Required properties :
-- compatible : Must be "st,stm32f4-i2c"
+- compatible : Must be one of the following
+  - "st,stm32f4-i2c"
+  - "st,stm32f7-i2c"
 - reg : Offset and length of the register set for the device
 - interrupts : Must contain the interrupt id for I2C event and then the
   interrupt id for I2C error.
@@ -14,8 +16,16 @@ Required properties :
 
 Optional properties :
 - clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
-  the default 100 kHz frequency will be used. As only Normal and Fast modes
-  are supported, possible values are 100000 and 400000.
+  the default 100 kHz frequency will be used.
+  For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
+  100000 and 400000.
+  For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
+  possible values are 100000, 400000 and 1000000.
+- i2c-scl-rising-time-ns : Only for STM32F7, I2C SCL Rising time for the board
+  (default: 25)
+- i2c-scl-falling-time-ns : Only for STM32F7, I2C SCL Falling time for the board
+  (default: 10)
+  I2C Timings are derived from these 2 values
 
 Example :
 
@@ -31,3 +41,16 @@ Example :
 		pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
 		pinctrl-names = "default";
 	};
+
+	i2c@40005400 {
+		compatible = "st,stm32f7-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x40005400 0x400>;
+		interrupts = <31>,
+			     <32>;
+		resets = <&rcc STM32F7_APB1_RESET(I2C1)>;
+		clocks = <&rcc 1 CLK_I2C1>;
+		pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
+		pinctrl-names = "default";
+	};
-- 
2.7.4
