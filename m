Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655944;
	b=f5D91BBQoW+6+6Br0JOg0hLRFM69OCkGJ1BR7FLYqbJuBGE0ClDfpxBYTDVrcfkTqAcg
	 aqB89iOZVvUOMLKH2cP61RWASf1MSa4FKDuLoT8GRdY3017NMuqlVBH05zPBWu9brxVva
	 E+73FxuftmSgnNOID5Uq/y3GPx5uy13b2CBRQ7B40sn7zdrlk9qfJ46TBdtjnVMfh8ula
	 6wk+z1SiNASgFzg/VSFTFqXNqhyZqT6bWZ+QkAJ9X5VgY4xSJ1AODrJ+TGDnHW55ntXpq
	 2qYnPXxAivVG5Qu6IrPhbE/Sjf3HNoZQq3+B7coPH648Ecz+FdFB33Gyj+e3OgXjRPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iOVns0On8xHRpLBncT/ucc3Ts++fKWZVvwDmwZRoZmY=;
	b=GMonB13gasOVSJPQDvEpjrLd5Vof1yb3IWauqKAwV6WzNK+Hkr1WFsdJms0oe0EwmEuh
	 h4CpbTiuFNGxf70t5Pa29l1j60HTIokBKq8kHBozGx9h1O7ClQ1fmblHVtMI5ql1gKDFf
	 Yx1/8Bt0SZyiuPvQ8kzfmQST1gdJfGj5OCeUDhEEWKWOEHz5ToIFcewe3oVZnreTX5WU+
	 ZYjFdD4a45GJbDpyNLGFtoGCvoyGL0MGHJhcUAcp6d0h+KaFi/ni5X11E+RCdFSb5kAxx
	 PSzYK+6hgKhB8wajRpNvmN7rxIAqiAKh3I2U4/m59Y9VQ9saRIkD69DOUKE/uNOUeJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A9MZNlLw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmU2O7hv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F517606A333
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F517606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=A9MZNlLw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TmU2O7hv
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9w8mW2054526
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iOVns0On8xHRpLBncT/ucc3Ts++fKWZVvwDmwZRoZmY=; b=A9MZNlLw1UQE6aUU
	yW0GWR8ycdBsliUATMPJ1369rv/R889JETKb94RjsiUW/bBYnTKl+qkhKZwr68w+
	ZKbAYQuaJMeCRQb2g6PQ8TMu4P04cn+hllJfMItruIE8cX+86V3H9gfSoBFk0bRa
	VL4v3Bo+3wcAfjVMkuC8/6Qtv2waq0zu4e/3+IL9yFjQzdNVViEY5Sj5Oe7KqnbK
	iOZ5JfhhZkEaYa+xVeHspdy4T7mbmuEE3BNgTuwOvODFfhZYOMQV3zdspkKGhxcq
	SVoXT8PDm+CS20PYctRMIE/lrKiWqcRyYRMmJaLWCg3IqSN1xOJhHMMqSLiAxDS1
	ezFIcA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmc8kvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91f0f4c70cdso7148026d6.3
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655942; x=1795260742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iOVns0On8xHRpLBncT/ucc3Ts++fKWZVvwDmwZRoZmY=;
        b=TmU2O7hvMIBQ6JNuayS7oKMQTvB7s1PslQhsCKwu29WK3yIGaJKHmKpLBv6kd2pVXe
         SC/hut7xTRp1sv+sPKk1t3Q1GRueYke5kFsh1CY0x4wKar3gX4inKRAoaZwR6T+Rwr7q
         Yd0S+htLARETex0vY78bqRFLDgt7vkYkWOyfypQdpQH/dNDhw6fY1LFG4/TCSVlec0Vy
         Td/jlkAxRa+ZCH/xes00uQEf2gm6Fe1oLB0pVZVRj1ZF/a4oXnWZsb+456CiPCW/XQgN
         qYqlqtFtZf7qNsmF8q9TFFkwlcl5ldgAKlyf4B+4WRU9MDLrvqiKSIin6nSYkZvUVtK3
         Ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655942; x=1795260742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iOVns0On8xHRpLBncT/ucc3Ts++fKWZVvwDmwZRoZmY=;
        b=xrhdabMgy0c9+5/HcoXl6UE0Z3zXtJKPCgM23GMts6jTKE+b2OwZtpw6t41tRdytfs
         rpAV7l7TnPDPtAJ6+spbu2pXWyXgQxROBPah8reVQDcrPnpgLdGBBjpshNkw9pYYRzRd
         kzhvLXEBdBX/OIeWQ68ujHNogorSjG5Ucj2KAtMaqywbsXviv0mQ0CWkOhV86PshZsUM
         78xn/mB+RCtysbdW8LvBoN9kUzIuSYdEn8RKrfF2d5U+2+Hf6+xLIR7y23wc6YloTjr2
         96YJAGS8pu14tt2/4YG12G+0EYv3JOdnu0DmS4VTamU+g1kui9BYZ0sTyDL0xBAPaEcj
         aFOw==
X-Forwarded-Encrypted: i=1; AL+hErH6D8+yTv/Exa5wM7TAiiSvHJfkZ/TAYXmSlFa/Og1v9T/6jCpMCGZ0NvL0SLd1j/Q89DyVQZwiCJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4jV2nw4II5565Xn7GnMW6sKkWV8CeERMeijXO7JcNINV+BdtE
	wTe8eTocJsIGExLPpgJveP9QXlACGtj9zXjxhM1Rni7VBYUjVvFphkcy+MYmV3PHiguG6uGkB4C
	Lojm6ZLJcArikyuZJ0sJBkov8pXmEtaO3AfaszcCeMj78VEusDTfy//yWKni8W4M8BXWDvNVEzA
	==
X-Gm-Gg: AYBFou0+rU3eh8kPv+EZlggRfWEQ/l7SZGixSaTMz5U+QRRmKlCFApes26SsFYKcqhY
	ECNYKaySQ06TMG1XZYnhOqwo+F7H8mOT1qKmEwgoUH5GlOEpjnfP7DUqBDKmjsYseMgr4w576Kr
	LIdmf1jC4nBhZBBIBIYt46AanjYTGRdh2iQAdSo4co9hFaMbiEz0dUQal5CYjpAsVSL2DDFwg73
	WMtoC4hjm4aZh+KYGCGHoubuF7KwuHY0rxS88481QYn9WpWxjAr/2CbXqLB7edVdlMBHbViXuft
	CU6fFl0wpKe68Z+CVBcpeVdd7W7ND579OSwez+h8ZO6Y4iNuVIWKkOkinXG9cOBSTQcnB2dLiUc
	oCURZqMUXOswRaUK9Fl3kU3Aq+c9gXcX3N0QmrbEurkfenkeDy4PDYoASoFnfvXjBBtwgMrui5g
	mmHcxHGya/McsgqaLGbdPDu3dGsvzHtnqvISKVUM8Y
X-Received: by 2002:a05:6214:2c11:b0:91e:d612:a120 with SMTP id 6a1803df08f44-91f23f1757cmr84911176d6.0.1794655941837;
        Sat, 14 Nov 2026 03:32:21 -0800 (PST)
X-Received: by 2002:a05:6214:2c11:b0:91e:d612:a120 with SMTP id 6a1803df08f44-91f23f1757cmr84910806d6.0.1794655941400;
        Sat, 14 Nov 2026 03:32:21 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:32:20 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:34 +0800
Subject: [PATCH v7 17/23] arm64: dts: qcom: sm8750-qrd: Enable S5KJN1
 camera sensor
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-17-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=2708;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=WcXr8K05MCivYBH7t55zgxmqvzswrk2NVxaQje+wUUE=;
 b=83dZyLdKRsTC9xpzwO8aD0RlXWspmyBIeBp19Rd28ihT0G+7H20crZ0mR5issY+uMIh84StPX
 5Gnt+iHD10iDNVT5nZBG3xVbirzR7Dn6giWZ3plWGxANoYXGtpVoPG0
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfXyoQigdmozIY6
 IMBBlrgIxCbUzeC9DbJ/zWK3LtdWx2HKyFXac+1naVmBeYYveFhBHloUZAYMh4ZmCoG9xDtzQvF
 Me8WNrMX/fMW7LkA1P8Yk32grG/V3YU=
X-Proofpoint-ORIG-GUID: hBqaxucv3z3u2NKB5JSoRgDTa1Y37rKx
X-Proofpoint-GUID: hBqaxucv3z3u2NKB5JSoRgDTa1Y37rKx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX5durT2kwinp2
 bQ0QIhqojT+2obLIuj+Bpb9HGvf7/H8F2ABejPhAAurFj6WzZ8QZ/ra6WjujRJBWCAO2KvrcFfj
 0HeJU+hk2WtfRdJ6qizWaozhqkC7ng9Npq1BQOyICQW2ucY82ev7KobxHv4W9R7+RmbkcLt3QIQ
 ONZzeBGkzPwrPuHS5y0z2s2gyQAWIP39vYOJpzmjeJnismZ8fKFXu4A9u10ksoxGrFoU6BUhuZi
 Av1LSyp0Fx4J/OHnaLxxhWm/oI1X3SZKnUmz+lny7eUx9wUm+NX1rhwSM8U7fak1NwdLYYdmPD8
 0C52L5961RwroFD7tbygi6BJ1NW1crxLqcYndD55kj9TSSZNaoLQ8jueWmXVdECoManTr7jk2Bs
 x9KxbzvTmNso/cg7Lc8Gq+pgaDDX//Z8m/wvy6sPaQL86nUjPhPqzuml8NOxOEKLK2sN2SxOOGn
 ZARTHegvyg0JFIcLn4A==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6af846c6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=2P3Xd4wR9g5NvcxdGpwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

Enable CAMSS, CCI1 and CSIPHY3 on the SM8750 QRD board. The S5KJN1
camera sensor is connected to CCI1 I2C bus 0, uses MCLK3 at 24 MHz and
connects to CSIPHY3 over a 4-lane D-PHY link.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 72 +++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 75927e1f7b9ab0316781c64dbcc82d3394c414f6..c92a1f3c47bd5cbae26854614682c3bc7daa0398 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/media/video-interfaces.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8750.dtsi"
 #include "pm8010.dtsi"
@@ -858,6 +859,70 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&camss {
+	status = "okay";
+};
+
+&camss_csiphy3_in_port {
+	camss_csiphy3_inep: endpoint {
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&csiphy3_out_ep>;
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
+		reset-gpios = <&tlmm 109 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam_mclk3_default &cam3_reset_default>;
+		pinctrl-names = "default";
+
+		clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK3_CLK>;
+		assigned-clocks = <&cambistmclkcc CAM_BIST_MCLK_CC_MCLK3_CLK>;
+		assigned-clock-rates = <24000000>;
+
+		vdda-supply = <&vreg_l4m_2p8>;
+		vddd-supply = <&vreg_l2m_1p056>;
+		vddio-supply = <&vreg_l5m_1p8>;
+
+		port {
+			s5kjn1_out_ep: endpoint {
+				data-lanes = <1 2 3 4>;
+				link-frequencies = /bits/ 64 <700000000>;
+				remote-endpoint = <&csiphy3_in_ep>;
+			};
+		};
+	};
+};
+
+&csiphy3 {
+	vdda-0p9-supply = <&vreg_l1f_0p88>;
+	vdda-1p2-supply = <&vreg_l3g_1p2>;
+
+	status = "okay";
+};
+
+&csiphy3_in_port {
+	csiphy3_in_ep: endpoint {
+		bus-type = <MEDIA_BUS_TYPE_CSI2_DPHY>;
+		clock-lanes = <0>;
+		data-lanes = <1 2 3 4>;
+		remote-endpoint = <&s5kjn1_out_ep>;
+	};
+};
+
+&csiphy3_out_port {
+	csiphy3_out_ep: endpoint {
+		remote-endpoint = <&camss_csiphy3_inep>;
+	};
+};
+
 &gpu {
 	status = "okay";
 };
@@ -1081,6 +1146,13 @@ &tlmm {
 	/* reserved for secure world */
 	gpio-reserved-ranges = <36 4>, <74 1>;
 
+	cam3_reset_default: cam3-reset-default-state {
+		pins = "gpio109";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	sdc2_card_det_n: sd-card-det-n-state {
 		pins = "gpio55";
 		function = "gpio";

-- 
2.34.1

