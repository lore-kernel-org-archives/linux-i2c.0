Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED4239E97
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078508; cv=none; b=hlwWfvULn562/bVE5qYiv7OPTMpaq7prxTHaP+Xu1vM9OBPBdyLwm6fv38/EGIWdLqPzxxy9Y70SmOVd7FUG2MJ9oowdnpG1YJBV5nFeX3+IInP8G9fEVwkcgIe4dGfQMK9iXEUn05uWNJMMGAxgBZkHhYewEOqOT8AbgugxjpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078508; c=relaxed/simple;
	bh=t5OG46p4ljnSn6Ugt7/7Wx2T2LZF7712SOUc7lxrUEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cixu0IayVJF/B4e3yJzeRVZPTeMEi42UND7LPTNqk/K2wxjmnLj4iEMFOruEo0LhFW+hYaTjBvw0I1VLZUXa7lJJxO7rGOvb+ouq42tov1vIiw8Vc5RidMunP7xFjJz7TQd5PxukuLI+3i8Pljms9+URT/qaLRNk57XgT0Jxrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0QEvOtz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ok5tPoav; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0QEvOtz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ok5tPoav"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7Ma2D483554
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=; b=m0QEvOtzDYFZji+V
	YmKfUTj2q1Otp1mzrvY1xBBwnc5brRdiH4A35CJ6lRGECohlj+C2tciAkwyWYYk6
	hO6hxZrQMwFO/gVx6S7IPp+nX1vulSSGfU7KLSest8L6svN9gAD2QcvEWBhx4uGA
	6FI1bmpeix+nDNZM/Ijfl0rb5/vM6W9YBb4mgJX2hrk54ZAHKq7c6OE2RWwi5j/d
	fxtpqcmqRDE1QWD5h2jtoezT02vJUJypah/VjXJ9R6/Q7IR+d0EH9k5zlH2uEW1v
	sU+Z7XfpVhuBaa02pSGpu2Qjtun50eBheFJlClPawnrfzzayxDWladmTUfT31BtV
	ysIxZg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu6pj2508-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8947d477a09so20267936d6.2
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078504; x=1769683304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=;
        b=Ok5tPoavwEkfkq2rUrDONh07DYJUf49/7kTxguSVRPw9eZvEvc9+TlcExQSrOxOip4
         3oIdTrCn82NsStSghtMWsgU03h/vMRZcj6BuneD+FxX5jz9fdTSRGy+9xLqplXVJ0Wrt
         +7ol/MNrSAfT8ltF/OQWYv9C+KimLJ3rLpLUgTf0ebbEANTSgbRyBBdzerXNk8N4nctI
         LrBvFGgwW/M4kynXFjAz1ROUe54iLBP75X8Be+xk9yNPmUKTE2GTL1jsEDMH7HuHeM7+
         wVChoh5ExLZo20Gp8M9QHtNv80YrkEUNQV9uXuSZkUZILxGONroUklpq+nVmhhOOhL8z
         z7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078504; x=1769683304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=;
        b=hKDQjujydN5d3Gjalr1uwQTs0VkT9hYclUwkrMe7b1dmptODaFGQ9efjHS6+ZJ6esk
         YTd0Qa3Iojhv4+CxasJfBr/576epQFWYw4P0uyUdh9AG6X+iv1SbTbug0O6je9pHROSE
         Q3SKb5yyKIzEG4cvj6SPje7DaIPmZgkF+/50tLY/NIwT2tYUclj2Ny0FfHxU7lYep/7m
         HcQZJU9eeRekqU23aSCPShdn9Osl1BPwmhTfl5LSTpJlR00SHz1YN2G/XymucaQmOCWN
         D7jz4FTrAG4AgBPD7RHddkxcmWCdgKQFaGQhHs7dtCHRdp4uOIOnH2cHGpXqnm+TzhTX
         wEyQ==
X-Gm-Message-State: AOJu0Yy4h12tJLxJQssF9wLZf+xBKDkoduIVs7adM61S5oYL+Agrz46V
	dqp7OOywoSdINPs9o3HGz7+xDa7tJzJFT6rr9qc2I2fMhfS1JHzfuQWSVf/D9R95em13n3zRvU/
	rYHO//O75KaOdHDyDcjY0JRH8J15XRMHZMHc3PQeJo5pz7OC4WzQHIhJjFMFIQuw=
X-Gm-Gg: AZuq6aKI2VVpApwZU6HGRrJUL/CloPlcxSQAFVlJS0Hoxv4agv6oxu7PS4uY7PivXP5
	woPFtVUKMwQAAe2MAzFmTSDzl9yQ8p+mtROMcVcOWcXAw+Lvk+qBhsQM7C5yA2qj39ArO8fy4Qv
	insU5vgD+mgNOHBLOMRWmuXyLajgJp4/+ttHV+XRAe9RuVqdiqOG9zE5110wQNIrei1YmST/+Yo
	FBQP7MyqU8zaCDgPJKHyvJzTVerEILSbdwqmR5XLvMbbEtXksiicTax/bAFVBDzWuKSn3TwLREe
	iFlmRokbsSVJ/FKIATsFOB3mAnkDPdFsfi9BaOTOcFebHgh8AsYigARUGPQdHKLBJqkByEqTfAh
	eZpxSjTdHYkj5mi/Ndwj0BXuEtGrTySFuueRMheh4B2XzETGd2FEXZqY+2BYJMWY2phTWddxRFc
	7l
X-Received: by 2002:a05:620a:3910:b0:8c5:38f2:810e with SMTP id af79cd13be357-8c6a67a411emr2605788085a.82.1769078503728;
        Thu, 22 Jan 2026 02:41:43 -0800 (PST)
X-Received: by 2002:a05:620a:3910:b0:8c5:38f2:810e with SMTP id af79cd13be357-8c6a67a411emr2605785685a.82.1769078503284;
        Thu, 22 Jan 2026 02:41:43 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7260229sm1387868685a.42.2026.01.22.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:41:42 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:40:50 +0800
Subject: [PATCH v4 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v4-5-a908d49892e7@oss.qualcomm.com>
References: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
In-Reply-To: <20260122-sm6150_evk-v4-0-a908d49892e7@oss.qualcomm.com>
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
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078453; l=3019;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=t5OG46p4ljnSn6Ugt7/7Wx2T2LZF7712SOUc7lxrUEc=;
 b=n986DyQp3CsKwqwcFIuFzEWA3NaquONuV/voJTXw9fQ2RNi8BCnuw6M5vTv6vfYrct4IBiw01
 XcK3Aznm7QFBudn4AHwfEtODiasgAacyDuP/OgV5lAl0gYRNYY+fCyR
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=D8pK6/Rj c=1 sm=1 tr=0 ts=6971fee8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5RPoKDYpsqj7oBEIzsA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NiBTYWx0ZWRfX9qiGjNfv128X
 ZFjsr6H9yYitYB0768Pr06kT2eEXKMMHAAeFdFGemyOfaizL58IwQegyuQAOM7vKLZ1JX3WQwbd
 AKWjtXJYM+Aw3XUEqOtw5UFcRb+M3fee07nANvVidqfxZ/4nCs27f+bPkB4lYv7aWhjkKwF0JH9
 d0yfNAdzBr9lK6c8CzT4ChLpR2U3l6h51Ig4fiUvK4CfFKx5WVhbl8bT0Pmo3omkq0grB58qnpT
 fkvfH0uCp/oHce7fQa7Z2Wl3DwiBZ5VAmJ5dXRf+HxMcWXDXPkWUhARUltiFlldHwX6Cf4b77b1
 YBbG9IKx0IaBcv7dx5P/8uRVwU7Gnp3sdoTfQMSnQ3wvM8Uu/aQxgKIwqMA0zu6meGJtUpAviS5
 37mr5pKVPDBjCWCBOfLPiaRcs1ZW8HNMc/yBDw9XZ3HAqdBYF2zXnLAO4gn44d/C/RQDyTa04Ap
 YfFQiseOK2dBBfUz+eQ==
X-Proofpoint-ORIG-GUID: cIRA4aTS5EBXuLnONjBKYatmkPngTInS
X-Proofpoint-GUID: cIRA4aTS5EBXuLnONjBKYatmkPngTInS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220076

Enable IMX577 via CCI on Taloss EVK Core Kit.

The Talos EVK board does not include a camera sensor
by default, this DTSO has enabled the Arducam 12.3MP
IMX577 Mini Camera Module on the CSI-1 interface.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |  3 ++
 .../boot/dts/qcom/talos-evk-camera-imx577.dtso     | 63 ++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a2e48b58323c10735c8b98996cee6669e4f918e7..b505b5b1aa2feaaae691977b35a2d872751c4a46 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -349,8 +349,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8750-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-camera-imx577.dtbo
+talos-evk-camera-imx577-dtbs	:= talos-evk.dtb talos-evk-camera-imx577.dtbo
 talos-evk-lvds-auo,g133han01-dtbs	:= \
 	talos-evk.dtb talos-evk-lvds-auo,g133han01.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-camera-imx577.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk-lvds-auo,g133han01.dtb
 x1e001de-devkit-el2-dtbs	:= x1e001de-devkit.dtb x1-el2.dtbo
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb x1e001de-devkit-el2.dtb
diff --git a/arch/arm64/boot/dts/qcom/talos-evk-camera-imx577.dtso b/arch/arm64/boot/dts/qcom/talos-evk-camera-imx577.dtso
new file mode 100644
index 0000000000000000000000000000000000000000..53006a861878f9112673b9a0ad954bed7a5fdca5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/talos-evk-camera-imx577.dtso
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/qcom,qcs615-camcc.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&camss {
+	vdd-csiphy-1p2-supply = <&vreg_l11a>;
+	vdd-csiphy-1p8-supply = <&vreg_l12a>;
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
+		reset-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam2_default>;
+		pinctrl-names = "default";
+
+		clocks = <&camcc CAM_CC_MCLK2_CLK>;
+		assigned-clocks = <&camcc CAM_CC_MCLK2_CLK>;
+		assigned-clock-rates = <24000000>;
+
+		avdd-supply = <&vreg_s4a>;
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

-- 
2.34.1

