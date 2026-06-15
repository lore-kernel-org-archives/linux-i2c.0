Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CB3CCFDE
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512494; cv=none; b=JQhSDi3H29FRZdLQrDfKXdMDjjuL7SybGP6ocOmuAu8EHrV9/cW+EngsVce10ibBU1+zktyVveGYs4cAhQcUkpp6xowKE1Nd7ZWMF2eyHnc5QL06HhHJ+4fgLOYht9k8Hn8AewQLJf9SJN2O7GJySH547Qny//MadKvas+hx0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512494; c=relaxed/simple;
	bh=X503i/Mth0eTflp/hBfEJ8uVr06pRZPumlIjapac8+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKjRFCJZ1VB1OuLBPKRhs9+LI7HgH5+bE4Buafuu2B2VsN/Hz1BgA74sEjaLD/oVoR8z8aPVKzNbnGVtRjQwhtyV0yd8CwBgNmQF1nbNUDxXUZ9eaJLIsuLpdj1T7sqwhrXZ+FM/oEgMskGCou84l2B3pCMW0E0ge0EvWsTkVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eFT1Hah9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HSt83ZGF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eFT1Hah9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HSt83ZGF"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6IuVE3332556
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ogg4+x3ABUq0tZ1UsQhDlNpMjMUYFLtgDBX0fb8zT00=; b=eFT1Hah9jS0fxap1
	ii3Npy85ddvflo+0FlYx9VL+jciwm3Ipl8rmTG6lxVtZuJ5c4SHpDQBGLIZPGZKe
	NzYyzuxdTZFMWF5dqaU9u+/IjAyfh3OCwtkr/Dy4/RO7KTTe9qsiq/ekjtQkBPoI
	te+Qbs7cwjQFhxzAabgVzK6LSwEGXaHVDjd9y3hXxMnG+tm9uR9NjvaB45nH+Pdu
	JFn5dgO99t6zilMJpriwTYInaMmMIyUX+h1Nq/rrAqJbPmm/ZszUoRwM75ax6Dzn
	G8IYFhp+kUMw/Ul/2mvtv7Zo2G1/psThhLc8YJGvHiq/YkITXXdMOXmLKnumnodA
	AdEueg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye16g7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 08:34:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0c272e532so33227445ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781512485; x=1782117285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogg4+x3ABUq0tZ1UsQhDlNpMjMUYFLtgDBX0fb8zT00=;
        b=HSt83ZGF6MZSLGL/9lybb0QrJcDsxkkVNE9s2WXuuEHgoFVpizkswmCFBt75baIC38
         e0a7zZvl5B3y0XojsRF2h8CDW2Vmn0pvNcUkPkyeDRBt5WjzlA5egHB+9r1l0H4K4SyA
         VVxk3BJ/DnBL9/ErbtS86fv08hss9Qs/m1cG4cz3CEeRod2p4bwi3cs31LTDbng4HjmJ
         6qBQ/kvnM7bpBm9s96JJBdzg/kO0T/SjBX71j9LtnOvJHiFP96MK08m1BgWgpf/zB3j4
         6rT9dsJCONiJ8rJa2MMLRZKKOODbxs5FtytfhnHwz4sZhXSH0lX3ztDYw0Ehl8DLkYrk
         kFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512485; x=1782117285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogg4+x3ABUq0tZ1UsQhDlNpMjMUYFLtgDBX0fb8zT00=;
        b=O3V2b6Q1BWM/T5E9RzZbAOyIIb8jBtKzNCeGbPm2G6CCXc2p5YjkeD4SK6ed6geta5
         C0TkJktqWFoL85x/X0OrWT85AR9UPLFWN+td8a3HfBXu4kHxQWMGssuuGKvCHkjPQtOE
         Jty5eD9d0SOyqGZtNzCzbF/vTy3RW12MWALkXTY0eYkylL2hEFzwg9sxVEdqhAsKk66H
         /rieXWLLdHiVLJzvlst7vczsrQ5mUgPGyhOrc1BigH0mppRwyohEz5aA8cVMpHgs+HCI
         Yfn8igSQqqszS370SrjMQwJYdWL/239LUKhB2+3++RrahFKSpJNy7IwrK9stiJtmYWRO
         6cdg==
X-Forwarded-Encrypted: i=1; AFNElJ9aZuDJ8wLI+6FPe6eNoSAbwznUtyIuaEMyM9u2pEeX+mca/kKl4Hj3UBS3a28Gbbq4P0V4AdE3qe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/H1Bn6V1FMrVc5zFIs0fpFUuVoweqcFfiRQAZwpEmoX7O7OpF
	pKgZ6SKIhn6w0AoBUvhlZBiYcH9sHzxJCpb8xCnfX43ofqbSxEo5t8Ql24K47Fmkt+MyA+2OY6Y
	n6OOxxemUNmn93j6vLUld6uL1Uuh9jV5Ar4CDJn9nmH8eTpw6tkmHngzEdCAgUSY=
X-Gm-Gg: Acq92OGVnS0Z7JAgVjcH0F+pCcOjwzxvszjv485A+DU5UhRl0HiaTlFrqCme7RnnR0I
	6G+e29/WgLrEW2bOa6bLV+LsmwskyeWawatBtu4QItqcCQ3I78nDMghrQ6Scc2YksIcA7xhQywq
	gCCRw4YdXdquuWLp/dazjPjf0xkP6Vjc1FH0Uy7MhPnQEBgIUO/3Hl+agYiCEX0ITHM7JrN9vln
	qUTxOirH9JKz4mrDQ8VOa6yadJb0hEAEpTk2y0I5QALzqTCb7KYIK2zEmoG+are8rRYgYoBYGzf
	tZCHHNxgCpGJwTwXnVVZoV+88nOPkyZg3XqJR07HoKX3vmrdFOOKfDeK0JqpT03eSHCOVA9Uh/w
	DClp4dMpFnTC2Z1bLi/2J7XTE1kZNLxtBOs1/y6xlI5sda9KhVrco
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr104881395ad.17.1781512484608;
        Mon, 15 Jun 2026 01:34:44 -0700 (PDT)
X-Received: by 2002:a17:903:1207:b0:2ae:450c:951e with SMTP id d9443c01a7336-2c6641e180cmr104880975ad.17.1781512484003;
        Mon, 15 Jun 2026 01:34:44 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c70easm122789235ad.25.2026.06.15.01.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:34:43 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 14:03:58 +0530
Subject: [PATCH v4 5/6] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera:
 Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v4-5-bcb51081735b@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v4-0-bcb51081735b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781512439; l=3728;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=X503i/Mth0eTflp/hBfEJ8uVr06pRZPumlIjapac8+M=;
 b=HSVeJrzwoJPjIg0lth7jjpJ+yu4+T0MG7EJiH0F6k4OQXUeBwaFIwd8XaW3Cnbau3JrX0ZOPL
 Ht73cPtScrRDrVj0aPkrpIAiYqSkDJ/yT3aq2UJ47aF55jxuO/1Mha3
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: oWzgCseJB6Pz_9E_lPQIxIrUFOcoOnV0
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2fb925 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX0yjneP9/OtSs
 CrqfuBII9W9xZgQZe+Uv2sJBnXTe5P9TBaElGfPmh82HBbamx1B9KFz2vfUz2PF+U/V3yZi+rZi
 jXGDKcFXhHA3Magl1k8+Cm11q5Es7RI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA4OSBTYWx0ZWRfX+d8zBMvJOPx1
 op3FDE62tB8D/0yO3kSHm3Yl3oOTaWOXXULEESejjZOJnIVYgXHRDJovN7eim/zxKU8oeL6F+SH
 oYUrzRRgn9vnaL5e6mcaI0qiTrLdSGpemXrIjrshhnhHMdyLw2xMzPNzJswQTCh4oII75Eax8UD
 zxH0N/sExv2svwI/B/TjZ+WuyTW5yG79FN0Ck7XljnJi/2geEmWkRvlA9zzl1EoGZbHp7I5StBN
 B5YUvunD0SYNRmmf6O8sRERmhK1K0U6QS4duadHcS9I+3PGA7BME+lN1x0Wrtd8mW66oqKGz661
 +1MtG4Q+dASSRKyCRpbWBhmXusfWAds7u/SMkiEbQGArcEj4nxydUdxyuSYAfA3FNAka3wQed8g
 JWo/a/rQW9JsBKaX8G0veGWqVUhWfaXggAK8COtrC+siGWIkVU8888yoB6j6dCIqKcZ7pPefQ1o
 zLQZM9gPHxxIBsSCpIQ==
X-Proofpoint-ORIG-GUID: oWzgCseJB6Pz_9E_lPQIxIrUFOcoOnV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150089

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

