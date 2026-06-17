Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1233A029
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781671846; cv=none; b=by/Qebn9GJ/RHp1jooXeTVOCOogPzVE6QetMK1N4aVo+eyeXFsa+1iQ59HFvUpSa3jLx7bw6K5PvNb6hXd22+9r98H7XOrIjtgbByojiM0RnHAzaXmVcple5eHrOfGPQzD0/Oja9c5gRDmaWYS3QZllnIRsPRlyM7dmTJEriKRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781671846; c=relaxed/simple;
	bh=1U79tpuM4ZCInjzjfpqkfXwFv1yu+UyNvhAWxEVHcg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiEYsNnZysE5254jOyDMVmeSZgNCCgvZ3Q1r8gEANWsnjWFY+h2Vtn1n53F4nVHpNXE2v6kSh1moIn1gzAAqAzZdYOcot1Xa8pl72TxQfCCacVrZzrK1cFryxztRtZMAxUKS4Poi5NY3Qm7KIGcf5+Ir+VIeLd8P31n8gBhm6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M5dUP+8t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dOsMK26w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M5dUP+8t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOsMK26w"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLTcYd249141
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Q3orq+Pmz/vzt6D2bgZpv8WUE6yDRouML55RTJqYNk=; b=M5dUP+8tyG7lphOB
	YqCQRrayp4Yav9sRLoiRRsocpeb/ivDZjRoN4JGVmJ0CeFDPNZNIhT7G3DcmhfVg
	LlrUDUdq2rPQzU+6xEg2fFc9S9W7NTGpEgiVdsNfA/f/tka4MNldQuy1GcYuN1+v
	eIcqTuT0X7rB8qPPUbS+lOtxqVx4xrM842WnaI64+bpR0VrkeXGl/pP1fxLMIJvb
	DxFI+wOeYtLyWgve5dFU3K5GW7vQnBTWY8QIYg+hrEhloOvLcG8xDzySzyv3XUXq
	/RtonqlQbiXtWwoKurepHpThUH2h+yoGQdLtyI/CrEu+YUC91p+KQM7KHj7mKBpn
	FLrTwQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueet1aub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 17 Jun 2026 04:50:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso6178630b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jun 2026 21:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781671841; x=1782276641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Q3orq+Pmz/vzt6D2bgZpv8WUE6yDRouML55RTJqYNk=;
        b=dOsMK26wTcPqJN2nR3J+hAMS08IUSVaAx3ScNAQZ8HncUrkUxaVpjzDwEiPegEVEYx
         4EpEHDF8QJnSIYUHY0M866I+8/w4Cw3I+eJDgUvQUWDYRmD8Agdw/K18euK6GN+mVlwK
         0S+fHJ5URXjQQbcNWT71Soh0ybErWZrpMLDp6+rKMsYehHlUhAzSmdaEdiqHtU6LCpOG
         gtmW9vdY7yvFstz6vPWaBIhIL83ws/tkccjICJPABSnsxMEIICLfvQUt/dxwtNVW9VQd
         goh1EGjCgLny/vJZeCD0Ld7TFjxw5EtcNk8b9Hw+xWmF2/lvUBtGDRgcGpOoNkWrOK0a
         J0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781671841; x=1782276641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Q3orq+Pmz/vzt6D2bgZpv8WUE6yDRouML55RTJqYNk=;
        b=XXs9tTTV/DW5QquAZiw2Ui4J/awabMBwLcT1NIcelCpvQYX32gfY3POW4cd/8aRpIf
         eoEIFMr8ePywlhSbQ02wwevR7dpxhJ73HegPEKU9pJ7sXyK6M6m2KJvtBTYpL16Rhk5Q
         F+/WiuuZcU9tZIiaTLjJ+XE/wWUfe8C1Zg6Q4P27xkRZjbjEp61NBGdn7rkDuhnTLMrx
         bDWLDqg2fiEBLXxh4R7kTRKpFHTvExHpWwcnY/n/EMMho7FFArD77QRxiMQq0f+YgS3x
         4pcV9FgLZ8L9MW6uOa6xq2TQymomzv+1vMelmLaoEJbYNwKyqmzRZWq6vByAdxvnjskX
         pUyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YoK1tA+Mpmf4lHAHRxqjA3Eca0S+UzCHmdQy5BD4ngOYw5cWBGQ+THDZB7AAFJZ9o++1Ww6zLTDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65PNLa0ATlk/9PisU99Z8ajNpmW/guD5vX5nQZF86yIkfn5ts
	ApQaannsyHf7dT3XA6cgCuf2yIybrmlQqfvhiFMUDDgt2D2bEQy4kNZ9g6w5Q/Tntn5SQkbR8y0
	+N9Lzirv/UExFinenB2FhByvaOnQXVzudYdS2CqHj/EjUrQ9qfn04/4w6a6wRrU0=
X-Gm-Gg: Acq92OE+akYY6fvZ0jEtvEYCPIydkw4CFETowgDrI0eLQ87vSd1tdXTe1BSv2cpYbME
	PWyc7d+lLlQuDTFCf3xS2dP7SFpoW5XaErLuzmAtG7L5cwAAefsYBaCBkriocGgyFhvgMXA/d5I
	CJdV/lbTf9n6CSB6Plyx0+fMYGDDUz2NePKTC5W0sIZtQ3MQXPjhjAR2MNr2KI8txkBW4eBTW93
	ua6RSd/MCdgHLwdSGpbJcnLjXzOaZn5udBZUpuD+5W6PgYVRR8t5BDCisL9SOED9xLhGKTmFHgJ
	K8vq4vb0X7aeHG7MJOfBWcuKqxZgZR12mzN8O6702goZDVh5vqkBK65VdbuAtdZb1Pe+Fkn6Y5k
	UT7D/UbHyXSoc2yFUxjcb+Be7nmh/uFAubJJmlu0YgqKN
X-Received: by 2002:a05:6a00:3d4b:b0:842:80c5:c425 with SMTP id d2e1a72fcca58-84524569afemr2216759b3a.35.1781671841073;
        Tue, 16 Jun 2026 21:50:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d4b:b0:842:80c5:c425 with SMTP id d2e1a72fcca58-84524569afemr2216713b3a.35.1781671840558;
        Tue, 16 Jun 2026 21:50:40 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c016sm14721127b3a.8.2026.06.16.21.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 21:50:40 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 10:20:15 +0530
Subject: [PATCH v7 1/6] dt-bindings: i2c: Describe SA8255p
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-enable-i2c-on-sa8255p-v7-1-ad736dbeab57@oss.qualcomm.com>
References: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
In-Reply-To: <20260617-enable-i2c-on-sa8255p-v7-0-ad736dbeab57@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        prasad.sodagudi@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nikunj Kela <quic_nkela@quicinc.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781671828; l=2715;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=1U79tpuM4ZCInjzjfpqkfXwFv1yu+UyNvhAWxEVHcg4=;
 b=HLl7kNKNz6/ItrAtFz7MOBiAdXKbbVW/7jPVsy66FAMZ+wWyPHvHg1c7/VlT87BZQNfwAL/0Q
 c3mg+oSzMyMAgrUMFY7HjTGbn8TV+TLeK4+nAdX75T2E3VMV+bmPCHk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: P4hfarUVpipXy1KOqqfC92Vh50Ju8hnM
X-Authority-Analysis: v=2.4 cv=JufBas4C c=1 sm=1 tr=0 ts=6a3227a1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=apMzWF-kzHp83YoYYzAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: P4hfarUVpipXy1KOqqfC92Vh50Ju8hnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX4Xe7wo6J75O4
 xxILal40C5oagOcyAMgRHgDijXJWaHOaacSV1WcqYushb77cepfY93G3LirMNHjAfcdUS7RmXu9
 8ADAWf2hx9lvzNnIXcGwIv5UzoiXtlXy8Hsnl/BhBE7MmVmX6CE+QlnElyg4QS1tE8rbGF6q5Ma
 CPyhJQ3oB8xpu3DGLiaJjpyBKlqBnyaBicH43eAELsk7aZG1VLmzNMUsMjf9V25hsXNjjR0PuU6
 GTRct4c5ksO2U4FGhRQZaB9l2riqf8zzq2+SORQEDgBaA2ie71iiiOvtgHw5+wTq9Ef5rRrKw1S
 jstY7WvPaDgk06p9XTJmwkuvjqIiAaqJXgg7DEqErnwPq1HNjLUZEgSo/O8Qu70MOe28EMDshBh
 I70PWkQOcl9cBWJwwTnAf/eVpH6L4gEYzbIEtma1tuuIXYgPV/DwGLy9ciLh7nuQfOjqTn0dXHg
 drhrZu1xAK+7ynosKVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA0MSBTYWx0ZWRfX6jkHKvyAwIP5
 GB46+9o2dK2jmggPffhejEN7xsOoTUzi+pEEEeTwBcsopclRUnFHVBJXhHu8mQxmEIy1jtD8+dl
 T549Klkmv2CiD1Mlbdcj8WSCOfK73to=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170041

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
 .../bindings/i2c/qcom,sa8255p-geni-i2c.yaml        | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

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

