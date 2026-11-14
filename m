Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794655887;
	b=MgbWbt+sPY3O1H35wJnNbZHS0YrEbjh5T73cgLNLGxVnACSQxIXY2H6IivXfrdtJ/g3N
	 hUn8mkW4SICoUG3UZ0BRHfJthFv0Y4/GQ15iUSlDhX6aCzoo44M/3wb98G2yKwQLRbFlW
	 ygm+HS0oqW3uH/bMTS5HVTI3s/CASbRZYd9EBeRw+owuvhaor4D2nFVFip3/DrGESKM6y
	 +c9XcPxQXFdg5yXaEzOiel0CYf9K92ln/JKe9sAm+cHEjTqh3wJ3b0uU2B1cZO0qe9XqK
	 j35aQHKDh3/OnI/5zaWJcBfW5+QaFWGbj6XXhVmk0o1uoQle8Qv+yliKCGMB3dSSDVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794655887;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PWuBHqtP7Iac3fMYajEAGxsWG/T/hay0H2dsNXisRKg=;
	b=5XwlvVU+5yyjWWzD0hDh5a5WjNAkF7ROIy6U6jBnH8X4RVbrtNA6nrMsdjNnDItGP65u
	 IzVkt+OZnrfPlUfP+Ek1OWJGyiQo6BYGSqaDjDPewJ5C5CsXKgVaSg42qLE5Otk5b/YZC
	 lzJ21YclFTVYUwacD1o2wSSQfJw3Zi8Cyaus2bfBoesXmyluj1qJHSQeXrc5HBhc/7p2B
	 DWJJIq8EYFRLrTXnALelJIOE1Ud4CNWkm7mdoq+eQH9/q9ATJVp3f69JotGUTlJa5HyfY
	 pMIW2PRg6de0OaewF07+UOFIDvmk2SXbk9aD1o7u86/qW3MrxHpWtSpcrkDJFGqGGDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zwpkpoep;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UpWqKbZV;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE6606A33B
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EEE6606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zwpkpoep;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UpWqKbZV
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wFTO464846
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWuBHqtP7Iac3fMYajEAGxsWG/T/hay0H2dsNXisRKg=; b=ZwpkpoepkoNJh5Ld
	1U28IySHobB1LA3TXT7pPyhFmbAweO1TuflssjEn4Re8AB7g0ApBYIfT2oJfIaPU
	eA4x44HHgqa7ndKRP7OAQz/yz5MbuwYkzlvfW0tD3qzh1ASFIldhbeqTlaH9hw/5
	3/ZZPSwEZ34AdxPQ9R5OeExe/UK9mK6z2Yilw8aD3S6rP6lVxWJSwKPtOSM++wFE
	BqWy9s5miHSXGKUNJ4fGRiLEUJZzZ6CJGbp1sBIMuHHLQOF38orj2ybMuc9zr6f1
	A0H1sYsbmwJ367oO6I0nn2H9Svboz34SvIdeygng/4Ov2fHi4RE3JQNqa+UZuD5T
	gV7lMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdrmfx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 11:31:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-55d2c5f10ddso810931cf.0
        for <linux-i2c@vger.kernel.org>; Sat, 14 Nov 2026 03:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794655884; x=1795260684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWuBHqtP7Iac3fMYajEAGxsWG/T/hay0H2dsNXisRKg=;
        b=UpWqKbZV/Q5hP1N/b6S4/7NQY41/7CqbcWNA90kr/AXSuMMtH8SrbvNouBvj17TB02
         4CVfqBJ+kQWDrY4YMnEL22736KQq/VlS/H7BQtSX0LKMFFarJCCKUnnPCUPHuejAeL5y
         aj6ccsvv8I/7GYnP3izfjjzja+qm5Igb1WV4V6U7JKVlme8b8v3aaecp5iD0r5zPeu1D
         2g98r9bxfpp6qQq7zLuIx56/Td6eGr9XdHTJ2XszbMZiRiqUUhpqwT/TODK943HN3fd5
         fRzyMPvi+HuCucJZHlZYMonh4j82wXn3VEDUoj/P8KH2qprFsqicSswry1XaAKshyPqc
         bgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794655884; x=1795260684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWuBHqtP7Iac3fMYajEAGxsWG/T/hay0H2dsNXisRKg=;
        b=C18Huxl+8mv9YFWlpTzUNamUesrzpmzjzWjaqVKDYDxV9QHVfGWulfNAWGU6m8Pllc
         I4UOkiddb8ui+hRlk+4EqnnBaC4H9HDA7v9AzR9tn7wd3/pmlnOPNB0jUFyotBWNmdAS
         PK3C5tfSyHvFXUL5BJpAjE8XximuFNpxcXlXqrExf/ZwvnPEEGb+GFsM6OInCpP13ifF
         6HKjW8YRD4BkTdACwBN/vTQod1aZStytu/wBTP2s4kFtiC/iNSrrYkX88Hxzba5+kzoA
         AxttXBOHQRoE2EerUyzzfpgsdk7QKsEbcJd03mwK3dliCKM7PoglOu1cmRmKqSY53y5i
         Hanw==
X-Forwarded-Encrypted: i=1; AL+hErGTekySmAnaEHCDsg/PTMxthKQLYFh7hb2o7TE08OgK3edJRa1VdOFe2BWKF46/xr96tvfTAgPPuSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+barnv6Tm1Xd366RvoIKqMXAiipl5ySCTBm9gp33tIm5DOXREN
	RplrdXsAyByNx0SiRo1G9SxPKeCEwT8hVSLrKuTOb1Ml34ejHVQYC8qBeXLp9HE9eNS0A6rGtdN
	fuGBf/C7+aDpWM8Fc40eyQpOczlh5ReEKBcmmanZ6P9kds0ZtkxpKTTCTugpvFvw=
X-Gm-Gg: AYBFou2zdK3bK8Fj/+7HRrMnr3Pddko3JKtQVFcr0EJjPxqp4Lsgrd2lC5/oSbU+phW
	oBSTLKbS1M+ktGYlksUm6fbQ6rAPp2x5Nsj4KaFNTn81KrytP9dJUrBwsUYc/t3GcgZJaYDnl7V
	Tui42gfW+kWTTeIjgyoS+RbGehJl8RhjbUHqHe8yPRN0I+rvgptdE8mgR20DIhVIDqnpeaq6/aK
	XWUx42xF33EIa6OENJLvgFlPvMeXQrwsJ2apI6yLpqkMtmyredA+EblgrWD8OYFXUD9cVI1VsET
	0RQbnYf99gzfjSDyFP51IsceKezLex8ZLrF3UyJL00SLtHkGHkZLy19ZjUpqIbn5D3daWROfLz3
	a08ZrPdwGoZgo8bCcI8gJEAfA3LWJLPBIV/+kjY/T80fb8yNx64VDWDYWdp/ljT2Hv4BOPtIGXv
	ZJogFVLAkfElFlTZVjw2eYyZ9Qz/e3aoQxHspmGwHB
X-Received: by 2002:a05:622a:355:b0:536:6214:f5d0 with SMTP id d75a77b69052e-55ac817ffe2mr85270481cf.22.1794655884325;
        Sat, 14 Nov 2026 03:31:24 -0800 (PST)
X-Received: by 2002:a05:622a:355:b0:536:6214:f5d0 with SMTP id d75a77b69052e-55ac817ffe2mr85269991cf.22.1794655883816;
        Sat, 14 Nov 2026 03:31:23 -0800 (PST)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d7ba48sm41389746d6.28.2026.11.14.03.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 03:31:23 -0800 (PST)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 19:29:28 +0800
Subject: [PATCH v7 11/23] media: qcom: camss: vfe: Add support for VFE 980
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
Message-Id: <20261114-add-support-for-camss-on-sm8750-v7-11-8ff2a11835f6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794655774; l=13061;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=f7UYBYHL0sIoSG+X5GdpJ+Zm8VONhTXcXsJG+oaZYtE=;
 b=dn91c4FUcXZubFwMGP2Ov/wTWmx9Tlbrz/GrQkmbO4r1VN7FczeZnSF/d9l9y7Z+V/9sh4G6R
 ys6s7iS0Fj9Dbo8Ndfl5jaR8jBJbU9Zdkpc61BdHbRDwXYovozngO0U
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af8468d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MF5GGWwJVXFIdQ_HTw4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX7p8z1RxoQ7QH
 4vtpmjHHy4/aGxk2pz2L++d0S1xzWWLmpmDreLWk4H7/MFK1CUUvOI3/dWaO+0/NT2+/CeorR5L
 4ErIR0YHO1fsCHEETVvYp3AQ8rFO0hE=
X-Proofpoint-ORIG-GUID: CYpU4NnQE6ksDWZxJZw8RoIo0Amtvp6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NSBTYWx0ZWRfX5o67SHp1n8zc
 FM9TWH7cATd+wvgyTg5cv3R2MuTMD4gZtGyjUhj07SMDHLOaXoLTU4zlmfBAUiNd4XEM3Ifk3bE
 f4FvV6+55c4x33HtIErifYpEEeI3aKUlHyDiKuisM84K1uAImpCmoa1xGLNlTluPOFaRq6zRVKG
 e2hj2uKJgzZ7vz91udCozA04dZM7bBrMuXzX0VNhS2HPIXXdLIZByuVlbwVBKRR5AgWjaqJYEVe
 svTz1YVsSDUtB7wECDGJKYklPh+aPOq1WREgb7Me2DNktJz6qhehDoweTR82D/+bThTVqkueM4s
 ZEyNHX4+TvAczhRMaA2bkPDctPYezL7XF++iI1jLvmTgPMconTt1uPDNzfEu1uy6GoPNeryjDcI
 6HZA/LBYTM+WZyDE09Iz7y3UFRS3yTNTwrxuk4vFX+ADQq8wz95JPSqwKVqCTTTe1YMJrmwKYam
 ibft8AAqOZdZ9euLn1g==
X-Proofpoint-GUID: CYpU4NnQE6ksDWZxJZw8RoIo0Amtvp6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140045

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add support for the VFE (Video Front End) 980 found on SM8750 SoC.
The bus register base of the lite VFEs starts at 0x200 and that of the
full VFEs at 0x800.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile        |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-980.c | 213 ++++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c     |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.h     |   1 +
 drivers/media/platform/qcom/camss/camss.c         | 115 ++++++++++++
 5 files changed, 332 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 1aef4267543dfa1c25dbbf351252862bf94a847d..b955b3c735ddcd0f8c733553188cef8b48fe4e9f 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -27,6 +27,7 @@ qcom-camss-objs += \
 		camss-vfe-340.o \
 		camss-vfe-480.o \
 		camss-vfe-680.o \
+		camss-vfe-980.o \
 		camss-vfe-1080.o \
 		camss-vfe-gen1.o \
 		camss-vfe-gen3.o \
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-980.c b/drivers/media/platform/qcom/camss/camss-vfe-980.c
new file mode 100644
index 0000000000000000000000000000000000000000..47f6c18190acfbf3c6ab49186fc73fde6a0ac799
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-vfe-980.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-vfe-980.c
+ *
+ * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module 980
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+
+#include "camss.h"
+#include "camss-vfe.h"
+
+/* VFE-980 Bus Register Base Addresses */
+#define BUS_REG_BASE				(vfe_is_lite(vfe) ? 0x200 : 0x800)
+
+#define VFE_BUS_WM_CGC_OVERRIDE			(BUS_REG_BASE + 0x08)
+#define		WM_CGC_OVERRIDE_ALL			(0x7FFFFFF)
+
+#define VFE_BUS_WM_TEST_BUS_CTRL		(BUS_REG_BASE + 0x128)
+
+#define VFE_BUS_WM_CFG(n)			(BUS_REG_BASE + 0x500 + (n) * 0x100)
+#define		WM_CFG_EN				BIT(0)
+#define		WM_VIR_FRM_EN				BIT(1)
+#define		WM_CFG_MODE				BIT(16)
+#define VFE_BUS_WM_IMAGE_ADDR(n)		(BUS_REG_BASE + 0x504 + (n) * 0x100)
+#define VFE_BUS_WM_FRAME_INCR(n)		(BUS_REG_BASE + 0x508 + (n) * 0x100)
+#define VFE_BUS_WM_IMAGE_CFG_0(n)		(BUS_REG_BASE + 0x50C + (n) * 0x100)
+#define		WM_IMAGE_CFG_0_DEFAULT_WIDTH		(0xFFFF)
+#define VFE_BUS_WM_IMAGE_CFG_2(n)		(BUS_REG_BASE + 0x514 + (n) * 0x100)
+#define		WM_IMAGE_CFG_2_DEFAULT_STRIDE		(0xFFFF)
+#define VFE_BUS_WM_PACKER_CFG(n)		(BUS_REG_BASE + 0x518 + (n) * 0x100)
+
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(n)	(BUS_REG_BASE + 0x530 + (n) * 0x100)
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(n)	(BUS_REG_BASE + 0x534 + (n) * 0x100)
+
+/* VFE lite has no such registers */
+#define VFE_BUS_WM_FRAMEDROP_PERIOD(n)		(BUS_REG_BASE + 0x538 + (n) * 0x100)
+#define VFE_BUS_WM_FRAMEDROP_PATTERN(n)		(BUS_REG_BASE + 0x53C + (n) * 0x100)
+
+#define VFE_BUS_WM_MMU_PREFETCH_CFG(n)		(BUS_REG_BASE + 0x560 + (n) * 0x100)
+#define VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(n)	(BUS_REG_BASE + 0x564 + (n) * 0x100)
+
+/*
+ * IFE write master client IDs
+ *
+ * VIDEO_FULL			0
+ * VIDEO_DC4_Y			1
+ * VIDEO_DC4_C			2
+ * VIDEO_DC16_Y			3
+ * VIDEO_DC16_C			4
+ * DISPLAY_DS2_Y		5
+ * DISPLAY_DS2_C		6
+ * FD_Y				7
+ * FD_C				8
+ * IR_OUT			9
+ * STATS_AEC_BG			10
+ * STATS_AEC_BHIST		11
+ * STATS_TINTLESS_BG		12
+ * STATS_AWB_BG			13
+ * STATS_AWB_BFW		14
+ * STATS_AF_BHIST		15
+ * STATS_ALSC_BG		16
+ * STATS_FLICKER_BAYERRS	17
+ * STATS_TMC_BHIST		18
+ * PDAF_0			19
+ * PDAF_1			20
+ * PDAF_2			21
+ * PDAF_3			22
+ * RDI0				23
+ * RDI1				24
+ * RDI2				25
+ * RDI3				26
+ * RDI4				27
+ *
+ * IFE Lite write master client IDs
+ *
+ * RDI0			0
+ * RDI1			1
+ * RDI2			2
+ * RDI3			3
+ * GAMMA		4
+ * STATES_BE		5
+ */
+#define RDI_WM(n) ((vfe_is_lite(vfe) ? 0x0 : 0x17) + (n))
+
+static void vfe_wm_start(struct vfe_device *vfe, u8 wm, struct vfe_line *line)
+{
+	struct v4l2_pix_format_mplane *pix =
+		&line->video_out.active_fmt.fmt.pix_mp;
+
+	wm = RDI_WM(wm);
+
+	/* no clock gating at bus input */
+	writel(WM_CGC_OVERRIDE_ALL, vfe->base + VFE_BUS_WM_CGC_OVERRIDE);
+
+	writel(0x0, vfe->base + VFE_BUS_WM_TEST_BUS_CTRL);
+
+	writel(ALIGN(pix->plane_fmt[0].bytesperline, 16) * pix->height >> 8,
+	       vfe->base + VFE_BUS_WM_FRAME_INCR(wm));
+	writel((WM_IMAGE_CFG_0_DEFAULT_WIDTH & 0xFFFF),
+	       vfe->base + VFE_BUS_WM_IMAGE_CFG_0(wm));
+	writel(WM_IMAGE_CFG_2_DEFAULT_STRIDE,
+	       vfe->base + VFE_BUS_WM_IMAGE_CFG_2(wm));
+	writel(0, vfe->base + VFE_BUS_WM_PACKER_CFG(wm));
+
+	/* no dropped frames, one irq per frame */
+	if (!vfe_is_lite(vfe)) {
+		writel(0, vfe->base + VFE_BUS_WM_FRAMEDROP_PERIOD(wm));
+		writel(1, vfe->base + VFE_BUS_WM_FRAMEDROP_PATTERN(wm));
+	}
+
+	writel(0, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(wm));
+	writel(1, vfe->base + VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(wm));
+
+	writel(1, vfe->base + VFE_BUS_WM_MMU_PREFETCH_CFG(wm));
+	writel(0xFFFFFFFF, vfe->base + VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(wm));
+
+	writel(WM_CFG_EN | WM_CFG_MODE, vfe->base + VFE_BUS_WM_CFG(wm));
+}
+
+static void vfe_wm_stop(struct vfe_device *vfe, u8 wm)
+{
+	wm = RDI_WM(wm);
+	writel(0, vfe->base + VFE_BUS_WM_CFG(wm));
+}
+
+static void vfe_wm_update(struct vfe_device *vfe, u8 wm, u32 addr,
+			  struct vfe_line *line)
+{
+	wm = RDI_WM(wm);
+	writel(addr >> 8, vfe->base + VFE_BUS_WM_IMAGE_ADDR(wm));
+
+	dev_dbg(vfe->camss->dev, "wm:%d, image buf addr:0x%x\n", wm, addr);
+}
+
+static void vfe_reg_update(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	camss_reg_update(vfe->camss, vfe->id, port_id, false);
+}
+
+static void vfe_reg_update_clear(struct vfe_device *vfe,
+				 enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	camss_reg_update(vfe->camss, vfe->id, port_id, true);
+}
+
+static void vfe_addr_update(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	camss_addr_update(vfe->camss, vfe->id, port_id, false);
+}
+
+static void vfe_addr_update_clear(struct vfe_device *vfe, enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	camss_addr_update(vfe->camss, vfe->id, port_id, true);
+}
+
+static const struct camss_video_ops vfe_video_ops_980 = {
+	.queue_buffer = vfe_queue_buffer_v2,
+	.flush_buffers = vfe_flush_buffers,
+};
+
+static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
+{
+	vfe->video_ops = vfe_video_ops_980;
+}
+
+static void vfe_global_reset(struct vfe_device *vfe)
+{
+	vfe_isr_reset_ack(vfe);
+}
+
+static irqreturn_t vfe_isr(int irq, void *dev)
+{
+	/* nop */
+	return IRQ_HANDLED;
+}
+
+static int vfe_halt(struct vfe_device *vfe)
+{
+	/* rely on vfe_disable_output() to stop the VFE */
+	return 0;
+}
+
+const struct vfe_hw_ops vfe_ops_980 = {
+	.addr_update = vfe_addr_update,
+	.addr_update_clear = vfe_addr_update_clear,
+	.global_reset = vfe_global_reset,
+	.hw_version = vfe_hw_version,
+	.isr = vfe_isr,
+	.pm_domain_off = vfe_pm_domain_off,
+	.pm_domain_on = vfe_pm_domain_on,
+	.reg_update = vfe_reg_update,
+	.reg_update_clear = vfe_reg_update_clear,
+	.subdev_init = vfe_subdev_init,
+	.vfe_disable = vfe_disable,
+	.vfe_enable = vfe_enable_v2,
+	.vfe_halt = vfe_halt,
+	.vfe_wm_start = vfe_wm_start,
+	.vfe_wm_stop = vfe_wm_stop,
+	.vfe_buf_done = vfe_buf_done,
+	.vfe_wm_update = vfe_wm_update,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 7a7d7fbc4e825ba980312e3079ab1ccb2ff0b62b..7a20d9c1a350da183959f9ae024ef6f53cbd0c1c 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -352,6 +352,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_845:
 	case CAMSS_8550:
 	case CAMSS_8650:
+	case CAMSS_8750:
 	case CAMSS_8775P:
 	case CAMSS_KAANAPALI:
 	case CAMSS_X1E80100:
@@ -2017,6 +2018,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
 	case CAMSS_845:
 	case CAMSS_8550:
 	case CAMSS_8650:
+	case CAMSS_8750:
 	case CAMSS_8775P:
 	case CAMSS_KAANAPALI:
 	case CAMSS_X1E80100:
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 0a91440cfe438625f7f1b71b60186491b3d24d5d..c8afa0dc9660d4b8cb0891ad2bbd9fdc92126e48 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -251,6 +251,7 @@ extern const struct vfe_hw_ops vfe_ops_170;
 extern const struct vfe_hw_ops vfe_ops_340;
 extern const struct vfe_hw_ops vfe_ops_480;
 extern const struct vfe_hw_ops vfe_ops_680;
+extern const struct vfe_hw_ops vfe_ops_980;
 extern const struct vfe_hw_ops vfe_ops_1080;
 extern const struct vfe_hw_ops vfe_ops_gen3;
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 9f7b2948b3aa4d9d401aa5ad76b6133101c95278..d05c0f965f01ce02a91b5f8dbd58a43ad9691019 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -229,6 +229,119 @@ static const struct camss_subdev_resources vfe_res_kaanapali[] = {
 	},
 };
 
+static const struct camss_subdev_resources vfe_res_sm8750[] = {
+	/* VFE0 - TFE Full */
+	{
+		.clock = { "vfe0_fast_ahb", "vfe0",
+			   "cpas_vfe0", "cpas_vfe1", "cpas_vfe2",
+			   "camnoc_rt_axi", "qdss_debug_xo" },
+		.clock_rate = { { 0 },
+				{ 360280000, 480000000, 630000000, 716000000,
+				  833000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 200000000, 300000000, 400000000 },
+				{ 0 } },
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_980,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE1 - TFE Full */
+	{
+		.clock = { "vfe1_fast_ahb", "vfe1",
+			   "cpas_vfe0", "cpas_vfe1", "cpas_vfe2",
+			   "camnoc_rt_axi", "qdss_debug_xo" },
+		.clock_rate = { { 0 },
+				{ 360280000, 480000000, 630000000, 716000000,
+				  833000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 200000000, 300000000, 400000000 },
+				{ 0 } },
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_980,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE2 - TFE Full */
+	{
+		.clock = { "vfe2_fast_ahb", "vfe2",
+			   "cpas_vfe0", "cpas_vfe1", "cpas_vfe2",
+			   "camnoc_rt_axi", "qdss_debug_xo" },
+		.clock_rate = { { 0 },
+				{ 360280000, 480000000, 630000000, 716000000,
+				  833000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 200000000, 300000000, 400000000 },
+				{ 0 } },
+		.reg = { "vfe2" },
+		.interrupt = { "vfe2" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife2",
+			.hw_ops = &vfe_ops_980,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE3 - IFE Lite */
+	{
+		.clock = { "vfe_lite_ahb", "vfe_lite", "cpas_vfe_lite",
+			   "camnoc_rt_axi", "qdss_debug_xo" },
+		.clock_rate = { { 0 },
+				{ 266666667, 400000000, 480000000 },
+				{ 0 },
+				{ 200000000, 300000000, 400000000 },
+				{ 0 } },
+		.reg = { "vfe_lite0" },
+		.interrupt = { "vfe_lite0" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = true,
+			.hw_ops = &vfe_ops_980,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE4 - IFE Lite */
+	{
+		.clock = { "vfe_lite_ahb", "vfe_lite", "cpas_vfe_lite",
+			   "camnoc_rt_axi", "qdss_debug_xo" },
+		.clock_rate = { { 0 },
+				{ 266666667, 400000000, 480000000 },
+				{ 0 },
+				{ 200000000, 300000000, 400000000 },
+				{ 0 } },
+		.reg = { "vfe_lite1" },
+		.interrupt = { "vfe_lite1" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = true,
+			.hw_ops = &vfe_ops_980,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+};
+
 static const struct resources_icc icc_res_kaanapali[] = {
 	{
 		.name = "ahb",
@@ -6115,10 +6228,12 @@ static const struct camss_resources sm8750_resources = {
 	.pd_name = "top",
 	.pm_clks = { "cpas_fast_ahb", "cpas_ahb", "gcc_axi_hf" },
 	.csid_res = csid_res_sm8750,
+	.vfe_res = vfe_res_sm8750,
 	.icc_res = icc_res_sm8750,
 	.icc_path_num = ARRAY_SIZE(icc_res_sm8750),
 	.csiphy_num = 6,
 	.csid_num = ARRAY_SIZE(csid_res_sm8750),
+	.vfe_num = ARRAY_SIZE(vfe_res_sm8750),
 };
 
 static const struct camss_resources x1e80100_resources = {

-- 
2.34.1

