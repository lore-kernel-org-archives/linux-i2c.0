Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB19480DE0;
	Thu, 13 Aug 2026 14:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629699; cv=none; b=fr1VbKzSwFvvgWIqPjPubPC51cIRXIoGprxlTHGfs/JQPNYk0N3Y7MZgv2qLC0oG0BerayYrKjpVfp2zJuheSKlQh8FkiljYGlzi6964VWA4zgEUQRM1KPHxtsTa4fRqvTJLoNSEnEe4hgI3vWmGSbm6XOHmmNXXZOfbL8V01p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629699; c=relaxed/simple;
	bh=6bQCbcIY+Asx/0DnCv5CXfqby5VEXYj0Uiz/RsRGhQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3L6VEePwb/97w3GoWTnkU8W0yMil+8a3jjUS8fXavrMKzAhE0dytArapHkz44PRaGjJs57VL0lqJx8zn1JqCkyYR8n1QMbmOriWXXqk0D/uXhIt7Q6EtW8H7t9NBPTJlor5gcncMd7/ne4xByh/ZZiIKkHg2ok3zHkreL459+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BcdG2awX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BcdG2awX"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCJhMd2359289;
	Thu, 13 Aug 2026 14:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pZoyey6z+gl
	rWL/OFOqkRTCq+cb8aKTyCA2INl2lfDs=; b=BcdG2awX6rKdXOlCIFqSIpAa6xu
	1hPiJozfj8GyhqnthjCiSMWdEKRjLpJalQWJI97rS+3HsiqE3/SwPwcZCnVBv8P/
	P/hzRwYyH5GYaBcpmSuNt42ReRCQKA1a+FjdVKkb4k/dnravNSRXrs+COD3BmUy8
	8dsESng+v2vdNV7++r4okn29Y+yQbtz+AxL4JPd6HafYUyT4dbA6Y5XAoOxMytp9
	hSzLNU2oZovk7ii5vDZERo+cVQIVBTbiDWHbFlm+QAj25J4OjpAqZb/9ubabLG67
	voqjuc7YuA2pLsgbefMq1M1punHcLeRMbqRPkfxqKy0hZQLhrss3t+GVnsA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1cb5gsmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:31 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DE1INk008730;
	Thu, 13 Aug 2026 14:01:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g0bs34pup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:28 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67DE1Sr3008777;
	Thu, 13 Aug 2026 14:01:28 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 67DE1SMF008775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:28 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 2A0F3220EC; Thu, 13 Aug 2026 19:31:27 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        brgl@kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v9 1/4] dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller support
Date: Thu, 13 Aug 2026 19:30:40 +0530
Message-ID: <20260813140047.1006478-2-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: ENDjdY2AjA4o9xIderucaTdFXNUvwHhg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX12POw1OeW3nr
 d1KX5NyydVjd+ITmlpg94TEEyEqVm2BYnb8QU2MfZI11p+tuOUoh+hYovcMULsYroiqjtdik3sG
 sHTcvlTWWIhn+lOd0qUOL6hICRwJ0hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX1Ep5/PPEu2NS
 2izc05XaoNMFwvuO3WST17YW5rAWdTC37oGYaVMggRr6y40b/prByE469ix/b0yzHRjie5aGxoq
 gZkgERJ25Lmtpg4cm0XzkCTjqZdhZAHupBEYM9AVj30wJwNO/uMjnQQHcVLiTz4T9vW6FYJUtoN
 COlguXdkTLiRWv6K499xNPxxDHbk4KFBQ1cyJ60+c4g3MkZ+1Zr1oZNaPrP6P4krnit4X1NJi6Y
 SAuR58pmGEpg8YtuvGLnZdCzmjtk2o5RyVRKTLU1XnboaTD3A6tI1/ws8wLEGH6tN9U+gNfi86v
 CZAqPdW4qAh5JD246TpaaKRVO/UcZDS9AL9Fd7tdegRgkkQwkjk9pqeCswZUWPC9oiHMN1s/OR2
 USSq7cJsTGfaVaAQHhwxVvgW/ga3I4JYd82ilcICEh/zcg1Cgplw5R3w2/EEvdY2vmhW/pavvvF
 Si7MK6O0h1+UKAMcUHg==
X-Authority-Analysis: v=2.4 cv=GoNyPE1C c=1 sm=1 tr=0 ts=6a7dce3c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yG_STSell-aZfaz4LqIA:9
X-Proofpoint-GUID: ENDjdY2AjA4o9xIderucaTdFXNUvwHhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130100

Document a DeviceTree property to describe QUP-based I2C controllers that
are shared with one or more other system processors.

On some Qualcomm platforms, a QUP-based I2C controller may be accessed by
multiple system processors (for example, APPS and DSP). In such
configurations, the operating system must not assume exclusive ownership
of the controller or its associated hardware resources.

The new qcom,qup-multi-owner property indicates that the controller is
externally shared and that the operating system must avoid operations
which rely on sole control of the hardware.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 51534953a69c..ed9b029603fd 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -60,6 +60,22 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,qup-multi-owner:
+    type: boolean
+    description:
+      Indicates that the QUP-based controller is shared with one or more
+      other system processors and must not be assumed to have exclusive
+      ownership by the operating system.
+
+      The associated GPIOs must not be reconfigured into a sleep state
+      during runtime suspend, as doing so may disrupt transactions
+      initiated by another owner of the controller.
+
+      Each owner is responsible for maintaining any resource votes
+      required for operation of the shared controller (for example clocks,
+      power domains, interconnect bandwidth, or other platform-specific
+      resources)
+
   reg:
     maxItems: 1
 
-- 
2.43.0

