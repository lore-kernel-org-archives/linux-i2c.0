Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E53CFF62
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927647; cv=none; b=WK7jNxMnQlD8fWRg2pOl59GNfWOfZL0n3hFikT7QXm8zTtfHSxARRr0thCdaywkKqRQZ8oJo2KMd36G3PBPxl1gqkJN5wDqcXOsTji0I6F0vt4XDnqFH6XwoTb10pvTg7zTs1AW9o5g8PtGyXVu8XpeNNgR8oBr9ZkaG/zOu6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927647; c=relaxed/simple;
	bh=nnNj0bPf4Tyt7UYYDgU1GYFk9/w1Us7QvO4PuiTMSA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5VTVmQIeYBuMl0Epz25y5+W7JEE6gibA8lOD+POqnTNW9qy5C3FRgMwcyxj8aWRY5G2mr/2N+jjMe3w9fi8HcT7xyS/GktYlGdjUdbmn7b5uiFEDx1M4zAodeTK6t4GLbJZGDDvXqvQe00Ziso8rlO17ifjO275lF4h1gOMg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1ITahX4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QhsBg2/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1ITahX4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QhsBg2/t"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658DRBXB3336230
	for <linux-i2c@vger.kernel.org>; Mon, 8 Jun 2026 14:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z1qr/cFnfW8NLplO047lZkMdrYxmX1NQnYYSVJUNuS8=; b=U1ITahX43xJI2zRs
	knCa6eHfuHe2RTrvmKI5svU2mVVOTq8CTExtI+5GtW7OjY7i4a7A0Bf7fALIK9k8
	9LtBPmJPFJOEKiE3lYOKtZSDWy65diZcRLSulWLFu4HAoieJnm2uxzowdUqTWR4V
	1fQea++iqKcGbPGsOxWoHVG3x0JY04uJM4V/aMnnft2Po2KdAuZjroasKDSD6Sb/
	SR1QtTpB3G7nQrW0ThAHdhS7/+K/oa8nYRVDPV90uwxHJWCFD/cwalpCI5bDST1n
	KENpfIZKMjmgd9cr/lRthRduDp+6raOBnBhm/L4c+KmQvK5odTWjPJfu9aU9agMu
	g3qzEQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun411eh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 14:07:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf281d523eso33072525ad.0
        for <linux-i2c@vger.kernel.org>; Mon, 08 Jun 2026 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780927645; x=1781532445; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1qr/cFnfW8NLplO047lZkMdrYxmX1NQnYYSVJUNuS8=;
        b=QhsBg2/tHAUvRtUIs5HbpNIFL22IdA0z+LOYgiljCAUFgWswbLUiKbTJGl2i3m662/
         d+DDiOTlzlFUTW9uEMf1ouPQ+yOINpaUc0wPBOgWrlWUjmZMz3oy74oS5UlzBoIBAgUb
         6NS+biJL6IMa+MsMBbijlMiXT8il8GiGW891gw3G9yNLqOEVsTWu/adiENfSFF2RNJXi
         BkcK2G8pE8zz8/jjVg1glJ9EapRwzwd3zphYShGGsZ2fwek/EMt/ut5rpkkJG3B9l5ds
         XdKI+pGjiXLJXAiPC1L4qLu877lCIfUDdyfdBDQvNRSxzNjSDciIP7eqcJjVre1KjKgO
         9Xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927645; x=1781532445;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z1qr/cFnfW8NLplO047lZkMdrYxmX1NQnYYSVJUNuS8=;
        b=fdX90FCkG/WPG9iY8jljI7ytiQ+94fyOc8oV6+5Jfdp19FRbbiiGwEF3r/hIzkPG+V
         cyBlRwzSY45rnJkU1x7ihRvfSWbq4HqgVBXTH1QWGnZZKb3Er6BVehivbT3oqjdjoUOU
         lWAMUk7FyBk2/RA8H3tHbbuBy7xGJEObXp2n+g/sxEf6r/eKx+6c0ws2FXI//jQ9tdfw
         4IMmV8OAAnXsdr/lBSIUQ7+0ESVJ4cyb1SxmxgmtzQ8OMWkyQx0gNZUq89VbYV70rSQ3
         hl9PrU0JiL+PPc3tED2ME2vyynZyzzc1jM4kkQK3zLdOUO8cn0Iz/DFo8ICIxgsATyPM
         PBRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0a8sn6ZCfxWRHioWPs/n5MIvK+JtDV38kup7UuikgTrpWg5C/rx7p8kqTOAECSHTHIgcSWSjXJGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cqm3LOwh/KBqVTRAjqrDIbHI+csgZT7gl1p7fBa2lNpr8iAN
	oA7JL+hOCM8XIBPqipH0LKmX46cwCT6utjRT4Hm41UH1Wwm2feRTdaMqjLRCx+5Q42qNbAXcxs4
	hWw4YSGVoZvsNuAKJuCOE7FImqVPyIKHhK/Zsm/3TJG+qeDakb603ltfG40PSHrQ=
X-Gm-Gg: Acq92OEF2KJDReQpotEz7hqrKBGsgfWz6WtQDB348O4qahP5Eg+XCmmC+lZo0MWNLR9
	t1nReQ7Wr0N1Grp4viVJjSdwRXosgVQEQ5jAW/Jhax4pWRxrNUdbZHYbFLh4701ynM2onCm6xLZ
	Uxzge0mW3/Too3+eVsxe2sdQx1FHwl6Beak7RVuV20eM4zlHjbSUdjTBKREJU45bt+HdHl9MBZg
	fJSjhm9w9b5yn28GMZDjEEQVUlGQz91I88KgoGxtCIyw9oHDgXVw2FUTLypUcS4gXwClqSJsQxT
	6pIrG8Bt4iL7RLdGciz3kOf8DL9mqOvvVCdsbUMZum0BLTPVRHwGIQwB22aCxPmZinshx2CVzBB
	/EwkYvb4tzlqTM4lwOD+bcUiWmAI59vZUmPscrL6AeupeTDQlbrXXa4HD6RP7ar8=
X-Received: by 2002:a17:903:8ce:b0:2c0:cb0e:ac3a with SMTP id d9443c01a7336-2c1e7f91985mr175034815ad.23.1780927644953;
        Mon, 08 Jun 2026 07:07:24 -0700 (PDT)
X-Received: by 2002:a17:903:8ce:b0:2c0:cb0e:ac3a with SMTP id d9443c01a7336-2c1e7f91985mr175034185ad.23.1780927644353;
        Mon, 08 Jun 2026 07:07:24 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1646e5c51sm183935955ad.0.2026.06.08.07.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:07:24 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 19:36:41 +0530
Subject: [PATCH v2 4/7] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-camss-review-v2-4-ca1936bf1219@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780927607; l=2602;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=nnNj0bPf4Tyt7UYYDgU1GYFk9/w1Us7QvO4PuiTMSA8=;
 b=GkKVdIkUath/EME51kNESPjACacVq1UXhwANX5S9tPyhbsD/owBuVfNn8TH4OgLNMENiKNnqS
 2DYOfqWUXPTCvifXMUIYSzyhpRC6ya1Falw/4liQ3P/FpHBJF4mUXYk
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMyBTYWx0ZWRfXyWSDJQqcmBcu
 0/jaDVkdyJvRG2cbcGH68Ckstp20xT/v9DFLOPiiHBc0Cj0YqBqVceuV+sr8QfX9V7mkpzwqKb5
 1DtdCw4AA6z9TiKhupjFCnwwS/l+/pShC2CZNfhjY67WRBPliHsfyaLHEvykAJFI2Nw2a0nBx+O
 GgUDHs3mhDBAIwdIzzBkrro3F7PR3UaxXHasDDu/c+gIphm4WzmrJ4VHkiQHv9EiH5+Y9Mv80pg
 nBdt3WaQL9gpKUpSwCrDy9pM6yvBZLFpMWW423epnw3M9LrRQW4fvX68wIKjewAOsZiu63RhBTO
 vV8hw72BRvuSVaWygAPOfPudmJiqS7en5uLRkaf2WPwF+RFZ6b0NspU+OWvVLDilxfNa49avOQ8
 cZAcu3toAj2T+De9AMDROlHPExj+Dnx2W6Cc6d83UoxCHxXxZCtO4LouHFKlAIQ/MewUGFz2a/G
 14MtYEEiMOh0Q5Cv12Q==
X-Proofpoint-ORIG-GUID: 45WioGqgAyGx7J472pFy0z9ImMhdZIZ5
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26cc9d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=XuEftVTFR-VjiOTT8WQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 45WioGqgAyGx7J472pFy0z9ImMhdZIZ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080133

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index b93ce4a92a998ea5d9d4268d2fd46030fafc4084..fed71131491ebf6e261bfcd14b5d4a2624837878 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -348,6 +348,38 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 165>;
 			wakeup-parent = <&mpm>;
 
+			cci_i2c0_default: cci-i2c0-default-state {
+				/* SDA, SCL */
+				pins = "gpio36", "gpio37";
+				function = "cci_i2c0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci_i2c0_sleep: cci-i2c0-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio36", "gpio37";
+				function = "cci_i2c0";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			cci_i2c1_default: cci-i2c1-default-state {
+				/* SDA, SCL */
+				pins = "gpio41", "gpio42";
+				function = "cci_i2c1";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci_i2c1_sleep: cci-i2c1-sleep-state {
+				/* SDA, SCL */
+				pins = "gpio41", "gpio42";
+				function = "cci_i2c1";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";
@@ -701,6 +733,44 @@ port@1 {
 					reg = <1>;
 				};
 			};
+
+		};
+
+		cci: cci@5c1b000 {
+			compatible = "qcom,shikra-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x05c1b000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 206 IRQ_TYPE_EDGE_RISING 0>;
+
+			clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
+				 <&gcc GCC_CAMSS_CCI_0_CLK>;
+			clock-names = "ahb",
+				      "cci";
+
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
+
+			pinctrl-0 = <&cci_i2c0_default &cci_i2c1_default>;
+			pinctrl-1 = <&cci_i2c0_sleep &cci_i2c1_sleep>;
+			pinctrl-names = "default", "sleep";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		qupv3_0: geniqup@4ac0000 {

-- 
2.34.1

