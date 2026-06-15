Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B013BB9F4
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507600; cv=none; b=fyvaVn9Z9kzgAFJR6Src2ZEBoILD2gfbS0lyJguPNpMe6rOgWZszm5jn7WTm23yHUUo9lmkZo5hviPkehtOVZLWGOzMn/UenR5cnxE6VebHtMmwP81NeX1g9EFTXcU3aZZqXwHOL45nhBSKtZwV7tYASb1HEnutIzoELcm8EWlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507600; c=relaxed/simple;
	bh=uTL9b6XbA0RtAXsYmfuH5ui5uiOY/IkXuIsNHvc3KvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eli9FHON/ZFJCFYcKOSZkHICGtBZAu7RICjl/cDGbNvslRQI1N395mP5WQ7JCpKXGMi/zRojnucNuUU58wFmCtZpMzovbTqWAWi+ch1grioOqCLqqzZp2mT3bycuiYpBBKYVmqWh7K9RQ1qLqtMxsRJNcusefUDBkKE6Y3iH2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMKg0+Cc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CNaMflDV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMKg0+Cc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CNaMflDV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J30f3327636
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VMYIMAke9Egc/yVx7PIrN4xAB45Me7NI309julpzCAg=; b=cMKg0+CcGZtEofP6
	Vm2Gj5fuqMQcQAnKlpt0K7N8H4hMgZhCTO1ZqCTEUfzV7ttTak1RgAHxglDOmCrZ
	hQ/9wXVXhVo5SSfFHgJaeLjOn4HQXBNSralSgefPdfYBaokyMahWXBiz+JFJ+LLv
	SD9fQFczZGuVvHJ/VNToWZ6KQCkxTZnsw8Bq2W49t2m6JMW0Oilli5xQsz0A985Y
	vpvY+CVRr+TvGQUXIHfhP5H9YiK1/lCPr7Zd2ptZvhRzJPQy0eMrWMFYJnH943ri
	LI81TcgIzVk0X4J19TU0I9J7UDKsrEKqN+EkW0jJZSm/Ma+GBvSUjWp2f9STudfS
	EgLpYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4es0cgp0ak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:13:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d97955899so2947223a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781507597; x=1782112397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMYIMAke9Egc/yVx7PIrN4xAB45Me7NI309julpzCAg=;
        b=CNaMflDVinu0gZdGplgrxWyQ3SPh88e3guwoj8UrO/1B9rhembpcxdU1rkS00pw0yW
         r0v3ZcBAKKmIZWTIxuAiQqXJbB1rXMFc5/8T8cH36nOT68BvFcS2VslBsWpzuKLFoP1F
         XYTd/TWTV0aV3XDpg0k2UhAOrmS8stTHjeDWwWFQ8KvSEftvL3iBSA3roS4oSRm/wfy1
         6Z7ENzv8c77gTS+pS7UVXfY+e/8vVqPnvkwTi6bivke0ZlavTv3B9FNrOajgtJzCcFtY
         o1lULKNZZoaFhECl/r/ytXI0KJxF5K4K3GIvXs0G8zALfoTvJiE8pI4zixkZOJtjS2iU
         Jj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507597; x=1782112397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMYIMAke9Egc/yVx7PIrN4xAB45Me7NI309julpzCAg=;
        b=hOOXB5xnDsYeDgHBgHqrRIDekdqwIjmRtSEc0mQMBA4lSGYB/jJzcRJzUsleyh08y5
         0Pu3mucS7ODvDKcEKXhn8jOpRDOkhCHNn7PkS4Gkusda3U3RtEuOTy9E9CJf1SAGNErZ
         +TDuT2GB0np9bgpSCsfTPq4ybqa8xIEOFiVRq89dxGcOjcMAWP+jSrOAKUK4rALnErWl
         cFm9SzirJ/c1zK+tKjjjobhMnB0HBlY/IgExZsAcJly5t5FH0uUmbRAMifhIirsvKw1b
         +5fQrhNnBGWDoE99JdWps6SALGGnQ1mZzbBogypqmCqqNGrOWVuATds5XbMAjEae1yGI
         Fi4Q==
X-Forwarded-Encrypted: i=1; AFNElJ91d5y3cPwOFYOO8uMSiiiPTM49aOmsOJoLrXkzE3bWxZDy1AWIkSsCcTKcS4S5i+GVruh23mw3Mzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gdg7vETzZbjYMBm4r/lSeUeAuE0qd/owlUH8otIIM48d/Wc3
	p/YDixXbGZGXNN/swmB+uMhsTJnTGMwJGR4QZxpgWLTlz5lCyCJDqtXdZ4rZH5j7yEub1hHtyGn
	OwggNfVHgvMLIYtnC++W5ExVQADmpWUtYaCcOWcnSry/7ec+l45uIMcG4A84pj7t4bijAkBg=
X-Gm-Gg: Acq92OEFlJaDYyi0YuVmuC9KAQzyIjshOF0h4BLKsu1h88c675pn9qsY8s+RHUlpqBU
	dvtRWDsQOZf8sMAtuU/Pv5cxgpXtOg9+c53h0Af8g9s7GfEahbtkmHtW4M2uVQ8oTe3nsE6gfDM
	KL19FlwC/fiIGu/fwC0gWTIf1y3RsUVZ3WRZdfxHOdwFjsZsNm/nlHewSmY2Sf46ZFQQyKCIMwY
	FXzOi4RchsRDojLYZsNad22iisZJFHk5fHyrxqUvLXfNgCIkYMnHrGFqNRWeBwaRa8O5hjL+mtO
	x5vsipgGCml15iWOKub15U0SXIII2HaFCGbr9niRRr5Jh+aR95E0AA05xIuugxbE+E1rl/ycBSc
	qi1S8Pc+aqW5PrvWKeapjw99pGAdVe9jOa9mO0zNS4gIXJ3fvlXn2
X-Received: by 2002:a17:90b:4d08:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-37a035ed628mr13606884a91.14.1781507596581;
        Mon, 15 Jun 2026 00:13:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4d08:b0:368:b01c:85a0 with SMTP id 98e67ed59e1d1-37a035ed628mr13606824a91.14.1781507596089;
        Mon, 15 Jun 2026 00:13:16 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm14867474a91.16.2026.06.15.00.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:13:15 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:42:16 +0530
Subject: [PATCH v3 5/6] arm64: dts: qcom: shikra-cqm-cqs-evk-imx577-camera:
 Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v3-5-8183481f48d0@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781507551; l=3728;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=uTL9b6XbA0RtAXsYmfuH5ui5uiOY/IkXuIsNHvc3KvM=;
 b=IB1ghu+w4PvpyGH6m0Bdnutb3tvpsG7T2pM4eyAH//Ujm7h8j2hvoG5mLCD9eCaT/meO11WSe
 FQqQreHmmuwCpXhO2fvpzM/r8856xfGl5oUyy3yAlAdzwqvM1GBTdVQ
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: 6Bk8cBJGmXHalWKY69yGAWbfkaCwRc3E
X-Authority-Analysis: v=2.4 cv=NPLlPU6g c=1 sm=1 tr=0 ts=6a2fa60d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 6Bk8cBJGmXHalWKY69yGAWbfkaCwRc3E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3NCBTYWx0ZWRfXyi/pATqEK81t
 aaIomY7lG8fhVEu4bjX3hAOY9uCsMhNLx4QLMkVGr4eOBdZsiRh0xqHckKKKFw98YwL/2gKh1R/
 rBmXFslZp+Fe0FxisjOp6C5TKAgnpIM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3NCBTYWx0ZWRfXxOcYhtwzZDOR
 lUM5hPSI4dj94rPKQ3e+EuBrxjM+XNyr563/IiBQeduRxSJFYG0OwN+rpowTWkgEbeCTMUHHRys
 5V41OoLzjq/3nCQN1H0rYRPv8WjHnBSR7t55MgRnV24y7+glU0JSKFydFrgcZFA+hAr3AnqwdMD
 HiVOpp9ZNgdqFw8xHRkiVUs7X/f7pNDmkt6xFcr78qdc3wMPi5pEdjTCAnofOwHK6eTvsfVwBnN
 uJaTkPEbq+bflBBJgnkvahbCQImR5ecjbbfb75gaNbi0wGBE8US3Lyi4rumL4X4nqtPhsS27YB1
 6T3Gg+6RkD4GJRhXRx8RLANDirPPESEZxuOFn6KzTFZcgH9d6JmVz924Bmn3HmLVWJvk0dq5TR0
 Sh0klhaumo6fRj7xXGTcmi34B6vz1uY5ANW9xanXDApHGVfiuRdwRwJe7A0GP9cq0/RUqpwEL0W
 F35Y5LMuINvG38LsCCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150074

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
index 0000000000000000000000000000000000000000..037cef17ca8196ddbb5c1b0c301702e4f0ea3a47
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
+				data-lanes = <0 1 2 3>;
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

