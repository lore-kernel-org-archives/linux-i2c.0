Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06DF481FBF
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327970; cv=none; b=Ni9vkKhdx1WoI27rWy2tkMesXEV0sr5poKT9/8zxyinHEIGgFfDIP6NT76c9Ap621YCzZQWYWqe8nZEv1Qzqy1RHLfbdIQEeyUlxjFcSmdcIk7WX4RGABkSPqCtEANjtIjNhiSyubxdTaY4XVZaAsEOr4VzE/2I8bPJIQ3sgdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327970; c=relaxed/simple;
	bh=WDfP4eImhagoubHadmYWYBQwKUoTDbKClZvjE157G34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Smit1iwXiiiPiYo62O7tfSrGav4xB2g8uVhXwoYzYyadkZ/cRHbDoEHRuZZomq/F/oxKNnV7aITZD0aRciNRlj4DgpYu758ncYelmnKcc1dG5/RsE31uPeJodKvbN9N0bmxJZhPlyuTZR1G5VtJQpWoIjEmdBGFykTgR7252UB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i1JONZjT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ICLNxIeJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1JONZjT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICLNxIeJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCQ81R1707396
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YWUbfROb2lvZUMuCtXI28/wgXdhqqUViDghyWVR4cpU=; b=i1JONZjTJMAS2NTg
	P9M7ymC7PdmFfNGvGy0xjYGtRMeNPJJB4ULSrWenJ4TC6WWxWTl8npfe5zL1uLs8
	/2ldQZx7m9boDg85/GTZsJglf82QPglc/1+4fVFsi/Aw+cyD1hG50DIItgh5/2VI
	HDAk7nyvvYkp+xgmq5n3oS/77+agsUA5C+GC70/hQz0Ay4rLCIIiHrtk1vCl03xt
	N/NYX/weGMBc8usCA7CSyD/dcz0OFb772hU9Qx4/kpOKqKa+n0oi/1D3ZTU7zT/V
	ZWCKMIjcTWKRXR927if+5tkyEscEDeuAtX2eH/T16RwbbVIdFQ3bSAzTCiSXFuw0
	XWZLtw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhgy8009-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bec738909so7670071cf.1
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327967; x=1785932767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YWUbfROb2lvZUMuCtXI28/wgXdhqqUViDghyWVR4cpU=;
        b=ICLNxIeJN1YfX8nHhW6oegabGNuS+dDWvGa5tmmf9rLptG49o/Cv2v7GMfwvLy36Rj
         MOgyIoExUHl+pxjsjTZz8klXG1G2ciZg/RZGIeWVxt7UaCaVgrIwmRrHFpDdAo0VKs16
         rKv8wMvlbY3qy80+pSdXClmq0Z+EVFnbNMdKtwTxvYuAkRK6PJMYEiewI5+bPRFxYz3B
         U3g76wNSaOBHle6vnF2UwDOP+1/pOm9sZ95md7JPEDRbp6vhDqBjmtuJ3RZCp+tJf+Zn
         k6p88VjS4x82BSpJYiJDF34h+A9LT+TWF8CJf0K9+CR1G/gPY7u58awvYcjCUtSkOugI
         XUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327967; x=1785932767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWUbfROb2lvZUMuCtXI28/wgXdhqqUViDghyWVR4cpU=;
        b=AWfkVwzPTxqSlVi0pK5QXLy6bDCFG3f/Curuc47rLxCqNgrdBxM7ypKCUPmEbDMYPa
         n2PH9OCgT44fOtR4LX4AcdLhSU+iwqmKkJIJdBUKYUyqXzF3fI0cwRfZ4GSBZgPOa4aI
         36QqSpLJ35IKkoN5PCypGtmktNvUfNi+50ANfZxxeS3i3DsSilzZZBcjmbBp+0U56U74
         w981gmDRfgXAUvKjTUaapCl4NbfBMIaTyToPLNzXUQZNRG2TJ2Z82b7OFsghBGy28y+X
         m0fPmVY5FH5LyyFao/emRX5hTEPo+f1DyxHG83FjlfwX+rrmOiGq7iC4wNl+ayhYCw5A
         xOtQ==
X-Gm-Message-State: AOJu0YxwafzOY4vFXG7FUmdStXx7oHjoz0zaKYULy7XqsUAoSM9deru6
	FO3osdLbgbTh+Y8Buz0Fm8dFHfaP8ycj5neLlZrJH6irhEd8TZReCiEmUAgFPq337FRaRm4bgwJ
	LHp17XB1bmMW9nBruZ0jnfOHZS0AM/HdQWqj7lPfc273bC3zE4QPCIwbLyYjUd10=
X-Gm-Gg: AR+sD13DpfJUzt4vdP6Bkc4Nt95R0WOQUIljA4dqF3uVZCdDZsPQGKkeUcLTmV++8Z6
	bRBR0XQPw0Wx+ChPnnx6ZAIv8UBl6VI1XCQg7tjex2c8JSW0NXBH/rmdo22bfdvDzt4hx+Ih7V3
	l8GADhCyFgjE6i93GhDSK5ZchKpjCfFteK1/R8s/dylZjMfAg37b1bVdRXWAt2BZhFK8kaNiQxU
	je/b+pa9CW0/7zhoG2X89c5366Fvn4St/CahNGck9OqD94GfPpwJerrA8hWH/YcQ72noUyLPXUO
	IM2gZD7fKssudmwgTWN6znwGzGeVz8/6qxqCNEWR97++3TdVK+eiw6FSgVcYaFj8xkwFfl/+myX
	2SE26uDe9kkABPK7JhWz2NjzSS0+WAB8pW1EZDIZnq0ionIDrQH5MBvYxZRS4oPybnIvw2Q/2+z
	Bi3G5c923Udwj0Phf5Pvrq88KMiEVgB7q1xNC+6kThBEVfgjGnfKu0
X-Received: by 2002:a05:622a:1a85:b0:51c:dc:18dd with SMTP id d75a77b69052e-529d71d6292mr55944061cf.46.1785327966824;
        Wed, 29 Jul 2026 05:26:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1a85:b0:51c:dc:18dd with SMTP id d75a77b69052e-529d71d6292mr55943601cf.46.1785327966358;
        Wed, 29 Jul 2026 05:26:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm756343a12.23.2026.07.29.05.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:26:04 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:25:55 +0200
Subject: [PATCH v3 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-cci-clk-fix-v3-1-f3c731d1596e@oss.qualcomm.com>
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
In-Reply-To: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: BpuV6k29pSjuEDFGCt2S_q3GpryUCAsi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX8+Vt86gNxAX2
 TA+TfKi0vKgXQHCAR5oy1Pfji95QV+tNFlTDF573P+heYHocvmmgcYI0+xjI2jID5zXfGo0z9C7
 +vr7wzBLVTqZm2U1LnJRM7fgfIYX/OoH/FmF4qhJW9vS+EN563LIebLfv9LCBJZ/hygI4NIexHB
 Qa3PDOT4rZfnhjBnqfvuSMVtZQz3jbDb6nwQvsZxFhdaE72GsXnBCwVjXzSJUu+9LJZLvpFuUyJ
 dFAbIttwchJkWINSAl2TzFnBU6i3R8ZAyPtOYbneDnh6jH+F33eF5SZjjd66Ch0pmuoofgsSbxX
 yorK8+PapTTu6ft4gELlU1mw3g2pgde1q1s0WX3snDJqtnIYerewdLEa+d96in7w+pv8bIBX3zl
 GSjC+FeD3r7KfbAN1DbCyMhuV+9Ze54ELYUHAAg3phISeICTk8pa3BZa0bSGyRi+3FrSc+vSu3U
 vLHrUstWoSUy2tHyFTg==
X-Proofpoint-ORIG-GUID: BpuV6k29pSjuEDFGCt2S_q3GpryUCAsi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX5jOTgIjSU+o0
 msLr8GaJq4BIxLGBV5XPvkMXcGi+4E3H1ean6v85/2k7OgChx6BOL3awT8G9AcanyKrrJEuRhbz
 8Lak7UGwZyhzWasR6Zg6mxt9iAYxJUs=
X-Authority-Analysis: v=2.4 cv=VZHH+lp9 c=1 sm=1 tr=0 ts=6a69f15f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Y4CGMd7wAM7EkgizcVsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

The msm8953 CCI timing table is internally inconsistent. Its Standard
and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
clock, but its Fast+ timings are essentially the v2 values, which are
calibrated for 37.5 MHz. Since all masters share a single CCI clock,
no single rate can satisfy all three modes with the current table, and
the DT assigns 19.2 MHz, so Fast+ timings are wrong.

The msm8953 CCI is the same hardware version as msm8996/sdm630, which
already use the cci_v2_data config (37.5 MHz). 37.5 MHz is supported by
the msm8953 CCI RCG, so reuse cci_v2_data for msm8953 as well and drop
the redundant, inconsistent standalone table. This makes all three I2C
modes self-consistent under a single clock rate.

Note this requires the CCI clock to run at 37.5 MHz, the driver selects
and enforces the proper rate in following patches.

Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 47 +--------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..23cef922351ce44d71f1691cd7e4aab274fdd196 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -772,54 +772,9 @@ static const struct cci_data cci_v2_data = {
 	},
 };
 
-static const struct cci_data cci_msm8953_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 11,
-		.max_read_len = 12,
-	},
-	.params[I2C_MODE_STANDARD] = {
-		.thigh = 78,
-		.tlow = 114,
-		.tsu_sto = 28,
-		.tsu_sta = 28,
-		.thd_dat = 10,
-		.thd_sta = 77,
-		.tbuf = 118,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 1
-	},
-	.params[I2C_MODE_FAST] = {
-		.thigh = 20,
-		.tlow = 28,
-		.tsu_sto = 21,
-		.tsu_sta = 21,
-		.thd_dat = 13,
-		.thd_sta = 18,
-		.tbuf = 32,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 3
-	},
-	.params[I2C_MODE_FAST_PLUS] = {
-		.thigh = 16,
-		.tlow = 22,
-		.tsu_sto = 17,
-		.tsu_sta = 18,
-		.thd_dat = 16,
-		.thd_sta = 15,
-		.tbuf = 19,
-		.scl_stretch_en = 1,
-		.trdhld = 3,
-		.tsp = 3
-	},
-};
-
 static const struct of_device_id cci_dt_match[] = {
 	{ .compatible = "qcom,msm8226-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,msm8953-cci", .data = &cci_msm8953_data},
+	{ .compatible = "qcom,msm8953-cci", .data = &cci_v2_data},
 	{ .compatible = "qcom,msm8974-cci", .data = &cci_v1_5_data},
 	{ .compatible = "qcom,msm8996-cci", .data = &cci_v2_data},
 

-- 
2.34.1

