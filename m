Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85704CA283
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645920; cv=none; b=MEPoO7Czd5jz13GDFYB4EDVN5gx7dqdz/lUeRiI6i2l8WVxTCqr5i3QaHYCoM3ZUoo0jaaEkagVODgdJwNOnp9Tb0B7NyD4ixGOlYE2PbQYwTc+fnnugknDWjALW17ykZQlnq3Apkf+Hvv1AB41r9TprOHpy1G1zesw3c5bfovY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645920; c=relaxed/simple;
	bh=IG6nNY2rpLz56Y4qeQC3PTx1SQ0y6+9CgmNeqxv5pFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICiRloDd8pbVhPy6AOLd07iVe2bIp2f7k9j45Sbrm/IyqqWwRspurqweLMzLNBi6GwM4EFEPhAnBI6iQ74niISaEoxzrnNmuVkzFO8sOoyUeBs6+d+r07kAt6f1EF/o4D6KfbpPYL2AGUDMOktM3Q6IMo9l9UpEZhVOB1191VjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CGWhcaWG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dvLnMJ50; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGWhcaWG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dvLnMJ50"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg7GR1939379
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/NvVmHEiARXUqdG5xNPL/AxvPN8bY9Ggi2ZtbAMd1uU=; b=CGWhcaWGMDfTYyoN
	YEsHGIFs3e2TLxnq7jwlxjzEKDT9rFgUnsnfYAG2Umv1c8yeL8vQmXNocNPmkRt3
	SFlIoV5iXvb7BeZrplMlc0XhOSZNJNsytnfltarf6fPv5+zlyctwPhdhQbhqJAoX
	SLLoDt2t04SrTYkM4+IKCLF+9LEWxRh2oFT6l4pqWTmVkqA2OUrozVeZgSDNekZz
	sks2bG9V1Tl5a+UFg2yvwuDQ2RgDweGbrkOASmODV0wvx+yOYm56iJnLh8zdsOki
	Zb1Zl0taz9QLoEiWWZ68ZSHdpDM8aBY517akSGE0PbQDtH2TfVOIIJzp705UBI26
	+hY8OQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9bs8hu9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:58:38 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ec3314f65fso231783646d6.3
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784645918; x=1785250718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NvVmHEiARXUqdG5xNPL/AxvPN8bY9Ggi2ZtbAMd1uU=;
        b=dvLnMJ50enGdnAaLkqlbNUDfq/xQpNIlHlRkhj6MHzKsoV6B292LvU7oLP4M2hDhlc
         ETpL4i1qNz9jZm+sRex0SlE7KuIBTkgN1npP16cuT9fncDwBUsOKTlIKAQPHjJrFs4Rj
         IMLtpCIRoC+BkFWmHuH5znlTNZBhIk1NARdjKF0Ylynsz7NAWmfKPnqmNr4AxDayjjJJ
         LBk42c1Atf4yMet1nhcPPCtKB4bL54rgfUSmkb36+/oci3tXCBwLFE4luKZvUIEceYpq
         50zHIpsbL6up+yPBl3AAytcZ8nYL3IhfXsfeUPoL/bsIzqRZRhePzuu8A/lwamf1z5vT
         +/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645918; x=1785250718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/NvVmHEiARXUqdG5xNPL/AxvPN8bY9Ggi2ZtbAMd1uU=;
        b=CfKXBN5sh6YR5Ulbe5gxdu2ERmUo416XQ4xwlPal82bRw6KmeOtrJazGMXVRMHco8X
         Pd6Y+nZENVq/4Wot251jQSE9RMWXno5EmLyI4w5YKcgejzT1wccrZDOhD7xviqca2OEM
         NPTAbTPbU2wI5eD9gqizZikGp2jtiVf2QN681IQoVyTQRLrMyeVktMYVBhe2jf2gOzUM
         m9pBAfjkckPd4Q2jYWYKylj0zHEVqkKHZ5OUF9F4jxVHkVh6CsQW4k0bl7XOanMIxVFj
         CWDk3HawAHMDEBNzC4MzD95UrqBVDfvSH0e2swryzyvBRkYTOlfuex8J0a4pMGbVH2Sx
         Cp/Q==
X-Gm-Message-State: AOJu0Yxm8EGXsMFE7/bW+sDr6o88RgcHX91ovC6dkLbJcFL1D4KOs+T2
	1ANcLsf+XzcRPywjrusXSy1NROH8Qyg5Jmb5rbmY2uVsn4BobZtaVmVQdR+uT6QqFeD1piRAo+S
	5o9JEwOCi9VzxsjZlEdhkDJXDW1JEp0TyAVtwpFVH7MpuI2PWCkk3hmiMpjwnYSo=
X-Gm-Gg: AfdE7cmPkbLPNoQg4U2mQmPD6DF9JYNuBdPd5jnFqJF3Bi+TLpQHIY/Bh1UWNKnxp27
	XyuyeuvXd3efKA9CBj2lS97+28h9KYEWUQNemPLUyyLgk3mtRCbhqZPx1vh4UQ9OeoFfZNiF4B5
	IdXmOcwpCSXPhN16BjrPnp3ox76xfgWpAXFlWfa4Y41J5Fvo9Qdd/d5k9AVypufsyXEj9yje61l
	4/NCMqFzpXSDGIi+IPTh2Ns3OBi/WcV2outrt+UKDpFm5un4bCtZko1T6mMltdLeyM46kjXJVUS
	LcO8ilkq6gvDbz410HV+4tULQCRbQ2RfjfbXDhQE1YUmfMzTXKmb+q/Hmz3n7x/2RQ46LZMkr/k
	ZDRvIDXubI+bxOfXhtZONLTVJd/uaMHin/zlzSfrstMKG7HrJ4+5aHPS7U65TaBDJtYOlV96OGY
	XBqpoy8r+jaJscLuZtKdTWgp7iyfddwvb0J9Uk2fwx6DIpcjLN/eU=
X-Received: by 2002:a05:622a:4ccf:b0:516:e0eb:d7d with SMTP id d75a77b69052e-5213c2028b8mr186795231cf.27.1784645914641;
        Tue, 21 Jul 2026 07:58:34 -0700 (PDT)
X-Received: by 2002:a05:622a:4ccf:b0:516:e0eb:d7d with SMTP id d75a77b69052e-5213c2028b8mr186790761cf.27.1784645906827;
        Tue, 21 Jul 2026 07:58:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbba0fsm5875369a12.17.2026.07.21.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:58:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:58:20 +0200
Subject: [PATCH 2/3] i2c: qcom-cci: Add missing cci_clk_rate for msm8953
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-cci-clk-fix-v1-2-5eae78700da8@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: J1pTgCVnTxAaA4WL6wAZ43ltMhl5PA2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfX0enlbHWLJSry
 5D8XTpcC/1sUE6d540d8V4Kq/45ZiYw/Ozun0vRrSlRSAYUfeVW6g9+V6o42Tj8uHCKLxv/TGmr
 pHXQC7/psWBEFRhu6eVRcFxNt+6eAMFjXWqz9QC0HaMgylAfCeAz2x10H5H4zeENJKYnUnfAnEC
 hS/NEoEQLbbjK0sm2XExJwwUb1mT6HrG7OoWr/8Rv745iRsCm4u9rN/hG7vm5a9tIa4QGCOTgmq
 SHhORehvAG/OjMbuUZy0VVCZUz78NIN9Mzqv5rA/HGLgoKkYeAtCqkcl9G3Mpj0tngig+l/+7W1
 A317zn2dbE1F6Xe7vIa6NV9kH0JnOXiQTN67h2BsteTMjr6gdaCz81v+Kndy0Hw4gh2tuQMiKRE
 yOPHhay88isDO4hxY5hRg3G7CtlmoHxNGHI5hRv1f8xJrHsyzqqqrEZ+Kk0f1Tr0ATno7D98zUG
 XAscNaSe9tRECLutz/w==
X-Proofpoint-GUID: J1pTgCVnTxAaA4WL6wAZ43ltMhl5PA2L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXxBx9EPE3F1T2
 22uTr9G6t9G7UxxAMBAd7j9+GJeX43iDZyZtora6ow3T4tVBDYyHV+WucMSSgEObFR1A5RCm8Fz
 1JMH44DnGU/bAtzZ9WmkMkdmMzYT3Rk=
X-Authority-Analysis: v=2.4 cv=QK1YgALL c=1 sm=1 tr=0 ts=6a5f891e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=JZ_a1HBs4gVu24XmFGcA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210158

The msm8953 CCI data was added after cci_clk_rate was removed from the
driver, so it never got a clock rate entry. The DT assigns 19.2 MHz to
GCC_CAMSS_CCI_CLK and the hw_params values match those of v1/v1.5 which
were also calibrated for 19.2 MHz.

Fixes: d202341d9b0c ("i2c: qcom-cci: Add msm8953 compatible")
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 19e4719f13b29b2cf60e113565b1b63f19d0e669..5f74edde8558382e63e2c3d0fbe19489f325e8ce 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -783,6 +783,7 @@ static const struct cci_data cci_msm8953_data = {
 		.max_write_len = 11,
 		.max_read_len = 12,
 	},
+	.cci_clk_rate = 19200000,
 	.params[I2C_MODE_STANDARD] = {
 		.thigh = 78,
 		.tlow = 114,

-- 
2.34.1

