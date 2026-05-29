Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A53AFAEA
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065473; cv=none; b=SIUfcEeSl3zc0n3/hyRTSYkvKXkm0RHFUeBfo4u/Z2Oe49PS6352wLM7VKDj54hd4FHokMCitz3+FLtFJeGId5M5CMwPJ0DJN3FcPCqy5fgiTRP52OGgtKbHbtPLiEA7Tw9mihNjj0Iz/qLqrcJW14wIGOXVNT/2AHHF/I/SHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065473; c=relaxed/simple;
	bh=xrNSSChXSP6Dhgp1oFPSGJ7x8cfUiKmSoXkmQclw/u8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NO+gOdt1QL+l0MDqjLUT1WROr/HrnFO4JmsF9SwZzr1dmTGLSY/VttuR8XQ5+GVNJ2VbYOVqtjLMHZwe3PBFSSc0tUubuNKC8stvb2xR5G04sFF7Tu7ZBG5KM+uBLCnPXM++OehiQhcTfyvQg+5O9B6KmK14b46+2OJVTHcFBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZ5gxadG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U5lGPXlI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZ5gxadG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U5lGPXlI"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TDLBnO3656473
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NilxEkXlNSGx9SvphPrCyq
	fQL0cQzhwyxwBlG6uCIic=; b=lZ5gxadG62vuJGFf+AiMTQFAewQvkdU2G3+0RA
	7Msa/TX16tZa0C+d8L7WGJEHQX8xOEoYY+07s+3zFhAI+QG0bRWBrxTxTpI/YlPn
	QL8jxku3gY/+DWoS5I2XOafdJgFLJYtJW63cMhIdVywWQjpYqgohle5lvoi3E5E+
	mP0zsu+tO3ooUd+Y5mPVpdTtC6f+iuNd2IPXApGswXZGbs97fQByW9OPvieXp6Nz
	5gpMXJJjyLJ3beaigwwDRae5cIZAuQDmKZ4YJecU2heRP/9pC+z7gw+4GuWcEskJ
	I7iNpbypgmVfe4h+UnHTTOnrDC5Wy0tQ6/5SiUb8Qqg9S/OQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5vpey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 14:37:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c827bda2e60so8266103a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 29 May 2026 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780065470; x=1780670270; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NilxEkXlNSGx9SvphPrCyqfQL0cQzhwyxwBlG6uCIic=;
        b=U5lGPXlIiXl73f8KmMpq8FsPioIRsHUVsyhwbFqjOa118i6SneXKfv7I5KvCxSKnPP
         xH/sQ7/DBfWJ8eNdYE4oIgqLNn3s6s80CWqKOF716vChyTR9ChbhcAN4sdhrZr79yhE9
         cixA97qrrtUvhu/Rqk/55bzYiVHznqDjFsWZ8G6FO94gQa/V1WMHR6vqGuuCW4apGHVl
         UyddvmUwiEkgofV8ZR8fHI06G+u9l1efGH7G3hO1G2HquKnUgrJ02FRroi1oGJBK9+wo
         dzGvBEBcYSFQLqf+w7RJhuC6Cw+29xVxhZYQuJCNRhe3VIXZBb4IMvCnT4hOASsq/DJ7
         Bn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065470; x=1780670270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NilxEkXlNSGx9SvphPrCyqfQL0cQzhwyxwBlG6uCIic=;
        b=REBSKmm72Fuq4rsq4k80Dr6ElMiDMILqqs8sCpCSmoLT8qiV2hqUWjHA9TgMZn1jW4
         Gjut0SiLMP9nizu1hHgefMeedVA62JGI6ghSTvAbCo+CM+E6Uvb0iznw8UiGXL9fT7mz
         MBgWTTtDU4eQ63MAdWDI8dSfQc+bLxD+GyDWa10k4sbx0ExNWXDJjFimDHsNw7j0ESkB
         mo38gAUvkIibzZtLE8jkJnQqytw5hxXgMzJ+xb/zMV1dTMDzMdgR351uqUryfePaxtYT
         96qFNfth+yLaam66JQJyiQJDMVJaR4a4hug1WZxDQrl+UJhSQMY1Ot2k0hW6wt3uTZ/H
         WQqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kD6fCs4VOYbO3IBxaNeXPDjW3BNtwYd5OAclMDaCyWfBMOn6pOKZYEb6pylmAjsjMk5ayFQoIaJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOPhLPrsXZlsP95FlzPBqySCxr9lcYaQE3mknKRywle/aJlLob
	BKoy0Mn2C6FTwhgs6w2ZWI29TdCXS2VukXkyvxr23FUaRYtYNeCif56+pdSpgmCXeF+qyrnpTom
	scTOfHtQnq1GlwwIEPL9CdjsnXzmKOUQAtq0F3CzOxqCdI7PqRdH6pOt9WfPy6b0=
X-Gm-Gg: Acq92OHlIueWMTXwVV6qPQ8mSGdjsITwGRpVUH7AOGjxnxDmaMwAhEh3yttwVqakULj
	4Ek0Lpoy+bqVdDy0feXDzXPbQ7ejh1y2lgAPyse3uhxn2i5bdts5tMq2xNlarMH049G1BxX61X+
	xSb1XAqDjyGeLp+fVbcakCsT0K32uXYZKr8rpJi0MxElkvleD/ypjmrVG/AzxehG6JuTWrdn64E
	usY4k3rSouuSw8aGqlcNR8zVpZcMsaRBX+aiSWA2pTCTIiia6dVUSA7sMMgStH2R7zwKWMBwV8x
	0HkaZX5teCzeBumrff9GD+PDYWH9uJgw6YQWCL7nY0YV/Eq5ACQWADbx0a9RvlqouvgIMFl5yjq
	BoTAIrxqhg+9yKLO7/ZHnAdmgquPSkYLQ3AJwSzJJbFlL2oksaAmUrMPe2s94Ej5yhg==
X-Received: by 2002:a05:6a20:a11f:b0:3a0:b65a:5def with SMTP id adf61e73a8af0-3b411e16d64mr3925735637.33.1780065470083;
        Fri, 29 May 2026 07:37:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11f:b0:3a0:b65a:5def with SMTP id adf61e73a8af0-3b411e16d64mr3925653637.33.1780065469345;
        Fri, 29 May 2026 07:37:49 -0700 (PDT)
Received: from hu-vikramsa-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85772993c9sm2469394a12.15.2026.05.29.07.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:37:48 -0700 (PDT)
From: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Subject: [PATCH 0/6] Add CAMSS support for Qualcomm Glymur
Date: Fri, 29 May 2026 20:07:20 +0530
Message-Id: <20260529-glymur_camss-v1-0-bee535396d22@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKCkGWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNL3fScytzSovjkxNziYl0j88Q0c8MkwxTjFGMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAU/Pe0nAAAAA=
X-Change-ID: 20260529-glymur_camss-27af71b1d3d3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780065463; l=1891;
 i=vikram.sharma@oss.qualcomm.com; s=20240628; h=from:subject:message-id;
 bh=xrNSSChXSP6Dhgp1oFPSGJ7x8cfUiKmSoXkmQclw/u8=;
 b=lYpv+FN0QQXW4OV2NsfgGPreJxBFObPV4VrNpCxevLX6KUrkWm9v3ffLmPHH/MRIfLW6wFior
 4U3RWp62DeFDB9ak17sMFDSBMpkksBhxPfOux4yRGLwMMCXECLI2ujZ
X-Developer-Key: i=vikram.sharma@oss.qualcomm.com; a=ed25519;
 pk=vQBkwZr1Hv+VXogAyTAu7AEx8/6bvkOmgrzYFbNGCDI=
X-Proofpoint-ORIG-GUID: lfla2S5hreaGQcV4ABzPJc4JeBDhQcl3
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a19a4bf cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=c4NERmNbVgiTpoOjq6oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: lfla2S5hreaGQcV4ABzPJc4JeBDhQcl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE0NCBTYWx0ZWRfXwDPWi0t5lAMq
 yp81hXZ3FkIyANVhO1iLZ8pxHVKPJxJbRyH/c+L4Le8zo3bKTMhjl9pdhtBUN+ip5vtDSaWpBt3
 OBIJV/Nli7Jh+fYd0cQ+J8mMXubW/hWSFmLMD/gH77GRdcDdzStEE0AhrDguGCZ98UHxqeI9pue
 yFSLYh8u1qBmCDrTtFEMkwqr81MCPdxP6sRicZ6PHQT8PRkAlok7/lDXkhs5ynMSvTIbuOrC6hV
 tKF4OxWFPTRYRS/vfOzGwF0a8Y8K5m13eGx4cfy4fIKmTtZ6UqnzeXM9ZkaL7GcamOk+2Ea0IQq
 0m5NpneYGPfJe8Aj7HAQxAKfG68IWJv2m8uxmXPuBTOwThc0FB3U7A5fL96PMGj3S+ygbA+HTxq
 FbB+llBKL25vJODbNN2WwniWynxpFFdDaAFKCTmstXv9UGVxuC+0K9G3r+uIFzE+EudUXpa2VAn
 LcN+19c1QOoVWFARihQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290144

This series adds Camera Subsystem (CAMSS) support for the Qualcomm
Glymur SoC.
 
Glymur's camera hardware topology:
 
    - 3x CSIPHY (CSI Physical Layer)
    - 3x CSID + 2x CSID Lite (CSI Decoder)
    - 3x TPG (Test Pattern Generator)
    - 2x VFE + 2x VFE Lite (Video Front End)
 
The CSIPHY block is the same hardware version as x1e80100 (3ph-1-0),
differing only in instance count (3 vs 4). TPG, CSID, VFE, CSID wrapper,
and ICC resources are fully shared with x1e80100 — only a dedicated
csiphy_res_glymur array is introduced.

Used following tools for the sanity check of these changes.
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=media/qcom,glymur-camss.yaml dt_binding_check W=1

Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
---
Nihal Kumar Gupta (2):
      dt-bindings: media: Add bindings for qcom,glymur-camss
      dt-bindings: i2c: qcom-cci: Document Glymur compatible

Prashant Shrotriya (4):
      media: qcom: camss: Add Glymur compatible
      media: qcom: camss: Add CSIPHY support for Glymur
      media: qcom: camss: enable vfe for Glymur
      media: qcom: camss: Enumerate resources for Glymur

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,glymur-camss.yaml          | 343 +++++++++++++++++++++
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss.c          |  71 +++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 6 files changed, 421 insertions(+)
---
base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
change-id: 20260529-glymur_camss-27af71b1d3d3

Best regards,
--  
Vikram Sharma <vikram.sharma@oss.qualcomm.com>

