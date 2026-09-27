Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1413F12E2
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515799; cv=none; b=HACSnVUIMPtscN7P7K7HgcDIAe9kZAql2xnnKwfxWyet8/OqtAKDzSBbTG7rZjNB5VQUeZyh7qfe3xRa8ms6VCYstRMq3TnVviQ39A2ssIPXjRJgjGjfv/TMuwtqQ0g1eKXp0Dc28RPZxnepK0Jz9+7YInppgfhVrT6MCGQRmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515799; c=relaxed/simple;
	bh=t16IXrQp1yANeK+b1ZtNgYp4/Gn5qoGrwHlCtrQMeg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gUGA0n1HTnQqleLchPeBcWIzkuBoMUEdYAo8ZmZSMga5tL0lkNx0BnGxUNaagKTAT7+Q4ZcGtycuXvFoU/YApFQKi6+4FKBruyY4z833viKmb8nZ4BL0lh1yZtlVgyCZQbEq+I34WH1uDA8vUqmjQq6HgblCHPmk4a7Tlmzukks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aZ6dO106; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ek6c0uVG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aZ6dO106";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ek6c0uVG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QH03Zk880302
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vbrkTRyC3oc++L14v0v0sQRxQG12jGoR751GbRN2fLU=; b=aZ6dO106AfZ3YFXH
	FnHfoJBJf6YdaKieFmPKB6e0zkTh9qzIzl/pDPdEn1YzovH++2X2QotCOFyW/EL8
	GJ5ZOS0m+OqaWBsoH5rwh5N1NdrZlFaP2Cu5nwM20rZZBTuA0x4OYjH/F1DJjo8f
	0NT08KCb0ZSN9ajwcY/eY6u6cTa/lAWLnYgP4VrKEmyc66SXBh+uJP2dVbljYBRk
	e2NJ2CRXaB+dljpu5gn7s0jmaPlRH40zObqMVo5oHjLQmgCWy3Kos26qqqgWpQk8
	C14Z6t1vLaIqcoa5agAJLHP/kYFyF3EbPiIlgxQ8kIdUgJPPt5vNiSU9WTHXoIR5
	p69LKQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb1p1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 13:29:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93bf4c0af4eso597668285a.1
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790515795; x=1791120595; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbrkTRyC3oc++L14v0v0sQRxQG12jGoR751GbRN2fLU=;
        b=ek6c0uVGyG8XSTazaB4RIzWoE5pTbh6IMve3l1OZAnlxShZzqoXznjCBWuMedskQnp
         mOKXmfBx2k11rA6RdY/9rOmFvo01ZuPL0qHiGu66dUzd0+AGjO3pMrPwqRYUj+bAlnmb
         QhCGX7z0a2TtGP/634FbwiM7CLmBSX7brdlne4/1tXWiZqcumaIHXgCgDVnjqTMKdmsJ
         Azr7qZvK0DQ1msyxkhPRqHdXYspJge2IEo2xD6ZPltyLPc3Lfd2L1CnQ4FClVnUlLQTC
         SPl44icf4hxqItRWnd9yDaueer4On418nnf1JLGfge3gZYs85Bmcq/MVZdICKeoLPn+s
         QvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790515795; x=1791120595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vbrkTRyC3oc++L14v0v0sQRxQG12jGoR751GbRN2fLU=;
        b=YZSr/1474R/bqIqe4xVai8qcX3O5rdIc9WWFfDutSgAV2kbk4Aw2Xy/SNJL6reG9K6
         85x+EnXgxfrhbAsj/s9WH+j7WVTzObaThBx7/61pqA77WhT2P65K6Ehbwc1JdQ+hRc6u
         WnWHLJ7WP9fkkow5sFAtSgfApnzw8DrGIpWgFSTPm4Nr7iL2GL6fARu6AJFvC2u39KHr
         WHCrLEGxXulNhu3isURjZ3s5+jz6NIImz6eH1/qGXIdiCbg0MwgUJ/f6z2DDUxUrkA7R
         N2TnIZMybGzhnYK9NQwDKa6UUGRWidDT3i1cBz30+9ImfCiEGX4NepXkpf7ZozEq53IY
         8naQ==
X-Gm-Message-State: AFuF++nnZLAf8u4+3j/uycpcs6np6pFoc9qRqJz6JJQ/O84ThkQlFHme
	lWN7UZrys7etLAUrJjpjnQgEOPR7xK5soBk3shfjJlfCuYtXH3168pWGqxXMB4GH3rNs4m/VIxm
	MCbu53xtbw1hap4vjt75TmDbg+dLkBlUAqR9miSOjZwGrtmMPHJo1hdQzWSRDntK099ieCkoTFw
	==
X-Gm-Gg: AYBFou0DHm0Ls8pywirrCXFv5k/Uhlv8TLe0RxciDOCsurFl7sygnMGORZsUREF1zz0
	GAl5xn37zaPOQ3S30PgWwWVWCZR4vHpp43T57xKWKqWWrA61bbmDXaRb3Nd/uOhFU0xGN1ZlRi0
	nR6W0MrNCY0Hn4yeufQ3dmXa44zIzoAewQqj/1mpFdXKFJbwO15JF4KDXV/TjMAI5Crw+VZPKyb
	SYW4IgfzRjV6CQ4a3LpTD5PgB81iy1r0pPppHY87YP5PEowNUtxnSNMIAv0ZPuF4OlmzKPhWkXs
	m/ciWqw2XWLsexq2o1mmQawzRqyq3FMpIZr6uSNCKreoVros1BeZIKq5MPJBRiguZQJ7zccea0y
	M+kCXCsPl2HmuiDeNxYoIMlYu3922SJHUNWdgorkfzRLIOFKLI3h2WEWWqIY4xvAuK11L1qz/SS
	sLcNAP6OroYAg3XOS9X2pvKloBRAVwBT6fMC8i76I/c2pPOz1Pe2o=
X-Received: by 2002:a05:620a:2547:b0:93c:290e:9e9c with SMTP id af79cd13be357-93c43d17a10mr1409431085a.16.1790515795421;
        Sun, 27 Sep 2026 06:29:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2547:b0:93c:290e:9e9c with SMTP id af79cd13be357-93c43d17a10mr1409428385a.16.1790515794999;
        Sun, 27 Sep 2026 06:29:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00179c729sm94636745e9.15.2026.09.27.06.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 06:29:54 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 15:29:50 +0200
Subject: [PATCH v5 1/5] i2c: qcom-cci: Switch msm8953 to the CCI v2
 timing/rate config
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cci-clk-fix-v5-1-4cd498559ae5@oss.qualcomm.com>
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
X-Proofpoint-GUID: aOArGtDpOuYX-feon81dMiB557kAOR4d
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab91a54 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=Y4CGMd7wAM7EkgizcVsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aOArGtDpOuYX-feon81dMiB557kAOR4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfXzu+J8slXYDKo
 aTOkji03TJSQAc4rt3WkdGqNsGHGLdNPQmJd8Ld6LOdpJ63fIudGel0Dsk7B8gK0DAcXaET0Wwe
 O9jSe3ZOPipn7HdL/iGOlFzMxk37bCUGD4QG1gA2dgmoUhcBOI4mrIWaNN3qlf4CpX84s+zCOAx
 Etk5v4rxMKsvc8HFJ33awtde5prFAOpjSHPriI8k5i8Ben1l5PA1Azvwe4jx+CmNEbkmGYXLMwE
 +8plYAc7wppTn1llUXsSoDYUVtRlbmLlb3r4A+Q+cvSA7APzxf/RAu+XFJ46gt3UHIRKsmwWuiz
 3cMjgQ23+rXOOevq1TZH6zNgi6z/uQMdBFf4LV0oFVoLfUraB01TB0pAFgWLlzeXwG31MLPPs6D
 SN6QXjRWr8W+2a1YbNF7Xd9lw0G1UQoFIU56VV4zlHTnCLJQmS8GIZ2tuWhN6+1KDEe+sUtflAy
 6vNIpPyGux+TDjILWWQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1MyBTYWx0ZWRfXxt13gL6DfXWM
 CV2qtzZAPu4A1OY5LTpRtxFU4AQbFvOkdNkwxu6jg9ZXMkLgA2bAFePU4Fp551u5FqDydE0ie1y
 SHbDF06J6Xc5u70n+VYcZyNeG8v1uRg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270053

The msm8953 CCI timing table is internally inconsistent. Its Standard
and Fast timings match v1/v1.5, which are calibrated for a 19.2 MHz CCI
clock, but its Fast+ timings are essentially the 'v2' values, which are
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 47 +--------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index bdeda3979c4814b5cdb463734b8361da7fffa879..0a216c4d08114f267c8441925e8811ca64f1a909 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -756,54 +756,9 @@ static const struct cci_data cci_v2_data = {
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

