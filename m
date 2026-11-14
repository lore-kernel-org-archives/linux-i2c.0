Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655927;
	b=p92qU/tw+HJIrukO8jowd1cSHfGg2EQc7VZ9lH62nBxKNU9R+v4lSFCV8Mm7x2YIu+Ck
	 W6hQwYXKx2JpunlallHCgvyJJGHpJgGwUsmV6YX31t0DI0JgcCLl51Q8iQKBO+nEVXRqa
	 k2qiR8n8S6YGmCC51rUjcECWVmUnQQRp8rqyLekiJbUJ6lVUtdAAnLxG+v801B05Sngxg
	 MbhxWFQm+2uZML866Ua+YsaRouLhyElS0T7V+oTxVjkAaLW/SH+wjb63BOlp0Yd+vXVvq
	 K3hyIpbOOsHltq8I+heWeQuxIEibLLPQa/gEu75l0Jsn7KnMQs5o3aYO1/BqDyxtTdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655927;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zQQmVhv+kzuoV/3wI6+2SQdGx9hm3pY3alCduLOYJsw=;
	b=42jIk7NKgjziQ8ch/cOh2IgtJsDc+JU65cdZCFh7Y+mAmCyoxsZY/gQpbLszxNCSUAV/
	 +U8a8OJttD1XxGsEP6+iJeh4B0fH2/Jvl+1AmqzFymdTK+9/tGNWiJzs6x12Gei6l1Qgd
	 eDhUHrVHxHjUea+hgODviWj9cFQV41SHpqjmBZD47rXPOylljjCZG5pQsBP6RqE9XRiID
	 Qu6CqqS09Z+YrsjMz67IVfAdhH9Nmfsmr3L45uuUmRr+0CX6r+AB2pdUKafBCb58jGvfD
	 o8D06l/+4iLDrUZCJRILr5XRX3ed/1iaAWzvRacaTZ7EXdG6SPpnY94Kr2i2noNv+vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfDF4bRn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kPaHjZFD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F7606A32D
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 728F7606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GfDF4bRn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kPaHjZFD
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wVc23717025
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zQQmVhv+kzuoV/3wI6+2SQdGx9hm3pY3alCduLOYJsw=; b=GfDF4bRniBmoJGta
	ZvOSUYf2qdPZ/aVWKN7CyLz93HCP8yROKLbKur4uf8O1GBECQxDBJ7AGoFSAEPRh
	qibeL9PGZVtzLkLM8RgIOIFDVar+viOd5ROJWOjlSSdIudeBHoqvc76KN8GAfZwo
	PgUXLgsaozH29zLxyPLWZUiqq1OPR1dgot1udMQXA3uu/RmjdQ0N23OtWqvxJRZM
	/YIdVC7DnL5R/s1Bo8UPtLLnDRJzZSwSZzg1NYVlmJU26ZcUsLNEBuK98sTtw2b7
	0XNhP2QvG6UGYoLjcykYppXJxHewbtMl+7Kr8OQWh63QBmHyaH/N2cgK8nodcbG+
	cgHpRA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk20m6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53661e036a2so37978061cf.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655925; x=1795260725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zQQmVhv+kzuoV/3wI6+2SQdGx9hm3pY3alCduLOYJsw=;
        b=kPaHjZFDLv7FTF5FsKdX9n424HD+UQQHyNjgcRfNGUjSyCSFWH7KzVDq1o5tHWZJm+
         9bQmvTfIwbPCp2j77USdoKJy0IPq8ImDRIvbclDuS83EK4oBs+vet0mi3ZBUlUVDOIB5
         9jOKcZkL1Ko47q4dN1hhmU5CbLXro9vrWJow9wIWef8qxeJnjjK3LPrTN7yLiMt402Tz
         WoJ15uwb+ApXMMgmXt7812J+9pwI0IkuC1jBYdIO1oe6ihpojaMQ8LLBuPdvcS2RKY6Q
         V2amE4UvbPX9Z0mrSY41kvBNbrREDwLM60b7C0VON3tqEL+2ouDpv4XITa/t4G3dRHVH
         oypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655925; x=1795260725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQQmVhv+kzuoV/3wI6+2SQdGx9hm3pY3alCduLOYJsw=;
        b=JZ3ccGwprFPI/TsAwq9a54PuwKrtLLtyrQwJZGG4SGCHMUFYrV5u2tGCw3oaijkA3E
         e0xgLSdemhpQxide6ac2q/5WGijD7dIR2XmEAx9aX+fdMNPQ6HGJb2/+hHgB9uuNi4QQ
         b1tgRcOR6tms9z622BsoIdjI7QYvClx9Rq+GyMFcUiXw02oyFNWzxDyQt6RFEf3dT8mj
         QcVG562NM+4lGeEtN1j53Vo3HJdzg4W0pFoGVui7dYoThIDz9NrqWKRg3RlYmi1k4bX7
         bven+BBaoi0QbLImPbwIJouBRXJoSCkx6wlVNab2+H2shUBDmBaJiHygUfaxCnCpk0YI
         rn0Q==
X-Forwarded-Encrypted: i=1; AL+hErECX6LOrhN2K7hwPubFGr5PNccW8sgHhY1jSV11/bA21KyD2rqFTUDHHqqu6JLLLz5P/vu3WWBkMb0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/S170jVeEJVgY5mQLmmeZPXiHsaPsld8lcTra/zDSP5FENC+i4
	9le8d+lXrhzXLH6lfVsGv1cIOZGlQiZg22+LcWmmv1dL78VStiNrWj6+fU7d/u16nElh1a68pbk
	uqF2em+/fGszv0jvNxvjHBzyGpg7w4P9j6Zqh5d8ENIO7spVFD9obvOll4yTYPg8=
X-Gm-Gg: AYBFou2dMhh/4cwZVgA0puThHHMFGiurhDWRgTknuNYCT5sPcPrytFYuZtEpmbar/BX
	RcZtTSc+Q6w/RYt6sWxB4vFRmxIVGKNwUorDXGLdQBYlgfJo/WgkJqOa+hLl6/6pOzducjZCc2v
	mtyiTfXPdQf/UQJg8rl/UqNL6NcjwiIznrRgPyM9/JTVaFnOnhRJzoG7qbz92HO2UznYlSkeDvi
	zd5GO3vLNHKT1Tng2nW+kakyoJUnQk22wV+J1fatsXn54ozgqCeBK9Mxj++7POBqg9+Bv+XJ6a2
	mxQdr7ky7fuuvFYFOCYPocc72z9oJDSYiM6Dves/DCfbrySsTwHXEYXBxcPelSukCQgADgcPftu
	8BBDzTJJUNBOcSIoO4N4iUH9Cc1xs1DD/Z0lrJS1GiDsEz1JabPFNhr1K7z8tp08D3Ec/8xCwjN
	NqIh/C3dNns/nxa/KUYv8djKOuFa4na6248dYG80lA
X-Received: by 2002:a05:622a:4185:b0:55c:66f0:5bfe with SMTP id d75a77b69052e-55c66f05fefmr24047981cf.22.1794655924728;
        Sat, 14 Nov 2026 03:32:04 -0800 (PST)
X-Received: by 2002:a05:622a:4185:b0:55c:66f0:5bfe with SMTP id d75a77b69052e-55c66f05fefmr24047421cf.22.1794655924162;
        Sat, 14 Nov 2026 03:32:04 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:32:03 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:32 +0800
Subject: [PATCH v7 15/23] arm64: dts: qcom: sm8750: Add CCI definitions
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-15-8ff2a11835f6@oss.qualcomm.com>
References: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
In-Reply-To: <20261114-add-support-for-camss-on-sm8750-v7-0-8ff2a11835f6@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=7530;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=naOrccvepD7GWw2rHiX1+vICpFHGnqZKYg6wsoLbfpg=;
 b=rXus8NvuZiTv/m5iks9SVfNKqwxXWGTqCo8s/sNCrjTKECXaflXLXf5c4cKCWeTQhA/Jd7UxJ
 CnuPhqrnsXmBqS40XEdEZlsEkrmptIZi9+e6ItjuPFVuQw9K61PU2rR
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: Rfe2Rh1-HR51-z_KQ76KAVmtNuslCaCQ
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af846b5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=qxfSyLteW3qA2b6KDJoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX2g82tbTnupWD
 zWxzQSt1XnnF/XY44kl6UUNlkxKmrQB1I3Xxg5OAApbxIG+KzvRtBmRS8p3or8UUEg+ZRraiKdc
 FilgXn8CL6VPcYK4nbCk2u/B2/xK7qDqODKlTMQqYHd4QJVlJZqJiLnEV86W+Q1YNhxL4SBCN93
 lBCKISZmKXTb2GEEL4VWhhmkR+O0/4zIQYM3sl2R0rMsnzBgTw7lvbxp8zfjdcAYiz60Vb8NkmB
 Zh+vDwqTJo4Wmsa00SN+Mzb+asQch3JJ0dZmIspnDxN1MYTGU88ttDA56LTQJTEptqZHKm14OOe
 i7wdBayKOE1KebCCFl/e2a5r1F5cqkB2j5m+sbMZ2+lwhaQWnU9WJlgWrIABso75je/Yzp7RIkl
 mnegY1jhk7UQTw0EjpSoKnrh1tGUhgvf+TkIjc7pAmm/xvXOMXp/kXsoxk7o/7rB9nUtjgsh5Kp
 9fOekEJvrjwsieT2k8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXw0ArTeltsR7Y
 X+CEHJRW0m+lIphBx9eLeTR5etQFXGpBGYmDJRXGNm4YYWSZv+rAjk0F4BagCeV4G4pf1llpm+E
 bJJo0KkKA8V47Sq9LO6oD5Ah5OGqgKc=
X-Proofpoint-GUID: Rfe2Rh1-HR51-z_KQ76KAVmtNuslCaCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Qualcomm SM8750 SoC has three Camera Control Interface (CCI). Each
controller contains two I2C hosts.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 282 +++++++++++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index e91f7f8377c0c37cd54e5e91585ef58a4f8a65a0..b1fe1c2f5ae9c5b6107729fbdf31c2577ee3ebd3 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -3496,6 +3496,96 @@ camss_csiphy5_in_port: port@5 {
 			};
 		};
 
+		cci0: cci@ac7b000 {
+			compatible = "qcom,sm8750-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x0ac7b000 0x0 0x1000>;
+			interrupts = <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
+			clocks = <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_0_CLK>;
+			clock-names = "ahb", "cci";
+			pinctrl-0 = <&cci0_0_default &cci0_1_default>;
+			pinctrl-1 = <&cci0_0_sleep &cci0_1_sleep>;
+			pinctrl-names = "default", "sleep";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cci0_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci0_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci1: cci@ac7c000 {
+			compatible = "qcom,sm8750-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x0ac7c000 0x0 0x1000>;
+			interrupts = <GIC_SPI 427 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
+			clocks = <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_1_CLK>;
+			clock-names = "ahb", "cci";
+			pinctrl-0 = <&cci1_0_default &cci1_1_default>;
+			pinctrl-1 = <&cci1_0_sleep &cci1_1_sleep>;
+			pinctrl-names = "default", "sleep";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cci1_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci1_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
+		cci2: cci@ac7d000 {
+			compatible = "qcom,sm8750-cci", "qcom,msm8996-cci";
+			reg = <0x0 0x0ac7d000 0x0 0x1000>;
+			interrupts = <GIC_SPI 428 IRQ_TYPE_EDGE_RISING>;
+			power-domains = <&camcc CAM_CC_TITAN_TOP_GDSC>;
+			clocks = <&camcc CAM_CC_CAM_TOP_AHB_CLK>,
+				 <&camcc CAM_CC_CCI_2_CLK>;
+			clock-names = "ahb", "cci";
+			pinctrl-0 = <&cci2_0_default &cci2_1_default>;
+			pinctrl-1 = <&cci2_0_sleep &cci2_1_sleep>;
+			pinctrl-names = "default", "sleep";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cci2_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci2_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <1000000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		csiphy0: phy@ada9000 {
 			compatible = "qcom,sm8750-csi2-phy";
 			reg = <0x0 0x0ada9000 0x0 0x2000>;
@@ -4296,6 +4386,198 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 216>;
 			wakeup-parent = <&pdc>;
 
+			cci0_0_default: cci0-0-default-state {
+				sda-pins {
+					pins = "gpio113";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio114";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci0_0_sleep: cci0-0-sleep-state {
+				sda-pins {
+					pins = "gpio113";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio114";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci0_1_default: cci0-1-default-state {
+				sda-pins {
+					pins = "gpio115";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio116";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci0_1_sleep: cci0-1-sleep-state {
+				sda-pins {
+					pins = "gpio115";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio116";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci1_0_default: cci1-0-default-state {
+				sda-pins {
+					pins = "gpio117";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio118";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci1_0_sleep: cci1-0-sleep-state {
+				sda-pins {
+					pins = "gpio117";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio118";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci1_1_default: cci1-1-default-state {
+				sda-pins {
+					pins = "gpio111";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio164";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci1_1_sleep: cci1-1-sleep-state {
+				sda-pins {
+					pins = "gpio111";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio164";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci2_0_default: cci2-0-default-state {
+				sda-pins {
+					pins = "gpio112";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio153";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci2_0_sleep: cci2-0-sleep-state {
+				sda-pins {
+					pins = "gpio112";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio153";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
+			cci2_1_default: cci2-1-default-state {
+				sda-pins {
+					pins = "gpio119";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+
+				scl-pins {
+					pins = "gpio120";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-up;
+				};
+			};
+
+			cci2_1_sleep: cci2-1-sleep-state {
+				sda-pins {
+					pins = "gpio119";
+					function = "cci_i2c_sda";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+
+				scl-pins {
+					pins = "gpio120";
+					function = "cci_i2c_scl";
+					drive-strength = <2>;
+					bias-pull-down;
+				};
+			};
+
 			hub_i2c0_data_clk: hub-i2c0-data-clk-state {
 				/* SDA, SCL */
 				pins = "gpio64", "gpio65";

-- 
2.34.1

