Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933837E2EC
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781883; cv=none; b=Q+m3ptkOaDPf6KqZRkg7jqi0nyIFvfHKCw2/JB2pcBEo/XNOUX97BpSqLYFV+ZcjC0qjg3X6vvmHD78PE68rnoHD889sppSjimlo4Y+nCaK8mFSzHV3ZO/RrTUcLew0f5SUqqGBv+0wudTeXwmc8nhgOQxp//qmDM40KzxJOFG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781883; c=relaxed/simple;
	bh=fvp+ta5kyo9P1ISBE724MVFIdf/YdhpsBaN9p/esYwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwgMVoMYu7VpCviZvzSV1BgzON0jGEq2/1KPqJTywXfSYa8CkiP1tTggLt75hNtvjFdnEJjte8ByEIHCi6aAwKuSS1/AVuIA3L+jIDjF988O5bT8S9Lw9Cjsrhx6CqSBgSNmsY3O0Vjt77oSNPIZxcAPUiLRPm2ibh6gLp+lkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gsniN3EX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NLlM3YBH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gsniN3EX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NLlM3YBH"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N0X88E2658539
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i+zagSHROFEodx+Lk0GjyCrhmWq2ocvbAsIK+kpUx1s=; b=gsniN3EXpXixFTom
	iuTVT4ew1b2CajxKkSUbAuahpegxuzwUMx5hvg2VO7x16+bx/R3feX7AeBcdLyLC
	oheTqkVwiotWCsTc7nrw5357q2PbZ2IoG/X8JBhPiDErXKXOgTcXL1NujV8Wcn/O
	nNyqjPoAAs+073/pkQbtqYvPDlR9ClqOQd/rybN3PIqDRsku3uUlCqWp3e58VNgD
	hlrUDYAuKY78L7QJp0ZPvIh+h+USUuH6NfSQFRex7sQJXjdrVxpbZqdf4Gzr/4i7
	oGFKTzq24xvJ15Q+yEicDgtuL4XTEgX9gCMtNBaS1fEoZg2jSRz1rln4dbFte4Jo
	aCw9YA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk7b510cb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 23 Jul 2026 04:44:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso487737b3a.1
        for <linux-i2c@vger.kernel.org>; Wed, 22 Jul 2026 21:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784781871; x=1785386671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+zagSHROFEodx+Lk0GjyCrhmWq2ocvbAsIK+kpUx1s=;
        b=NLlM3YBHkApHPQiUKAxr8nGSUybCJDi2FdSNRkRUe8bs82IIAmi24iDzpf8gxXJHjU
         fOee8l15Q4DKTzcbOWBipEh+Ji7XaK0WsFaj7GPOXBclGhstQD/cOScEyoWD8QAncTRr
         FcDaEZCDq9SfMEFiaum2ligi7XoK4AppsZoJCfpKz4HlCdy0kWUlD/ooACGqsABtjyFR
         m2Jw1nc+BwW0/XPGT3ndOlXUN1VgSwWscQthiFtMReOxXnUtOBIbNyXP62mYPwlcsNOM
         3PjRgQ9DEtIB2dOjNgcD8bPA8VGgW1Hv5LJx4nFjUfqg16mcCuGlAuSKmL07aKF4sgpS
         by0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781871; x=1785386671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+zagSHROFEodx+Lk0GjyCrhmWq2ocvbAsIK+kpUx1s=;
        b=eg7nU7ZXZ69rwp/mAHlyi1gcTZjsGr8PlPEUdUpmiZ263yPx7Q69wrFX0xmO07KdQb
         OejBU7O7Zz3FL7yxY/SRW23NONpo+yya3s4n+pAep+VMHZo9Xv4AdW73u4adij3Cl93t
         ArUIzhF3viuSuQAE0mGnQ/2S2qdFYcyCTLBQaaJnA9pLS6kX8fwrFky29kyLDCKnkpdc
         0tt+KJxRAYwpYWT1eqeNwceMA1yLZ7z4CYuKtAWzTcKCHR/NbUlSk2FjgXOnk3sWMwH0
         6geaOmBoq/8El/ku+Qf5+719GhfoIcQm6HqOf5kGFx1pAPtoiPlmwX3b38qW8o8fwu2P
         Ls7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqRoqkv31yYSLMt4bCPYBxXGU2n0wKN1n+xNfAG2VsVW1QjG3ZCHY5oK+DoP3o+JRF+mtyQvSoYpWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+o5VlTgjQtDiCWimj1MZOwot0fgc/av3TVYs7owZ16cz4Fr+
	1bAr3zh3gELN1cTMFPfkaDmZCgmjMSACYaSOxZHAVEI3vsEx1IOfpQ1Obm1cOuww85NDbDwvBpP
	WoKgR6KbNaYVhwGe5uv7ceVsThU0CHsnG/0x8lTFY6653WJTVLkxYhS/q0XgdLOQ=
X-Gm-Gg: AR+sD12zgBc92qu6bzAs4RU9sNI65VmtltEymUnQTVC15wbAZWWDv26GHSQYyAhKs4U
	U4B8d7w3mPCOuQt1u6aS/REN9PtYrnDzPeLVIyy4A/dLUpdRNdXPdWtVc9ZTGJ3JQLpJY7a9jcf
	pn7y6VQkLvklD5wxIU0r7ylWDRulbI6dB3JmOQYSWKdKsTLGs4RH+omFRBkK1GXBrnOoTAkiZuv
	Yrr4/WQi7J7njhCqf+90+Zj98DHz1taz3Mai1MY7xFP1Txo+ENqb+UqrvqXFNT10g2zyeOQ6S66
	8gM7+UHq1vKjMV81HVjlh8B+UIHNK+WtUtq1esCeeutrhzz5vaGPq+vYt5voBg6cMvcSbvYcY9P
	bFpRCsEZXkEJXq6c/LTupn8i3vuk3eLM=
X-Received: by 2002:a05:6a00:4505:b0:848:3f91:da82 with SMTP id d2e1a72fcca58-84e2bc69e37mr1849207b3a.32.1784781870580;
        Wed, 22 Jul 2026 21:44:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:4505:b0:848:3f91:da82 with SMTP id d2e1a72fcca58-84e2bc69e37mr1849167b3a.32.1784781870157;
        Wed, 22 Jul 2026 21:44:30 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175aad1asm2327922b3a.44.2026.07.22.21.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:44:29 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 10:13:57 +0530
Subject: [PATCH v6 3/6] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-shikra-camss-review-v6-3-7c46f9bbb4db@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784781838; l=2668;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=fvp+ta5kyo9P1ISBE724MVFIdf/YdhpsBaN9p/esYwU=;
 b=aCFsFVSI+19VMBFO+CGAO6movLwyzk2+QHAfc13mdaxkAdQ3arJ42R1jN5tgn6crl6pwlEWUa
 0xPgJ779uO+D+oYwRatYhSbhwkpXFQDjQfx1EzVOZzDF7T1179TJlgh
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfX6NuaOY0cXFaF
 tzOWZE2EmPHrRDOnTKQ8an4PW6GQjST9sEyh5l4boh7dCDPcVXu4/cBEabgOIelcJmVRfesndT0
 HL/zrgaFajSENcS1cWoueXM0S//sJ4mQH29uS6ND/ff4rd7xYpUTIQbL2hADJ9oVV2DCZ1a5AJm
 wPrryKHDq3xWAQIpFd8KruSn6NQ4phjeRp0ObNiivxGijg4+3PyF/9y07jJTeqdV5I2Zo9Fk0vL
 OUcxvOrpIoZRwSboVYI1XpuinNTUpYjTCvye7Kqew9tcnUTc4tX5veq7IlC7W/UaQdieSlRCY97
 bzhK+NKvdXKIHyygIA6++XcXJ6SPUJ3+MZJEjdadeuCN5hRsQs7pXnXg0LGw+5WVxRnoxEJ3+D9
 RjMIoYkpC74Vlydhvuq5T4Vdo0P3ncg7sWBeDX5onsp3J1hP/VB4xg+V+B3i7enLIPEWV+fyqU3
 LcrdRNyjL7HuMvj1ZFQ==
X-Proofpoint-GUID: QTDHLD5-ddVKD10sDZFJ9ruHSrP2ZcUn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA0NSBTYWx0ZWRfX6dufe5LHm/O9
 dSVtGvxCPquPt6rTLIuL9GMshcx9XL92t8ck/otsDD9T2gytINgHSuCfF0bX01IgZoyFUgTsJcy
 ENT96dmW+Ojo1p9VGv2RwBkfQRFnTwA=
X-Authority-Analysis: v=2.4 cv=btx8wkai c=1 sm=1 tr=0 ts=6a619c2f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZbC1Des45MQyGPwI-hwA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QTDHLD5-ddVKD10sDZFJ9ruHSrP2ZcUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230045

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f7caee4cffdf72b7e98f5dd33a33419087cb8b57..215ca0743d943dde71045c331f7cef6ee4d9e9d2 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -355,6 +355,38 @@ qup_uart0_default: qup-uart0-default-state {
 				bias-disable;
 			};
 
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
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -738,6 +770,44 @@ port@1 {
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
 
 		sram@c11e000 {

-- 
2.34.1

