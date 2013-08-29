From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 1/2] i2c: qup: Add device tree bindings information
Date: Thu, 29 Aug 2013 16:27:52 +0300
Message-ID: <1377782873-31931-1-git-send-email-iivanov@mm-sol.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, grant.likely@linaro.org, gavidov@codeaurora.org, sdharia@codeaurora.org, alokc@codeaurora.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel, linux-arm-msm@vger.kernel.org, "Ivan T. Ivanov" <iivanov@mm-sol.com>
List-Id: linux-i2c@vger.kernel.org

From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

The Qualcomm Universal Peripherial (QUP) wraps I2C mini-core and
provide input and output FIFO's for it. I2C controller can operate
as master with supported bus speeds of 100Kbps and 400Kbps.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 Documentation/devicetree/bindings/i2c/i2c-qup.txt |   99 +++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qup.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-qup.txt b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
new file mode 100644
index 0000000..c682726
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-qup.txt
@@ -0,0 +1,99 @@
+Qualcomm Universal Periferial (QUP) I2C controller
+
+Required properties:
+ - compatible : should be "qcom,i2c-qup"
+ - reg : Offset and length of the register region for the device
+ - interrupts : core interrupt
+
+ - pinctrl-names: Should contain only one value - "default".
+ - pinctrl-0: Should specify pin control group used for this controller.
+
+ - clocks : phandles to clock instances of the device tree nodes
+ - clock-names :
+		"core" : Allow access to FIFO buffers and registers
+		"iface" : Clock used by QUP interface
+
+ - #address-cells : should be <1> Address cells for I2C device address
+ - #size-cells : should be <0> I2C addresses have no size component.
+
+Optional properties :
+ - Child nodes conforming to i2c bus binding
+ - clock-frequency : Desired I2C bus clock frequency in Hz. If
+		not set thedefault frequency is 100kHz
+ - qcom,src-freq : Frequency of the source clocking this bus in Hz.
+		Divider value is set based on soruce-frequency and
+		desired I2C bus frequency. If this value is not
+		provided, the source clock is assumed to be running
+		at 19.2 MHz.
+
+Aliases: An alias may optionally be used to bind the I2C controller
+to bus number. Aliases are of the form i2c<n> where <n> is an integer
+representing the bus number to use.
+
+Example:
+
+ aliases {
+		i2c0 = &i2c_A;
+		i2c1 = &i2c_B;
+		i2c2 = &i2c_C;
+ };
+
+ i2c_A: i2c@f9967000 {
+		compatible = "qcom,i2c-qup";
+		reg = <0Xf9967000 0x1000>;
+		interrupts = <0 105 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_data>;
+
+		clocks = <&core>, <&iface>;
+		clock-names = "core", "iface";
+
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dummy@60 {
+			compatible = "dummy";
+			reg = <0x60>;
+		};
+	};
+
+ i2c_B: i2c@f9923000 {
+		compatible = "qcom,i2c-qup";
+		reg = <0xf9923000 0x1000>;
+		interrupts = <0 95 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_data>;
+
+		clocks = <&core>, <&iface>;
+		clock-names = "core", "iface";
+
+		clock-frequency = <100000>;
+		qcom,src-freq = <19200000>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+ i2c_C: i2c@f9924000 {
+		compatible = "qcom,i2c-qup";
+		reg = <0xf9924000 0x1000>;
+		interrupts = <0 96 0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5_data>;
+
+		clocks = <&core>, <&iface>;
+		clock-names = "core", "iface";
+
+		clock-frequency = <100000>;
+		qcom,src-freq = <50000000>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.7.9.5
