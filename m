From: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Subject: [PATCH v2 1/5] dt-bindings: Document the STM32 I2C bindings
Date: Thu,  2 Jun 2016 16:26:04 +0200
Message-ID: <1464877568-21897-2-git-send-email-cedric.madianga@gmail.com>
References: <1464877568-21897-1-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1464877568-21897-1-git-send-email-cedric.madianga@gmail.com>
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

This patch adds documentation of device tree bindings for the STM32 I2C
controller.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
---
 .../devicetree/bindings/i2c/i2c-stm32.txt          | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-stm32.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-stm32.txt b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
new file mode 100644
index 0000000..78eaf7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-stm32.txt
@@ -0,0 +1,33 @@
+* I2C controller embedded in STMicroelectronics STM32 I2C platform
+
+Required properties :
+- compatible : Must be "st,stm32f4-i2c"
+- reg : Offset and length of the register set for the device
+- interrupts : Must contain the interrupt id for I2C event and then the
+  interrupt id for I2C error.
+- resets: Must contain the phandle to the reset controller.
+- clocks: Must contain the input clock of the I2C instance.
+- A pinctrl state named "default" must be defined to set pins in mode of
+  operation for I2C transfer
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties :
+- clock-frequency : Desired I2C bus clock frequency in Hz. If not specified,
+  the default 100 kHz frequency will be used. As only Normal and Fast modes
+  are supported, possible values are 100000 and 400000.
+
+Example :
+
+	i2c@40005400 {
+		compatible = "st,stm32f4-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x40005400 0x400>;
+		interrupts = <31>,
+			     <32>;
+		resets = <&rcc 277>;
+		clocks = <&rcc 0 149>;
+		pinctrl-0 = <&i2c1_sda_pin>, <&i2c1_scl_pin>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1
