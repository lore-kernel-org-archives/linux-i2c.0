Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC73DAC02
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173013; cv=none; b=hZbn2LMOo7puqOteLAplgK6KLfLh1YEbgqpuOI3KSXW1WO4dKezxGSBj4mWz+fiD8NkBXX2C/n8Xakko7/jy8D5cxtv/77Ig7FaVG/vn9LNk8WV9LtKzFew6xSp32CrykOf4PAbWoGp/YMR7gS8GHQZIP9LiBw/0xLP0c7weozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173013; c=relaxed/simple;
	bh=fLcHXdKV5/hDu2wr6i98ZasPwufFwNkdfF36wyuIx94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Egul0kbvFYo0KMITSUkmWOtDpYV5FZoIWy0LGyUF987ENRZI2J9+lHZCwUdRq9lS5yi6KfQz3wpZIZcZmQGnO9SKUeBQ5LBKfxnBYqSrIIBg6A/M8ZhkKVkRW/Rx3SDw4AvYgHIOpZVC7uli1WRO0Si00y6f54Qbtm/CgGu4Pus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dRNHFoC6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OxAQFFAA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dRNHFoC6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OxAQFFAA"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R2K0Ff3761435
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cbpTgWXazdO
	AfAdL49uExcjxZu696DCuIHbDLPHFMMY=; b=dRNHFoC68FeCvWKWNf7RlsJlegv
	kJYv71UwSzSRn2CKIqGriB1k7RsPYyUMPbWuUfvQY1x6yRWAP5423gb3qydPRIpF
	9n0WkqGTghcQbqDHsC3jDiyehWpcO7YkJvaLiHFVLF03qW+D1soiJ7WRJxr/2s3U
	GZaMWYcxh2puxasX1skLwh4a2RzACeaFKkH13eQCwNgDyiXDYg+y6V8LvGgBbc/U
	F1ddcjyUs/o5vSuW1JYFmJF2kF7R1P54HOW2LkU+6XsF/gTkyd4ocBJAct7/PvQx
	BeliUWSGdGTXewgUjeG8tJAfn4yzcN364A+3aXjM21FDvx6dCjnoWfjZ7Gw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7yacrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 27 Feb 2026 06:16:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2adca7aba8bso14772925ad.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Feb 2026 22:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772173011; x=1772777811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbpTgWXazdOAfAdL49uExcjxZu696DCuIHbDLPHFMMY=;
        b=OxAQFFAAp8QIqebka2GFEFIPOir/hGQ/ntBJn58Lu6sSqpp43ODsFb0BIK0pPxaggY
         jLZDz2XAimGvaR8cbGIR6Wu1PWC/cmv7U8Nuhtn5JY2+mG/8T2ekwoR2Czcs2lGk/lag
         x2FzYAC6kmq6Q0Ll+1/b4vlIDKGpupMKjc9XdfVHSa+CkowoqQBC/id/GYxNo3TNp/Cf
         qkDro5QLHwtR5bMqcOtZcV2ItGLWmSYa69TdHCMPCFR3gead/rxsdKbvXd2f++Mea41G
         w/So+gdgbrV6SrH6IR5fTWdwUv9dtYrcobLcQgSQn8hKTCJX0eT9xoS2UJDkCKKKKIzj
         uFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772173011; x=1772777811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbpTgWXazdOAfAdL49uExcjxZu696DCuIHbDLPHFMMY=;
        b=sJlAsHW7uWpylJKoCAA7sy+YPfX3e+y7Mm/5BBBl41R3Uyi6qcFhPxpoKMIuwogw24
         +eVjR7nTtVFk/53pGKcKBzkcGVMnfba3szW+yJxCdE098PHKMBslTdIBCXFMdR+u279w
         1Fy40pN+byKQfNiDr9drH4JAtznZA3i9X3b6B61eONBzPu7dk756OmLlMwF4he2+VpL5
         q9JLb2jJ3zVwokCsqX7ZNmAmGFu5eOtXplX7dGx37v7bz1FiRAb832OzCxL8lgyooE1F
         cHckqeBDHi9C1Ck3ngr7+6Crrmr2VzfFpml+uPyWS1uKLdordwV1T5FNVsFINYK5s9Pf
         9qpA==
X-Forwarded-Encrypted: i=1; AJvYcCVPnv6w/BQAkkvGk8NuI3dUM2yrttmuwX0gU9SmhLguAMPlTeqqayXMMZQ7ySn91QcvO+fgWL4JAkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF0sB19zkEXql3wZEukGI8yMbsnu1viTzsM6ML0GkJSa239bI9
	cvLrmcFvvSVT4pjwrEz30/LLkOYdrZXHX0T+t4HM8N0rL6YyKuIGYbLbAGrPj8cOAI5LUZBmnIM
	JtW4flV8bBgCuhPo+jP/W+j/2jzLMuYFplDrwQhlgtQyuiGI8bWIT2SbI5GZXlM8=
X-Gm-Gg: ATEYQzzXR9vflNHVjmDuTFaGOfCD7ceES4E6ZRYtD0wMWjcQZ0uleKltjbZSJAFEMhf
	JCFdsOFLJhn1vvDKg5dNKl28MORjQ17HFvMjdAWKZql+zHPe7/tUARg8Urgw6PSDH1OYnKf+vH5
	x24z/CA6zZWvYmg4QZoRvyt+c5bctXOqXBHo0e70fc0LD9aIjgZz64cipXpxtfrvI1K3gj7eDcN
	xS9zQHgBkwhHSgvwv6CIDUMhatp3mAJ7/pDwy8v5pPLIKncEoOr97lH6Keea2ESrrrzAKWpJ938
	f5DnruJj+fwNoopBXgw+DzwUUN5KysUiHRez7IM4J5qf30kAZUPY2t0k94Ou6r1WqspmZkOHo/u
	Ls0gdvhP6vLpUXNoV08DkhkaR8V+zcU8tjgznu3bE/04EPMq99CJJ5Po=
X-Received: by 2002:a17:902:d484:b0:2ad:ad52:3670 with SMTP id d9443c01a7336-2ae2e4d9617mr12245185ad.51.1772173010747;
        Thu, 26 Feb 2026 22:16:50 -0800 (PST)
X-Received: by 2002:a17:902:d484:b0:2ad:ad52:3670 with SMTP id d9443c01a7336-2ae2e4d9617mr12244945ad.51.1772173010208;
        Thu, 26 Feb 2026 22:16:50 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a043dsm64813025ad.54.2026.02.26.22.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:16:49 -0800 (PST)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v6 08/13] dt-bindings: i2c: Describe SA8255p
Date: Fri, 27 Feb 2026 11:45:39 +0530
Message-Id: <20260227061544.1785978-9-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
References: <20260227061544.1785978-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O1wroH_0Krd5iqWgQdyb_RL4F5YYUyAd
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a136d3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=apMzWF-kzHp83YoYYzAA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: O1wroH_0Krd5iqWgQdyb_RL4F5YYUyAd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA1MCBTYWx0ZWRfX4qlYheCn261E
 E9vrNsQuGCbb4Fi1YaJs799jqqR+hyUEPocP8hPahNH5MBNwfnRxUI+3+HfbL0ssiM09k2LHe5l
 /8+kEV14h079bP9YGkCKUEbx9UIxejlkseeclNH/YSra/uL8gkfnU4asWZm0WAvOU6dJjuOS88P
 WKflZ+G7TUXNKkZVwqYy+ozDpCzcUBVAa7YEAiUHDPn5Dx4EmOJeXVDsH89DJ6QqKGI/+zW1hbu
 5uOX6qRROLzCX3LCQS8amI9TTm4ZFjaCkzpaPD+sDySuQQeRi012nVMh82sLiMFUtLu+KalL0M1
 YzIxDdT6SpDwFuVEXpRXwveM4pDhq28CGCNVex6P9+NWC1yI9i3zhm84I+vxKV4lwJQ219t4jJ4
 ySFcEo/Cs+4H1RBgMlMf9XJoNW/S2MAStIuurONm0ROu9dsVJnmyYxBr6wPoQAbYyWJ5mxswGPO
 RZ8wiIq9ZE71EguuxZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270050

Add DT bindings for the QUP GENI I2C controller on sa8255p platforms.

SA8255p platform abstracts resources such as clocks, interconnect and
GPIO pins configuration in Firmware. SCMI power and perf protocol
are utilized to request resource configurations.

SA8255p platform does not require the Serial Engine (SE) common properties
as the SE firmware is loaded and managed by the TrustZone (TZ) secure
environment.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Co-developed-by: Nikunj Kela <quic_nkela@quicinc.com>
Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v2->v3:
- Added Reviewed-by tag

v1->v2:
Krzysztof:
- Added dma properties in example node
- Removed minItems from power-domains property
- Added in commit text about common property
---
 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
new file mode 100644
index 000000000000..a61e40b5cbc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i2c/qcom,sa8255p-geni-i2c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SA8255p QUP GENI I2C Controller
+
+maintainers:
+  - Praveen Talari <praveen.talari@oss.qualcomm.com>
+
+properties:
+  compatible:
+    const: qcom,sa8255p-geni-i2c
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: power
+      - const: perf
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - power-domains
+
+allOf:
+  - $ref: /schemas/i2c/i2c-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/dma/qcom-gpi.h>
+
+    i2c@a90000 {
+        compatible = "qcom,sa8255p-geni-i2c";
+        reg = <0xa90000 0x4000>;
+        interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+               <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+        dma-names = "tx", "rx";
+        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
+        power-domain-names = "power", "perf";
+    };
+...
-- 
2.34.1

