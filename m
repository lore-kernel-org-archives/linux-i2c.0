Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D54DAF87
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645283; cv=none; b=LS/y5wkcIBntrmHxsCABHRiiqEGMzH2NFNvJUfj3wp2MVdXq9aR3+XvvbBMgDrzW2w1hVMNWHTmIjufZYGYywW+CwHFnESwc6/2ApjCHdNZC8mzxEXDNgqoQP05+scFikbZYX7MhAbfnCxeFkLwqfMt+dYhQ3BPHYn5eGCEasUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645283; c=relaxed/simple;
	bh=dBquW3rrzw2wP52nzgHqCW3FsrfEce/mwiNkRbVPbBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nin4GyeFqMUYndZ95LNCLZ2Hz8r+QG+TvYwsraciI+SqNrZMxwVAfFyucmZ2tcz//TlfOZY/bG7elULq2drRv6rXxyQiOW+zvK4vC9fjzJKYqPU1w/bHwFEAAJa2qqRcD/8zHtPMBbtupsD1bzpDEV8smN3nl8fYPrPapRCWVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+sY6nxZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HdaDhPeo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+sY6nxZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HdaDhPeo"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H9ZuOl1390210
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 11:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f4bSX8P8uhf8R9Ebg4i33O9RJeY6pJIJnHw8HgmLtDk=; b=P+sY6nxZQH6ph5td
	xQbbVxRHBKrm+5h7/zl3asrE/8z+KIyRpPqrK1nqSUyhqyoZ9x19l+cutPqlnVdF
	Jfsn8L5gcqG9I/j1Nr9MHNdAqOdKZzRPsFdoh5RxqFqVdTofR2s81bWVUWlxBtMO
	sXD9O1Oo6169GpnKI6YGzsw5XjZcbd+NidpPQbFyXwHMd7cL5SSVukzB4c9Fpk1e
	ppceYuNYL78GWRQTa7jJ76Mn1Go94J36uYjXKIti8OdsuBs9u1ullJ25TayIGyD3
	puL4hBX0tCQT1t9VnTX8Y7RzWbc7Nu281tymfRAW95VHO8ghinSGouuI8BaP56iX
	FrpY6w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d46aw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 11:41:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4b524ce78so543275a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 17 Sep 2026 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789645279; x=1790250079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f4bSX8P8uhf8R9Ebg4i33O9RJeY6pJIJnHw8HgmLtDk=;
        b=HdaDhPeosD0oeBMm+jYwrvob87WFEYgjK3UNI6PifgLGHmgeunoClozU5EnvRcBNQy
         qHkBoGyvgqOBJmk36HhTeCzeEvsu97PXJUSmispYqGvipkV7JqRouxOrQ6EZKWcEBSvg
         4MsUAGPWqpdqtNfXR53YwHYj9i/BbLY1K7VoYixjABRLH78x9FBGWrDf9lwvP8z2zFem
         hGtKDK1RCo0LdojKFJzJlEDroA7xXnebdDxBJrJO4WKs4NEA7R/6gOKZQF+VCLTVtGhB
         mYsERn2fBJ57lj+3maJXXodRrhdPNeBiI0FdpKAFKqkp/m7gk2xDECJBKoHMyMdlTUoN
         ilMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789645279; x=1790250079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4bSX8P8uhf8R9Ebg4i33O9RJeY6pJIJnHw8HgmLtDk=;
        b=Gqgw0t+HyuDDOQwtKgh81mm7yfuqWxCIRbaW2OYeGp3Koqzgtn6jck4KIbw/Apv67V
         YcQ7yiPnEHsEvdGChtNK/C81z3gnjCDOBSTcQCR3GByaR3y7rReG0j9IvFdphj26UJBk
         xxUoMZtyrUeJMBCIXkngwxy47aHjcqF0GR9b5Rtti6Mcty6xqEs+FMeT31eNv+FD7KzZ
         am+lYVAbNbDgU8J3MeAQnkXqsFNn5iHPc6ywFCPgI0kgvYkeY7zcCLLU022NtnhLRZBG
         6WmeTcGAqnVciDN6dC37gqU2XKEtJQrQCtENmdy1l64/zuHV1bxUKipofJTAZbD5pWjc
         5uMw==
X-Forwarded-Encrypted: i=1; AKwUvByU0Dz4B81uXCCkCXVTVOGLZQ6JRbT+HX08VgJ41SWBIdwWwH34UfIDNFxp/SmZswgXlYVjEVnCmnI=@vger.kernel.org
X-Gm-Message-State: AFuF++k4Afvneepw9QWYMFUw/tRQnnBOyIAZdOcOXATSYgCIvb8tvtFw
	OMWA1gb+vsLf9O31hpalvfSuFhRMhSHB8rTL0yXpaRut82Z8Me7RdQO9QNhPxEV/wiWB94J5n6/
	ZC4zEYF7rBNuKSKjO8uF7qBVe0o5nNrtEWswqlfZHFjm7O5gSdUf+T2gt2iETik8=
X-Gm-Gg: AYBFou1cRhg5+f8MGWk1cNCbW86yk3/0WftILRY/CFBMsLv2v4DQp1JCothKNKk2nqW
	ZlYjUy+hzj1mmoR57LQnC3s5Kc58mIssKNr9Ww1GvsvsG1uV8Rpu0piZH84+x1WC81SCZ+aDJJq
	Z79fHCL+qR8AKfxoYYhmgjoZS6xhr8LJ3ZAGx29bZd9zztordsBVFOgd4Fz4/kB8PF1j48UnTTo
	dFP3Mz8vXBN7FX0GmmdvzjgXLRAiKYnIvAW31JR0fUPYqXp+J59kC3ZPhSrkt56A+UZ0/Mzysdn
	ECeerrXn1x1YnTEaBaXjYrpBBqiuHUphsPzfPNq+fyynRqm02jA5tPbK4MxodJyOZjaEr0f2juo
	V7m3UPF5euM0/r52E6HQ+g1s3399+aw==
X-Received: by 2002:a05:6300:83:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3dd5f094c91mr17001579637.0.1789645279306;
        Thu, 17 Sep 2026 04:41:19 -0700 (PDT)
X-Received: by 2002:a05:6300:83:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3dd5f094c91mr17001479637.0.1789645278808;
        Thu, 17 Sep 2026 04:41:18 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc1178sm3066557a12.30.2026.09.17.04.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:41:18 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 17:11:00 +0530
Subject: [PATCH v8 1/5] arm64: dts: qcom: shikra: Add CAMSS node for Shikra
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-shikra-camss-review-v8-1-9b9596221cfa@oss.qualcomm.com>
References: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
In-Reply-To: <20260917-shikra-camss-review-v8-0-9b9596221cfa@oss.qualcomm.com>
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
        Fabio Estevam <festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Suresh Vankadara <quic_svankada@quicinc.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789645263; l=3981;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=dBquW3rrzw2wP52nzgHqCW3FsrfEce/mwiNkRbVPbBA=;
 b=Qap2UKN5qySFqJIJgVmmNhqnIKlPZ8yKkSGkzupva+aFr3aRApiiB9137Tc9heI4DQu5xQFDD
 Ulwt+BIGaZqCKULaOkIk94a/JkrTVk6aYiOWeyOOTmIzdx9iyVhDvAp
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: NxW-s5d279BiINdoqXsYVubiqKrh-gI4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE2MiBTYWx0ZWRfX1qklBVvJRJi/
 b9Qv8dtDyM783Pe8hpMT9MomF+d1pa6NwDoWVM5srk9IQ4kC4Pm95OzUKy5CWMsyZSJjoQx8KOS
 E7LPLGLcoz/0nOx/hGnXs5x6X9v0PiQ=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aabd1e0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ahKksh3eZu5pIVwncigA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: NxW-s5d279BiINdoqXsYVubiqKrh-gI4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE2MiBTYWx0ZWRfX8fB2qkeIRIxV
 cqB4rwtt/1Ze85ZxPgLX4+AOFwPkg4F1BlyDEGYerITxPKBMUWSVGVjElE0AsPDUeKVCjVpknxv
 4omJd0TLPVALrD4n71aoLLhktmjso8AFMg7fi+yiW7geF0vm2fik5D2/AFQ1aWR1YJVa4pY41+A
 N5NAJIifJ/b0eBboVI0KL9VarJvzCS/V0f0HWtB7JmY0JgcK4isQ9QRkKvZ7ITFP3EhkgG5qp0q
 fVF9EZJkcTInQP12ObjAMLqyoLBKplj89XaxB0Oolnz6GtgSXHUYG+8R9Jn4uutmduX96Qa+Ug+
 +1fX2Y1IEBZ5vzfwg1sHmXDHx2WHNokZ/nxEm4lNrNd4e3vXS7t4CyjEOxPudgxF8Bdcz0WaDNo
 11Yp0TYzxcu4UxigEdDZK/Kz0DpriRVgoEXF9naMFr6CYTHcABB/mdT+pV5hM7crIvnrumoGtjI
 M/Mc4HdQVUsLhfGpTyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170162

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
index c1f06f692f66452c6ee1b10f3ef12c20e201b5ce..faa1f02c01957b8ed86b5e8fc659c856d574a8ee 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1977,6 +1977,106 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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
 		remoteproc_mpss: remoteproc@6080000 {
 			compatible = "qcom,shikra-mpss-pas";
 			reg = <0x0 0x06080000 0x0 0x100>;

-- 
2.34.1

