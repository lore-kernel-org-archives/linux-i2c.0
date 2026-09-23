Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43243DEA3
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161520; cv=none; b=F/OdA24F6bcX2/wJLcAHd7hS5sdfqX8sGD7qFAS/L1wXT3xb2EZvP05g635UxtTcPaAE4idKwVDnfng1/jefLIJOh39ObygtByca6HJdkBYeY2eW1noA9fpfD/z0n79whA8NHnxXs08S9Mqp6arKEMn4sK0JQVQuMqT7EI8rD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161520; c=relaxed/simple;
	bh=ejkGZbckdu7Y8g19FzEkZUzXDoil6pNFeAk6N95Ij50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tsxAGfWg8MxdtOVmSQCU0f9ypBlu64X8mpIx9jqicT6NQHSGNG1rf5joOf6DkxnWMf9ZaP/xwXHWWTII691+NmRL8QR9TrVSJsLMH2lqSIEsxgAPfCxEgCYS2KcOw2YI94CvkSPH+Bpcxr3TGo35310ONmcnVMV4sgol+UWyt18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YcYMkJG4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XlWEy86I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YcYMkJG4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlWEy86I"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2emD2821196
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tre58gH1uuyq7gZPL/9X46DDzlm5FDA2x3JI7BE6AIE=; b=YcYMkJG4wD4VS4+r
	M/AF+a1haPZDtBOXHe34vQMotk679I6y00T4xex+G8JmFcoQV85VLvLJlowWt4Cl
	dGKCaYLgNnqXCqPZoumiFp55u+j3mmWUI2ETfhENzyhVV3YPTyW1b1A6c3wWVSK6
	XZdn1YY91M9xMgZw55swmdNzr4kvk3z2Qb2/UK2lTID88swK+5iHNU+a/HtOB27A
	azEpfOw8doWHigU3pDihorfQy631wdVCxV0cp6YfkBw42Wt6cw5pH+KOD1/44kb6
	I0st8cklaklAdY9T4EsI+bmUyYnXKB3gdxwwoEwtEnYzh7i9kqO2Qq0aHjBb3DMs
	JnFAOA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwarf8q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:05:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-32b8c2b30c4so1151133eec.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161510; x=1790766310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tre58gH1uuyq7gZPL/9X46DDzlm5FDA2x3JI7BE6AIE=;
        b=XlWEy86IV2/LcHo154Hf9pUeK+JpaWrRat4F7BVC20PNHJbk8PZyz4jQynZQHWDEYw
         5U8obwsgx35ufwUaEHmDR1s71YUifp+4VwaCE+/J9LMVrdLHdGRAiN6mbxWzruSS+DvW
         0SigedG/4LM9wTSkOv9+SKcSeJGqgbvcSXA2SR9dpwXtpsG1ijspL8UN3Rb4XIVQRT0r
         y5vGqX8wIb3J3fe0gwiqvoftdBHwRJTyJTkT99zcap+KF64gIvMS0eftbtlofDHpARL8
         qMXv2Vn1RQyznZdG0/2lbI03EDqtdn7aGG48Kjkr9hLq8i1r++LZd8x04P0YeBYaPZ+g
         JGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161510; x=1790766310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tre58gH1uuyq7gZPL/9X46DDzlm5FDA2x3JI7BE6AIE=;
        b=n/PEKlsfxwG8QJwTAviTsQHzccOd7P9ClfydjOF5pEYz3nzoPfSxqmTbpFl+dmu9u5
         w9aJY0Ecn87JQ48qgexO7z4jjfzBi2htRze8QgVnSTrNLVPebS05BpjyCoCUgbnXmZc5
         pCkTYSb4o16+kuofdz2BeEaBVLQ/e5yqjhGfdJcyJ3xPIrL92FocNVVbwxl+xgLBf4Q7
         AzCmli12grVYNcv5YY9+gTxxhoeuFlAfvyPf6c0qZCWnnX3KmVZuJgA9/e/s0OVUaWBQ
         WLvuqWd9PntBYGY/jPMxrn6ewvSfJAhbTOyrRrGANdmiboYQXLQCJaZXxixWdEOPCEij
         dJNA==
X-Forwarded-Encrypted: i=1; AKwUvBzYmi0pRrUxm9DJmx1kyOraPlnk+rD3Vz9ZSS/NkdbFtbQ5CiZfCRENYmchRe+2lTwVKNR543d0tcY=@vger.kernel.org
X-Gm-Message-State: AFuF++n0EHVzN/FQX+nXsqu6Nn5Ip1EIDSor+qjAilz9M9OwE3C3Kn0/
	Hb9gP+aPbJgPQOw6j2MGx9jjhyfn7HuPnc7quSqF5vqdLgrpZn3PVMkoM5wo56FVepvOVzErB0C
	A0iETfyWmZMtZaZM46Qb/BOQ8oHo4U5ITkxybKvdtf5yB7sLILf2HgLYHM8IANsU=
X-Gm-Gg: AYBFou1kRZ5U6PC8GgdL9Iw70ekmjwNQmJctHjxULn5/VZnv2PG5hyTC2/DWFYVWZVc
	79A+A7pQeaCrdYniTZCnNKqNyUxwTlPtcdrGVQQnokqvXju0IfauVPQtggEpKXk3xi6Bx5YtMpb
	+2xocmYpwecQxKfbGqyYwnW14KzsThl75sIt8bzucwPyHfU/EKS2o92Za0JjEno2NIFCuz8s+bU
	xZ1phHI+nDuUWggYCUZAThZz1UDOrNt4qSC55puDru3r9V0eA6AIEdubZ0GwQY7Em92ar5qtjuV
	FgmaE4qyVmNqsPY1rUbD2sWR/7NgTYEAspRUKLNy6THBBLxJKaWxnzVsGE+uFnTSZSDkD0/sXOK
	BsipNsmBENQWdYuWXqbrNLSOd3rYmfw==
X-Received: by 2002:a05:693c:60cd:b0:334:2bce:2216 with SMTP id 5a478bee46e88-33e8d9cd4a5mr2878201eec.23.1790161509498;
        Wed, 23 Sep 2026 04:05:09 -0700 (PDT)
X-Received: by 2002:a05:693c:60cd:b0:334:2bce:2216 with SMTP id 5a478bee46e88-33e8d9cd4a5mr2878111eec.23.1790161508317;
        Wed, 23 Sep 2026 04:05:08 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:05:07 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:45 +0530
Subject: [PATCH RFC 14/15] arm64: dts: qcom: maili-mtp: Enable S5KJN5
 camera for Maili MTP
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-14-cbbb42e534ef@oss.qualcomm.com>
References: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=2567;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=ejkGZbckdu7Y8g19FzEkZUzXDoil6pNFeAk6N95Ij50=;
 b=u0MMw/aCYYKabTZOtxbRelgxG3E1x61XwJwYbBNxzycuHB20bn5MW4HHTzSBXbHPl5lVWDZJs
 rDkZkPQXff0DKiC0PewAkya9akkmBda/NhFajHlry1sHvbYik0T5/nR
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX/KvqVTldZ/XQ
 9L6CS4Xmi7QeGpL0rLW934GXx2FB8gy2O/U9sbPArGj+s78HD4h0Rb0oGVJZ5q4qQc7V5aB2Twj
 DbV8/nuJsTJGmwjbS8vgOMfbOB/HBwUUTUAVf00k1WKdjZyoQ/VM0UVvZsgE6xnDKMDZJxOL98+
 5w+cTDiJYqDmcH6D5z8Nf13l60JpriNnwevRxJOmYOFOVfH3E168fW1iY6yoSpGMflcfoh7mCiP
 xk1nj57XaaFuvq1kJMuP2n6b0kdh9Tr5chWnDV7qkm9HCpLr90L/ffCqFtbUSqveBMxrmWpVw2I
 sN7wGO8D/hR2t5fsVfhZASF9US219E6oR/R1P2ajaASU57mAOwjLgDWLQILkRQs047PC0ARGCdl
 msdED0airHYKaWBE7tzqn9zNChF5B17xJW3KGw3pM5FiAp/gItHWGLJZwqbBYvmfRS9Nb1L3JoI
 Us8bzFrAC2Wr6FZuqlw==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3b266 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=2OLIcDlHICjy9cVqpt0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: iANcLE9M01tMzocwcxHSeQOJamBJC3q_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX3ZNnnEFY2M9T
 VQM6WGzbjQBtz7Dbid9vHsBrxkZRYKP+WcIdc2EBZLk78dAHBGgV62jtE40rJBawzrUb0RXHZOs
 d0PVd3mthOWLOjh2IPBb8XG1mANA4PE=
X-Proofpoint-ORIG-GUID: iANcLE9M01tMzocwcxHSeQOJamBJC3q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044

Qualcomm Maili MTP carries a Samsung S5KJN5 rear camera sensor on
QUP I2C9, connected to CSIPHY2 via 4-lane CSI-2 D-PHY.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/maili-mtp.dts | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/maili-mtp.dts b/arch/arm64/boot/dts/qcom/maili-mtp.dts
index 1fdc91e03271c40640910b57f3187311b6077ea9..f8582a21d1b4f58113c6f2d1a26e4d673016894a 100644
--- a/arch/arm64/boot/dts/qcom/maili-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/maili-mtp.dts
@@ -8,6 +8,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/media/video-interfaces.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "maili.dtsi"
@@ -743,6 +744,62 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&camss {
+	status = "okay";
+};
+
+&camss_csiphy2_inep {
+	data-lanes = <1 2 3 4>;
+};
+
+&csiphy2 {
+	vdda-0p9-supply = <&vreg_l1d_0p9>;
+	vdda-1p2-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+};
+
+&csiphy2_in_ep {
+	bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+	clock-lanes = <0>;
+	data-lanes = <1 2 3 4>;
+	remote-endpoint = <&s5kjn5_ep>;
+};
+
+&i2c9 {
+	clock-frequency = <400000>;
+	power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
+	status = "okay";
+
+	camera@10 {
+		compatible = "samsung,s5kjn5";
+		reg = <0x10>;
+
+		reset-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&mclk2_default &cam2_reset_default>;
+		pinctrl-names = "default";
+
+		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
+		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
+		assigned-clock-rates = <19200000>;
+
+		afvdd-supply = <&vreg_l5m_2p8>;
+		vdda-supply = <&vreg_l7m_2p2>;
+		vddd-supply = <&vreg_l1m_1p0>;
+		vddio-supply = <&vreg_l4n_1p8>;
+		vddio1p2-supply = <&vreg_l2n_1p2>;
+
+		port {
+			s5kjn5_ep: endpoint {
+				link-frequencies = /bits/ 64 <1248000000>;
+				data-lanes = <1 2 3 4>;
+				remote-endpoint = <&csiphy2_in_ep>;
+			};
+		};
+	};
+};
+
 &pcie0 {
 	status = "okay";
 };
@@ -906,6 +963,13 @@ &tlmm {
 			       <119 2>,	/* SoCCP */
 			       <144 2>,	/* CXM UART */
 			       <211 1>; /* NFC Secure IO */
+
+	cam2_reset_default: cam2-reset-default-state {
+		pins = "gpio3";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
 
 &uart7 {

-- 
2.34.1

