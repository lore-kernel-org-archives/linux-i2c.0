Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793990200;
	b=LTPu+DjmPdWJlOZtRckDKn2TdhY9DBFosh1AaebMROrbUthy6IWAhx07FH0dH4sE0MqR
	 CjixiiNftvx11RiboUnLoxru/gNMI1gKeLJu1sHeZ+6Lao1IvEuJMjWvBYL26IXOlh5Cr
	 tguVr6Y/oWE23TepnS8nFpYIx0/V270f0caokucnmrxWARfLYTFVyfkrS74eKh+qi0NoV
	 6UGmwJDfKw4SxLClDG5e5UaSMHJ1iWFEx8HSo9i7Yd9uYZqveOZ7oNnEUev1JMMBC+VbD
	 nKM5Mj7ITAir+bu9xkGry9j4FqQL2Y65uZ9P5aZl0EYVeITB5EiRMfjxFq4lPTfJhYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990200;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=emTcu3Ju2+j6QK+m0/7PBNARIWWyENCaGsP9AEa7rGg=;
	b=zBuRdfn1md0hKjdO/jLIVfk9TgDZdhQOkq74OEIFxtb74aHF5Yrr2ycr/l0rt9aKW7yr
	 Xm0baF0toDvGBHxcVMj31OQoZ1FeaUA70WGr1ZipiDPJJzriafF2WyBwPQIQv7HFz/YMT
	 g03pU8QTyqkIIMvWB9LseI02mGmJxys0S1CAsKFhn6colChjL8I1qYZHRFMGcn/4dx3eO
	 2HJOO5dab2MWjVStTew160MhhiOVTkg8C44e3z1HOqKG9JEO6sRhUXyawje43MMagOhjV
	 kT46++Vs3080YHvPhRiM1XmOidxUvwzMTVf1tfQWA/4DzFkm1GoB1chf5dUQsFFnSMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpqQJI1w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7228606D805;
	Fri,  6 Nov 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpqQJI1w
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793990199;
	b=ibu7JKbWlX+F9yzL1ABTHsYPyLj5EC4mk3LHClDb4/v3TpIQgJaUW1fBMLzq0IShJxLj
	 SSErJjxW/OkWsBVEh0QTfxqdrmPf1/y6vKcAxt/bxBoey25XEFaMAewu+0vaLMZy4wk4L
	 4WBR4kWAJRf0SD+qzRmR4ynWmaTdvuZ5loW6n2WgB2Nfx13GoWkftcDf/BGgd9cpdPQSP
	 XNoNqKRGklGfpNEOwAKXQOy7+rVgIuUn0jb1EpJJMZ0ZybcfSFA+iMM0v6Td9yJ8BIysm
	 MJpyHmaW4dhj86Fn9yDHxIb5SGB+VPsno/nQVAmTXDxRqcrzb10p6SHBoCXB7djacJg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793990199;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=emTcu3Ju2+j6QK+m0/7PBNARIWWyENCaGsP9AEa7rGg=;
	b=WCAoDfNI2gt9pWAjotTGP0brwUkCI+XbA1OM0LzrJ/LASwHNAi+mF9JfgCYmwppL+hPE
	 FQhH40EMdcP5Mc0MybTQI5tTrIqFA6Ruexd1EaCCQ9v44RoloptD/22ECpdEQYK8rUY6G
	 13NNpVMVgTQya0S3ZDyeSyA9PsdWUUZ9MoUSANp0JXwoP+jSJ/D4rWgHeZK/mtDIEm6Ou
	 HO1y8/ylJUsfoixXT+I/+5oeEH24k+XYMgm/JtkPC30U/5xlu6oMmYZ9li8JXX/Hh/E5b
	 Sl5clB4jP+1pB/Vz5k4ZVrduWcf77/wErTxsnJZlJSo/4SBqyOM2SnRsIrxDXTgWiRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B75991F008A3;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990199;
	bh=emTcu3Ju2+j6QK+m0/7PBNARIWWyENCaGsP9AEa7rGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XpqQJI1wn48AWmByVDtH+GpRCV8yNNJ7KdKBc08TrXXtl0suAChYFer4esydL3hmb
	 qiLT+mWUEISrH8jkxXAbk8LrnxWMTZpTo9hbnSuM5/mh3I/b0A8Lny5EOToFYjkkSo
	 Jo+38RiLPHH00G0A9TZNI29dvAAh/JFIrZUhrUkMDTaWnbqqCOU/BK1mBoNqtADekp
	 j+M6RyGoKJFonXVpapanXa7EvZLQ7rAD/PqwOhC+gARnD9l5LuHlZ2+P4szh2XWWME
	 G8xnX4KQGhuEpDWWmFrH/Nl337CjWFX77PxL/7sg2bM6V+v3WTqoNgK7C1OIKTwx5q
	 HKqQSLRtKFVLQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F77F47819;
	Fri,  6 Nov 2026 18:36:37 +0000 (UTC)
From: Andrew Gigena via B4 Relay <devnull+mail.andrewgigena.dev@kernel.org>
Date: Fri, 06 Nov 2026 18:35:35 +0000
Subject: [PATCH v3 3/7] dt-bindings: phy: qcom,sm8150-csi2-phy: Add SM8150
 CSI2 PHY
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
Message-Id: <20261106-sm8150-v7.4-rc1-camss-v3-3-0103e8a0bbcd@andrewgigena.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793990195; l=4862;
 i=mail@andrewgigena.dev; s=20261104; h=from:subject:message-id;
 bh=4StL/0cZR1pFiugSPlhrlX0GIRod4xaFwYZMPXIq5uU=;
 b=rq1wgRFBH69KD9ie9nj8PIdAORsADHLf4ffIJIaka/kMmLNX+F8ANwuv/JwtLum1w7czf5MpO
 2HLV4M8CMEPDEMpNiBAbfq6ZqBw7hmIzyYzQe/qhw+8/K0ePDV2baBP
X-Developer-Key: i=mail@andrewgigena.dev; a=ed25519;
 pk=OMhlYIBaOEC8g4mJ4JCKy7kbg+lrwRxuujieZF8Ne6U=
X-Endpoint-Received: by B4 Relay for mail@andrewgigena.dev/20261104 with
 auth_id=1402
X-Original-From: Andrew Gigena <mail@andrewgigena.dev>
Reply-To: mail@andrewgigena.dev
Content-Transfer-Encoding: 7bit

From: Andrew Gigena <mail@andrewgigena.dev>

Document the Qualcomm SM8150 MIPI CSI2 D-PHY. The PHY sits between the
CSI2 sensor and the CAMSS CSI decoder and is fed by the CSIPHY "core" and
"timer" clocks, the TITAN top power domain and the vdda-phy/vdda-pll
supplies.

Unlike the X1E80100 C-PHY/D-PHY combo PHY, SM8150 only has a D-PHY, has
no separate AHB clock and no MMCX/MX power domains, so describe it in a
dedicated schema.

Signed-off-by: Andrew Gigena <mail@andrewgigena.dev>
---
 .../bindings/phy/qcom,sm8150-csi2-phy.yaml         | 163 +++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sm8150-csi2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sm8150-csi2-phy.yaml
new file mode 100644
index 000000000000..86d8970d1119
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sm8150-csi2-phy.yaml
@@ -0,0 +1,163 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sm8150-csi2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 SoC CSI2 PHY
+
+maintainers:
+  - Andrew Gigena <mail@andrewgigena.dev>
+
+description:
+  Qualcomm MIPI CSI2 D-PHY. Connects MIPI CSI2 sensors to Qualcomm's Camera
+  CSI decoder (CAMSS).
+
+properties:
+  compatible:
+    const: qcom,sm8150-csi2-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: core
+      - const: timer
+
+  interrupts:
+    maxItems: 1
+
+  operating-points-v2: true
+
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 1
+
+  power-domain-names:
+    items:
+      - const: top
+
+  vdda-phy-supply:
+    description: Phandle to a 0.88V regulator supply to a PHY.
+
+  vdda-pll-supply:
+    description: Phandle to a 1.2V regulator supply to a PHY PLL.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Sensor input. A single sensor is described by a single endpoint with
+          one to four data lanes, numbered 1-4. The clock lane is position 0.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              bus-type:
+                enum:
+                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
+                default: 4
+
+              data-lanes:
+                minItems: 1
+                maxItems: 4
+                items:
+                  minimum: 1
+                  maximum: 4
+
+            required:
+              - data-lanes
+              - remote-endpoint
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output to the CAMSS CSI input port.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - operating-points-v2
+  - power-domains
+  - power-domain-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8150-camcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/media/video-interfaces.h>
+
+    phy@ac65000 {
+        compatible = "qcom,sm8150-csi2-phy";
+        reg = <0xac65000 0x1000>;
+
+        clocks = <&camcc CAM_CC_CSIPHY0_CLK>,
+                 <&camcc CAM_CC_CSI0PHYTIMER_CLK>;
+        clock-names = "core",
+                      "timer";
+
+        interrupts = <GIC_SPI 477 IRQ_TYPE_EDGE_RISING>;
+
+        operating-points-v2 = <&csiphy0_opp_table>;
+
+        power-domains = <&camcc TITAN_TOP_GDSC>;
+        power-domain-names = "top";
+
+        vdda-phy-supply = <&vreg_l5a_0p88>;
+        vdda-pll-supply = <&vreg_l12a_1p2>;
+
+        csiphy0_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-400000000 {
+                opp-hz = /bits/ 64 <400000000>;
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                endpoint {
+                    bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+                    data-lanes = <1 2 3 4>;
+                    remote-endpoint = <&sensor_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                endpoint {
+                    remote-endpoint = <&camss_csi0_in>;
+                };
+            };
+        };
+    };

-- 
2.56.0


