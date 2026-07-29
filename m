Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C654483810
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327974; cv=none; b=R+Z9BRqE9/cu5Qz+6p6jiqagal6KdKRCzmZDzgCyPwUhqMzTkCZ9x45H7wRKt5hEzvHj4HuJuxM87OBjWYRVOi6h+CbfJWgo9EprIKLlP8XDbmAMZSmC+xByLuX4r+IPedzdVA/RMgNLQhvb+jEGsHDRXb2fUhNyMkPt/SOAptE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327974; c=relaxed/simple;
	bh=Zx31oD6GyEJA3YzYQdmeNawsiH358wsX6n0LkcGPRAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZVDFcveOpxHJHOeq+kpo3acgn8Z8txyAz88a9uXj8E22avLmgTWHBBBKZfU+d9drS01HOGGY/XtI1676R0Mo1bjfJ8yoqPkAcVdh3OxV70SFQXKg+8yvnHZQOjG7ET2Q6nlLN+OTFcYseXhYAaclRCiEQpfZ9WDKKXGKg/TYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SU1X/H9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OdHMHhCs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SU1X/H9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OdHMHhCs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCO7WN1814504
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xqkTVMHLircUUeJl/l9K4o8h53AJUq28KjUtzbWeErg=; b=SU1X/H9lkkUv7FVN
	qssDRvQgNXTd8UrbVEreCEqyb7aMHvC6/MDAlIZvwcwcC/rrq0drunc6cjm6OIXk
	Bcy4oxL+hvMu6OeEU7r9fB7515Zjg4gyl/gqwxf4AGs8SiPVhGziQCuSjH2tWEn9
	PPbIzfwUiLhdTjhXKYRp1Z57XlUMFGAIbvTsGSZOl3d2/8x/2wQFSaju0pmBsCMB
	ghzO8NHhMIBEvjMKr7dGgLCOKb2l8x8mxrHr9HZGRtidd3LWOdPuTI0vnjG698ly
	nvCfrl6ZZoFirEauDX0VSiNHoQ5kxi5KxKgsFPR4yxo3gzHTW23yav3w/OVePU0B
	anxd/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhg8r07v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52827090cc5so10706731cf.0
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 05:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327970; x=1785932770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqkTVMHLircUUeJl/l9K4o8h53AJUq28KjUtzbWeErg=;
        b=OdHMHhCsDcJ0IaOrqtFdAXzBlFxrv+jFlFcmQ9CoqL/XtPJTljRISV1a662YmBL8oS
         LJMeau9dRwzJb3sw6xBgJV84tjjU+BlqfS3tyUtj5KOKS3C1WEEj2amN7j/vcYyFu1Ho
         +H9btTQvXr/eARolajTjbeg8hZPupNG7H0lJuKAA1x/WmOVA/rpOx57VJBNxHnTd+3TD
         +ld0bxiIlhGyp4je1fYqIryskDJljc7lKY+qhEoGkv7C8Tf+0w9NjCLVScrK2yKdje93
         KJJ0QuCuKMt9k9pCBAd2Hdcx2FtE6KFOzKvBcij9m1wpNBdVVFjwpEz2b12yJ/cXi4Tj
         W+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327970; x=1785932770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqkTVMHLircUUeJl/l9K4o8h53AJUq28KjUtzbWeErg=;
        b=aT2VkCoOjrtgws3cbTURqsgaX4aVOKekArtEU/BwNlY01sAOZUYBQRWUFo8/T+lk7T
         dzIwcQr4e9t3rSFqtB9bhfpvH7a3PyzM7r73QMf7n+fCN5UonweiVYbFMVWkmdvctMDR
         96Akp89R2OojkFjlL5MYLAyHnEvdHMQ5V4SrcqVvV+1RroRYt+ah+J78B9R7aeP2MNrD
         Bj5uS07MJohRAJnLXTYwcfEfQwKXNzGoyk2SoUKNmdRzgZGUmt/fAB/twXLwHyk8c1/u
         jZmeKTcmVARDuqwMm18HZTyddy/jNvvpF9Dp/cIhErDf/ulbZI0rX4F0YyPN9VUtdRQV
         QHZA==
X-Gm-Message-State: AOJu0Yw4cymjw2v/FxgfBt59MIFJ7yBTMMmS0IRc0R/YNg04+Mxn+bEo
	niZE9mMWbVDrAz4FuLegjqooMmfOn/3FQ79CySCLi/zVFpDyxxzqx2lQ8nIVLP99uKBUOpSsd6b
	P0TEv88OV5QtZ37ozX9eL/Amr6ywe4eTtkH0xk1qY1IynjwaCLIQTCDcMJaTSEYA=
X-Gm-Gg: AR+sD119zyScKH1vIm3fJcGcj8HUrkC3u+pS0cTJ21ZiItA1Nq8pfzVfbc9ViaE+XTQ
	T/af89+goxncfLXsd/K7sQz5UrtqvcxLGdUdRgD2/gsmVdQ2yVu/LPI+c4AFtAdGwz31rCZlnFi
	/j4a6/gyJHleKLNM4x6OswK2+7EPc00P6BPgBnGxFhW9O0ZrLNiOqUqqjd4ebUPZg+KuPnyljFr
	OYgrHotik3fQiXnCBZErnPc4ekyfXcsOoATDulOT2qP7i2MdsOMyqCWnFofJFahyv6XNlz4xbDI
	50iwGtuuOqPe6P9qpfqzsSuYQufbw/PBVmejXJGP1WuaPFxvjk+qeUTbWIEm+U8hhrQazA0AeQh
	J3fJN+NNUYkWk7+hK5HLizd0h5IyhwzRPpM3++NynM+LopfJwkQFefZQudU5QwlRPXG1hvUwECF
	KsAl/LR3KzNEtadcSczNrfmuakw8XM0TBrCP5z0LQLWqQJWGquYsng
X-Received: by 2002:a05:622a:134d:b0:50e:474a:47e1 with SMTP id d75a77b69052e-52b2ad2bf4dmr15754471cf.10.1785327970241;
        Wed, 29 Jul 2026 05:26:10 -0700 (PDT)
X-Received: by 2002:a05:622a:134d:b0:50e:474a:47e1 with SMTP id d75a77b69052e-52b2ad2bf4dmr15754061cf.10.1785327969686;
        Wed, 29 Jul 2026 05:26:09 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm756343a12.23.2026.07.29.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:26:08 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:25:56 +0200
Subject: [PATCH v3 2/5] i2c: qcom-cci: Support per-mode CCI clock rates
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-cci-clk-fix-v3-2-f3c731d1596e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX0zA0iJdgRyhs
 mbOGSRTeSWOUQfVO5ZSCcydO9eWtQP7axR+isO3NK3q6ORW93i+nRW9gjVi5RrkuG4bpBvMSSpR
 OfDpaulhltTumoFFmKrvoBYAlrLKcMs=
X-Proofpoint-GUID: 2YL5wOKJVn0GbCwpS3gW29SprfTvyWZ5
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a69f163 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=vNI37wWFbY7V_e8DPPQA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2YL5wOKJVn0GbCwpS3gW29SprfTvyWZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX/MD1FH3kOfwo
 LisUy/aypfBOyZvglkgqW8YUqTyKTlH2fn4MEEmZBeaPajVv1sw+tBk8OjX6TFjOOGQJDIMYWlP
 6NHB5Z3QHlzY6dImEetlsnud0iX/OP7Y8lUXtkU2iG+DTmpHluFQ+1rulX5vZpR2rwE+TD8hFBn
 a/WyRWHLQch51ioTlC3EOQf1HDIWJZKWJTPUUGCql1tLyXRXPbsth/o6hM/HxEh5kb03waFqFRd
 Vd/eQ7SShN7X3W6jRR2obj6d0/t6/ti19E+JgtJR0G5J9DNTaq7/zd0YjXfiHf8DOVDlUMg4kge
 mXMisbiGMqDrSLkCA686VFN0nB+Z17F7dBUK6Hbw2LIqPt1jF5HHkq6e/hYsjLv2/aJ73IdI7GN
 b0ZfXcx7qi1hY+nz//4BMKt8DPma0RmM+0vAV6VV3LB5DmQ1wSPDMmj5aD1N6YV0Ew/3mxiIKFJ
 Uc1VD+JZcEUnPg8ctiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

The CCI hw_params timing values (thigh, tlow, etc.) are expressed in
clock ticks and are only valid at the specific CCI clock rate they were
calibrated for. Different I2C modes may be calibrated for different
rates, and the single CCI clock is shared by all masters.

Turn the timing table into a two-dimensional [rate][mode] matrix so a
given rate can carry timing sets for each mode, and select the entry
matching the currently running clock rate at init time. The existing
per-variant values are moved under their calibrated rate (19.2 MHz for
v1/v1.5, 37.5 MHz for v2), no timing values are changed.

At this stage the driver only validates the running rate against the
table, the timings are only valid at the exact rate they were calibrated
for, so if the current rate has no matching entry for a master's mode,
fail initialization rather than program incorrect timings. A following
patch actively enforces the required rate so this becomes a safety net.

Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Tested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 74 +++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 23cef922351ce44d71f1691cd7e4aab274fdd196..6fc2327db44acf016d008d0e268099494572774b 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -82,6 +82,13 @@ enum {
 	I2C_MODE_STANDARD,
 	I2C_MODE_FAST,
 	I2C_MODE_FAST_PLUS,
+	NUM_I2C_MODES,
+};
+
+enum {
+	CCI_CLK_RATE_19_2MHZ,
+	CCI_CLK_RATE_37_5MHZ,
+	NUM_CCI_CLK_RATES,
 };
 
 enum cci_i2c_queue_t {
@@ -117,7 +124,7 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
-	struct hw_params params[3];
+	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
 };
 
 struct cci {
@@ -127,6 +134,7 @@ struct cci {
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
+	struct clk *cci_clk;
 	struct cci_master master[NUM_MASTERS];
 };
 
@@ -225,7 +233,34 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	return 0;
 }
 
-static void cci_init(struct cci *cci)
+static const unsigned long cci_clk_rates[NUM_CCI_CLK_RATES] = {
+	[CCI_CLK_RATE_19_2MHZ] = 19200000,
+	[CCI_CLK_RATE_37_5MHZ] = 37500000,
+};
+
+static int cci_clk_rate_idx(unsigned long rate)
+{
+	int i;
+
+	for (i = 0; i < NUM_CCI_CLK_RATES; i++)
+		if (cci_clk_rates[i] == rate)
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
+{
+	unsigned long rate = clk_get_rate(cci->cci_clk);
+	int ri = cci_clk_rate_idx(rate);
+
+	if (ri >= 0 && cci->data->params[ri][mode].thigh)
+		return &cci->data->params[ri][mode];
+
+	return NULL;
+}
+
+static int cci_init(struct cci *cci)
 {
 	u32 val = CCI_IRQ_MASK_0_I2C_M0_RD_DONE |
 			CCI_IRQ_MASK_0_I2C_M0_Q0_REPORT |
@@ -249,7 +284,12 @@ static void cci_init(struct cci *cci)
 		if (!cci->master[i].cci)
 			continue;
 
-		hw = &cci->data->params[mode];
+		hw = cci_get_hw_params(cci, mode);
+		if (!hw) {
+			dev_err(cci->dev, "no timing for mode %d at CCI clock %lu Hz\n",
+				mode, clk_get_rate(cci->cci_clk));
+			return -EOPNOTSUPP;
+		}
 
 		val = hw->thigh << 16 | hw->tlow;
 		writel(val, cci->base + CCI_I2C_Mm_SCL_CTL(i));
@@ -266,6 +306,8 @@ static void cci_init(struct cci *cci)
 		val = hw->scl_stretch_en << 8 | hw->trdhld << 4 | hw->tsp;
 		writel(val, cci->base + CCI_I2C_Mm_MISC_CTL(i));
 	}
+
+	return 0;
 }
 
 static int cci_reset(struct cci *cci)
@@ -283,9 +325,7 @@ static int cci_reset(struct cci *cci)
 		return -ETIMEDOUT;
 	}
 
-	cci_init(cci);
-
-	return 0;
+	return cci_init(cci);
 }
 
 static int cci_run_queue(struct cci *cci, u8 master, u8 queue)
@@ -488,8 +528,7 @@ static int __maybe_unused cci_resume_runtime(struct device *dev)
 	if (ret)
 		return ret;
 
-	cci_init(cci);
-	return 0;
+	return cci_init(cci);
 }
 
 static int __maybe_unused cci_suspend(struct device *dev)
@@ -586,6 +625,11 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
+	cci->cci_clk = devm_clk_get(dev, "cci");
+	if (IS_ERR(cci->cci_clk))
+		return dev_err_probe(dev, PTR_ERR(cci->cci_clk),
+				     "failed to get CCI clock\n");
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -668,7 +712,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -680,7 +724,7 @@ static const struct cci_data cci_v1_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -701,7 +745,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
 		.tsu_sto = 28,
@@ -713,7 +757,7 @@ static const struct cci_data cci_v1_5_data = {
 		.trdhld = 6,
 		.tsp = 1
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
 		.thigh = 20,
 		.tlow = 28,
 		.tsu_sto = 21,
@@ -734,7 +778,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
-	.params[I2C_MODE_STANDARD] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,
 		.tsu_sto = 204,
@@ -746,7 +790,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
 		.thigh = 38,
 		.tlow = 56,
 		.tsu_sto = 40,
@@ -758,7 +802,7 @@ static const struct cci_data cci_v2_data = {
 		.trdhld = 6,
 		.tsp = 3
 	},
-	.params[I2C_MODE_FAST_PLUS] = {
+	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
 		.thigh = 16,
 		.tlow = 22,
 		.tsu_sto = 17,

-- 
2.34.1

