Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46C47126B
	for <linux-i2c@vger.kernel.org>; Thu,  6 Aug 2026 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016654; cv=none; b=DjzlvUay7dgHW9z3kfIU6XPE1suCEylzGNSOE09KLgPTRAaNDsisZjCKYIz4rVHgr4CxzaNa5bn2VNpJzx3kp0Bo3vlCTScbjWptXsZxi0qdpLmRRtY+bEJaaZEzSpF+nne8H0Gt72wk8ge6lUhs1ZbNwPjthtYNz/QhhNrqcFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016654; c=relaxed/simple;
	bh=flYHAsWqMe1Nmyeu2IpHX/mwqnQXdwl3hGTsXJ2UJ48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQbDPHa1c5a7Wm6vC7H7Y0yebkL7H/od0GVL1Gwu7aFGEUEVONVJLSTHt/1YvMbGNDW3tvvrREHhaxGvE6wA67N58fbfwUca3t+whjFgbAgD1IscUplZ8vzmKnrWTadTRKx/gCZseJxnqKCu06M+qm3BzSA/B3EJLJz7K4VVcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gU1zl93T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JCRUKGYW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gU1zl93T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCRUKGYW"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769neCm1277835
	for <linux-i2c@vger.kernel.org>; Thu, 6 Aug 2026 11:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d0AxWTtHAl5qkJ2pTsdEn68dPe4XsoapBpxQmFo5neA=; b=gU1zl93T5jCPbr4l
	WWDj6gLTvCdJ1/v3Kg4SoiYFe1kkyr2Uw9VdsrcLyFn1L0TjhuN7Ct+bgBTeAHjZ
	Oo49azSly12MgP+aCDlGxbvPUagbj/ilFPcq6+cKPkwLeUP2vLT6vWWv/sf4gmA3
	n05h17rfRKGTDJzyj6utN++DbL15bUT/gklwxPzubmvjsOYRsdeuuZbfXxfSDlIw
	BLKbfiA22ABZOp3I6Ci7k7ty7j/SKqlLegiyDi+4q8NOX6/ncBGQXdQBfz3EqRIJ
	kRYccDBvl047G6ukb53H+U/fSYhRpSr+mzBwanqvAR6aBVVMCWo6f0pnQ7Qi80we
	enCZuw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuehx3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 11:44:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84eccf9d899so2898174b3a.2
        for <linux-i2c@vger.kernel.org>; Thu, 06 Aug 2026 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786016651; x=1786621451; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d0AxWTtHAl5qkJ2pTsdEn68dPe4XsoapBpxQmFo5neA=;
        b=JCRUKGYWtWQGm8NuStg7uhqctboeGjzdo9/JQlOT8bAWltQTwVki6RM3tJ/uoYPncE
         LlnJ3o7cJbhudjnY6J6NrtBLdGXlzu7cxyG5GPoAqI8lnejmMijP2yBwCCVZYYJxy4KF
         GqSX2jqmwifRMJtXJRVuK7r/jHH95QEocnqHTukTVLf1mi2VwJQm4DB/tIe4SdCV8Tg2
         jTIkZng+gvGkc3hTznSwGfV92qBW/CxjxvHLIIXpkjZW6u4VEDHcqEKb2JZQVXxo6pHZ
         EXZZsYn14gZb9FnuszQSgvVGBybZSf5c7cjcigQ9Hn/VH9r3rsfJ7jlkSHMdqtKczOvx
         pMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786016651; x=1786621451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d0AxWTtHAl5qkJ2pTsdEn68dPe4XsoapBpxQmFo5neA=;
        b=IPNbpvKa8sSO8KBWBYsgpXDQJlLJ/Pgs/6+vRYGDb5eLVhfLYR+9tGgtQj3MZlMOvM
         Ys/WU63xpb0OGEh6XDsLLkcnbNiO8ZMqIui2cpkKgcdRahL6O/fUfhe9R4yDf0MZL8vZ
         jm+cDQ5E5zx01OyGCvWoUcR2bU9SLkHzSrrEOyYDgI7jAH4hRBJETZsH6aw+5EqBmzSh
         ehxXpOt2w4i7syC/mtk59PTxdKpEhJ5Dd7xxkAstw8FEzYYDBTJ4xoK0e2AJRLT9Hfox
         1Q4nYd4qQ49aR1Rv+P0vVsJAM+g9Ns/meepK9SWk652ZldztBUXJ5rFe0wD11Y6xSyk/
         thZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rryfpi0zwNeOBI7zAIiKSST6JO+n00a9zsHpe5JDzqIg9p+2Yl/eic3u8Ah5pIXiNUuTdH1uRsy7hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyniX9fyUu+GfG9gq/szcw6FClqp4GLU8LuYBZ59zOPP+rwQAZH
	Jysjy5UY5cWDH/2XkeG3Ew0BlYInCHsWdtZpOv6DlqYurQEzFwfXJZyyL8WJZ3vIyQiH4jvc5N3
	yW4JmESsLaJZaGK+iGbj3jqiPYjWGf9Nwnvc077sVgxSFFyETWAuI5bmJ6naSZGk=
X-Gm-Gg: AR+sD11iLrRHXB3HBXlXScWhbWAeWhwEq+S2DGM33Tl2H9sPxerTBbLRTXzDOlrc9lS
	71ChkT4HbyoVMwV+IprWD5BJE6UWOEt02KNTwdoj13r1lsO+CsP+yeOYlxnEZyoQNQbQ6ZD1Q7i
	cnjQCuo3QDit5KcR4zEiIeHcTrT8TzrJvc9p0ksb4cXpQ2jdT1JPfW7R8doJkD+s4zZuo7yuT5O
	0P0PTtvpFXf4i0AKn2cs8k2PArVxudKFaHoj9F6APhXeHYqfzeq/Gf/iywPPLaMmr3k/sFtCSVd
	F0g2XbrLztIWcKvJlRBwl19mAHzKXrHUK0N7VoQEOtwfwnJRwZ9b3gAEdIth05GKketlmWGl2sG
	ga+hrRvN2SQwW07SnVJk4w/HnDQJ9Kb4=
X-Received: by 2002:a05:6a00:278b:b0:848:7b92:8e74 with SMTP id d2e1a72fcca58-84f2e0dc994mr17478210b3a.39.1786016651271;
        Thu, 06 Aug 2026 04:44:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:278b:b0:848:7b92:8e74 with SMTP id d2e1a72fcca58-84f2e0dc994mr17478151b3a.39.1786016650815;
        Thu, 06 Aug 2026 04:44:10 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f456b75dcsm1234756b3a.34.2026.08.06.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:44:10 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 17:13:29 +0530
Subject: [PATCH v7 4/5] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera:
 Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-shikra-camss-review-v7-4-c7360fd6a5ac@oss.qualcomm.com>
References: <20260806-shikra-camss-review-v7-0-c7360fd6a5ac@oss.qualcomm.com>
In-Reply-To: <20260806-shikra-camss-review-v7-0-c7360fd6a5ac@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786016613; l=3728;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=flYHAsWqMe1Nmyeu2IpHX/mwqnQXdwl3hGTsXJ2UJ48=;
 b=+NRK1V2w+DTmTUaqLRTPFAq3rJUHzPs3aeOzAqPyrR6crfUEjHKjnWNHtpZDXgE59xenOHx7W
 pkS6MLmq8lxCjt43CH3uX1Fyd1Z/uKB4H6voc8q1+28zPel/UfHnlq9
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a74738b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SnuPAt3MQpO7ggJjswry_ZGAAJnFrFRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MiBTYWx0ZWRfXyrh+MFwbTRpv
 eYfTJBXSAmCyq5Bueog2SMWZbw2VJ2bbm3hyjA6RhlSOWzjNhFUBsBJfFCKxpY2hRAv6MNeSopn
 8z7yTLwvJGLhiM2I7k0jPFRjsUsSSGbSR3yHaUZSlADVt51mI/TxOGD8eLO7TZDit+vBpjrYvQg
 rnnfoqUys6Pz7n6hR1e61nunFl3pvvFO4NyiDHrMTFNOeBSXPWZ/UE+pr/TqfFoxXx+1fV6QxqG
 YuPUGoHwLGwHjVJYlydECDLVD0CJ/CaN4BD0pKewKyqFqZh2gkgT6lnMeouvTmE/u0fiUr6fbD3
 JWtB33CkstJLNShsB2qF/gLCp6X80mG1tOeLo0hotTlRQhm+DfeYjKsAl2q2t8XvRrmiENULtJn
 dqHxP3kQSs401FGkN8vOwpSpKTwxsLL9yUJSu2sTpCbRiXFlJNYPdVBUeaO21KmUjfAN0lae2tT
 OVNpvFJyU2ky8akgBaA==
X-Proofpoint-ORIG-GUID: SnuPAt3MQpO7ggJjswry_ZGAAJnFrFRY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MiBTYWx0ZWRfX6OV+eE4Don2H
 VQNLktiDHY0OemkVeS7gAi0R6H/o30iC9Ec6frTwXZEuDPVtn/3uKAK7Zv5+I8xfiJLvcusEzt8
 OfVKPL6u63/4GWIQVEUjq61zWvP9+1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060092

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
index 1c86e7e98f55d539f5292816ce06c9a46bd4904c..03ed24afad5795b49848a2548c0facdc9f3e7115 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -339,6 +339,12 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdx75-idp.dtb
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

