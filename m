From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: i2c: qup: missing stop bit and messages
Date: Tue, 31 Oct 2017 12:19:08 -0400
Message-ID: <20171031161908.acfwka6zk277glyv@workotop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Sricharan R <sricharan@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Hi,


While testing a gas gauge, we encountered intermittent i2c issues with
the APQ8016. Sometimes, the i2c controller seems to send incomplete
messages, or doesn't send some messages. To read values from the gas
gauge, this group of two messages is sent:
 - one write message of 1 byte, with the gas gauge register to be read
 - one read message of 2 bytes, for the reply from the device

Once in a while, there is an odd sequence:
 - First, the very last tick of the clock of the read message is
   shorter, and the stop bit is missing.
 - The following group of messages is incomplete, only the write
   message is sent.

So on the scope, we observe the following timeline:
 ...  [ok] [ok] [ok] [missing stop bit] [only write message]


Here are captures of what we see. These are three consecutive queries of
the gas gauge:
 - successful query: https://postimg.org/gallery/215zrvd9o/
 - missing stop bit: https://postimg.org/gallery/26xn101d8/
 - incomplete group: https://postimg.org/image/2cvghepi0b/
(a start is indicated by a green marker, a stop by a red one)


As we use i2c3, for which dts bindings are not yet upstreamed, below are
the additions in our device tree. It's slightly incomplete, but note
that blsp_i2c3 is enabled and blsp_spi3 disabled. Maybe there is an
issue with that particular i2c core?


Regards,
Damien


diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 899f2b28a9c9..a303a4c8cad4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -294,6 +294,30 @@
 		};
 	};
 
+	i2c3_default: i2c3_default {
+		pinmux {
+			function = "blsp_i2c3";
+			pins = "gpio10", "gpio11";
+		};
+		pinconf {
+			pins = "gpio10", "gpio11";
+			drive-strength = <16>;
+			bias-disable = <0>;
+		};
+	};
+
+	i2c3_sleep: i2c3_sleep {
+		pinmux {
+			function = "gpio";
+			pins = "gpio10", "gpio11";
+		};
+		pinconf {
+			pins = "gpio10", "gpio11";
+			drive-strength = <2>;
+			bias-disable = <0>;
+		};
+	};
+
 	i2c4_default: i2c4_default {
 		pinmux {
 			function = "blsp_i2c4";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f6091aafc984..a08e2b4894fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -618,6 +618,21 @@
 			status = "disabled";
 		};
 
+		blsp_i2c3: i2c@78b7000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b7000 0x1000>;
+			interrupts = <GIC_SPI 97 0>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				<&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&i2c3_default>;
+			pinctrl-1 = <&i2c3_sleep>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		blsp_i2c4: i2c@78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b8000 0x1000>;
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-centaur.dts
b/arch/arm64/boot/dts/qcom/apq8016-sbc-centaur.dts
index c96aebcb046c..10928bf31189 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-centaur.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-centaur.dts
@@ -29,6 +29,13 @@
 /* use i2c3 instead of spi3, for gas gauge */
 &blsp_i2c3 {
 	status = "okay";
+
+	bq27510@55 {
+		compatible = "ti,bq27510g2";
+		reg = <0x55>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&fuelgauge_default>;
+	};
 };
 
 &blsp_i2c4 {
@@ -155,6 +162,18 @@
 		};
 	};
 
+	fuelgauge_default: fuelgauge_default {
+		pinmux {
+			function = "gpio";
+			pins = "gpio9";
+		};
+		pinconf {
+			pins = "gpio9";
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	/* overwrite this node to use gpio 13 instead of 110 */
 	keypad_default: keypad_default {
 		pinmux {
