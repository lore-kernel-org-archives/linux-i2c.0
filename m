From: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH V3 8/8] arm64: dts: sc7180: Add interconnect for QUP and QSPI
Date: Tue, 31 Mar 2020 16:39:36 +0530
Message-ID: <1585652976-17481-9-git-send-email-akashast@codeaurora.org>
References: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1585652976-17481-1-git-send-email-akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add interconnect ports for GENI QUPs and QSPI to set bus capabilities.

Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Changes in V2:
 - As per Bjorn's comment, ignoring 80 char limit in defining interconnects
   paths.

Changes in V3:
 - No change.

Note: This won't compile without patch-2CcfMPLixEJWlDyRan3ELWD2FQJk+8+b@public.gmane.org/patch/11430403
	[arm64: dts: sc7180: Include interconnect definitions]

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 127 +++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 998f101..65d5c85 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -427,6 +427,8 @@
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x43 0x0>;
+			interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c0: i2c@880000 {
@@ -439,6 +441,11 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -452,6 +459,9 @@
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -463,6 +473,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart0_default>;
 				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -476,6 +489,11 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -489,6 +507,9 @@
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -500,6 +521,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart1_default>;
 				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -513,6 +537,11 @@
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -524,6 +553,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart2_default>;
 				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -537,6 +569,11 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -550,6 +587,9 @@
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -561,6 +601,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart3_default>;
 				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -574,6 +617,11 @@
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -585,6 +633,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart4_default>;
 				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -598,6 +649,11 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>,
+						<&aggre1_noc MASTER_QUP_0 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -611,6 +667,9 @@
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -622,6 +681,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart5_default>;
 				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_0 &qup_virt SLAVE_QUP_CORE_0>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_0>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
@@ -636,6 +698,8 @@
 			#size-cells = <2>;
 			ranges;
 			iommus = <&apps_smmu 0x4c3 0x0>;
+			interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>;
+			interconnect-names = "qup-core";
 			status = "disabled";
 
 			i2c6: i2c@a80000 {
@@ -648,6 +712,11 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -661,6 +730,9 @@
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -672,6 +744,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart6_default>;
 				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -685,6 +760,11 @@
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -696,6 +776,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -709,6 +792,11 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -722,6 +810,9 @@
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -733,6 +824,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart8_default>;
 				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -746,6 +840,11 @@
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -757,6 +856,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart9_default>;
 				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -770,6 +872,11 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -783,6 +890,9 @@
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -794,6 +904,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart10_default>;
 				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -807,6 +920,11 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>,
+						<&aggre2_noc MASTER_QUP_1 &mc_virt SLAVE_EBI1>;
+				interconnect-names = "qup-core", "qup-config",
+							"qup-memory";
 				status = "disabled";
 			};
 
@@ -820,6 +938,9 @@
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 
@@ -831,6 +952,9 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&qup_uart11_default>;
 				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&qup_virt MASTER_QUP_CORE_1 &qup_virt SLAVE_QUP_CORE_1>,
+						<&gem_noc MASTER_APPSS_PROC &config_noc SLAVE_QUP_1>;
+				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};
 		};
@@ -1335,6 +1459,9 @@
 			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
 				 <&gcc GCC_QSPI_CORE_CLK>;
 			clock-names = "iface", "core";
+			interconnects = <&gem_noc MASTER_APPSS_PROC
+					&config_noc SLAVE_QSPI_0>;
+			interconnect-names = "qspi-config";
 			status = "disabled";
 		};
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
