Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7A405C58
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815611; cv=none; b=TZd4ptBSpdY/8f3i5bkUKPmFjxahs5AFh40hSxTIX8LCqW3EKpC7/CMC4axaBQTbpG3mDotlwNpBNdcEGZr2pV85p+uM6on+VGDBMcC5IgNJQRJoYrK5OXUOk4x00zpUjoIdPS2G/vzFa6kaz+Kp6r2XfANiiH1NgPTkQW5yhMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815611; c=relaxed/simple;
	bh=5j9HPHByrjfIQ9lcpGSiDGJ2ss0BLEntTz0H14pT1mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfFj7y9mQQgJOssQHMbsU9piTfscvqGoyIRYk7Lix/59BMzBEx/Bboz1eLWadT92Fxz6c1wriaCfBMt/1qt4UYOF3wnpK/B8/jIjwWPkrMjBSAFhaCJPT28NoNTt/TGD3zq13/0ooYUSS1l5Gvv/J+ToG6XicJmcka44fpj/Nxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q9y+lIH9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKGXAar0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q9y+lIH9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKGXAar0"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QH14Xt1752168
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XONe5QpG6DzBvhFVWtsDUR60QTo2WcBMmV2k8RXmilE=; b=Q9y+lIH9xCTcKaBW
	AzF0h1oAqTKTvG41lwd4fV3euOSkgHjEZJRZ7G66jdsSFW4Q+E8clAX2f8VGxICZ
	wjbR9qxtgMKoOr+CFmV5ttXt3bQ2OGTheN75GcChbPcZNURn7a2v84vGEfIgcvOh
	1mSd4fAdJpgl+xwriR2yNOB4oLto8lZC+V+wH+Wd/BCKm6slGrYoFn2kyuCG/UhB
	jabnJqljcHXinvRfmy1LS65da2JtHkOXEeWtw1hys8xmY928+f4v880B7JmPI4+m
	wDhi6ivDx0P8u4HUEgAMz2IpBaq+aSKnAGqZwa1uc+dDvaA9xwAPh+Clnkib/B3k
	opyWtQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edd5ngua8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 17:13:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82f85179263so12515102b3a.3
        for <linux-i2c@vger.kernel.org>; Tue, 26 May 2026 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779815607; x=1780420407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XONe5QpG6DzBvhFVWtsDUR60QTo2WcBMmV2k8RXmilE=;
        b=YKGXAar00htXfoSDcGAEQyarHBRcidvy1ftBJjerk1z8z1hY2fIpLux6Fw2VjxJBw6
         m+vdsfweeGO1e+Fyv5MrxQKVFvchnp2xE6YS1yoWtRXmKGdf192aovcsqglRPZV7ZOGP
         YE8KNQ2AvGwakDIsXU0hz43ngAbhE9kOsNrxryXbUtJvexblYk009jvWpfAliMfG1x5M
         UOEwRl+f25LWFf1KkCXVY98/hZOoqOVmkSbKLL99+X/jw8WaiveMiGUq0qOXqF0u9h+Z
         W2RdxXuavJD+/erJ3UskU0qXl7HFe5KYpVpqd7mxgKRJWl8t6TCEsu+HD93QAamXe3Jx
         hDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779815607; x=1780420407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XONe5QpG6DzBvhFVWtsDUR60QTo2WcBMmV2k8RXmilE=;
        b=m2dCtAB7ECu1u9uDLEs5i9S3AZ/qU5malLNFT3bYu5nUTRrUpsuZHIx3AhKV/yOzAm
         q1LZEP6EpKLc4cCsHaubZUg/sdlCFBAqaH4vvmaQBruitd1lLQK2qZ6o9ta46j47h2af
         1Q9n6js2W081085eT7QM1PFwemBKQ8yH+VySYoLUBPtc0bi9WtPpODyaL0SbdrxK61ta
         8hOrdvRZhTrMPTZRFqMbw/WgbcbqOvCUM3Pl30vTZtoO1WS65Ztaq+kqHkm8OGlf2/tE
         hiil6Twc1HPgZnNxF8XL6ztL2B6z8X9pgEdPiN5wAxQTVR7HU5gs1rG434rl9e+ykt2A
         u8gw==
X-Forwarded-Encrypted: i=1; AFNElJ+EYw/SaMd43+oFpqXShmnTs9TAdVJmNOuOYlV6qoLCGoGbmCCULeUe9KX4+KMSlaMyEsV7i+kH0rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsiwsadADAohhYFJ/uYDubITp1SAffPRiDN0a25bkGUP22B3UF
	anY0b0Kh4Pm/ADfsMsM1aM5D0EhgRV6YQ03npje9DRtMWo6ayjEZFAIY9k1z5ZkA7OgjdWK93cY
	1yVyII34EjCmDESouib67rX52pjj5p0gCyB9HWwwQTBGKKfaKQVIPwLUM35+M25E=
X-Gm-Gg: Acq92OFU4lxbQ7lyEkkCTdl0JXnAWLiy44rgsmzmNC1xTukgSgA8y6RasyxHUkLtotQ
	Uy1b6r/PxuVuPiiqr0vxrMT6d3IDrabZmatnMME4TYfd4pQedavt0p9Gc0Any7Ph6EvAIDGbMMq
	myWQboFv4EeZ1Sl5WuajJ/cOuiZvPYMkjdGJhov8VE0BvWXrRz43U4914iM5aZXx6bb5lmOKrS1
	oqxBM6jTGHuynD77e77Tm1oZDwUmiKhXgbBvBPoWTfX2IunOUirW5fhjlM3ZGUSP898X3JVlQlz
	JHEr2wnltb6lwM7V+9wNbTNn4+eaiYTck1NHyIU6NxMxa7vEWXs3ViLAF+Ro4KkNLSIuec3mGvQ
	ZwBnY93kAElMhh74DZAyDqkGN9E/IrRtFkAW6uRTzM8BbUNwF/jUrGn+DOpfq+64=
X-Received: by 2002:a05:6a00:2447:b0:835:424f:6a83 with SMTP id d2e1a72fcca58-8415f65c577mr20365423b3a.41.1779815606911;
        Tue, 26 May 2026 10:13:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:2447:b0:835:424f:6a83 with SMTP id d2e1a72fcca58-8415f65c577mr20365368b3a.41.1779815606442;
        Tue, 26 May 2026 10:13:26 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84165009761sm15736235b3a.60.2026.05.26.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:13:26 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Tue, 26 May 2026 22:42:48 +0530
Subject: [PATCH 4/8] arm64: dts: qcom: shikra: Add CAMSS node
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-shikra-camss-review-v1-4-645d2c8c75a7@qti.qualcomm.com>
References: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
In-Reply-To: <20260526-shikra-camss-review-v1-0-645d2c8c75a7@qti.qualcomm.com>
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
X-Proofpoint-GUID: 8ZnMb7E1WPF0PBphCC088uq70KI1KGcy
X-Authority-Analysis: v=2.4 cv=TZ+mcxQh c=1 sm=1 tr=0 ts=6a15d4b8 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=7JZC8XBhqYczC4Ahd7wA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 8ZnMb7E1WPF0PBphCC088uq70KI1KGcy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0OSBTYWx0ZWRfX7UpEHub9XrAb
 CIdwA6v9ZYxOtc83+L/Kap+ULkWNBZuFkODSvOXxTLQepRmjK+K0hGkf+jnZv8Us0P94bAIneZN
 Vx6xcqQs3xktsKXnAGve6k00RTSCrRcR+//XR8FvTKAvBQCxGLB3L6tTZ6Wwuis8fOM5k40VhrW
 pD7Q6sW4lFOCuhxOpoMWS2qS3MSIoZMhry9wUPov9EYYWeD1bBLoZaV1uYmfrhjqExYEfuov4tU
 whf3QwfoJb4LpUCj1jg93h+PMe0eY35HkqyM2NaL6t0pgG2Dk3fNY3Qr1ccp5nAdVTt5FTfBMWS
 zppBDkpotZb+qjiwR9zMVOk+a+XgkxtBmwc5LSbnA+le/MOqnfQzxHIBvATHyA/dvNxM+xZOTzJ
 xvnUVErU5RpUGWCzOcqWw2zskYpnMqfLjfNMqwsxA2MSPfpRx8nmy6K+QgpBRr7ixscHtSI7YUG
 ILjCM+t385XN+tF8Qaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260149

Add node for the Shikra camera subsystem.

Co-developed-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index a4334d99c1f35ee851ca8266ec37d4a200a07ee5..6c47cf2a7ef26b4bb7d7f642a240b435cf5208d8 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -604,6 +604,105 @@ opp-384000000 {
 			};
 		};
 
+		camss: camss@5c11000 {
+			compatible = "qcom,shikra-camss";
+
+			reg = <0x0 0x05c11000 0x0 0x1000>,
+			      <0x0 0x05c6e000 0x0 0x1000>,
+			      <0x0 0x05c75000 0x0 0x1000>,
+			      <0x0 0x05c52000 0x0 0x1000>,
+			      <0x0 0x05c53000 0x0 0x1000>,
+			      <0x0 0x05c66000 0x0 0x400>,
+			      <0x0 0x05c68000 0x0 0x400>,
+			      <0x0 0x05c6f000 0x0 0x4000>,
+			      <0x0 0x05c76000 0x0 0x4000>;
+			reg-names = "top",
+				    "csid0",
+				    "csid1",
+				    "csiphy0",
+				    "csiphy1",
+				    "csitpg0",
+				    "csitpg1",
+				    "vfe0",
+				    "vfe1";
+
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&gcc GCC_CAMSS_AXI_CLK>,
+				 <&gcc GCC_CAMSS_NRT_AXI_CLK>,
+				 <&gcc GCC_CAMSS_RT_AXI_CLK>,
+				 <&gcc GCC_CAMSS_TFE_0_CSID_CLK>,
+				 <&gcc GCC_CAMSS_TFE_1_CSID_CLK>,
+				 <&gcc GCC_CAMSS_CPHY_0_CLK>,
+				 <&gcc GCC_CAMSS_CSI0PHYTIMER_CLK>,
+				 <&gcc GCC_CAMSS_CPHY_1_CLK>,
+				 <&gcc GCC_CAMSS_CSI1PHYTIMER_CLK>,
+				 <&gcc GCC_CAMSS_TOP_AHB_CLK>,
+				 <&gcc GCC_CAMSS_TFE_0_CLK>,
+				 <&gcc GCC_CAMSS_TFE_0_CPHY_RX_CLK>,
+				 <&gcc GCC_CAMSS_TFE_1_CLK>,
+				 <&gcc GCC_CAMSS_TFE_1_CPHY_RX_CLK>;
+			clock-names = "ahb",
+				      "axi",
+				      "camnoc_nrt_axi",
+				      "camnoc_rt_axi",
+				      "csi0",
+				      "csi1",
+				      "csiphy0",
+				      "csiphy0_timer",
+				      "csiphy1",
+				      "csiphy1_timer",
+				      "top_ahb",
+				      "vfe0",
+				      "vfe0_cphy_rx",
+				      "vfe1",
+				      "vfe1_cphy_rx";
+
+			interrupts = <GIC_SPI 210 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 72 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 73 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 310 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 211 IRQ_TYPE_EDGE_RISING 0>,
+				     <GIC_SPI 213 IRQ_TYPE_EDGE_RISING 0>;
+			interrupt-names = "csid0",
+					  "csid1",
+					  "csiphy0",
+					  "csiphy1",
+					  "csitpg0",
+					  "csitpg1",
+					  "vfe0",
+					  "vfe1";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+					<&mmrt_virt MASTER_CAMNOC_HF RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
+					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "ahb",
+					     "hf_mnoc",
+					     "sf_mnoc";
+
+			iommus = <&apps_smmu 0x400 0x0>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>;
+
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;

-- 
2.34.1

