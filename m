From: Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 4/4] arm64: dts: qcom: Add Camera Control Interface support
Date: Fri, 13 Oct 2017 13:56:43 +0300
Message-ID: <1507892203-17033-5-git-send-email-todor.tomov@linaro.org>
References: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>, Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This commit adds the CCI node for the CCI controller that resides on
the Qualcomm MSM8916 and MSM8996 platforms.

CC: Andy Gross <andy.gross@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
CC: linux-soc@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi      | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi | 14 ++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi      | 22 ++++++++++++++++++++++
 4 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
index 4cb0b58..4fa6a72 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pins.dtsi
@@ -733,4 +733,18 @@
 			bias-pull-up;
 		};
 	};
+
+	cci_lines {
+		cci0_default: cci0_default {
+			pinmux {
+				function = "cci_i2c";
+				pins = "gpio29", "gpio30";
+			};
+			pinconf {
+				pins = "gpio29", "gpio30";
+				drive-strength = <16>;
+				bias-disable;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index dc38175..9f64130 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1325,6 +1325,25 @@
 				compatible = "venus-encoder";
 			};
 		};
+
+		cci: cci@1b0c000 {
+			compatible = "qcom,cci-v1.0.8";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1b0c000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
+				<&gcc GCC_CAMSS_CCI_AHB_CLK>,
+				<&gcc GCC_CAMSS_CCI_CLK>,
+				<&gcc GCC_CAMSS_AHB_CLK>;
+			clock-names = "camss_top_ahb",
+				"cci_ahb",
+				"cci",
+				"camss_ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&cci0_default>;
+			status = "disabled";
+		};
 	};
 
 	smd {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
index 6599404..3faaa4c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-pins.dtsi
@@ -300,4 +300,18 @@
 			drive-strength = <2>;	/* 2 MA */
 		};
 	};
+
+	cci_lines {
+		cci0_default: cci0_default {
+			pinmux {
+				function = "cci_i2c";
+				pins = "gpio17", "gpio18";
+			};
+			pinconf {
+				pins = "gpio17", "gpio18";
+				drive-strength = <16>;
+				bias-disable;
+			};
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 887b61c..ae128d3 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -819,6 +819,28 @@
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+		cci: cci@a0c000 {
+			compatible = "qcom,cci-v1.4.0";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xa0c000 0x1000>;
+			interrupts = <GIC_SPI 295 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&mmcc CAMSS_GDSC>;
+			clocks = <&mmcc MMSS_MMAGIC_AHB_CLK>,
+					<&mmcc CAMSS_TOP_AHB_CLK>,
+					<&mmcc CAMSS_CCI_AHB_CLK>,
+					<&mmcc CAMSS_CCI_CLK>,
+					<&mmcc CAMSS_AHB_CLK>;
+			clock-names = "mmss_mmagic_ahb",
+					"camss_top_ahb",
+					"cci_ahb",
+					"cci",
+					"camss_ahb";
+			pinctrl-names = "default";
+			pinctrl-0 = <&cci0_default>;
+			status = "disabled";
+		};
 	};
 
 	adsp-pil {
-- 
2.7.4
