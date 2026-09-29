Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD55218B5
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684763; cv=none; b=eYYpTauHydGmlKXR8OmYXNG2nTYREm5260PkkGNz82EKYU53TGT3fesKLAKojaHmQJCXNlFz4synVLT468o50+0nbK/9wt/qY56aF0zb7qrlKHg+5c4CqWim5lhQs7mp0WCF/nqCflsutP1jubweRlCq0osN0hkC3Xoer6x/QmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684763; c=relaxed/simple;
	bh=AiV+UgMZj/8Xbz75FJ/bRBCuJFbHFnWTyvBbyi9SIaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MlpgkPLJynV7ILP1D0z/pcwJWMoe/EFxmZa1hXZfC+X0t1wVDBP+qmrcwBcm90MDC59kYimjEwZtF1q4WGHKHVTFvXMCj8RlpBft+LNjJj+azaFBdxZr/WWXLGbuEOuB31UTJBuUYw0Fab0WEqF9GymbpK43Uj0HVTfm6kCuAJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UvPyO3Xj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IiIp2gyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UvPyO3Xj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IiIp2gyp"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCELis525121
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=; b=UvPyO3XjTV3JmEU0
	BzDdmnjOhQUerjmnDIk79o7WXrxThdTT0oKSwt6PrjrPIntrK78Q/dOj43x5ps+t
	T58nj83lE4QYC3lFiv3ko1IhKx5g+q6JFjcNk057UtDT2DbTKh2veUu+dZvLxxda
	Yz73S1eMPQN9VeTA+N8cbGhjuDU5oClTd8T5FrJzKk5v06oVTqv6WaZ1QifMX9EU
	mSGOvEssk0ADqQw1fdEs7MfX3eCMXZoSyZSgLgIcWm68jRPkbEPZXRvyaZ6bhSX5
	vJDa6TGtQsNyfbAefjiBu8YSDd2LQxu2haKxHsmEYH85rWQrNJEe20eYhLNDbz2O
	HnEYeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4tyy0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 12:25:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530f9b8cd29so83880041cf.3
        for <linux-i2c@vger.kernel.org>; Tue, 29 Sep 2026 05:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790684758; x=1791289558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=;
        b=IiIp2gypONVEcro7TTl2qqbjz1r4O6KAsauja+1aHCODZa/IaUWibDNEAX4MljfabO
         0r1/e9RKsUe9tR0OMzBGfbemeWAShCjqK5TDZK6gXXl0l8ZBsXHRolebgmJQtLLVo0dT
         MqGns37JXVaY24TLRvk2lW/Z7x8bQJVpzAfIO/0GOIy7qTzY28aQNWRV2AmaYHvc4zW9
         g/hrawqsi5wQzSwzhULcmUADA7J0Ncu+xLpbeNFaJbDfCN7NC94kf5A9OmMmOPzLiwaP
         XUkuu8OiX8Skh+Z1VPTWdkFpoK4b//vv5TPyUjj+rC318qktoNzc0TrsqIurB9a3g2He
         J2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684758; x=1791289558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0W3hrgF4xqqK3S9Nv7s61X5LJpvgGVvfqcGo/cmYe4=;
        b=KqopJX6dwjqmlLxgKYleNFTssS4JsAnP7Hul67WsfrEq2BaYHmIbmYtNgB3rn87pA4
         Rn8OVYe6ybpIN4cXXiUxpj6tZLElp1OrYr+Emph7ebVqpkX6pqxFQ6ZSBH0KUp5JHfU4
         KEiS99xUZx0wH1QfxDp0ztacT8hxiKmc4KG7Cvos/MqN4FydjrCGV2Tl7zcgsSvEUEWI
         IIIRD8fccOmIHgMIVPrOkEsz59V0SvQCSuB8PdBtFUBi7gvJ7EpBBfZdU8OEE1ks9vCO
         CWrOTZHAGZuaaF+nQmvl/lwybAVOLFVw/MhjD6N//Oz9qsPe9eBtVLT56P+dm1sApV8y
         gIOA==
X-Gm-Message-State: AFuF++n/CODRggoD7bjqhO4v057ah1izz9Oj6dLtWFa4MlwBtM9OSQ3j
	jLCb5i66dGItVLVD2aDaZjdTfEeNb6UzuH29HKwpRlNv7SGBkqOWPRhqMK5r2XHjYJkR97ljiAu
	dvcOHXuWr+Pd4jzw69uf+nrh5P/qnSEkwgyyrDAc9sTJ+SowBwm7bi6yjVXV+Kjk=
X-Gm-Gg: AYBFou1Ou4jxE/6tqjoVDp9bBfYvfiTsTcmlZb3XFk/f1GGAc+vyIS0ymmf00/humYk
	rDbPIbvSL/Xp0ps2e8gr2NhjRGikw1ZZUSgAzKKCrIv8XO7rNoZut53ua6vXSM2C+8rle/rkPxu
	K48vCUzkxuEzatqgZMvGh2mo/hafccoEHgyiwZdKnoJ4vgR4FkUIFml8RbWPW1VqEKjZgWQNHSU
	76bTLqX6MPjavNAR3SvIba18g3d8GWDdLZCW/tIuzYO3OgFJHJz0/z/nVK/Ij9tNDWsHT6ATSyk
	aoCpGZyFAj3unTecOj2eWlNzBfnpPkbKG5AxQSlCJOOSlsS/CaGp6hKIErumkeCTsOl/eYz9eto
	ypENCuw4sdz63E2kgk7vjDA+Lg02TtMg/+q295CnPwjo91k6WUFbk4tXrCe22PnDv/gvx25TgXh
	ij39xcgfiDQch/3QZ7NGLsA8J/VtrwOgpCKIwTqNSf2HynMVnYe4E=
X-Received: by 2002:a05:622a:5887:b0:530:f37b:cabc with SMTP id d75a77b69052e-5330b55671cmr281761641cf.12.1790684758491;
        Tue, 29 Sep 2026 05:25:58 -0700 (PDT)
X-Received: by 2002:a05:622a:5887:b0:530:f37b:cabc with SMTP id d75a77b69052e-5330b55671cmr281761081cf.12.1790684757981;
        Tue, 29 Sep 2026 05:25:57 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9178d302482sm9103956d6.12.2026.09.29.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:25:57 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:25:47 +0200
Subject: [PATCH v6 3/5] i2c: qcom-cci: Add 19.2 MHz timings for the v2 CCI
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-cci-clk-fix-v6-3-62a268cccb0f@oss.qualcomm.com>
References: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
In-Reply-To: <20260929-cci-clk-fix-v6-0-62a268cccb0f@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX86Oa8GSorGUv
 5fb2y+ZGRKCTFEdnVHbEwUN/rl5H/5mwM4cger6dJ6H4X2Chg4Tl1TVITPqdycaQZQ9TWxTXXJd
 yFbVuq6dIyU2WzZ9rH62B9uclk0bCe4=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abbae57 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX7UNiMoWB7lpH
 j8H/KwGArqQ/rmW/HabxiENxY72TLPYm0Bi4GSE435gdQe/ApT0JLMiJtBunF7ZosKFlMrQCIvr
 myyJXR71GAqunKhBUZffLpP6WLAbD2hdwta4BuvbiR/Nw9mp4PWagyR7jefndsHcy06Cr26ZFkx
 lk+YXZjCJIK+kn9drW3IWlRET7YNN7rBR5+s0/5fLrEzcc3A4HCLFoSe5SzERw5Qzy3bM+ig8Sm
 xwI6L+d5Y8Mo3UQxJQr3v8feyW2yd5hCFpsE8pD2wYqUPIZZTG7Zum/lxhiaLLzVtH2tFI48xiH
 7ieIcozURQYCPQeikTLW9jP5iTKLxH36qRbpEhdXK5muL483niIBQqOARf3hFIeoZzPxEyUIFXf
 wOYAam0mhey4PKBpJYO8Sv4nyIt+wh/lECSxYDLczrzktRXiAl/oPBwTLYqEOY5GBrBZ2JtA8KS
 bNgar+abiV3ek9COKGA==
X-Proofpoint-GUID: UGz8aQVa0FGkQ-ykdy9Owgpb5Rs58NiY
X-Proofpoint-ORIG-GUID: UGz8aQVa0FGkQ-ykdy9Owgpb5Rs58NiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049

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

