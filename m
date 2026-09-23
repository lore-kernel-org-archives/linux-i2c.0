Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF64499F0F
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161490; cv=none; b=fd4XYXe6rWu3urT51dkDCRutOqxYwPuNdsolDFXalldji9zacCxVJT1oFYhzqNErdGinziaKRrZgy3szWyw6fiWmk79J9AMV886c+7kUstBy8QclocXgr9n8x89fWhT8Ly17I+sRhhAoKqhXYZxr7lKI0V92FeZpuJXl8i/cLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161490; c=relaxed/simple;
	bh=4ydu2ccoL7r4dmhIwMdua1R5h3XcqKfINUhETugo8AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spbwYKbqJvop+rtEtHTA40dVjkR2DplWPH0P2Wbr+FwiqkiTClxWQGdvVQmLmItL1QAethmZNIrTA393nut4ZX7uRA5SstdfEe9bSdYhb3p3RzusVCw0I/8bkD5KJ2yCcN9n3OwodxPs5cBVRLmzn8BHGcSPKR2WF1GIYnJqb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iC+hjRuc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eORN7qMT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iC+hjRuc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eORN7qMT"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NA2mQG3087171
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C3HtBGWpPVuucMugGw82PT4fND5zK19Dku+NV3m9Xik=; b=iC+hjRucKRqaHWoX
	cvJTMHAEiu4LoU5IGldYmRXjTt9wEoL1CjXPk0r9ziRLbHhmWiPKBk8WEFZmaRQ+
	0isthONNDsOLbriT5sfBp8614zDVsdUFSIjlJQfatr6ZQQwwkq3o+1gW2aC1I0ge
	lSoUrcD0OC9RL0VJF6Jbfk+WxZhwziIaaDOxgIvVjya41n4L7BJQGjf3crP422uA
	2lWgwA2CI2s19UJSpac50MNR+oulI8UQCGIhIxE0+9mDR5DwOIwGVaB3kAsNPDMW
	4VFXlU9tDsfkSsvagMiTHyzUmStR/JyeLknurP26GoNNDjI2Ei1j5tTbHM/CWb7I
	e2rxlQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8f72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 11:04:41 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14373747468so1071495c88.1
        for <linux-i2c@vger.kernel.org>; Wed, 23 Sep 2026 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790161481; x=1790766281; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C3HtBGWpPVuucMugGw82PT4fND5zK19Dku+NV3m9Xik=;
        b=eORN7qMTzWYlrxe2k81Zk7QS3gtokSxvycWYgck8Nmo7vmoyScKU/+XBuQNb2aU//O
         O5STQ+MqKgfi8qy9CmRGsvMMa+MXOSjyeNMoVuj6PvA8dvpfF8jJwcrCNvPFiA+Kf48z
         O4ThqwIZDiCY/I3cjOxPkP/+qKEdvF8g1wabI0fJ3EuKNZ5X8bSUSrE13wIGJwawywnj
         NSUDZ77wrdHDPmtCZtcdJ921T4RbwFmlzmSqIYxEZgkTbjQaEpxWc0/wuC1f8togWCVn
         uenYFc+rz35X9p4hUL2IdxjDGRlrLB4ybx+8an556/yKrCzaur4eIciuYRXJhq7GQ6bZ
         uZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790161481; x=1790766281;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C3HtBGWpPVuucMugGw82PT4fND5zK19Dku+NV3m9Xik=;
        b=h5ODY9hKDr4x6wy24qIQE5Nh6FxeJhWMaNT2w2ry9ljtm5923m5kWblX4Y/udWWpuB
         WiRfZD2vegB9rZxfmDpwOLXzyX0Xc+wxg6zl0XBZvChzeNbGyMuT3nadt5vYR0bwTwxf
         cjjCDdkj6zlWwg4rv+TAnoYwmzHfuMOrWp7BsXgHGHlRfoHpORDjQL0BXQfUHFlNSXIJ
         IWaDD+2Y+B9Vum+4bY+dSs5H4GtLExf3tSram+xdKuzHaisysGP0er6DZyAb4KwLLEzl
         ZzNFagUQuyRX4gM/Fn1iEaEiuWvxi8FPCAOgD7YaLqsyRbYMGQoITS7Sjv3lcn3BSA+t
         yLNg==
X-Forwarded-Encrypted: i=1; AKwUvBwZJGmCbnkZyA8fVQquiZF5jf0w1QpnFjsL4IpGeFX0Nt3t8fV1rcIPxK9DOSPcaxv7FmV8eTKnrYw=@vger.kernel.org
X-Gm-Message-State: AFuF++nLL+lMdCwvI3NKMv6JNNxiCEApUbGEn7hAdAmaziYPzVHRXoeZ
	DMnpxVc8KZOdFtu4UKVsG3/ZVoSw7ucUNnixkaaGcPy97xUHSgbZ1JCRQ/lKJP2dkjQAogY6gik
	pmOZfdHKd8tC7uVNEXiG4mTi7Gy+Wm9sLcNZZfCjuFAK4zgJmxRS9SH/8GDJ/a/s=
X-Gm-Gg: AYBFou2YyiGgZUrzGID5NB0SoNd93D83LS+BBZ1vkp4AgWVl1GqAFW2dyoq9+aKtC7l
	UEK6t7LKLd6ia3EgdsgT5iAUtMcmqQun77fB3rtTR2SWFxs7+BwEFzSsjlj34+beg8JD0aR6kNL
	v/OlyM2EQOCGBDmc8KdU0Cg0yIXU1CGClnhRvsh4Q/3b3DB6FEvc8f+KifXCJ1RB9w4BB33se/3
	ebkFU1fMDgow7oerSeA0Tmu0ZdvWAwjzDFd8oH0i6mss25W/4ZPpSUmwzMDCdRZVsAa4LgfjdSC
	wKLFlKvvMx3IrIahQLLiWVZoyiES7bSaTWnPz2wzz5Fjn+Pp/XT6Wy4f/yhEzW28+dL7tVhfY3r
	1gC7YSl4FauClJsXT8fAEZU5GSfYYDg==
X-Received: by 2002:a05:701b:2714:b0:144:f44b:fa26 with SMTP id a92af1059eb24-144f91cb68emr2109011c88.30.1790161480446;
        Wed, 23 Sep 2026 04:04:40 -0700 (PDT)
X-Received: by 2002:a05:701b:2714:b0:144:f44b:fa26 with SMTP id a92af1059eb24-144f91cb68emr2108980c88.30.1790161479765;
        Wed, 23 Sep 2026 04:04:39 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e9625825asm5905377eec.13.2026.09.23.04.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 04:04:38 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 16:32:41 +0530
Subject: [PATCH RFC 10/15] arm64: dts: qcom: hawi-mtp: Enable camera
 subsystem for Hawi MTP
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-maili-camss-v1-10-cbbb42e534ef@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790161355; l=2682;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=V6exmN7k6wtdOoCYYQmAPRf23Vw79t137APmgsQGhOg=;
 b=L94jv+35gQv7GLk5poLrS5WPX8QqX7ygy1v5q0nUlk0ekJaN+3ASE1+kmvFyU3ggoIRuwGlbK
 b0RwcPbBxKCACpGfZWv5tQ+fJ3jmPzpTQ+3DxXHgEPqWG60au7zLOfz
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX6jxhq1/4WS27
 IguMWtvAckTId9QNWIsSKypDWdscNlk4BSVV9gjFYylN3GJKH9hbv0SV65fbcdVAkBNMXdgNcyg
 m+k6nA+7bqRcdhyvUm2Je/jsfbNHJEY=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3b249 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2OLIcDlHICjy9cVqpt0A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: mnTZNl6ZtpSa-2t7Iltx9YaJH-Kt64Oh
X-Proofpoint-ORIG-GUID: mnTZNl6ZtpSa-2t7Iltx9YaJH-Kt64Oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NCBTYWx0ZWRfX/nhYbBIRfLam
 3adlDud3rgXpLaPqAAtZ5E40VOTjiSHE5+G7joZzv5HT1mQwHK+7Ci9V2+kkrTu4kFImsvqCEMO
 p5IrwzjIAC47ehDgQjHIKZ9gviiE5OouG5tYBENfUCdU//RJ1iP5pkj6hXBIDykBA3xFLY7KuGw
 6aLpZSxslm81LmT6C+4sx+3Cy18OCu+isuSDb11yiTjhI4RfdEvxHBYux+1tMnfz7FXBtlS5NDg
 LxAbpO0OqUoIr4UOlXIG4g/OpRvd1d+j4IaT0oiuII13f1GHk/w+P3rMs6BRxzVktFpVPEv2L2G
 D/1+VG5Q3jnt1UK2JDAfZ477f+UxsC22U4fuYD3z8oB1u7qbNvTjUP8rqs7kG2gRq9c6MDczOJL
 900gm2pgOxzXGu2cdqaz0OyWNNH4UVKYNo7rEU2UchB35nnImPz7MA5Eh76YhwPhhEL19XDxw+u
 xeU70rpid2MGbfRgXAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230044

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Enable the camera subsystem on the Hawi MTP along with the S5KJN5 sensor
connected to CSIPHY2 through I2C0 CCI1. Add the camera master clock and
sensor reset pin states on the TLMM GPIOs.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index 7709582491f9d426886a6afced6d3706b629e620..183c0c7a7595703113cb709b0e9f39ea5dc339b1 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/media/video-interfaces.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
@@ -781,6 +782,60 @@ vreg_l7n_3p3: ldo7 {
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
+&cci0 {
+	status = "okay";
+};
+
+&cci0_i2c1 {
+	camera@10 {
+		compatible = "samsung,s5kjn5";
+		reg = <0x10>;
+		reset-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
+		pinctrl-0 = <&cam2_default &cam2_reset>;
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
+&csiphy2 {
+	vdda-0p9-supply = <&vreg_l1i_0p8>;
+	vdda-1p2-supply = <&vreg_l3d_1p2>;
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
 &pcie0 {
 	status = "okay";
 };
@@ -937,6 +992,13 @@ &tlmm {
 			       <119 2>, /* SoCCP */
 			       <144 2>; /* CXM UART */
 
+	cam2_reset: cam2-reset-state {
+		pins = "gpio3";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	key_vol_up_default: key-vol-up-default-state {
 		pins = "gpio101";
 		function = "gpio";

-- 
2.34.1

