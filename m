Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A43CFF44
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927669; cv=none; b=FQWSTLBAmHzNDftfjA+HPKOs7twcqGfahtx6XAoP2L6LwDLXLDJk0PoeQSeAlOTXnpwxmBr389iVnhqF87Lg4iXS2PQYGr+UpPrLxhC1ghb1qea04V9DvLuOEUMJyMyNwajWBxl5WyYfBkn/z7PTLpHvwjTnwx/ugWPbOVo5DFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927669; c=relaxed/simple;
	bh=A0s5+Il8ZVmbH5Bso5yDr6ndaAOTDuKArql6IBzS6b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pB96ZMah5TPZmzOQZkJawBHdHtSFbZUspC+H4zMfWI2StFrh0FA9NFjGXQCQwESxLbjHdWDst9NISmDgTZ9GLuUdXc0uYQ1JQJTIieBBBlH+U/tYMBNkNAeZH6F0ew4e/5Ro4PctHOohs01SII+1aIn9lO24i0m/z11BZBZR7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lDKnJ3kS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YdsQCAwc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDKnJ3kS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YdsQCAwc"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRBXI3336230
	for <linux-i2c@vger.kernel.org>; Mon, 8 Jun 2026 14:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uowIbmQnqqTqEZNIE5zF312ZxkTUFs3Y6T+ij+Tr/3U=; b=lDKnJ3kSgJhbfbqt
	MNVlv7Ls73L2WU+K2WCuwEOle4vBhZgNxJsquGcD3Djl8ylUxfqZdz+JZDz7c+BF
	DPljUoRAVIhn/ZYwRiCcHA6wZgVr9tiGOp0kwtGXYiIIHiWbGKmDAK8/CwYKL28O
	McN1llrjJbxIthWUjBTpBva5foQ4LuqSzh8QH6bQYCpRUpvqAhDOR6l8hChr14vS
	4y9jl9kWgg8Cc/OcksYDe6vXCWgQ9HovNzmOMc+niAEIQO4HZVnHLW0B9UkbJfuj
	hH5d/wdMrBoDqRpXCmHmpPbB+T4+26oxQf3aceeNCGkUrcuaOot/haLykNMNZ+R5
	gH5xcg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun411gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 14:07:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf0b7425bbso87287545ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927667; x=1781532467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uowIbmQnqqTqEZNIE5zF312ZxkTUFs3Y6T+ij+Tr/3U=;
        b=YdsQCAwcyDFNiyM2bUR80oOqGDB15MlBKzA0wzr6T0nFeo60zzK7btdO3hsn39BbPU
         MzPr1U58QkH6zSo36TiLzL7byJTjAkuHspZWF8bJIU/Npm3dP9WPmtP1gB0MJ6rJjKvw
         VLCrV52cnsPOys/A3mI46XvMViRVExvlYj9gipTi0l122aSGOTFSmXakbUxL5b6CEAVa
         Lliat7YTMP3s2TIR3gc1Gr6Mqj3a+bThCL0i9C6D8yyqFXH5ymJleHpJtcrqyzoCKIHC
         NGBzApOlQE9WWRJynlmymZNpZiGmxXzpmi7QnH7ufVW6kWOde/KDTeLQu3UUxDovGu6j
         N1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927667; x=1781532467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uowIbmQnqqTqEZNIE5zF312ZxkTUFs3Y6T+ij+Tr/3U=;
        b=PRET6/kAqLe2mTbhbD+GoMtuIgm2ANSF4q7tAg6ea+9L8BvFMPwZJ3CmK2wB+gp8Pc
         tKO149Os0ZAgNwC63Vw/jaSB1urNWgIaxD7BP23hKUjRSaJxWOQVQKIv7zt9i0II/Ibe
         Kpmc7c1e4ehMGKd8WI5YXiNqc+3Y08HU/O9ruXZNvhBJaEwn2l9opNAOKDacZR0boNqa
         0x0F+52nzZR+XFTnvcqHTpgx3yQk0Tbhuam17TyoKaan2mLeerlEktiZr/qkq1un5aIN
         y/k36hfR0pd+JX6whzHFJYXrI++DMBtdZ32aLltelY6hPm6Z9v0UXw1nB84iqN1QtE+f
         rwqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VtT1vIGguoRCRFnXMkJb5zt1OTM/EUGCxSoHn3gcKyeavwPZvuxLUE6LvoFIY6N8ZTyXC/ySpzbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5A4mYZKyCFG6bIjXfPxof7y1mfRqWKLCsf/6ZCokoXD0/uvp
	mEvb8BgAhewxufPq75XeMtn+FzfovTb34Jg2mPWf1RIm9zYEbRKVUoPv/aH+8Y45LQQYzJ9CZ31
	ue9q0aHo4E0TonMlFch64OSH81H2Z6Qbca8uSCwMi/at2osGlACr9tD7oNaOF1bs=
X-Gm-Gg: Acq92OFf+iHqrQ0QxmneztIapLwSdU9npEaWhZt1cJQ47xhAyMNP1R7XPG2EgmJ/4Yl
	wubZaMnAepXnrBn+2OcvoqF1CjdVoyVEC1GLhRxrDBRnohQojuWlaJTl9SAhmNdfGGB708zS3/n
	7sUjc6HYuVDOkhxGlV/hH7Pe5bXtMrBCUPITpfeUtQpMYoN/qV0MQhiidOTUabqhaCSQuDkUEjB
	0M81/oW+h8vT+ZwdBuDXcNDlKjM+C1IDHMn+feZi4Fwx5gB1XHI0hlWbEOvubpHLVvEk/2k5m0/
	08Zszf8b4FH/TSmAr0eP1y/+D+gI/Bam28YLgxyzUb4p+1qYVNy4R8Jkyj1cRiSfJcQTSgX6SsD
	uG7YC9OZOv8TEjx2sNcdE8N9H+lXf9omZzgpPgogKgps/FYlqIjI963ND+f7emq8=
X-Received: by 2002:a17:902:fc46:b0:2c0:cbd8:5ff9 with SMTP id d9443c01a7336-2c1e8209a20mr170708335ad.21.1780927666828;
        Mon, 08 Jun 2026 07:07:46 -0700 (PDT)
X-Received: by 2002:a17:902:fc46:b0:2c0:cbd8:5ff9 with SMTP id d9443c01a7336-2c1e8209a20mr170708035ad.21.1780927666352;
        Mon, 08 Jun 2026 07:07:46 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1646e5c51sm183935955ad.0.2026.06.08.07.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:07:46 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 19:36:44 +0530
Subject: [PATCH v2 7/7] arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add
 DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-camss-review-v2-7-ca1936bf1219@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780927607; l=3961;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=A0s5+Il8ZVmbH5Bso5yDr6ndaAOTDuKArql6IBzS6b0=;
 b=PCkywFV7Ad1LRXpneXA8MnC0iB+aPRyZ0mGEDWhbytABVjXWkm9rSmmQUKCE2QhjynCeF8zXu
 OKdXzoaI0E7Am0/2XMN1Hv+zsuifI5Kn6HZcFpG2wL1M7leJZQ5MguD
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMyBTYWx0ZWRfX072Ulx/PhPQ7
 14IjIzzjnj7rocOJ3mSw7LyxQi1yw6+cCQg6KkcDlQy+CwAijn71Bwc9+5VOg8Jr9pG91B2j8XZ
 gmeVBBA2wG06/OrRPTXLOQ9lea/G8jRx+AcWmwRujRQHHlugdH9uDHJ1R+65ehu754mX9Org7S4
 uUtQmByncD6826MCplQO+qveKOCcrDBWz4yj01WAIXWIVW2nWs4ixCHW+erQy20Vba7lsjLqPMI
 K51M7wG6ofBDKY15yVUU/A0uoET1F7Ss9R5QFfOrXf5IOBOc+0ZCd6xsNny8vHKzHLAf2Q6qc7B
 9369YO0zfPg51u3CvbLh60Yfcmu/J51iJcf4dSMTMA0DZFLor6CylxqBOPS/iEK0Jo/RNs0w2ps
 rj+dJDxFS3lr3c/swPGN2xjIh6Sgpx0OM6rvyKPVGEox2ja7MPiZc0B0Ko1JykWepRLad1oligY
 6tL0YrE1Up0qZCmI8WA==
X-Proofpoint-ORIG-GUID: qUPoS7uoBzgGeD863ayLVmXDinbikidh
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26ccb3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: qUPoS7uoBzgGeD863ayLVmXDinbikidh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080133

Shikra IQS is an industrial-grade variant using PM8150 PMIC, requiring
different CSIPHY and sensor supply rails compared to the retail boards
(CQM and CQS) which use PM4125.

Add a dedicated overlay for optional IMX577 integration via CSIPHY1.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  2 +
 .../dts/qcom/shikra-iqs-evk-imx577-camera.dtso     | 70 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts        |  9 +++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 76b8f144983827f4905a72935e8d5291a227dc97..09f2318d1c12c4239a6a7bac4ecbca38eb65ffa2 100644
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
index 0000000000000000000000000000000000000000..340d6303adc6e1bea55f1bd0598175f0cb269737
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk-imx577-camera.dtso
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
+				data-lanes = <0 1 2 3>;
+				remote-endpoint = <&csiphy1_ep>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd7594206f0ac54957e0af509fa365f54..811fd5da4af7babd412d70fee84434849846dc2f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
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

