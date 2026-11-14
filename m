Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655987;
	b=2BRnDvEw1TBq+JnRKZlAE6p8pVlfvbWOG7rMSoIgrM0zZDIdiFebzFjGU6PXOYhxCB0n
	 ERsZAVJmmDxnJX1OyxQQ6bWVi+5jRl9jIVmeUQerW73m22ndz5mCYjZWIjZQR7Grncl23
	 ECff1uhmSLrNUJ4IQIjiizW9qVn23/y4fJO3x399H2AVtaUGjl8Qjslmif7/FpIQDBqOu
	 vBqTeg5etMno2u/Y0i9F0fcLhyNfKqEgJtV3HXucIgUc5Md47A0zIr9cFQtMYweCnQOpP
	 flmYBwNiBeHvnLbS5lxpSqaI31T4Csmqmfxz9WhYEUMkwQy++MoYtLu31adqDPlos5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655987;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YL2RS/EwYR3+hEcQENBxnWZjthmJZRl0ABwUqhJFCt8=;
	b=U9HkVicaUyaoPynNnx/DV4VECA+38D+3+Vk/Fypz5czPFCWK/xAYqrwI0gpflKQiroDg
	 i49maTRhMw5lmcGrX76m9cdhRHi+ITiZs6vlxfzt+81jvMmXENP9RQlCoaq2D93CLvlfR
	 qPsw9+Fx8Qkr5qyzZ7wUUI5HW16IiYC/snrWZ8X/YvZ1rgl809cz0xarLFBnCN/EiIf57
	 UQsDexgw0dnlItW/HpdcFSKqG2dx2t+YmpamzXqwSC+sy+1zBLpwg4H97EBOcrpB9q4a+
	 KAiwkmw2nrweiMGW/8nQBr/dF9+S+xZ3vUllKiXhmwuhoaWGQDGliSYgnY257jrG4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TiRrdehl;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AzrKbtcj;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8004606A332
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8004606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TiRrdehl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AzrKbtcj
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9xiW33719433
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YL2RS/EwYR3+hEcQENBxnWZjthmJZRl0ABwUqhJFCt8=; b=TiRrdehl1Ylx9RcY
	6YIFYoGiEW2QVqG7BnkgFMNM9oJhm3vVlx8qvrgH15tRMURS6lbT6c3X3eukLsbu
	2BzvbzThDkxg5/tzX3NjvsmqtUtabJON9Ipl48fN9ltuNMogfZEhEJAVlsJUGyXu
	5rkTWZMc6XSHxqNrOkfJ0NwshHLOKq+Qkqoa+oRoRPp5czOhK5c0niHWflDvgcSt
	ibr84UDz4qiTHiFzeUYrB2yLONDQHbbyA8wBW9pASQKl+g46bZ+NjnUjYvZzikEn
	YcoUkfVc8d8VceZ+su2Qf2wybFTpSL3PcBFPzezUe1I6EydVKfKs4b1R2Isn3hGc
	ozUoHw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk20ma6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:33:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91eb3a63064so41088426d6.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655984; x=1795260784; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YL2RS/EwYR3+hEcQENBxnWZjthmJZRl0ABwUqhJFCt8=;
        b=AzrKbtcjNI63iAsiJhoNXQwdAFdQt4FqV3RhcnaiMy7FZmAEqq19p/CsfSEobaQbux
         mG5tbo1eGZsLE09zf69XzDqT0U1xJxFOLV6cGHG2FUuH8GJhnJVW7rGtarwhyF8jb91x
         bQJsblUIZxrTB4jBvABEgex7QXkpcHC/3OelI4XPlD+frFCA5sAsBTkUX8+30py6Ssma
         sVJQgjR8o8kuClYYA80+59RAlDmiwcjjW1AanB//dVeBecKgtv3tH38hlx9LlolpSKD/
         FQC0Yj0AS1USt1SmSXdavfr5bKQ3sf/ypUbQXi/yqHieh/a3i9Jg29dxNDtTznySVqy+
         hzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655984; x=1795260784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YL2RS/EwYR3+hEcQENBxnWZjthmJZRl0ABwUqhJFCt8=;
        b=yt4d4ZPvx398WntLr2K8Tdi0bzmEF5gSiunS23Xw+nGYcVPPijh11uiUliVId5LG+y
         OOrLL18fHuedA16+f7zGYC7HEGcvlg9y8KODWMlgxmCCinzij6mdJgYvzbz1b8nDM1Hm
         PWCYdW0Rj2dWMpHGI/ViZNDcBGjZdDtgcMW2paXvasU6i9UnnZvaItJr9WST3VhgJJXv
         E3pYyH+j8bd1fykeV1vRV/mDjg2qdKRQ8ru+LnJvyvafYu875bkfc9Jo9oHJ7o9KTXoD
         2RwzrCaPJKwT0hqlP48U8PDpnHr2eZ1Cy4un6RIwT/0gZOl5VgJDno/TBtetao/+kqp8
         3u1w==
X-Forwarded-Encrypted: i=1; AL+hErGfSy6gWA7gXOWokkBJdWcxfiff3PzJjMfNkTM1TIsoySqIvt5SOHCHN87gO8abtO+n3Hw8jes6VZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SCtrMIvd7jHOKTRG6Kt8Z9GnL11H94DfHIzHRHe5R2wRyN5zS
	X2zeD9NRoysrdrEvGXOkqQxcGNfVAPY92tiFjXtVLA7y8Uw/tokiI9RjFBEz+nNmKip+ytp7hrf
	GV4E35Hc6dXlzXM6DHJkzrP/NpAQeL//hkC34APimbd9Hzp6LbPE835XVqYfDiFI=
X-Gm-Gg: AYBFou3DTqoilHzTj4GMZotsAI4U18gKoMymSIls49vWcOP8Cw38eErIPX5J3ZGjZUZ
	wQuxvzR/DKAFqjuULpVWvtdB6HjCgLQvH5kolKjgzbbhIowyYgTUClCSWKefwpoXQiDi2/BuV0Y
	iDCh/8hGYR6cfdZzx/pLpUwiPtMVXnxDo+8CP5LMP4GcLqGQoejJEeZFRzLqwtlIqrBH4XvJWOC
	dUyXcCKZqAaNSx6Hkhtum1gT99h/eJoTNQpTu8Uz0+pNX23LOnNgabpuI7vY18V257eFmLwQqKy
	e8b6tyWZnaTrESokrJGDoLQ3qna+zqYgrrkf5yQ9kS98H+mkh4rpXHkCOsr4GJVhwZ/WWyhmAg3
	+o22+BitCsg2KXkxyHH0u3F8ngGS1WgLVA3lxkK6TKGunfy3cXVLyjTgEPzCPJT5ElwkX46D/ul
	3SwLj8FrG43LvQdK2ukKYvognFiCFyWY4xku/ioZlS
X-Received: by 2002:a05:6214:840d:b0:91f:3063:6b2f with SMTP id 6a1803df08f44-91f30636b51mr36968706d6.17.1794655984234;
        Sat, 14 Nov 2026 03:33:04 -0800 (PST)
X-Received: by 2002:a05:6214:840d:b0:91f:3063:6b2f with SMTP id 6a1803df08f44-91f30636b51mr36968476d6.17.1794655983761;
        Sat, 14 Nov 2026 03:33:03 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:33:03 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:39 +0800
Subject: [PATCH v7 22/23] arm64: dts: qcom: eliza-mtp: Enable rear camera
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-22-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=2795;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=PKU2g+Gn2vrHlq+OzzzbhEEMcvvxoyv/Dn/4YmbMkgI=;
 b=2qvCfPYV852R9Ur2umoTPGPZuJY4yAANvplFo8GtuVfDjHfTDbxh2tPABEDx/HzDAJfOd8fSU
 MGwAXRdCf7yCYhfMK3HpmRDfYxqVjRhoA3hSZSB8yJNmnaA8Ej+/Mb3
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-ORIG-GUID: Ak_ydYA4i142_m9aDBFx6lNjTdq9gavA
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af846f0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=2OLIcDlHICjy9cVqpt0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX+I5z2cgOJIo9
 ADsomOTRXUKw4ObtYtUTr5/ogRhbWaKnLnlHkRYXowD7j4p227IZUAyEs86o6MBaeAJmNpeMT9V
 v5lMJJwDeNBtxqaQdh9coalArVlioJWsrUuyWmuP4r2rP5VyyNShNg9FMpAvWfTXMJ5fpmFJzZA
 fulrgHF8k7He7UoHvB+5tsXV3yWjSSxoa0VdBW3z1+oTQwOc4YX2ZBcvVKcUkOYkyMf7ds0PO8P
 PGTtPtXBDqGGQVYNC+kIHoKJfAfrttWirepwfAoQDzQytUA1FgeR8+4ppWcPvwKWSGGqsnClI+/
 xlu7KqV8o9uYGc1757FVL1ljLF+imsqTgjS54oNqF92fi4jKHWBphttsvoxLH5M6LwhX4pIloGP
 Qw5ssD30A7Q7wAp0khr5OS0yh1qu6C55N3uVKYdCWW4DIfFQOgjcVhPuK08XUh8NXB+bnEB2SEf
 k3HUXg1EOazKteZM08A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX0+EptWsROgXW
 7ToGdd9CJKg4MQkSN8eqGXXSEB5A0EDHtexr+eAyA9r/qzrxonDfJhU8bfMpYEu5nehk8cK6k9N
 Tinvrv4R8hJONnFMeJxd6FtLr6gUltI=
X-Proofpoint-GUID: Ak_ydYA4i142_m9aDBFx6lNjTdq9gavA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

Enable the rear camera on the Eliza MTP: a Samsung S5KJN1 on CCI1 I2C
bus 0, connected to CSIPHY2 over four data lanes. The sensor takes MCLK2
at 24 MHz, is powered from the PM8010 regulators added in the previous
patch and is reset through GPIO125.

Also enable CAMSS, CSIPHY2 and CCI1.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts | 72 ++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index af7450fa2020d29a4ce98eb958dabd0cd8c61860..cd14b44cf0aef33a7939075949916d054cd77659 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/media/video-interfaces.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "eliza.dtsi"
@@ -538,6 +539,70 @@ vreg_l7n: ldo7 {
 	};
 };
 
+&camss {
+	status = "okay";
+};
+
+&camss_csiphy2_in_port {
+	camss_csiphy2_inep: endpoint {
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&csiphy2_out_ep>;
+	};
+};
+
+&cci1 {
+	status = "okay";
+};
+
+&cci1_i2c0 {
+	camera@56 {
+		compatible = "samsung,s5kjn1";
+		reg = <0x56>;
+
+		reset-gpios = <&tlmm 125 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam_mclk2_default &cam2_reset_default>;
+		pinctrl-names = "default";
+
+		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
+		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK2_CLK>;
+		assigned-clock-rates = <24000000>;
+
+		vdda-supply = <&vreg_l4m>;
+		vddd-supply = <&vreg_l2m>;
+		vddio-supply = <&vreg_l5n>;
+
+		port {
+			s5kjn1_out_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <700000000>;
+				remote-endpoint = <&csiphy2_in_ep>;
+			};
+		};
+	};
+};
+
+&csiphy2 {
+	vdda-0p9-supply = <&vreg_l2b>;
+	vdda-1p2-supply = <&vreg_l4b>;
+
+	status = "okay";
+};
+
+&csiphy2_in_port {
+	csiphy2_in_ep: endpoint {
+		bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+		clock-lanes = <0>;
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&s5kjn1_out_ep>;
+	};
+};
+
+&csiphy2_out_port {
+	csiphy2_out_ep: endpoint {
+		remote-endpoint = <&camss_csiphy2_inep>;
+	};
+};
+
 &gpu {
 	status = "okay";
 };
@@ -657,6 +722,13 @@ &tlmm {
 			       <111 2>,  /* WCN UART1 */
 			       <118 1>;  /* NFC Secure I/O */
 
+	cam2_reset_default: cam2-reset-default-state {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	disp0_reset_n_active: disp0-reset-n-active-state {
 		pins = "gpio12";
 		function = "gpio";

-- 
2.34.1

