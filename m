Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D254279FE
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078492; cv=none; b=ONknWbK9n2IQPdm10VFKgMwuxKpaPVOwiH6QMpri1ImEEeCaSOik5HiwFIS0c4Mp4t/tE91o6E3ospGNm1bxIBTfJfqsvCwIuvmZ+rm4ddYmj5DCHXRzan71LaJ3RU5OJD6CfG19Q9bPDGxsIFee4PrTvXZZ+VX7QHx8MLxopdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078492; c=relaxed/simple;
	bh=2WG5aoisKJwerkvnpytr8xGIA19LajXbCLZsav5MoQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9uv1HiiSAB8mcINVO15ht83115F/oVFmvU3wtfTCpwHMeg++tRCH7+BCdN97XRVWXD1d8jUbUJ64/qqCS7NYxiV1qU169pBNp0tjc1OmufMfth/1GbIqVliZkVUAt1POcCjQgdfIBuzv8Wq3ManX8B2GCNRu49aIAL9j04MPT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ozmmkC5M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SvmjGJGP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ozmmkC5M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SvmjGJGP"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MAceLm2898711
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T/UfWtw5ZQfseqhZRXzgqUeaU3ggF8Gp/sL3W86n7mc=; b=ozmmkC5M/tEUYKvr
	pj9eip0gDDbkOzEihU0UoWRYue/7bH4BfLspEeEb2Faz9QoSWG2rUnXEbK1tMHCg
	ngMz0I4dBEbbLPOaQmzfmuiKd0CYyuH5bEi6jaujxL5bRPaO91Q+wuhL/AZsETGE
	0VAM3FYflM8XoaKQGNMbPRKLyTH4UPCMyt0BYVULynl4x8kuaR7fWWUmsfEBLcLR
	3G6rtPFUidYu5iNdyJcgD2QHCKR2Yepkh3I2b1uy20cJL9m+9cGU2hlPf+RBuVrw
	IpiFLxuTrTw21si6OQGXkFjhzFqCMtiRjxZA6tE+W0fAhuhfxw4pVqC9LyLwdI/v
	wS/SXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bujau00b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 10:41:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c1cffa1f2dso526326885a.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 02:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769078487; x=1769683287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/UfWtw5ZQfseqhZRXzgqUeaU3ggF8Gp/sL3W86n7mc=;
        b=SvmjGJGP8Gr3VUjmsIRLFWmWvtmFkT+NtIJMu43g4iC6G3U+FJz24uv8UFr4Z9t2my
         X2H+Yl1weT195eosflxvCAK7iBuGOgKvhd/46pbSN5OE288/MGu2PC/0SBV1TkjDzo3E
         iMtZGM6/ZLpjgv7xOU9kIvaWmeKApJc41wep6LVoLAX8VkzG01qtCtJvGSI5uTVtjAS6
         26EWyr/VLcPLd0Ez3eTly7wWV4L9b3bP+RqGQg693M3era8hOXGXZvMoPPcKjfjR5bmJ
         PTZOdLNSUADqlAZaZRYKaJLU482MrJLRpAxe1vwZqgcWSIYBoX5VomUCTbkNT/k+EZUY
         JsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769078487; x=1769683287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/UfWtw5ZQfseqhZRXzgqUeaU3ggF8Gp/sL3W86n7mc=;
        b=EM35SJ4Zb8V1/W+kM/Rlz/1vkat8sFI7e8WPgV3EbYnXf1o8iDpyJEMsTFCi7H5d/U
         A/CyuDajhhayZ8JKuQR7+J+sjGhsbx/OFoiqmsKP/dmQCx6GvES9MQH+Vom4HQcBqJ09
         vKjZBZX6r2LIb/8JwAguY5A+LeYw/bIVKS6KRq4Xr9bi+4a0/0yI13B31vpvCriaYH9c
         kpZCGzIMiDgL5Fs3H+GsWo9UOQVJWGa9Fntjbw7WgLv0/U3FT/hh/scpRkHfMTLcLKeh
         eRPPUiiVNbaje6VyevgHU/pP10p+Dri1DYBz9ciobz1UA27uR2L5GTnRuGVRzsVP3nxC
         s0vg==
X-Gm-Message-State: AOJu0Yw4Dq38pBJD7E2pxWNwH5sxuT7NaeBQrr0P3plLnGz6/0vE3ngs
	4RcqLIutgV7nMOxu0HbjyjVeaV5M+LGyFHmDI5vQjjWF8gTPVyuf6ge0XR1rRfPFKGKW9AsLIkw
	+PiecCICZZ+Jnn/Fg1osTVS6Tp50TDEM/JlcNDk0KCivdwDlaFM0fLzKTqxn5NIQ=
X-Gm-Gg: AZuq6aJzAdOstQHGQp54Pv8jEWqlNvcNZhla6YeRlWxMN4rPtYbVOCERGmJmrjnR0XR
	Vr0pCiY+1uowxDR6jkjAIrHxbQiDep5orxG/+ccLkpeV9NOKyG5XQtu7g6XxhMKEUTQR9I9uHHM
	yrghVfBufH1lHGYEgdrTpM4F7pIqGOrysOrpYHAwGsbWi7vEJ0Ykaz/knx2fH6+o+uFg2pu6F7J
	40uEsFm7HqDPkyXSWoKH8q/RoY8Nh412HbRPrf4pKZKvOV/4Y6Ri0aX5tI7pPlaCTniQaTfT3v5
	ICuyuB6JIiTbFcCPP0fFS5Vz3iEZPEi8bTdDO0l6Nqrz2THjamwmX7UMwF0nD8eu6k3tNt/815X
	2qoOsOzv/t2AXogQtsOCMx/mfAiSefJ6OLsEyuLeDnlAVmsBnG/8U2LGkOmWCc4FOzIMkhO/rAG
	6d
X-Received: by 2002:a05:620a:4113:b0:8c6:a5c8:fb39 with SMTP id af79cd13be357-8c6da87eee2mr272139885a.1.1769078487565;
        Thu, 22 Jan 2026 02:41:27 -0800 (PST)
X-Received: by 2002:a05:620a:4113:b0:8c6:a5c8:fb39 with SMTP id af79cd13be357-8c6da87eee2mr272138685a.1.1769078487163;
        Thu, 22 Jan 2026 02:41:27 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7260229sm1387868685a.42.2026.01.22.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 02:41:26 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 18:40:48 +0800
Subject: [PATCH v4 3/5] arm64: dts: qcom: talos: Add CCI definitions
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-sm6150_evk-v4-3-a908d49892e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769078453; l=2250;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=2WG5aoisKJwerkvnpytr8xGIA19LajXbCLZsav5MoQ0=;
 b=t1vTSMWGXPTYqrQxSeJNFQegnAyafTbIj4gd43njXHFo0Sc5yhyBYN9CUxe6ejwaAaXhH0Z8P
 vNxm/R4ARtgCsjYeWoQfBsvr9wAP1l0UyFu+kWQ0/YQRcXsGVs+db4L
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-GUID: kWadduNI5GKt9cQRazem48nwmAO49gNn
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=6971fed8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=szutk0iRDVHniUSXDBIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: kWadduNI5GKt9cQRazem48nwmAO49gNn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NSBTYWx0ZWRfX3HyFJfKx6X79
 ow/VmPhl4ynryjUxsYepah27HpUFfdpMpr74csrtzoNOwWdYu5QvcvMFGRrGMuyFu2Ga0slTh1m
 hjG/4iQaZql0jXJwabfR7HxG+1pHYFzt9ay5r1bNA58UiS9k3MLfaworgafGclHIQX97VTpvuqS
 nRL3wVni5v9BXxP+/41xFkcXZT/trBHF8l5Fb0bdkktH+hJSF9g4jzdkF+P5JfR8A7HVjf2+7tC
 rSC+eJYu/6Jpl3QtUScwW+AD06X86GaBarV4KDn/qGRlZF6te7KND4LCjL+5pRaRuy57S6TN8An
 9s2s22EMqY++JZzIwIuylakx/QGKfp6QRzyXmz4xjx9CG7nigardADIOAsDxbhzaaJOtEG0e984
 UlR/lij1OLNlDbFXDUzhHt29cZKzzM9FQLAvFzmBLdQvjIWiwxjgxGZEee+QWQkKuGEt0wd5Dym
 ld2lwGGtclL0rk45SDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220075

Qualcomm Talos SoC contains single controller,
containing 2 I2C hosts.

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index 3e1d85b6eacb90b48496ddfee2db27c586f3331e..6d28096e50546855bd762e479b66ed6214ec5d65 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -1553,6 +1553,22 @@ tlmm: pinctrl@3100000 {
 			#interrupt-cells = <2>;
 			wakeup-parent = <&pdc>;
 
+			cci_i2c0_default: cci-i2c0-default-state {
+				/* SDA, SCL */
+				pins = "gpio32", "gpio33";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			cci_i2c1_default: cci-i2c1-default-state {
+				/* SDA, SCL */
+				pins = "gpio34", "gpio35";
+				function = "cci_i2c";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
 			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
 				pins = "gpio4", "gpio5";
 				function = "qup0";
@@ -3789,6 +3805,41 @@ videocc: clock-controller@ab00000 {
 			#power-domain-cells = <1>;
 		};
 
+		cci: cci@ac4a000 {
+			compatible = "qcom,sm6150-cci", "qcom,msm8996-cci";
+
+			reg = <0x0 0x0ac4a000 0x0 0x4000>;
+			interrupts = <GIC_SPI 460 IRQ_TYPE_EDGE_RISING 0>;
+			power-domains = <&camcc TITAN_TOP_GDSC>;
+			clocks = <&camcc CAM_CC_SOC_AHB_CLK>,
+				 <&camcc CAM_CC_CPAS_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_CLK>;
+			clock-names = "camnoc_axi",
+				      "cpas_ahb",
+				      "cci";
+			pinctrl-0 = <&cci_i2c0_default &cci_i2c1_default>;
+			pinctrl-names = "default";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		camss: isp@acb3000 {
 			compatible = "qcom,sm6150-camss";
 

-- 
2.34.1

