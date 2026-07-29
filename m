Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243847F2CE
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327980; cv=none; b=Vf9IIhP+kvKk826pXeWEXPKc6gTxXB3pB5Ii61aG1hOR4D/kqFFNf7dXJF7vvuQz5jyjr93uaVRqhVBdEZhGNdr+YDRMKRjTzPkLY1btl1cqvzAB04s60J+DH73OkBmino953sT0E4VzHQ3iXfCNhENHOJm+SnotAxKiQD+IUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327980; c=relaxed/simple;
	bh=xz5apLrFQTG0+j1rBEfyBxZ2rw8AdYEYsjKSDnJQrGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJkt6Viq5+6Kw8noC9qghXPXWoRcTWXRLbX1/63IEW7PdAX1DblPotnq7lJfUt0t2lwMNk6kWCiyQ/aR+HSMdfZWMKSAandvLyFMX2qIWbl9T1CzR7jG9dIvFGo9u61B8fbqrrCgqh+RADVGyi4xhYld92WMn9770N6HZ/C55FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZiJSyHcp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lr4VXbGc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZiJSyHcp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lr4VXbGc"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TCOJ891814630
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O2IL2h91jdjfQPSi43/3wX3WqbsOxbgBY6Mc820EORo=; b=ZiJSyHcpwi9F2Tfz
	0fnnepWLeJoL8a+eRtAjUin8itc+oWyW+Q/7Br0Jmt+knCVh6yjmJNVs+6zUm86C
	lR+BZMCRE+cId5yraLLOzIxYpqcN10lICzbNEXfCiCxS55pUr5qp8XHn9BA4stlX
	J+XiugJiJFrP0ahOfQEOiZNrlDZFyZ2aVav8L/MFjEPkC3ZUwmeJBRzkQziexLxS
	YVGRTMYWgGRNIyPgveafi7TlFJPdFi8LQe5fdsdDX3SIFqCI6vRZbgSHjVvK3oZk
	q/lPslW7U1FxF0sr7F+cEn2s501ZxjEVGUaAAdyFqlMvi6Tjr4369o/KFQt6S0WL
	an3wIA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhg8r086-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 12:26:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51ebdfceddcso11006901cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 29 Jul 2026 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785327976; x=1785932776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O2IL2h91jdjfQPSi43/3wX3WqbsOxbgBY6Mc820EORo=;
        b=Lr4VXbGcM8/HGl+zGJ2WNba8G3oCSn0nrV89diq+cQzoJGvB35O+gqe+n453+Vzk8d
         KmuTzMod7Mz7RdxGoipD+WYk3O7Fwe9HSs/9NvaOz4K33bzBQ5uQTh/7Ux2v73yEKUAg
         iRcTvzSHSsy1MeChLdgTfBbPle0770QAiHjmvRtPlfPkCrceIo4Y8zwsKC5rpJqaNlky
         2zpfmgkdXSMthqbhltVvsskarDvNfW2ghx8w5wpRMlarQbyGq4zv4+qv7PqY2zRqjq8x
         Qw36DqSYQEBDMGKcYP3cSm8V2J22FQMFDHumO67HDzHo1l13qRazbZ9PgsJtZtol+76h
         FJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785327976; x=1785932776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O2IL2h91jdjfQPSi43/3wX3WqbsOxbgBY6Mc820EORo=;
        b=ZajBwhooSKiL6531kbR8kMmqUNSUGjDzihH9nih/EW1AGPBPjzzFozjDSj3qXZ21fh
         YAg6pkc+O/URUB8cLKQLGTMPloBz+CBRclg9772dhtup6aukOJI+2W3LTO7lnxJTZkR0
         Zhyj9MBKrXjFkBp58h+KB7x4w3/zf7OQUOTl75yEz/SaCEGR0n6JFIdE72g6tYcDAMDA
         PZLeiqSgAm9tCWreiRzWQsULlJF5s1aQcjRfRK3mcdP/yITk9pthfEuxcGN7FKd+8sIR
         3rUPb0X/Xe3QHXhiw/FLXsuJ/dujFW68c2B9ju1RjWUUVgEtHHZsQvM+vw8JrvA3U/WY
         2wBA==
X-Gm-Message-State: AOJu0YxeqEakzQ39MvSvuz6XW4x1pJ2qFtiTEV2bxtWVNs+UZtn6Q2d9
	/6QSLucWK7C/kvjbAlECEaDh3vqiJdjxuzOM+SOjxY84rY54+czyQ3pDvM73Kadc2LR8cCIW86p
	tD0/S0Yds0yN687CjUZ2vaFUAwaatg29dKnTtWeGh48a4HvS2inHmczelYUibXKk=
X-Gm-Gg: AR+sD10s6124YlR+7HJLWWHx8luYWLRzvc5/9ZqqemW3nKYZKjh9SkCnI6IWUyzc9KO
	D9iY4yFYB1Cq7T2l1KOvXI7YmZRwBbkDEC+FF67iDSPF4FKqzFU/b/2rGG38vfXpkN3vLhMJt1E
	xUQw/ib0WxAe4Kzb3CGErMVnc4i8EqyK0p1GF1WCKoEMbM60Bc43K2TcMf0IdG3PowTrUSXiKjk
	zsWu+iv4D0tyDjGuaVkjOgCeF3ZtJH/QFqr4eUslfytvoMOSqWwR5bKQqmZ1CDqFewVEmf5DVJp
	toGILXzuZJAWTvrp0v2HPtGlg0079dTIXFOS9m4hU772etUCTOBS4xMOdyGIAgItTqE1Kt/C/U0
	1ldM0KzxkI6N4n32voNfW6D2dE6zzcp2TX0sQ0j+qZf+aitp49LjfOAJ+UexQUXagiOpDWMklDB
	jru2vm5sdcCYeZkqQQl3WYK8utbALHEIBNAP014xigLKB0XbbyEUer
X-Received: by 2002:a05:622a:5516:b0:51c:f33:9be0 with SMTP id d75a77b69052e-529d70d5b93mr59144211cf.55.1785327975726;
        Wed, 29 Jul 2026 05:26:15 -0700 (PDT)
X-Received: by 2002:a05:622a:5516:b0:51c:f33:9be0 with SMTP id d75a77b69052e-529d70d5b93mr59143851cf.55.1785327975151;
        Wed, 29 Jul 2026 05:26:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm756343a12.23.2026.07.29.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 05:26:13 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 14:25:58 +0200
Subject: [PATCH v3 4/5] i2c: qcom-cci: Share the timing table across CCI
 revisions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-cci-clk-fix-v3-4-f3c731d1596e@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX1zwXvNy6H09f
 cAJB8v7jhvdgx+vbV6jDk7SMHdnXDnHSVOfXThtc2PNKWxEdU7Z1a+uautTlnCYrv1gJIj+ElvZ
 253f+4DQcKeCRsxp9Ds1BOC3pXobw+c=
X-Proofpoint-GUID: qsWXQWmcXip9-gvXAiZv-BCUkbiLUg6M
X-Authority-Analysis: v=2.4 cv=LOdWhpW9 c=1 sm=1 tr=0 ts=6a69f168 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=SaDyQQL3Qiq5HZUYNQUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qsWXQWmcXip9-gvXAiZv-BCUkbiLUg6M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEwMiBTYWx0ZWRfX0ANLM3JqN7o5
 dudFjKXVogU8UaaA94C+baI/c5t3uYjdXIwUDvOMCyApxYBZdX+FMiQhduGVd4MuFAMdpLbWDRX
 AOW88objXHcu6hhql9TlOBnxheKU8rE/j6J+HfzXnJf0w3WrNduxkBrenoEnOqqhjtSPmGCIEi3
 HsLX+k08Qp5amaaLgocEN9oDNUP2yEHsen2q2msrFk2ka9HEnmFlA6dJlM0QMEFkTIt70BlEWQG
 qRRL1o1l1H9ulDFxtuiw4N8PotHS0hszCVTugRdu4zbfldmy20pWjKbpH9f2YMrjyhefaeB9T/Y
 8MBVs5gIRi7zo6eN9UFt6TL6gWJO+yDCys3aoM5STke23C7UHavsaeHeoXJl17ADQjOscstIHDY
 YlNXfhNfACNtfgiuFV+UryMg90LVkLNSPRHgaP+SCiIVk+C4m+FkQtXMQgNU9ciLZsDqZg5pYE4
 d347TpIHzbcbQHAdmmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290102

The hw_params timing values only depend on the CCI clock rate and the
I2C mode, not on the hardware revision: every per-variant table used
identical values for a given [rate][mode]. Only the set of supported
modes differs between revisions.

Move the timings into a single shared cci_hw_params[rate][mode] table
and describe each variant's highest supported mode in cci_data with
max_mode instead of duplicating the timing values. This removes the
per-variant timing tables without any functional change.

Suggested-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 181 +++++++++++++++-----------------------
 1 file changed, 70 insertions(+), 111 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index a7b9a8d43e39a6bdeb47250c34ef7474bd7138f8..8e4641de049e56da5afbddbab122946bcdd4f60d 100644
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
@@ -712,30 +776,7 @@ static const struct cci_data cci_v1_data = {
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
@@ -745,30 +786,7 @@ static const struct cci_data cci_v1_5_data = {
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
@@ -778,66 +796,7 @@ static const struct cci_data cci_v2_data = {
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

