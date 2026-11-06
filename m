Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990201;
	b=Jnq/QM/RnNAeApCy5JY3qenBckia1i5DdOeTR7UD1wTs2mIfkyCYpWBO+MoFMjwOXS7j
	 vgf6fNslNHma4fX4IMNCUJBOHzFH0sKUfNXjAaKB3gsUCpUXMoCbOEXUzdqoE+cq/PQMF
	 DwcvlMzDC8w/RisL/ewq7UuYAJZEEMD6+i+z5aNjPVRLh5/vuxhJt81wsxWvOh2kQdp4B
	 mF7SI92rR+oTHX4Fm77errqveNTYvJ1xXlBhOnjRB1MqziUX3hzy4n6uylhfO5LKVQp63
	 M0gBjCnH4AppFeHZHBfMzLyZhCz1VHgHhsXFsKv2JWvTB5+PBAcQbO4cw16RdK9TN5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990201;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TsuNq2OheNSTqk8/gL9IbJScHhDNNcxGyEjKvs+yA0c=;
	b=JvMlgOAP3Jy0dz+t4vYFvsUso4dvFEoXSyww+sOfs6Bw5wmI7F1M8P+vuLhP4kUGYYXP
	 yN6B/pi9yUvSnpExLn+0rEZlwZ+8eWsjPIolNDEyGjls08hFsVrT2/aNyAthB5g7FjGou
	 +xYfSGI1et5HY+Iry9+uCkpRdIdyq3ehZ3DnXae5A5jWg/eF/aRqFBSkeOb+PL2mKLDaS
	 t/ofBh+NasvYBc8z1zClU5pw9CGuWUzhh1rD1OiNS0Zkb2UJ/j0Os/tDWzTO7KyOiEiQf
	 SHMKaD7jaYIGHlJ+cmLrwX4XyWqhErELtjwFNmmEsJYehBtF12aUJExUat12zwCZFBw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNomdTr8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFB606D828;
	Fri,  6 Nov 2026 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNomdTr8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990201;
	b=qiSctHSLjJKiV1XNuUHFx06u+16vA6Jpijpu4fPTB6qk+kCYr7EX53PYsRDmv6RQrFZD
	 4kjqMuIrs20W7UEVoDzJhmNfHP3gLSbG55isxz/7SBnGuESuVy8L9Al5nawLJeKVqn/3W
	 srgcjwh8fKRV0/rkHLXKaTmdLzsX82VVmJeW7E1w3ENy9JJv0nA9ZITlbSsrYp3vdqoXG
	 7i9CngtA+a8QBEpy9I1G7mb1xNf+VeoqcMR2mAesejFxp/a1aDC893UGJKY73AxZmsOfT
	 OO5fBd5bj8Q4TeXHuo8zLRMba3tQUKQGJAdJGBxEpt4rPoB+hTzotqRkjMgi0hV1T2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990201;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TsuNq2OheNSTqk8/gL9IbJScHhDNNcxGyEjKvs+yA0c=;
	b=jqxQhn4QzTXhe0yE3DK0PXDQuONAA+zkqUZan9GbN0bQA0Waqn+45FUTRrd5kyLxD7LL
	 n0t2EVNUv/CyGlxXsbE7PVpjZgx/Gz+oMvSulScMmbLiwuvotEBGPLbN8dKzCu/SZp3/P
	 QUhl4nhdrGzCNJz7WOjhttfrSMfRFi/pcHkk/rRrCw/qBzVkugE98D9/RIGvhEgcnrZrU
	 n7bhAkWGTgoFnAe3qezS8tho4j0MQOAh8H3iPnSXLWfqjavsoEXGkbXqpjsm0NT/vkTB2
	 TssAjV2UyLuuJv7SORnIv8VcEKAv8KQkNwCcPeiHWfYfz8EqdkwaMBj/tXMWh//P8eQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 06FEB1F008A7;
	Fri,  6 Nov 2026 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990201;
	bh=TsuNq2OheNSTqk8/gL9IbJScHhDNNcxGyEjKvs+yA0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RNomdTr8XlEH2fxrIVATX4DXNL60uzjO1/9fC/OEfxRnyM/EOHAKw1m+QFNB7JXd1
	 +8SK717r5ynAvuCXLNK9jQTyLra6Qph9X9T0P2BysJ9PR4r2PoqgVwQVzjFUuazuLG
	 LXnIWGtCLKKjHJBAP62jaRwPXlxYmVDlG8hNOWsobneZguFkd4xy6FmxDHkHW2HRw3
	 cTob+pvQxOr4BAVfozWOx7VKyGN8YZjRIIojgH402L4xgU9ASK15hS3Yx/Pkma5PMu
	 zo9m7D4c+ADVSo91rcTwF57ivWAYpWQDzo/hkGQelR4BJJMuANTLFiwrfijW7A7THy
	 y4jZtEOSX6npA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7EAC347829;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 18:35:39 +0000
Subject: [PATCH v3 7/7] arm64: dts: qcom: sm8150: Add CAMSS and CCI nodes
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-7-0103e8a0bbcd@andrewgigena.dev>
References: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v3-0-0103e8a0bbcd@andrewgigena.dev>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-phy@lists.infradead.org, 
 Andrew Gigena <mail@andrewgigena.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=13107;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=wZwrsoUDBqcXubxpglOHtI9ltv3LEaZKNJvQ/8Ba4ug=;
 b=1HWIC7qdT+/bR9cZ1qHK+5C/DjsRz2nAkmfkmSIVHn85TQCtSOEU9LSPgwPI7o6cmrQXmFNXX
 wt0OT5H0lkvCTVsAc6ibq1hOAph8Ua+Byr7/CAKiQOMf5tLRD572pJl
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Describe the SM8150 CAMSS block and its CSID, VFE and VFE-Lite
instances, together with the four dedicated CSI2 PHYs, the two CCI
controllers and their I2C buses.

The CAMSS node exposes four CSI input ports, each linked to one
CSI2 PHY output port, and references the CAMCC clocks and GDSCs, the
interconnects and the IOMMU streams. Each of the four CSIPHY I/O
spaces is described by its own qcom,sm8150-csi2-phy node, fed by the
CSIPHY clocks and the Titan top power domain; the vdda-phy and
vdda-pll supplies are board-specific. The CCI nodes describe the
CCI0/CCI1 I2C buses, and the TLMM pinctrl states for their clock and
data lines are added to the existing pin controller node.

All new nodes are left disabled. The PHY supplies and the sensor
wiring are board-specific, so they belong in the board DTS that
enables the controller.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 488 +++++++++++++++++++++++++++++++++++
 1 file changed, 488 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 293fcbacff34..008f787235b8 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -2736,6 +2736,86 @@ wake-pins {
 					bias-pull-up;
 				};
 			};
+
+			cci0_default: cci0-default-state {
+				cci0_i2c0_default: cci0-i2c0-default-pins {
+					/* SDA, SCL */
+					pins = "gpio17", "gpio18";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci0_i2c1_default: cci0-i2c1-default-pins {
+					/* SDA, SCL */
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
+					/* SDA, SCL */
+					pins = "gpio17", "gpio18";
+					function = "cci_i2c";
+
+					drive-strength = <2>; /* 2 mA */
+					bias-pull-down;
+				};
+
+				cci0_i2c1_sleep: cci0-i2c1-sleep-pins {
+					/* SDA, SCL */
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
+					/* SDA, SCL */
+					pins = "gpio31", "gpio32";
+					function = "cci_i2c";
+
+					bias-pull-up;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_default: cci1-i2c1-default-pins {
+					/* SDA, SCL */
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
+					/* SDA, SCL */
+					pins = "gpio31", "gpio32";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+
+				cci1_i2c1_sleep: cci1-i2c1-sleep-pins {
+					/* SDA, SCL */
+					pins = "gpio33", "gpio34";
+					function = "cci_i2c";
+
+					bias-pull-down;
+					drive-strength = <2>; /* 2 mA */
+				};
+			};
 		};
 
 		remoteproc_mpss: remoteproc@4080000 {
@@ -3782,6 +3862,414 @@ camnoc_virt: interconnect@ac00000 {
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
+		camss: isp@acaf000 {
+			compatible = "qcom,sm8150-camss";
+			status = "disabled";
+
+			reg = <0 0xacaf000 0 0x4000>,
+			      <0 0xacb3000 0 0x1000>,
+			      <0 0xacb6000 0 0x4000>,
+			      <0 0xacba000 0 0x1000>,
+			      <0 0xacc4000 0 0x4000>,
+			      <0 0xacc8000 0 0x1000>,
+			      <0 0xaccb000 0 0x4000>,
+			      <0 0xaccf000 0 0x1000>;
+
+			reg-names = "vfe0",
+				    "csid0",
+				    "vfe1",
+				    "csid1",
+				    "vfe_lite0",
+				    "csid_lite0",
+				    "vfe_lite1",
+				    "csid_lite1";
+
+			interrupts = <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>;
+
+			interrupt-names = "vfe0",
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
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_IFE_0_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_0_CLK>,
+				 <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_0_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_1_AXI_CLK>,
+				 <&camcc CAM_CC_IFE_1_CLK>,
+				 <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_1_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
+				 <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>,
+				 <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&gcc GCC_CAMERA_HF_AXI_CLK>,
+				 <&gcc GCC_CAMERA_SF_AXI_CLK>;
+			clock-names = "camnoc_axi",
+				      "cpas_ahb",
+				      "vfe0_axi",
+				      "vfe0",
+				      "vfe0_cphy_rx",
+				      "vfe0_csid",
+				      "vfe1_axi",
+				      "vfe1",
+				      "vfe1_cphy_rx",
+				      "vfe1_csid",
+				      "vfe_lite0",
+				      "vfe_lite0_cphy_rx",
+				      "vfe_lite0_csid",
+				      "vfe_lite1",
+				      "vfe_lite1_cphy_rx",
+				      "vfe_lite1_csid",
+				      "gcc_ahb",
+				      "gcc_axi_hf",
+				      "gcc_axi_sf";
+
+			iommus = <&apps_smmu 0x840 0x620>,
+				 <&apps_smmu 0x860 0x620>,
+				 <&apps_smmu 0xa40 0x620>,
+				 <&apps_smmu 0xa60 0x620>,
+				 <&apps_smmu 0xc40 0x620>,
+				 <&apps_smmu 0xc60 0x620>,
+				 <&apps_smmu 0xe40 0x620>,
+				 <&apps_smmu 0xe60 0x620>;
+
+			interconnects = <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_CAMERA_CFG 0>,
+					<&mmss_noc MASTER_CAMNOC_HF0 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI_CH0 0>,
+					<&mmss_noc MASTER_CAMNOC_HF1 0 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "cam_ahb",
+					     "cam_hf_0_mnoc",
+					     "cam_sf_0_mnoc",
+					     "cam_hf_1_mnoc";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					camss_csi0_in: endpoint {
+						remote-endpoint = <&csiphy0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					camss_csi1_in: endpoint {
+						remote-endpoint = <&csiphy1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					camss_csi2_in: endpoint {
+						remote-endpoint = <&csiphy2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+
+					camss_csi3_in: endpoint {
+						remote-endpoint = <&csiphy3_out>;
+					};
+				};
+			};
+		};
+
+		csiphy0: phy@ac65000 {
+			compatible = "qcom,sm8150-csi2-phy";
+			reg = <0 0xac65000 0 0x1000>;
+			status = "disabled";
+
+			clocks = <&camcc CAM_CC_CSIPHY0_CLK>,
+				 <&camcc CAM_CC_CSI0PHYTIMER_CLK>;
+			clock-names = "core",
+				      "timer";
+
+			interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>;
+
+			operating-points-v2 = <&csiphy0_opp_table>;
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "top";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy0_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy0_out: endpoint {
+						remote-endpoint = <&camss_csi0_in>;
+					};
+				};
+			};
+
+			csiphy0_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+			};
+		};
+
+		csiphy1: phy@ac66000 {
+			compatible = "qcom,sm8150-csi2-phy";
+			reg = <0 0xac66000 0 0x1000>;
+			status = "disabled";
+
+			clocks = <&camcc CAM_CC_CSIPHY1_CLK>,
+				 <&camcc CAM_CC_CSI1PHYTIMER_CLK>;
+			clock-names = "core",
+				      "timer";
+
+			interrupts = <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>;
+
+			operating-points-v2 = <&csiphy1_opp_table>;
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "top";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy1_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy1_out: endpoint {
+						remote-endpoint = <&camss_csi1_in>;
+					};
+				};
+			};
+
+			csiphy1_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+			};
+		};
+
+		csiphy2: phy@ac67000 {
+			compatible = "qcom,sm8150-csi2-phy";
+			reg = <0 0xac67000 0 0x1000>;
+			status = "disabled";
+
+			clocks = <&camcc CAM_CC_CSIPHY2_CLK>,
+				 <&camcc CAM_CC_CSI2PHYTIMER_CLK>;
+			clock-names = "core",
+				      "timer";
+
+			interrupts = <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>;
+
+			operating-points-v2 = <&csiphy2_opp_table>;
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "top";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy2_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy2_out: endpoint {
+						remote-endpoint = <&camss_csi2_in>;
+					};
+				};
+			};
+
+			csiphy2_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+			};
+		};
+
+		csiphy3: phy@ac68000 {
+			compatible = "qcom,sm8150-csi2-phy";
+			reg = <0 0xac68000 0 0x1000>;
+			status = "disabled";
+
+			clocks = <&camcc CAM_CC_CSIPHY3_CLK>,
+				 <&camcc CAM_CC_CSI3PHYTIMER_CLK>;
+			clock-names = "core",
+				      "timer";
+
+			interrupts = <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>;
+
+			operating-points-v2 = <&csiphy3_opp_table>;
+
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+			power-domain-names = "top";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					csiphy3_in: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					csiphy3_out: endpoint {
+						remote-endpoint = <&camss_csi3_in>;
+					};
+				};
+			};
+
+			csiphy3_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-400000000 {
+					opp-hz = /bits/ 64 <400000000>;
+				};
+			};
+		};
+
 		camcc: clock-controller@ad00000 {
 			compatible = "qcom,sm8150-camcc";
 			reg = <0 0x0ad00000 0 0x10000>;

-- 
2.56.0


