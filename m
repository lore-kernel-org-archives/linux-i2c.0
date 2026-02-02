Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B95387563
	for <linux-i2c@vger.kernel.org>; Mon,  2 Feb 2026 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055839; cv=none; b=MPYaUWT56WYL3XvendxilHFnu6cv4js206tWy7iSCANnPF+ataxeuPanpGO/xfmaT0vLaL360cB3edS336+lgWimVi5LXNarZ7xLY4KKyJisP0xW8Qk+4SR9uK7GXzOMT5FWyh7hTJ8g4j09Q0zf9MYH9hKXzN73TJjUxHUb7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055839; c=relaxed/simple;
	bh=fLcHXdKV5/hDu2wr6i98ZasPwufFwNkdfF36wyuIx94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tfHPMZxXZEdEC5ZTZXcJ2PHsTOSFcxVREesPpJv6fVErIGq3rTAonF/ujbzBU0dws8J3WU34F1JmcZzLFJjKdaRdU38ELvEpLSAUSOhTca1ljZAkFC9ib5rU+KMXiMJuUNPXbwYV1TRaEmbU728l+LnvtDvDJ0wOLzVrKDlqqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HpMNVcip; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dbx1PYte; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HpMNVcip";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dbx1PYte"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612CJSIo2884359
	for <linux-i2c@vger.kernel.org>; Mon, 2 Feb 2026 18:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cbpTgWXazdO
	AfAdL49uExcjxZu696DCuIHbDLPHFMMY=; b=HpMNVcipAqegOF32c3LLEcQmm6A
	ikQb5KQHhYJtQ77BXaQRlvhCPxNwDUqCXilM6IUZCqEDG5GMZkoWJA0gxtqRwVPG
	ZsPbkNogMdcikhN39j+CmVN/hCz8FiVOlWTCApMmwjgWkOf4FYnwpirsb9LrSDiA
	nxQI+UJT5GFL9GnKsW+MyPGYHTKEy9EvUopMwYlIjPrULqcgdOdvqgSSFBlEOue6
	ZiO8XdxlsrF4G1pMJQ8T66CTXozSCVEnRfWBZdS/H7tVPa6u/SI6BNiTgiq8lIVr
	0VbO5ZLmkivs5+lAjcAPbpI/sYFVFDPVqTtTK+16QlF6zcHCa2A6eYNCV0w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2uu3h4tm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 18:10:37 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81ed3e6b917so3929990b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 02 Feb 2026 10:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770055836; x=1770660636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbpTgWXazdOAfAdL49uExcjxZu696DCuIHbDLPHFMMY=;
        b=Dbx1PYteGR6wo5l4svG1lRs0cfZ9ouQ9uXnMHju/wXTTyFYEJFN3ktS3iFG8Gl61a/
         ciWK3Zly2xWniEKgkh4re8GkpoaVZK1ySrMJVj68HBGRtE6YVv5fvmzsauUBdmofZJqd
         waP/Srk7iGFedQCJ1Sd/ozMOrhTk2FIeDWFWn99fnMTJXeVCtnz8DxGoH4mJDWMdSQiG
         mtUH2xBYlHLPrLJYRn0+33f8P6u2ejf9xSLX7vfVFVTyCubYucWSzq1S4fZm9xzxW00N
         e6FPpOkkWhw//DQ01CyMLUqeLuBxsFddXUMHvHpgQ2EsSdz1dqGenRBcZsAfwH+4w7Vx
         A/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055836; x=1770660636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbpTgWXazdOAfAdL49uExcjxZu696DCuIHbDLPHFMMY=;
        b=r4kIX6RLW/fulRLYQA8L5yLYbOvrVS/OBOFdjwZpUbCsEu79afM4PROy98Rvxr+zs6
         vQG2RHhMxgJ7gf4YK+TBmfVE93qQm2QQepda7PU5M0u6Jtk+6FDXldRJ0OXsvUzZUfs7
         f40zZUdFY5QSJoB5Rgt5u3MYIIp6PWq2EFMw+tw/JBZDedsyADNfDboKsuy4PJUoHChH
         Q/iZAyeK1vwghgOfbIWA4VflyNala8aOwKm/vWbpy1fnM7QUfXvXWD2YJAoh4vHOZDPH
         potHsYK9E672ELV/KIxu9qUSEFz0qqevp6H5Bq44eZ0FEh9P0UzXRv5Px3++C83GJdj5
         SKhg==
X-Forwarded-Encrypted: i=1; AJvYcCUC2PWslL7mTGCYrfW9CMZzdSpOFeLofeUr5rFvvLtvR6gGehVilkvKDR5TGXoggtOfZWD1UYuX7jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7O2V2jneNmnYXhN8F/oUz9BuVvqNvTr3krUqpnMh2pkPQ0Cg
	lJUXzHKId5/f79vHnD4ZwJqTf6EfJsC9s35lV63j9FAZCaobCcD98hBKGyB+nUPvovTnPASG7/n
	G0DH8kmEYAjvsuQyABZY8llikC4NT6Tc/2A7YFdKWKMAAxLMFINcMEGS5n6c2Y1M=
X-Gm-Gg: AZuq6aIXuxyRPsc2fL3zEsfo0jWmr+6zlLVU1gbGGjFXxRnoI2nXdZ00O8/RNmSnCGm
	zBd4t0iP7lY4L9HAjNrVC9GdD9lJi9MDOLrbBcWE/cU/n2YQUJxdFk6BGn/YsPo5nI1Tv2pBEvu
	cyY38kOWooJMLrq42ZGQm1MR4xz1l4CSauDzzt13KByPKKvxWENWgQMBTSDwY5NisZxZBPN9q5D
	PlY1Iz9nZpLz2D3ZbfPIH+aj8SD4b3JD7hnRCX1x6aU88PclCBT9hTj+IDGl8vtGFQHas7aU7ao
	wapVEU8Cr7oqZL0X+B2sMBFbbsXllsaxGa9GVgZ1E0S7lJIGKSi2RycAvNMFXSXL/rgJ0daqGBh
	DoaHsvv33iqYOjUI/MVkfJUu0O+fMYy8Zl4iUgdDGC20=
X-Received: by 2002:a05:6a00:94f3:b0:7e8:4398:b360 with SMTP id d2e1a72fcca58-823ab748f55mr12083560b3a.51.1770055836408;
        Mon, 02 Feb 2026 10:10:36 -0800 (PST)
X-Received: by 2002:a05:6a00:94f3:b0:7e8:4398:b360 with SMTP id d2e1a72fcca58-823ab748f55mr12083520b3a.51.1770055835816;
        Mon, 02 Feb 2026 10:10:35 -0800 (PST)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm17476780b3a.40.2026.02.02.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:10:35 -0800 (PST)
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
Cc: prasad.sodagudi@oss.qualcomm.com, quic_vtanuku@quicinc.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
Subject: [PATCH v4 08/13] dt-bindings: i2c: Describe SA8255p
Date: Mon,  2 Feb 2026 23:39:17 +0530
Message-Id: <20260202180922.1692428-9-praveen.talari@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
References: <20260202180922.1692428-1-praveen.talari@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QK6dluB6p-PcyCfrqVBmDQV0CQsh5ZZE
X-Authority-Analysis: v=2.4 cv=OrRCCi/t c=1 sm=1 tr=0 ts=6980e89d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=apMzWF-kzHp83YoYYzAA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: QK6dluB6p-PcyCfrqVBmDQV0CQsh5ZZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MiBTYWx0ZWRfX8GG5TeFrn6JF
 G1UPR473COJhPjF/amrEsXkpuKq8rlEHe2QF2qKhfVwjpEaCKIeYafrsG1mlJ6lisfj4BUivqhP
 5ZORAWIj2/Asi2tBXEMWjWeULQ7sY/bKWSTLwwS4FAS4lSNHnTJaVbWMteDxMDaeAzRqau9g8/g
 gIm5ayi6IiV23NzBzAzXsKM6SHUUdqNSvnZ6bqF7vEKBgMbuaBEzjGXy+kHwM/9GGexLyp11twS
 H8+jzqkNdHlgoUnty83x1f81wNQ1B/IvMdR95XG4n+cEH+/25KEysfwhl41Qd2qMv5lEpP12dZs
 BBWemRzZ5RgRSx4BLtSaePmcojNZUKEtFOEkjI+TTqU+1Sdo3bmsjQ6Im4ZPRoH3vZFB1K8S5X5
 X2JpdelfubF+tRSPubTZH9Sy3CgRqcc4eWPG+NJt41njIn6oL8cOjypn0lcvVSQADBA1xatsDpq
 0yYdENt/meIzhBpl88Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020142

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

