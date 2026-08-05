Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405A3DFC92
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938010; cv=none; b=axHfcGSs8zfdVowE23+GXJsTZNoKATkjQ8t9VmgtYxBAB3iRhBuHOnPEn0+8N+NwqgfPlgjOXLX9yoyzxHyCldqaxLK3DVQ1Iebd+Gp2nZFvh6SK7nKzEA3z5XWLm+AM2XWvbjvja/MVz0NS68KvtU/2EtvCbx4V6k+oHPCcfrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938010; c=relaxed/simple;
	bh=zqWW9GqLxAuICtzSU1LCZ2LuTRVM2uyQw6HFZppsKLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ky1k3eNTZfgx6Ds584TkorKNetSXAoLzFP56LXelZ+db5vpVvEDGlz/cjnV9rixtsxr/tMAbqjoN++th1wQVRUFOdOijzWA8k2l1FBerEavfgaoXMxSj+KeT62JBcies5GZVj4wCQAfKUekKpv0TIO0JqKowX9T/G1QFdkTfVfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7/MkG6k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f2xHlM25; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W7/MkG6k";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f2xHlM25"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675BvOtI2823478
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 13:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DHDj9TXQt02YxQEnRTeluEmHbttgGScQD7kszwd7H0k=; b=W7/MkG6k5UsOh7ek
	7+SSXXYUmQNFbCVzzXSKPlG9dQ5shyQcbHAgrOg/WAG0jB3R1RqVL7xhYtndF7QA
	27DIenOEhF6awF4PD6DA3zcfpwkM5Vtd0+AUoEivnlkTTg4unq90Zl1hMeRDcu2z
	ScBpZfbYMO8qhdGd2cnOlgW6RD8RuBQjYL5CF4NhJrn5ZFBsJDnTXr740Pa9AP1A
	lPFCojZePVTPXb8T9Zhg2w36tMQ0oDwzubAvZfzTnGCA3kfPwQvpEzgoyiIHHBtU
	JSqkq4JPxlDyRx6dtaXjROGOMTn+87eH9T98211PNKnuGAMOpTKHH5sexVrAuALb
	wHgTNQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c093vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 13:53:27 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6ae12b42so14160917b3.0
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785938007; x=1786542807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHDj9TXQt02YxQEnRTeluEmHbttgGScQD7kszwd7H0k=;
        b=f2xHlM25+S/90haighO0ecvK/sI5y7sNb7/p8hcbB/9nBqC0roNQQD/9TOsT6yqpqD
         FLF+TrXWNkljZCP8+Zmxx/2b9ghPqdAhnNTkKBT4QKZJaJzzIulRqN+cOgWjHUi0unEg
         xVx5+cnM0NWCiLb4IxvR4xixzrmiGRWdI9+E+inDamHSmrM6t76bsRe6nGWW8xwKO5hh
         4otDDKSd9eeoaPRv0r2saB0FEsv0JNES+g8LiSgSMWWmQAVCaCIq7Idu/AltJAKVEUPe
         baceBvkaKwHvq8b9vSjRxbFQnPVBwwA6ulpyEfR/e/PBwwluy4K0/0UeqJX2eWACGbx1
         z9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785938007; x=1786542807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHDj9TXQt02YxQEnRTeluEmHbttgGScQD7kszwd7H0k=;
        b=Kdo3m9qe0QVLgkH06UdHbUDa2N0HFvQxEoce8+1Zj5LDdZY9QF9+2lq8xjinPat82M
         BL3hdV9LBShwQSn2unk7ScmuKl+8qpWt1PPISNPs25/0MiJYheoeZdqdJCZYsYfV2Av6
         8fCVBve+qiyiKmWHaBw5Dviwa4StnI49+NdNCFmC7670U1yrXGwRoMYLdtndegwA9c3C
         N71nM/jeprwZf1GPPcq3Lw0fl9E/CIM+hA+6R+p+3/afmsqXr4CcKp3cp5sey0EB9GKV
         E+bX0J48kG1gxt4TkVBz9ukQr7o15vhMccruF04VaF2EbGDwwfTzdOG5OxjmkHkZ+u5A
         ke9Q==
X-Forwarded-Encrypted: i=1; AHgh+Royi1u1vJIc1I51yi1EVjaPRqXUYzBQtUqp8PtDPtYfey49aD7hbyB4y4GtRqULxo50GcGcz+pitpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/UryzdxDFW6OtxaBCOajqgUwCXb3kSwMR283Sl/YdvZpWBuQB
	DXz63lnae/KmBpYFFSrr/IPjnV91LUAenHwm+Tew3ZlS+e6FWEtfYZBpkSXDlnTHq55EYaOBn+L
	SImCSJe+9WZE/IsnNiyza38KpQjZq50vg+npZBTNhuXGcMULdhZ2/8dG3XGQ+xcg=
X-Gm-Gg: AR+sD13tB+Yxslbwhl2rW3kL1iGR1oQP7IR9x3Sas853gbDTfjP5eN8paAIq/U3Z84y
	DxzORQlFcf9HHnjnIYt+hctbn/HDNUdKwiOtF8CRGt+yST6eQlL9rqODL33efZdVwdr1vzEzunb
	oMlQmbnasLJHdsfhSTfnX6XzYHE9dMgFXSf2CvZ8cgD3OB2ZyFVFpGu4Lf8j7Rtlf20SxKkJh1Y
	RjO8Axya1FUFhksNLSY9fR89Fnli2lhxttY9zJI7ttEGZ1RfPm1/uM3BUE/G8o0WsGtryG7wabA
	3UqNUZbK944zYDXlE2EtL03143kn2R+ZjJ7gq0wVJWwrCU3F8FhpS7cqU4Wf6hKpjJhtXNOLMvm
	VpE6inga2Gzk2EXijOcyX5fdtderJnpQ=
X-Received: by 2002:a05:690c:4b86:b0:7db:a109:f12f with SMTP id 00721157ae682-8201bc73833mr37282487b3.1.1785938006961;
        Wed, 05 Aug 2026 06:53:26 -0700 (PDT)
X-Received: by 2002:a05:690c:4b86:b0:7db:a109:f12f with SMTP id 00721157ae682-8201bc73833mr37282077b3.1.1785938006455;
        Wed, 05 Aug 2026 06:53:26 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201320ec71sm20892517b3.12.2026.08.05.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:53:26 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 19:22:48 +0530
Subject: [PATCH RESEND v6 3/5] arm64: dts: qcom: shikra: Add pin
 configuration for mclks
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-shikra-camss-review-v6-3-a8dbc66f0d87@oss.qualcomm.com>
References: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
In-Reply-To: <20260805-shikra-camss-review-v6-0-a8dbc66f0d87@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785937970; l=1547;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=zqWW9GqLxAuICtzSU1LCZ2LuTRVM2uyQw6HFZppsKLA=;
 b=sPuLgU939muF7lwZr37xaWm5GG4BsPu9vMW9m34ozfu+Pq6sMHMdoRAxVeqnsYL+ofo7mtjLA
 8q1T7zV8HxTDVId9Gns+28i2uGBlQRNdE1/TRBXtuXIsyXP+kmGawY0
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: 2Y_VeIlp2MZN40ms7Tj_t8H7hTsSsCOp
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a734057 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PMLJDkNcKfHmOO-cHakA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX2/58GB/YwPdZ
 n6fyzCMJXiEynzPdukOxu9yU1mIWB0S6uZh7gp/lSjvymnwGu7OH5lH7ts5J6990vEDbcLkyR22
 Simy50WLQg+I5vsp/AAnFJoL1RG6lW8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX6vphobyN0I+B
 ZVhbBPKt3B6RgLXee9/CwoNh2fX1qbgQqznemzjqUuQCN5vxQ0+17QznkaZ4SSzgQi72dhd+egc
 e4nqh/qHGzzH4TNEb3gLgmSgVgbvO0XXwRlpKwDBd+/IHdEmWtS1p4PixM4/RTFBGMk130rCJpl
 JXecetfZl7IVqR+atOUzSeqw29tFWYhBx84mlXNlg0wvnJRZADPsqRIFP3RF3c94uml6zsllaR6
 9GxCiLUzExwiv8GSIAB1xk3vreYb2dftyeVM2EIf7WBdGVzBkvBLPL3Xo37H11B/vDFZM3xxYpG
 /yvfdqrwH+fnaW7LvYcAyfisVXEggND6YsgORnAEn9qacgL5k4vCA6Q8OjiH29Ih7tLXZYbuc05
 a5ymV9cmdOsJZavEPj6QE3DheM+/NBucLaY65R94sD6gq7JVwIVbmhGVXRjBnNFIu5GBAXOPsl+
 Zo1X4D02cEs7ebv/K2Q==
X-Proofpoint-GUID: 2Y_VeIlp2MZN40ms7Tj_t8H7hTsSsCOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050112

Add pinctrl configuration for the four available camera master clocks.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index ddfcfb137bb29439ce20ba6ebf3a76693792b56c..c6839aa2349f397b041f3201b8a33fa90e36c77f 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -387,6 +387,34 @@ cci_i2c1_sleep: cci-i2c1-sleep-state {
 				bias-pull-down;
 			};
 
+			cam_mclk0_default: cam-mclk0-default-state {
+				pins = "gpio34";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk1_default: cam-mclk1-default-state {
+				pins = "gpio35";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk2_default: cam-mclk2-default-state {
+				pins = "gpio96";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cam_mclk3_default: cam-mclk3-default-state {
+				pins = "gpio98";
+				function = "cam_mclk";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";

-- 
2.34.1

