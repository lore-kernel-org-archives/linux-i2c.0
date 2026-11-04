Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833544;
	b=ezpzkj1R3tntFMN0zYC4iIpvlu/F4PJxtrByH4WLEf7nKLB56pc0Jdwxb2nnMlmkKdYV
	 L44ur+TKrdOeJP6FAwsPdU11SoCd6Wh5v2tCvxNC4fdyXEjoewoJk6hhOTGBUDmVUPrSr
	 1Q3L3/kDzvvMV6IogQV73DcfkMXrgMmUN0sfWSEYZ06tEqly1Vp6NYKAMPzAJeUvu1VUF
	 efe2wJP0ud9HedbEHj4zuQz1PfMMvzIHUJL47L2tq4kPTSgcwMIOJZaF4eBfsoKq3ULaP
	 tJ2r6/XkgoGRcKC+HaoqAd/1bVw/UTYPwNZKieWI7SKzHIEoQujvnq0vFXHpYqsyeHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833544;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zfhAWz3muEMLtRMGl8d9Zss8OhlIqSj/qk7CoadX36w=;
	b=l+le5wYFmYdLB94Xora3KfTaIAqwk3BTjX0lQtuw/RFemO8B6lqk6qR/g2GP+RjA4F8E
	 MSIpzMQY0w/MgCqO14Tu/CriLY5bVjc8W6tDEXBmKUnB5gzbl8ZJzi3gKzyIRI7hGl/OY
	 yZaTS5427bNYpuEm7hB6+A4/yuzAS+lH/TmsUGKPHcvM2rngdMnQxt26I5SDdVDeP4+cl
	 wgwiLwSJSanlqgXNes5/M8Bnkt2n1Dl/AdnoC1hqpVNcrstFafpXK9BshgfbUtZIxPWtc
	 pib9L09cFo0TwxqgtvfqbQkO1LxBjTPdvZmHwxUA2y8d0+L3WGLlhZr5yMZ7pYvJ1sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnTfjxEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A95606D810;
	Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnTfjxEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94A51F0093A;
	Wed,  4 Nov 2026 23:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833543;
	bh=zfhAWz3muEMLtRMGl8d9Zss8OhlIqSj/qk7CoadX36w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnTfjxEn/eYVo+kz152yVpVGuBuvorBRRKdTxHSW1ZhG6hOg+PzKRgwP2H23Nen1m
	 rqbw55NtQwZUE9zp9TQZD9iiU+efK3yLpyxICrX1fiDLCoouQ5A8mrcbHyoSePW9IO
	 60w6VLKgdLMEO1bKOhbgn8tXVu4hdedbPfsd7HSiGCjnMd5HSeER5xAtRUFp0KaDaP
	 wjiLZ4wDqryawBE1vqQdnTjdE2YIJr3Mux9rF6+/kScCUQy0q1Ws/GwP8I8YxszBDi
	 odZNsZZm3D90wRA1PbLwolSYyXnL5QVBdQD/r8JYqOLV0s3Yv7aYTEhbqkEA0ezQs0
	 spwFSkWg8zt4A==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Robert Foss <rfoss@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: qcom: sm8350: Add CCI device tree nodes
Date: Thu,  5 Nov 2026 01:05:28 +0200
Message-ID: <20261104230529.3040285-3-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261104230529.3040285-1-vz@kernel.org>
References: <20261104230529.3040285-1-vz@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Camera Control Interface (CCI) controller device tree nodes and pin
configurations of the I2C busses to SM8350 SoC dtsi.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 147 +++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a51942c99f8a..41dff3736061 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8350.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8350.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sm8350-camcc.h>
 #include <dt-bindings/clock/qcom,sm8350-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/firmware/qcom,scm.h>
@@ -2830,6 +2831,88 @@ videocc: clock-controller@abf0000 {
 			#power-domain-cells = <1>;
 		};
 
+		cci0: cci@ac4f000 {
+			compatible = "qcom,sm8350-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac4f000 0 0x1000>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				 <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_0_CLK>,
+				 <&camcc CAM_CC_CCI_0_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci0_0_default &cci0_1_default>;
+			pinctrl-1 = <&cci0_0_sleep &cci0_1_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci0_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci0_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci1: cci@ac50000 {
+			compatible = "qcom,sm8350-cci", "qcom,msm8996-cci";
+			reg = <0 0x0ac50000 0 0x1000>;
+			interrupts = <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				 <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_1_CLK>,
+				 <&camcc CAM_CC_CCI_1_CLK_SRC>;
+			clock-names = "camnoc_axi",
+				      "slow_ahb_src",
+				      "cpas_ahb",
+				      "cci",
+				      "cci_src";
+
+			pinctrl-0 = <&cci1_0_default &cci1_1_default>;
+			pinctrl-1 = <&cci1_0_sleep &cci1_1_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci1_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci1_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sm8350-camcc";
 			reg = <0 0x0ad00000 0 0x10000>;
@@ -3348,6 +3431,70 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 204>;
 			wakeup-parent = <&pdc>;
 
+			cci0_0_default: cci0-0-default-state {
+				/* SDA, SCL */
+				pins = "gpio107", "gpio108";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci0_0_sleep: cci0-0-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio107", "gpio108";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cci0_1_default: cci0-1-default-state {
+				/* SDA, SCL */
+				pins = "gpio109", "gpio110";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci0_1_sleep: cci0-1-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio109", "gpio110";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cci1_0_default: cci1-0-default-state {
+				/* SDA, SCL */
+				pins = "gpio111", "gpio112";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci1_0_sleep: cci1-0-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio111", "gpio112";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cci1_1_default: cci1-1-default-state {
+				/* SDA, SCL */
+				pins = "gpio113", "gpio114";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci1_1_sleep: cci1-1-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio113", "gpio114";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			sdc2_default_state: sdc2-default-state {
 				clk-pins {
 					pins = "sdc2_clk";
-- 
2.51.0

