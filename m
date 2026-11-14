Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655977;
	b=jWvgECSXykXU6avcJzy6PxEePDrEQ3+An9cOeTdMEkOQdVUyGDes9Wa+8sc4vImnZhfI
	 0vUajgR3ozn7U98vxlMIP6beVa1b7BuWaGAH4fy7IxP88mrIZR9ObWSQ5Vh3lY29QzYIE
	 fZ4jIEHA2Uv4XwXKjH34HpldECHUSeFWst0SLkuEPxKkf+DMGzDBj3PtQwRTfaO8Mq9eP
	 +Ie8xsrSZBP4jKwtjloPIqAza6/nnkrLxI3UuKERaqdO7oIGGi9dkuQQ4fB658hOdWAas
	 04KooCjka/ZBEC1DTEBhtJAFhTVmAmOG0fuhNWdz4tviRbD+LWsGIsPPEo1hL1dfj/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655977;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u4Oly2ccZ0M2EddE7iLjGix5zbXSWGoTjOlAUxiJPBQ=;
	b=acJIE9yQCM7KnV1CuDugOAoK778B/di+5XPAtegN7pk7NUmUrNN5Y1oI8LASdjSz0oUr
	 STZ1o2MjHP7E2ugu9qvalLlPWKdQpxE9wVPdlc1dMtpgBubPTirWqTMcIXyHTDgu5rpuj
	 Hf1sXE64Ml7hBMjR5jUTiOxKAKzaUrq9Tq3HZDJzHknHM0Lc4oEKZRBJFlnRHpb8wVJJF
	 EhGClaWeU+ThJ5I+8SGdFQ7JAWJh+sodFGXWPsuQkRT4wVTUtIfa2ro4EwHDlppaPyyC/
	 septlD0mucbZ7YjDDU0E3zkWjq2Lv5S7bFkFaqJ49+G2ZjobNAJAcdeyU8p8iMNWE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O76SxMxb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V6p4NkzA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC0606A329
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCC0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O76SxMxb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V6p4NkzA
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wCFG3649974
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4Oly2ccZ0M2EddE7iLjGix5zbXSWGoTjOlAUxiJPBQ=; b=O76SxMxbxeqlf+/s
	J5QM94qjLwegqGbaM40Cw7rgwsy57fIpr56y21gmRl9DNlFjO6/tNMNE6zDPs5VW
	zVajAGdTmtJR4WV6wAEev7xuWLHEMtATm9wf0D/sKSfo8EdjjhjfQYt+0bpXadHB
	iHsDnic3pLaNFyZuor4ev4l7so6IlKkz49BuZs22q3MxFLiEj9TTxVPswETOmKS2
	o3rQJFMSO0RM/uiwxhnDQH/CUyYMrZFRL0aOUoc0vnKsJa69M5dvzvQRYAy37wHl
	Pr+33+V5M6WeB/nBktPzS/Ow3nTxdIGkZcVMuPSfITkwCc5QVAJ36I+rIfaWzuHN
	ngsWlQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjrnuc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:32:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55cc3c32e15so2477081cf.1
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655976; x=1795260776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4Oly2ccZ0M2EddE7iLjGix5zbXSWGoTjOlAUxiJPBQ=;
        b=V6p4NkzAR77VuRzJMp+WfbDPEnA3B9a9PuooUvBGVR6VsTEFtbnW61oFNNWF2WEFAA
         orms+EkxFlKu1S4pNSfZCi5s3sykuToCpVopESdwIAx7AtXbN9C5sWGz5ylbKhVUvJfI
         sGv2JEt0nN8GLZvMQrHSSw4j400TVIujRE556NvNfpD7g94BPnVrMhjUjKkUgrQhARJV
         M1jLkX9ZovvfJbsJI9vWk3HJ1bVek6Ntq6EwFWguSbT3X8ycJtYZZBz02B3LOPvMIeQj
         TAdDoOxcYdeCADsWpO86+mYtOn1KaXHdhrKmC/QsPEv+uaatxwpPAxsfwMY/NtY3UR8I
         F8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655976; x=1795260776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4Oly2ccZ0M2EddE7iLjGix5zbXSWGoTjOlAUxiJPBQ=;
        b=xQSV9xphgFWe50RRfVCkBsI7N2D1tmiFKZfbKSjWzuhuFXh1Y5xMGuibK4q6v4TSe1
         uFj/rKF/R50n4AiBOYJ50ImE2M4foFXhnEtYd0kBwtel6MVtw93BBNatBMz1DwvlWjjH
         bknug4ADhzjQ6VG+TH6kUJlnm+s/FxUsAPlzua5u0gzYFayHKBfovmHql/P3fWDD6VTH
         w0I8JLdLjnsl2+iuWGMU5O/Pg8mDO73EO97W4HDzzeJCwoZvp6WXmFetOcYrZrMIntmf
         DnWQ7UTfVCLk4t3gUKttzNWfpEqx4UsMg2pCqXS/kiOYbTzXmy53XNU82QOmcBoBIgdc
         ugKw==
X-Forwarded-Encrypted: i=1; AL+hErEGTdizSMoLHB92l1HoRpMMZjUDl2F6fAf/FxC988RrtWwOU4re4MJzg9lO5NJ/mm0aB+K2mZrqkqc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rfsP3iQNdFkXJ/m2ayWdYi5P9nbpBdgrz3gCB6kW86MO3WtPy
	BT0DUIJBAGa46CspSjc5jma3/piWhpJuC14qZUEpbXf5kz2z8EQpXyxe8+Xspu+3y/3/awluoF5
	FS3E2ntWMtJvW0wzVOeG+NTcAQMu6S4Cb1ZI306j8Pbg8mNG3RgqgIlK+AW9aTB8=
X-Gm-Gg: AYBFou0GJK6UgZZqjZqjQxBzC2RFUCwJtKZQUoqqbYw4w60eUz0JM55PemhOcthkQjz
	r9g8xsG03og4gw2AUWP73MS0lM6T9WdRwwgmip2FMMRuj9LF1r3fmNUCWl5n/+qdkQrubfL3v7v
	9Sxu/hbf+N6kuxf8DjF9xc4d24KcxZ2pkg0abO2FkByVMcwvrAnr8+GdeNluasiDzBqLzRo0dVh
	2tbE4QDyQYRg69IgogCrTfiOlY6t0RGAZmOoy45Fk6drShQ/JhM/GIhIq8S/ps6OS15ipXJ1GX4
	LnG+cIlkxe6Cfibvq5Z/SUASFMWMoKHuRoLX9J+7edpsGs58+kPp/ZMv0DcxOloLt58SpWeFUdh
	hMEFQ2Y6pvsfAINZXzLiayl+9a7aAoeRxcvxgeBTWyBsZyf5NR2BG9vBTU2YUEHbU1fetrK62Sl
	XTeJ9JOZGy//b5pQ2Uuc4m9vXyYCFJR5LpvGidYz6T
X-Received: by 2002:ac8:5ad3:0:b0:536:3600:f0af with SMTP id d75a77b69052e-55ac4287a80mr83819841cf.7.1794655975635;
        Sat, 14 Nov 2026 03:32:55 -0800 (PST)
X-Received: by 2002:ac8:5ad3:0:b0:536:3600:f0af with SMTP id d75a77b69052e-55ac4287a80mr83819451cf.7.1794655975113;
        Sat, 14 Nov 2026 03:32:55 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:32:54 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:38 +0800
Subject: [PATCH v7 21/23] arm64: dts: qcom: eliza-mtp: Add PM8010 PMICs
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-21-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=6334;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=qEA/VOZEPJj9FtavWPFngGillqdti7IGX6O1SVnmft0=;
 b=kbxzQ1RziT+LGmz0Ob2zzYDFbcTHIesR5ElhBnfStyGUmFJukhp8flA+Wb/U16I6rVwR92MUq
 6B2Ut4Cu1vVAMopCz/TUd+3A6BK9sBSnBYOoZNcxME7KAFxLrl1JsUY
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX7IhwXiSXVUWA
 S044LoVLLDjliMgxNvBQmiYVCK8j8bqYTVfQW3q+poo3pfW2zE9OoSosASdfDrPt5ptCDGkWQAr
 V29W1JNby5mAcpMWRlNlu+TcfrklBDmko8/MLv9WtYo7oddFYj2M1hrnP3mfk/r8A71TYMa4Y0r
 FJyL04seoKBQysfCziPFwxalzu0dJuq8a9kRwWVKwzWctA75tcUsjURvOaNN38YwoYL21sQAk2E
 pdG5buSny+byUIJLxp95VisHIYKhbhccRjL1t1M6Qq30/jMWpaLXLjlaX+Y40zEy9S842VxSEOh
 TXSU9lG4r8Fjlv9ajxXS+uTRbNwzN9b8VdBz1LopBZtOZokLAYOZ7avygBj9BesdVSf3fLlawrh
 Qa7vm/JDeyQEnDjL8ritsOZkYdZI0eLnx5XBBWw25zM95fqdp1NhBoJyWy4XFHlrHeV+16DL8tt
 ZJYeky2866mbjtigUDw==
X-Proofpoint-ORIG-GUID: tS8CnKBiHeWO6DsOQSUu40FART3wlITl
X-Proofpoint-GUID: tS8CnKBiHeWO6DsOQSUu40FART3wlITl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX1Uey49R0/bWy
 fNgNl6CwCM/mcc4DTYdOSVo29XWM1LzuUNERiuH2nBRF+qG/L3i30NpMzFO9E+FgioxB28BeSkM
 mskkZiNiqPU8Yddc5QXAqDBviSYRqIE=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af846e8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=THGDsv6KT5CLo26r1dMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

The Eliza MTP carries two PM8010 PMICs (IDs "m" and "n") that supply the
camera rails. Add the pm8010-eliza.dtsi describing both PMICs and their
thermal zones, and instantiate their RPMh regulators on the MTP.

Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts     | 116 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8010-eliza.dtsi |  81 ++++++++++++++++++++
 2 files changed, 197 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index ee05192adcfb9f79cba59f11001b640a8572cc91..af7450fa2020d29a4ce98eb958dabd0cd8c61860 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -12,6 +12,7 @@
 
 #include "pm7550ba-eliza.dtsi"
 #include "pm7550-eliza.dtsi"
+#include "pm8010-eliza.dtsi"
 #include "pm8550vs-d-eliza.dtsi"
 #include "pm8550vs-g-eliza.dtsi"
 #include "pmr735d-eliza.dtsi"
@@ -420,6 +421,121 @@ vreg_l7k: ldo7 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
+
+	regulators-4 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+
+		vdd-l1-l2-supply = <&vreg_s2b>;
+		vdd-l3-l4-supply = <&vreg_bob>;
+		vdd-l5-supply = <&vreg_s1b>;
+		vdd-l6-supply = <&vreg_bob>;
+		vdd-l7-supply = <&vreg_bob>;
+
+		qcom,pmic-id = "m";
+
+		vreg_l1m: ldo1 {
+			regulator-name = "vreg_l1m";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2m: ldo2 {
+			regulator-name = "vreg_l2m";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3m: ldo3 {
+			regulator-name = "vreg_l3m";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4m: ldo4 {
+			regulator-name = "vreg_l4m";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6m: ldo6 {
+			regulator-name = "vreg_l6m";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m: ldo7 {
+			regulator-name = "vreg_l7m";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-5 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+
+		vdd-l1-l2-supply = <&vreg_s2b>;
+		vdd-l3-l4-supply = <&vreg_s1b>;
+		vdd-l5-supply = <&vreg_s1b>;
+		vdd-l6-supply = <&vreg_bob>;
+		vdd-l7-supply = <&vreg_bob>;
+
+		qcom,pmic-id = "n";
+
+		vreg_l1n: ldo1 {
+			regulator-name = "vreg_l1n";
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2n: ldo2 {
+			regulator-name = "vreg_l2n";
+			regulator-min-microvolt = <1056000>;
+			regulator-max-microvolt = <1056000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3n: ldo3 {
+			regulator-name = "vreg_l3n";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4n: ldo4 {
+			regulator-name = "vreg_l4n";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5n: ldo5 {
+			regulator-name = "vreg_l5n";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6n: ldo6 {
+			regulator-name = "vreg_l6n";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7n: ldo7 {
+			regulator-name = "vreg_l7n";
+			regulator-min-microvolt = <3304000>;
+			regulator-max-microvolt = <3304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
 };
 
 &gpu {
diff --git a/arch/arm64/boot/dts/qcom/pm8010-eliza.dtsi b/arch/arm64/boot/dts/qcom/pm8010-eliza.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..7fe414970b27c483706c86491c4db124bdeed43e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8010-eliza.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8010-m-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&pm8010_m_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+
+		pm8010-n-thermal {
+			polling-delay-passive = <100>;
+
+			thermal-sensors = <&pm8010_n_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+	};
+};
+
+&spmi_bus0 {
+	pm8010_m: pmic@c {
+		compatible = "qcom,pm8010", "qcom,spmi-pmic";
+		reg = <0xc SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8010_m_temp_alarm: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0xc 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+
+	pm8010_n: pmic@d {
+		compatible = "qcom,pm8010", "qcom,spmi-pmic";
+		reg = <0xd SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8010_n_temp_alarm: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0xd 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+	};
+};

-- 
2.34.1

