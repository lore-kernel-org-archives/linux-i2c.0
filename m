From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V6 5/6] dts: msm8974: Add blsp2_bam dma node
Date: Tue, 12 Jan 2016 14:13:52 +0530
Message-ID: <1452588233-1803-6-git-send-email-sricharan@codeaurora.org>
References: <1452588233-1803-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452588233-1803-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, ntelkar@codeaurora.org, wsa@the-dreams.de
Cc: srichara@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 753bdfd..7786408 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
 #include "skeleton.dtsi"
 
@@ -345,6 +345,16 @@
 			interrupt-controller;
 			#interrupt-cells = <4>;
 		};
+
+		blsp2_dma: dma-controller@f9944000 {
+			compatible = "qcom,bam-v1.4.0";
+			reg = <0xf9944000 0x19000>;
+			interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP2_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+		};
 	};
 
 	smd {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
