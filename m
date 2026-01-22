Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6008A43636E
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079017; cv=none; b=BFOpeZGyL72ZHKt9dBBFIlPeZkF7Bdxky3cPzAmCbU9Ybo3L+3sNX+SrV9zAxr5o30T8falgSUFXD/xgY8FMnJN928kzgJBKMbAL4fYsj9sqU0Qstb7e7J9mk0oIr73oEjgG++5vYSlZZYLulUptJ0ywi9/W0Dv0lMXrffdsJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079017; c=relaxed/simple;
	bh=urisQog5JZfbdirBxu5tGAO+ASUUaW9dPoY/c9Nj33A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=El9uF0x6hBPUBGLIO8u4Z1ZkGNd4dzfcM1ZOFH6vM9egzxAFl9v0rHyjbBWhm5aVOMQlFWuaRmurbF5vEXY8Tfp+p9RL8X3yam3pJufGmch+jks2rVUSrXikaratp3eL930vhjgsyFf4gxjh7bGtsRBh9tAemvk9qTq0iplAXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXCFtWKS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CgAPMvA9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXCFtWKS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CgAPMvA9"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6G3B33902101
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=; b=pXCFtWKStN+tJu7A
	slfXABaU/YsMvnGguwvei3HFptmC3STtQRjRQuArIpsmd71xtHvBIupXnvrDEhk/
	HMhyW10V9h3wfCpcQqgx0R2S35qM1i9UTiZlWSFIM596axDZown207KKE39Ouz5s
	znemym+CjIADeKUXiCvJk94/7uhiHaD2dtpcpG0x+ELAfeAm9Lwu1GxZIpBSOogR
	7HhOmno+IEyqC2UrMmKZ1KdhmYxhD8SAPbVANDLhebjdJxnGXgI64wJROYIHW+6B
	suXkBJNTTIg0ed7gt1AgUIb1d52GYWxS+H7VGBkwgOvoreIYeksJxBqaNH2T+LNc
	WXtJ/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu4khjhf1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-502a8fa0a28so29131241cf.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769079009; x=1769683809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=;
        b=CgAPMvA932sYvrYekyMptjY1NumFE+wVn8q2oI+v30zCaGm/IqgQdKGNqZjD7lkkZi
         aV22NtlNepNrCw8ITJwYcexzaKlXnB+ltwxL47r7SoQPcpARcxjQN+Zw63K0jovFWoa5
         g+k7+tdMyKA1U9XG7ptR4YNtLnOz4jdqC4saAYdAqOK/XfZrcHtVHYabvvlIo3tboyYt
         /u3m0qh9P7Azn6u2YpKJlS7JP9ixEO56FUspmGHgVAuk2durUhgH2wJmD/TqzJFKSUk8
         OuBsn8rgCi89XyWybu9qbKh4MapQenH2vmDIkI138VwCCPx32pwumg2fNsh79sNvGXZO
         D4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769079009; x=1769683809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oYe3a+X8RQV757haNblqDrC0UCkSImr/La6BxbOeCBI=;
        b=RT4uiEXWxAUsBaaXnww7Xibwia5tMRcXaqIynFJMRW+VwsqmmlnQUTtQcEBT1x10he
         f0t7XhxAgFsat5dN9TGi/2XawybtrHVfdBoq5xDW7p13Xy6scYCzUKd6HLzDALjFaqkT
         pxSqzrcQ79Jv+rMvMQt21ScDFXFXfw9KGq4jseifHQDVZbGJcaO9sA8P6kafbhL6wubi
         cBv95xP3e6HtSx7BxFcslAMd0nZedu81QirsACYAPe1ZKwa+8jQrytKsN0ch9mJ7aOeO
         VvJ0MWCGDq7Ele3lJpNpqfZ2wEgDbC49ndPfzWcTjQSW6g5Mgdtc5aisirDtelR6y+0X
         L7tA==
X-Gm-Message-State: AOJu0Yzbl1Zn6UVlN7Q8BT+N5v8XKCMl5Ppx01EyH6tnlRarjDqKH0aE
	9959AIzM2UxcAxmT5YLVNlGdKcpuHPvGwgJ9ts8EhjvbHngIA1UrKQoxizQFJMYHhk7G2YfQXvw
	mvRDO3G+7pCEIbag1fOmJJAlATClkNAxX9zidmX1rFGG59Fn1matRKIn8YSVZVXo=
X-Gm-Gg: AZuq6aJQZuZbP17zW11euYo+ucyxrEXQ4xkVE86QTwz5UttX447luEMpL53it+1CeRR
	EEJdy7UQlSvx/6NSi1Jt5EeP7k6Mh+31TM6tslpNoLZl0pA92GiN1Fs652XaEjOIOYG5u8kzW9F
	Ykm9V3SHPtZowujtwkxU55gjtCmpc+JFPHifLmTBehG3y0O5Mdx3fkW6x5zKZbnvCLTGr6Soh/g
	0Jq4+oUifre45Ruf4FnVL8vPqoIkILEvDh+gn6AnBHPi4p7cKb0UK83wETK1ESi0ZcS7h5+44ND
	Yqzupp/sc+1eMQrHkATvd2WOpPcmgy8QN3RlMIwHGfy+dKlVJE+XKVIiPkBBFRpYZ11lniCsn4L
	e0Eu45fDpvKY27q3dZBKpUfdD+WX5q9l+tt+Sa+rYVAjQRrLvMHVXZSPirT7EGhjQkuKFlulMuG
	+w
X-Received: by 2002:a05:622a:180e:b0:501:3c88:131 with SMTP id d75a77b69052e-502a1e05425mr286886811cf.22.1769079009363;
        Thu, 22 Jan 2026 02:50:09 -0800 (PST)
X-Received: by 2002:a05:622a:180e:b0:501:3c88:131 with SMTP id d75a77b69052e-502a1e05425mr286886531cf.22.1769079008952;
        Thu, 22 Jan 2026 02:50:08 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm121704901cf.14.2026.01.22.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:50:08 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:48:55 +0800
Subject: [PATCH v5 4/5] arm64: dts: qcom: talos: Add camera MCLK pinctrl
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v5-4-039b170450a3@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078967; l=1538;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=urisQog5JZfbdirBxu5tGAO+ASUUaW9dPoY/c9Nj33A=;
 b=8b2oOOOPX2SdYaNULjliR8pcPHELaBMrn0YzW4Aoq5mhdvzr1KSJ9jHs5y541HZm1Mu/hUPLU
 0xawCuOjhDaDEslehWSigU9NBuW0C/AQjJkIfSeruRcugbj2FeHIBZz
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3OCBTYWx0ZWRfX7oJq3XJW/1Kl
 1CIV/AmW0gSexnqUaEDwhSZMQ85T9jGAhF+e0NRIv0PDJHmiZmP8zL2zke9MiugvUDI3gaqT1at
 FyuUi5TNwckYVkWIDHyHYoRMyHzjh93rE+vudOgl7AzmT6EjCrhkzBq8GpTKnlu9t8PISVTMug0
 QZzKWoX66hzZxVV36AFqC7jmB1ZDi9lh0Xjhe8A1FhnTKN/1ffGBMaSHPrFdhib6vMMfytpKYTF
 eosKetQl7j6KcbI+0H49q2F0MjqZR8w0P5ILWAYKEAUEYA4JQvR8pjST1pubsnacHr0C5oXcgfm
 t7B3/jnzXUcTWkCJ9bAF8zeHSXrSAOoxuQmD1czcLkfe4QiPWcsXKUMMKC9E4Q+2J3Dd6xqu8XV
 CSYDtsyAJPS6HmwmSsDYKXusAi4RsI62DnXSjl3o+cCj+9L7ZKEePjhDIJbcBtq2VVtRBDkmiYU
 YavDPJytEoGBn08C+gw==
X-Proofpoint-ORIG-GUID: eoj2kU-K-puCNS0OCpK1u8x4Z70UBVL0
X-Authority-Analysis: v=2.4 cv=UOjQ3Sfy c=1 sm=1 tr=0 ts=697200e4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=butnsgrUGOw-u3YEFNkA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eoj2kU-K-puCNS0OCpK1u8x4Z70UBVL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220078

Define pinctrl definitions to enable camera master clocks on Talos.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 6d28096e50546855bd762e479b66ed6214ec5d65..33897994d0ca8a193acfbc94a932551a09c712ce 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1553,6 +1553,34 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			cam0_default: cam0-default-state {
+				pins = "gpio28";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam1_default: cam1-default-state {
+				pins = "gpio29";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam2_default: cam2-default-state {
+				pins = "gpio30";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam3_default: cam3-default-state {
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

