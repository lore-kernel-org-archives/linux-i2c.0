Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F6381E9B
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781906; cv=none; b=rWxPRInL3Z7iId5M44SlaGSvjVQCYRTCH2R2hmmPRnQkPdN5xVYD8zUj+GYCa1AaVum/oaqhiXtgkbNlpsoYc4vj2jnIOshVktPOcCquC1+Qt06H7GoN9THZkz/cqoabk7XEHtpSfEh6sYsccKJnuD+M1KGSBqLD0jCTCwOAO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781906; c=relaxed/simple;
	bh=ZA3HAjflV0tkYLC6Nd8u+XrixaMrLTLfnMhVUY6WrUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuQGiBfA0/+clM6jLpnhGvHXsRvhdGJokDChBUyYCfp2jUROyHcjtewqURoh7VQB1rmx/Zwao5HU2vfDV0y+vB7HuyjebyXnrGj/UjqA1sAzTaq1kVmGB0MNPJPs6XKV/dv006uRG5HfREtZcAFa4btGI62M4fsyzs1Mhp1V5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ko9yxgPn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BeC30IbP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ko9yxgPn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BeC30IbP"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0WrdP2364563
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ogOnkizJDQbuq0BIHPpDBbizrKgtonMZlEbEehGvr4=; b=ko9yxgPnI2Jg62yb
	wFAMtqQT2XRL9LivtLbBLDosOgM6Pcn1K3zjQmTtCh8q4K1BIGOCxCz5rlJxgKeC
	xp5cMech2j12I/6lrKQPEgP/cBZ8SY9NBKC5fuDRpBgI18d3PG1pJiKEEODnSeVU
	kFdGyrRcu6ZWyI+sPsLdlutqwn0Ed9HR1FD+HB+FonnLZ/uV+OZUXI/mt0CSzTjA
	UZ3SVBx+BihL5atNuQpCB3etkx+cysq+jU6HzTvzHr14Yo11IN9gpTW9zGG6SPwk
	TsXfUt5X8gVVc0Q6to6YmYy1cLDHruxMyKhIdI9QXsrm++iwv5Q+1nY2tpbtCDpv
	EW9pRg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28vj9ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso288122b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 21:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784781886; x=1785386686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ogOnkizJDQbuq0BIHPpDBbizrKgtonMZlEbEehGvr4=;
        b=BeC30IbP7WEbfOGJ+xX79kmqumhvpBL0S98apg+Y1W+NhlN8vM3ksCSN8jrUcYKXaL
         VkARuSC4JaFebj99Dybun9YWaaIwqQmDn5QvXzz/VDZDkJq1nSrBEjgQWJJN3q+aYM+U
         auoEjGuOPY+emERehSbF+EqDH0HIkxallg04FJVJbm0T02/zfwH3YdvgUGn1kMxO4yXF
         6vaC2v5OYJZaxwYDR2WywKveEeoo36uq2gVwf8K9f9jE6s6eYwplqs+dbQFQFQMi/na2
         IKC5c6h0DCWhA6E7Twq1PDqwamEFnQ4F1lSpTRrfL3cnZZi+WscwuypEMqpwHAke+JPx
         kOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781886; x=1785386686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ogOnkizJDQbuq0BIHPpDBbizrKgtonMZlEbEehGvr4=;
        b=qVhEzkk3MM3kAGS84d3hBE/BkoigEfQlYCQvVM2VZb8Y/bhH9htRvqCc246plNMmCb
         abvTXyjD5O/vEqtrzl3OyEv1UW2n2dMUyh1LgPrVLWF5oUXekp0iww6UHpR789gG7y82
         nCUzbr86aXY08K+fKp0/t8Tqya0toRM9SCqGY1gjWhVwnoq+RVGApGPwij/tAJjIAz5b
         ju63yoif4YhdRkwwNUw0wYP+HShwul2vrz7X9P4cO5iHvF8ao7xjve18yoBTc52Z/MQk
         99mvyKKbQ+NjBnqp2HCLRcG6HAFv1wqROtsB7KcpRxMLRbDoA6anCGyg4DUZgBVJ2R73
         8yQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpR8/5Ia+gAIkLzJ6HCMqf0H0Cn6ar8aSHO5Pc//nraZ1gPEA3LtbgGzXk4QYEWylXb1QWjjiSgcRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPFP13CmsV39ci/BbSzVz6uC32esFb3J25HTJf1GfTygqQvwa
	9qfePfYoZBGmitHCjk0JGlHS2mhzMHNggl6D2ijE0Y8F5Mw1Ssqle6g3vR9lkAHfCWdBxOmbo1j
	CE5wo+HAa9oIrLzcHR9xsG0tXbKJ3CdlKMNjGYdkLmh3wUsvWNXgi9S05fUs5wMM=
X-Gm-Gg: AR+sD13FAt+fnMfThw7BA5lWQKyBJgC1VVBT5sLYm7xar25fE5cK44++5W0OB6b2B8x
	ApJu9xQmlcqX+56t8cQkklQFvTQa+MeEtlUkfIWG44HatCMGl+34WWkKglqTEK3wBqA8Q2Z6ItI
	bFhemGQezDSwIcMPQL+gHsWWURw0tsji2XTKAIHzoy7d1MWZbU7T+SEY1W3fEJkQi5b9muy5I94
	rimxSwRYaFQds8sLnibr7k5BW8fEeLRkH8AluIaAkaFmB8d2RMOTi2gg7lQFK/C7+VTYgFzUaR/
	/2Z3tGD6mD5pV5NNR6aQoRDCpi8Wi2JXg4zRE40T0X/f32nUhoQFqM35x4g8iy3zEC3+PkD5vSP
	2zzy8QchA5h0jPtoK/MEsF2X7B9qWzdg=
X-Received: by 2002:a05:6a00:3d12:b0:848:4080:afe8 with SMTP id d2e1a72fcca58-84e2b8c0dd8mr1961069b3a.22.1784781886123;
        Wed, 22 Jul 2026 21:44:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d12:b0:848:4080:afe8 with SMTP id d2e1a72fcca58-84e2b8c0dd8mr1961044b3a.22.1784781885645;
        Wed, 22 Jul 2026 21:44:45 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175aad1asm2327922b3a.44.2026.07.22.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:44:45 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:13:59 +0530
Subject: [PATCH v6 5/6] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera:
 Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-shikra-camss-review-v6-5-7c46f9bbb4db@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784781838; l=3728;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=ZA3HAjflV0tkYLC6Nd8u+XrixaMrLTLfnMhVUY6WrUk=;
 b=fsDQyLQdGt0+M0g6Jbs9vEsnskbJSfkprD71lfYYse3dZ+f+VAClv/FZ3qv3yVTRSJFOvqcBX
 PPOVvCxk+vRCwutJYlt3CvKpqCcDkSqCdPGCqKUdxYLx1QQR5DUO2Nn
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfX7Poj5aVdz2Sc
 qa1NvJZGLdLASfNGsMloM8T/nR04dEYUmsxxFk7qESDJWgFR0ryT+QnzDEOYW80kQROM3jWOR3h
 wnbfP1Mdy5w/dug9t0hDanoTZ9RM5f0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfXy+NcdaTtxWLT
 udM0Jt+N9X6DTHCLICPK8QEe8cBpuk3VBpZy4IyS6iVUTfrIaxH7lwarqj1DHugSeD400GMAef3
 z3K0SumMnK3LDJ2j4Zk1axD+x9PT0h/lII4sWv1jkQTHmG5LYgIKT90HOFIeVhkybVpYX9zJpiV
 gxV6xuZ2r6hfaRSMQvLcTpunUw17GUwlLMIiHw54zu6HYykjAoP2A9mvYwIX+XuKZnFS4iga5N0
 sTmqT7nwAdefA3M8YTPLz09XsmkndfRnD5OzW08gE8m7AneNbV0+pX4WjOsYE86OXDwlEkIvEws
 PO48/rE1Qn0Q0rL5xQ1DShPErJYOYqvnzT6hWjmWJLPMGzqMsf9kWbepiAfaEULecz3HK5AsFxt
 lErnZC52KZ6RJy+JO9suu2lG2iRkS6q523jGRnKChwLKnv2fRTtPvJI+WEhcszRu8P2MCOOG7VU
 wcOuNKZ7hHQo3D90njg==
X-Proofpoint-ORIG-GUID: 4fiF9SuPGO64wKxyYIMH88VKQfJsF0tC
X-Proofpoint-GUID: 4fiF9SuPGO64wKxyYIMH88VKQfJsF0tC
X-Authority-Analysis: v=2.4 cv=D4V37PRj c=1 sm=1 tr=0 ts=6a619c3f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
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

Shikra CQM and CQS are retail variants sharing the same PM4125 PMIC
and identical camera supply rails. The only difference between them
is the integrated modem on CQM, which does not affect camera hardware.

Add a shared overlay for optional IMX577 integration via CSIPHY1,
used by both CQM and CQS EVK boards.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  6 ++
 .../dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso | 79 ++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e05414290d8e5692accc758bbbe472f2f959a0ce..c75e0ae736a96b047c04305bb109cacf06d06f07 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -338,6 +338,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
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
index 0000000000000000000000000000000000000000..3a481d972cd27a2a324d96d8f47c161e11ea54f3
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-cqs-evk-imx577-camera.dtso
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

