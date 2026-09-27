Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405783BFAC0
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515804; cv=none; b=i3OuJRE6+6p0U2mHml1ELDFI7Dbx9ABArFuDH5hzf23ia7uvvsfo7z/puwTmDNcNbEQkM7AtYgN1W0yn1/Zx2AuVo+27hVP/2HY0vhkx+UxgXY8i4ZIhWRyzibq1D0BZLHKiUb7fcQEjrtUBhVzPwkCUOgkRS0szbeDnPvR+IEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515804; c=relaxed/simple;
	bh=FL7ldl9LU54gpf6PaJsIAMaKHdINinRa+Hmc9p0bjVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GXL+JqoN7Z6uvW4hTNTXFVUKNPyBNwpdQqNv3ZdyG8JKqaAm7dQcDaI9PbphMTb8USUtpAik5lHBdIqWRQOogdxSC4jBC1g9WIuf2BKKiFde6ihkj2nIzUcgArR8QmRxPDqmX+QXUdvxvkzYfyYk0jh3+RZehQ5MshPWOkdMn2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxRkIzyf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bd9DuAFq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxRkIzyf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bd9DuAFq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68R1XuO21908997
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Obygb7aPUf7Z+CJroQ+0vxrBlTyHCRZkXWI/whnPI/8=; b=GxRkIzyfJNJqW7s+
	qWt1A+ohXbjcyJ2NkEKq74pQIsMhxsTiOanYYlmcTYuFbG9mOvQ9k1aBwkvCNpR0
	1DYL+UjR1MaznzBiz1J5dQ79+IQNTl6+wNjHjqcB3f2x0uX9HkHCg+mOwZ9Jsb4F
	6vr/Qd+VkKkLS87xPEL24rtfh1ZYWJg4N4dnx8AcU62mwzSINgSQFRRZOMEjA53G
	MN5aVO9YjfzwswY4l5LrAGXUj3ifOFM4GzsBYLed3HpQudGkn79Ce1KUTT2TvVAm
	tRIOqDcEZVZXNueXtEgDzHGX/p2xseRjVexZ+JP9crYWghfiD3aleEnVHgwIiT5x
	mNEbUw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb1p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e82060977so439892785a.1
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790515800; x=1791120600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Obygb7aPUf7Z+CJroQ+0vxrBlTyHCRZkXWI/whnPI/8=;
        b=bd9DuAFqaRB27onP9KeFHuwbSHJlbqVBZ7Tu4FQqu8bqRbky8FZO0azlUGhzWPK8fJ
         iFf9VO8CT/gaCc/0OYmoIyaip1yeY03pUfijt/zUICRxodcDlVWpzhmyTkKRUwZf9fMx
         3FJbTQ53AEOYTODcK+ZmLfPscPZtL1kVr0qpkYWYNvX4YLM+mZt+6cphx5mF1q3RGX1S
         IQYPeZpr5DxWQAwLPfrHqtExPyPqA2upctx0Kcxc3nsMtP9XMj4xLUfBGgc94fgR88jV
         NX/9LI/F7eVyf/nji0oRZoKUaV2mKwQRvhDAgqf1JHxsTH4x1/0n2t/j0/TcWYleBtBW
         3psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515800; x=1791120600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Obygb7aPUf7Z+CJroQ+0vxrBlTyHCRZkXWI/whnPI/8=;
        b=BLlohif/TVNdLxGla2ccjD3yHw2jhWRAbkQTcfiANEmsb41AAKxfu4uK8VPFmv7c+b
         G6hHSaMZw3ax6u3U8GS56o1Paae1OFMiXgh0qTijvY8T/JHwcffSl84wYEDNXApz2H30
         n2W/J3oWBlP2JyZczdtxGAagf4hZQb5P0o3e3l+DhJ8zPTY6KyaaSiuiW5k2TLuiM2zl
         bIOfAO4optjtBqEc0P6MF9JRkZyN5yDeMl5P9PtTJ59x4AgtCM8npQKeGpOhLMRIdNSF
         D5kLny/C/RiG23VndexT3dEp4pB1aH5fhXGNHp9y98IFv5jKCXd1A7oDfZs3jgX8/x8r
         Uqgg==
X-Gm-Message-State: AFuF++mRGn4iWFMRxX+bCfKbtgwnqU37Ok3GY2PBovC0NXiaijkb4zRk
	AXD8WVV9jz4Km1SbybKX5RhR27q9X6AFZM34UJtV5SDAQs3HmDDgGxknhlLu+DtpuKL6nmVDww1
	KFMo07f00nVSjU2Y4i08ugE8sU5J0NCzOMVp9JtClDwNd+HAQBbOCNclpcvv6om0=
X-Gm-Gg: AYBFou3a/1WwOCmLNYHnk01HTnIe1Yy/5SYEFOYzLrxGzWe0FW3pnfQ8f5rzShXbWlT
	fTs7ePy9Ri+ktFxXfU+tifEy01NeC6DMQy2yfVJ0hUranVv6GSg6LDspVH5ScQR7C5zq4Y2gYey
	ckh18h5m+qKAMwymDMfXF8aqQqrskq3w1VpfsdICf7S6DWJtTH+0q1nDSwzC4SDJ14ExrVn/gok
	b3VSgXXs6IqngLQBT/Y7k8SLT93RA1jxMy6mO/mBeTYiYoF3WEfbgU/6WB5cgh3/RJ2PywhUq2P
	rK5U6wlTH1oSkH/0K69LaJ9JFb4+2LK5awDRFm+R3YgfYlC7rV5YYTc1iHhTi0Sol3LOr/Buz0D
	2yR9tEMCdJgdrrjt+Vlyc+KsWgQVJhF/Td58rQJIxQ/wXQrq1QXv0TLqbVNjYa6SVwbsoVwfg2e
	Q7VBkpkGqZYnentJMaLS7PG0euK4QgNwoxBeWKfadN2UJrw78eWX0=
X-Received: by 2002:a05:620a:4608:b0:93c:7800:bc55 with SMTP id af79cd13be357-93c7800d31bmr107414485a.18.1790515799942;
        Sun, 27 Sep 2026 06:29:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4608:b0:93c:7800:bc55 with SMTP id af79cd13be357-93c7800d31bmr107410385a.18.1790515799360;
        Sun, 27 Sep 2026 06:29:59 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm94636745e9.15.2026.09.27.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:29:58 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 15:29:53 +0200
Subject: [PATCH v5 4/5] i2c: qcom-cci: Share the timing table across CCI
 revisions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cci-clk-fix-v5-4-4cd498559ae5@oss.qualcomm.com>
References: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
In-Reply-To: <20260927-cci-clk-fix-v5-0-4cd498559ae5@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Ru8sY8poe606UkQnNt1PVPuLfbSiEIfw
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab91a58 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=aKP0LZVuKWpzAjQh7DIA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Ru8sY8poe606UkQnNt1PVPuLfbSiEIfw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX/dlUofmzjYzS
 Rt/ezR4ITBfvRomtGZ1HKoAJCwDxerHphERGTujDjTGYHBEgTDWRCUUvglkJg/pzwBH9HFv9XoB
 hRT1OFeffbOqudTxagdFP02I9FR5Rk1PsjJe4e/lBAgJvMJ+uppJqHhdthw1MriiNjtrAtfBf40
 SvOiZ6a+uQVUgb56ifuDitECDHbrQSm8+gHggbj26J8QEFEBN8hQ601+f97HsqZUWDJR30/iDKl
 WFwxrJHqag4KbmmD5asMzuPb+PN6IdZh7Hb0e63Pq5LFSeE5y7WhoaesIHVCokJmlZsdpmFfqEW
 4qirk3XRX+BN3BUhKIw2PPVrEeTOEtMZd6wG5KPGgE4ylTM5y2jBEHWaFj3OaA6S+5fO1riQSDe
 F5n9VUrFPlXGr7UakRk8op3kbjUIFdqPXGSId/tvUokyN8zwpaW9BwLkGjZHwLqI7/wdQ2ZW9c9
 GSpRP24TD6bPEcIc7OA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX9xbF6wGAlyUo
 qIaBhPR/aCK6GXyqaZlRiEWxmRqfs1Af+QkTIzK0zBkvsTzLPzOUXiddLoozPi7Ve8HjAOz1dO3
 KWAp7qe0ffEFDAxNDjLryVOKHEUVSf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270053

The hw_params timing values only depend on the CCI clock rate and the
I2C mode, not on the hardware revision: every per-variant table used
identical values for a given [rate][mode]. Only the set of supported
modes differs between revisions.

Move the timings into a single shared cci_hw_params[rate][mode] table
and describe each variant's highest supported mode in cci_data with
max_mode instead of duplicating the timing values. This removes the
per-variant timing tables without any functional change.

Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 181 +++++++++++++++-----------------------
 1 file changed, 70 insertions(+), 111 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index b6fa37a306758ec33ede6fcc39ce4412b86d9a84..21695c744502f7fb5d333f1272f3771e4d9d5508 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -124,7 +124,8 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
-	struct hw_params params[NUM_CCI_CLK_RATES][NUM_I2C_MODES];
+	/* Highest I2C mode supported by this variant. */
+	u8 max_mode;
 };
 
 struct cci {
@@ -249,13 +250,76 @@ static int cci_clk_rate_idx(unsigned long rate)
 	return -EINVAL;
 }
 
+static const struct hw_params cci_hw_params[NUM_CCI_CLK_RATES][NUM_I2C_MODES] = {
+	[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
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
+	[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
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
+	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
+		.thigh = 201,
+		.tlow = 174,
+		.tsu_sto = 204,
+		.tsu_sta = 231,
+		.thd_dat = 22,
+		.thd_sta = 162,
+		.tbuf = 227,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 3
+	},
+	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
+		.thigh = 38,
+		.tlow = 56,
+		.tsu_sto = 40,
+		.tsu_sta = 40,
+		.thd_dat = 22,
+		.thd_sta = 35,
+		.tbuf = 62,
+		.scl_stretch_en = 0,
+		.trdhld = 6,
+		.tsp = 3
+	},
+	[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
+		.thigh = 16,
+		.tlow = 22,
+		.tsu_sto = 17,
+		.tsu_sta = 18,
+		.thd_dat = 16,
+		.thd_sta = 15,
+		.tbuf = 24,
+		.scl_stretch_en = 0,
+		.trdhld = 3,
+		.tsp = 3
+	},
+};
+
 static const struct hw_params *cci_get_hw_params(struct cci *cci, int mode)
 {
 	unsigned long rate = clk_get_rate(cci->cci_clk);
 	int ri = cci_clk_rate_idx(rate);
 
-	if (ri >= 0 && cci->data->params[ri][mode].thigh)
-		return &cci->data->params[ri][mode];
+	if (ri >= 0 && mode <= cci->data->max_mode && cci_hw_params[ri][mode].thigh)
+		return &cci_hw_params[ri][mode];
 
 	return NULL;
 }
@@ -696,30 +760,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
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
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
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
+	.max_mode = I2C_MODE_FAST,
 };
 
 static const struct cci_data cci_v1_5_data = {
@@ -729,30 +770,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
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
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
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
+	.max_mode = I2C_MODE_FAST,
 };
 
 static const struct cci_data cci_v2_data = {
@@ -762,66 +780,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_STANDARD] = {
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
-	.params[CCI_CLK_RATE_19_2MHZ][I2C_MODE_FAST] = {
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
-	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_STANDARD] = {
-		.thigh = 201,
-		.tlow = 174,
-		.tsu_sto = 204,
-		.tsu_sta = 231,
-		.thd_dat = 22,
-		.thd_sta = 162,
-		.tbuf = 227,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 3
-	},
-	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST] = {
-		.thigh = 38,
-		.tlow = 56,
-		.tsu_sto = 40,
-		.tsu_sta = 40,
-		.thd_dat = 22,
-		.thd_sta = 35,
-		.tbuf = 62,
-		.scl_stretch_en = 0,
-		.trdhld = 6,
-		.tsp = 3
-	},
-	.params[CCI_CLK_RATE_37_5MHZ][I2C_MODE_FAST_PLUS] = {
-		.thigh = 16,
-		.tlow = 22,
-		.tsu_sto = 17,
-		.tsu_sta = 18,
-		.thd_dat = 16,
-		.thd_sta = 15,
-		.tbuf = 24,
-		.scl_stretch_en = 0,
-		.trdhld = 3,
-		.tsp = 3
-	},
+	.max_mode = I2C_MODE_FAST_PLUS,
 };
 
 static const struct of_device_id cci_dt_match[] = {

-- 
2.34.1

