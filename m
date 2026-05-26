Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801340F8E3
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815634; cv=none; b=tNqXY3LIS3CwGhtBpKdjUGcmpJP4AsPPBqM8ORTOqyaJyDzCp7DSSd9vNa8/3G0K6fnC3sDlY+dsMm1Yq2RwwbfUNItM6VASdVIydMJJD3/wSkMi8Hl7I/mcWX/wPaUSSoN5UjmGmHr6aLvjJDmk9Q2CYr44X4QtA4EatDAsZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815634; c=relaxed/simple;
	bh=wUE/ebaxyKGDfHiUqCyM5jXPVqYMeyt2f2pUluNnCSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqz9coBCYpCLmY3Ud8L8ikxT3ljPN/y4Vcm2xvffqcRmgewQdDBcOEMaMEptAxq+NWOxBmxMRoU6/Ul/kd0nxefQ78od4c80tCFuS7iyWpMM2VpgHrtT3akuWQVBLNT04oFyVP8XrsDdVwlsXUrU8Oh0OzYfjfYgctiXq1FoSpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7dFU35Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cQyw8f88; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7dFU35Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cQyw8f88"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH0wl0195528
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SHWN/CpABQpi5ue90hqnc7ukBQhLZVofwHgxOgWNJgY=; b=L7dFU35Z3epDssGg
	M2xP8S/TbeWLV1VeBbolA6B3kNJAPHA4m0X5VDYROVYcjaXuC3qtMAi9Za0oKz54
	6v5L2ZOtrkbfiAfnomKnXGj12kbO9HtQFDhSvjXJtJL1AZ33JrdVkg3aiFQRN4d2
	3M3UgHvzVctQ2r29ErlmV0qvJqwrSoGIgwo8LuEcWjL0lPKVasMNDxvl/SBbD+Dq
	dxHkcAG/lJSSt+kw2rW4DNLFk9dkxSrMYQ/M4ZRdUGYWQV+h+npmhDc7oik0siGp
	s63lH/dZ9uKGveKN/P2QYo5GZzqnmK0CWpv4jWBjNQ+kU2MO4aTOtFPmfYeDNCaG
	8F6tmQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eddd7rt0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so10787553b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815629; x=1780420429; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHWN/CpABQpi5ue90hqnc7ukBQhLZVofwHgxOgWNJgY=;
        b=cQyw8f88rZMiCjwa6soGSHAfKnK4ADmCNJgO/hDWTRsDpgb0EroXConeIsEzPIdws5
         CzpeJsriKA20TKwwmQ3pIGX8pfaqh2ekKOwc7fyXsUsJUnRNtWVCjNVo8UmTC4tCBIyB
         u+H5vr54uy78KtXbsd/5wIgUYRfCmMa1BpKXYYTFzMn63TiH9yoBVHobZ0/PGyNW0JWs
         bXzSARSo5zFZ6NKk5FILDhYahKD5blUPGElBQcMhLbTw2xIMxkwobJdUvWquAFgaeVwz
         //vOd3nCffrieZKhMvAzau2ryGkoH7ZpracKoc0sNiQ/FOVppxAWjlWfZvwRB0ATAJg7
         p7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815629; x=1780420429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SHWN/CpABQpi5ue90hqnc7ukBQhLZVofwHgxOgWNJgY=;
        b=QksgI11kBpItPft6G7KyFepiGUNEBE8G4/oz213PdQgWQY60PMxuadTIcV5BGcZUvp
         UTe+UNBoXAqHObj2p1ok3Qee2IG5yCKTBAfeOvU6dcJknAp1e85kROUu/yKWPiYF82d7
         o4elZjC5dBDl/dkX2PfQlXVQqZbuRmoajSu1tJ5Ru/SRvHNXv8oQwYtgfrjgNhcI2Dg7
         uVqgZnL4SMbUDmuMQIsKQm4359kMXpuLgjt/25EfsgJ0r4zYDR8LbJ9ZPWu4fYJgNJ/1
         7B3qY/FqmMqmDLEC2ztGeJxhIdFZfdbB5cZRTxG2XeX0TS/YTRtojbU2Ex0wIGmqrvDz
         J5dA==
X-Forwarded-Encrypted: i=1; AFNElJ/Psh3crsWqpyZ3Mjv/qhFfjgYaZqJkumTbdZm9P4i9IHpogNOy6iXU2RFtHxEzLB6fWCO1PfatMkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytY1FGOjMBIpTMmLVcZ3qabLviuOi30V9HjaFBR/ooibAvRrwc
	jb5CVeGsNP79offFxMfwANnjk2qv+2ixyDxRl+ubhLjoUHYEz3IArBMp0BK6kd/TfYowv5B0Jik
	eG07Ltb1qaoQa6wrD7ZpozLoBAD8p3Z7vi2irW/u+EHX0sI4RfpXKycV/B6XeYfc=
X-Gm-Gg: Acq92OHMgYi5V59a2eiCcbBTe8t07xxj7qLyYvnEUtsObEjm7SnyH1PBeV6P2t5lmTt
	+feyy3/gj0URty3L9RZ3dzntPqoSXf25/v0+GjY8bQF2P2Ag8rICwhLp9HZgACLL6FSEKghH6Ii
	y2jH8Bjdc4ZHxSxwh/720MAQbg+ZcVGkXnyp8ZL6bmj9OS8kKrY9x6nBSesUAUlHh8kKyemwgfM
	iSXpR+7/zqWCLDgv8fQx4zAP32gls1f1dRc81AeJnbltYEq4ehcF9hx3+iXX+UwaaLx+MUF24Dl
	EhABjji6AHkykoRADD/ZyJZO6w/1hJJrwP4vswT9UIxh3Ol1x+xhvZCb6YV7iQn/QHioZDEbiaN
	2WyPf1qwSVP8rZ/iy3I6cxn5Nt984is9qRuQTIf+nhNM8xbhV8cIb7iGnGD4kOXI=
X-Received: by 2002:a05:6a00:4503:b0:837:c1f8:6e55 with SMTP id d2e1a72fcca58-8416112c734mr14803836b3a.14.1779815629333;
        Tue, 26 May 2026 10:13:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:4503:b0:837:c1f8:6e55 with SMTP id d2e1a72fcca58-8416112c734mr14803793b3a.14.1779815628747;
        Tue, 26 May 2026 10:13:48 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:48 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:51 +0530
Subject: [PATCH 7/8] arm64: dts: qcom: shikra-cqm-evk-imx577-camera: Add DT
 overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-7-645d2c8c75a7@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfXxp8Az7UohYis
 81xhQ7u+5A+YeqfXpksx+TUsxYp3nW4MwQwJnJs6WKQaRJUG3vvd5eCf4IDtlDz9gp4IE7ZV4Mw
 YU64Na4KyMO/bTcPCs43OKC7MqNwaW0NBG1+0jGwsDfhpuZtelc5PxGRBThQ2B7C/EaqgVv6+KN
 h6YvAskrcbvOwFSz2yekO3WcxPO8RfRVRNz3rKlmLqLkM5dqdXRO9U9xVdQbcxDZ4fpoU7GAhP+
 pxqvbf6O6WpXHvrC/QJwUTFNk87gCGSdL6bUf3jYpj/hpV6gy0BWSUmKz2jZw7ST7had7m7mnMF
 7JzwoBIwXnEgm/gWOybfRjo5uXZpFt4A+dKQTHy4KIsHu2VhjtUv/bbHvFIT7HCzPzAEN3AgI5/
 dtZdRY3jtKX/fa72JI1DePNOtxGB21vY+iFClOju1t8ZTlEEfrMndtE3WpqLMgySEtn5SaULrf+
 2iURX0sybILpK5xf1gg==
X-Proofpoint-GUID: pIpq6ryoXhix1sU1m7Lb6XLNjrwc5drG
X-Authority-Analysis: v=2.4 cv=fKsJG5ae c=1 sm=1 tr=0 ts=6a15d4ce cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2GryoL8Qn4L11UQNV9cA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: pIpq6ryoXhix1sU1m7Lb6XLNjrwc5drG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260149

Shikra CQM and CQS are retail variants sharing the same PM4125 PMIC
and identical camera supply rails. The only difference between them
is the integrated modem on CQM, which does not affect camera hardware.

Add a shared overlay for optional IMX577 integration via CSIPHY1,
used by both CQM and CQS EVK boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  6 +++
 .../dts/qcom/shikra-cqm-evk-imx577-camera.dtso     | 63 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a9e9d829fb962386b3975f345ec006504607130a..df41830e18edff82893ca24ca84d7e03065d0ef7 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -337,6 +337,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
+
+shikra-cqm-evk-imx577-camera-dtbs	:= shikra-cqm-evk.dtb shikra-cqm-evk-imx577-camera.dtbo
+shikra-cqs-evk-imx577-camera-dtbs	:= shikra-cqs-evk.dtb shikra-cqm-evk-imx577-camera.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk-imx577-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/shikra-cqm-evk-imx577-camera.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..aedcd164810cf687efb425da79ace7ec6453e3a5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk-imx577-camera.dtso
@@ -0,0 +1,63 @@
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
+		pinctrl-0 = <&mclk1_default>;
+		pinctrl-names = "default";
+
+		clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
+		assigned-clocks = <&gcc GCC_CAMSS_MCLK1_CLK>;
+		assigned-clock-rates = <24000000>;
+
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

-- 
2.34.1

