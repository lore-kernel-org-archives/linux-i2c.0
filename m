Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D593C9429
	for <linux-i2c@vger.kernel.org>; Sat,  1 Aug 2026 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615064; cv=none; b=Nf2rlObKnqeVi9uXUoE6bBd9VVDMms6LjSOXmRrntnN+gURtiBGdDqN9ZL/XAWv7+1e81WHtNpGjKCxAvdHSeQDHDlmDl42m6Za25GCN6XkMZOLxQiqjqy9MjIB9d4qPu29lvGCrupH4FLX8UaDNIc44i1aNNRD55pJRhsrSoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615064; c=relaxed/simple;
	bh=Qm9nFvVcaeUvmOuSNzcR9T/4tIfWvikQ6cPgHn/XIVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2h4r9SOfxTJ5pXEe3cEQEAIZ/dRsoWjZrKODxPFk4VxoZwlzQ0TnclqIlGAO/qQUgIdT1Hr5VFlef96IA/ojP1l/zTrh6SAtYeGLrTLaF4juwzluKkTIZPv5kyxpiWDBm8I4m2Vf1F3O+U2bFDQ0gSKiiJtW064gG4qIga+hSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IoS97Wix; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iTz6inV4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IoS97Wix";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iTz6inV4"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671J04Kp3716865
	for <linux-i2c@vger.kernel.org>; Sat, 1 Aug 2026 20:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6cxTWYCLqozQ3KKHFsvbhod+fQlKTK8UpPfC+lxtFQM=; b=IoS97WixuaRtCw2Y
	FFaWEHceGsknr/njwY92Ddo3SeAt8oobsyRa3JLBz2oMADnw+aDtEJseZGNaBHoH
	nMINnzwgu0pOwVol0RS7Bc0+U9m4Iq/N+PIM3Dk3yH6LOflnteY0A5CHVk39tBpJ
	xYmMT6PRJvNUk76vykZwfFZQxfy56y00PK5juCbWLdVB7OkuwgBNTrsiICC/FOz9
	ObG12CnCqm5aM7qmGdKdDEkbZYyj+gT3vSLz5Y00V8Ym5CNIP9+HOHjeWlNQStwl
	yUgwxeH0ao92R1L1JlbI6Eh1U2Zr0tK8wwyydfFWJHvrNxNL4dxBvoaS2y6ED6qW
	i7I2bQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6hng1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 20:11:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bf321d786so21054761cf.1
        for <linux-i2c@vger.kernel.org>; Sat, 01 Aug 2026 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785615061; x=1786219861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cxTWYCLqozQ3KKHFsvbhod+fQlKTK8UpPfC+lxtFQM=;
        b=iTz6inV4hvhM2oNW41AN8B5mJtpIZld+Ms0DuHTpSK5GX5ZnpW+oVp1focTOhjsuXM
         +MMdE7NH57oZw9Mg575M4ea8pbv+uz9N6G5qB0o0pbHuT/InRw7votD3fexF0xS2GrIo
         7t/bIYpzLLEJ8D1foQPxNalrHghCjJGnX38+bB9eBFq2n2KJTw4tYnmvaMtr2onjSaqy
         7CrsmvbUsxC6ILj0i7dn2bieLCFC+sOvQNk22bT0wY7yuWlJXDlXNJeit2QeZjl1f0Yo
         /DQSoVKwhZQFVzqD4ArE+2etwUjtPXUeNMnpB1zIWf9ZxM63v3hY9NQKvP3A3xGvFOOJ
         EuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785615061; x=1786219861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cxTWYCLqozQ3KKHFsvbhod+fQlKTK8UpPfC+lxtFQM=;
        b=CDYXjMQ1lRN40fYkTnjBUOABq+n3VKRlPvvg5hles+opGu+RDpvd6b/fhRFTmZTi5W
         1RThiPbQYuZ+KKCQqReUFWsJ6Rw5Zo0QlxiWQGx5n30RTwkmZeSSBgPLHROS0ZXAFG3K
         9ZryyHs0ES054J5gekL2Vy1jjbDNG5QbzEjpsKSEcFmWEwociSeM3bvjleb3fdlWLS/l
         vifc7RqBq1m4zcaqF1YiVgCQldycNEBwgNdVyx9x+eg1H6NZgqjWE97CCEH5pdPKhr2T
         /ZbvYM4DVPm60/NvVXQWYzEorNPwnNMHlNKdvZYCjzOBYqASVlbmnCK4xDPou3l4gogW
         troQ==
X-Gm-Message-State: AOJu0YyecNEbvWxRtmqc/G/ycTIjWU9RU8ZHjEnNJuz/TvfeBTTbICjK
	bYG/H+YAwhFIeZv1SA7TGShVPNoQcfjtN0HrjWqelf4yrfg5O8tY6+ibxW1uYDuvfp8tuI5E/mp
	EWHFw8qy8FY0GU4W6w+nQ9hBlGksimPqXFoa9p6tUohGTvXNnhbVsCglgNrYLBt0=
X-Gm-Gg: AR+sD12Spv1N7bE7DshGoY4ESjQw4+IW74wcOhtc2Yn2JjMOc6KW6G12mPuDrpNot39
	KGYq6VLzovZng4x4PnfPHVwDcjI1uRQKzXZbI+1khXT0x+pmuV605dxvt/IW5/Lr99Z3GKF+5Ps
	J+QIzlQdGGDuOkHEXUXAZS8fAxsHNwXxFx4RpDNhrmlXs3onkV8wyWmQO/ZQXK1nLO3TEgnqXAE
	K6yDHdvMAXrxCzEID+chDv+Dq0I6s1PfQqlCzdszSNElrWeKs9Pr12W0met4umG/5IAqeWOZ7xo
	PKzfGMduCCY2TTTFEIHRFRD3FCExtFUL8RYz6afq5WnoGbj56HBZ8Fv1+A78mZfjb4C71NokZDu
	AXuGVBab4GDPDkzYyCk9+HhLg/zDvlf9/jxyxL75/D7TLE/hrAtHs8b3/qBdLXraceIAqT3gWS3
	LX9+TW9jpcRArVlSnn9hz4RHK6HBiCTh6VL0KVUQFRsn6E+xb51wTQ
X-Received: by 2002:a05:622a:1e09:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52b566b1487mr93941391cf.18.1785615060882;
        Sat, 01 Aug 2026 13:11:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1e09:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52b566b1487mr93940701cf.18.1785615060441;
        Sat, 01 Aug 2026 13:11:00 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4537755sm358499066b.54.2026.08.01.13.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 13:10:59 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sat, 01 Aug 2026 22:10:46 +0200
Subject: [PATCH v4 4/5] i2c: qcom-cci: Share the timing table across CCI
 revisions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-cci-clk-fix-v4-4-e1d80da54e01@oss.qualcomm.com>
References: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
In-Reply-To: <20260801-cci-clk-fix-v4-0-e1d80da54e01@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        konradybcio@kernel.org, stephan.gerhold@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX6WmbLWiJm0D8
 0MpjzG8wl4Jnu93pKdbMZAy7O6k6rpIzFKeIJWNJTwPR4zoCFdzwAYT4K7szpJXKnpNvY2jB7nG
 b7kw3Y5fkxHeX3/RSgXP864MRfy8ty8=
X-Proofpoint-GUID: bu91qtkcKR0ySPtZzbdF0lTc43eDPYvO
X-Proofpoint-ORIG-GUID: bu91qtkcKR0ySPtZzbdF0lTc43eDPYvO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE2MiBTYWx0ZWRfX1gqeZ5WUBC6h
 qo5F7yUIps5upJDXIHAjC7NqQnHLgE0tuHTa3wJIPePYKXaVyLzMScBh9zZdrKLXX3Ir6KJLzv8
 8UCb7wAmZoF7SG44JerBh+yzGmLQsxhHd3dQlvIv8/45NKmxhH5rHtjXdn4f4TylC6P2Sigherd
 wcIQY5phfkWP2JfgOZzN2tVhJJXAYl4U7ll553CUfjAT8QpmOUMAX30FSxwe9/A4BCTanUB88Ep
 6shgv7tca+UKuwa6LpHhMLAboeNMcpGezxQqnrBkrXOyi8eSNFvoUnVxTg8Vm8UPALkkdGyWIqq
 r1+Yio3xbrBiAWG/ICMbLoVU7bZK+emc58OJLNQLkeWOJbabSVvV69jvMInjtu+ku0Car72XUtx
 ck3WK3PlNESofSRPBE7Lzz7eeGxGMkmwFy9cSkM0fL+t4dIVJ1GsQ6CEdcrTorMDYeHHurgbkFT
 dgU+vUvcX14fbaCoKPw==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6e52d5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=33lF9BsO7w0KwNcR5BMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010162

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

