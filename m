Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8437B417
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704118; cv=none; b=meIGxt9ZKkhY3eAFRWgYqDy9/9lvB7srnxX6eyHmBaSwpTNrTgtUOGxlh/HGM9Grj5UCqWp6KTvhN4xoTR3/aEYTKuhCeiCkf/rE3yRQydv20nDlKcnWsMzd2N3FvT8rBv3F0HwNTLFPe7Bx3piRCoEaSEH+HAeWFcQWnbLh75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704118; c=relaxed/simple;
	bh=i6izUJviyArX46Sxz3psV8CYflgOEvKVmFWmHyN2UJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IybPG9oA7PFwq0yyujvKbmF7bQMY9lNqassXO7cFKf0Jp97TZfG5im7QB07HJvzo4nUWDPVrsl/zlgPMYQ4OS1MV4D7IWH0EoJ+qs/SAImcs8S7oRpA3Wf8uHwppvhwBbW+BvfCC1Xbo/FwAMxViSBiX8GjTWKvE04Dh+ihrjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Si5A8wQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XB+l3doD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Si5A8wQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XB+l3doD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259FpiG3160422
	for <linux-i2c@vger.kernel.org>; Thu, 5 Mar 2026 09:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	azIj86InPC+CXN10XsD4qgZL9tAaO+Zo/OsdMtMqGik=; b=Si5A8wQkVIgZLnx1
	siu1KnQufSbALw07L+ODCEEgkm7qe5QlRfWt0ge2kpNv6ovG0sMH6lHz/4AYyHbs
	FHvsfOZoYLuqcgA0D6/4ddqRoc4cdAmYhHzFzHUaCkciVmz9aMAem9IZXf1C+wYR
	rJAxk01tTKSGJjHusbHf4rwFcJyZ3QH2fKtwGiIQOUSMlYnzUdLGvH/xNnI3u5yQ
	rGGr9OFZdvLg4uwvHCvEh6YrVUv8N/YAhimUMXhDTaRZ1N5VPglOlENuJvxdfTqP
	B/jpEt987CcmwUT7ffiOx+4BiwfUr6SiA4+rR81NZwXQcNsKkwPxOfsnn3pFZTz6
	yNhe5g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpjh5v4jw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 09:48:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5033b62efa7so538401131cf.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704115; x=1773308915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azIj86InPC+CXN10XsD4qgZL9tAaO+Zo/OsdMtMqGik=;
        b=XB+l3doDbgS98znvECBXuTKJxayzgHj39zcvO5ERsIrQIApu0pVOV7r0I5sZ4f5VQ6
         YZMyXdLWPaSSkBfHXlrOnjJV27KG/teajSZQxN2NNSTyAPBzTxHgINaBKz1CqaUnMTIR
         YiKEsghsDLtJiG3N+iSY3K5HmRXBQzyHEX0NuiZjbpNNKM/TkFb5BpqjggmESmCkVZjH
         DQK4TtXVLO1hX1U2CKYncqIyC1XLhDH73uNffhGZY4EdYGyCRKGcOKtxbIBmp/NZaOIV
         CsrqISlrxKJjxBVDxHLR87mm5EMB+zYuFl4m0ULv68VHeKueoxcGOUj2+ETkjD6aCCct
         Sugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704115; x=1773308915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azIj86InPC+CXN10XsD4qgZL9tAaO+Zo/OsdMtMqGik=;
        b=dmKAmt6v5gyyQqlcBuTAQkQXBUZXc6wAIo0uer0j+qL9VjIWxsrk3vIUwScMVop4vf
         ElNPearfGxAwELHqBRG3uy5JY7QrdvRn/fZC4hSddo6roGt6I/UOTG1eLsZQYscGUe6A
         TLc4M34muzI5J/+fFUxAo4QfXLcT270hcEoQEBlT8BfUgRD4ZhLghyj07dJQAb5NorTR
         Bs5LBgPX1hEgbPBOvGbg+Qwthl2ybvgog3IamR1R1XkQ+0V/fYn25pkwqe2/kduBKpMY
         0QexNotz2CHpMec0Eo2qC8oynzr0FSLQHG7SvKV557ylm7jon/C8Jm5iWBkK2VC30aKV
         wGgw==
X-Gm-Message-State: AOJu0YzukGSaJHM/4gcAkFVPryN5Id8oAFokJw/Wj0lZSK6V5esI0QZY
	PnGKfXNH6ak2plTBNWdnA/zmzwCoqaqUXG131ZlO3+ilJSytDn6kTe9UtPFgGtC4R0GD0pWaHVs
	u9ONe6sF6l4M+IAPgsnzQhrBgB4EBt00SfdItZNXFxbbvRpIUQzZ5wRClFwZ9s0o=
X-Gm-Gg: ATEYQzwsiQfgx2zykhbaa7urkZt/l5LkeppSDrhsBtpHi/TYIvYzrN2OUYCrOnH2dm6
	xIRZuBKi49V3kJAFrRqn7GeGw6dFvZXXflOl01B6T/083kCngbqM1U+UqCEe4/ySqgQBU8DlbA6
	RtelkzytDbN+uiDsSMPxRECAm5y5YDZfOBLd55mOxmMNIP6JFdeRbHGqNcDoidFEDxbzpLmui2F
	0NrmvJ9+g/l0yEw1xUNDxbLtPzEHSFiTyIUWS6Xx3SBS7ILrGi372Y6isQlzrTGLiKjAOf02Cqx
	iDVopNp9xCAKjjeIogqOWEqVX0ypqNtEXtAss74Q1FWQ6ylXi+7+Jpx17fDfeOujXrwktO7Lzrf
	5Kdz0fS79pMmygw/mGUuXXefrkZsHmj6wd8Z7N20CmD9smT5wLHdG7bdt9zPLIIwhouMQJAHTjj
	AtpMXNbneWqx6c
X-Received: by 2002:a05:622a:354:b0:507:3ee:23be with SMTP id d75a77b69052e-508db25dc3fmr65561981cf.9.1772704115060;
        Thu, 05 Mar 2026 01:48:35 -0800 (PST)
X-Received: by 2002:a05:622a:354:b0:507:3ee:23be with SMTP id d75a77b69052e-508db25dc3fmr65561781cf.9.1772704114585;
        Thu, 05 Mar 2026 01:48:34 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074496300fsm177126211cf.2.2026.03.05.01.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:48:34 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 17:48:12 +0800
Subject: [PATCH v6 1/5] dt-bindings: i2c: qcom-cci: Document sm6150
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-sm6150_evk-v6-1-38ce4360d5e0@oss.qualcomm.com>
References: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
In-Reply-To: <20260305-sm6150_evk-v6-0-38ce4360d5e0@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772704098; l=1336;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=i6izUJviyArX46Sxz3psV8CYflgOEvKVmFWmHyN2UJg=;
 b=61XRv9AhrNpd1bojD8c5P7j8kwKYTzIdkkCrl5q3FdMqWSZvfOltv2e354lZ5/0tJ6DNK/Xby
 xvWi93boORvDrN4S40rT/4FyP90rUd7qmkTAai4hPS2SHvehiAcgs0z
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: vq6x9TqRDY3Hm51ApvZmXBYMZWLndneF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OCBTYWx0ZWRfX5dKMW+y848h7
 m0REKsHrifZtTTXe0tJiiL8Q6s1Prx24G/Q8meJq7G9fKZlyxMi0z3DgCiPDBUqk12QwvSB7wfV
 8JDiwRiH+Lx+6Y36l+i6T43dE4VK4GKsNTwpdamIuUf5NeDUJkirh0kasvQcgOOV8UAMISdmbdT
 k5JCHefxbG/6o/O5tj2CQwOHU3OBOo43RcFMplsaCRxERON8wFoUg4nM3M6ei88ht9fafcKcorJ
 EvlNV2GtNonNtLL1mMWrDHzOptiqpBvo6/LZc5wnW/IDrAlgL1Kxk5zryRpe+A7aai5JJu3hXcz
 C2pyRsGsd99ZyK9Yxfw/U2tZOVi48RG5fM1JYJfM+TEytEhoOqAJNLKmxjTmNW6TfZUKAA74xff
 6oSo/FPSR7bNf3d1IXuv+/ow29bJSQskLtaGD48OlV8paupIx+ehMuhQk0isJkO4YnDohZLzcTF
 +q1ONRdxOXiZXw2Bzdw==
X-Authority-Analysis: v=2.4 cv=JK82csKb c=1 sm=1 tr=0 ts=69a95173 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UHGjisO4C0SBheCDbiIA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vq6x9TqRDY3Hm51ApvZmXBYMZWLndneF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050078

Add the sm6150 CCI device string compatible.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 399a09409e071b7caad8df7fb831c429a8bc7750..35d3a0685ac4468d49e68621d0359dea1988cbcb 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -34,6 +34,7 @@ properties:
               - qcom,sc8280xp-cci
               - qcom,sdm670-cci
               - qcom,sdm845-cci
+              - qcom,sm6150-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
               - qcom,sm8450-cci
@@ -251,6 +252,7 @@ allOf:
           contains:
             enum:
               - qcom,sa8775p-cci
+              - qcom,sm6150-cci
               - qcom,sm8550-cci
               - qcom,sm8650-cci
               - qcom,x1e80100-cci

-- 
2.34.1

