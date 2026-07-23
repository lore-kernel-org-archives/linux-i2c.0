Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CC394496
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781919; cv=none; b=YeLygorgHqqVj+WEM7fBX3dbxCDhAIMN9OaQb7jrW/A84Zk5dBzyz+8lY/+ouQhAm6a1SeoUUHcf9tsNRIGphVMTbTwCd7nRaiypgMPL9IRGD6O1GgkCY7JRoDzLgQclbVI8gMDE+ZfC8LbEypLM8ddl/6EreV4whRzBiPPL0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781919; c=relaxed/simple;
	bh=XGRj83YxrNm4RwCD2q5W+GyFydoPwPwU9M4GUQfaQfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lyr6MCMHF1YiQFgEZbyszJ6KCUZHCCnsKh5pCWDYTpmLjZefJUIHmsFcVY67wly/sWigUlIcCfC5cc6u8bVBd3vZr2Zece9OW2MbF0YGyRXgIxvNncXMhMY78/wSRqsFoWDsqvM1Ar1J8R1hv+vO4aVfaHcO3f77Cp1gKbYy9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oij7wTDX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eruyQk4V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oij7wTDX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eruyQk4V"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N3KlBN2886523
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fz+QR0/sOdWcbZ+WS9ggauDKFCQ9imB4dhuVqgzis54=; b=oij7wTDXUUhaYHfb
	H15IJq/tYsAsbavn0di6KckzpFR7V0Yoj5n2cpLnSK+z0HiVvGyeaPaszTh1NpKr
	S4fgg3E4wJWXIYmKc6B/mfKxgf7UIB8oHokcAV3MM+c6NL+dsaQ4/bvbaBbg8tdq
	OyehpYawNr6TTLSNoLudExEp+0/xWh1EoeWfm5tc6gRZwbfGI3pexh75mi8GYbpu
	5VrlUv23RVbJma1eIACrdQFalqW9Q8OZV0FY4nJcrh+nike27mN+yd3Gi72Mo4kW
	iNGHrzdhZTBFpJ2JZMYt1W/PvMIuhdEeI2uSDpL8aRVFc2x7vmdAvbIwBVwMJe0S
	hCiryw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkayh885s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:54 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so78699b3a.0
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 21:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784781894; x=1785386694; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fz+QR0/sOdWcbZ+WS9ggauDKFCQ9imB4dhuVqgzis54=;
        b=eruyQk4VCJ7ZlxF9x3A7vjKYFWp9WasHEES/np5JRU7QatTocjkez8kJag5HBBngVD
         x/fIc0GfkWIWLgZfh6hKrKCBBPb9AHnLld9BLj3nQbnLn6H06LMFQ4mD7mM1AHDvsmnm
         LU/znNpl9bQBWxRe+//KK0iZvAP/POiwXi5eIrscPjW1ry0Qd6xsWSJJOQSZ9rZGhzeR
         N+G3OuUCGVGnvEXPpTMqnu5rHUNHtuKQ9erNoyJ+WdTZosOq8IrRG7y2Ivo16+Eo2j3S
         UI1OtPyv16ITAw/YvZKcv3UJxI6GgHqCStKOyjs4jEBLnooWKHDz6RE/uVkL6NpTNz7P
         NCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781894; x=1785386694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fz+QR0/sOdWcbZ+WS9ggauDKFCQ9imB4dhuVqgzis54=;
        b=oMQ8cXyZZzK2+nL2AFMhvW+Zh7LZ8H+2FHiLrfXFXlRwmEM5oIaV4O0ZwlGzmpQ6UA
         qeL6pgrbi7Koktj0JTYAw21+d1+WG3crhO1YBtOnKjwSYCE4R5OMGsVLISgDG3eSiApa
         zJgWoc2mHZMKMFHwBIxe78PGdYWhJKLYhurmL1JZU2meTXbOddNdXoHlRSIQNJe/RVgC
         LkWjkBxmQ8g2SAx4byibYy2CC7BuddYZKa8PENfYD+JBTH6ubyolCMJRC57ldIOydwF1
         dJZ7p3ThbgVb3pLxO+q7oS5j2cW0TO75GKh4N3uoNRwc04quTHiBVyCladV+jNx5t5NW
         G/tw==
X-Forwarded-Encrypted: i=1; AHgh+RrCcs4Yw5X7oYz6IdW8k7KFsNnbkY5aZAizV9NgkHBsAqv4Iu3UeebSxhMji5n+iKiX+Cncp8wgzTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOQWb6Mt1gue22T1fWg/khNJsUSEWg9CvGhhqVC1qsEsuM/I2
	s14AgxzgdtIVmOerflNOul+57Q7lZI4B8CU9r6Vdty05ZhWmTY4hK5PYMPg4qcGn8ytClkQgtGb
	Ok0lPjkWytg8Zaw5v+uF3Gqs201cvCTzRKlLYu7MSMb6RLnuZTB4feM4SG8Z5vI8=
X-Gm-Gg: AR+sD11PJnNPy/EwaPUNIIxE0tQ3VoKCl76COjdCbC/Dd9ur2oVeCBOZyWuAtmJp91d
	VOXCI+HhxpeyVpxx1di30yJbIL2+Ov7upIHGP7wboVFuzgm6On09zNyLvaXjpNHWL3fNffANWRP
	1jnOOCXouqzyu6slAkHQ5bitwFOju6ocySx5XPgMGZqmRNzPGO+BPIKI9ufzRr33uIejXFqchge
	IWRD4NtvTkovnLZZtGP4aG2buHMmV6iYfnxkyykxCWyc3o+jHQzDVfnH6jGfo0BcKihWbvRbOhN
	mvdZcUDoOPnAFsul3Ai2FN43uUGEH15qNSyToZGx1EGV1TJI2/KHpr8RIhrUxk2LjLlgd2JPJbq
	JdXtHdSRltYbyZCW+T72oNCE97NRgAvA=
X-Received: by 2002:a05:6a00:368b:b0:84a:29af:a0eb with SMTP id d2e1a72fcca58-84e2e83fac3mr1234963b3a.9.1784781893776;
        Wed, 22 Jul 2026 21:44:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:368b:b0:84a:29af:a0eb with SMTP id d2e1a72fcca58-84e2e83fac3mr1234932b3a.9.1784781893301;
        Wed, 22 Jul 2026 21:44:53 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175aad1asm2327922b3a.44.2026.07.22.21.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:44:53 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:14:00 +0530
Subject: [PATCH v6 6/6] arm64: dts: qcom: shikra-iqs-evk-imx577-camera: Add
 DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-shikra-camss-review-v6-6-7c46f9bbb4db@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784781838; l=3663;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=XGRj83YxrNm4RwCD2q5W+GyFydoPwPwU9M4GUQfaQfM=;
 b=fMswVXZVWu+X8e0RzElVI1YmxLwGjzwPScT/+lzI1TWUHkZ7tABYZXBOnMt6rQDFkHJ7vO6is
 xp/6UUy0PpECajuY3mU/y8NQikKVnk+UPp9yz4uy6SA3htMpZXRkFAa
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=HZgkiCE8 c=1 sm=1 tr=0 ts=6a619c46 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XDnPgaZbNy_ah444SADCG2jAOe_VX0QJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfX9l26bGQDnpbF
 Fl7XetUa0oD+lrwycu8vgOdUGDjEL0DD/idhOwGKR7nOoPwzMpmmUSlL5b8mMrqCWBIxNpIyjDu
 c4fMtvaJ9HBdv/vH7HTaFmYNYXOvCvX7M385bC7Q70x1myu92crRk4tliHK4lMfcyglaBhMVUkr
 SoEn8alUnWy5LdBkv8PtFj4vsbyIgtimEnFOXetOtSBW2TFZA8wYw+d2OCjvQ7haYO1FKceH+pn
 gT5wZf3ZYNwQEsllwMWAQf3wY5PJHmHMmkkdMbaXBn9fGAoa8Ql9JSecDig591SoIzABiVUGydj
 Zz10kuQJ82bbLiR297fPCNLR4O2nb7wnnwztblmsHTHAvcMUSDIDYBsqvfFDUaBdHPJk2NRH/gg
 eWdCMA+ib4MZd+zeZ7qyoGN7mGuHwt5hcZiZGPwlfBIgg9epW6/60BUzgcwqwvSmaJUZUjdOBOJ
 /F91RzeFapZ7EGcf9zg==
X-Proofpoint-GUID: XDnPgaZbNy_ah444SADCG2jAOe_VX0QJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfXyOWM+BvpZiRh
 Pm60jd7qA0TOnyEZWMp+hjfO1uBSEaFvB/vQwajaHEbh3G8b2LPgxYIcaANgurMOT21T1n84QWe
 bZF8Z5VnbDSLvR+xZGKiBbNZlPVMZs8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230045

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
index c75e0ae736a96b047c04305bb109cacf06d06f07..a1e1daee6a84471f2e793618afe21528576a8cea 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -341,9 +341,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
 
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

