From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH V3 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
Date: Sat, 11 Apr 2015 12:39:05 +0530
Message-ID: <1428736145-18361-7-git-send-email-sricharan@codeaurora.org>
References: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428736145-18361-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, iivanov@mm-sol.com, agross@codeaurora.org, galak@codeaurora.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: sricharan@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 2c26151..d741856 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -246,6 +246,8 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "tx", "rx";
 		};
 
 		blsp2_dma: dma@f9944000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
