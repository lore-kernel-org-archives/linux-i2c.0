Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8253F12EC
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515802; cv=none; b=MQsH+8JDfGCtRzx4X3b9P5iccIjpKiyI7F83UDObPlg26RZNzfcmseysxQtb7nt+w3FriV3pNIQTiWuYSkhb9tXaPQZlJxU90c3Vu/2n4H9IF5O9J3QFKcgAF7S1sOLWtmuOTdvURU9jInpdid7zQWOVbkOTT/w3nbhcedIC12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515802; c=relaxed/simple;
	bh=AiV+UgMZj/8Xbz75FJ/bRBCuJFbHFnWTyvBbyi9SIaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tdJfZ44Yzt3YEL0JAEvD9KAq7hFz9hGJ7Uh1bIE16pyrfv+MnFak8nvxFuybf0Oxx33QWt8UPqPGijXBMxCgxRmc9dQW27qgNpWskhgsSq4eoKsO1wPsMtPIjdqhzDOtwSxU/ga8gIKAb5CHiIUdd/LyZWh5Oib+2Uvp0dgLVBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNoGM5u5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFcg5ZFo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNoGM5u5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFcg5ZFo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QMMSsD893068
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=; b=HNoGM5u5/oUKnvLx
	P5MwcDL+ZdO+Y5HfOMr/uflKSOHqpmkn8QTMy0QLASSN9o6OtvCG0nhgv/Y8ZFRz
	Vm20jVnxj75SEKurrlaVhaODh9MR83oKviAJB9sNWg4KMSOlBAgBfyhMI/kmiLFj
	ZaQ99SOi0l5Z2wFa/YsaA+cZup0QXEGjpfsnbNxCyNlteETUpqZYfiyLZhvGHazo
	qNw/4p+xXdnuewivtIjTKwlA7rDymbOlmvXyTYVxr1kheoQiD/TELjbrJI+uyydk
	cGmo08cQWYZ/Uff8b9duxdNyVRGOqUFr+NRpxLd7ltQ/JDLD7e8hyQAdEK3JvfSH
	zwMBqA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3apx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934963b2bc0so579285885a.3
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790515798; x=1791120598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=;
        b=QFcg5ZFoho/zbdPRsqCeqhMaiGkKrUjaFDXhs1nVng/ZFg7UctFe/rKxYSafcRCk+J
         BBOJsHYoNWkg5uJWgpK0vjJV+hpdc4nRo6Q+seay5+i6aSp06pCN93A3U1Zh9QZ1T4IP
         guJKSStDt2TqXj+qKE25GEqvn3pQX6qXIKvxE5bDMn8yZwYvBQ1tr9YoBfTrtGOeoI8C
         7FgFJ+Gl1VAyG+eusJPO/IAX8FXtoxgMtjnvHoaaQT0Cw0LThZdSaiGpS1hu3RPbj0Gd
         dZ7GDqN1j+c3Al2BMpxoN4G31DInSSwIOHcSpj1VEU82rJFyhv1sFAg9MUzOwMeAP/cU
         m4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515798; x=1791120598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=;
        b=yJpcPte53x4qRAMbP4p/gfU5fGh6nS9TjvZ0i3F8iQXeORidm2PKwCSvQvnnZ1BwhW
         kes7Dc16NrZvksFoWjjKNyQ8jhq63HCvrxTIfsUotifPY6RR+CYd4wDXOaXAGhauHi1a
         b5a8h5oS6MvN2qnuOYc8v7jUMYMcWE8KCHiK1UsHKWlXEI1kjg9ohYzilkR39XhhbPPZ
         K5ZDNLwsbSkjdKJsg/jCrVl+/SJeCnFMOWENzhSnddFkAYU5E8VWSG41qW6U/p1bzvJS
         kVlGQS1Ktdn5YqNgH3U66W101v4/niyRLgV3F1nkGNnviiVj4UXo/3PB7w+GXGSPTM9M
         PUzA==
X-Gm-Message-State: AFuF++mndsH/NsZqSBkbTV4hENIYFbnrAKnQMHQyjyYrfSkjJdcJu7Bi
	eI1o+bU4tqf+i7DokTil5lBtNFJ42c5YB4w2so7RzX7KGD4nRMHml+WFHxka7KNbksbP9beeDMT
	mo8SVVwib8KBUExK7hBz5seJAvw1fV4Hae9kUZnNcKzoBFIfMEWFbuJ/KZ8lYVzs=
X-Gm-Gg: AYBFou2FS2q8OtNkgM/qrFD51dxo+IEjrLysICEZL1C0Eo6XiHkA/t3Iegmnwkkioxp
	wjkHGTbJlgiWFsZmmQpa8YADyYkPgzattmSnGdi3eatW0mwL0sQcrankQP7+PKCudignyNQxqIU
	LlNG5/0ZM387DD+cp2zUiCqQKUjZ0ipwAwBq6P0lUgV83JH0CLQzBvccy9fXS1rnw5G6y1so60c
	Qx5Mq1MCjBN0C7dyfPanVa7a0bjZHKpuaX/EtxhBs8GF1NHrpG5CQPgNAR5x0gVHcDSPWwu2Ytr
	7DHn80foRVUIu6ShkXpNzr6nsJQdilwzMD81mPVW0zet8r3/31mgfIoFpgHWVeoebzNIi2orQld
	LWR6pIk/wt4Ll96XeeAn9G+nW8c2ijJ9eQffiFed9rmpRQ3oKVpOaTIYb9XM5DuwedGUNmGjcGV
	pY1Y5ABOq1wjti8c2Q63mKjjI+nkkcBHq1wwE3rwwZ+UM6HDZCCGI=
X-Received: by 2002:a05:620a:284a:b0:93b:d79a:c460 with SMTP id af79cd13be357-93c43e0ef20mr1570232685a.56.1790515798339;
        Sun, 27 Sep 2026 06:29:58 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:93b:d79a:c460 with SMTP id af79cd13be357-93c43e0ef20mr1570228385a.56.1790515797866;
        Sun, 27 Sep 2026 06:29:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm94636745e9.15.2026.09.27.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:29:57 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 15:29:52 +0200
Subject: [PATCH v5 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cci-clk-fix-v5-3-4cd498559ae5@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX6dqHJD4ktp4X
 yilIpYSRGTjttoZeg0yaCWU8CapqicAJEawRIE1hisJ07M2I0dudlrd0CGM4z2xY+4c8xUnshRk
 xkH/D+uGNq+a7RI++jVF6zhaP+zdTMwpDMqc0Li1ejGfwKrpmyUhX6mSSHXeozyngdFzT4hSzKi
 m9xFG4gMU6tCEogRZTPtQ7B9Y26ei3swwJ1dGn6gFx8spnSp08aKAr0xrzPNkBOxJvokfXz0S0q
 XoU2HaXndhw5wg0yzyS9eLUcvQRVnq4S6xMigWFJSJ/ngtj3lQ137EW5LlsHXJW8l95eJxqq1tt
 88yMca+os88Ggka3eBZb2YI7T8Jlo4V1ZPexG9IwpmGJd6mSuFDzpNFnGbgaeJOXd4rmhCWlqiz
 WOZF4Frja9J9G1rlFzhwDRUwk3HMnWNx8rB5XUvFUbPytCd0PgFgadD3lM3AeO8M7hz5o9tCiH9
 SMtjDUjX9pR7YuIv3rg==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab91a56 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Ztu6QtnhzlsJnfPSskgaBw-n9_0hFBb1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfX5Pw/p0mwo11k
 JMcHbKG6RrkouR/fYNqZHp+ien87qEnI5VJ58EOGF+u/fCeJiaftoHSB8YOm1bW0eLhBMDX5bVr
 7aTtr+72uqrWXpFZRyb4/csKEOLt28s=
X-Proofpoint-ORIG-GUID: Ztu6QtnhzlsJnfPSskgaBw-n9_0hFBb1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270053

The v2 CCI (msm8996/sdm630/msm8953/...) is normally clocked at 37.5 MHz,
but its CCI clock can also be configured and run at 19.2 MHz. Add the
Standard and Fast timing sets calibrated for 19.2 MHz so that a v2
controller left at that rate still has valid timings for those modes
(Fast+ requires 37.5 MHz).

The values mirror the v1/v1.5 19.2 MHz Standard/Fast timings, which
share the same CCI clock rate.

Note the "v1"/"v1.5"/"v2" labels are arbitrary driver-internal names for
the cci_data configs, not actual CCI hardware version numbers (the real
hw versions are e.g. v1.0.7 on msm8974, v1.4.0 on msm8996, v1.6.3 on
sdm630/660, ...). They only distinguish the timing/mode configurations
used by the driver, and will be subsequently removed.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 1092ce0371429ef64c7cc44cc23a42ba4c135af5..b6fa37a306758ec33ede6fcc39ce4412b86d9a84 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -762,6 +762,30 @@ static const struct cci_data cci_v2_data = {
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

