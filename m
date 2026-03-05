Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D537BE96
	for <linux-i2c@vger.kernel.org>; Thu,  5 Mar 2026 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704141; cv=none; b=LObS23QIbGCUKfVL/aVg5dQM8mnc+QMDC8qAvIQexPs0JWVGWWHPDSTMv476nyUtrqKWYgCIcSIRmDRyMYYZ+QOrjaMo5n+Htpt6hFbSXvfFkdF1LXX5tJq8hfpkj4nXiqQs4Vl+w+06m0IgbablpTbbjfRoz6kxITCLGbhZqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704141; c=relaxed/simple;
	bh=PxCok/m06RL8EtXvhxkBdkhQnDrY29ujrliEFTX0zGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsETMMbgtw6UzNxhFdWjTuqZMFCtTIOg40YhdBLSvgJpubqieX9gBPgE/ZxC9unyBIeFMZpgbN2stoe7Qpsna5doRYvanLpJ3qlBrc6syTiwQZoSUI4NVHcAkGI3lFhy1zLhflTkV61/zenH+4uZ+xXn5ddRCh/4UqF/AXA8GZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0eanmbe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eSyx1BRD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0eanmbe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSyx1BRD"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259BaiP3604191
	for <linux-i2c@vger.kernel.org>; Thu, 5 Mar 2026 09:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UTco5l+cTyAHR+yMd81P+5uIodWOmaB8yH0KycCwb6Y=; b=m0eanmbe0KpQ4EZG
	fwJYyZ/9ahL9lpyukyALogpv9cxSWSnZeI46S33ZVe4AVK8y2C1BH+uW8WAjj51e
	wT92BFgBGN+/uIHznYeinmRIjsiyXz0wAeHa0DubAIIEQxHOABkmvXPce8xeNjyM
	6AR1gEQzM15hAJwrCcq3KU83KNRg3jWTigIdr/QVnxcjxD+IA83DSU9OYuvVf8zB
	PTBe0+x9CXtha7Xmit5ktXklz94yEMA5WUH85/oB8mBKtl82+woEiJZdyqIWmucm
	DuhMQvbH0wTiebtcRz8pTsHL7y2RymWb9eHAw7H8qD9b5OUxTsiAyhhdMdilG5Xx
	xDkiQg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0war3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 09:48:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-506c0da79c5so625612591cf.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Mar 2026 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772704138; x=1773308938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTco5l+cTyAHR+yMd81P+5uIodWOmaB8yH0KycCwb6Y=;
        b=eSyx1BRDhzr9Ulhh66Qs0pELnVM9ZRxvXJZXgWOIKRkxywwGOaYsmsvxUAe2tOXsQa
         PdLi2wwZCyEoenrprzKaTHSCdxSpkPGetTX3+VQklJjC6D6XO1WA9Yu5zwgCYLMafQGe
         RxCbLfsYCkjICckWrl35AxfmMwVltQHMZADw1wYaf3l61ITb5+X1p7pFVulXAbDbUCIH
         +CNc069c4adHjC7HTy5w/j4zuWbbv4Xs1alrf+Q/eMIkJHcmMYnXkDhuzejjNagI3S+w
         F/yKVcq8kcD7HOeJs39C2VJkTnbEI8YHQ3i1fJ3GeEdZLsWZ9pqvNWvFeVcTicjqMffz
         3YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772704138; x=1773308938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UTco5l+cTyAHR+yMd81P+5uIodWOmaB8yH0KycCwb6Y=;
        b=gCJf9cZxOYf9n3McJ6WeQpJz3GPw0ACW11PvkYD18Ky31aLKEhlO778tCJKFbdHaYA
         2bgmi1uHHEoKiQ2t2/4mrPCAxU0MpJyhpznsAUnvpIFniB3lgum9DJtnlgudkSAQtJGv
         xi6E0htw7389P/HBU00L4I7Ia6gERTZG+uMge7z2p+n2DBaHNbjUZkOINID7EwX1vXjw
         zRgrDu6ckaObP0q5yKwWpF+lscv4tvsoQ0Zop1EHoSVtdqgwpp1TT5e5C1bDmKZZzzbX
         mpG9AIRnd/vEeauii5jnO9iY6oCHow5hv5a2VbVI8c/X2kILlZ+A0IrRKXaIRNuFLXrC
         KadA==
X-Gm-Message-State: AOJu0YwcLT8+3mSyiC2DcPz2tg7qkcoY0N5uK0gImEMx2kpnjYlPG9H1
	YkFd2Z5oF39Ig0sigS4oCzjQCbKgjRXmPfVSyJkGQHIP7JILY7nBKmqeGFXc5DjRiSs70gdVpuX
	igWaPxG52uE4bbF31adK9OY/Tyvp8XMkJUDzg6IXXLUjuMZO++kik/nANNFq0DwU=
X-Gm-Gg: ATEYQzw++R7ayUhscNQIXcGd75SU/z6Fos00sy+PjBBaEfIKvArlVmDXbri1nMjg56f
	3+RZSf1fC7CsR9w/g5YiwXKT8Q/Gvt+6KH6vzrY4Rz0v48nSKbzou0q7iU4g9/K83G0C4VpN5fd
	LUk7ksjKfr+OQQCiq5gp81fpoP4ByvabLi9GwDj4tgqF2OEte0w4VKWO5Ln0jA23vzYMPPLlNK8
	OvkD4nhPDKpQBcjEUpPRr9Pcfnk0QDZXnhSaLXnuoPJfOEuL8qLLOhZZ5y9C5DpaXQCke+P+4G1
	RRm+kPGIet+WzScCAuG4Sf1M6mxzppxSj/tPI/6EIfoUEZvamK1hWsxDf4CcWtukbmXl+F/yze0
	c+AkjBzSz2Ld8Fxc8BZPLrP9z1ol+3TOC6pJ+DiBm8/bpaNW/Dan5i9jlG0Mht7GGPGLCBXTm3i
	FWfL3OynoZq74C
X-Received: by 2002:a05:622a:190c:b0:503:2f21:6355 with SMTP id d75a77b69052e-508db32cef3mr62095151cf.34.1772704138552;
        Thu, 05 Mar 2026 01:48:58 -0800 (PST)
X-Received: by 2002:a05:622a:190c:b0:503:2f21:6355 with SMTP id d75a77b69052e-508db32cef3mr62094771cf.34.1772704138150;
        Thu, 05 Mar 2026 01:48:58 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074496300fsm177126211cf.2.2026.03.05.01.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:48:57 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 05 Mar 2026 17:48:15 +0800
Subject: [PATCH v6 4/5] arm64: dts: qcom: talos: Add camera MCLK pinctrl
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-sm6150_evk-v6-4-38ce4360d5e0@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772704098; l=1578;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=PxCok/m06RL8EtXvhxkBdkhQnDrY29ujrliEFTX0zGs=;
 b=QCvqamsbtXSXBcZDLP6JGVj8UEFEM6iTAPbY3uUtSzvfKRzoSV6fuCQYY0vBFV5l2El9SHEjF
 TWyDUqc5QqZANTVRm5sUT2Yqc9F9T6A+NHbsPYIv5LDxHIpYi7GFVTx
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: bwhu3JTe9lhyU_OF4qpSYA5PZs-VUcD3
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a9518b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA3OCBTYWx0ZWRfX5bwKnvgo9Op6
 vr+PzP/WGNiQdxksubriQkltTMyitZx/974ue6K8XCajAGlwgyjhXBxalMILbmXX3W+jTvzOy8k
 W7uKMax8yFgBVaST1ufqt4YKjUqyWRoXzG2R1FH0VHUSSHfy8n5svRIg12vEd1mXAIVH4ZAmDq9
 vSjunCzURqvUiZP+viFQWEU9BxgxHTwPCupV0oFA5QmRJ5fYOm7TGspocj6XqDgWwH/wq6XVdnP
 RaRW55d4R7Da227St4DRcnCY50nRJMMEqIEUSNW2Y5fZpP8zWWPiCPsVxNWJ0hWwY+Z8BBLFDcA
 GZCre2p04nZNfUCB1k9vt1bntMRplAZ1lLA2Kairzqz+UFzjmrztWdUjDJax3bs/GLHPY+TZIXv
 fcjJC8SbfMz4EYst9G5N17cYq46oyh/JnE1fOoz7tNZPa4rQ6jdK4hD4JaGKYxY6og2Bl5FcgKW
 fbfkaTw9fmBJS9jqIbw==
X-Proofpoint-ORIG-GUID: bwhu3JTe9lhyU_OF4qpSYA5PZs-VUcD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050078

Define pinctrl definitions to enable camera master clocks on Talos.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index ace2b2a0bf2b7e574b0d43f98ae4624df03b477c..9da6ae131b9195885458ff4b7688773620af8e8c 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1553,6 +1553,34 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			cam_mclk0_default: cam-mclk0-default-state {
+				pins = "gpio28";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk1_default: cam-mclk1-default-state {
+				pins = "gpio29";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk2_default: cam-mclk2-default-state {
+				pins = "gpio30";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk3_default: cam-mclk3-default-state {
+				pins = "gpio31";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			cci_i2c0_default: cci-i2c0-default-state {
 				/* SDA, SCL */
 				pins = "gpio32", "gpio33";

-- 
2.34.1

