Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71917B418
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079023; cv=none; b=aTZqzphOQIV48UrKjVYToxaCbwFDcSGcWprL5d/JQjAIKxEVCOFMf4kUMPw4KVJQP24oXY5ImnwqTdD1zYIg8vVuzduGvimQtukvP/YSv4nMmtdqmi0xFtcVKww5V2Iiw89ZrCnY+tXvIUGbqaS6GCsjALdlyl7+goDRJAX8p2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079023; c=relaxed/simple;
	bh=t5OG46p4ljnSn6Ugt7/7Wx2T2LZF7712SOUc7lxrUEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nk4MGvKTn6EZp6yIelY/5azQCLXTeTR+N0egA8rxi8EyNg3tXRPPIhHI8+GXDAIXO2AVk59uq941clvNBXXKDHn665C62xODDYWHOtFsTpXxk1aDQZQM4rp+kH0vbbSo5dx2XVjSm1MVdWGzb/XhZwB/V8NTj5goJMsafoiTsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=evXaYxiB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aPvF/epL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="evXaYxiB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aPvF/epL"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M81uJk2279967
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=; b=evXaYxiBSZQaEWYv
	+VBuSfXwQhkd87y/Bj0AHJ4meuEOTVNM3rFH+6b6vkpPYPLtrpoSCazdObFE9RVm
	IonjcAU5x4ETLTB5Yn9UvT5Xo/h5bfa21u7un59kndyipQpR9CXspqStcZuZAT46
	4lyMnPqj5eav6fTHpuCjJmfdtx2lkIIqA40WwvjweTn6NoLF2Az80URxgSKuZHXT
	vGgWTDza2YHIG7adWsaelUD7iTnHW5e/pJMCXZqiroRNv7ZsAAc/NATZp5PbHF0L
	Kht9wN38j6taR7a5lTHZZoB3LDAenpIIA4YG48TuvmtrnL7baItNL6IpoVj88zxb
	IOKEFQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu7fat0u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:50:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50142190becso28860271cf.3
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769079017; x=1769683817; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=;
        b=aPvF/epLl2QTxpktOIQRiV+mzIz5XGN6alZ3dsnrWy+O8w0nE2in6mNWGmYl6EsxSt
         9+waM+V9+PjPFTiLiVwdegrLjBeEmNwGDLnPcurJqWCVmFKnDA0sOvXizsBljGr5KJSj
         lA+FaGk72qMocFFJTFbjkJIbhtY9yI1z8zLiSV41oDQIlwp+ZQKen4lN3KAb+4fohIEA
         ffoxO9/IOLZo2QMsBg8b+IMp/TzmLWD5bNSXnca+Px0Y0vjvQ8Pa98RU3Cj5JTxc4RBe
         J6+C7uV+9dS5TzHSBhLA/gYde+lts5hflzqS3nfOE/ujeuC9ANTsKNrFrsExdm6bWZ/6
         5uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769079017; x=1769683817;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hgRWl7dvcHPI/iM3lLLq/fDWsyOLgllUFc6gqOMV6G8=;
        b=cHtq+wVnRVvIJp0WKc2KeVK3ZwfIRIdLSasoknpS8dQDclEWI3EfaxJKiG1WqCqt3B
         rCz4HR39yIh8j6IC21qjB6bkiS/BYYuOy3FHoXV1bww7fm2xgxNdyFTT1rB94492we9a
         3i/XxNNsy8+Mb095gi974tDYk3yqwrvSD8a3hqQFxzkc2k452+5S4iTEoM79lbpas6q2
         hlT7vgeYBR+tKdNE9XkUnDRFTcupKndfetsSjjYFAjVMINLAWWQQ93GDOYGKDth8t9Iq
         tJigKtMWySvQmHQqve4aULAvn5RKGKU7WA+aNSekx61c4B5j8UXluqLBY+7ehA+0nT+T
         x1Sw==
X-Gm-Message-State: AOJu0YwL8hMYS349nFghSteNbCQzP1+O60gZ5jm/q3U87kMu5Xz8jpYT
	XV55WRRwMKgboegCdq/CFPSxnnQKa89dUIr0KAYGrT+AaJqWAQ/JFyQPqGwgUt8lUO/RviJSvx+
	wgKg4+WEJ5D8PmgFFUycrxSiK3BQabFUTzOlHbz8HWdmz5xWlC+ynODaL7LpW+uk=
X-Gm-Gg: AZuq6aKxGKIxdoPt7bS9uHuo16Ys2x0WvfPnkxFV4EMnY7oINk+Eb53mpRUqKwo8zDx
	55SkwH7WXZ7R+jHXn6mKoadylkOCRSwv18qpNhGCLPBbpHoo2jHGYDjAAC67xpxB9IYhEdzNRO/
	rf07AiWLUTp04lXW1XfBQddOAYqNG/19l1huha+SWfVDJ9KfWMKeQgYQ07xLcvkS9SHss+xTItx
	O7NxLPMhmFcoCYoLrmAtMHCbmXPsTtkdMvNG1FXoSFOfP9m3AyyndD8TU987DKj7g0xZSMbXMto
	aRx1Jl1MSsLsHseoFY+Onr7xL4RxKfmJasW9VJW3LR+075E2xm7nzUixARjXAqndujdvClu5+pF
	hWJkhELwuV1vZeLJ7h3i/yxtQwfPbZfWWlo0bhMH9CJc34F5veo/G9VIwrsHNGzZ6l6DKofZxiL
	BW
X-Received: by 2002:ac8:5fca:0:b0:4e7:2210:295f with SMTP id d75a77b69052e-502d84b0ca5mr104417501cf.13.1769079017242;
        Thu, 22 Jan 2026 02:50:17 -0800 (PST)
X-Received: by 2002:ac8:5fca:0:b0:4e7:2210:295f with SMTP id d75a77b69052e-502d84b0ca5mr104417371cf.13.1769079016824;
        Thu, 22 Jan 2026 02:50:16 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9ee19sm121704901cf.14.2026.01.22.02.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:50:16 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:48:56 +0800
Subject: [PATCH v5 5/5] arm64: dts: qcom: talos-evk-camera: Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v5-5-039b170450a3@oss.qualcomm.com>
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
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078967; l=3019;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=t5OG46p4ljnSn6Ugt7/7Wx2T2LZF7712SOUc7lxrUEc=;
 b=URKlVySI9bGyFKXmi/af25h80gqnu4VJjSXLLRwz6zqMcNzAll63j7bl35RrIxcIpvsSQ5ynL
 ezsaxvknZJCB/yHb/I0v1nG7WDk2WKAFwlUKpi7YznekQBDOvCW2je9
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=Hrx72kTS c=1 sm=1 tr=0 ts=697200ea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5RPoKDYpsqj7oBEIzsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NyBTYWx0ZWRfX6dHp4jyHW7ap
 FpOT2XTzB0M0b35rJh27hzGtVwqwkyfmY6Xie4wc1SSVWL38PooKHuAX8DlFz+Ottt3bSb/LweY
 ATlESL/xrcr6bJzDOluXogS1MIvxPasH3wD1/QyW0JwCIvM/o3REPDpHZoR57qHdNVi0ZzO6qOv
 7k1bo/wRvWJKhedv2WjHluqrQm6WDMJeYHO245zQc8Q/QqpH6YhtWUAsDAJk6JQ/Go6/6gP8nQC
 K0ZBe7d+jwcIVv+SQ06YPJcKI4qulAIZpnXK/aBr/8q1KfOF8rVFQftgAJW99rhJPpfd4IFUT1m
 REiAqtbFtlskTDmyzkUiSeng1iHeZpbZElwZg1J8fQgv8cLxnSPoYU4Gxbo1AcQdaL6cZd/PrSl
 YhJiGGM1jzmRsK9qQbRdIvorvF82+f/bRtiU8++lrNQpKZsndd8GhCVe4Vqt8jarP5t7Tz6rtyH
 F/ZXmqZ5apmm9SNAJ1w==
X-Proofpoint-ORIG-GUID: x4p6xu3jE5K6mTSCtbCua-ob9cdjqqVC
X-Proofpoint-GUID: x4p6xu3jE5K6mTSCtbCua-ob9cdjqqVC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220077

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

