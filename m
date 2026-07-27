Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D03ED5A1
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144102; cv=none; b=TgOv4GhQXpfDULX83f8s+7CB1GX8wbXkZ6JJ9nYCfNruL7/jB+aBCNjt57DAs42u90cV0C60MKxS5Smx2tJBCZgqZoJI0NPj7Alc+TaWev2+mgbVn46VjfVJH+kN8ybLBcGO+/Tye8bsSp14iD8ZgFrLM0mggd4hHoHZ9YmHi1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144102; c=relaxed/simple;
	bh=XibWOFYzL7NFRYf/IFZlMjx/SLzb9MhUUvP0QCnS3/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLrw6h2FW3ExA/KBvHoHvACE/m9hYBUQ4yYWpPrwUjW6n8FcRZt+TeMIW+nymtfQ0IzorJY2nNz4UBpfBzydgyoaa75iCffFagseljdylmPttvAAYshb9IufQOoZxQq6M8Ua8Vuc91VrbQDCUX9FCBTj0ISDqKsB03IHxv/z0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iqB5fpm8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6yVKZsS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqB5fpm8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6yVKZsS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9LcEd3455098
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qh8+gNQVycVqYf+GLM/MIdlS2XrJGv+NSL9vs+oSJNc=; b=iqB5fpm80dVFZQsy
	IvRJL5CpRqphQ4UagYGTDeR78/WB/5ch7GJzC4+7R/iUTgLqvIIPJbS2WRYy9/Qg
	oOepWsx5PNg0eQ89LMivQhNMfvPqvsGDyIJEmc6Tx6atWANTP4fYk2swvy06RPHN
	BFo2iZh0Svmv0Shb2SB3vOZ1ZOoZK1WLmwPCedj4WWpjF6EuWUzXzeq2UY6fnUrK
	ebNK1j61zv+2VD7aOQX2RDZnYLwt5Ful+3z4M4wDOKWrQIBKcygxv9GsmGnpD+i9
	R8It7UR9bf0ECzR79VQY6VWCnq7aDC20+TVSScvdj8TJ3h2u6Ip3j9liNPgt3A/e
	RD22MQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mq000n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 09:21:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-526da7e3c9dso28130671cf.1
        for <linux-i2c@vger.kernel.org>; Mon, 27 Jul 2026 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785144097; x=1785748897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qh8+gNQVycVqYf+GLM/MIdlS2XrJGv+NSL9vs+oSJNc=;
        b=N6yVKZsSMkGVnmiRpzwKGZMS1q+Yse0dciBYg4ASPwqEV/iZ0s48+lRG/y01w8gAAm
         7sF2kL5L/1pHcOULG7SCV7Ys6mn+R1MMD3OrVWxZtebkIGWtRtv456HJNpsFtDnvuSJv
         v5O6oExBPLJ7wDlgPc7tjnaMGyV6BJUHALfeoML9jriQHwOaHYWvoqpAj+Gao9JNl6NQ
         x8Q57K0OJxK1mINH48WI5sL6sZvzxWrDZZ2DWWOVzmWkUrK0zm0+RqNfX2QxSeQAt2tu
         37O0jf2OOF6d4crGF2RFxvEZ7/hTPTzL5NY1XXpK90vMApN0fQu5FBzigBEqCHmVbs3V
         tkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144097; x=1785748897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh8+gNQVycVqYf+GLM/MIdlS2XrJGv+NSL9vs+oSJNc=;
        b=SbbvDmjEtLXnX9KFtEz5QDzrC0aZ+Tto8AyjuG4qZcdWxQKaUNjkgKUprzs7+FmEp5
         J0dytKBX2aMx2piInvsLyIqhgHD34KB9gZkCjCNT1Jcp76pnRe0/KgZAodZHjHcya8qu
         7H+iA35hT535uHbkkUZCSIq4DpemKCtmNbP/kWpc7Tbak7W5NoKC40wegTVix3g+9pbP
         CzsI6r6f/TcCXargdy34NSCyGaHc7rGMIMKE+nqSXDV2tOo214vPx4CGrCcFkpE73g5U
         Lr4bztUMxw4UXqB+xJf4EvnmGaIR6z9WmtlkZo7iCb4oubhN8hltr0bUJL/yB2d9jF2C
         VzDA==
X-Gm-Message-State: AOJu0Yyaz1b6UfJCOFplkFDtyvre+Y7BZX3UQ4kJc6Q1w14FabjJWxYu
	Y0ZHA9pEmOSwsFjfp2Ranubg/AhWa9kSHoMHcKF4HpTrwblmlq1NM1vT++l2vXqRfBhAd3hORBr
	HQfeNRWnzqUgKmFX3iumPhObg3K0hgX7wQFA0jW48sAi5Mw5B5pciNQEXMc/qeWI=
X-Gm-Gg: AR+sD11MCAPQfqA6Ay4FxOzJtNfFCNFAGJ4wYIDpZx0MFY/LPiTi+JDRxVDo82cVCO0
	GQn3AVKzDUK8OKwxV4M/nMN9I8oZ7MAzyMW22CUldBceKbRfKv230XGobg1p3hvE9YJzepF12xk
	ANGuJhPsyQzy3MpBRz3HxDl+csc8GOSYlWfIFwtBKA/wp0Qv/R9JGk7l8sAjpavxfzmAoI+e3cj
	diP/7NyP/OXOHDMC93W80d+IDofzYRQkBtUe6BObT+0LSYX2r0fGEBrUwsAvKK7Fh5VkZzB1ZvV
	AVPlw99nHX/e5aeFRk86NgCDpvk92FjoKsdC0JIjXE1h6NUPGg5B+ff64P1wLYipxDZ05935Vdz
	4i6i3Iu/BdHA7p6u4lcBh84o2wKXbGOhQFkjY3gWjq8kHXEXMMkIFDBysUXqACgfMfzO04man/Z
	gBJ4hF/cWrDi2kvhJ/gMUpZaYIMFKOdh+4WXTSxzWO2LHxgmT1zkI4
X-Received: by 2002:a05:622a:4d98:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-529a865ef39mr80908641cf.50.1785144097214;
        Mon, 27 Jul 2026 02:21:37 -0700 (PDT)
X-Received: by 2002:a05:622a:4d98:b0:51b:f8b3:3d4a with SMTP id d75a77b69052e-529a865ef39mr80908511cf.50.1785144096761;
        Mon, 27 Jul 2026 02:21:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:61cd:dcd3:c61a:ac3c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69fb51c9babsm2265326a12.12.2026.07.27.02.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:21:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 11:21:32 +0200
Subject: [PATCH v2 1/3] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-cci-clk-fix-v2-1-c3958f28b045@oss.qualcomm.com>
References: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
In-Reply-To: <20260727-cci-clk-fix-v2-0-c3958f28b045@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca@lucaweiss.eu>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vladimir.zapolskiy@linaro.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX2w+ywtzFlF4R
 A8JNw1j/dDXIxP6UHEOkBkxnV+88iqwc7BMk5C+WKTFE87MWQerxwbY8oEiwxvnIueDTH24MuGU
 X+gXiBY2qTWJawNOO87VSHhP48TB9ns=
X-Proofpoint-ORIG-GUID: enSCu3swyLbP7BCrR3V7jWDYlZ8kyTIc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5MiBTYWx0ZWRfX7xhPmRUWTC7b
 XdTxDDhwCLvmSVR3w1qWDBSYJTY6lQhKvJiY3g6S7KVSnxMHKEBv1XrYBERjAfdm1YEPDA0VbAu
 NWO+jSACRNmymt7NUkPI9W6DPX6BFAwN8tB/VoQJ67X3qnQjFBpPRtN+a+ttTFw/Xq9ckxrLeZ2
 uRx03Qw1bSBbCkh+vsI6uSeY0t/fg/mUv2s9vCx/TMf0PhnHstSstT00Oyy/W1vGnxTLFi/2KAr
 3Y2SmXROama5WjHPl9fBW917QVxrbVEvSo29v2SPPaQgfsb9xLSS/YcO4T8INVyfOZjIOmAL/+A
 ZTyE62NW2Co94oZ/5R4QVE6s2LUUL2mpKljKz3x41q7zNFxe7kQmF/ABfZxVtVk8lRMSc5FqwML
 qGFdfqcKT7VM/IA8eiJAJrNfEqwXW7Hmpa9Nfto2v52zCL1RsCGTUYRkWEHxHCHtdVxqp4Muk9J
 JnGmsl1jTzbp2o2vFyQ==
X-Proofpoint-GUID: enSCu3swyLbP7BCrR3V7jWDYlZ8kyTIc
X-Authority-Analysis: v=2.4 cv=TemmcxQh c=1 sm=1 tr=0 ts=6a672321 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Y4CGMd7wAM7EkgizcVsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270092

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

Note this requires the CCI clock to run at 37.5 MHz, the proper clock
rate will be set in an upcoming CCI patch.

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

