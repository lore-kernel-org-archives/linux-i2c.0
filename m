Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5533EDE7E
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065495; cv=none; b=oYhPbQTMF9EPv7WLSxLVZFrBLcEN+euU/DeAVwcIGLv5BrHhWFKQ9chgpl7ZiJoIghpypCoPt6Z4vjyLZks48vY7Qg+a6fgfvKPAOK0qZLCyq6LGTAW2F7QVWQdwM9IeBNjg1CQDQ7bwQvRuo7h2T9atvuiraPzhB6lbNm8ppUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065495; c=relaxed/simple;
	bh=9lEkBuKZtL7T3fUi7MQIaCyOwfBBNHf6ISwkYn2IzAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FvuW9IwKLQWnKlPIUec2t1bf0K8R0GMaVaugFPCvi7ppC1anBKp4y9F+cqCb7ehvftVDwYBCFuopRgdxanOTkrRrqs9G0Wx5ZCewWqB348JTkrx8gBulgdGRJXtqHKi6Wt2IgwlDgko/1EsOh78ArgPCKgaDdrjLpERPPsRvvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=btev+3wF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gt1YkOR8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="btev+3wF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gt1YkOR8"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDKnj21202015
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OhfLTkCRHJqRMZYe79jrqm1oJVre0tLq/Pdp8JbAs4g=; b=btev+3wF7m3pLyLC
	kPazX6StDaBQzzWOT3WEnIwyO/+Telo9/FiK1rpPNJOGZfpoQgr9KqlbKj72xMIT
	6YZMsnJzpcVJzTKV4sts8ErybJhB9/Ov/nIS1IIuB7YKXGJkW+LTpl20cpIt3dlZ
	yu8VnHFJta7x/ulvDrYVLCOrx9j+L8br7eNxKbiO8uR/RdkQoNSX5AqK4dM1K3lN
	Bg+ReEdjhv7iOap5McmhRDhYDzjjpScyZr/f46D5yYJuAX4UxoXjXY9UJHJETD1K
	zh6xZAbXu0QuxBvMX3Dti24Pg1p8C/POmpItYa0qoe6i1UEk9JLTVeDWS3Ggckyu
	37RJtQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te2d9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:38:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bce224720d8so7180891a12.1
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065493; x=1780670293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OhfLTkCRHJqRMZYe79jrqm1oJVre0tLq/Pdp8JbAs4g=;
        b=Gt1YkOR8bMX9sDO/FCmiLSHggUfjNrnTYH7iuSpJpSCM/nM4J8sM2zaC92ixSH800p
         cTBYyfVJF+/kfih5S77l3E2w9h2T+FCZbywFjhFcodUcyzrQ7Oym8RbMzO2OEOFR0VU2
         DgSbP4rPqh1VSK0xqNKRZ/CNyoBaE1cm7fcEkZJoNxr7h6ijAxOQBCoMtGsLRYaF9SpN
         sP764y92+pbt8JSKDppVU5YORKKFPybmUOkmKqrsBuI7ttpKoVjy0NrHBZM27Qk1A3E9
         n+kyqSWCcBCPnC8f+k0T6yFGeAFK/uxwrIU8ujwuSnXHAN6gcXQc0tkG7VWDFMyF6zxQ
         Oyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065493; x=1780670293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhfLTkCRHJqRMZYe79jrqm1oJVre0tLq/Pdp8JbAs4g=;
        b=gu9qsA4qEESRb5/NxUVgfhNhPLDMohJzn2IhxM644Y2agElMH7zqORmPCqhPALyfAr
         MrX4QcmUXhEPdWQ0c0BWTddzD/wNFODcPckJpV1HLntdJndri3HcHNQqQQGYaKtSp+Cl
         v6WCZnzUDlaWOUSPEVAFAMpez4CPxcW/QvPk0JYWkjHH/PqhYNaz8iGQW0nIOBZsxPa3
         oZpJaYAvycjqk4nQQACw3JH2zh1HydoSy7NuZrSmiran/J9u4RQXa698qAZq7LKLxnxM
         KA4ioCN765XpBjqPlL23Q7xaKMUNhHBPpVeSrsW6yKhe20JvF+N10jlMjxX3shlhz0LN
         2RMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UibXKmb+HV5NHO2wy0Pm0NCaixwl+W2pw0OdWQvcRxBn6nxXa1HgVrsQ+UP97YLymFH1OLHVxejE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2AcvEp+gcBSZiamSTPQUqP4QPQMDLC1BFNmGGPNQyDN30B6x
	Y/Romdus6fyYPavccXgSpHJYsORX49bcCtMapiCYRMUAYKqQGuM6qbDKnSYhe2JPczNWygxrNad
	1teBQ7wGC6gTqJNRHm66VykKT1U3uUaz7/H9gpwM4QS8MBwVQ9+JhF3LNEHSXzfs=
X-Gm-Gg: Acq92OEoC6ZdYpVcWPYnxhwRxv31blgP0a3si/74lIuILPH2XsgdM1bQf7rkMJwzcFh
	FnIAqSBc1iff2MRJpuXbtQaLyMcF6eiwVBGs4IUyKmJ/lBUnDAbZfQFZ+Uz8aswzgjwqWSxPh8q
	0w+OV1Z7t30X6sBttXmoNymwBI0GdcxZ9hcTM7BdGOGC8lYz9pNQtNJ/pFQijGQmwS1r2aZoqCT
	Nm3aySIck25LeVvVCVTwpApalkbu9l3S/mHPCVGXrR3Rz1fZ0S1kv0jY2s+se/ogsF52cX0WVQ1
	L0uDWbiZNtG+gS1RjSZwDWtnSFP82C6B007IlaFsvMVOSmFC4flFM+IP6B4/dolL1p+87w/eVvM
	SSgpcDF8gmcQhvNIV72epCGEJt+/KdGTGVV9InQDjxP08cZOdGjLa7N5Ev/DQPJhREw==
X-Received: by 2002:a05:6a21:7a4c:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3b411be480fmr3690411637.2.1780065492587;
        Fri, 29 May 2026 07:38:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a4c:b0:3a0:b781:4c8b with SMTP id adf61e73a8af0-3b411be480fmr3690352637.2.1780065492079;
        Fri, 29 May 2026 07:38:12 -0700 (PDT)
Received: from hu-vikramsa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm2469394a12.15.2026.05.29.07.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:38:11 -0700 (PDT)
From: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Date: Fri, 29 May 2026 20:07:24 +0530
Subject: [PATCH 4/6] media: qcom: camss: Add CSIPHY support for Glymur
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-glymur_camss-v1-4-bee535396d22@oss.qualcomm.com>
References: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
In-Reply-To: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780065463; l=3341;
 i=vikram.sharma@oss.qualcomm.com; s=20240628; h=from:subject:message-id;
 bh=ThwUpqoqpxggiYDM26CYveGVee9nWCp1GcaenJjTqA4=;
 b=2WI/R7mQuiKUcwOVOQrM3kzK9msV96N2o1X7AY5tlaFYdFqhPYZ/nHgc696IHGFZp8l1L37jj
 0piNurIlbToAs7LkT1I4q7Q8dJ2Xxt+0gDochIFsla4V+jSAqXxrJHs
X-Developer-Key: i=vikram.sharma@oss.qualcomm.com; a=ed25519;
 pk=vQBkwZr1Hv+VXogAyTAu7AEx8/6bvkOmgrzYFbNGCDI=
X-Proofpoint-ORIG-GUID: LAxc19tRAsH_XFAwTA0t6aG11N810gUK
X-Proofpoint-GUID: LAxc19tRAsH_XFAwTA0t6aG11N810gUK
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a19a4d5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=slCHJDK8HlXwqJ58Y7EA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NCBTYWx0ZWRfX6eFHVPaYdu6c
 lARmGIqXvZ2hot5Kn83LLXRBnhJebDTFnur4uF9j7jtbUwHbQoRVzeHxKF/oigwf7ttijNQ1Ck0
 syg621VI6SO6fTU34Csj84+8ygcT0k1IMEmrnqAEII1DjisRqNa58stRHr1ep9f+is63d6wPl/X
 lCJV04P8lZ+ef0ujWjq7EdSYkcDZYLZM/f9nrPPbfP52g3bntW2U8qeWZ7j6k4M56pcQE6AoqPm
 9VigScG2LZpBwDj3U+E55yxmcu2hgGbmMbAHvxvtjr8OpcPyN7HbpUJ3E+LAdGKkU/sO+cESu5U
 gbISYoei5QmtBj5Igd1UgLwlDqALgTwzqS9OqRC0gff9XJJZD0VxlgtJUO+p0cCZ/zH/aT6haQ9
 U36nAawMdgq6qQjBEiZ/tYLruFrjTNRJnyDrntYAxtoi7a8fg/c8FPAE1hddUhmWwRsKMotlN0q
 +Ttla1mbon75n3Of53g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290144

From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>

Glymur uses the same CSIPHY hardware version as x1e80100. The only
difference between the two platforms is the number of CSIPHY instances.
x1e80100 has four, while Glymur has three.

Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
---
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |  2 +
 drivers/media/platform/qcom/camss/camss.c          | 54 ++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index dac8d2ecf799..c6d8531bce58 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -1140,6 +1140,7 @@ static bool csiphy_is_gen2(u32 version)
 	case CAMSS_8550:
 	case CAMSS_8650:
 	case CAMSS_8775P:
+	case CAMSS_GLYMUR:
 	case CAMSS_X1E80100:
 		ret = true;
 		break;
@@ -1239,6 +1240,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
 		regs->lane_regs = &lane_regs_sc8280xp[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_sc8280xp);
 		break;
+	case CAMSS_GLYMUR:
 	case CAMSS_X1E80100:
 		regs->lane_regs = &lane_regs_x1e80100[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_x1e80100);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c6276d746352..864e16e999e3 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4536,6 +4536,60 @@ static const struct resources_wrapper csid_wrapper_res_x1e80100 = {
 	.reg = "csid_wrapper",
 };
 
+static const struct camss_subdev_resources csiphy_res_glymur[] = {
+	/* CSIPHY0 */
+	{
+		.regulators = {
+			{ .supply = "vdd-csiphy-0p8", .init_load_uA = 105000 },
+			{ .supply = "vdd-csiphy-1p2", .init_load_uA = 58900 }
+		},
+		.clock = { "csiphy0", "csiphy0_timer" },
+		.clock_rate = { { 300000000, 400000000, 480000000 },
+				{ 266666667, 400000000 } },
+		.reg = { "csiphy0" },
+		.interrupt = { "csiphy0" },
+		.csiphy = {
+			.id = 0,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		},
+	},
+	/* CSIPHY1 */
+	{
+		.regulators = {
+			{ .supply = "vdd-csiphy-0p8", .init_load_uA = 105000 },
+			{ .supply = "vdd-csiphy-1p2", .init_load_uA = 58900 }
+		},
+		.clock = { "csiphy1", "csiphy1_timer" },
+		.clock_rate = { { 300000000, 400000000, 480000000 },
+				{ 266666667, 400000000 } },
+		.reg = { "csiphy1" },
+		.interrupt = { "csiphy1" },
+		.csiphy = {
+			.id = 1,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		},
+	},
+	/* CSIPHY4 */
+	{
+		.regulators = {
+			{ .supply = "vdd-csiphy-0p8", .init_load_uA = 105000 },
+			{ .supply = "vdd-csiphy-1p2", .init_load_uA = 58900 }
+		},
+		.clock = { "csiphy4", "csiphy4_timer" },
+		.clock_rate = { { 300000000, 400000000, 480000000 },
+				{ 266666667, 400000000 } },
+		.reg = { "csiphy4" },
+		.interrupt = { "csiphy4" },
+		.csiphy = {
+			.id = 4,
+			.hw_ops = &csiphy_ops_3ph_1_0,
+			.formats = &csiphy_formats_sdm845
+		},
+	},
+};
+
 /*
  * camss_add_clock_margin - Add margin to clock frequency rate
  * @rate: Clock frequency rate

-- 
2.43.0

