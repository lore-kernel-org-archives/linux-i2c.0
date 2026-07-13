Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF33E1682
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934954; cv=none; b=hTqzOp1o0GVuVv4siosDSd8YxKOTl5LwwkjvyQj11P9PW1H2OjVrftXu5qCeDAF3JdkouMNEhmk+2alfjWqSa9w+09PWPMxIR+7Xx/fpptLMxKeNPmuze94+dSXcAr2lfLXp/veVPU6T5ZNsD6S+KBc9lckO8YRHUe86IU+es6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934954; c=relaxed/simple;
	bh=3DT6QRDlnKNLdhYLJ0aWsJwYiHRrU9kcv1vYTABy68U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=maI4gbhsQsyRZJ/UdED4LLFX1ZFmnohXfB56vguzwPFfci649JEzr9HxaUzzo0CTjV4q9nKJup3e9gIcsEPaxFTTkH4QYm0br9ITchtY3QWCjgTaIGoeDBaBWh45oTPlSkf+lXQh4fQpNuoJMuoxIrAdiuvRocBbhACWy2ZSWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eWL33Yg/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfJ0FZCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eWL33Yg/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfJ0FZCJ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NnMG732256
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XPZHmS6h/AcJRV2idSAJRkkNucwFXp3FnUZZxD2wUGQ=; b=eWL33Yg/FdDF8gik
	hh9Q5gFuv1X4L1wriQAXWuu423D5iDCwzwo2LrV4USpyiOLFNLg4MGc2WejsLyIA
	kVBgmZuoWjZGDeSYxUdg7+4bHnZnP52sNzC6amsMXsnp0TjwZbAKNUuBJntb8LZw
	vmJRqq50sDvhtWJzycyUQQfacceKJ1WZOBHMYI9z0L2WM63YMjRsE4ppA5D/OgPD
	ToOKd5heWqm7AEaKAnFl2rc7M6fyZSZqTVYS8GJVTbwNGpAFTJvwl+umFgfYSxts
	jB8Ig5xSVmhb3w5zJ+QXAcS/ECMNo+UITDGtpNt6GR7tf6CHR15H6wsq2Zwt58H6
	Y7CBNQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39upq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 09:29:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so39942875ad.1
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934950; x=1784539750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPZHmS6h/AcJRV2idSAJRkkNucwFXp3FnUZZxD2wUGQ=;
        b=FfJ0FZCJpUrB8A0QoTw1lfM7Yl7wpTDuEmf4GzTSeAUkA/r29+Y+frtQ2JFetvQy+/
         K1yxI36cs26cCGtfVbDIQtdqEnZm7jSeD3pSOa05tTHZ1VdGTFRjLOz1cvZQOBXiqkzB
         Q2z0AfaAai0D5eonL/vxLKZ6UgOiKd4yIYzrNjtqkcVo6R1o/V46N1SC1tXaOPxVY9tG
         UuoguSC1QDRXRIkGPlDDPYBtnnxGa9Fd7uiu12+IeIywRswcRbjtl8KrpkaZWoSCb/OX
         9/qr6wTCCPkQaeMjujpQR/kvytlD2yMGTg5Ll1QBp/wSqJu+O4msw3q0d3MQmZ9Z2Tz2
         ETaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934950; x=1784539750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPZHmS6h/AcJRV2idSAJRkkNucwFXp3FnUZZxD2wUGQ=;
        b=RSYWfmhlTRIgcQl3XsapXmx+6RrGqV86+PpJ0rbbTxuxywn3zZRLIkHzXCMPOrEeLp
         s/LE576/AtPydxRcf2xjVsj4HfyclI8o/Ekbn9eG58Tpez0gCy2iysOK5fgf+i8NpQS0
         Sx16yES1OkdsFIYDkmLGA5D/sZkjPflu28PlzNT2xj/ubZQxjrGN/5ewL62IhWdHm2AT
         O8fqOe/SFvH/G12hgGHaK4B5fIPjDVxmgzZmugkGeGqW6cbcJ7IzBcQQsJxjLgnO+ZFE
         6l5kt2ZRUZAoUSAtw3orR4TShdSkoQi/rx7AAUpJDkA11kcmSYGFz04GxnGeV5wo3rqK
         b8gA==
X-Forwarded-Encrypted: i=1; AHgh+RpzA0KH+WYHhx0ZWLuvtlo1qPmsTKk+TtqVWfGuQev5OuvxLAdeLcVf/sDrkKOOFm97CLSP2EZJ8pM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd2Q4UKPtb9MZoxSHuFtgX9s0zhwCk1RiDcU+nqFaPtP3oO+5g
	pjFTizoWisIxW2C+XaAFzIW6LLswJ7XX1Ua/6SaiMQTAO3MVs0gP+cHq1CLCpOzjlbSLArOHhK8
	8/isAG7LWPHM0Mlwhq2ZiiQARrnXGF44yMUbsnJqhfNCP7KYHX48qxbNZKnOs24w=
X-Gm-Gg: AfdE7cmQV2ZaoTKOPSMa9ByfKvlampJPAldgJ+DRNFvvclSYa3P39MhxFlCjdkax63h
	suhXAADnjOrFaP3eWJgtWkhmmEoORhDdIjo+/5DbwqluL3yL/w6EsWSrTu4L2diOWSBuZE5lojR
	S2Zds8BFX+y1iijhK2IFTW0UxP1OEYxTNs780uMgS3d6Fv0jRCDESt7jUaB1pKo0+QFHiJJFfLd
	5GvSuwDNCtUn+hketBtH9E+2l4aw0+1FQyq44d/f7u67bGwDL1gS/TA96PJrrBzKujdxyqjUGoO
	3AaYneg74GxN4bDL12P/pb0X6S91o02UuYLPRMhA1WBBYnDRC63/wEwcS3NjNTKx442Sl16jGYc
	ODBLWt2KdSvPpfp2WoGNjulp3DWFBFcitV+7/p1HOxg==
X-Received: by 2002:a05:6a21:7010:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3c110a73f8fmr8546316637.35.1783934949633;
        Mon, 13 Jul 2026 02:29:09 -0700 (PDT)
X-Received: by 2002:a05:6a21:7010:b0:39b:dea7:5626 with SMTP id adf61e73a8af0-3c110a73f8fmr8546286637.35.1783934949195;
        Mon, 13 Jul 2026 02:29:09 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm47495569eec.24.2026.07.13.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:29:08 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:58:34 +0530
Subject: [PATCH v5 3/6] arm64: dts: qcom: shikra: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-shikra-camss-review-v5-3-db53be15dc4f@oss.qualcomm.com>
References: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
In-Reply-To: <20260713-shikra-camss-review-v5-0-db53be15dc4f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783934917; l=2621;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=3DT6QRDlnKNLdhYLJ0aWsJwYiHRrU9kcv1vYTABy68U=;
 b=G28wrDzWu2NzTARFJ54PJ3XxhPcMa5sc5Ppjqr2j6H7OiEQ6JhJ7NsLaMX5AT2fjmUeLDnYUz
 kaenrXUlaSFCGevPMgLBSABMYZai/+myb/fnRfHumo/yKYXSWY6FdhW
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX1BYNxwoNC1h7
 4shWIOPfr4egW+hwK4O4BKSMgfw0sEbdg87DRVrP4u9oBEsZNKw9i4JtcFqv0LnHfpNShY6sX3a
 Sh+J38X9bndv3TrA+L7FYEaZgkPHAKAGOzgGiBw0aSraWoa5zjza+E4kfNkMgJgVfeMOoVwSVAm
 f1LjZ+ZqAD22ycU6houRw9TtxHvw2kkVTobY6emmuhej/J3YSNV84fhCvzuCDjJQp7gmhLKu2VK
 YK+gpJ+FQv1xpkTqU6OvgGiLtozn8xInIekivlil/kkD2r+1Q6pDX/LxTg9e6W3ot64oVdxObW1
 bQ0C6/+fGQdLxrE54ci69n8qNUKPe6OiIR7S/iREsgSylxAtD1wIEK4qUgMUJp/vfF8f7e+sdaY
 MA7oiNxVIXvtV/ondyQjjzaVBkUtJid6MOZTfh25xTWFSulnfQGmz7ryKeD/L9S5maZ4rwcweaM
 QjMAaI78eOgSOYgP0LA==
X-Proofpoint-ORIG-GUID: jS3e-sHVA0yqSZzSYm5QGub379gP_NHQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5OCBTYWx0ZWRfX1fo3AaMRchXo
 OfHM/zrUyDJaLFzbK92xP/mRVVtIylAKYAkSB0nhNV2FTb+wPrqhiNCcARr5t79GBtlKaSpHmS1
 6Gs0VIXant3S52dYEK/qozG6u3Th+uU=
X-Proofpoint-GUID: jS3e-sHVA0yqSZzSYm5QGub379gP_NHQ
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a54afe6 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=s9wsCz4ZXjtKvCKk99UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130098

Qualcomm Shikra SoC has one Camera Control Interface (CCI)
containing two I2C hosts.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 6335caca329808ee04d9067f1f95e8075e2fc3ed..18da1380e52acdd8813625eaceac796e342efd16 100644
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
@@ -702,6 +734,44 @@ port@1 {
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

