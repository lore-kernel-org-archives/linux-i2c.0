Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793935535;
	b=VZSAFrq+QD9A35edSJ/cw7qgqdmJGNZH8lb85IiFG4beApPkDvN9+pPB5CxcQtAFHW+E
	 gxrJ6HTCqAQFQD49c+tl0PczBdEu4rDjOFvByutLHFLKmkDBjCAeoga6kaTTYmujgEdZR
	 IjoqFpuudJpVZaS3UBPal/exB4eCb7bmypXtCbJiqbsgwWCu57N6LRPcrRBFlJ6GBBEn8
	 Bl++sSbxb8f6QBmmVDEHCvykouHSIOsWDpI99lZE4u0TkAkkhLXU3jcu2cxW9S5UrZzXg
	 B7XUzua+eXy3fWWQdrvmciIldsKWwMVXDoOZTY4aPdsrmsnPzHz5DMPEdCw8FqnoIdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935535;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8mU+HqoGf2aPTY9e2zKEmdU5X7SGnUqTUiNNziZStXc=;
	b=Q4kDqQd2h2GaEq0iMFUi33Si564PJ94F8XP4owtmiZWYJcwtyd7VR6CRbhY9FKvBAF0D
	 F1E2fwgzygRdKLeXrgk8rD0zmZRIVq8arN3PxRXGuBF2sYaEFkC7SjTZnlFG9KgUa9wNV
	 Rlp6n47Yb55X8NhfD+yvX6+yOa61ToAJ9l8oNdHGAqmuTIqoyO3pVTUEeq8QKXyEiUs4x
	 1P+g+mDqBBJN2wAXix+wIE91VKZRs73Knjzn+EDsuwlBnIETmAuge8Bey+LIXFShlL8ne
	 8Yw4hIePZbYUfM6nMrSD6VGbVZ8lZ0vOpwdXWq4rTMHjG9rhV04bS2sJIe/5zs2funQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmnA6+ay;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272E606A339;
	Fri,  6 Nov 2026 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hmnA6+ay
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793935534;
	b=DF+1Ddn6XBsH3VP5tNeelPxCG41z+VN4kh4sj8A21TWy3VXnfOqSjes2bgW+2TpuaQot
	 PGMABezy7cn4/HiRSGX1nemDaBIQORPrckvNxU1M+Q8M4JpfmSXpILxy0MBknZXPrHqEb
	 xpAZIsT1ynAH+EatnQ5qQmIrO5hk1TBONoZklrhH5f0CxtffgJAByFVh3mk8AJrSRpwHK
	 lLULYy4TZNOuRKjAMPu71qFNx+wCmbN/QHihfJVvofL+9NC8+6LlEFQFqr5n1JjSW5cRD
	 TkRf8TaadQeT3DbTQLZZinqOJAS7I9cMH1bjJoSiXb/EzvN3OmssQrufOBuML9kJftg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935534;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8mU+HqoGf2aPTY9e2zKEmdU5X7SGnUqTUiNNziZStXc=;
	b=paDzNl0jgIrPe1/+k0KPefAgXRLHim8Es3E2hSfeUFIGLio4wwGUngPAT3mRIq0bQZHm
	 hOZ03N7UqhGRUslgHb61nn/wDUwUrhxtmOiQnpHKir2TG6yQZBXsDjyCd7Ey0zuZpHny8
	 lIyIK99d5W4GkJy7QRi23BDjvb93JfDubX++tt0aQMWp7d9IV9oRMC6ZGCab3RF9alJ6U
	 IRJLObfIdySog/+Zk7y21M2lWGkXo4BC+wxnQW53DMQ5tBet5tuYl0045I6uD5cUbM7rw
	 pL81ZBFL8hiy+E4TUgA2dwNbih6qjMkYbpEmEdW95kbryTmMYmBb4uqDa7p4emmFo/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 28CA01F0089F;
	Fri,  6 Nov 2026 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793935534;
	bh=8mU+HqoGf2aPTY9e2zKEmdU5X7SGnUqTUiNNziZStXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hmnA6+ayljMUCjtp74tH3K1IMX67/d239O85qAY2L0DdWhx2h4B6y5D4kWK98u2EN
	 5RD3WJ6fAVSN8g5Ix3KHhmgb+cCpdjf3K1tZGqE89/+LxWseS3IxwR3SzVTY/3co6u
	 eQfkPMeIREdAaoGdC43AA5ATnZrFA3pVxtEL4inw6/8Jlc2XiYTt0qwtO128KAAQ2F
	 FWQHKyXLhkexeB1xjGujgOo1iniRPZkHql8/+xoDsti+pGC3R8g5QU6hhi5gfUi1g9
	 UuZu+qDhQTEjMYLTyOwanYewIfpiACAAGcA2FdWBvlorh2VxfDu730Apm3XoH2yaiP
	 ZHTkKE6kwp7ZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9F99345B8E;
	Fri,  6 Nov 2026 03:25:32 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 03:24:53 +0000
Subject: [PATCH v2 2/5] dt-bindings: media: qcom,sm8150-camss: Add SM8150
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v2-2-39ee37787b00@andrewgigena.dev>
References: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
In-Reply-To: <20261106-sm8150-v7.4-rc1-camss-v2-0-39ee37787b00@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793935531; l=12837;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=vSXIZ+NnZ5IgvwFNIcKcKlCI9Jlk+88w6gGFFPgWPgU=;
 b=B0pew+3QpY2aiENl/6Uhff5LRRaFT6SmnSWGUdNoUwx7hWInI8Kc9SErwqfuVfmnspgDB9dZs
 y7fO9lL8jqrCdUooVsvyRqC8d/OVoIwEDCg2Dk0Gz1QX8xFOddZgWlE
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
instances, with 27 clocks, 12 interrupts, eight IOMMU streams, four
interconnect paths and three power domains.

SM8150 has a different register layout, clock tree and power domain
topology from SM8250, so describe it in a dedicated schema instead of
using qcom,sm8250-camss as a fallback.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 .../bindings/media/qcom,sm8150-camss.yaml          | 412 +++++++++++++++++++++
 1 file changed, 412 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
new file mode 100644
index 000000000000..26f8939001df
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,sm8150-camss.yaml
@@ -0,0 +1,412 @@
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
+description: |
+  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,sm8150-camss
+
+  clocks:
+    minItems: 27
+    maxItems: 27
+
+  clock-names:
+    items:
+      - const: camnoc_axi
+      - const: cpas_ahb
+      - const: csiphy0
+      - const: csiphy0_timer
+      - const: csiphy1
+      - const: csiphy1_timer
+      - const: csiphy2
+      - const: csiphy2_timer
+      - const: csiphy3
+      - const: csiphy3_timer
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
+    minItems: 12
+    maxItems: 12
+
+  interrupt-names:
+    items:
+      - const: csiphy0
+      - const: csiphy1
+      - const: csiphy2
+      - const: csiphy3
+      - const: vfe0
+      - const: csid0
+      - const: vfe1
+      - const: csid1
+      - const: vfe_lite0
+      - const: csid_lite0
+      - const: vfe_lite1
+      - const: csid_lite1
+
+  iommus:
+    maxItems: 8
+
+  interconnects:
+    maxItems: 4
+
+  interconnect-names:
+    items:
+      - const: cam_ahb
+      - const: cam_hf_0_mnoc
+      - const: cam_hf_1_mnoc
+      - const: cam_sf_0_mnoc
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
+      CSI input ports.
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port for receiving CSI data from CSIPHY0.
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
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port for receiving CSI data from CSIPHY1.
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
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port for receiving CSI data from CSIPHY2.
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
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+      port@3:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port for receiving CSI data from CSIPHY3.
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
+
+              bus-type:
+                enum:
+                  - 1 # MEDIA_BUS_TYPE_CSI2_CPHY
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+
+            required:
+              - data-lanes
+
+  reg:
+    minItems: 12
+    maxItems: 12
+
+  reg-names:
+    items:
+      - const: csiphy0
+      - const: csiphy1
+      - const: csiphy2
+      - const: csiphy3
+      - const: vfe0
+      - const: csid0
+      - const: vfe1
+      - const: csid1
+      - const: vfe_lite0
+      - const: csid_lite0
+      - const: vfe_lite1
+      - const: csid_lite1
+
+  vdda-phy-supply:
+    description:
+      0.88V supply to CSIPHY IP blocks.
+
+  vdda-pll-supply:
+    description:
+      1.2V supply to CSIPHY IP blocks.
+
+required:
+  - clock-names
+  - clocks
+  - compatible
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - interrupt-names
+  - iommus
+  - power-domains
+  - power-domain-names
+  - reg
+  - reg-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,sm8150-camcc.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        camss: camss@ac65000 {
+            compatible = "qcom,sm8150-camss";
+
+            reg = <0 0xac65000 0 0x1000>,
+              <0 0xac66000 0 0x1000>,
+              <0 0xac67000 0 0x1000>,
+              <0 0xac68000 0 0x1000>,
+              <0 0xacaf000 0 0x4000>,
+              <0 0xacb3000 0 0x1000>,
+              <0 0xacb6000 0 0x4000>,
+              <0 0xacba000 0 0x1000>,
+              <0 0xacc4000 0 0x4000>,
+              <0 0xacc8000 0 0x1000>,
+              <0 0xaccb000 0 0x4000>,
+              <0 0xaccf000 0 0x1000>;
+
+            reg-names = "csiphy0",
+              "csiphy1",
+              "csiphy2",
+              "csiphy3",
+              "vfe0",
+              "csid0",
+              "vfe1",
+              "csid1",
+              "vfe_lite0",
+              "csid_lite0",
+              "vfe_lite1",
+              "csid_lite1";
+
+            interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 478 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 479 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 465 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 464 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 467 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 469 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 468 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 360 IRQ_TYPE_EDGE_RISING>,
+              <GIC_SPI 359 IRQ_TYPE_EDGE_RISING>;
+
+            interrupt-names = "csiphy0",
+              "csiphy1",
+              "csiphy2",
+              "csiphy3",
+              "vfe0",
+              "csid0",
+              "vfe1",
+              "csid1",
+              "vfe_lite0",
+              "csid_lite0",
+              "vfe_lite1",
+              "csid_lite1";
+
+            power-domains = <&camcc IFE_0_GDSC>,
+              <&camcc IFE_1_GDSC>,
+              <&camcc TITAN_TOP_GDSC>;
+
+            power-domain-names = "ife0",
+              "ife1",
+              "top";
+
+            clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>,
+              <&camcc CAM_CC_CPAS_AHB_CLK>,
+              <&camcc CAM_CC_CSIPHY0_CLK>,
+              <&camcc CAM_CC_CSI0PHYTIMER_CLK>,
+              <&camcc CAM_CC_CSIPHY1_CLK>,
+              <&camcc CAM_CC_CSI1PHYTIMER_CLK>,
+              <&camcc CAM_CC_CSIPHY2_CLK>,
+              <&camcc CAM_CC_CSI2PHYTIMER_CLK>,
+              <&camcc CAM_CC_CSIPHY3_CLK>,
+              <&camcc CAM_CC_CSI3PHYTIMER_CLK>,
+              <&camcc CAM_CC_IFE_0_AXI_CLK>,
+              <&camcc CAM_CC_IFE_0_CLK>,
+              <&camcc CAM_CC_IFE_0_CPHY_RX_CLK>,
+              <&camcc CAM_CC_IFE_0_CSID_CLK>,
+              <&camcc CAM_CC_IFE_1_AXI_CLK>,
+              <&camcc CAM_CC_IFE_1_CLK>,
+              <&camcc CAM_CC_IFE_1_CPHY_RX_CLK>,
+              <&camcc CAM_CC_IFE_1_CSID_CLK>,
+              <&camcc CAM_CC_IFE_LITE_0_CLK>,
+              <&camcc CAM_CC_IFE_LITE_0_CPHY_RX_CLK>,
+              <&camcc CAM_CC_IFE_LITE_0_CSID_CLK>,
+              <&camcc CAM_CC_IFE_LITE_1_CLK>,
+              <&camcc CAM_CC_IFE_LITE_1_CPHY_RX_CLK>,
+              <&camcc CAM_CC_IFE_LITE_1_CSID_CLK>,
+              <&gcc GCC_CAMERA_AHB_CLK>,
+              <&gcc GCC_CAMERA_HF_AXI_CLK>,
+              <&gcc GCC_CAMERA_SF_AXI_CLK>;
+
+            clock-names = "camnoc_axi",
+              "cpas_ahb",
+              "csiphy0",
+              "csiphy0_timer",
+              "csiphy1",
+              "csiphy1_timer",
+              "csiphy2",
+              "csiphy2_timer",
+              "csiphy3",
+              "csiphy3_timer",
+              "vfe0_axi",
+              "vfe0",
+              "vfe0_cphy_rx",
+              "vfe0_csid",
+              "vfe1_axi",
+              "vfe1",
+              "vfe1_cphy_rx",
+              "vfe1_csid",
+              "vfe_lite0",
+              "vfe_lite0_cphy_rx",
+              "vfe_lite0_csid",
+              "vfe_lite1",
+              "vfe_lite1_cphy_rx",
+              "vfe_lite1_csid",
+              "gcc_ahb",
+              "gcc_axi_hf",
+              "gcc_axi_sf";
+
+            iommus = <&apps_smmu 0x840 0x620>,
+              <&apps_smmu 0x860 0x620>,
+              <&apps_smmu 0xA40 0x620>,
+              <&apps_smmu 0xA60 0x620>,
+              <&apps_smmu 0xC40 0x620>,
+              <&apps_smmu 0xC60 0x620>,
+              <&apps_smmu 0xE40 0x620>,
+              <&apps_smmu 0xE60 0x620>;
+
+            interconnects = <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_CAMERA_CFG 0>,
+                <&mmss_noc MASTER_CAMNOC_HF0 0 &mc_virt SLAVE_EBI_CH0 0>,
+                <&mmss_noc MASTER_CAMNOC_HF1 0 &mc_virt SLAVE_EBI_CH0 0>,
+                <&mmss_noc MASTER_CAMNOC_SF 0 &mc_virt SLAVE_EBI_CH0 0>;
+
+            interconnect-names = "cam_ahb",
+              "cam_hf_0_mnoc",
+              "cam_hf_1_mnoc",
+              "cam_sf_0_mnoc";
+
+            vdda-phy-supply = <&vreg_l5a_0p88>;
+            vdda-pll-supply = <&vreg_l3c_1p2>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    csiphy_ep0: endpoint {
+                        data-lanes = <0 1 2 3>;
+                        remote-endpoint = <&sensor_ep>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.56.0


