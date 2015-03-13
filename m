From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH 6/6] dts: msm8974: Add dma channels for blsp2_i2c1 node
Date: Fri, 13 Mar 2015 23:19:52 +0530
Message-ID: <1426268992-19298-7-git-send-email-sricharan@codeaurora.org>
References: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426268992-19298-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, galak@codeaurora.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sricharan@codeaurora.org, agross@codeaurora.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 3f648ae..1ec7ec5 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -246,6 +246,8 @@
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			dmas = <&blsp2_dma 20>, <&blsp2_dma 21>;
+			dma-names = "bam-tx", "bam-rx";
 		};
 
 		blsp2_dma: dma@f9944000 {
-- 
1.8.2.1
