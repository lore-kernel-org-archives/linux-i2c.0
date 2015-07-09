From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V4 7/7] dts: msm8974: Add dma channels for blsp2_i2c1 node
Date: Thu,  9 Jul 2015 08:55:50 +0530
Message-ID: <1436412350-19519-8-git-send-email-sricharan@codeaurora.org>
References: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1436412350-19519-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iivanov@mm-sol.com, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sricharan@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index f138202..17dcda3 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -284,6 +284,8 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
 		};
 
 		spmi_bus: spmi@fc4cf000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
