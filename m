Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1413911C0
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781877; cv=none; b=ptrpvt6+ol2thXyg5CE6+WcEI4QCKN6Qq8SuRPCQs4btNg5FO+jA5MGNbpRo7ukHNMXAbI/vaVpbD7XaXsxJKihdCiVXh9ViCxIvmDWxlnHeMQFgR0JSmF4cyddwIHB9h+592QUFpzWi5J+MkA2F/y2saYl1DMMx60SGoySA2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781877; c=relaxed/simple;
	bh=yiYdgiJqd9IrcyVppfU6gBuaofPptGycHJJtR/oHevs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSRB+yBtpEDvwWck3cO3/TwC0rAT/IvBC3EC/6T/cvWhrjC1hwCbDCjIZXJPegBTAF2HAGv+4LNfxvX5uIO/L/H0F+HDBruXdJ/ml03boC7JIUlQwI2aq8zhWzV9P+4OLBW+nKmNzb1o+XBaSKlu9eRKXUyE3IwDQQYCkrMDDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KmEayScr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jqs64Oh/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KmEayScr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jqs64Oh/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0XE262365495
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4nC2LTSIQg6tprR91g53nLLPdKX5ERT2wD35VYnpBLs=; b=KmEayScrLrlkDk2L
	8TEFVvYxrvJmEBp01zyrP3qLf6KDGLpJJtb7jUzpdVqnRdcWyRDVoQpH2/9W8ew0
	jmwCis45gvpZAkqnnG1MBYB7yyEWnQi2tGh/rykWMnblOa1cEPR7ZgJvV4A9N67d
	g63QJBfhdNe2AkJ1pj+ldiYIq9JQYi73Ioy+5HCJMMYUy+ZgbftDkMlUutkB8UBr
	uuSCNKupRYZU2me+UDKVMpfiqNGoYzJZIvS3XBD6mJmzUXqL/2nClbv+S9uqSRCE
	WC9kvPwnud2z5CHOWEBm407rXYmLT23UFS3DvYLkv71JDm5ZTofgRcDrG1nyKnzb
	uZBu2w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vj9pr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848544a8496so298535b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784781855; x=1785386655; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4nC2LTSIQg6tprR91g53nLLPdKX5ERT2wD35VYnpBLs=;
        b=Jqs64Oh/hv5Ofimkkk0o5IKOM2Yd8Xy6QAZpD+G7wXBd6O2G/NOMhsm1sv5wYBXMRL
         1ZnqM0BQ1EnGP0JpNjvJZyiU+CdqlYwRKniz2cAs2eV06mqoQx4SJQ/tnEOMz58ZW/p7
         HxklvBXQwDM2fg7CTIypqXgBkHhOW/0S4REO+PUx83r3qBMQpuHyYF/NeOqL/qgsqdOY
         NYPRjPcjm1t6uPjzOKwBc4+j7vWGPaglGzx26t0980Q2JCpWZBtsS+ganAtSpBDJEbAe
         9TuZLNZ5zvmxM0WZIo+QXYuhyhc14PaCQNP3vGnjwQYsRE59q9ZDQh7RsPKwXt20u+ES
         ZkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781855; x=1785386655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nC2LTSIQg6tprR91g53nLLPdKX5ERT2wD35VYnpBLs=;
        b=XyizWnGqGiyBdjp5K6BVwwCgXziyj80BM+vxyyAK/KCHiOncQfZj+8gyNrIkYksF88
         cSJrtkjD7tFdvoyBrAHGNWzNzGoibm47rpRZi4gQqI2cV7R1yl/2QxjxMh5qqKBj2odw
         XnQm+jsLSrI0nPWafpX9ikNvUH8iiTbYCtgm5XkkAyT0d+UY7kRA1Hcv7LRsuqo+sTX6
         nzwUF6f/RX5Nkzf9Z1E6hNxIflr1H61xY4myUUFpshPmv+4mLoQBm6IN0h7Fg8Y+hU0A
         LqfYcvtDezEiez7u3CAsubi+/KcYKlUzlKgpriugD2YGsvO1mbQ4fQDJfYl4f/+WaD6K
         W4GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPTm2Oyp+IMj/NhiNYBoydRXVRb6xeWCk4Qqo/Ha+UGVCVziv7OkcrQUYJI8EqbwME/G4COeCxV/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3C77GGJCZzVpYLQNRJArnNgPBeETFuF1/T9z0C0fEmC84iSfd
	xLD/uDGkvgyn3xLmRqVIiZdBmVN+F5JGAJ5dlGAO6HBo96So5Ki0lpF6yhVd2dpnM8pn+rLWay9
	9p2uqaRvdZTLESQ/UL5jhtyyufro632dmONrTPaTogd1Pl7QgGWqFVlBOhJ3t9LA=
X-Gm-Gg: AR+sD138obw5OMiGREFHQN3UzkIZAtGmrFUmw0ETsXzFkd3eYE01DF6J1oHCXS2qfWD
	33XlssoqbXyGyj3W16IXrJIyysVn30kWDP98GQhCxJMb1qg40iH7bgik6bLqR0Zh79qjRBp/yHu
	AR4sKWmjpxALlvcboU258fhff6oyIiwmLCsN3S0nvc5LDrWEe7BQBQ8y07nEH1KgRce1r/iaLkI
	wRwiRN+HWC54QSv7BN2h92fIq8fIzvco+uopUNuDlwnkPTwnm+uvmqnnufsiMbTQFz0gkTUj8dh
	BcUfFyZq19YdAEcUysV1A7yYcv6JhDssxnqO9n5/C/HUJzeyUS55DCzCpovv+aR0a7zRyhPzW8L
	kxb9jKm7sATyGlvJiu94z6S3Lwuloync=
X-Received: by 2002:a05:6a00:a20c:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84e2bc191b4mr1845624b3a.76.1784781855205;
        Wed, 22 Jul 2026 21:44:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:a20c:b0:848:2f74:1d66 with SMTP id d2e1a72fcca58-84e2bc191b4mr1845596b3a.76.1784781854753;
        Wed, 22 Jul 2026 21:44:14 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175aad1asm2327922b3a.44.2026.07.22.21.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:44:14 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:13:55 +0530
Subject: [PATCH v6 1/6] dt-bindings: media: qcom: Add Shikra CAMSS
 compatible
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-shikra-camss-review-v6-1-7c46f9bbb4db@oss.qualcomm.com>
References: <20260723-shikra-camss-review-v6-0-7c46f9bbb4db@oss.qualcomm.com>
In-Reply-To: <20260723-shikra-camss-review-v6-0-7c46f9bbb4db@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784781838; l=1799;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=yiYdgiJqd9IrcyVppfU6gBuaofPptGycHJJtR/oHevs=;
 b=2a+i34b6L4suWBSaj65sVWFwqZeY1Qa0wKJ5bBToRjvGqa9hw98ZhfM8ZuXl1Ob00IrzH4lN6
 J3e8fg1VKtMCUmyvsCfYDSwHZToBmpyFnHVGTdq0GdZOqLeO8ZCSReU
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfXwptJ4exw1una
 yIByF3W0fo2Rpn+1fs3O/j5w4LAW2/kMkDazAx/4lHi8BLplfKp3RVbr2Z+RLHP4jjhUvMPM5OO
 hTuGsIM2L5Y94leKHa9fc1lP8xT3GS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfX7VvPxWa6G1OV
 /OZ1RbBcaED9NamhQsdeSZCuCwUb8rFUk0CRP9KEi7cya6Yr5SJC4UEeXClYrImhY/ru20zg5cM
 S+mkBjupvLHVsO+eFoo2qoCu7Sq33k9EAzGEK/xL+P+pGcpY9cUx883VLqkRDBfyhQFlof8+R1a
 t3ndal+5NB0wnPOcniP+u1e3Z0SzsXYJ6P20sjWn3StzkNnoSvhdEtol4uo8j7FyGC0lSV2ZoCG
 GXvvTHWrM0w0P5s53yAwYOIgpWRWbD0jAhLs/X8fe+1uTI+XZISJPKmO4Rvx3fncd0L5sMGYwXn
 apS6X6eNX9wz9lFJeDCTM9C0WnAg/Zln9MWb17ClqqtzrXwBZQdspL28AEifLeeJJkuFP86ItR5
 jN7tRaQJA+ynHYkOdwg0dxBGLWHlrZpwxz6Inn2teSJPB+H2oxTOBjf7yodRoJqITnmqvy1rdqG
 kypFX/KuDWi3xeOhaFg==
X-Proofpoint-ORIG-GUID: YT8UzglZbluB_upRM9A8z4sGFp9BdDaj
X-Proofpoint-GUID: YT8UzglZbluB_upRM9A8z4sGFp9BdDaj
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a619c20 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230045

Shikra contains the same Camera Subsystem IP as QCM2290. Document the
platform-specific compatible string, using qcom,qcm2290-camss as
fallback.

Unlike QCM2290, Shikra omits the CDM and OPE blocks, requiring only a
single IOMMU context bank instead of four.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,qcm2290-camss.yaml     | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
index 391d0f6f67ef5fdfea31dd3683477561516b1556..490a7f3a8c5ff9c624f46150ee651793811823de 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
@@ -14,7 +14,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss
+          - const: qcom,qcm2290-camss
+      - const: qcom,qcm2290-camss
 
   reg:
     maxItems: 9
@@ -76,7 +80,14 @@ properties:
       - const: sf_mnoc
 
   iommus:
-    maxItems: 4
+    oneOf:
+      - items:
+          - description: S1 HLOS VFE non-protected (VFE only)
+      - items:
+          - description: S1 HLOS VFE non-protected
+          - description: S1 HLOS CDM non-protected
+          - description: S1 HLOS OPE read non-protected
+          - description: S1 HLOS OPE write non-protected
 
   power-domains:
     items:

-- 
2.34.1

