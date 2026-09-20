Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB35430CCE
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905861; cv=none; b=JT2yNSuJk/y9uiRmDTPV1LGN1024eqcSTImW655lu1YNEkdihvLKjBzstuknLP9eNzAgj3X+qRxXrcp7k2+EeGopvf6nYQH0WYBSkU37982wpsMBAsdffM/TfrPNXAPAHLZ6/VjUYezJg3QYNteGQxJST62Gl++j2eSKShD6CRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905861; c=relaxed/simple;
	bh=vuxpQQHSHpogoXgcj1g6nYIyqWnif7Aqe4zqMtU2VSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N6h0lmMXCPhiyUDxqGIBpBdO5i6f6QHx63xYToIPFAvtOGPthkiTSzwACthHksRHt+dEoAtvuaPO9OPWXFn6mr2Y4OLc+2l2u8pPY9G7s+/nTqs/khL4z0wHKp3Kveb9t7FNAcbgaygdemer3ePvZ/iyvo0DrsLW0rMZvTJTAM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mIyOgh5I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJ5V4qwo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mIyOgh5I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJ5V4qwo"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBoEoo1639406
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	312B9C6n0UKKu6NJESvzkUE//S3M9JdnPEV0pkxNzjc=; b=mIyOgh5IA5WtV7T/
	92dSrsoTNguH/YzjbHn8bddUBUnFIfb6GCPXOg5ZsKfATvdemxL9cEfmIG2yp5nI
	79qm/m6LXqFSg4JmwABanhuUVOSqhRGVv4f5neLrfIWgpPHL9XPUg5zj2sdwTAXj
	I2CfadCjsEKKd9d/DxfKbg3Scrr7MoDmK9AW6KUVnPAhv7FEzV47jIDu5EncTDch
	Wq5NNj858uLKI5HsUeOOy9TaXj2kXVzvYOeuYGdMbCyWOaxeBY4Z+r9I8JEG0bTX
	oHNUZzPLGP6fdhi4gUIGfzQQt7Cg2T8v+v5HfNFjY+cGDTObUca7fpS0H2A+UgvI
	6f7ODQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjs82v53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 12:04:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4ac5feaa4so2979049a12.1
        for <linux-i2c@vger.kernel.org>; Sun, 20 Sep 2026 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789905857; x=1790510657; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=312B9C6n0UKKu6NJESvzkUE//S3M9JdnPEV0pkxNzjc=;
        b=DJ5V4qwoMv/ioTXuvY7HoFEcRorTm74Lr+kP3VN9+6XBTkWJMJWjq9MOBLih3dh44k
         QbSVV1KfPXJ9GhanBcfiyXnOW+U/kJNf+dsMZpwNULUCwVT+BKxRErx+deFHj27iDWjr
         yDFE6mLIln8W2iBfAm940InXwdhtKuYdHN0GeseyNAz7W44a/864f105231/nu1d/ENy
         USBLIkDtUFB933Q1DWOPJDkHAQlZiZ5fDbM7juoUTrveSkV6ntrS3DyHtu3jKlN+NsIV
         TQ2it3zgRfU+x+cVQK96ZXW46kJVb2+MAE9Lmwwv3j/ujXjJ9S1vlWpbUndn1ecqTEEC
         /V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789905857; x=1790510657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=312B9C6n0UKKu6NJESvzkUE//S3M9JdnPEV0pkxNzjc=;
        b=nRdcFg6RUuqyn/GNADPP7TfGeeu5y9eHFjz5FRdg/nWYdABpuzBPHJMdfzktzII5Af
         VP+ZxfTl3u59GIBqNYykeascgw46Qc1GqjnTODuK567Z8maVpVe9i99PoO7noKBbiuAf
         NAWxKmeLpvX+iA726OfLNllieRYyfBlDiE4eWsvEisVvhLwA9SUF6+7JxqHpo57XuDx7
         W9O2zfvkCfBfS3UlD5+onPZRtcy/wmXAEF/tdj1JTTNdNC36SZaqykL3/g4wE0doI4Hc
         /o8iBYXEXCw4Ses1gv949tC/BgClAiY/yEePRFNp9L7H/YzXVIiayHEgBRa/rQ30Tc0g
         MdXg==
X-Forwarded-Encrypted: i=1; AKwUvBzXWSsQld8EsF0G12dIm1SJKY+WxROYvgeS2iePdeQmtPtK+bCs7Eo22twtDoTDgRTyl22rKjUjc2w=@vger.kernel.org
X-Gm-Message-State: AFuF++nC5SemrgAPXZNDHjpLh2RG9BazpNbJweS3I2RLi6ORFd+MI8ab
	Hgmv/rwyWOGqhWsU8IqLroMdQrrYCQv1nyNAhnkHaK0nw2dg2JxWdMvlveL1+a8uD9auOg5GKlh
	7F4bo5U1leKOGomTE0AiIr+R9By+VWtfIh5xK8bKUtAkArqSlucTluD/EHEqxCP/vLAA81nE=
X-Gm-Gg: AYBFou0ph3SqMyZz/W6r28/C9AmAD5PuiUYOjf/IxAYW5mPcU4fhBLV582COk5u9wFu
	pfZPRwpxKwJtWLLWYR5K1L2LSIXcfTMzLIOPJ00kroK6ZZZFpzHJDEGrZejzrQR95vfWUHJX0rV
	MVgcoer7SRLII1wcqWyvtyF0vb0FdETWMf/Pom9+1yXfgUA4R2QRmvSdZVaWssWwf8TCL63cI0h
	DpOK0ZxjcUtmIjCx1Updd4nR/WTBhnFIr86PunooMVlhrZAmnu1olojb9Wv36MFkGokzmz0LCDu
	TNSupQGm1mQPAekD4xnzeLqLlzNipPFBJY9gtZF7eCOIig4NFXwa3LMcyvZO8qm/jm5y2Zg4eqm
	jHJGqY62WgW0Uw+SEW3i9esVPFw3PkrOE8PU=
X-Received: by 2002:a05:6a21:b89:b0:3dd:a197:cf30 with SMTP id adf61e73a8af0-3dda197d7f6mr6614211637.84.1789905856588;
        Sun, 20 Sep 2026 05:04:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:b89:b0:3dd:a197:cf30 with SMTP id adf61e73a8af0-3dda197d7f6mr6614165637.84.1789905855983;
        Sun, 20 Sep 2026 05:04:15 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55aaf1csm12109622c88.3.2026.09.20.05.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:04:15 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Sun, 20 Sep 2026 17:34:01 +0530
Subject: [PATCH v4 1/2] dt-bindings: i2c: Add Qualcomm I2C target
 controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-i2c-qcom-slave-v4-1-f7e1020f3bb4@oss.qualcomm.com>
References: <20260920-i2c-qcom-slave-v4-0-f7e1020f3bb4@oss.qualcomm.com>
In-Reply-To: <20260920-i2c-qcom-slave-v4-0-f7e1020f3bb4@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789905847; l=2790;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=vuxpQQHSHpogoXgcj1g6nYIyqWnif7Aqe4zqMtU2VSg=;
 b=cD/isAtcvTnIdN4rCxFt5vNkUpdNJkaupwoJvyxs8k1coPb97PAwRqJiTWapxKDPtfOgGWB9B
 ZtdV/dhZQi6CPEPQq+AlaJY/KgPuapgecMT7U5YHLlR1J1NLlY/h8xj
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 5iWdN23Mkhyg0dCKyL3fgaxnBnpiiX1S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfX5b4VLgtGXRwJ
 ycHRIluCpiontyPp5p0YCvp/4Vv7v5IEOFtJPNVKxNdTZiP9P3mkrEqkZsT6SNPLQqJ5a1POYPn
 Qq4tmM0Gf5D+9s9JLMzBhhdzPNx8h2k=
X-Authority-Analysis: v=2.4 cv=YqWa1IYX c=1 sm=1 tr=0 ts=6aafcbc1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=64-jBHeFNbSwsrqMnDgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE3NSBTYWx0ZWRfX579OzaMLaYZ6
 kgnvXxRLIKSYRZu5z+ANuBuKvNuowOsZdmsin+Pf60ArGUEU0we0WSSGmLRcuzEaUgbCrHLRKPZ
 hrvwwrkc4plYx4vFXqL6dsYDlw9gFXlPdPi/iwk8nquEaZtKAUVIqIzQqXWLhqQjnd2pxCVE3C8
 nliuqKbtqFONB9Iy2Hq8Lu+Gp9ZD8c68NJ0CA6tavDx8fwvW/hCzMRivZ3GUVKt3q4x+vXeCLoQ
 OFITJG50OlCVoUkecPc/lX5TragKTPQiHTjRIKBRBe1QR1pBglaHSdbKS0DARfpVniohZxBm+SS
 TBxqsIp9KOcnDWFgo/97mE+SpbayfkaA4wkkSUN1aagUDnhDqU5LYb6Ea8bkWBTSPcXQ2XuDRiM
 vMgOCv7pqUReRdkdB3MaKF1dx2sml852hV2zplQOXVs+0Y37pQmUkXShTNtisV1hCK3T/6+dVBs
 Cnk+3BFOZ+pxx6t6tkg==
X-Proofpoint-GUID: 5iWdN23Mkhyg0dCKyL3fgaxnBnpiiX1S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200175

QDU1000 and related Qualcomm SoCs include a dedicated I2C target
controller that operates exclusively in target mode. It is a distinct
IP from the Qualcomm I2C master controllers (GENI, QUP) with a
different register interface, so it requires its own binding.

Document the MMIO region, interrupt, XO and AHB clocks, interconnect
path, and optional pinctrl states for the controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../bindings/i2c/qcom,qdu1000-i2c-target.yaml      | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml b/Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml
new file mode 100644
index 000000000000..9a6b08f0ab0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/qcom,qdu1000-i2c-target.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm I2C Target Controller
+
+maintainers:
+  - Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
+  - Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
+
+description:
+  Dedicated hardware IP found on Qualcomm SoCs that operates exclusively
+  as an I2C target (slave) device on the bus. Supports FIFO (PIO) mode
+  for data transfer.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qdu1000-i2c-target
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO reference clock
+      - description: AHB bus clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: ahb
+
+  interconnects:
+    maxItems: 1
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - interconnects
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,qdu1000-gcc.h>
+    #include <dt-bindings/interconnect/qcom,qdu1000-rpmh.h>
+
+    i2c@88ca000 {
+        compatible = "qcom,qdu1000-i2c-target";
+        reg = <0x88ca000 0x64>;
+        clocks = <&gcc GCC_SM_BUS_XO_CLK>, <&gcc GCC_SM_BUS_AHB_CLK>;
+        clock-names = "xo", "ahb";
+        interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SMBUS_CFG 0>;
+    };
+...

-- 
2.34.1

