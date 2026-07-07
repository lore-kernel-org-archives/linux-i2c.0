Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C46288C2D
	for <linux-i2c@vger.kernel.org>; Tue,  7 Jul 2026 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783411364; cv=none; b=NCVjCDNmeCrZ75Bjqt33EHISUJkrAzu6dYX+MNbh/stQzNc00eN5nCdX0J/YiZCP3SE9526Hsk7LLF5A2PxWUeMCILROQ0tZOjYoJ9sUMBALPbzx7pYdwNDzp1B3PGjgI9ih1tNJ7MGbJnX3kYN+HmgCJXHj6y1daBHwSXBzJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783411364; c=relaxed/simple;
	bh=05mTt3WzwqVURtsexFxJaoPg02cIOnA+8A1NAYyBuZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCopEgGttuFdCuoEhq0ur2HfOOYjW7g626VYkmW8IGYQV70tPLAdboDtMMXlhjNMnBUyjTXz87HkMYPDe2GLE4OFq0K6PKB4ydfvj2kHSCwf0JRF7F1EJLaPkYmyZ75zwiJbuT/Z8R84wJAEIlCXeYQ8XvNjh55wsuUCSrzuOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hva6BdC7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fO40iUk1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hva6BdC7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fO40iUk1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6676fS3x2998342
	for <linux-i2c@vger.kernel.org>; Tue, 7 Jul 2026 08:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+kTw63aCltmhjLTw8lsJ8qVfHy0eXwaijmW
	Z0RC0Bws=; b=Hva6BdC7JkOfqsmoY4tQtnZaR8mVlqD5DiprI5O2mYsVi+i3bp+
	EWwRgSSK3SnoJkbd8X82/WwIH6ZA+CjpkQsRgGKzOPVO8cQnzDyl/OktVodQkW75
	rrTAi+uFuq5uhqZ7ZKNvP7SQAYKGZk0wVSDToONy8GyHbbL+6rEFhkJCYppqEVah
	Uw6M9gwYia4QCu0c14JEsgTNjnUr5YfIlEtC0546wjxNmYD7+Gm0hG7HkGrWxHiH
	HLjOULIPyHuy7sK6hDOdUu8M12Zf7ri2Ta41cRlhqW48mCxyXNdNL90bprjUI9U2
	Ivns1aUujaQx8+vB3/EFVK4SR3NCCZWuIrg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdj8a00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 08:02:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-847b8d76e3dso6582179b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 01:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783411361; x=1784016161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+kTw63aCltmhjLTw8lsJ8qVfHy0eXwaijmWZ0RC0Bws=;
        b=fO40iUk1wAxv6+mGgStiyhTP9f40bx8UxMBpW1/OumDI8thaYnlz58Ziax3uNoWDnB
         Gi7ZksFjesvWfiAnLectbIlUsNZi+rkF6OiqFJcRTVUMJ43vuGvUFoAK9rGYnNIH1R+r
         Gei+z+dOZSrlVKO1m57NPJ22LR53hG927xyIHTMTapc9Ee2u1TaVYsong6gusdWzNtCO
         ZMNUFnXGx9NBtZWgie6vDv4du6WlFWbx9pj7QJwOBxQYlhtcHTeGgtFOaIZIpe2b/ipJ
         Zzc0P2UIAJISM3ar9U7LaX1C+S83ci9pXPdTmh8vLbxLpQ1rJy3ew5PKYoWwGI93pAK6
         K9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783411361; x=1784016161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+kTw63aCltmhjLTw8lsJ8qVfHy0eXwaijmWZ0RC0Bws=;
        b=Gz8xtOl9c4wSG/MlhGFONZs6vWv+puI/8kWMnx+LVPSTtzK/PeOAABuaBWzORyiohZ
         fqvGRIvXCnvRH1kXWUf3hdHEzQyo6wqK3d3GPQNdNSAvxm6Tq34KFINh0C6cIf7Bx769
         5tMJTRkSSV2Dbp8nLs9/6enCLAKUqnL2FtP8aT4u1uSPBxuEDfAa2Y+vEl6hPPTI8jKJ
         vnwpmKOgQYrMtG0Cz2V1izuTb0L0BpKDp8RSN4UU3SO459gkKbO4HLLoQdLMxIhD/Xck
         6rOt2vLvhKqF1wThF0CvOf60Hnr30vAvc71z20STyw4KsoayslOim5PcVmcS1+16D1DZ
         t1TA==
X-Forwarded-Encrypted: i=1; AHgh+RruHBlYI659HYg+mFNcGTWLqIPjChhSDDzuep4yt9LIUkyLL5xDXO4qFKYlJ/KObxhSwVdNWGuM0d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkaqprLQ1PEO1Z9mCN2QDDmb93Ge3TQqHpOOCGawVhkUG1OE0J
	PlSqAoAJGrPL0RzEWalyrjdVQdOa6/yW1gXtYJlhb+SYUojG0/PhRizEfXOd6N8LzBrLeIp9b88
	eoS101tqD+O4bdYv7vA3EZ7hCNwchWn12M843y2ZbzW0/9lAgOlVb9gPtIjiZPK8=
X-Gm-Gg: AfdE7ck7OVU30W/oD+91vu493Gk8zE1B6HDjF9cwkvbRLFo3UnoXYG+/lokQDQplZSB
	aI7jRxXubAnsPCltvDaYhNIIjwV3M7XqKTFnuVSqYW2HRyc3Up2z3csOiHSXzXR92fNGbdnES24
	T1gXiNbP39vNrtCF8AoDCSeM5JyS66WqcJVT0pP+s5cbNHztKcqEYp/SFyqM9II8m52ijmwurtj
	ktiTR7TKxG+1Qpbhi0U74GDn9ac4/Ds7w21IJUlZjUT3oFc9wORXlz9zLXEJ2HAR3ulfXmRtIkj
	tjqh+0C3KZqOzx5tgMz6jJGi2p+VvfZPsf0N2TUQ0tm5Vbm/IQ2eO0DKU31uNpDn+1nQfDg//HX
	JP8nEWlkBloJ7DdbhcR7SG2DmEyXi4LQm+QpS+xfqsFzydqspWhgX2+FAgk0P2PQWDZwSbmw=
X-Received: by 2002:a05:6a00:32ce:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-84826d69104mr3873784b3a.26.1783411360442;
        Tue, 07 Jul 2026 01:02:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:32ce:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-84826d69104mr3873725b3a.26.1783411359467;
        Tue, 07 Jul 2026 01:02:39 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm5061005b3a.60.2026.07.07.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 01:02:39 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] Revert "dt-bindings: i2c: Describe SA8255p"
Date: Tue,  7 Jul 2026 16:02:29 +0800
Message-ID: <20260707080229.3795971-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4cb2a1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=uNDNTEcSI2xEzEqYS60A:9 a=2VI0MkxyNR6bbpdq8BZq:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: bwoLMK0Qr0z6dY_azdFdk0bAKLm0tdzp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA3NiBTYWx0ZWRfX/eU1lcfypDFC
 NxOkb4yEkByNK0dqGlLxeey0N7qVdFeImH0pn+aRpX+UAyGlUVnJshJ6rvr17Hcmaqa0g1kIZlL
 ZBPSDgRZt0A/Onuca1+39/QvSadwICWB60umazqWdK1uBeUTa3BCqBGXnbqGsjf0Zi4qv2S1Zu3
 UwZo8bL4D759EdB6FY2e3O3ewY9xtKpozD1M80vj15tATzOmXkj9zp7a+DAemdVXjCHYx/ZxVF+
 MFyW/Ygpd5lCilMF4UufMjSKrGGLamtB2OW3sapmyZoTTL0La+KoMdpomjN5Digdx6J+99Q9hiQ
 Gj856OfXpACGszo0La1gc5iPhinwuciHQhioK1xYnnELtCYpaXpovZ1X7q/8QLigjVg7kJxNevS
 LvUlwL68/X+PerAqXrQcWPssfoPfbFXMk14/eyBjfPfeaohqSKRKl8FBPsdDr325OmJMrLkYkCK
 t+SWQ6d4oOTVq9oDw/A==
X-Proofpoint-ORIG-GUID: bwoLMK0Qr0z6dY_azdFdk0bAKLm0tdzp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA3NiBTYWx0ZWRfX/vaLqYBc34zA
 v73Exh6Xd89V4NxZCm/mXUUhVqeZQ602sfgmj0LSVOH0CadHj60lCn4wBM/cKSi2N4DegEh3mlm
 yQyR9F2vbFLapL4U9rof/opXdH4oSck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070076

This reverts commit fd359c0272bb4078f3a7ef34c1d53ee0deb59900.

Compatible "qcom,sa8255p-geni-i2c" had already been defined by
soc/qcom/qcom,sa8255p-geni-se-qup.yaml. Revert the change to avoid the
same compatible being defined by two bindings.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml   | 64 -------------------
 1 file changed, 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml

diff --git a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml b/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
deleted file mode 100644
index a61e40b5cbc1..000000000000
--- a/Documentation/devicetree/bindings/i2c/qcom,sa8255p-geni-i2c.yaml
+++ /dev/null
@@ -1,64 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/i2c/qcom,sa8255p-geni-i2c.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm SA8255p QUP GENI I2C Controller
-
-maintainers:
-  - Praveen Talari <praveen.talari@oss.qualcomm.com>
-
-properties:
-  compatible:
-    const: qcom,sa8255p-geni-i2c
-
-  reg:
-    maxItems: 1
-
-  dmas:
-    maxItems: 2
-
-  dma-names:
-    items:
-      - const: tx
-      - const: rx
-
-  interrupts:
-    maxItems: 1
-
-  power-domains:
-    maxItems: 2
-
-  power-domain-names:
-    items:
-      - const: power
-      - const: perf
-
-required:
-  - compatible
-  - reg
-  - interrupts
-  - power-domains
-
-allOf:
-  - $ref: /schemas/i2c/i2c-controller.yaml#
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/dma/qcom-gpi.h>
-
-    i2c@a90000 {
-        compatible = "qcom,sa8255p-geni-i2c";
-        reg = <0xa90000 0x4000>;
-        interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
-        dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
-               <&gpi_dma0 1 0 QCOM_GPI_I2C>;
-        dma-names = "tx", "rx";
-        power-domains = <&scmi0_pd 0>, <&scmi0_dvfs 0>;
-        power-domain-names = "power", "perf";
-    };
-...
-- 
2.43.0

