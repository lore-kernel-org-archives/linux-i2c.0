From: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 2/2] dt-bindings: i2c-stm32: update optional properties for
 stm32h7/stm32mp1
Date: Wed, 6 Mar 2019 15:11:51 +0000
Message-ID: <1551885100-22207-3-git-send-email-bich.hemon@st.com>
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

Add STM32H7 and STM32MP1 in the list of compatible socs for each
optional property.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index 7d054f1..f334738 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -19,18 +19,19 @@ Optional properties:
   the default 100 kHz frequency will be used.
   For STM32F4 SoC Standard-mode and Fast-mode are supported, possible values are
   100000 and 400000.
-  For STM32F7 SoC, Standard-mode, Fast-mode and Fast-mode Plus are supported,
-  possible values are 100000, 400000 and 1000000.
-- i2c-scl-rising-time-ns: Only for STM32F7, I2C SCL Rising time for the board
-  (default: 25)
-- i2c-scl-falling-time-ns: Only for STM32F7, I2C SCL Falling time for the board
-  (default: 10)
+  For STM32F7, STM32H7 and STM32MP1 SoCs, Standard-mode, Fast-mode and Fast-mode
+  Plus are supported, possible values are 100000, 400000 and 1000000.
+- i2c-scl-rising-time-ns: I2C SCL Rising time for the board (default: 25)
+  For STM32F7, STM32H7 and STM32MP1 only.
+- i2c-scl-falling-time-ns: I2C SCL Falling time for the board (default: 10)
+  For STM32F7, STM32H7 and STM32MP1 only.
   I2C Timings are derived from these 2 values
-- st,syscfg-fmp: Only for STM32F7, use to set Fast Mode Plus bit within SYSCFG
-  whether Fast Mode Plus speed is selected by slave.
+- st,syscfg-fmp: Use to set Fast Mode Plus bit within SYSCFG when Fast Mode
+  Plus speed is selected by slave.
 	1st cell: phandle to syscfg
 	2nd cell: register offset within SYSCFG
 	3rd cell: register bitmask for FMP bit
+  For STM32F7, STM32H7 and STM32MP1 only.
 
 Example:
 
-- 
1.9.1
