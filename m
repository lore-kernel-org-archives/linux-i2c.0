Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AD38A714
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507578; cv=none; b=D/snyMkN0ToIMfSh2RDNLUMtzJqSceeFpLEIf6LXMPYg68cJJJxvddY55D0dnbtZaBJ3qcyh0zf/5OcgITvHYkJvQpYGkcAosPzf6ID9ndWnPUckV0kETEINyuwj0Fto3ko1PmNJnw3dbtZyD6wNQZ1gncRJO7h+5o2/bCtwfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507578; c=relaxed/simple;
	bh=FD/YYzeYflttpFETR8KNzzuysuLGEKsTDke9rdJBgPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dFLLzx5VihX/q77b2No7TOYPEkWwcReiButRIM/bvtZ2tuR7p0qx2/Umaard0gEuRmFGUzTBvGdF/ALQy554XZuEfcKfdRYBvttpz2+DY+C6Ab+09/H5efwB7rnaA10PXrvKOfba7g6B3fQd1RBS6tIKdc/E2G3omNHrd5aZM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Iemi6Q5S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VE6nVr2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Iemi6Q5S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VE6nVr2Z"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6Ljfw3853226
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XeXuSTBUDtUckVxvoOvS+dfvJD3DA/ozz/evToIu/as=; b=Iemi6Q5S+B1d3D4z
	UlUHeB+3DZ8h0eKj3YCeH7Yjx4D0c1CsTmaPKtLow2aucdVz+8W41Ps+o3+94PQZ
	r/fjqlSOOOO356AiNKX7wGDD3QUwERwZp4CAQwtXyZOqDoRKj/aHyKJpyoAULFDz
	9XM4dKtQPrzHu/1OsNRQDCipJc9yzwTkVqJF+PkgWQlTCdMGMrH2eQqKuSRAn6YT
	IgQZWPNPBiLPnSAkAq4V0ZxC7BcRyg8TRnm57cjVMAWBRws6M0gxClWZu/EY3v1b
	Tl1oeMopQqlL/Cb4wdCnXoRnyW08DEb5lvmCOsXXVv5nI60AMU8Ocyru1HEvmmdw
	uENgqw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gx6t1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 07:12:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso3522568a91.1
        for <linux-i2c@vger.kernel.org>; Mon, 15 Jun 2026 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781507574; x=1782112374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XeXuSTBUDtUckVxvoOvS+dfvJD3DA/ozz/evToIu/as=;
        b=VE6nVr2ZITGpdURhCASK5mnXpvtFbN8/UuFKOmjFeCdY5m3T77SxBmbGAojRRTreX0
         I+ORsy02su7vYiPpSfaehZLtZhJZpimZ0reD+eSY+zUwtojqazVOJ3u+HZDfBfC5dc3y
         1mJ4hFWmlPYcUB7GFF/nnDEl3pn5MXxohY4eKEhcLjyaAnDeauwidl1LnEVMeVdKfApV
         J7sNKjVCSTUeRKfeKfVIh7CXjwx54OTQbtUuO0kG7hM8t4ueZLFYUzM5UFoP+b4v9j80
         7dNelX5NZQr4zUbNdUY2Z/b4qRrba5teeR/kmQmiPHq6j0oCoRViN6PG1h0p+/9TwIAY
         rZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507574; x=1782112374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XeXuSTBUDtUckVxvoOvS+dfvJD3DA/ozz/evToIu/as=;
        b=gPMy3QWfWCg5xCnsL8A7QXn1rZ+uPMDVdiwHWtX9KWSHlh/3yLenFY5VZtIIqbVs60
         GqgmSchHD5nsR+HbUFkRXO4glFRWYCZcu45yPNiVdCaMsJ+XXZkfYfOudGQgQ0riMq6z
         nMXGtH0BEsPaxIBi1a3HFXSVmV+S25CmBPL0hc4gQLQA5vUQ1Se2wfd1atq8ZV+HBD2K
         11DaOdBmbnDAqqrR7SRbKWggOtfS3JaRZKtfb5u8NdiOFpr4nNBs07E+akPeStz1UMn5
         Wkttr6c8WcJBM88UYpoKdNnERKcEz/sEZxjFAfoW8V5nxsmnLRZJcRYOsCDzL3rSJhpe
         kuWg==
X-Forwarded-Encrypted: i=1; AFNElJ+sljJBr3MaKLI640QHFGiMz3ZTKmnSvXaf3K2qtDJuaqRk53jtHAaUdnpd68jlWtTOYfD3nKIF9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA85CmtKy6cCN2UJHJCRum3Biizo6e0G4wqkkGSn9cG5IrUjNz
	3W9uj4W501MwXHvnyUO8S/Jgnh3Df7bUu0X4tZvMrAMIog5pCIsSXxWEv8LkfsD1PgQvJuRGQe3
	L6NEKhKjjHJ+BLiHlmxQ9hnuaVutLhJFhbLJhDe23uWx1q11vNzX2o6cG4OEOEkc=
X-Gm-Gg: Acq92OGEdTPhHLPEkEHfI91uxmkhd8xtXR50ARdvEFaykIcpgaXVZ1qMgwdH37XB7fG
	reYzkUSaRu6fsEGHWr/vp7dVqU6TZWGS269uy0Vb0WXlQGqywYjZTZpXktimxm1y7U7lelPoZoa
	VzSmI90a1eUDXjBvTbCyMujOQ2WxFRdN7iY62yd4E0b09cE3I2/WWVOArGWflOFrVkd63BFC7BO
	EICFrZ7sNRM0VRO/qNbyTfn029x7NK5KJQUHJJgN5GKbKWF474hcz083rHHpgwEj1ZD5flgiDJG
	/e2YKzVVhIwibDkDPZVyau0t4TgyQ6OD5MNapQbdykm0DxxLG1T+/zGnCa/NHphJ1qlqI4VWtJs
	2lnxNiyqYZlj6yqcyTu6Z9s/um1R6vsadroXDT7WxMF4KHSNqTweR
X-Received: by 2002:a17:90b:1c09:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-37a03ebe902mr12846044a91.21.1781507573920;
        Mon, 15 Jun 2026 00:12:53 -0700 (PDT)
X-Received: by 2002:a17:90b:1c09:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-37a03ebe902mr12846012a91.21.1781507573427;
        Mon, 15 Jun 2026 00:12:53 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a2668cce5sm14867474a91.16.2026.06.15.00.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:12:53 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 12:42:13 +0530
Subject: [PATCH v3 2/6] arm64: dts: qcom: shikra: Add CAMSS node
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-camss-review-v3-2-8183481f48d0@oss.qualcomm.com>
References: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-camss-review-v3-0-8183481f48d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781507551; l=3937;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=FD/YYzeYflttpFETR8KNzzuysuLGEKsTDke9rdJBgPs=;
 b=jcVZCP4apBgm09J+irO0tk1USXAmLXj/HWvbeobqVoyNCmVhZiorPB1J0WVNlRDLgp6ed+K43
 229TT5//GvtAKt3puMJbFWAriZwG18b0AiWjEqIl/DiiyBe76O/CtoE
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX4AhxKC3MJJ7s
 qAJYQ10I6ttBotewLPvd87/3U8ABRoKQeF8NamL63xpogDEgOsqaI39JHIZMTz5MdziRWkekxPZ
 kHZeKW4FcnpKNtcmrm1/7md7bD6DEZQ=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2fa5f6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ahKksh3eZu5pIVwncigA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MyBTYWx0ZWRfX2ytw0ydTteRY
 lD0/JTDlZX5ggGPQNf1eJgb1+eSZoiYjss6RXHSmpYBzjLLqc12Hx223ar9kwbXoi728A22/K2c
 T29jZgfJqkeTgYWvQ97aSbpg/pBtO076w3VJK/oPuMAmNxSbfzWh2atjvHntnlVKYMFYIFh468z
 PV9tynjVB4kUtgiFQNbLBjLSfSffEIcuzb3BDj0icO8MAFHRfRLfoYPdjlJvIB7KtiC3vDSvIk0
 hfq/447TBVau2XyiQ7ph5/NjVAY8GWDfglwgYRGexwF6rRFYZ5IIxpLY0yCH1FEP/yQsONxDpE0
 ecCT+ug1lTnW9YdJ5gHmUV1yVin8i+yhg1boGIK1rP26EVDTUJEbXa3C97pUkzL/JMAOFjYqy0Z
 KzAP063N3IR3EITzuJbyYbBVlA5dnzO2qdD6JNzE3uToPu2Z7eutJB/Ii1RERuo81EghVLvzuL7
 Pl7JfkwPOcPdZmqNZJw==
X-Proofpoint-GUID: AfDc7W8egNciNcA5G_LFTckBknT7BL1p
X-Proofpoint-ORIG-GUID: AfDc7W8egNciNcA5G_LFTckBknT7BL1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150073

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
index a4334d99c1f35ee851ca8266ec37d4a200a07ee5..f0e827996609dab2c09834857a1bffd9560155a6 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -604,6 +604,106 @@ opp-384000000 {
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
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;

-- 
2.34.1

