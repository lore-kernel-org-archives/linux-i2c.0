Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8B4C901C
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645909; cv=none; b=NX6ik40HOSQxGlj3FrDgbXnB3hHjjCXP5vi2FNBZdtMDDSnAzuGBP+ZtWUv67S+zOi6UUWQwW+P4v4ibzFWiKS3Xi+JkzSKtNdMTmmWRjSWKuuEUMI2Jaklz3Q9J5OScuR/Aqqg2NMwpMcCvUSpezxOou3a5dyRXESgrX7bdpM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645909; c=relaxed/simple;
	bh=wyuCd0m2Tf6gslltmhzVm2PYWYg/TizbC8o2RujD6Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tvhn0vj9UOcSuIUXcb8d1m5wDlCo2aHa6Kg8IpqtYZXo1ughbbm004iviHJyUIDeTvAGgLELbn8NHJVwysug8RzCkfzmGQ9Ir7c1N9J6Z1HjiJ/gwmuBGl6PYAacnA2keVfXQustFCKqG+DdbfikVdMdl+ouU61vHuRHp+HSDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pT4n0Y2F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CUzzD2aZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pT4n0Y2F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUzzD2aZ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDft2k1707159
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YKmjy7alDb+dpOY/O60rS4xgw0LLuCjkEI8V9VvwZ3k=; b=pT4n0Y2FY2mikl8r
	mbThfQJ6GaIN1Xyd0013B0mcX1IR+FqXwAE9TvHaXQSg9c7VWRxPM+BU99BBI5a6
	wysRY01xt1OYgHWlqX9TMb2Kk9/g/VLwBrrBdFpFu6YD5sIpXVrKN+SudwGZXBv3
	S/QYU8JBdwtrdqmf9txP/ctLhCzw20JAgAiw0MP+JPa5NLvsptI5bqaeTb9LONyV
	pklcqdWY4fCN/Zqlh5pGl/SQHBQawU245KL3BQWnXrTwTzAtVKwcSxOeaDikiuiO
	UmwP4+/ap4ySuGo5sC0T91kiQe2B+g15PrKIzffSUW4V/cuPlkc1oIUI3CV1mBd8
	Ij7CMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9ae8jfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf321d786so102082391cf.1
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784645906; x=1785250706; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YKmjy7alDb+dpOY/O60rS4xgw0LLuCjkEI8V9VvwZ3k=;
        b=CUzzD2aZj5uVHqqemepc6nLahQeq8TWnOx5Np8t9g2dt62ZG/E0kIctiShhai64+P9
         ImqSDdI0SGL1gDtEzV19OdX+TMdPrwt8nsyu/OQs6zoszj4hVOKY1C+zwUWPdj800SZY
         qon7UvmWJiKHKVvlvWr0HFDLrZHZnVdBSQKYSVrlzAYqXCCmfDPGjyzrSRMPQpDyc5Ds
         IW+NSBx41SY+wNEHOSlEHgEniDDsinmGtn/rapTZsJ4iCUcPVyUiwoq4zEr00ufhExtf
         khXJoqLMRTZg7LFeNYGla0dv5kFw8HuBr4/nP2O8Ih/i9NRA6Xh19tnL6X3vAEwY7zwW
         yn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645906; x=1785250706;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKmjy7alDb+dpOY/O60rS4xgw0LLuCjkEI8V9VvwZ3k=;
        b=VwQeBhyS2sSGn3mLagnFqPgQrkEdRbDSSq6LNACqz23/e5ETqG0EAL1fWkUZ6gHtbw
         vD9eBG6mrI7uctsSGUjY0zKYQmDKm2KpAjrLqWok/NgUglXrax+oEYmDSQkqhIypPCnt
         06YWpQqUjuswFzuNyFv1ktZqaFutxRdtD+aEFvR+qNyPCMRC8XRa1zjCYj8Guk70gaPi
         5kZAwv/cO1K50xbwpY3dShwnbCnzVVoiqR4ATCIZ+tlW9xmRRgI0uLMjwENQfqGTpHuP
         TLkSNQo6vozru7fvf9cu/+A/tYPZN2OUA7TVz0FD1Sbrcgt3F7SXnIIZY8+ENswBAWhW
         t8HQ==
X-Gm-Message-State: AOJu0YzvfxDGgockeS2dFBSJKcywh0SEL4hdfsZazr8Iuj1iZRNrpIa3
	YRwS3/hZgfPhb847uH4U+deSl6XHZ0GdtjZmBKQUTuzpnE3utYkl7z4g9xvI88vOBG6rlbf2c4M
	IIpgFuAbJQGKWWNoSEx1U/9pQLCE2nuC6HJUNI7a9ZVpE4/L8zFOsK4rR+BJ44aE=
X-Gm-Gg: AfdE7cnnwF9hU4GpJpt6hZ/BeV1Xcs62DjTXWSOOT2+KFPSqj/LV21ViONGcXCj1rVr
	+CxhKCK4o8/R1G8Jp7tCyppnQqFqB8a/CuYmiTXJPxZYDZZR7BfwhJDtIEGyQHpISwGSaEFp7tX
	LLtHhcnsf8qTQm9ja3OVL8UrhyXDajzn1QMDPnW9W7gD5c6Vmep0zK8ukgw7Pn0GX5/QCOQgBin
	RdB4qHS1c23a8YG1iYvWILQckt6C5yyBKYa2Vl7V0BLu8g4znqOcbyhVqntjd090qWUhScCOdb6
	A7P6avvIKeS8AGGkHP2cugtx6LZnwzM7W3Ae3Vh4caocu4U16f174BYiA2oxr1GyaejcPg8VsfQ
	nuTXnTGPXL2AVlZhb037o99HqdSkt1N9cQgEZZDDyBDNaie5sEL137B/zK4lFlAJeiOueQMGMc9
	1w+sffXrnicWxrXMmjvSy1Wk5/t6FmfKv/P58SmD3/zv4Jt1hik3M=
X-Received: by 2002:a05:622a:83:b0:519:51b1:e764 with SMTP id d75a77b69052e-5213e48be91mr169175731cf.47.1784645905382;
        Tue, 21 Jul 2026 07:58:25 -0700 (PDT)
X-Received: by 2002:a05:622a:83:b0:519:51b1:e764 with SMTP id d75a77b69052e-5213e48be91mr169175331cf.47.1784645904830;
        Tue, 21 Jul 2026 07:58:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbba0fsm5875369a12.17.2026.07.21.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:58:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:58:19 +0200
Subject: [PATCH 1/3] Revert "i2c: qcom-cci: Remove unused struct member
 cci_clk_rate"
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-cci-clk-fix-v1-1-5eae78700da8@oss.qualcomm.com>
References: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
In-Reply-To: <20260721-cci-clk-fix-v1-0-5eae78700da8@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: JyaQsXEpZF3t6kcibIreG8_fI4zM3osz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfX/2xFyIMGrOhs
 uBv8PMnAcd+F3ItriDY5peVY0Eo/HTQ+DtxDfIhG5nRlrJbsEiuskww5pokl5ZMnulGKQGQ5SaZ
 XbZH204HgTibBGadGDL7nc4viErtPmE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXzKt1Q0EcglZ3
 XYk/kAUKfka0HhCJqsjVbxrQVZn6ly1cyquFAcc5r0XznYUb0Wbv2Imd7bbRRao+QViRI0/7cQS
 1G71oK+jxgj1YgI+Y7dfKN5pSbSSaU5ZPHxkPJ+Rdp5hWOlWL8pkLLahBU3/JS9d1vT679uvJpC
 RJCxMzM2vdAEaiWmX4ZblaroR0xSTzfrgX5kBbDTPR/I8zrlL0l45VzI2G6Is14VvCj238B4TJs
 cjMgGvlqD/fgBzWD/4Xp31QF0wGlstxaD/2RxCcVuyYgEh8YLk+mzUglehMiK+cda4YVsxBb/PJ
 Z31WUEppTamX2MP6mreJeF65d3nBTcIY05laIFRCUsmfE8/QdsiovgDkk9UugdTM23x32BWg0E8
 j1kSCAGw/euQnW/QhtT/hvBEDwxtHSsqrsf02/+8L6y48uZaWex7UfQ1hlfocIO3WyJ/UMiEuqU
 xk5vEO2CjvtwabpITnA==
X-Proofpoint-GUID: JyaQsXEpZF3t6kcibIreG8_fI4zM3osz
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5f8913 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=wn_r6Zk-WEjAk6jVh9gA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210158

This reverts commit b641af684fc28a07bee9c808eb6c433f9d9bcec6.

The cci_clk_rate field is needed to enforce the correct CCI clock rate
at probe time. The hw_params timing values are in clock ticks and were
calibrated for a specific frequency per hardware variant, so running at
the wrong rate would violate I2C timing specifications.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 4d64895a9e9e4e0bd5e0ccb5c3cc04b282b1e4d5..19e4719f13b29b2cf60e113565b1b63f19d0e669 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -117,6 +117,7 @@ struct cci_data {
 	unsigned int num_masters;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
+	unsigned long cci_clk_rate;
 	struct hw_params params[3];
 };
 
@@ -668,6 +669,7 @@ static const struct cci_data cci_v1_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  19200000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
@@ -701,6 +703,7 @@ static const struct cci_data cci_v1_5_data = {
 		.max_write_len = 10,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  19200000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,
@@ -734,6 +737,7 @@ static const struct cci_data cci_v2_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate =  37500000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 201,
 		.tlow = 174,

-- 
2.34.1

