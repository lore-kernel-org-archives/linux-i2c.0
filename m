Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51D4C955A
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645975; cv=none; b=KIVaX0sZyUg0OgLBiOt6L7SIJLuHjl9zbh01t8Getj+1gUkpLt6QJIQ01b/hYHq3u0kqSArvBVZ5xe6Hyo/YFvLn1is1flIK5QncKqpimyHtN4kI19t5ktb7fHXkNJncUpKaUDdYG7sjdxfnMLSPuoQoU7qT403VPwhkllkBVNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645975; c=relaxed/simple;
	bh=XceuDuLrzakfs0zugQBbXJa+oizwCWt+Pl0ZpC7HxL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjaelmwotIS7WMSxSOngZrUkzeUy02oxd9s+XAqfyLFH2fL3YIj695hYg4eP2TG4LWRuyzjpODJ7Wjolc27Qk+R5LK61P2WsPk9dho+lWM+b5bkD5FFFmStX6v7T+1Kw+C14IQqLd65q5qE8shHcoPdLUy7tkiD9Tw4k5L0efrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PDQZyP1a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IHscMRWO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PDQZyP1a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHscMRWO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LDg7m41958770
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K+LK8F70ldltnOCivKw+ePZv3anat5mG9iynUsCcEZU=; b=PDQZyP1a+PemFjTw
	AQhSirae6PXtc2O2DukzeDWgNvycAuO0bHrzkHmSLrye89JVi7vw8X1lMdkd4EI+
	cceh01uxqGDQcDrCpWyI2CVe4FWoRZh8a4HmhW9rqf+F/b4/4bgohBvzOESHiVy9
	lhrjhfTVgqdU95qzXfXoCQ7C9EvNmIUCiBbynTq/AtNDB0qcFxzCIdeLxiGrWwOV
	rHub1ktrI+MP9fkmWqioGMWZE5LKKjN0CD8jGm7nFq+E1aXQ4pjbNf+wO16wfUI+
	A3n4e6z9MoteF49osiSBFL3YkZ2891JCQSKKJSF0y/Ir+pgIEM2dBa5ZMb6UlLY9
	MMUKvA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1bvu2mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 14:59:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec3314f65fso231801246d6.3
        for <linux-i2c@vger.kernel.org>; Tue, 21 Jul 2026 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784645970; x=1785250770; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+LK8F70ldltnOCivKw+ePZv3anat5mG9iynUsCcEZU=;
        b=IHscMRWOBAUNOtiN2XgUr2vPJRvYAiFO24HBwsxb945qZxXV5+EC0tH3c9zyjEBJMG
         E8OwDX8YLW4zjmx8SG+4YdhT/7BcvmhAp/INRQ1th0NPZ/RihzX0ptIZIE7GPO7bLyq5
         iDeCcDA6ruLec/ohRbPkt6BxcHbeaaFElfeUbBeHhWE674uvHwsyhfgEHnfvr6M1CDD5
         1CzjS+NkhXpqfpG659voJBQfvIyNm7yinT6ztnPo8olT1eWIkSPPchZHLNk0OvqoITQs
         cNKlU4PpYTZ1If6RKKYu6TEob9ISCNmSPxY6yYhdZUyV1Zg4ZctoQge7lYxuz6K+zGaw
         VGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784645970; x=1785250770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K+LK8F70ldltnOCivKw+ePZv3anat5mG9iynUsCcEZU=;
        b=emgd/8WhEBxHxPXjeNRrKhaYPWpp25NDQcXPFJdgjipK358ZKNVMonKE/XaaNm80X6
         6FvbDUWtMfgVER1FWE/d2I8POpeuxj/9z1QiZDxe3bbHrYs/5uH+6zUSNilL6+BWK9Y0
         O+2uwSYGNJqhZKeOxtPYqRO3TK2vbmN6EZEX1brnyVEEgvOAc48UfliIcQgn8z7q6cXH
         epFIwhMMLi1XAqnXQU3+Zt98IvnZokNBwCR7WrrPwJDvtExK9N42ygH8Fy0GOfqa/4gx
         T/n1YxyvaiEaqXFLLXBenfdEftpMBZGsLIgGmVdA6ujTsKrvP6apfTDMYWz0/dBy+awq
         hxdw==
X-Gm-Message-State: AOJu0YyoMwXdDen3k4gSDEyYpBvU66JFbpO1nvs+COYPxVGe/WZ+s5Rh
	FTSLxTjTuAizr2w6FmDxWeP2WOfuo9b+ftRtldfGhSzojeRPwW9VPUGh6/cvbnBQqcp9eOKFA3m
	f0PN3JxHQvlMmcw/FdQzxAjLZ1NqbTf+LlJlBCJdKjg7eWwEfogPyOxZR5wLHMMo=
X-Gm-Gg: AfdE7cmeyHelQf2HIr158mlqDmbk1AnTlljy32Sd4yPQGn34GtZ/2qaeRHyecxm7zTk
	3ZKdmRz7VxQ4WSt+rjI/5ONtuGb3AprJ6VdJXkVhXvKu3XawJYRNmwoHsikfWz/3b599LdKBkek
	I4Jfk+YByI330q1k0MVYFEoffjAlddxlTNiWI8Ylg57n+qfXvW4uqUh6Nj8hpV34i5+t74sMbsV
	9I8egFmsdIX+Jv22pcmx48pSJcNbthvU7Jw9Hf3kElQAcr99kElJPgYef9seR1fZ56EN3t4+mP0
	x1iK+QbTMVpMNS59VZ0zrRkS2Lw0/Eyr+voAa1jQaJIBONpj32Ze3qs3Dvx3UVVIVjMCusf91IC
	93iJu26Uqd88QJVrbqdeoBw+FuVmNJs3dpw5fsL5mFN8naf3kIYab0vDdl+E5/dP+1q1akKjDsX
	oyMlQSSroqb+LKavtTOISpVdbxMG852RIe9mkGrpcq0c+zJifuAII=
X-Received: by 2002:a05:622a:909:b0:51a:8c97:938b with SMTP id d75a77b69052e-5213e190f97mr180208731cf.66.1784645910664;
        Tue, 21 Jul 2026 07:58:30 -0700 (PDT)
X-Received: by 2002:a05:622a:909:b0:51a:8c97:938b with SMTP id d75a77b69052e-5213e190f97mr180207641cf.66.1784645909028;
        Tue, 21 Jul 2026 07:58:29 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e6ffbba0fsm5875369a12.17.2026.07.21.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 07:58:27 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:58:21 +0200
Subject: [PATCH 3/3] i2c: qcom-cci: Fix CCI clock rate enforcement
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-cci-clk-fix-v1-3-5eae78700da8@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: OqzOfbPMQSGIU1wmJoRp_oZunCK2YQPq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfX4042O5SLr4D0
 3JtcnyA93mENkg/m0gLBTuCyrPzvTvWVRsmV8rvSr+onbH5aczgDC5sgj+PS0Q4nPwr/NSXtAoW
 zLVpOV8TguM9BtZ0z/pJ89m49snx+T4=
X-Proofpoint-GUID: OqzOfbPMQSGIU1wmJoRp_oZunCK2YQPq
X-Authority-Analysis: v=2.4 cv=Sb7HsPRu c=1 sm=1 tr=0 ts=6a5f8953 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fiHgs4EJ_qdzu2AaPLEA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1OCBTYWx0ZWRfXwfmMGg5w2OsR
 Cla6rpaXt0mQC0XjWjwW6pabxyMFGr3ssQQxiGNoPQ7lNqsFhQJ4QON0hOM71VCm9lipZDGCkjV
 glj+o22nluJKTTZNGUODK+Xqq6LDnr8IBN01kxsg1nX96+opHwLDNIfwRMh7N/D1TlOPUZX1Vk1
 s5cb9BGLTMlKWKrQpMdhQXGTSzY3np5pEimphqrnEvQA0qMndzxzQKp/dksASceZAUvUdLLr96d
 mNN2+pRu7NX30851Vvn5tyr3bhXJQKcx6SbeSf7XKgeuOX5pt2xi7r2T0wu9ulOV/6Atl8o0dnD
 /wrt4P6rrMP0l5L5HbKkaCIDxlf2vk+fDP2Dcygi4NLWV1mCr+t1EhMeRGL/5cq20MqeCFxZ6iY
 E3AVYxTv8CwuQkm3yP5o/4xj4OnE3jwTTkfDJpJM+nRF72+Vym3swJCwFZcCC6FHbf0mCQSxMU/
 M68znUwFIrsBuTaT5Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210158

The hw_params timing values (thigh, tlow, etc.) are in CCI clock ticks
and were calibrated for a specific clock rate per hardware variant. If
the clock is running at a different rate the I2C timings will be wrong,
potentially violating the I2C specification.

Rather than just warning about a mismatch, actively set the clock to the
expected rate at probe time. Warn if the rate could not be applied so the
user is informed that timings may be incorrect.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 5f74edde8558382e63e2c3d0fbe19489f325e8ce..e001c0d565cebd386fd67b1d9d532360b29c67d0 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -519,6 +519,7 @@ static int cci_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child;
 	struct resource *r;
+	struct clk *cci_clk;
 	struct cci *cci;
 	int ret, i;
 	u32 val;
@@ -587,6 +588,15 @@ static int cci_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
 	cci->nclocks = ret;
 
+	cci_clk = devm_clk_get(dev, "cci");
+	if (IS_ERR(cci_clk))
+		return dev_err_probe(dev, PTR_ERR(cci_clk), "failed to get CCI clock\n");
+
+	clk_set_rate(cci_clk, cci->data->cci_clk_rate);
+	if (clk_get_rate(cci_clk) != cci->data->cci_clk_rate)
+		dev_warn(dev, "CCI clock is not at expected %lu Hz\n",
+			 cci->data->cci_clk_rate);
+
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;

-- 
2.34.1

