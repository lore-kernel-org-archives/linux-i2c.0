Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FD3E3DBB
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934976; cv=none; b=hWM/S+ZbXomHDQsJFWtaOTL3v1/ATxFPzO/Dqq4rr7c84QxnvmB723anI1/nZQiGQdzk7abEk3jW+aRL7rVpc61oV4wnTGAiMcUV6t2u1AvpqVdMeZsNy/NcNQZ480DPYFior2uilg1SG1cqpcG3z0inf50yH3Im/freHbCBw+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934976; c=relaxed/simple;
	bh=OGpAN/l+ZCNB62iqv7OJ8/lTOeHL+3Z+8yqdVcmNtTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fzia9nNxWjlcLYZUeK+x9Up/WaX1d/rovLvmbOwYMe0716GSVXYEXDZqasoeTMs9mbVbSL1rzmcnGGIhKdgNBv/tagMrMOLBXnhgPnZBVF0Pb9o/gNpizTfb+Otl2jYm5Y9PqQCuimpVCGuW4thouH6G+Er3l1dkBn2YPEL/5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UtKGg4Lh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HY8uX3ub; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UtKGg4Lh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HY8uX3ub"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NkmE668623
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cVUooRcnsM0Mw8liPOqwiMPOxm9R+oX8vt9NMitZwd4=; b=UtKGg4LhMcd+whFy
	kcyTaHOEqdqGLg3jJTG0eZgVMLh0x0hARLqbEkclMYjT5g5ezKJ0Q3JPvMWFxpuE
	+Uvvbo1hRNXJOBxkqixuxehGcaJ0lqi+aeuL6SX2sRno7UNwrRpwVNBREz+7L+bx
	DyHI7EYYhkGFDTmNppe/m52XUpSBImLIOf4xEKtLVblKjgHU8YQjvqmQvZRGE/0V
	vhm/00UKdlb3BmlhXMH2bFu/x5Pe/HJhOJlcMaqs+Zv1td3I0B9dZeHLhf5Dl88u
	s4KN/ynkS8963ftZtT5g35Dkxyga6zC2e1KWR155mAIf8fNlWM1TDzQ2UyjNgNNp
	9g6ikA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm1vf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso189802a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934973; x=1784539773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVUooRcnsM0Mw8liPOqwiMPOxm9R+oX8vt9NMitZwd4=;
        b=HY8uX3ubQP7LtvTOPoZYilWfMTxFsvYl1d/j0jmheWb+AjxMM76mjfCcfAREK1b9gH
         1PqRdUrjdZJRN7be3Ot8J0hQ8VmUIO4aYAjc66DpRlmVJzRv4uMzu4M8TbftIKe9h4KB
         56EZVUZ3A5pqIeiZsceHweP4L+Z2zS9MnVrejA5EiM+aP01zJiyqK7dXykWgeJ76WLEA
         aie+IDb7OhBh85CfG2SnZ5eAQ8hAnM4JW4nNXVO222Q5L3kZ8IEMj8qMqdzqMm5h8VyI
         dP1k5mU1f1WXup67w4AaFEqbAJII8U350jntxQtANFm0AycSLdsNAN/oeYSMw89dPDeB
         /+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934973; x=1784539773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cVUooRcnsM0Mw8liPOqwiMPOxm9R+oX8vt9NMitZwd4=;
        b=W3W7DIxD7Y0Rwsq4FxGfI0gr2C4d5PaHoRp+3hTm7es2UlDNBYV5mpDvmF1XWbPOxS
         RWv0w2lHg5pfOvtOyuALwvQz4gVr2h4EZCgoWNi9mN6lh1S3P3kytBzMiFgOEc1gOviF
         52hiE9t34Gc50dIvDvAWLKCj/rmYvizSj8Gue+p1zKRUB7hjOhca7wcDv+2A1cDIuwNf
         CGEUCK1KWDhbDbZOa7HHNcJQdU+I2W/yf5BqWrLlAdSjthEIm1HSn1px3GrwGhiwps5p
         fVjYpXn+6MTtEEspwsz/44avLFENpAAY83th/IRlStLba0dqzSOo879IatOwHH+jtQ6g
         3gTg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3vBR/2XoNUsX+u+yVXuIBSien0+MG0sR77UKi4AlgwGK/UTJPlIEPGNW4vUvmqLQgXdUGKMHj9mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGnYFLBSNDLdWWQOwCYGOKUZi7TQyM/pFn0SjXLou+bpKZBbE
	ev7gAoS/2Ygx1OQPVx23dAdq1WdYdKvh3+A3zwBBFUDvQd3j1zTkhGQ0WCOj57OKK1x+czj0wP+
	Ej6NcdD/y8Ctrp4JYyM91nhlO31Dx4sMKaPDbQ3OdRwxPYjU3xhuXqJPmbdMsEqk=
X-Gm-Gg: AfdE7clKPsT2utlJi/2WgGGXd+15B6yT4Tqj5gbVFGtN9yGf0JsPo+3S9lk1KvqCMvF
	BhoSj4uG+r6IcdF1LaC3uysFQwxm3qIptpeKzIxG7Ad6MX6sJ5bk77EEaQwfF/TEvBPUGfsyFoO
	ryfoDX5/DqRQOpAl+Tg6uNC1v2QSyWaeq3zE2HtkFSA8+GXED3rUj1qMqUxXpDA57Ft/0Gg+rtV
	Eslch+Z5uWd4Z6Ksp1kDp0XGdfwZdWoZ5Ie56XtVZwvvVoUQiG9w0h7znE/c5q6YeI46G4KGAjs
	FAhNd0Z8KxKAjFJSnM0WAgbhb+ebFP9ixOcpUWuWJWJQ8Y4Yuxj/GYDn6/j3QmDrN8Q1jXv0AJK
	fsAm27lkpMbPVGWSkaVqG3bxoFX4Tu/xkmw270dq3gw==
X-Received: by 2002:a17:90b:538c:b0:38d:e5d0:9bd with SMTP id 98e67ed59e1d1-38de5d00b5amr4999384a91.26.1783934973444;
        Mon, 13 Jul 2026 02:29:33 -0700 (PDT)
X-Received: by 2002:a17:90b:538c:b0:38d:e5d0:9bd with SMTP id 98e67ed59e1d1-38de5d00b5amr4999349a91.26.1783934972978;
        Mon, 13 Jul 2026 02:29:32 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm47495569eec.24.2026.07.13.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:29:32 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:58:37 +0530
Subject: [PATCH v5 6/6] arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add
 DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-shikra-camss-review-v5-6-db53be15dc4f@oss.qualcomm.com>
References: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
In-Reply-To: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783934917; l=3663;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=OGpAN/l+ZCNB62iqv7OJ8/lTOeHL+3Z+8yqdVcmNtTY=;
 b=9E8lC1f9kmO9Np8MUIG9D+PhYi8juyqtA6Z5p2DNlLrGugaIVWnCBr2+FeL3zPsWnq3MDfnbn
 Ir0kEZxN5Q5DaQxhtZdep1f6ltwH7fTjvtv6eLC5YGwMKdA6WLZrZN2
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: 4e2dvb1sBthGdvdMlu34F2Wds8XSUn6i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfXxrWoQ8lcOjbJ
 /9rbBSGAiVusYTYudkvceoZ5H9Pz9btV5n5Lz/2LFWdgYWhUmEOkSKNiD0vAAPEuizUljWbIjl0
 xcJBIddePFBs3Z3l21fPCKHJLYT2WDimBWe5cyFZwImSHu424m4vi48PzOMYsP+zzkB/bwYh58M
 ck1/7AHSuoHD2tlEHeQ+WQKchXs+2F6ShtioeNCYymKJ5fbNN4joouVsI6UXYPqNJuAYIZeQXet
 gREDAa5hlLLRDgR3mGcqC8t72BWmH77rgvgYAUg0g2g5KJTahPkQLOlQW6S5Lh4QUOwbfGsH+/k
 H9Q4gnQV6abwLujsxfosvGeB+Gf1WX/UlXp2QA9kYrvRijb/p29JfCRgZnl8mGsmF11zMuLJEIg
 bmhsxyw6g6C9gYontjukdGQeiDezV7r4YE/ZOHwVWAu1s7hDIe7u2CG82KiU3QTQw3jDGOwwkq9
 WuYqsdOLKEAmoDw0NGA==
X-Proofpoint-GUID: 4e2dvb1sBthGdvdMlu34F2Wds8XSUn6i
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54affe cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX5G8LAFl/QOiA
 n2Tlo34+ygcpkg3cyXpEffSmWacTz0yqIhgz+lI3VXuGnscOPzyFgdPBZQQSKhimzm2Jozt8ZfM
 1STYB6lpT4C1MMVXsZuJgAy7DxPbIPw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130098

Shikra IQS is an industrial-grade variant using PM8150 PMIC, requiring
different CSIPHY and sensor supply rails compared to the retail boards
(CQM and CQS) which use PM4125.

Add a dedicated overlay for optional IMX577 integration via CSIPHY1.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  2 +
 .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     | 79 ++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 16e1701b6b338c2fedcd4aac4e331336c59780a6..e79419194d9aa1ee2b0bc8e836e7c28630f90a50 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -340,9 +340,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
 
 shikra-cqm-evk-imx577-camera-dtbs	:= shikra-cqm-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
 shikra-cqs-evk-imx577-camera-dtbs	:= shikra-cqs-evk.dtb shikra-cqm-cqs-evk-imx577-camera.dtbo
+shikra-iqs-evk-imx577-camera-dtbs	:= shikra-iqs-evk.dtb shikra-iqs-evk-imx577-camera.dtbo
 
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqm-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= shikra-cqs-evk-imx577-camera.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk-imx577-camera.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm4450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6115-fxtec-pro1x.dtb
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..d8c968a918c67cdebc0e7c6fc14ef820c97ecb75
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso
@@ -0,0 +1,79 @@
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
+	vdd-csiphy-1p2-supply = <&pm8150_l11>;
+	vdd-csiphy-1p8-supply = <&pm8150_l12>;
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
+		dovdd-supply = <&pm8150_l15>;
+
+		port {
+			imx577_ep1: endpoint {
+				link-frequencies = /bits/ 64 <600000000>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&csiphy1_ep>;
+			};
+		};
+	};
+};
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

