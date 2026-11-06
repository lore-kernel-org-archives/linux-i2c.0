Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990200;
	b=nDeZka0HNxpuSZWq7A5Mpdbj7XGMGSIESgD16hXJ3QIobsUz/btUyCMXU8y40psx6hBr
	 +6McXWCBYheePm+wdmrjFvp5lU2boHkszMldqADEszq3r3DMBGEnaQTWxatx6sIVSgAou
	 ZGDAktZJz1Xj7x+Feau/HvrWQgV4fYlF7wQL7d9dD8z2fICcGLH2u5iyY1QuSiQn8s2rf
	 P/5IfEaDEgm/nEiAed0UiOaazTFet1KPbV+Vd4zWCZZv2ezo3K9kI5oLpwS3xTykXaHxt
	 dl7nLk1AX3kwReEsMml92FoXaB1UjeIzFZNgGDXzyf8z361k7JWlOZpitzChrwdqZkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S4b+VA8Es0e7Gqn+7Rek6L4blVcmlZ6+aRj8kpIRYX4=;
	b=IzSrERiMDxJ40FMk8mrkGfjgLNqPsdhTfTxw84egBVEMjrVd/Hu4HE5vkIfNedifF4sN
	 UfwMrLAX64wYGevX9N8XRgMuGZ0gvH4kxSfMZh7GFdpBDbafpFyuB9Aoi/2NKBM3QWxqq
	 F3nDg9UbVDa5Hl4rvanIYVpMHEZVArALccpqFzEd/9YMj93heR7luyJtCsgN6G1CwqQP/
	 B2ES3e1U8RY1IFuUmajCZzeT2k4BcQ71zWH9RQJskbrW0fOIbtaR/WS8MIjdcC/pGd+OL
	 ztdsIi4d+i9bwaNGDpOt3QtD1wNC3TWHaXzlxv+NHKdjkZQEdFUBVe2T7325P5vwjvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lN+nI3r8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8E606A339;
	Fri,  6 Nov 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lN+nI3r8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990199;
	b=29IrFZwBuNMxhyowuLSK0NHR7Sqhd6a8MhAX/63nAFaphTHtp80hJ6EH6Pf3RCm6D4wG
	 z1OCntdYfN//UGIlFmpim8z691t+oZI/W3/DW/dFF0qpLGq2QLSqo1NtafT2WMx9RmCKc
	 VX6Kz6oBxYgF2geF5xJtLRipM2Gnz+XWdc0aGGXKr9JzOuZms0gLjXCw21RB1N9ZiMR7D
	 zdJYGloNOubg6LdnLCBLNUkb2yw2faOqAAiALuArSQQUJvz7tVdRo7hp5P6FPAVeXAysn
	 baRFFQ9d5mPOcLxN1GFhidOs7rrUbyeRa6IcuXLbw9uKkkaa6v6k2YMSkNqfmIihxTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=S4b+VA8Es0e7Gqn+7Rek6L4blVcmlZ6+aRj8kpIRYX4=;
	b=SqL/AK9UOoseKnCIOLzJ+F+1sJPgYPj/O7a9LKS0eNpwpjNXObIHawPsiL2YcaA9ItB+
	 XSs0lJXxEWvxB1mXuigoOB47g1+qyEOxPSZ9+lLnBO7yOZLskJjb08ny+umjf5+ibSTif
	 W3Sgp2UHkWRTY75MdB9kQTOnvN7oCyIEs/UUVP2AskfkQI7+mGNCIZseUVZbrpC7Bulbb
	 f7CNxZ87KrROGiP1TWq7U+78VAWsS9bAkD5lCJp8SzwvpwChJvOnuNtqvTBh981xB/Qgn
	 ey9LhuVa0wzONcyPVCXRVOc4SerJQer+n/X+HCQlsaCRbqw+yfJ9O4+ks+13RXsjLnw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD3F71F008A2;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990199;
	bh=S4b+VA8Es0e7Gqn+7Rek6L4blVcmlZ6+aRj8kpIRYX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lN+nI3r8xLjDfAByK4efo2IMD//rtvQuXMfL1UDYmgBeMIr7oNlHR9ZrcT8D0060l
	 VQw4bVhufhbA5Ju+66mCZUNkgPg8GNIhF0AOHFMeg6meIBddrsTPRhEogzY/96goUN
	 X0DbaRyTC92/Kb0Y9Jw8YVxIlvVsTvfeHDVHqkUxnUyWwyUa4/oUszMSgprRNMRFsq
	 vo0ByJvl9EVvtnOMpkjvOU7uzyGS6IvZGKyxG3458lH+TEI+SGL9pu8YTS0c7sUOfj
	 Z+TCn9LSU20JRoxGazBtZOw7dG4YddGr9b95wSIMyKNj7FGGKS2MSfbKJ6uCxLZdUT
	 9S6y28B7oQH3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2FD1747405;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 18:35:34 +0000
Subject: [PATCH v3 2/7] dt-bindings: media: qcom,sm8150-camss: Add SM8150
 CAMSS
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-2-0103e8a0bbcd@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=10174;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=lAPvSNOJB8lII0U+qtMrDtqFoZDfOKFHLlca6xqLLMk=;
 b=/d7qwhpKPMkhy+no9/2Frp28Q1YCfQVwySWuEdWXI9MgZjtznUPSIpjVs32Xw+l07UyvKoKmB
 LzY9dsiKJoPDoDZ0o1O/fLEnylGIreBtRYlb43V3PDED8LWOM6LGqwL
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Document the Qualcomm SM8150 Camera Subsystem. The IP integrates four
CSIPHY, four CSID (two full and two lite), two VFE and two VFE-Lite
instances, with 19 clocks, 8 interrupts, eight IOMMU streams, four
interconnect paths and three power domains.

The CSIPHY I/O spaces are not part of the CAMSS container device: each
CSIPHY is driven by the dedicated qcom,sm8150-csi2-phy driver, so this
binding only describes the VFE and CSID resources. Each CSI input port
is described with data lanes starting at 1, as required by the CAMSS
PHY mode.

Describe SM8150 in a dedicated schema instead of reusing another SoC's
schema.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 .../bindings/media/qcom,sm8150-camss.yaml          | 285 +++++++++++++++++++++
 1 file changed, 285 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
new file mode 100644
index 000000000000..371ff1ce0bd2
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
@@ -0,0 +1,285 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,sm8150-camss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 Camera Subsystem (CAMSS)
+
+maintainers:
+  - Andrew Gigena <mail@andrewgigena.dev>
+
+description:
+  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,sm8150-camss
+
+  reg:
+    maxItems: 8
+
+  reg-names:
+    items:
+      - const: vfe0
+      - const: csid0
+      - const: vfe1
+      - const: csid1
+      - const: vfe_lite0
+      - const: csid_lite0
+      - const: vfe_lite1
+      - const: csid_lite1
+
+  clocks:
+    maxItems: 19
+
+  clock-names:
+    items:
+      - const: camnoc_axi
+      - const: cpas_ahb
+      - const: vfe0_axi
+      - const: vfe0
+      - const: vfe0_cphy_rx
+      - const: vfe0_csid
+      - const: vfe1_axi
+      - const: vfe1
+      - const: vfe1_cphy_rx
+      - const: vfe1_csid
+      - const: vfe_lite0
+      - const: vfe_lite0_cphy_rx
+      - const: vfe_lite0_csid
+      - const: vfe_lite1
+      - const: vfe_lite1_cphy_rx
+      - const: vfe_lite1_csid
+      - const: gcc_ahb
+      - const: gcc_axi_hf
+      - const: gcc_axi_sf
+
+  interrupts:
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: vfe0
+      - const: csid0
+      - const: vfe1
+      - const: csid1
+      - const: vfe_lite0
+      - const: csid_lite0
+      - const: vfe_lite1
+      - const: csid_lite1
+
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: cam_ahb
+      - const: cam_hf_0_mnoc
+      - const: cam_sf_0_mnoc
+      - const: cam_hf_1_mnoc
+
+  iommus:
+    maxItems: 8
+
+  power-domains:
+    items:
+      - description: IFE0 GDSC - Image Front End, Global Distributed Switch Controller.
+      - description: IFE1 GDSC - Image Front End, Global Distributed Switch Controller.
+      - description: Titan Top GDSC - Titan ISP Block, Global Distributed Switch Controller.
+
+  power-domain-names:
+    items:
+      - const: ife0
+      - const: ife1
+      - const: top
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    description:
+      CSI input ports, one per CSI2 PHY instance.
+
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+
+        description:
+          Input port for receiving CSI data from a CSIPHY.
+
+        properties:
+          endpoint:
+            $ref: video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  minimum: 1
+                  maximum: 4
+
+              bus-type:
+                enum:
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - interrupt-names
+  - iommus
+  - power-domains
+  - power-domain-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,sm8150-camcc.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
+    #include <dt-bindings/media/video-interfaces.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        isp@acaf000 {
+            compatible = "qcom,sm8150-camss";
+
+            reg = <0 0xacaf000 0 0x4000>,
+                  <0 0xacb3000 0 0x1000>,
+                  <0 0xacb6000 0 0x4000>,
+                  <0 0xacba000 0 0x1000>,
+                  <0 0xacc4000 0 0x4000>,
+                  <0 0xacc8000 0 0x1000>,
+                  <0 0xaccb000 0 0x4000>,
+                  <0 0xaccf000 0 0x1000>;
+
+            reg-names = "vfe0",
+                        "csid0",
+                        "vfe1",
+                        "csid1",
+                        "vfe_lite0",
+                        "csid_lite0",
+                        "vfe_lite1",
+                        "csid_lite1";
+
+            clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+                     <&camcc CAM_CC_CPAS_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_0_AXI_CLK>,
+                     <&camcc CAM_CC_IFE_0_CLK>,
+                     <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_0_CSID_CLK>,
+                     <&camcc CAM_CC_IFE_1_AXI_CLK>,
+                     <&camcc CAM_CC_IFE_1_CLK>,
+                     <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_1_CSID_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_0_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_1_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>,
+                     <&gcc GCC_CAMERA_AHB_CLK>,
+                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
+                     <&gcc GCC_CAMERA_SF_AXI_CLK>;
+
+            clock-names = "camnoc_axi",
+                          "cpas_ahb",
+                          "vfe0_axi",
+                          "vfe0",
+                          "vfe0_cphy_rx",
+                          "vfe0_csid",
+                          "vfe1_axi",
+                          "vfe1",
+                          "vfe1_cphy_rx",
+                          "vfe1_csid",
+                          "vfe_lite0",
+                          "vfe_lite0_cphy_rx",
+                          "vfe_lite0_csid",
+                          "vfe_lite1",
+                          "vfe_lite1_cphy_rx",
+                          "vfe_lite1_csid",
+                          "gcc_ahb",
+                          "gcc_axi_hf",
+                          "gcc_axi_sf";
+
+            interrupts = <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>;
+
+            interrupt-names = "vfe0",
+                              "csid0",
+                              "vfe1",
+                              "csid1",
+                              "vfe_lite0",
+                              "csid_lite0",
+                              "vfe_lite1",
+                              "csid_lite1";
+
+            power-domains = <&camcc IFE_0_GDSC>,
+                            <&camcc IFE_1_GDSC>,
+                            <&camcc TITAN_TOP_GDSC>;
+
+            power-domain-names = "ife0",
+                                 "ife1",
+                                 "top";
+
+            interconnects = <&gem_noc MASTER_AMPSS_M0 0
+                             &config_noc SLAVE_CAMERA_CFG 0>,
+                            <&mmss_noc MASTER_CAMNOC_HF0 0
+                             &mc_virt SLAVE_EBI_CH0 0>,
+                            <&mmss_noc MASTER_CAMNOC_SF 0
+                             &mc_virt SLAVE_EBI_CH0 0>,
+                            <&mmss_noc MASTER_CAMNOC_HF1 0
+                             &mc_virt SLAVE_EBI_CH0 0>;
+
+            interconnect-names = "cam_ahb",
+                                 "cam_hf_0_mnoc",
+                                 "cam_sf_0_mnoc",
+                                 "cam_hf_1_mnoc";
+
+            iommus = <&apps_smmu 0x840 0x620>,
+                     <&apps_smmu 0x860 0x620>,
+                     <&apps_smmu 0xa40 0x620>,
+                     <&apps_smmu 0xa60 0x620>,
+                     <&apps_smmu 0xc40 0x620>,
+                     <&apps_smmu 0xc60 0x620>,
+                     <&apps_smmu 0xe40 0x620>,
+                     <&apps_smmu 0xe60 0x620>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    endpoint {
+                        bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                        data-lanes = <1 2 3 4>;
+                        remote-endpoint = <&csiphy0_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.56.0


