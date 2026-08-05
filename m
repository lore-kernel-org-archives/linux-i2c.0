Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCB4749C6
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938028; cv=none; b=ik5K+7geHuGkhTCrx5o4axUEomY40kcuLJukUwSSdPnf5qCK5WaxKKLU+2C11vLa18BaXz8Q/IMic4uA1l9JhUcnvrOJTZa/9cv1gZvLKuXXvKx6A2nEmC+JKm86AqNBwyJDRVPMuLbxgALcOyTd1z2WHredmJVtGMfRNNlviUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938028; c=relaxed/simple;
	bh=lTjpGa9aw9j7oo/7K2Uo54+/x9/nRwS5LnIyxeuI31I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIX9s0qKnaMwL6ECjoA3VamrGqsYUc/eX9etOMnn+w4fY0rkBY0agDWN9RGTtwydAfXeXN/xqFKSPfm2tigLOJgEkb3HvnrX9odxVU+H3T8G5eC/5kP81+24oNXamJtKMXa94scyfl5PxaleM7l7tf4yFVmnHVO6FKH8FF1d+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9HS3tiW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZwch7He; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9HS3tiW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZwch7He"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Bv6C52864919
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 13:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y9hkkjdmafJzS9eEzwPN0UqcbjM6LEHIzsWnMQ++U3M=; b=L9HS3tiWCzeqPSks
	zEc4JN4XqjssiJfGc15ExH8KDLT0NXO+7bDMGr40ct01adEZGRdvuRQGEnPZzYpW
	S2/zah0JTzMM66LIrT9h0fyTqlFi3F6M0xf9URI+1WbmUQWkhB/lrZ8QXmkQJDLf
	m47k3JP9LeJRUgj4aX5B8ItRBSgazv8zVCFrMlS2yP6QTrHmIQMpQT0x5s65R/bI
	fblrag2FPpw8xleeWPimpKvVZZ8Hn7CLTLQoPBt2zgzVNW9y3q9zQy1xub5IfSo8
	0u8VlEQhzsSPy6JQmkqj/4VVDNckmMR43OjsNeGOJS0mHCtDO2qNYA2Sr5iYpZoK
	UdF3Bg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2r6104n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 13:53:45 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-82014436716so28148357b3.1
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785938025; x=1786542825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y9hkkjdmafJzS9eEzwPN0UqcbjM6LEHIzsWnMQ++U3M=;
        b=bZwch7HekV6dQ3yT3HhGOZKoqbQ+N/CalUljtc86eCQGhCmvkNmpZvcXQ5DP6GSZWg
         7EDAPilmH4xCXNHSxvatODRsd/3zqFtuhAHg59pNO+4D/d4n7U0QX354qCd1g8v98ZNV
         BjFRy1f82R9YvQrHmc+kSQk5UIGUvtutFP8DhL1DG7FOXnh50taEUqySvVTR0jeHSmzF
         J1rgJ9x2sSrTAjepB/8aR9E/HN8wOeD/JYQ2zE9s8zXTF1F2X4E6POlWGATysd7Bldvm
         j5F7Qnagd0btNScb7rqvx5F1FPNDw+eHyIV+dfcsl/3B/mIZqJkcGHb4eNIujR/FlW26
         gr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938025; x=1786542825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9hkkjdmafJzS9eEzwPN0UqcbjM6LEHIzsWnMQ++U3M=;
        b=mqvIjJY0JBD3W9c5+GU/gw+XzdbdA8WOYVKd3PopZ1XKSgINSU2uSOFA4xigKsP7NP
         JASuMlCRMfJHOLpRQrK1F1A6N2zH/3WB4x5xzHGuOHrxsZmCIORdKq4FftqvJMztCZ7o
         VEIiE2oG0s6+NIuS1IzUo2kYaEnKq6+rdkhzsDNDIQYnJc/lzSHwL7mlb+F1n5qDpoTR
         i8coiEsQfDlsRIzN3AO0ie61JPofUfncnOXvH6IEmnu+q/5N7pOIWpJR8TGXahBIpQGh
         1kh/AdZXNkwqziLWY3ccTLtW0AjJkg7rMeXJgVdfaEyZT+fk1t+ou95aaoso2kPwiI/s
         Fq5A==
X-Forwarded-Encrypted: i=1; AHgh+RrzO1A9TD//OfCWOMDmEOgpXO6Ccc7vTPJct4uYQdarTKlaboWaJ/IHXiM1lL6OGLCwu8FcMbohs7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt7NgzF/n3dN1llM1lyrkiA1/xAUF85XXnNvIlvd4jN+t94K7V
	Tc0pwVIIHD6V2Uisv+eTEWDn7iPnG2y4GpJVsJdcl3WG9zO+RH40tGqeBEEfd3sU3NC8gIcizXP
	RlMI5N4W+tc+EqJRTepPEgiqfsDl/2fwY57LIIhPGRmu59iahcOGR2Kn320lMFMA=
X-Gm-Gg: AR+sD10FV8FjoVRxxObL8c/ELG9PqCKuVL9TfC5GZMUZAgSfY4IUcU72lHamVysG2pI
	UlmL2YD4fsIIqninRfZzZXGWkvvnWTl9Boefwpon52vwYL8vblK7p1eBhMvylFRx8RCON0OF1ja
	r1dNIZOWTvDKHjUpgBlASH1a2TpHvFn0OaeGYT269D8avrLIJXv9W5vq4tG8xK9vu0KH5qGq3RE
	G+7XWPxYINzRevaScw9taft64Ryu+X5rMhNLuDnokNZsf/0IsCOqDhgMkyRHezChJ7TzJV4I1/N
	Ljx/rB4c3fV54Bh53NgCRo62saJ1MClxFAfXW0T+Dt66q7UXdn2IEyCu1M2sMWjrAB7FNry2P5R
	pMUHJxiUZkGGGjQ/cffhrAPUalrg1Zrk=
X-Received: by 2002:a05:690c:6f12:b0:81d:3018:6eca with SMTP id 00721157ae682-8201c491d4cmr43940037b3.12.1785938024940;
        Wed, 05 Aug 2026 06:53:44 -0700 (PDT)
X-Received: by 2002:a05:690c:6f12:b0:81d:3018:6eca with SMTP id 00721157ae682-8201c491d4cmr43939387b3.12.1785938024330;
        Wed, 05 Aug 2026 06:53:44 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201320ec71sm20892517b3.12.2026.08.05.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:53:44 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 19:22:50 +0530
Subject: [PATCH RESEND v6 5/5] arm64: dts: qcom:
 shikra-iqs-evk-imx577-camera: Add DT overlay
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-shikra-camss-review-v6-5-a8dbc66f0d87@oss.qualcomm.com>
References: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
In-Reply-To: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785937970; l=3663;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=lTjpGa9aw9j7oo/7K2Uo54+/x9/nRwS5LnIyxeuI31I=;
 b=DVdk7tPHrxiR9a0X3yL4sAFZRnMhvSJDw5eUqZ1EMTNhSORE2OvZxD59JcHMpgqYI+XLBUYIC
 zlWbfOPbH9UBXiR06J5SL9aLD7spPeInAFOoGCQ7KTQmOCaKaq9QvD1
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Authority-Analysis: v=2.4 cv=WrIb99fv c=1 sm=1 tr=0 ts=6a734069 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=OGCdAuOInqFJiNoUztwA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mprpsS9Fzusz5hUv-YH-bRyplm2eIFSs
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfXwMNPS358EUAN
 10ZOGBWW+HKhGKpRaij7BEIKho0Riv0Pk975Pcic9e5V6M62I1MD6tI1+mkjKEeW1RzktUP3gUo
 kjrGN2wGEFTkFGhaD4MsVM5qgCly1RU=
X-Proofpoint-ORIG-GUID: mprpsS9Fzusz5hUv-YH-bRyplm2eIFSs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX/VAKix+Tb/7K
 VKed74fh2WErjNMmOO09aJOPD+0KPTJqoSxkl0c3YJ94SOWNJ4xp0vnBxQXwyuZ+AaqVYTsb8GB
 YtuZkOXe8b20VikQQ74/2Ym8OSfU7shxZcAEGBm+X5ThU/Nv1Flgz/eOF3BvjDou0WxWNmNGWvI
 a4X1lLI6RVVn2Z3GQy9Rly5hblA4fVuxpXNy9BRDH4UOigzzlyGpXK3n10trQeOPION5hLhAsYL
 aIEan82gr0C77BNFyUpUcGXnh5RbXiQlBG2WfXmMzIW/A7rkBCuyAs/HSYOi0h9NvnD82uKuh/t
 OapMTuykhXZrVjsrU4+j/4befNOEg6l/VmQvcv8iNrbfn9ZSphvqSPvRmvbT9ogZptUe8I8VJDo
 DQ7S5Y6tvymh/b/C/qlFniBHpF1kVLIQ4O7MrhWEUu+I0XXgXhqsW0EggoRrmR2+bJftbMPqi6K
 ae+4efvsyBrjgr+KJkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050112

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
index 03ed24afad5795b49848a2548c0facdc9f3e7115..5884ff14ad4552249b029d4aad569ccde5768647 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -342,9 +342,11 @@ dtb-$(CONFIG_ARCH_QCOM)	+= shikra-iqs-evk.dtb
 
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

