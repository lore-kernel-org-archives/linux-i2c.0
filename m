Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AF3B47C4
	for <linux-i2c@vger.kernel.org>; Sun,  2 Aug 2026 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785676431; cv=none; b=nAkQ/shhsx9BqS7nO3xLrHDEotND9bUZnnWClec94YR+edRCo66iUpw49KLLar3nfVY75SW3Li0y2UxvWjkNnOYnX73EZ+2nAAveO90F5nwzayOKYVxOWh3E3fwoIfa3MUZrAmdmVxlGoya9Zju1GT9GIXhxzCFrnxu7GcAMz58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785676431; c=relaxed/simple;
	bh=c+YVks3b0NjnPxZoViYuM2n50/y5hiDqyE3XSAVuY7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fP0q1vpbiZGkvMDRGAHkMvVZBYoq58ozXuG5NyZcJzuJtuFokXQB8XuC/aDpzpMz6ErCBe8EoDp0J19liAcP2TwNWSTiYQI58Ye/RPOJJjHCR11Uzz0rPI88LAxeJMT61rLSQqdX1Xe9VNQsQ6Q31JfTaA7QtpkbMUU7xgR/KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=piH226cc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UPxiwoGy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="piH226cc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UPxiwoGy"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672B7Zhq1320127
	for <linux-i2c@vger.kernel.org>; Sun, 2 Aug 2026 13:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WFMrveH/zKDPg6uSCRqHIFF/V3WcuiRR4bYskluiiOk=; b=piH226ccPxhyuSkF
	qrWV0HA4UabSsB9S3VG4rMDPrcgRPtCpkKl23ZpKNlQO7R5qYn1lr0HK/+Ve9K9e
	6n2ijm7ae2IFZSaCj2xi3YHs7tjOWXZFQcZ9yqoNZpSqzGT0EMl1/TxbfWPfiNv3
	T7QXBt0HJ1nLa7n6izV/EaqR3Xi6iY1eOFipTemOuJtmEq+rQz7Ybd0U9ihQts4I
	P9wR2++wjg92ijHGzVwtCPUbD+eBby3bWzF/B4SVjBPaMLLRzVmN/1KAldaz5i2F
	ZbgZkMs6C25Pu2RybhDiLQzlT8RsTaG89ZMGyW3PdlihmLCaKg7llcrfhehS8v2r
	lLNXTA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs966atkv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 13:13:48 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c856470fe9fso1842969a12.2
        for <linux-i2c@vger.kernel.org>; Sun, 02 Aug 2026 06:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785676427; x=1786281227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFMrveH/zKDPg6uSCRqHIFF/V3WcuiRR4bYskluiiOk=;
        b=UPxiwoGypqreNsQyKsKCzrRaGeLjI9dnxsShw3xSa2mRE7nCJcZd4Y13VyjGqRs9cM
         EjeiFTlk14COn8Uo62XAuwXfx6zvcnA7rhAhLDiHBN8ojZM1EOCRGIBPqx2js+1Jl/3F
         gxsPK3otca9kXjZXb7ROzuATZ/gf5LsnIeCmvla72lXSfgO4rSRKLBDP6SSUL6bgLcR+
         x6SLRkEWS1ppnychplOBMHZivft0xAog+FrMXITmmoNCULku0Tn0CSH6JbF+flvDlTlb
         28glomotKExUMX4hIpKly4S1qX14QkrCpqIkoKi8XcADEAWekr1Hko/0XHs5eaB4HvmA
         ARzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785676427; x=1786281227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFMrveH/zKDPg6uSCRqHIFF/V3WcuiRR4bYskluiiOk=;
        b=c2IiotP67fTVr+qIXlaJbxFC55XVhu1OGJJ2LZ6V5PJQR1wGZiBVV4H/Y4wQcphGXx
         XcTxSxLsoAqiLRXpesoub8mphyR1FESfOxJy7zwc05x9yct5L9Gl4uGKvSCuYv45oWL6
         Bfm5Cxj+dBU8XXH96HY6oi98IiZ/hsTvQLjWVrEgNH32417WvK/UO2Bc9eChSIbl0IOl
         jTkE3iVQNdQmXp+Tv3QzDGArilFOALO8DhnDMgFLk4e4VcHraE+8s7s7t8lmMtAm0GfD
         LzTfjbxb8AWRzLG9WQmpYM1oPDiQZJE+cBhImUzTrNykjdUK+wxVEXDyMm0mHwt8B4FO
         oRFw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9qKQOlaBlUjQXCAFtjy4WWbf0/2n23Kc9jeqFcj1/3OABzl9oPSS37cOaXZ+kDbB0MtskzXcT5Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TvuIOIhbrszocb/qpdbGAbQDrgwTcZhD2LMK9r+xdtA63Lbw
	JCazBmyUm/pddxE+UORPDdZbsLFT1z+kloqHD2N42cl078FxCGkoJGFdGsgpPWN6niQhJ7G4ZWE
	G2MpnZdCSz3Zw4E3SfVAEHbpWImNvN7rZXjrKPn8/l2oWIo50geovZ7rBT1wL8cw=
X-Gm-Gg: AR+sD13Qyr5w0+nBLBJg2hKTHYb5RItuJoP2f/Z0IhQbmYgpmZN6sLML5JQr1YHtUPW
	yhGBdrs9PsVvlHDEUreui6vYdnlna8Hx2Ux05sW/CT0r6WcnXk9fOvz0fux2w5RVKjJKjT0KvLX
	iSver3mFqW9qFtBgbjuyyF2mozJ0feYJNywYDL2gkxUl2jpdmALwhSm/FGfaQlvARaU+Z6/iglZ
	QpQwjdiQhqOK/q5dPIqafMc+HRX0cLCTnN9vpi6o2Q/82OgZxw3sg6X/ey3xhkZqg/oSCHi9kyU
	CMi3E/8e2CpqJJIiQG+smVd07oLyLsTQ51gUEz/hWk/R9aJQrQkeO3/ZoNGLMNnx/YLJ2+34bne
	pYBAu6qDnvhQyslfYX885AkBZ7C0AMP8xM3La
X-Received: by 2002:a05:6a20:430c:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3c92a5a1956mr6354260637.11.1785676427373;
        Sun, 02 Aug 2026 06:13:47 -0700 (PDT)
X-Received: by 2002:a05:6a20:430c:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3c92a5a1956mr6354244637.11.1785676426894;
        Sun, 02 Aug 2026 06:13:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f8dbsm28303457eec.22.2026.08.02.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 06:13:46 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Sun, 02 Aug 2026 18:43:30 +0530
Subject: [PATCH v2 1/2] dt-bindings: i2c: Add Qualcomm I2C target
 controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-i2c-qcom-slave-v2-1-27653118fa75@oss.qualcomm.com>
References: <20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com>
In-Reply-To: <20260802-i2c-qcom-slave-v2-0-27653118fa75@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785676418; l=2894;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=c+YVks3b0NjnPxZoViYuM2n50/y5hiDqyE3XSAVuY7U=;
 b=Pbj1y8oGh+c4QxvaVEvnyMqzGBQhd0ckHUQCEfsw+wxydShkDhqPFT7fwTB5x7saqp4i1qWVN
 3Nz7Zpv5dyeCafFgms731GZ8k5tPP+g7KdrQvvGTMdCeWfieLvJRB6d
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: lO6XwndSBuEuRCoSzyZTH6sQlISxYLq2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDExNiBTYWx0ZWRfXwIdJ/AEn2Qmi
 Irmn0135WICLBEFVuoOmhj3zAasUY4uzUrtzFENbDakvkNjHNV0HCn8EUB1vjAUfexG7ckPvwht
 hQ4FUphQJ0b8x0JOex7BhNZ2OHLg/pK2EIFxITmEKiXHSuMy5BDyvSPTCdIE9HIzCGzHmcPcuNl
 VQ1ZlbuqPqhPB9oBtw9fx5Pa4F5l02FThITncJavw+XOgPMuW17F4ujF9SBUvJva07sMhntWGMO
 XcIb1Bs0XejygrhLooNLVF9XU82BBKES+SP/0Up0PRxEJGodPF/dTToa0sLsQ9VuUCq93TyB1FK
 Tf56SuMLev6UkATCXO0Y5+3MHgxSuiouc2xLu1KXdZ3xrvMqM9INIDbxSwUxafx/oGHG2bTVDI0
 1aF/TkHwKdL7M/dDMkFg4ezoeHZesgJhHRO0x19G8qejkBBa2rHZrBiKpr3YwxlJ+MiPTFVbazn
 uEU9lU2QGtnnskBgX+w==
X-Authority-Analysis: v=2.4 cv=TpfWQjXh c=1 sm=1 tr=0 ts=6a6f428c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=64-jBHeFNbSwsrqMnDgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: lO6XwndSBuEuRCoSzyZTH6sQlISxYLq2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDExNiBTYWx0ZWRfX858w0TgO1FTy
 TvS3uJTD5B4voxmhOpYlbWaF6VYfWUXaUzKYV7BmSAoyErQtYYDzwT4tRFP8L6irH6WTEAxCuZR
 l8oNrA5XLIA6lAY1xTKQMOtEl1B3NAI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020116

QDU1000 and related Qualcomm SoCs include a dedicated I2C target
controller that operates exclusively in target mode. It is a distinct
IP from the Qualcomm I2C master controllers (GENI, QUP) with a
different register interface, so it requires its own binding.

Document the MMIO region, interrupt, XO and AHB clocks, interconnect
path, and optional pinctrl states for the controller.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 .../devicetree/bindings/i2c/qcom,i2c-target.yaml   | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml
new file mode 100644
index 000000000000..1e34e874cc4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-target.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/qcom,i2c-target.yaml#
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
+  interconnect-names:
+    const: i2c
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
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
+  - interconnect-names
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+unevaluatedProperties: false
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interconnect-names = "i2c";
+        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_SMBUS_CFG 0>;
+    };
+...

-- 
2.34.1

