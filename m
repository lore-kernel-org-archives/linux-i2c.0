From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH] dt-bindings: i2c-stm32: document optional dmas
Date: Tue, 4 Jun 2019 15:34:13 +0200
Message-ID: <1559655253-27008-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org
Cc: mark.rutland@arm.com, pierre-yves.mordret@st.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fabrice.gasnier@st.com
List-Id: linux-i2c@vger.kernel.org

Add missing documentation for "dmas" and "dma-names" properties that can be
used on i2c-stm32.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/i2c/i2c-stm32.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
index f334738..ce3df2ff 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -21,6 +21,8 @@ Optional properties:
   100000 and 400000.
   For STM32F7, STM32H7 and STM32MP1 SoCs, Standard-mode, Fast-mode and Fast-mode
   Plus are supported, possible values are 100000, 400000 and 1000000.
+- dmas: List of phandles to rx and tx DMA channels. Refer to stm32-dma.txt.
+- dma-names: List of dma names. Valid names are: "rx" and "tx".
 - i2c-scl-rising-time-ns: I2C SCL Rising time for the board (default: 25)
   For STM32F7, STM32H7 and STM32MP1 only.
 - i2c-scl-falling-time-ns: I2C SCL Falling time for the board (default: 10)
-- 
2.7.4
