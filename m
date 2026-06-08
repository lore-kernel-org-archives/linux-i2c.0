Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7B3CBE95
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927663; cv=none; b=Qx8jHmBBIoxQHDKnnncKt3swR21gT8FqY3/wX1sj0E57iMn1ntWoAbf4DYDWzAU6UpUzPVdTCS5mKIn9l1Ey1KQYvJS5SxHgADi5OcTsLyfCZKs1drzZ2zQXb2erXDpzhYxmETceRDaEVJZq5B26erzab5GCyM++9BuFGg79oN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927663; c=relaxed/simple;
	bh=R5wAzXzZufa2JNL7Pu+bFDchV+HH1sdlIkcQCFcUAKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXTZSmcfp3nDIy9caLVrzIPV11FXCF83zsPWT4Z6/Z2jfvvv5jQmdK5pwolEFLisC/idVAZFXf/qb/ALfzMsivCDxHA6vXhEX838M5QR9CMvB0OCi9iLg1mSThw8VE7481ez1Q3tojN62mSQ8hRUrFvjkYLOpHl3OtyZpJmi04Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HbOfu769; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=caH2KRn7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HbOfu769";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="caH2KRn7"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DR4ko3782976
	for <linux-i2c@vger.kernel.org>; Mon, 8 Jun 2026 14:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptJ4K9XngG1h9g+wzv3R0d5a26qxjwl67BJuxrxeWOk=; b=HbOfu769D6HkdEVu
	TkNMjrgly8wEo1YPnLxmZOOIyBlOqGpLmqh7j9ojuWQeXdVUMCmSVSxw5M+pFF1w
	PS+PMW2u4aZgjNDpOZ+/mzwybopcc4oIyUOyIIyUwwYQ85e8WbY2h+uWIPb+qh1t
	UaWahRyfUeY6CGamWweiSzlgNRz2P9luIwh+bD+HMP9zyvif87ipGLS/OhwPGsFC
	iPrqulvo0Ff/2h1x9C7zPwF7+5Ir54zhzmW0f0zM2uA0LYmuBkFgnQPYOs7p/MAO
	jjMjl74MGTq+J9ll1o9iG6AJHNx5G3ebVFdG9baUyIp4PlJATyhaNPP+oaT5HqZs
	kRA0aA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxee08rd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 14:07:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf11699875so44362335ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927660; x=1781532460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptJ4K9XngG1h9g+wzv3R0d5a26qxjwl67BJuxrxeWOk=;
        b=caH2KRn7yzupKbZLEESrG+L9qSEcKCREqxxurNSMwmeM5Cm03dMwvPUQHbOGCKSNlO
         sA6SX3FvxYaqH34IJYTUQ318yuiyRSoWyT3IQ2TNbYTjI7T1yc1xf8h4PuzbRo4ngkhr
         7R1ESLo2dzPWTg6cSQo3bAK5F7tq10NxCB+tdYIwVc6PctWUgj9xm1s/0lTbzN1AzioI
         UtfIUT7yxOHeXuX+n3Qg1o8O8iEn6aCgtPOO50czrrhhzTwTWhAfEgVG5LpACei47+aE
         EYmPYfYjTA/FA9fcC9LGtV3DdZui/DZIIq9CixZGd2jlsk+IriKQcI3Utyhsdo/L81Vq
         cZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927660; x=1781532460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ptJ4K9XngG1h9g+wzv3R0d5a26qxjwl67BJuxrxeWOk=;
        b=AtLskuu4QuLoGSix+52BQFSZV+Yq88LsWfeZu2d0MKTPutiJE4FJu6sz4LizCkxyia
         fbvRQb2mf1W3OLlXgmRzqkGFDQdXnrTSNRgtAqhvctKWDNmllXeGYT2bCRptk/WX9SdU
         OOBSdOPUZSUIKMS1wHX/B9/EosCactj6DgLeFleU8fRVpxuTmwx/GwGfpJy6dMrbxC2P
         7/qnXsMr1pex7deapGJ5F9I32+IOzo3Ac7Ip2tcV/fJbxxIkV5cnzE94IhrWmWay3cmv
         o5WkZhYCrzvn79FQaM2mfHYlE2cT3zZvShJjLYM/c9f/vfqcl5mPKgNdcqSXe8AMEvtp
         w0ig==
X-Forwarded-Encrypted: i=1; AFNElJ8JYhGNdkC1skpRSV6ow/cEpuojIATEQGVHnGtELeI4zo7WaCvZmXLQtYWIX4SlcypqAfwZ+WdHSnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLu6Azquyc3tIJpEguVOcRTf8ewllFsvELfcKcIf3yTG2yinB5
	MzVoDi64keRzIO05BsqhlEUcNt0RutYJjl26SRASQmgRjvFd3iwKOJ6BEdFaTsozzMmcSiFEZi3
	zzWorKsvM3HOOcTOer8BtfwWdRr+Jtb2Ic3fSmGwKkVXLBAyjJPuk22Bfz7ukce8=
X-Gm-Gg: Acq92OElvuvHIhbm/MgeUEtGLzB14trH9npTjOsHnysVjWa0Gi6oz3apsa+I2G6394S
	FABAo64kT64geAopPcIMZENc7DJNOI/g7tRgi6XOonbMhBjwC/KRLT0asx+KDqBGYQZBgTQI6sS
	4u3dRjWIrnTdHExEdaxHiZ9o1Zx2+GLg3OZbI8DNT3Pv3kQyFCghBJvZFvNkdQYo3fdhp4sXqJE
	CL0VT783DHgsXqVrZTKMMfjxrcS5pQwyHvYr/c+SJwU8AVS00DFzatbCUizUm6ewBeIJKb9DUxb
	keRmMA9jGs9iYKsCQvE8GUnCxm8yn9xkUOaNHq7b6b+4ElJ3UaNh0M8YxhSNoxuTTMYbxq0fCVe
	k/wlX6y7r5NJR3l1DtruFWni+VYQvW8nVulPGKtTlEMndgQ/rLZCcinUvlXf5gPU=
X-Received: by 2002:a17:902:fc8f:b0:2c0:d29b:34ff with SMTP id d9443c01a7336-2c1ec514e77mr128961415ad.10.1780927659653;
        Mon, 08 Jun 2026 07:07:39 -0700 (PDT)
X-Received: by 2002:a17:902:fc8f:b0:2c0:d29b:34ff with SMTP id d9443c01a7336-2c1ec514e77mr128961025ad.10.1780927658999;
        Mon, 08 Jun 2026 07:07:38 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1646e5c51sm183935955ad.0.2026.06.08.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:07:38 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 19:36:43 +0530
Subject: [PATCH v2 6/7] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera:
 Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-camss-review-v2-6-ca1936bf1219@oss.qualcomm.com>
References: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-camss-review-v2-0-ca1936bf1219@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780927607; l=4611;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=R5wAzXzZufa2JNL7Pu+bFDchV+HH1sdlIkcQCFcUAKw=;
 b=NshZi54WeV9a8D97jiR1sB/dyTfMfPfOSFbl4swH1UfFSw1K6lBZdCKTV5R1848lCk9Nm7UxV
 8f5FJ1Q1u61DhgMy9lnbAukPV9ZrbtW5qzd2BJOA5ZlOsZZUZ+Wxxu6
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMyBTYWx0ZWRfX9IVR9u/9Pub7
 a7paX+F50KcqBPwvul2DZwAguMXiTyemILgMJGi8vNc7EWoe9iXiOV4SLrS8Muu8w/zkwWX8wzW
 48S+kzjTFK/SdD89w7VWMF2uyKbg6DqNtE1GP/sDoP/E7MBcye9GzWo5xSq5pkrC5XHfYm5y0J5
 5Q1OiwMyBVK82L0sgtf6dc5bcCgWX2HSgxaWc790nIWjvWDPKm+Jaq2lbpUyMVdN4ZktU+g/zTS
 J5qGZTwCpfGBRUE2tA4WsYpa2si2+wUmIenZsWKq+QIoe5clNZxDED1KXooUW08Qy8IrRDpH9rk
 kAL7a1xAvW+5UekJP9/PTcUJW6YQ0K6tJM2gK7/j8w3iOh4FCwfiFgspKigg9Es7eajj4M8+Otj
 PR6tpRQkQuHnugktMUaFXeDTTKgxL3FBcFl3xBJ+O9QG6t4iFN39Ia674rZYtw4MQJeBZGYl8z2
 kwE0Pp1lZRXqrGn4BIA==
X-Authority-Analysis: v=2.4 cv=V6BNF+ni c=1 sm=1 tr=0 ts=6a26ccac cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=5a0XiBUjDn2U0RQTkwkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: zcfnFd1ExlYgaqVSY770tAuTJn-GRpjF
X-Proofpoint-ORIG-GUID: zcfnFd1ExlYgaqVSY770tAuTJn-GRpjF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080133

Shikra CQM and CQS are retail variants sharing the same PM4125 PMIC
and identical camera supply rails. The only difference between them
is the integrated modem on CQM, which does not affect camera hardware.

Add a shared overlay for optional IMX577 integration via CSIPHY1,
used by both CQM and CQS EVK boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  6 ++
 .../dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso | 70 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts        |  9 +++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts        |  9 +++
 4 files changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a9e9d829fb962386b3975f345ec006504607130a..76b8f144983827f4905a72935e8d5291a227dc97 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -337,6 +337,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
+
+shikra-cqm-evk-imx577-camera-dtbs	:= shikra-cqm-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
+shikra-cqs-evk-imx577-camera-dtbs	:= shikra-cqs-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk-imx577-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..e3dad7c81e5e8aeb1061c784b5b893965f914a6f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/qcom,shikra-gcc.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&camss {
+	vdd-csiphy-1p2-supply = <&pm4125_l5>;
+	vdd-csiphy-1p8-supply = <&pm4125_l13>;
+
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@1 {
+			reg = <1>;
+
+			csiphy1_ep: endpoint {
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&imx577_ep1>;
+			};
+		};
+	};
+};
+
+&cci {
+	status = "okay";
+};
+
+&cci_i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	camera@1a {
+		compatible = "sony,imx577";
+		reg = <0x1a>;
+
+		reset-gpios = <&tlmm 33 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam_mclk1_default &cam1_reset_default>;
+		pinctrl-names = "default";
+
+		clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
+		assigned-clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
+		assigned-clock-rates = <24000000>;
+
+		/*
+		 * avdd and dvdd are supplied by on-board regulators on the
+		 * IMX577 module from the connector's 3.3 V rail; they are
+		 * not SoC-controlled. dovdd (1.8 V) powers the carrier board
+		 * level-shifter that translates CCI I2C and reset lines
+		 * between the SoC and the connector.
+		 */
+		dovdd-supply = <&pm4125_l15>;
+
+		port {
+			imx577_ep1: endpoint {
+				link-frequencies = /bits/ 64 <600000000>;
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&csiphy1_ep>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c34d371f5ac23efe59d1c9d2723f4..0d5c3e31b1f613157d4d2ec6947c630f1031b73b 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -38,3 +38,12 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	cam1_reset_default: cam1-reset-default-state {
+		pins = "gpio33";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7aed3121ef092df684b19a4de39b497..515af370ca014a668dc035ff944fb82b6e09ceeb 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -38,3 +38,12 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	cam1_reset_default: cam1-reset-default-state {
+		pins = "gpio33";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.34.1

