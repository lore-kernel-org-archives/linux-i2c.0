Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EF472F62
	for <linux-i2c@vger.kernel.org>; Wed,  5 Aug 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937992; cv=none; b=QQKYr2o4SFc9aI4fu0R3cqbLNWwlT67Z3dx4DU+szzoDb7CrsJSQLgZUDuQX2Y4wqFSoDJgYPTl77PPVFhZc+0EVfWgTZSLFVI/+v/1KF57vejtp2d7lXkWN77iRRW7s9plqD1b1GtcJN/PQyCwewT8wGw/nWD/p0daLRTvl58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937992; c=relaxed/simple;
	bh=ig1ML5YRxSKYBLnbyel5EiPeXH4lJTzPwD446Jp+noM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2X3imvQ8jiHI5DooTFOvz7TfHH+4OsB80ODgOACBkAZugSGKGCb3gZH6lLGCGYShpdWqKLCIxu4imJgvlLV0Iw09vlhg6+J8ohm7/fdcMSKxxubNxdzsOuIaiq4iGjlSZrbt4SMkhIvz0dCo2ffFANAEMKA6snnBxYdokTaRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m9IsQMs0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ao1pIgDk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m9IsQMs0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ao1pIgDk"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675DHE8Y2986590
	for <linux-i2c@vger.kernel.org>; Wed, 5 Aug 2026 13:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c7OIJdm3VbtrlxeJChZycDupxK0CtLDat6B09u3YioI=; b=m9IsQMs0rIyVN1y6
	JSJYCFnaJx64oDzxIJMXhLvg+xMpnnXqg2Ks0Bbhqi69vTL+u/l1xGrEQHTMeHDC
	f8Nvq8REhlZsXVSnrd+bmFUNMiM7ipRPiY6KPa8pVJLVoxb2AgdtBR+ts0nV6SzQ
	+IredQXIbAqQcCHD81GbE5HrwZ3WgOO5DMvbpbOR+f9pol4+JFZ3SKFO36qtEOnM
	2YY23Ww5cpPxb/dUCw4xnZ/Tuyp2u+p5IYCiXGB3EQWKyKuSlMK979WbObd7ds/P
	bZn3x+Z/fR1qm5aUsqCGwTb/x1IgVZEpA04Oub7bUHN7EhvLHFyMwIha+DYM1l6R
	f/ALZQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5r5n3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 13:53:09 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81f0b6bb02dso26992937b3.3
        for <linux-i2c@vger.kernel.org>; Wed, 05 Aug 2026 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785937989; x=1786542789; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c7OIJdm3VbtrlxeJChZycDupxK0CtLDat6B09u3YioI=;
        b=Ao1pIgDkERciqD5bd0yC7ZKKc6rIhkkqVqi1oGIVytk91hzZ9xD+Cddiq8IgQ9HqOD
         NoBJfVZc2wVSyC6N3NNrHt244WVojhOFCZOEyEjP/NVhS4Pz/FVM4l+KtRcrut80ywQN
         LxsdtGydFIwWhWnHlkHNUbN8kt2YFh6c6xsOCkgrzBXIdblcuFKr2rDHLCOHiRDBmpxj
         z1jpKJacN8IX/AOswEFFDE0Y41LoYcq1UgjtucJPv6THJYwV06SEYpe6qq0BvQS7RUHy
         TmKGg5AhRQQWAFBzUaWuqP6esdIWR4QeAldHuOEVTB2KrCjzOrH9HD6XHnSumB1rPOuv
         z5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937989; x=1786542789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c7OIJdm3VbtrlxeJChZycDupxK0CtLDat6B09u3YioI=;
        b=M18spshn9nuNyfhMhE5SFiv3xhNiadHYhiqLAkweAdXB+/9f/12+K16/4560MIkUvE
         NcIca6wZU4dpWLSXIHrEpBC3bH/KrOrDPv35ZJv04efHR5sy+GZKvU7JeD/ZDGAQsG4t
         8032GgKyhWYY9LMIg2MVxJaHDqZ67QJbyv10r+TeJIoufIINY3uFapGPiuwN7+4o/wxx
         wYDxu0X7dVfDmLqUK7trGNAOQJ3/Qu8xV8juUsGSb15NTa3TzekBRYYZoJ5HpE4S2ItP
         1cLHWQ8hRAmen7vg6Ixgv7iF8u9OR0yJnLm392PGt3JsNKFWAJB0uftPAG+AQHsGQw6b
         K12g==
X-Forwarded-Encrypted: i=1; AHgh+Rouua1IJ5EgkJ3e7N/c3X5MrD0fKQWP8FmEL8EIXnVKNq2PMQBzspCRuyqGmxkDn7uo1Uijc4tfkCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRc2JrEy0HcEh7ZKjQM7nLDDYoyYcSK9Z9REDy9WoNK4XauyRW
	00EQsTexH73/ERYIqY/bom3VF0wj84tFd0n7K9p3UbYFLwNjBixDM63ZjEgOvoUiqYLlEHpXWam
	G0igs3sOKmvtsn3HOwniykujCJRANahsOY/HwX0rzFtl+bXPg5Ay7iHM290nBC34=
X-Gm-Gg: AR+sD12R0ka5KrX2GgslNICWDCpN7/WvcvLv3ds2a4RMn6Zlr/oy+qmOHjcpX7WZoRR
	BGnotZYYxpCJJUpvJLflQAc1AKF//+fibs+LFJ/yI3tckfEhJrVvbHVkIvJLaQJal7WXHI15JqQ
	7DV2N0/9V0KwEPCtoVA84XTn5W5OGv4yTJXng1LQruMlpWRNDgeGc31kBe4zKhJSsvwKhFriMfq
	LGbD1xPESCjeNEjY1Bhm3R9/YGK61AWf3ktitnUwZaovoplLClfvyK+rokfiWh3+ZzUMxllWRDU
	+bUvNv8/vd5ENbIOfG163joopiP7DS803FtaS8yNeqVdsumDr3Kbguu2BcxsO3/nNq8TipJ/zvK
	k0fwNRBwkdEnrM9kAgNZOomWSYqVLBu8=
X-Received: by 2002:a05:690c:e3e8:b0:81e:d8ec:d86d with SMTP id 00721157ae682-8201f0c1475mr40011877b3.2.1785937989152;
        Wed, 05 Aug 2026 06:53:09 -0700 (PDT)
X-Received: by 2002:a05:690c:e3e8:b0:81e:d8ec:d86d with SMTP id 00721157ae682-8201f0c1475mr40011277b3.2.1785937988569;
        Wed, 05 Aug 2026 06:53:08 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8201320ec71sm20892517b3.12.2026.08.05.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:53:08 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Wed, 05 Aug 2026 19:22:46 +0530
Subject: [PATCH RESEND v6 1/5] arm64: dts: qcom: shikra: Add CAMSS node
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-shikra-camss-review-v6-1-a8dbc66f0d87@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785937970; l=3966;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=ig1ML5YRxSKYBLnbyel5EiPeXH4lJTzPwD446Jp+noM=;
 b=Lf8N5eVjJBhYzRlwMotuU4Jml97qt2JyamtsHpbZZOPT+DCMpdZAJdgTOPKgvKtJSykRhRJgX
 jVgXX4L0/XKDRhKL7bxxmapb9/0jon3V+L9wwisnJgGO1dPMpIlqI1x
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-GUID: brpigb-taXuiEcAiRuCt4ZfHEYHKkZg6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfX0CC+iN5luj70
 w1cSF+zPl+qUlIt8Xe+6CFcg5XFil3SBcr8jjOMHd7t7hmfmlMyKZiClCCHsun1pmLKuHx/u47V
 IO7yZxy8e6pR6ClDo8bopa701u9YHQPABtqkFZ/aBvV1dtyik6DSW6R0bfQLRtgdUws4dNUfTb7
 YO5L8z4Scph3stBTu/UfroXpMoLPW6Tj+JKfBrlxV00AU1K2VWEVdnAgXxbs2NwHZO0Zhe68cqA
 iBc63ZKwd5mEl8TrYx0Ks327/6YNGeMzXhrhdblc8UpEVDkpnMGp2qsRxhL0O7cC4WHzv5H2+gG
 eTukxU8QzGQznStnBrVpfsdEdvAc/5OGDUJOtAa35auN8aspIoZqJKy3K8D1qAp6Lox9ULlkpeC
 Kknrx0FITBztwznFakn9PRDHB1LlHvsmlkLSB6fADsEFxnCQCHihs5UNJ0OUAuqccP7dM055A4c
 HO2GTqu10kCn1ABn4rw==
X-Proofpoint-ORIG-GUID: brpigb-taXuiEcAiRuCt4ZfHEYHKkZg6
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a734045 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ahKksh3eZu5pIVwncigA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDExMiBTYWx0ZWRfXy7VO4qbPmeVI
 UIxld0WiYOA1gcddm5QmBOwuIcebqoxE4NCdLRYij682WZMz10uGfaqLbXBp8j0MtCxDT6PuQH9
 x7rsvryrCTXNrmVxzaDwEZHG1VBCPtw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050112

Add the Camera Subsystem node. Shikra shares the same IP as QCM2290
with two CSIPHYs, two CSIDs and two VFEs, but does not include CDM
and OPE blocks, so only a single IOMMU context bank is needed.

Co-developed-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Signed-off-by: Vikram Sharma <vikram.sharma@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 100 +++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 80e8045282d819f14cb816b8b924dbcfbfd866ec..2e5976861253f4402c75509f52301c21e3864d1e 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -640,6 +640,106 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		camss: camss@5c11000 {
+			compatible = "qcom,shikra-camss", "qcom,qcm2290-camss";
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
+
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
 		sram@c11e000 {
 			compatible = "qcom,shikra-imem", "mmio-sram";
 			reg = <0x0 0x0c11e000 0x0 0x1000>;

-- 
2.34.1

