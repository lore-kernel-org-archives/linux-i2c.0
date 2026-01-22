Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DD428476
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078996; cv=none; b=UKVW01w/VIpnx49PJx6Sg5QCAh1IdKU+chfGoubnSSIMHalKa1eSscuVo+r/etjL4CmWxTWF4pLpXdRpXMhUiSxRNhVcJupvVyPqZmej3RIc1uXFDhpOoih5xQ0EplgyoxY3JBej9azgHHXB5YMe02eaHxs+MHZlSKkz+UIKFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078996; c=relaxed/simple;
	bh=B5r+Yo/9SDYaZ8RGuV/vWORvd/4+ohBj6uYfAX9/P04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DhjxoBux4zxXrE1enXVbfbOrJRuLlIXN2vLtzU3Gag4reKvigawchzap+jVm09t/vukZ0dyBKcHLCFVMiy+FB4hEqSM/FNQP2udx4CZdf9yWLQD3oMarnyCKMFphtZoyO8gVWwtvtC+pqXzk6+NPE19Wrw6KUqhNwZ4zshEC1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gm/or7ba; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZmxiOyZ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gm/or7ba";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZmxiOyZ+"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M84lkd646018
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eaVvPdxctaVfym/v4SBx0duzy99NPGMCqQ97rGguHm0=; b=gm/or7banhIUobRb
	Y6U5/fD5tQyaKKoOKNDIikR9TuSeUcdS5/zEsW4Cg4AONlMgCGCT2Iuw3WOMyx3Z
	EYzP1GYMysOjd4njJpv14m1U1Wur6HCgurSIji9cMS6BC0D7y5lzWyG8pkfd4Sf4
	NN5jbdbEb4Clfqc07BxewBRNT3UCDH06ZcmAlAmshlhVlGGBWUKMX2xzq6r7lgzQ
	SaMsnj3AYr33shWK+6JbuWOd+VOvxqRUvQ4UeKfbL5qv/eH2LgeDN+3OeXcHmi5u
	GRCsehfWzXc53zzUXVIvXRsMuzIeAerg1Bt0paTLWBIDGd3PmTWQQVOa2hoocwrD
	NbBl4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu8j9stkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:49:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a241b5cdso138317885a.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078993; x=1769683793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaVvPdxctaVfym/v4SBx0duzy99NPGMCqQ97rGguHm0=;
        b=ZmxiOyZ+djPLvgJqQ5NRJ7UohAyvrkkQhcBW73AkjmdFIbuORls+b1EhiHW3TGYSVV
         V3XfPx8qc1XsFvxis4iEq3cIVCFOtHqxNLeNSCXuPzYyi/xIU4QbnEwhOYkGI4TsfIDK
         oz8GElO/cMTzBdVHAlHUJhlfKOov8VNR+ioPGfwTklwt3m9ecUPthrKMXNLFIGPYwnD2
         99dq1N2zx7mXd91FGGMrRAMK7VmAsWlb58+fkTJKpd5PJ7OeJU3zgROZERyczNYf2vcF
         W6fAmbR/oUr7QPUdps/Diu70mnxgYG1uNH4nqKX7pNXxfWgKXnyIgY1KaIWVgz4MSFJA
         hqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078993; x=1769683793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eaVvPdxctaVfym/v4SBx0duzy99NPGMCqQ97rGguHm0=;
        b=gUreeVyK/ZicQIVmtZWJKu4GttjVHROJBbyhvywJ4A+exZO3bsuRkUsHzwTFK9U1wy
         DFK8bs4IYt+JQWBnb8tEKyXh2+9oxSAhlgjM1F84dP+c3Df0jc1idfGpJzLtZ0x5pVbn
         P2ttf54PWLLFCVSzm2jFZPUOys0U0bf0LQEEwpZC6hQhp3aWVnQ6HUe7RSZpUh36JNuI
         a5vR55mkK8hxZ6HDU+JQ9m9svPz7T/VQ6rW4SPW6ob5HFXiP1/4EaRg+78t6gwFyXn/W
         ATfsgtqNivW0tGvzeL+7qN/xJGohniAg1n17xRtwyQmPG5I3ixEjCjnJ+tamdD0FojT+
         rMXQ==
X-Gm-Message-State: AOJu0Yw4FL4bkkhTiVaZJh2EJJ4npo2tnEVTuTa+1qtIcxqoNoGR9Q07
	CTFQH92xIwvOC8HFbpRAUJ9BqM08dRgLhwh3ml+I/OaC57aTb0IqU9OLxvz7cb687PdPWZJd6T5
	XqPJ8r2ieDc84HnhErEtOqVWi6eyvKgNfkiXG1Pe3dxOq5BmY1FWktMSVEJ+oYAQ=
X-Gm-Gg: AZuq6aJXRzz2Mg9YaR0C11OCJlhQdiizlJ8sODtUCuROYdVpriWFYnflQn1I7xXqKJm
	TItg45p+5QrN+33+v2n8piUsKrPgL18TwaFMv28S14lzWKbQd2BOcFugcKVCHwfsgqp1OdmFiV3
	ImWXgD81+s3otAIhwk4rCv36ipOG0ZHmyq5PfxVhG5OoSIB9d7cl8tkHNjmsIyvweVXzNEeYPuv
	l/BrsIVfB/xM7zMHhkm1hj52c0dCFzDUIbjiCvwTBv5NaT5NfXIeHqx09dDku4vKMvEEw1vfOZp
	V0wTzJpnkknIKlMvCk2rT5sfSG2IG7q9GVta9O23TQt9ZXaA0v34WpaE7dcgwO3COIesNrB7ELv
	JmSUs0Fz5j5NndjxrPPOIxpqBx9vXfk9t9lNswAP0mtPBRjReg8H//ic48AwX16AJMjdfeVNaII
	SV
X-Received: by 2002:a05:620a:4081:b0:8a2:ee8:e7cc with SMTP id af79cd13be357-8c6a66c8477mr2937672685a.5.1769078992852;
        Thu, 22 Jan 2026 02:49:52 -0800 (PST)
X-Received: by 2002:a05:620a:4081:b0:8a2:ee8:e7cc with SMTP id af79cd13be357-8c6a66c8477mr2937669385a.5.1769078992452;
        Thu, 22 Jan 2026 02:49:52 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm121704901cf.14.2026.01.22.02.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:49:51 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:48:53 +0800
Subject: [PATCH v5 2/5] dt-bindings: i2c: qcom-cci: Document sm6150
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v5-2-039b170450a3@oss.qualcomm.com>
References: <20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v5-0-039b170450a3@oss.qualcomm.com>
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
        Fabio Estevam <festevam@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078967; l=1158;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=B5r+Yo/9SDYaZ8RGuV/vWORvd/4+ohBj6uYfAX9/P04=;
 b=avAvsXrSsBDrajbBbVZwDtpKrzztRYABQg9Drw+sLt8tWOBjUKXYhyJd0Aj5Lwaih2O4gak5g
 XLgbYhMHt2gC2zhOC+GhVdTii6z7WSaE9dVle2ZyLXVggnaU0ACmWXT
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: gbA2WYvhyj6fMszv3yVFCuMbmIpihBvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX85Fb+UReEbNu
 epU6hBLCnxc9852TSJtiSySe808iOW3/jaCoLmXsPViE62XcDWlRXvhj02UoOc9TqK36rxzfiNd
 PQhEbCnp8xmU2LRqx3oLqL6LfFNTCTJYbu2PM1qr7gscUKcC6sJlA4Rz+VWI9Ya3y0SE3X1j49l
 QfHijBw+xfvM/I4KLkU86o+Cyw9Q1KTNMXchdYKn2/qWlJAPvzWFsepxYoN4UvX+lLJAsq6H/Zw
 MNiFe8a2kOgFojKEOocAZc/jMO2VTt39lAPADvRKWXxKocMNYVgubJPyZMpakd/D8LC9Sgfb6oM
 gaJdceAyYCZn11YR1dOz7X0MvfN3FTviixPh5BOVjrEkANzkI0wtt43Y67KQVAj6u0sUjGfgxaZ
 uijpy8zfTaJ6vrWodiOrCqbX02AhLscTd5acBm3ahaAHM7CDL1MCo9yYTKkOuPmJWeKCb1QeQxh
 IMu0TsmFgYqpgW5nFtg==
X-Authority-Analysis: v=2.4 cv=U4CfzOru c=1 sm=1 tr=0 ts=697200d2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=MV-VTd0to6NmDFHxSyAA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: gbA2WYvhyj6fMszv3yVFCuMbmIpihBvp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220077

Add the sm6150 CCI device string compatible.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index a3fe1eea6aece9685674feaa5ec53765c1ce23d8..d3f87da54fcc14a8f808f34c94551583d8deaabc 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sc8280xp-cci
               - qcom,sdm670-cci
               - qcom,sdm845-cci
+              - qcom,sm6150-cci
               - qcom,sm6350-cci
               - qcom,sm8250-cci
               - qcom,sm8450-cci
@@ -249,6 +250,7 @@ allOf:
           contains:
             enum:
               - qcom,sa8775p-cci
+              - qcom,sm6150-cci
               - qcom,sm8550-cci
               - qcom,sm8650-cci
               - qcom,x1e80100-cci

-- 
2.34.1

