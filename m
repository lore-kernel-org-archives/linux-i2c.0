Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587958;
	b=g6H+PQhytGklopgU4nI3UFQ2KcDKKADu7tYRdTbMG+ry0EdpB/sZ9/H3C/03sDT3r2mT
	 K/aa8G9VGUw/QwBcuNU1rYnH4BsyTpiU/9uB/NjikFEqATeWENbJIx0kXrjospb8QfoM0
	 LewoaKHfcNywwmdS12a0SQvntXzNSi08ElakjgYqGY1rtxlAZB2PCEaM7ojLkUfplCGW4
	 DfT1XBs7teeC+7+jdfPFl9vPXInr76lcI+QNau7WpBVPeEQGVdVe7umPdyos/kxFKXe9K
	 Hw48AC2TGa++OtlrGrrXAHddZFxymtPaXpiFxYRsDm7U6ADyTU6oRqKiYDv/tBEewJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587958;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pzpfeVEavQj7EiIXq7kDg+d9nbgzFa46wq2EternaVo=;
	b=gAX5ETsRJ3oJ8ejNboYey68Z1NQZRGYJiqnU/HIgyJD0G1h+q/4rXcGp6FaTYgOhdbVa
	 NrLD05VIWUmmyDHcKODXMCECzrqSG2Pp4U7Nd++4ekzTL8H5rlKdfJZq3Fb4eqF59ZHH/
	 nA1B3P0xp6XE4fvZITLMc/AsG8i8lMkvhKXj9B45gSRh6yCoQ5VMzzd5b5t2w5PtlNw9I
	 jSIqkCBw2qo15TiQ22SUPEsxzpddnmSHUGP1s7ZaIonI6MlqU0OShr0KF7I9DyfhEjl9b
	 wyD7yBUvwzX9trkXJvZ6p4cTPuqw7PUDjD6bm/5wuuW96eqZIKP+5hC+AEmtivTdemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFInxtcL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KR4n7zMM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A4606A321
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A12A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oFInxtcL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KR4n7zMM
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68ZmW300019
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pzpfeVEavQj7EiIXq7kDg+
	d9nbgzFa46wq2EternaVo=; b=oFInxtcLKRoWuETwDbqmV2hPLqrZy7CHA8CuoH
	EBvNOG81/+vRy/GaA/fBdT2Q+vM9KMu525D6VV2CI9kMdTRQX5Fe5hyKZr/gFFaQ
	GPEX7CWQyD4yD7fKGk8mW8KZXctuigzuY7V4nlBj3Ywrp6Xb/dScFwIKW0hYjNpJ
	JB/1p8fEhY8hUjACoFuckzX1LUnUd6r7KOn/wRslbv38sfdapzrrHMqN6u4vgSwa
	29rKdwEnIULCNAH7ArkVPsS9tMW/H1EDyJ2pD6crehMLU7/+/MuMxUwSoDULxj9W
	POyywNPrJK0ARmUfXcPpQEVcLwacLryieFDCUKBPchu4iM5w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5n6rs3pj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 25 Nov 2026 06:25:50 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a06750c74fso3909438b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 24 Nov 2026 22:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795587950; x=1796192750; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pzpfeVEavQj7EiIXq7kDg+d9nbgzFa46wq2EternaVo=;
        b=KR4n7zMMGY2XJaDVRfZ3iwPvhPyi4BBogPK+KU8LrQl5EUwXkOH7QHVsuzW32Tme1T
         aFg2EslHyW1MWJt85fE8ZVAFfAUQNWVa55GYcuRJ1BP8S1XJdSq4mNhQ5BZWCtvRfwE0
         XW1ccitzmyWztlZJjvMWnxvrCL+5s6U+Vfwb8PtCDfLCWb0BUpidAI1LGJwlrFTzP+np
         m2NmgjVSG+ibYBerY1GSDJWRDRO2UBWRBCy0aynyNR4VB7X4ZsY02v8VG4zVZFUD+jMo
         k9jEnu6JUgW3nkLTzVGIZRAv3OMdQx2ieA+s+aIRLQktzLjYlzBc8+ReEQYXx8MrJu0n
         IwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587950; x=1796192750;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pzpfeVEavQj7EiIXq7kDg+d9nbgzFa46wq2EternaVo=;
        b=WiAXbNWnUcLYtvYpCoC5VearI80OW/c7Pol72xUjPO4l+6KwJn20KyB7qvPYFQ3bh7
         hbTZkMjaJSqc0JqHtAyLOSQyWC/amhQY9+/aSF305stnk1CGx3do/xWGv0M10Rkod6SH
         IFIuZlfJGQxPEA4bY160h/ScIPtjb2E6u2kAFoVnAGUvS0Bw6h19Zblmo2cyyuXctB9+
         brnEfk7QJ2esKM5gwe/yMhhugrxWsqLZxhFLoiM5OJQVcqsIB6qN+Vt2MC1bqgvWr0v8
         GAUY6rSK0t7STdUy1B7PvgDYpbbmOHIqDEC0A6RKESMAjUnUzzndpLMmxNwi6KDqrYBw
         olAQ==
X-Forwarded-Encrypted: i=1; AL+hErE64D8jvgm6Veg/QTuVSJ+My0T5Lc+OnwocCTNvvSiH6UYNdEo4t2eINv19mLHNyryaiFMRPUapoAg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OYfYuNbDgmnwfVbpN29H5xsEqxpw2VkKSv6zJhvEqlWGXpSe4
	373YXBFF2peK6JuG2x3+yonVJb4C5eB5K4jr5pvLbSE9JBBtz+19KSlA9e9eNKVdSEprvirvABc
	voNNI/lg6m8aQBz9oISnB+4i2CWHklZK5QS6UY52I0nO/jLutWtPKLHRd5Z0R/40=
X-Gm-Gg: AZFdTZcZI9eokefhv2coAQjnHMwQ7zSmP5QbzhRj/jPNMnLadsXA7cErdfxWxyJ3chd
	F72KepiYGTBWWWKabWN8/tPuP523TQ7KLo18yaKAllDP0N/JpRUxHw6DnC8HamQCPiUUrrYOq/8
	3cnbWObKtQhUmHUxWfAP4M676W6AqaV23IMTe0f4oozPCJOQQp4yFBv/LOokQ4KuogBmui4V1sZ
	AZc015vsGYlsJtxPxJ/W6jaUlSkF7BWFveMzYz2+4hR/52XYEW/nOM+Yxf4x+IXPGme3Kpr+rm5
	i2vHwXtYnw4Lkh75pGxunb7YgPdbZbxn7zKTd8EAW0ajpjpEyPacHRVrvAdVU65CeXa07R6II8B
	ah8BFMa/5Kq1D07pYvVpcAwUjlVy9e47Sw0RDG7rkFISXdLYH+lHo5ZcySl35ou2fZm6CoThtFG
	ffNFsO
X-Received: by 2002:a05:6a00:1d93:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8c87d51b324mr14173218b3a.56.1795587949787;
        Tue, 24 Nov 2026 22:25:49 -0800 (PST)
X-Received: by 2002:a05:6a00:1d93:b0:89a:5:92c1 with SMTP id d2e1a72fcca58-8c87d51b324mr14173189b3a.56.1795587949291;
        Tue, 24 Nov 2026 22:25:49 -0800 (PST)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm8385066b3a.2.2026.11.24.22.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:25:48 -0800 (PST)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Subject: [PATCH v5 0/3] Add Qualcomm Hawi I2C CCI and Hawi/Maili CSI-2 PHY
 support
Date: Wed, 25 Nov 2026 11:55:40 +0530
Message-Id: <20261125-hawi-maili-camss-v5-0-1483b7f68dce@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAGR/BmsC/33RwW7CMAwG4FdBOS8ocVLacOI9ph0Sx10tUQoJF
 BDquxPYtO1QdrH0W/Jnyb6JTIkpi/XiJhKNnHnYlVC9LQR2fvdJkmPJAhSslAMjO39m2XveskT
 f5yxDFdEarxRFEGVsn6jly5N8/yi543wc0vW5YdSP7j/YqKWSGEKwQJWx1G6GnJeHk9/i0PfLU
 sTDHOHH0UrPOVCcFp0BgOgbhy8c88cxasYxxXG1hYC+QWrhhWN/Ha1WM44tTqygwdrXrg52xpm
 +jpfocCpvOH5fcJruFlWBuqQBAAA=
X-Change-ID: 20260923-hawi-maili-camss-b5dc43a00ed2
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-media@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795587942; l=5267;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=9X/7nIs1WLTe0qV0OiMWh+UZ+GNApBiRWSnm81zHmmk=;
 b=0NXaFfnI30tyWyVu/ub8D+DzkJcv0nueHNtG7UFABXbpELymKwic0g8wInlL0f8csbqqX4QwL
 OveYpACmum6Dy/xHkW7iHFyjQA9nYNqOuztZCVBA2S97CPykn+KgPmC
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfX3jp7TWxN8aes
 Xo/HzMV9NlsFb+/6r5sh4vopmtdIBTJfhhvKXfyQ16al5DDJ0sOqXRlWMIVbTph8vyO1cUdzhRR
 4lcn12mLFE+1xRHRjXEn22CqhBTEhcI2Cole7hWAGDGxjHDX87e2XJ0ziKV/pRBmC+zkrZtGHgu
 RszRuhcR7kgFz9b3Dn1XcyA/j8p/EH//KLYa7i+QkQDddiS6PHguFBtbuuiPrK7mcJ6ZBVRR/eG
 l1xIN87oFhGovurc9/P1WY0nIf4B859nyjg695WgGttwVsqhHQ9OXAJSNMKrxO+jCc9f8cG4GQB
 E3Je9+vGlMhG4MMv/nkyWduc3AIs5DsnMw2/DwlLW0FMn2IH/PzgCWivS247CRGFO0nmfvldJIp
 XpJd56qUCmlm6CMQ2OxCTl9aeNrzvPgMK0ihQBARE9uXqYrGMfjp+isObPa/eXmq49I7Pzyxyqr
 018P/aX0AA60YSAQBZw==
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6b067f6e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=MdiNbCTM_Z-SUpbbCTEA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: NaVBzEHSjne3bMMeQBKAsQyiJ4ymc5eB
X-Proofpoint-ORIG-GUID: NaVBzEHSjne3bMMeQBKAsQyiJ4ymc5eB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyNSBTYWx0ZWRfXx46OqUqpjPRT
 obJtx5O6uK0pOdCIBvYzWb5C0Ut5RMkakLSAbdWSaxchyMHfF10CMs3dNPSMRG/pEN+Dy7zNV20
 7UKMpTEBmm5AYBUCtEw86U4/4FTp+ko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250025

Hawi and Maili are recently announced Qualcomm Snapdragon SoCs [1].
This series adds the I2C CCI binding for Qualcomm Hawi and CSI-2 PHY
support for Qualcomm Hawi and Maili.

This is a continuation of the previous combined CAMSS series, now split by
subsystem. This series carries only the I2C CCI binding and CSI-2 PHY
patches, which do not depend on the Kaanapali/KNP CAMSS media patches.

The CAMSS/media patches from the previous series will be posted separately
against the media tree where the required KNP CAMSS prerequisites are present.

[1] https://www.qualcomm.com/smartphones/products/8-series/snapdragon-8-elite-gen-6-mobile-platform

Used following tools for the sanity check of these changes.
- make -j32 W=1
- checkpatch.pl
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=i2c/qcom,i2c-cci.yaml dt_binding_check
- make DT_CHECKER_FLAGS=-m W=1 DT_SCHEMA_FILES=phy/qcom,x1e80100-csi2-phy.yaml dt_binding_check

Patch grouping
------------
I2C CCI bindings part for maintainer Loic/Robert/Andi (1):
[1] dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible

PHY driver part for maintainer Vinod Koul (2):
[2] dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles
[3] phy: qcom-mipi-csi2: Add Hawi support

CAMSS changes will be posted separately because they depend on Kaanapali
media patches.

---
Changes in v5:
- Fix correct patch history in commits - Krzysztof
- Rebased on next-20261124
- Split the I2C/PHY patches out from the CAMSS/media patches.
- Drop the Kaanapali CAMSS media dependency for this I2C/PHY series.
- No functional changes in the I2C/PHY patches since v4.
- Collected Wolfram Sang RB
- CAMSS changes will be posted separately because they depend on Kaanapali
  media patches.
- Link to v4: https://lore.kernel.org/r/20261106-hawi-maili-camss-v4-0-d528c7a797b4@oss.qualcomm.com

Changes in v4:
- Rebase on next-20261104
- Collected Krzysztof, Loic RB's tags
- Added Loic patch to Scale the CSID clocks with the CSI-2 link rate
- Use 8775p TPG resources instead of x1e resources
- Align tpgX and csiphy_rx clock names with the 8775p platform - Vladimir
- Remove redundant CSIPHY resource definitions by introducing
  compatible-specific code and keeping .csiphy_num instead in the
  resource list to denotes the CSIPHY number - Vladimir
- Example Address should match your first reg addr in Hawi bindings - Loic
- Link to v3: https://lore.kernel.org/r/20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com

Changes in v3:
- Rebase on next-20261029
- Squash Hawi and Maili CAMSS binding as a whole - Krzysztof
- Add description for IFE and IFE_LITE IOMMU in CAMSS binding - bod
- Correct the lane count variable fallback path - Sashiko
- Add CAMSS top region to binding and DT - Loic
- Use split addr_update/reg_update in CSID and VFE 1190 - Loic/bod
- Add SOF and EOF enable bits with top level RDI status offset to
  allow their corresponding interrupts but not configured on - bod
- Move the common CPAS/GCC AHB and AXI clocks to the pm_clks array
  drop them from the VFE clock lists - Loic
- Use the GPIO function with bias disabled for CCI sleep states - Loic
- Collect RBs from Loic, Krzysztof and bod
- Link to v2: https://lore.kernel.org/r/20261013-hawi-maili-camss-v2-0-fc93222da89c@oss.qualcomm.com

Changes in v2:
- Not an RFC anymore
- Rebase on next-20261012 and drop the external CSI2 PHY series dependency. 
- Drop DTS patches; they will be posted separately with Maili DTS dependency.
- Collect Reviewed-by from Konrad, Abel, Bryan
- Split CSID and VFE 1190 into individual files rather than in separate
  combined Gen4 files - bod
- Remove reduandant is_lite condition in CAMSS CSID and VFE resources - bod
- Replace bias-pull-up and bias-pull-down with bias-disable for the
  SCL/SDA pins of CCI nodes in TLMM, as internal weak pull is inproper
  with existing board level pull up resistors - Loic
- Drop the unused reg_update_after_csid_config flag
- Add lane count fallback path for CSID RX configuration
- Add Hawi DPHY support by tuning register table, which prevents
  potential stream stalls and SMMU faults.
- Add a standalone Hawi CSI2 PHY compatible and make Maili fall back to it.
- Resolve conflicts introduced by Glymur in CSI2 PHY binding.
- Link to v1: https://lore.kernel.org/r/20260923-hawi-maili-camss-v1-0-cbbb42e534ef@oss.qualcomm.com

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

---
Hangxiang Ma (2):
      dt-bindings: i2c: qcom,i2c-cci: Add Hawi compatible
      phy: qcom-mipi-csi2: Add Hawi support

Nihal Kumar Gupta (1):
      dt-bindings: phy: qcom,x1e80100-csi2-phy: Add Hawi and Maili compatibles

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/phy/qcom,x1e80100-csi2-phy.yaml       |   5 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-3ph-dphy.c | 136 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-mipi-csi2-core.c     |   1 +
 drivers/phy/qualcomm/phy-qcom-mipi-csi2.h          |   1 +
 5 files changed, 145 insertions(+)
---
base-commit: 3dd8c790a7b7027abdd568e36db5e82ffaea7c77
change-id: 20260923-hawi-maili-camss-b5dc43a00ed2

Best regards,
-- 
Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

