Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793825663;
	b=Bh1eQNLrPnpuIbkMxwOnCwOR44iRPmmdKMAq7LpF0yPBZ/A5bB7y1aYkpDPdfhFAezLK
	 YpQsrBj00w70LPSQ8aCbwtd7AjzDCNhkvteSL8yu3twTcFbFV0ahdcALuXW9+XwPuGvVP
	 Gn3XyTm1c4bvSNKZqDX6mH/qaSKe8yO9fHUFJSoQXLA4OA6FIvXLfrU4d2nJ0MF10to+k
	 HoDWKn0Q9KjbfN1mgWLQoJVlGgswT/ORpH1tCcRivkVfK0ADg+21y1WQGRTAORX+l0a72
	 /cGYX9InbllMXmV1PKWOMErSa3jnN0ssVNB/Rc2PcHohUD0dIiehMfaGKPc/5HvuuSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825663;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyVVsOeiABdcLjb/qRX/bgF5coPf3IpyAT+IpxiYAfY=;
	b=kst3x1eduNHDZw/lv8Udb7qluak+Cx1op8IROAwnkwVo66YmZMXva3rJaUkNMPYvY3CW
	 08XwcIuszaZmTu1+jSRCBGPNCzeXvKsVgCoUFcZUg2m4yZOyIDeeQdVSXjyIwy33/TIPt
	 8OWWqbxDx6Q2fPmU43rZpJas3mdhIskU+FKR8YFx8cvj809xS11jYkR4cQpSYHvYkMlAC
	 97FMTyzJ2uvBKBIrNi6HLH0fhHv0X8hsXW6m1AAq6P9x/0SH+usDzcgkFfG0r4xxto/qC
	 A8od9hkd27hkoT30UBlUKtMJ1ijjMttncLMkh1XvIs+hThvqI7cJZcuKjtG7jyKMiuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/fLPW0+";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FD6097651;
	Wed,  4 Nov 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/fLPW0+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793825662;
	b=lqM7MDqC2yFNhPxOo2ZRiyk5tKwOnP9toXh0e51BliUA4LRrjiDPI5CiFlVZpB1NKdpy
	 TIbOfhHmTOZrOdeShNhs97R29aRM3djP3OSrqRdCzVe3RflAZCStZiURpfgCsZDXDOjlm
	 aATiDVnrWBfw6ZBHvQro6XxUZSlBtGx823YE/Z2lrzlpDciOoL2KHjBlrgYpExAWiPoHW
	 +jcHfQqM0MNplGVuqTvYaCsr19o6yZMdMMqOqTBn9rn/Ag/myL2hAyosWiJbVx8vPKAB9
	 qMsK3xlxN7VoE2Pq5GlCB/e+J4VG/GxUTDzISetkLskadb6h/Oa5iAKcPdrs66UFrrg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793825662;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hyVVsOeiABdcLjb/qRX/bgF5coPf3IpyAT+IpxiYAfY=;
	b=vDY65scAvb9ORAtgmHaDVH5pn8NCFNR16osA2YjmOxaORtgJNYTQVuBOwIk2yfJbUqLP
	 GKy3ynQVA/ogrHHcSLyH9B1t8YT6uf68qFfKW6Tnp+PEDZos1RZbABv2ZqWBia/QR3KPy
	 osam+Cx9EIxwxtvhDrFF/aRbAMnV5nPP3Y7myjPZ5uP1tUjzYBtCnL8Igggf39KfuNRTv
	 NlgnXk5j7moFcGE9UDWdGbOVMaQ5Kw5epwXh2SlAMpOy3tZkVLDWGCAtFByo5xd/XLVD9
	 bIha2CpzFgKY4CvqmTuWpNdcUeVXObwjEwzpv8ufZZQ8sHdhEMr4BDa8fjLhb7OuO1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB6FB1F00A1A;
	Wed,  4 Nov 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793825662;
	bh=hyVVsOeiABdcLjb/qRX/bgF5coPf3IpyAT+IpxiYAfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U/fLPW0+t88bfrRjGcyv6O57AF9zPClKfCYKhom37NLGfAStfvHruexCQ+KnX3pyt
	 eMY/kDAZqzCA9eg4yNqlmB/RGJbT2f97j9jKXRimWX9Axujl0rHnXzp84Ciuk8t+Lj
	 VtuHYYi3/zj5jUOUOAiawEQOgWbMRNsDy+YvFT/zJrLKdAkeivBtm34ZTl1kdaaO0z
	 slwMqDG0huwh/XAomQp/kMScC6r7uNzDUV96dQgZLgZ91Qs8dGdhfj5XVXEplScEC/
	 oFy1Z+W1TdMamwTN3XSG+zJIZxA9neoh8ZLa5ybKDST3n2gqnIkKEtCIE6w1khLMV1
	 2HA5luOEyc1Mw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57DF146F9D;
	Wed,  4 Nov 2026 20:54:20 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Wed, 04 Nov 2026 20:54:17 +0000
Subject: [PATCH 4/4] arm64: dts: qcom: sm8150: Add CAMSS and CCI nodes
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-sm8150-v7-4-rc1-camss-v1-4-7a9534a9a22f@andrewgigena.dev>
References: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
In-Reply-To: <20261104-sm8150-v7-4-rc1-camss-v1-0-7a9534a9a22f@andrewgigena.dev>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Andrew Gigena <mail@andrewgigena.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793825658; l=10903;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=VQJuXKfUaZ1ncIrHEvEBHMSxL5rDNiiN3jEsia5UrGc=;
 b=aAh2aAOd3E/LYojqL4egj4qz6U9XRk514hDWLtC8HYA3Ynw+f8TgAYVjxnnM+h5UJdrwAABR9
 EnjKAZLywcjDiGSouDfxfEZSjlRkRzNnkGyQ4BhpiVvO/WJgQNixrpD
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Describe the SM8150 CAMSS block and its CSIPHY, CSID, VFE and
VFE-Lite instances, together with the two CCI controllers and their
I2C buses.

The CAMSS node exposes four CSI input ports and references the CAMCC
clocks and GDSCs, the interconnects and the IOMMU streams. The CCI
nodes describe the CCI0/CCI1 I2C buses, and the TLMM pinctrl states
for their clock and data lines are added to the existing pin
controller node.

All new nodes are left disabled. The CAMSS supplies and the sensor
wiring are board-specific, so they belong in the board DTS that
enables the controller.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 350 +++++++++++++++++++++++++++++++++++
 1 file changed, 350 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 293fcbacff34..72bfcaea8cf8 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2736,6 +2736,86 @@ wake-pins {
 					bias-pull-up;
 				};
 			};
+
+			cci0_default: cci0-default-state {
+				cci0_i2c0_default: cci0-i2c0-default-pins {
+					/* CLK, DATA */
+					pins = "gpio17", "gpio18";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci0_i2c1_default: cci0-i2c1-default-pins {
+					/* CLK, DATA */
+					pins = "gpio19", "gpio20";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci0_sleep: cci0-sleep-state {
+				cci0_i2c0_sleep: cci0-i2c0-sleep-pins {
+					/* CLK, DATA */
+					pins = "gpio17", "gpio18";
+					function = "cci_i2c";
+
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+
+				cci0_i2c1_sleep: cci0-i2c1-sleep-pins {
+					/* CLK, DATA */
+					pins = "gpio19", "gpio20";
+					function = "cci_i2c";
+
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+			};
+
+			cci1_default: cci1-default-state {
+				cci1_i2c0_default: cci1-i2c0-default-pins {
+					/* CLK, DATA */
+					pins = "gpio31", "gpio32";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_default: cci1-i2c1-default-pins {
+					/* CLK, DATA */
+					pins = "gpio33", "gpio34";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
+
+			cci1_sleep: cci1-sleep-state {
+				cci1_i2c0_sleep: cci1-i2c0-sleep-pins {
+					/* CLK, DATA */
+					pins = "gpio31", "gpio32";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_sleep: cci1-i2c1-sleep-pins {
+					/* CLK, DATA */
+					pins = "gpio33", "gpio34";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
@@ -3782,6 +3862,276 @@ camnoc_virt: interconnect@ac00000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		cci0: cci@ac4a000 {
+			compatible = "qcom,sm8150-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0xac4a000 0 0x1000>;
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
+			pinctrl-0 = <&cci0_default>;
+			pinctrl-1 = <&cci0_sleep>;
+			pinctrl-names = "default", "sleep";
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
+		cci1: cci@ac4b000 {
+			compatible = "qcom,sm8150-cci", "qcom,msm8996-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			reg = <0 0xac4b000 0 0x1000>;
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
+			pinctrl-0 = <&cci1_default>;
+			pinctrl-1 = <&cci1_sleep>;
+			pinctrl-names = "default", "sleep";
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
+		camss: camss@ac65000 {
+			compatible = "qcom,sm8150-camss";
+			status = "disabled";
+
+			reg = <0 0xac65000 0 0x1000>,
+			      <0 0xac66000 0 0x1000>,
+			      <0 0xac67000 0 0x1000>,
+			      <0 0xac68000 0 0x1000>,
+			      <0 0xacaf000 0 0x4000>,
+			      <0 0xacb3000 0 0x1000>,
+			      <0 0xacb6000 0 0x4000>,
+			      <0 0xacba000 0 0x1000>,
+			      <0 0xacc4000 0 0x4000>,
+			      <0 0xacc8000 0 0x1000>,
+			      <0 0xaccb000 0 0x4000>,
+			      <0 0xaccf000 0 0x1000>;
+
+			reg-names = "csiphy0",
+				    "csiphy1",
+				    "csiphy2",
+				    "csiphy3",
+				    "vfe0",
+				    "csid0",
+				    "vfe1",
+				    "csid1",
+				    "vfe_lite0",
+				    "csid_lite0",
+				    "vfe_lite1",
+				    "csid_lite1";
+
+			interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-names = "csiphy0",
+					  "csiphy1",
+					  "csiphy2",
+					  "csiphy3",
+					  "vfe0",
+					  "csid0",
+					  "vfe1",
+					  "csid1",
+					  "vfe_lite0",
+					  "csid_lite0",
+					  "vfe_lite1",
+					  "csid_lite1";
+
+			power-domains = <&camcc IFE_0_GDSC>,
+					<&camcc IFE_1_GDSC>,
+					<&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "ife0",
+					     "ife1",
+					     "top";
+
+			clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+				 <&camcc CAM_CC_CAMNOC_AXI_CLK_SRC>,
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_CPHY_RX_CLK_SRC>,
+				 <&camcc CAM_CC_CSIPHY0_CLK>,
+				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSI0PHYTIMER_CLK_SRC>,
+				 <&camcc CAM_CC_CSIPHY1_CLK>,
+				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSI1PHYTIMER_CLK_SRC>,
+				 <&camcc CAM_CC_CSIPHY2_CLK>,
+				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSI2PHYTIMER_CLK_SRC>,
+				 <&camcc CAM_CC_CSIPHY3_CLK>,
+				 <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
+				 <&camcc CAM_CC_CSI3PHYTIMER_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_0_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_0_CLK>,
+				 <&camcc CAM_CC_IFE_0_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_0_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_0_CSID_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_1_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_1_CLK>,
+				 <&camcc CAM_CC_IFE_1_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_1_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_1_CSID_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_LITE_0_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CSID_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_LITE_1_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CLK_SRC>,
+				 <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CSID_CLK_SRC>,
+				 <&camcc CAM_CC_SLOW_AHB_CLK_SRC>,
+				 <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&gcc GCC_CAMERA_SF_AXI_CLK>;
+			clock-names = "camnoc_axi",
+				      "camnoc_axi_src",
+				      "cpas_ahb",
+				      "cphy_rx_src",
+				      "csiphy0",
+				      "csiphy0_timer",
+				      "csiphy0_timer_src",
+				      "csiphy1",
+				      "csiphy1_timer",
+				      "csiphy1_timer_src",
+				      "csiphy2",
+				      "csiphy2_timer",
+				      "csiphy2_timer_src",
+				      "csiphy3",
+				      "csiphy3_timer",
+				      "csiphy3_timer_src",
+				      "vfe0_axi",
+				      "vfe0",
+				      "vfe0_src",
+				      "vfe0_cphy_rx",
+				      "vfe0_csid",
+				      "vfe0_csid_src",
+				      "vfe1_axi",
+				      "vfe1",
+				      "vfe1_src",
+				      "vfe1_cphy_rx",
+				      "vfe1_csid",
+				      "vfe1_csid_src",
+				      "vfe_lite0",
+				      "vfe_lite0_src",
+				      "vfe_lite0_cphy_rx",
+				      "vfe_lite0_csid",
+				      "vfe_lite0_csid_src",
+				      "vfe_lite1",
+				      "vfe_lite1_src",
+				      "vfe_lite1_cphy_rx",
+				      "vfe_lite1_csid",
+				      "vfe_lite1_csid_src",
+				      "slow_ahb_src",
+				      "gcc_ahb",
+				      "gcc_axi_hf",
+				      "gcc_axi_sf";
+
+			iommus = <&apps_smmu 0x840 0x620>,
+				 <&apps_smmu 0x860 0x620>,
+				 <&apps_smmu 0xA40 0x620>,
+				 <&apps_smmu 0xA60 0x620>,
+				 <&apps_smmu 0xC40 0x620>,
+				 <&apps_smmu 0xC60 0x620>,
+				 <&apps_smmu 0xE40 0x620>,
+				 <&apps_smmu 0xE60 0x620>;
+
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_CAMERA_CFG 0>,
+					<&mmss_noc MASTER_CAMNOC_HF0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_HF1 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "cam_ahb",
+					     "cam_hf_0_mnoc",
+					     "cam_hf_1_mnoc",
+					     "cam_sf_0_mnoc";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+
+				port@2 {
+					reg = <2>;
+				};
+
+				port@3 {
+					reg = <3>;
+				};
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sm8150-camcc";
 			reg = <0 0x0ad00000 0 0x10000>;

-- 
2.56.0


