Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2C3B6341
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791889420; cv=none; b=iUWF1Vmm8v3t6Cg++kDq/gatWZoO1a/MooHG2ZqCE5EMCUNfK09x6gsvx3MoNMsYDdtKgNyzYdZwIKaSyRC9xbArok8DNUkGSWiHHm4JVJtRtJxKyelEkvY/0f42b0WmH505CGHh9K7mDgMrA1vpAnWS0c1yhK8Ua6h+lm5jmfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791889420; c=relaxed/simple;
	bh=fkx8BdgQCXtuvhheut+uP1TzKPTL2Yk7D3OafuiXXC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgqmZLWMucb11QzWDTI7U61hYiBsKO+vCZi16+Cj4KCx6XYdZICdGMr/6JwMcRTK6/kurpDiYrqQI0k5RtnjdEAzahtX4zXmJPgDA+k8LIrfFwjvkP/x4Le7H3lb0vKiZC51FTo/EpEGQMNtp1XGTuXcfjzuJ8bFl9goxuP+lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eBWaJ3+o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WU6dVu18; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBWaJ3+o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WU6dVu18"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8xvHv790856
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jFXCPTv/2nT4awTOU0ExymnzqiaZv71EpQzw8EoM3wY=; b=eBWaJ3+oKax3NgGE
	mqjdCCLAfcJa7LBx5QBGHbgLgBa4r90UwM1cDLS6NxNqZSSzNxe1GRYFmohQIcXU
	R0SyG07xc45jG9jEvEe556g7WzYQoUS0rnoXREKl1dxm7EL5EGiiSIsp53lKfzUj
	umA1MhJvc79sZ40DLfJgS9RhGM68kFo6hBQQuCQzsFL0cOxJ6LwxsjzTm2GLvTO0
	DxeYLNqq9YcPT4I+5+B6nadMC7hWlEEiqHl60a7i8KgTtKbrFEXcSGL84NdnzbwD
	S7UpFGeIDRG8MjsbPnS04tm+WiiBqAzRy2yTxPRutvdpoc7KMUaJ4riUt95nO8VU
	DFstOA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrhcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 11:03:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aaee1fc104so3861814a91.1
        for <linux-i2c@vger.kernel.org>; Tue, 13 Oct 2026 04:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791889417; x=1792494217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFXCPTv/2nT4awTOU0ExymnzqiaZv71EpQzw8EoM3wY=;
        b=WU6dVu18DXMJyBGJC6dqBiRImBrLmMMaISawuOLo5LNmRJOfAHvDyj1a0It0Zwky+F
         SA0jSoVLNq/zEPC8sK++jESXUDgG9wXC5E410BPTME1nFoL+3dNH7kzJPTQEbXiTYDEe
         2oZmjrRMDGV1xgtPCetxEwcgooEN0AW9Ih8Hj02v8DHczxttmDUctGI9uOIb8pApMHZB
         loS/UUEuL/tsDuoY/yyPLEyZN7ZcV0E2OEkTWqYMaGLcJV80h7A+39sYeg/ENrdf3WKs
         fsmZr3cfU1Y74aErxOuVcHaiIkUwJQi7pR7Lu++kLJ52rUMxnwBNX0CF8Oxwv0fMQF8I
         T5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791889417; x=1792494217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jFXCPTv/2nT4awTOU0ExymnzqiaZv71EpQzw8EoM3wY=;
        b=nfM1KOvZThbL3hknGsnGPZvnutWbpksDWvqlv0OBoppznRriHcjqyhTRL0hiTatk/d
         9zqxrfNdADfCrKtzrvh2QXWpmb2qXxlU2n1QVpugc4caQ47SVl9EkpJU1gfAnx8jXlmY
         C53J7Y97I3g1K3dzJpLO3bltOVlCZZ/KXSEha1Ym+41Yjb7phYyfAm11HiZpORjm6flm
         zZaCHAHFm670bnc/AAYN5S0g/Q1hg5LAS+QX/MxWtHkekxOel1C+SLNFuZnZAox3kwB3
         ST1k7f/X3CpF+98jViXFhS5l/ogwzMi0a7ZtiffpS89FOSdhM5A7z4BP1WjClQ9RhJ+a
         xFeg==
X-Forwarded-Encrypted: i=1; AKwUvBxFwhZTkaa0Iz5Rf2IZkawCOBwbNbYLyetC7qsCJlNn7i62q2Y2Gv6YktMa4j68WRxwS476Oh6dzho=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMkD239oTxinwMnOFGJxX+3RodpPp4pilp5maP8U/jhraTyi/5
	vFzSBYUEV7kWZVAq2SGnXZC4JCgCYDXQ3fESFbYWvNs2rL5xUih/nv96UTDn9o44JXxch4zaSLd
	N789nGqfKlt6xwkfOGTw0V1UgK/u8o7xYHB0YEQtUuztGl2Ym9DDZonInoA9XowDhQutEfa8=
X-Gm-Gg: AYBFou1BwFQZSJEEY+4vcLc0j9x4qXqR18N4WNplEnqx0l0a3jzl9YYkcPT0Sgx+43H
	bPvTegqmytEqxPBtJm0ITREIqOF/y9+B3rfl2Y2Z62nKtuZ613LfstqdIv2b7akGHUFue9btby/
	kBNLOwCwHX8gJ4Trxtm6WbTwXq1s+/QqIPbXTusYPYUQekfUQWpIZaSLfoOqOuYt9XJOwJL8MW/
	NWYdysZhIqIIG2DtqrTm8XCyyhaC9NtD1W+zi/JZQIM9fdWKmC8ZMdBmXpAiI4cyJTwphxhHzOf
	joYHdQ+BKiaS7Rzfhtvze+ct/PCLvW02LQsUQ5s20Hd2sUBkpL/cpDy076Xy+4fJFHyvMS0/+Od
	RGqyGCyRWGlvJthgkGo7sUoFiVrSwBmk=
X-Received: by 2002:a17:90b:390d:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3ab3a33da7fmr10652671a91.6.1791889416365;
        Tue, 13 Oct 2026 04:03:36 -0700 (PDT)
X-Received: by 2002:a17:90b:390d:b0:3ab:2d46:1dd2 with SMTP id 98e67ed59e1d1-3ab3a33da7fmr10652620a91.6.1791889415771;
        Tue, 13 Oct 2026 04:03:35 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm20808403a91.8.2026.10.13.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:03:35 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 16:32:45 +0530
Subject: [PATCH v2 3/8] dt-bindings: media: Add CAMSS device for Hawi
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-hawi-maili-camss-v2-3-fc93222da89c@oss.qualcomm.com>
References: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
In-Reply-To: <20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791889386; l=11243;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=pZGG3ZTs6JHutNaOoMRo42LdG3lmp4rBlAcm1z9EX4A=;
 b=q2fTn5CptbTRt9DCAcby30uFR43eE7oOVgKWNrGWPTHTaVqjP9VgkTmxXAvmrHilpZajFcZ0S
 tZHUOe5ZnBvA9KEX4K+J+7R6tB1isFoI0yrSEBkIF+o5GlWuSWIDOru
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfXyau7EBDsxOOW
 N+vkx0tRj5heuqvJAGdvL+ipbTg5avKuZ1o7e7YfYm4OiaAaybBm2ffRV++50yw9Co1buKjh8WD
 61b+CwRrc92Xc+eLpDa5gl2BMdE0hj8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MyBTYWx0ZWRfX+szZN9tAsuKj
 aQuq9ewcQXSvYdwoE2Bl/G3pF9HzcI5VL09ovvzvhTp8bPFPHt9MYGT3Sqd37XW/PrNoTOCgSL+
 R0KHB9CRt/IFSE1PQpZvJ5HBVI+MFpReqfvrt/CajLYJq9YD2A0E2YrbeQI/IWOmgV6TafU2FSU
 fPdq83VhkpTn1k7ywCER4YaDo8YPxeQq85IM0qCj+dVhb2tW26C5a75rfpiSLNYQdnrEjzfsFMI
 k5pHeH4ADxKcxOIII3vr8jAr4jcNFRSaUzyNm7bT8aW0RF0sD5wNcBn27kT/TmFOpC25Ni7tyYo
 wTQIcmXcVp0sviDlPUMobjXf5zPOP96c2c16VSQF3mauOnHJT8LbqlI0C/Rs5sM6dPjTDHhWl+O
 WWUd09+HqlJY4GbC4uOV8M4b5mD+isgL5bZhRxpEtLfpUQzQy7qv3QXul+caeDcLfFK2VsYKD7M
 I3/8CKwFqalsgbH+w3g==
X-Proofpoint-ORIG-GUID: G74ZIWtB-f-YoT-qO1Ozj9TYVeo-ax8G
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace1009 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=yzr0uxE_ijXmPgLYsrIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: G74ZIWtB-f-YoT-qO1Ozj9TYVeo-ax8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130043

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add bindings for Camera Subsystem (CAMSS) on the Qualcomm Hawi platform.

The Hawi platform provides:
- 6 x CSIPHY (CSI Physical Layer)
- 3 x TPG (Test Pattern Generator)
- 3 x CSID (CSI Decoder)
- 2 x CSID Lite
- 3 x VFE (Video Front End), 5 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE Lite

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,hawi-camss.yaml | 305 +++++++++++++++++++++
 1 file changed, 305 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5bf0dca3d24621bfc4a09feb8e5037a925869751
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/qcom,hawi-camss.yaml
@@ -0,0 +1,305 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/qcom,hawi-camss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Hawi Camera Subsystem (CAMSS)
+
+maintainers:
+  - Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
+
+description:
+  The CAMSS IP is a CSI decoder and ISP present on Qualcomm platforms.
+
+properties:
+  compatible:
+    const: qcom,hawi-camss
+
+  reg:
+    maxItems: 13
+
+  reg-names:
+    items:
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: csid_lite1
+      - const: csitpg0
+      - const: csitpg1
+      - const: csitpg2
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+      - const: vfe_lite1
+
+  clocks:
+    maxItems: 26
+
+  clock-names:
+    items:
+      - const: camnoc_nrt_axi
+      - const: camnoc_rt_axi
+      - const: camnoc_dcd_xo
+      - const: cpas_ahb
+      - const: cpas_fast_ahb
+      - const: cpas_mnoc_hf
+      - const: cpas_mnoc_sf
+      - const: cpas_vfe0
+      - const: cpas_vfe1
+      - const: cpas_vfe2
+      - const: cpas_vfe_lite
+      - const: csid
+      - const: csid_csiphy_rx
+      - const: gcc_axi_hf
+      - const: gcc_axi_sf
+      - const: vfe0
+      - const: vfe0_fast_ahb
+      - const: vfe1
+      - const: vfe1_fast_ahb
+      - const: vfe2
+      - const: vfe2_fast_ahb
+      - const: vfe_lite
+      - const: vfe_lite_ahb
+      - const: vfe_lite_cphy_rx
+      - const: vfe_lite_csid
+      - const: qdss_debug_xo
+
+  interrupts:
+    maxItems: 10
+
+  interrupt-names:
+    items:
+      - const: csid0
+      - const: csid1
+      - const: csid2
+      - const: csid_lite0
+      - const: csid_lite1
+      - const: vfe0
+      - const: vfe1
+      - const: vfe2
+      - const: vfe_lite0
+      - const: vfe_lite1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: ahb
+      - const: hf_mnoc
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    items:
+      - description: IFE0 GDSC - Global Distributed Switch Controller for IFE0.
+      - description: IFE1 GDSC - Global Distributed Switch Controller for IFE1.
+      - description: IFE2 GDSC - Global Distributed Switch Controller for IFE2.
+      - description: Titan GDSC - Global Distributed Switch Controller for the entire camss.
+
+  power-domain-names:
+    items:
+      - const: ife0
+      - const: ife1
+      - const: ife2
+      - const: top
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    description:
+      CSI input ports.
+
+    patternProperties:
+      "^port@[0-5]$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input ports for receiving CSI data on CSIPHY 0-5.
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
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - interconnects
+  - interconnect-names
+  - iommus
+  - power-domains
+  - power-domain-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,hawi-gcc.h>
+    #include <dt-bindings/clock/qcom,hawi-camcc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        isp@9253000 {
+            compatible = "qcom,hawi-camss";
+
+            reg = <0x0 0x09253000 0x0 0x5e80>,
+                  <0x0 0x09263000 0x0 0x5e80>,
+                  <0x0 0x09273000 0x0 0x5e80>,
+                  <0x0 0x092d3000 0x0 0x3880>,
+                  <0x0 0x092e7000 0x0 0x3880>,
+                  <0x0 0x093fd000 0x0 0x400>,
+                  <0x0 0x093fe000 0x0 0x400>,
+                  <0x0 0x093ff000 0x0 0x400>,
+                  <0x0 0x09151000 0x0 0x20000>,
+                  <0x0 0x09171000 0x0 0x20000>,
+                  <0x0 0x09191000 0x0 0x20000>,
+                  <0x0 0x092dc000 0x0 0x6800>,
+                  <0x0 0x092f0000 0x0 0x6800>;
+            reg-names = "csid0",
+                        "csid1",
+                        "csid2",
+                        "csid_lite0",
+                        "csid_lite1",
+                        "csitpg0",
+                        "csitpg1",
+                        "csitpg2",
+                        "vfe0",
+                        "vfe1",
+                        "vfe2",
+                        "vfe_lite0",
+                        "vfe_lite1";
+
+            clocks = <&camcc CAM_CC_CAMNOC_NRT_AXI_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_AXI_CLK>,
+                     <&camcc CAM_CC_CAMNOC_DCD_XO_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+                     <&camcc CAM_CC_CAM_TOP_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TITAN_MNOC_HF_CLK>,
+                     <&camcc CAM_CC_TITAN_MNOC_SF_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_CAMNOC_RT_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_CSID_CLK>,
+                     <&camcc CAM_CC_CSID_CSIPHY_RX_CLK>,
+                     <&gcc GCC_CAMERA_HF_AXI_CLK>,
+                     <&gcc GCC_CAMERA_SF_AXI_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_0_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_1_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_CLK>,
+                     <&camcc CAM_CC_TFE_2_MAIN_FAST_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_AHB_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CPHY_RX_CLK>,
+                     <&camcc CAM_CC_IFE_LITE_CSID_CLK>,
+                     <&camcc CAM_CC_QDSS_DEBUG_XO_CLK>;
+            clock-names = "camnoc_nrt_axi",
+                          "camnoc_rt_axi",
+                          "camnoc_dcd_xo",
+                          "cpas_ahb",
+                          "cpas_fast_ahb",
+                          "cpas_mnoc_hf",
+                          "cpas_mnoc_sf",
+                          "cpas_vfe0",
+                          "cpas_vfe1",
+                          "cpas_vfe2",
+                          "cpas_vfe_lite",
+                          "csid",
+                          "csid_csiphy_rx",
+                          "gcc_axi_hf",
+                          "gcc_axi_sf",
+                          "vfe0",
+                          "vfe0_fast_ahb",
+                          "vfe1",
+                          "vfe1_fast_ahb",
+                          "vfe2",
+                          "vfe2_fast_ahb",
+                          "vfe_lite",
+                          "vfe_lite_ahb",
+                          "vfe_lite_cphy_rx",
+                          "vfe_lite_csid",
+                          "qdss_debug_xo";
+
+            interrupts = <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 603 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 605 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 376 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 606 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 377 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "csid0",
+                              "csid1",
+                              "csid2",
+                              "csid_lite0",
+                              "csid_lite1",
+                              "vfe0",
+                              "vfe1",
+                              "vfe2",
+                              "vfe_lite0",
+                              "vfe_lite1";
+
+            interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                             &config_noc SLAVE_CAMERA_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+                            <&mmss_noc MASTER_CAMNOC_HF QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+            interconnect-names = "ahb",
+                                 "hf_mnoc";
+
+            iommus = <&apps_smmu 0x1800 0x00>;
+
+            power-domains = <&camcc CAM_CC_TFE_0_GDSC>,
+                            <&camcc CAM_CC_TFE_1_GDSC>,
+                            <&camcc CAM_CC_TFE_2_GDSC>,
+                            <&camcc CAM_CC_TITAN_TOP_GDSC>;
+            power-domain-names = "ife0",
+                                 "ife1",
+                                 "ife2",
+                                 "top";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    camss_csiphy0_ep: endpoint {
+                        data-lanes = <1 2 3 4>;
+                        remote-endpoint = <&csiphy0_out>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.34.1

