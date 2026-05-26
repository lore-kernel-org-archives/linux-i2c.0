Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A4405C2F
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815603; cv=none; b=ESVFJSnZyuWAurmdq3f/O6wdnyudYbsqV8MCIJDgtxODc0gSFiVKanpvPMqpy84M0BkjZ/BXLaXAiBIhWNzC159DzeUDSbHhCnh+V6+m7dZAlzZHjuvS0nnyvxHsm3JSHPPVSbG5OHPS/wJKunXeIOCLZ2yIfBQ8pfvfdrmoHWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815603; c=relaxed/simple;
	bh=6ticCiz1Hu6M8/yr+1ZH4m5ai4WB/qqNCfU25u12Bng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hq3AOtWl0ZdsGfQl5gNdN2TFSRX/yGGIJWX0+3xdc12cA0NjFCOkKOmf9SH3k7rmFxhMLKTbKd9H27A0gqYC3K2sJx4c6uAE8gvqnKgO1tV8GSj7FmTazJMyEOmZuU0X2W4+YiT92KizTfkLEbERlhCW84OHrDJSVGmUdycrTtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKwtnu2x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j+hqEEiS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKwtnu2x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j+hqEEiS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH0pPd2977148
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JGhusXCA8cVjnObIc87hQxbbtx5nG/WYD8044e7EgZY=; b=IKwtnu2xR5XR77AR
	LZH+8SAvGtYzAD5ub90cOb4yAzcUCqzcW8o3ejewmKjWSKw2LrLbTIEDeISx+wUX
	tQmUOCAiQvl8UsZg4i4+3+jSMKOpTtBIWTcBntsfFeE5ThfaOykgEDtadI/HQWf0
	zwqh2bSZFcZZr10b3h2PYfUyovMMp8uZM3bJJ9GErxiGfk2Xt/1W+dP7JxJLPOrd
	593LzzqQq9AEH8ul1RSnVw1ioQDcg6JDbGS2+Km3xOwcd1J1ixkcWEFrljmoHe68
	9Srrj5rIWQ/wB0vZxLzxm4j7tQ1X+dPQ5AUsJtJyIsWiRWUh3FFCNRXADQxVronV
	NIxq7g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddqkrnt8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82c4772950so5428613a12.1
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815600; x=1780420400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGhusXCA8cVjnObIc87hQxbbtx5nG/WYD8044e7EgZY=;
        b=j+hqEEiS9rJxd5Bb+NFnZOr7cxicmqw45TDmtwdGfbncG+x+Jrmn8vvBOlvp8PxY7M
         2f/DBAkt7KaA2iqO3xaGOFovrJtF214oB59BeuRMTZooBH8dG83OjpVDIIH1bTxVKSbC
         W+tr1tBChBRA5HYYqu0kUY/TfkdmE1bWERmhOfcgaEet4fak7L2L6Qab785bB8EBdq2H
         96ESvV1mbwjalsJ2DjIyxM/uVNuOnJDaaH04Pr+YImc7uv3O/ncaWPbeCzNzxwGym5gu
         3EHQSA2YPz3CDUaWnDU0RKDzBVoz7cSggE8dAcQe/JNx0bS0RA9G/6R6xUy0I0Xtfta+
         CN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815600; x=1780420400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JGhusXCA8cVjnObIc87hQxbbtx5nG/WYD8044e7EgZY=;
        b=aMrrkPHp2BqA5oxaVoLXYxnGPgjumXyOAEzJDT3lU/Ibtnobk7ZH2+Llv0nYH8vvp1
         qkjTyoIooFFR7m/+JM9TOfAKPB4OMs7njEf1vENJwbZHrUuP0+pND52DS7NIrz7krhRm
         0LcPdGSygkgRWBhbG5Ge/djbx9MOHY3EmIzIkA3IPx3789B7XFcIKCF1Eq3ml0Ymdt5X
         6S12noZ24MMHAxirnflc3Y8HzNi4dzPi2Y3CFTFqZgOhm1G6jn8KzBN5ePETwGFomPff
         aOpsRCwsdPb1QI/7x/0AF+y2yH4BwM2d/axl7fmrTkbgNeJJMIZX7lsvhdc6JGK4bXre
         cN4g==
X-Forwarded-Encrypted: i=1; AFNElJ9nMsrAEe4jLKUmqbsDpS4QG7ZtcpOAZbHVdBzEFXKyCbWJ9htZiiWd+abSotnivNarqb6UvqiN4Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2FAJDbmQljLXZdmxIm5Hv5TJHI3ZqcajTAH7yi0efTfsFgQr
	eGK9gTXl80v1DgdK7oHLd4ORIudsQg/5+I/0Y/GJ545l5Dh3grBLZdCqWWh1chkO+Q4oqlunqs5
	LrS24gpuOJ1yG+hL4vvPt4GS49Lt0qgbvmju+bMPUpUHjOdVcWf/Oh8pPwk5kVLs=
X-Gm-Gg: Acq92OHWtxttv7BM4ZACy6naFYf2oz7VYiMUMWoEK9xLJJfnb7CB7YPc2yuHZgr0S2d
	axbf1HQN15IgpYpOCo/ZjR1UNjzzmK0YI1bkN478jjSX3Ct84vMYgH5FhtnMaCr6OIOzIKTxN2v
	3GIwTxZm5HpTp9l9NPq2Ty/PIb9ghin4e+wp057eNn40YbwIr7PN9RCggucfAz9F/pYRx2ywsMh
	6S/y52swQqYiWEdFoT+qOuDblnQLBHivkRrbz4rMLxlynUFUGEBfmgm3n4zVNgc+tQMF8geCIYx
	g8JbWdF2Y1bYWo2CSgqwkyvc6IwSEINCalQZNbSU4sVbedChOTERxU8yg+tox/PVU9Ukcu01/NL
	7sn9LxwVYwoMwEteMSPfz1HfaVrJP4vfPIGtuARpJFGMeCH1tWBsXRdt51q1IoV0=
X-Received: by 2002:aa7:8894:0:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-84160bdf1f8mr15090275b3a.7.1779815599636;
        Tue, 26 May 2026 10:13:19 -0700 (PDT)
X-Received: by 2002:aa7:8894:0:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-84160bdf1f8mr15090231b3a.7.1779815599104;
        Tue, 26 May 2026 10:13:19 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:18 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:47 +0530
Subject: [PATCH 3/8] media: qcom: camss: add support for QCM2390 camss
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-3-645d2c8c75a7@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Prashant Shrotriya <pshrotri@qti.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Zubd7d7G c=1 sm=1 tr=0 ts=6a15d4b0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-sGFTftWuDZfp9pOwnsA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfX2y0glO2kLKRl
 fwTOysWM/i0vXMdFVvcV6PDfW3vp42OSFEcjJKafPH6ktGe4QyjDtOfH2YXyGjjJC8jBjIuy9Lo
 QSkC9cxTVSlA4drrUZLPg9EmTUtYy5l/LZTZLhgXL/AZgeZi42pdES8edfLMdBkKZwyVnDISyON
 RFAyvOK3sGeEhDTS+kSrG7l6i3c8135Z9fclXxMneUmjjP/ARSBi6Q44qPSFH2pytsK4Ceg5ReY
 2JCP8KXcemyj1uJrd6zS3FYmu6BoARGurrflbGrVw2Vjrv+lTkNTK4YtPtbWhak4+VwRs3a4rUy
 t4ybru9dhI5o7FgjUryuK3uQH8iW7MeeItiEH2P3L323sQWMz+8/99vVlXSLr/cCMLuuyhWbtfg
 sg2jB23tVHpvvdMz4GXm34yre57QHXCJ18Rk0Hh23anRiTzWDRq0T7t92x99NUD5NS3kpd4nySz
 aHRIZVNdOA6LIEngrOw==
X-Proofpoint-ORIG-GUID: oinuPbN-ZhmDV5nwWLTa4N1AuMvASW-E
X-Proofpoint-GUID: oinuPbN-ZhmDV5nwWLTa4N1AuMvASW-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260149

From: Prashant Shrotriya <pshrotri@qti.qualcomm.com>

Add CAMSS driver support for Shikra SoC. Add high level
resource definitions for 2 CSIPHY, 2 CSID and 2 VFE instances along
with the interconnect bandwidth votes for AHB, HF and SF MNOC paths.

Signed-off-by: Prashant Shrotriya <pshrotri@qti.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c |  2 ++
 drivers/media/platform/qcom/camss/camss-vfe.c            |  1 +
 drivers/media/platform/qcom/camss/camss.c                | 13 +++++++++++++
 drivers/media/platform/qcom/camss/camss.h                |  1 +
 4 files changed, 17 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index dac8d2ecf79957dc05c5524dc439791ce097c785..62208f5c4f17bd6c9a8fe5613649920e6ee1a1f2 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -1130,6 +1130,7 @@ static bool csiphy_is_gen2(u32 version)
 
 	switch (version) {
 	case CAMSS_2290:
+	case CAMSS_2390:
 	case CAMSS_6150:
 	case CAMSS_6350:
 	case CAMSS_7280:
@@ -1222,6 +1223,7 @@ static int csiphy_init(struct csiphy_device *csiphy)
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_sdm845);
 		break;
 	case CAMSS_2290:
+	case CAMSS_2390:
 	case CAMSS_6150:
 		regs->lane_regs = &lane_regs_qcm2290[0];
 		regs->lane_array_size = ARRAY_SIZE(lane_regs_qcm2290);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 319d191589884777bced456867e5a2a4211a2770..b152f8d48e003d8eeb0cf19ad57419b25cdec087 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -342,6 +342,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 		break;
 	case CAMSS_660:
 	case CAMSS_2290:
+	case CAMSS_2390:
 	case CAMSS_6150:
 	case CAMSS_6350:
 	case CAMSS_7280:
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2123f6388e3d7eafe669efd6b033e22d8eb5cf79..f67ecff53f15bd213dc7736d4e5fe880007d1ee7 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -5565,6 +5565,18 @@ static const struct camss_resources qcm2290_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_2290),
 };
 
+static const struct camss_resources qcm2390_resources = {
+	.version = CAMSS_2390,
+	.csiphy_res = csiphy_res_2290,
+	.csid_res = csid_res_2290,
+	.vfe_res = vfe_res_2290,
+	.icc_res = icc_res_2290,
+	.icc_path_num = ARRAY_SIZE(icc_res_2290),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_2290),
+	.csid_num = ARRAY_SIZE(csid_res_2290),
+	.vfe_num = ARRAY_SIZE(vfe_res_2290),
+};
+
 static const struct camss_resources qcs8300_resources = {
 	.version = CAMSS_8300,
 	.pd_name = "top",
@@ -5752,6 +5764,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sdm660-camss", .data = &sdm660_resources },
 	{ .compatible = "qcom,sdm670-camss", .data = &sdm670_resources },
 	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
+	{ .compatible = "qcom,shikra-camss", .data = &qcm2390_resources },
 	{ .compatible = "qcom,sm6150-camss", .data = &sm6150_resources },
 	{ .compatible = "qcom,sm6350-camss", .data = &sm6350_resources },
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 93d691c8ac63b2a47dbb234856b627d8911a1851..8ba8a38113dfc15849fa333d05b2c3853f3a7714 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -82,6 +82,7 @@ enum pm_domain {
 enum camss_version {
 	CAMSS_660,
 	CAMSS_2290,
+	CAMSS_2390,
 	CAMSS_6150,
 	CAMSS_6350,
 	CAMSS_7280,

-- 
2.34.1

