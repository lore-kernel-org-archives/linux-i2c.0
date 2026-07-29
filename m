Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D3483BD8
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327975; cv=none; b=YPoxQw5CjMSg3rR/ImuSIHLlyodQlnoHWyAK5kF/j/gUqXSmeLmgMSBb4lshDfyk2QNAg/nVUxhx9fvwVIzoepFdulusJUzEYDuIcy6RhzVYuajmfa/leOjZprUzgjAVYjGisWZHJpjZGnRpDYU3EcT92guV8EJs0FpZbiprJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327975; c=relaxed/simple;
	bh=A+sfyCEb+0uJrjx6auv12L81KYLbwW/2QM6iCw+NjW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6xrVi/pxMh/TYftmmsGcXieX50IVinbKCnlaO1Z0cXl3ufOgb2erMcfItx7XpPirHRusWjWipWI249uxN+KAaY+JYZSAKKUbFap8JUvigTS7j4niSzR6t+IBm0zqmNwkFs7l8DUb448MnG3plSsEvHl3E7/5l7e1523tBkDXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jm0XRqmG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvmzQjTh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jm0XRqmG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvmzQjTh"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCQAbA1707471
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCKdsq+xCdEVD25FwTx7ov2uQP3kGHOAxSpc9dMl/qA=; b=jm0XRqmGsiEu2Lw5
	Lws36wMtwXOut1lDzWd3axGzvBoSFsPMYrDxfPHal+FlJA0mVC4XcnwYMcc6JsAw
	jJ35Amf7z1zVXrFM0zm691RX+n1Z0ayu1LYKVl6s9kKJ+vG6lwjEQrqiYf4z1fiw
	QhE4Jf89B9Dv4M+rz95m21M1dkijyWDnqzE55zbOtMiM4aBcxsUXrZtUafzhrQNd
	XluUMeb8lK3TjDvM2F4xv5hOWXCtYeTB7FWtuKYsQkHj7/6gYhRHbNQxDjZGAaJG
	z9NNXl7M9Ddl8gOe1LeqQr+Q8JZ52N5VSes6vOxVUC3A3BwE6t9u2ZrWXeUczBRu
	gAC4hA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhgy800j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51bfe3fa93bso9634771cf.2
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327972; x=1785932772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GCKdsq+xCdEVD25FwTx7ov2uQP3kGHOAxSpc9dMl/qA=;
        b=gvmzQjTh5wbPxekcwgfLxIArBzvZHIgLPSTjDZ72ur+OECJjY+O+zDygPf1hA3viIC
         aC0JV01kqja2TJHpCXwUfV/eZKePlO0dofdP4ifKoD0cC8pkMPfFk6d44HriTbMNMjAx
         pDKT3AcY+mANz/XBiFjK/xeU5y0dEYDZZTiTK8VfW7ntZAUWuL4iF/HOllDrtU0hrTg5
         dsaCSXcYrMrnI7M2y1+jur4VbnqrkIRcrqEJ3cmp8ZJYAGHZobODh3HVM1TKekQz7j1V
         GN5VSjgrNbhjuui+uRISi1+RBcZLCd88DBxGQf+GnLnmlHOYNTct2zbC60hPGDB2p1qE
         N1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327972; x=1785932772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GCKdsq+xCdEVD25FwTx7ov2uQP3kGHOAxSpc9dMl/qA=;
        b=beqw/RGX1eOho6QcQkCXfkRS9CJK95M68ikFcNTmOsopfNgIoiXzzybvGBc6dlGt5o
         ahM1j26mBOuRzHj0aQdsHfYKNnnSH083jibOyLsF4wtKjjuSAc+WGcgM6wObOAWOAS2l
         +wuvdm+Ca58xUvkcngvrpA1dMze9pwf8/rNQ/Ea7kFfDk+cVeoifXGGLD9OJ/ubj+n8q
         Q6JhFeTlsSO2iqJw2QAHLmJDCdgOBrigyF97H5f4EyGW1dmL3Jm68ppt65ys9l+hg7x7
         ekpu6/Zf3Gj3taa9MGebS50H7mXmcDy/a6NMUN1bPqZNhz8UtYtlSewIq0V76kIHOQHr
         /GRQ==
X-Gm-Message-State: AOJu0Yzxvm1yS3NwOmX0SLunKk0T6SS942LVJA/V0bifKjBFAldJhUOo
	oW6OF44zMIcReosQt8WHSXpN3YMTEAsSG+xPQGdp+/+satGL1KzKRupb2hVT1ebPRGztd8jEqTp
	MmHLQogfLbC/RBexwcAmmNqVxpy0oq3JNzR7Oq4qQjKYc+FfMPU3MMiWRASw4r3Y=
X-Gm-Gg: AR+sD11AQl0KWNfUlWGpMiN3DYnrKhiZRpGM6jOhTsGqqo4SNrNuUSeMkjZJIUrdPl6
	x+k2DafNpX34GixmF8j2mqsjs1tvxyvgLDtHEFS99VodhuRIttcAh4Vb3LDzgCqFenapu74CkRH
	nGxAGdPQHLCtjtXmiWKPM73ofuIkVcSar+ilebhlYGEuJH3CWTwiuisCcRo21RH4Y+89cNo3u8Q
	3PxKzacQ4AlXgKhm4AzmONtNT8Pc8CVqFx2+abXL1j/pMT4W6T7sQ5zWZfpfqFgRLMYEfyyHTPo
	74fu8AWnynbFzzHm6EerqCLJ7rmQLjzhPOTWDU1PYQFcuZPy6NlRjJmpClsTvE0Hu02qovcxEWD
	cN12sSG0RrirjZJuGLXruofZoU3PZ4B9fL4DKTITXOIx3Qn93y83vAKz8atwEhno3iAZm2PPYe2
	zX4Ob8JTYTe9cgiS+KRIdK+cZgVfRL9VLn8lYhppBXeJNzTZv3Tp6X
X-Received: by 2002:a05:622a:411a:b0:51c:13d6:b4e3 with SMTP id d75a77b69052e-529d71468ddmr53846971cf.64.1785327971771;
        Wed, 29 Jul 2026 05:26:11 -0700 (PDT)
X-Received: by 2002:a05:622a:411a:b0:51c:13d6:b4e3 with SMTP id d75a77b69052e-529d71468ddmr53846651cf.64.1785327971275;
        Wed, 29 Jul 2026 05:26:11 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm756343a12.23.2026.07.29.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:26:10 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:25:57 +0200
Subject: [PATCH v3 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-cci-clk-fix-v3-3-f3c731d1596e@oss.qualcomm.com>
References: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
In-Reply-To: <20260729-cci-clk-fix-v3-0-f3c731d1596e@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: peZomyTbr1kt2dY2rVQnG-6RixTMc8ZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfXxQHLqEFSO755
 609UlKJaWyjIihJBHXunrMoaL7vodFjVCouP08R/XPli0KJ8qUL2CWTJUej/ZCb33sYT77m6qZN
 RhCOJ7g2zcI7Uid/Ij/lfqvO5V7Byg1A6neC2Nn2JPq2YdxW6DEG8yndBCkjorda6fbLye/VrIa
 sDD6N7Nruo+SEhVyUOB+yAYnfs6ojkFumaM85wEiesnPLpRsgQF+eLW4cNXYqHXCZ87/Kvne1tt
 ByOfvCIcl5rRq1+fbK5erwS6DtGB0vYrTiIAPOvBYhxWViq6XxS9+C6Lhau3xvxpZNBUF/cPq1a
 Y1N+4FZsvTH9yVmywUbl8AHF6Hnz6FwRngwqRQwi8AYrCEvAtRrFF4TgMDR/3IgFtSPYNBIahj+
 5tl4I8ucLaMSsF2tA8vPtdOdnVANLFGd67/2N3KksV5HAKsv2MvRMJ4DV93CV6q/+QHN2GZrYfT
 6heeXcdJr6kQN82LjSg==
X-Proofpoint-ORIG-GUID: peZomyTbr1kt2dY2rVQnG-6RixTMc8ZI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX/e7ap4YisRx5
 ybvrEXWIy1RQp41nxJYDtgSTeE6uXflinXhcklMoDgnZx10R0G0jPqGF60FRARy05GI5XmoG6LG
 Rr8VrrL0KTVEjt3bAXUOmAkihk2SgpY=
X-Authority-Analysis: v=2.4 cv=VZHH+lp9 c=1 sm=1 tr=0 ts=6a69f164 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=fiHgs4EJ_qdzu2AaPLEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

The v2 CCI (msm8996/sdm630/msm8953/...) is normally clocked at 37.5 MHz,
but its CCI clock can also be configured and run at 19.2 MHz. Add the
Standard and Fast timing sets calibrated for 19.2 MHz so that a v2
controller left at that rate still has valid timings for those modes
(Fast+ requires 37.5 MHz).

The values mirror the v1/v1.5 19.2 MHz Standard/Fast timings, which
share the same CCI clock rate.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 6fc2327db44acf016d008d0e268099494572774b..a7b9a8d43e39a6bdeb47250c34ef7474bd7138f8 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -778,6 +778,30 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
+		.thigh = 78,
+		.tlow = 114,
+		.tsu_sto = 28,
+		.tsu_sta = 28,
+		.thd_dat = 10,
+		.thd_sta = 77,
+		.tbuf = 118,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 1
+	},
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
+		.thigh = 20,
+		.tlow = 28,
+		.tsu_sto = 21,
+		.tsu_sta = 21,
+		.thd_dat = 13,
+		.thd_sta = 18,
+		.tbuf = 32,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 3
+	},
 	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,

-- 
2.34.1

