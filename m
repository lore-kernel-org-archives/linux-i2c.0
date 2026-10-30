Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364244;
	b=JgEtEMiO22/sLs3ZNTZC/8RGgZVD61SMof+thZLKXOXNonlzYbJBisJNBX8R4tpz0nB/
	 lYnVoa5ILToCQCSdVtGAR2zyp6gVJVflO1S9IVT6GnjwbCB4TgV9XoJ7XA94tk32XhDgt
	 nSFyKI5scq5qkY7xR62FpoyaJL12udHYeaCfIKrX2tGsNkj3W0nVUmLqiVtD3Im0yKqyW
	 ZZVX53IMe24WpB+3i7e3R447YY2iWrOvACov0P5J2090FzZ5q+ANBpoRGJxNL//YA60C1
	 UrXUU6HHa/YhDfEjKaAGkFJ5wwRo2MXzwSoJPVvXwOoj22K/H8DrtIqabU3zr8W5neQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364244;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=bp0xk83sBOStew283WI/P44sA+HWkBFYPJ3dYB93FcA=;
	b=B/2EooPkVxB9+nwCj6mbUmJet6IG1csdLdToDt6Ry7wP/DBkZn86hnRJ9TBANug/U5kx
	 ZFGabCikWloDcaNkQNMcZrTDYhHm8SNwAQah1wCBeYSyt6pe8xuBuPUfky0ZSuro/GYe5
	 xTGBtmUsOdnHYxeJcmZCBa2g3y1WG+Kdw6HDwdvQRk3PAXH45mzjh4aNsh0+qnxLLWeEq
	 oVETyiU/3qAdKSUZ+GQUmimIRxw7N2s6SQxljQCGJQQ5E2z6KmEDBlvt0o9rZG71YAR42
	 3xQfSz+4G3dAZY0Rp462arxdYIms1ktkZVFB/QDF0jAENtcG+W0qvfu5cdJgJ84DVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nOR2Kfbx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a59sLekT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD14606A330
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BD14606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nOR2Kfbx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a59sLekT
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGUmx3130551
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bp0xk83sBOStew283WI/P44sA+HWkBFYPJ3dYB93FcA=; b=nOR2KfbxOK69PWTx
	jupJxTepsBUHQ80JCfqIvVcJcOMMYqRzyAz6NTsdx1M2S6JJeye57gUuiZPF+gC2
	6X/N0ySq0RdZ7KjkheuO5P9pO2nKw56Z8Bjjb5s8qn/agok3SoKjyAdpic9xxTKm
	1P3gRCBPM0pCgzfyiI4XqnQ/q8+p+VkUY9+DdcoajxroLiynUJStPE2b1PIp15c+
	G7GybS/1CoUFXIXo+VMQvytsNT8xgsIqgZcbA92vSzpC7azncdqQeVfsqMzLtB12
	plylD3Ecf2pN7J/oum/OA5HK2bdH107+tzJs/vaPGTPGbKI3PN32FGpMq3tIksH9
	5ZYQNw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qk0s2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 12:44:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e9d52f684fso7427035ad.2
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2026 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793364241; x=1793969041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bp0xk83sBOStew283WI/P44sA+HWkBFYPJ3dYB93FcA=;
        b=a59sLekT2tdkjd1kR7pJI5IXM/QNDWc6rgwnBPnHBcx96gIx/e1p7JC34YrHQXPp0/
         RoKAjVev6eFACibQ3lQwJSoZBGA69y060aQ8Q5NAp69sjR3SyEEAhHSpcG/ZFVFD2/FC
         +ABNgsY1dZ82LJhqKd1Zrjf7cgDyfXoyD5117uLiUwjn7c7ZJPSppku1gL/YlbhpC0Zf
         6fw3smmLg79rIAdg8W8gJBvTiKYRuR9MvMiK2+T9k2XBdU2B+RWBO8WTsvPebCl9ntYj
         /asyV6pMC/ZGkBpzfam6fxO0UGtN+yhGti4eRUm+rgvGGPVbD2ZYajsaXTF494WedF4h
         BfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364241; x=1793969041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bp0xk83sBOStew283WI/P44sA+HWkBFYPJ3dYB93FcA=;
        b=mz+4cTplbFeAa4AGE420bEI+jl0vJvn9wi0SiQbV9PvkRrWQ5xOo+iI0ZYFRCbBIi8
         ge2g1VsIgB/0z7rf9yHjaSR32pUSwRHeku7Ljc+ArvurSn+s9acl8QX5PKoIJ6WSOQOd
         KgougWuR+VA90imyN3kOKX79rb7b/dZcTsT/MY6mzkJhF4be4VRfo9lc80rAL6reAGzX
         IMkBqPJZtT8xCkvRmkvkcMlY8RHV/NZ8hvxM3XXv82HY8GejMLeIuDMhxAzfn9dbkRXx
         zTOAQKl33I/uyA1oJOBg/ktFPDlQlZR6IIcjU0gRD/OtOz/aP+bVD+Bw/CMj9E2cJW5E
         9lzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFggfbs0TE4AYv3rxZZI2JSlPuzzMmVCfV+/L8BfCx31iEgZBjJLKh+Z0KN0Y2RS2DVjxB4IbpgJw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS9JRLLwVZzs+5UAmPkhUvzOfXzferYNDV99UflIyB1LC3voDo
	Z8z8yrdnaM4sxVdrgQa48JnTtGisi5mMwCWK3rQDeEElnSEK+8imvKpT3OoTpQjlBfrm7zq9kTq
	Gq4IqzjlR6etgiCmq1jRZvabQz+mrxa4xgVOnzQQoFcBuRQVZYt2ZZgTz6O8X87KiC3H2mkc=
X-Gm-Gg: AYBFou0QJud8Hvs+f4VztwwcnU4U17OHlxh8CJ1xUlpgIa7R5y0xFFlaN0ezUrMyz+9
	bHlU1lmTqVLJtQOszavNfwclMviYLaHweLkQtE042L/XKmx7u7VsNw2csizPeyqy2fdphI8qyjA
	hs87zC1XDkIIy2ZDmNpTjxxmcoqR6NlXMaaKNKIlALpLiT72E/sWFHAeexJeCU/FCrpY1tkFlYD
	nicRXGFXLHcKQ8hJcZwGb2CTVoBsMhph9v/JChxvdgVHFgF53+Bj+qdWuLnp34xu+2cjncXM7Eu
	ggxz0Zsi2JLJuHSbMAbI5NcINjbjsqLovH1pMtwAu1Fy6ofs/F0bayXV7KY2IBrfr1VWDbGuG4Q
	EJkij5+oDbrNWC0eDMddHjBU4Phk9qQxTSt6BaOEC9b1xyCW3Bz9NrDPaKx6M3ybbea1hBYUSK8
	7BqFQ=
X-Received: by 2002:a17:903:3205:b0:2e9:5714:608b with SMTP id d9443c01a7336-2eb364b11ffmr24221375ad.34.1793364240901;
        Fri, 30 Oct 2026 05:44:00 -0700 (PDT)
X-Received: by 2002:a17:903:3205:b0:2e9:5714:608b with SMTP id d9443c01a7336-2eb364b11ffmr24220905ad.34.1793364240289;
        Fri, 30 Oct 2026 05:44:00 -0700 (PDT)
Received: from hu-nihalkum-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3922f5dasm6450075ad.25.2026.10.30.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:43:59 -0700 (PDT)
From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 18:13:05 +0530
Subject: [PATCH v3 5/5] media: qcom: camss: Add support for Hawi
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
Message-Id: <20261030-hawi-maili-camss-v3-5-9742bca8cef2@oss.qualcomm.com>
References: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
In-Reply-To: <20261030-hawi-maili-camss-v3-0-9742bca8cef2@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Suresh Vankadara <svankada@qti.qualcomm.com>,
        Vikram Sharma <vikram.sharma@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-media@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793364192; l=31138;
 i=nihal.gupta@oss.qualcomm.com; s=20260608; h=from:subject:message-id;
 bh=Sqb9nVQ2cHX5Ny1UbCLcxJ6z2EgiNzZ0z4Giklx7LEU=;
 b=5iTYBcp8jpreMbwdm0q0Vkv/zvA1S7Hi7LaT2VCbcWy0/U48yp8mBHmaZj7U0KI7dspB/j+x/
 VaJgkDO69pcAL9jau5uiiNvNhLpI7qRwcMcmq8ZMBfvELRPeLEpWcMj
X-Developer-Key: i=nihal.gupta@oss.qualcomm.com; a=ed25519;
 pk=DIbyFMNwqU/iMvU/0pCQp2wmRVgtHFBT3PcSu+A+Ncw=
X-Proofpoint-ORIG-GUID: cPZB0ViLO69-UzFrOdXWb3SrNMD_5G7g
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXz7HhF2ECN1se
 No3PtO6d3GHS2RRkG7sEPNVrEvqvAC6Q3VF0uaO/qS7WAbvNGNQOPyy35Cwl2x/CHJFawjLhubp
 LDCfIz+SjVFRsi5p1puXyREVg4AkZ3w=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae49112 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=h0cg83kO5dGNikamDmUA:9 a=II9370T-Td45Wm49:21
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: cPZB0ViLO69-UzFrOdXWb3SrNMD_5G7g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXxGm3yM03imcs
 m14u58ZYyzoFc4olrrgv+eaYQji7L7C85/5O7Jh7YUb+UTSqGhcdriSZ2aEE6lQwnQEMY+j6q8s
 WWTtSRcfYXsPP4CqZivzIZkdkLv/KtdbayN21oCpyjLTP6u4ikVU4/NfgRXbGxkkx4ZkbweRnU6
 /maZEKobS9K/RIzdHBSfqDMR7XCtNpBL1XIecNPzF+gxJHi+uN6/vPcgfJsDQEJEm7M8gV/05z1
 oinLFkRxnF0cjQ1OgTtlS4DmnsGpBaZDcLhgiL/E+065uCeXhi2n0JPL5HW0JlEEqEaURLmrraF
 h9BbO0AmPjf6iMjMgFnKN1ocfw50niveTMj58M7d+00rCFSXCj/2RFDMV6DmxoOJYIevOHWlkFL
 bRdaTIwblsN1HTUblW1T52G4YdANeANZIEVZ0gq+8+HSnjwKo5rgxti+bN7JVuLOub+RgT3BEWs
 At2VRYC8qDs4hp225EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add CAMSS support for the Hawi SoC. The CSIPHY resource table is reused
from Kaanapali and the TPG table from X1E80100.

Hawi calls its front-end blocks TFEs (Thin Front Ends), but the VFE 1190
driver keeps the VFE naming for consistency. The common CPAS clocks are
managed as PM clocks of the CAMSS resources rather than per-VFE clocks.

CSID 1190 splits RUP and AUP updates into separate registers committed
through a SET register, so the driver provides separate reg_update and
addr_update operations, and VFE 1190 wires up addr_update. The SOF and
EOF INFO bits are also defined.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-1190.c    | 417 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csid.h     |   1 +
 drivers/media/platform/qcom/camss/camss-vfe-1190.c | 217 +++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |   2 +
 drivers/media/platform/qcom/camss/camss-vfe.h      |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 229 +++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 8 files changed, 870 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 42a14e8fe1b7f28ba5ffcbe59769093b08db4d6b..e48df14933fa0e2b1910de5e68bec0b5c57dd1b2 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -9,6 +9,7 @@ qcom-camss-objs += \
 		camss-csid-340.o \
 		camss-csid-680.o \
 		camss-csid-1080.o \
+		camss-csid-1190.o \
 		camss-csid-gen2.o \
 		camss-csid-gen3.o \
 		camss-csiphy.o \
@@ -27,6 +28,7 @@ qcom-camss-objs += \
 		camss-vfe-480.o \
 		camss-vfe-680.o \
 		camss-vfe-1080.o \
+		camss-vfe-1190.o \
 		camss-vfe-gen1.o \
 		camss-vfe-gen3.o \
 		camss-vfe-vbif.o \
diff --git a/drivers/media/platform/qcom/camss/camss-csid-1190.c b/drivers/media/platform/qcom/camss/camss-csid-1190.c
new file mode 100644
index 0000000000000000000000000000000000000000..4bd2cce0944022ce0f987faa0e34417a665c0aa4
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid-1190.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-csid-1190.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+#include "camss.h"
+#include "camss-csid.h"
+#include "camss-csid-gen3.h"
+
+/* Reset and Command Registers */
+#define CSID_RST_CFG				0x108
+#define		RST_MODE				BIT(0)
+#define		RST_LOCATION				BIT(4)
+
+/* Reset and Command Registers */
+#define CSID_RST_CMD				0x10C
+#define		SELECT_HW_RST				BIT(0)
+#define		SELECT_IRQ_RST				BIT(2)
+#define CSID_IRQ_CMD				0x110
+#define		IRQ_CMD_CLEAR				BIT(0)
+
+/* Register Update Commands, RUP/AUP */
+#define CSID_RUP_CMD				0x114
+#define CSID_AUP_CMD				0x118
+#define		CSID_RUP_AUP_RDI(rdi)			(BIT(8) << (rdi))
+#define CSID_RUP_AUP_CMD			0x11C
+#define		RUP_SET					BIT(0)
+#define		MUP					BIT(4)
+
+/* Top level interrupt registers */
+#define CSID_TOP_IRQ_STATUS			0x180
+#define CSID_TOP_IRQ_MASK			0x184
+#define CSID_TOP_IRQ_CLEAR			0x188
+#define		INFO_RST_DONE				BIT(0)
+#define		CSI2_RX_IRQ_STATUS			BIT(2)
+#define		BUF_DONE_IRQ_STATUS			BIT(3)
+#define		TOP_IRQ_STATUS_RDI_OFFSET		16
+
+/* Buffer done interrupt registers */
+#define CSID_BUF_DONE_IRQ_STATUS		0x1A0
+#define		BUF_DONE_IRQ_STATUS_RDI_OFFSET		16
+#define CSID_BUF_DONE_IRQ_MASK			0x1A4
+#define CSID_BUF_DONE_IRQ_CLEAR			0x1A8
+#define CSID_BUF_DONE_IRQ_SET			0x1AC
+
+/* CSI2 RX interrupt registers */
+#define CSID_CSI2_RX_IRQ_STATUS			0x1B0
+#define CSID_CSI2_RX_IRQ_MASK			0x1B4
+#define CSID_CSI2_RX_IRQ_CLEAR			0x1B8
+#define CSID_CSI2_RX_IRQ_SET			0x1BC
+
+/* CSI2 RX Configuration */
+#define CSID_CSI2_RX_CFG0			0x880
+#define		CSI2_RX_CFG0_NUM_ACTIVE_LANES		0
+#define		CSI2_RX_CFG0_DL0_INPUT_SEL		4
+#define		CSI2_RX_CFG0_PHY_NUM_SEL		20
+#define		CSI2_RX_CFG0_TPG_MUX_EN			BIT(27)
+#define		CSI2_RX_CFG0_TPG_MUX_SEL		GENMASK(29, 28)
+#define		CSI2_RX_CFG0_PHY_SEL_BASE_IDX		1
+#define CSID_CSI2_RX_CFG1			0x884
+#define		CSI2_RX_CFG1_ECC_CORRECTION_EN		BIT(0)
+#define		CSI2_RX_CFG1_VC_MODE			BIT(2)
+
+#define MSM_CSID_MAX_SRC_STREAMS_1190		(csid_is_lite(csid) ? 4 : 5)
+
+/* RDI Configuration */
+#define CSID_RDI_CFG0(rdi)	(csid_is_lite(csid) ?\
+					(0x3080 + 0x200 * (rdi)) :\
+					(0x5480 + 0x200 * (rdi)))
+#define		RDI_CFG0_RETIME_BS			BIT(5)
+#define		RDI_CFG0_TIMESTAMP_EN			BIT(6)
+#define		RDI_CFG0_TIMESTAMP_STB_SEL		BIT(8)
+#define		RDI_CFG0_DECODE_FORMAT			12
+#define		RDI_CFG0_DT				16
+#define		RDI_CFG0_VC				22
+#define		RDI_CFG0_EN				BIT(31)
+
+/* RDI Control and Configuration */
+#define CSID_RDI_CTRL(rdi)	(csid_is_lite(csid) ?\
+					(0x3088 + 0x200 * (rdi)) :\
+					(0x5488 + 0x200 * (rdi)))
+#define		RDI_CTRL_START_CMD			BIT(0)
+
+#define CSID_RDI_CFG1(rdi)	(csid_is_lite(csid) ?\
+					(0x3094 + 0x200 * (rdi)) :\
+					(0x5494 + 0x200 * (rdi)))
+#define		RDI_CFG1_DROP_H_EN			BIT(5)
+#define		RDI_CFG1_DROP_V_EN			BIT(6)
+#define		RDI_CFG1_CROP_H_EN			BIT(7)
+#define		RDI_CFG1_CROP_V_EN			BIT(8)
+#define		RDI_CFG1_PACKING_FORMAT_MIPI		BIT(15)
+
+/* RDI Pixel Store Configuration */
+#define CSID_RDI_PIX_STORE_CFG0(rdi)	(0x5498 + 0x200 * (rdi))
+#define		RDI_PIX_STORE_CFG0_EN			BIT(0)
+#define		RDI_PIX_STORE_CFG0_MIN_HBI		1
+
+/* RDI IRQ Status in wrapper */
+#define CSID_CSI2_RDIN_IRQ_STATUS(rdi)	(0x224 + (0x10 * (rdi)))
+#define CSID_CSI2_RDIN_IRQ_MASK(rdi)	(0x228 + (0x10 * (rdi)))
+#define CSID_CSI2_RDIN_IRQ_CLEAR(rdi)	(0x22C + (0x10 * (rdi)))
+#define		INFO_RUP_DONE				BIT(23)
+#define		INFO_INPUT_SOF				BIT(12)
+#define		INFO_INPUT_EOF				BIT(9)
+#define		INFO_CAMIF_SOF				BIT(4)
+#define		INFO_CAMIF_EOF				BIT(3)
+
+static void __csid_aup_rup_trigger(struct csid_device *csid)
+{
+	/* trigger SET in combined register */
+	writel(RUP_SET, csid->base + CSID_RUP_AUP_CMD);
+}
+
+static void __csid_addr_update(struct csid_device *csid, int port_id)
+{
+	csid->addr_update |= CSID_RUP_AUP_RDI(port_id);
+	writel(csid->addr_update, csid->base + CSID_AUP_CMD);
+
+	__csid_aup_rup_trigger(csid);
+}
+
+static void __csid_addr_update_clear(struct csid_device *csid, int port_id)
+{
+	/* Hardware clears the registers upon consuming the settings */
+	csid->addr_update &= ~CSID_RUP_AUP_RDI(port_id);
+}
+
+static void __csid_reg_update(struct csid_device *csid, int port_id)
+{
+	csid->reg_update |= CSID_RUP_AUP_RDI(port_id);
+	writel(csid->reg_update, csid->base + CSID_RUP_CMD);
+
+	__csid_aup_rup_trigger(csid);
+}
+
+static void __csid_reg_update_clear(struct csid_device *csid, int port_id)
+{
+	/* Hardware clears the registers upon consuming the settings */
+	csid->reg_update &= ~CSID_RUP_AUP_RDI(port_id);
+}
+
+static void __csid_configure_rx(struct csid_device *csid,
+				struct csid_phy_config *phy)
+{
+	struct camss *camss = csid->camss;
+	u8 lane_cnt = csid->phy.lane_cnt;
+	int val;
+
+	if (!lane_cnt)
+		lane_cnt = 4;
+
+	val = (lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
+	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
+
+	if (camss->tpg && csid->tpg_linked &&
+	    camss->tpg[phy->csiphy_id].testgen.mode != TPG_PAYLOAD_MODE_DISABLED) {
+		val |= FIELD_PREP(CSI2_RX_CFG0_TPG_MUX_SEL, phy->csiphy_id + 1);
+		val |= CSI2_RX_CFG0_TPG_MUX_EN;
+	} else {
+		val |= (phy->csiphy_id + CSI2_RX_CFG0_PHY_SEL_BASE_IDX)
+			<< CSI2_RX_CFG0_PHY_NUM_SEL;
+	}
+
+	writel(val, csid->base + CSID_CSI2_RX_CFG0);
+
+	val = CSI2_RX_CFG1_ECC_CORRECTION_EN;
+	writel(val, csid->base + CSID_CSI2_RX_CFG1);
+}
+
+static void __csid_configure_rx_vc(struct csid_device *csid, int vc)
+{
+	int val;
+
+	if (vc > 3) {
+		val = readl(csid->base + CSID_CSI2_RX_CFG1);
+		val |= CSI2_RX_CFG1_VC_MODE;
+		writel(val, csid->base + CSID_CSI2_RX_CFG1);
+	}
+}
+
+static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
+{
+	int val = 0;
+
+	if (enable)
+		val = RDI_CTRL_START_CMD;
+
+	writel(val, csid->base + CSID_RDI_CTRL(rdi));
+}
+
+static void __csid_configure_rdi_pix_store(struct csid_device *csid, u8 rdi)
+{
+	u32 val;
+
+	/*
+	 * Configure pixel store to allow absorption of hblanking or idle time.
+	 * This helps with horizontal crop and prevents line buffer conflicts.
+	 * Reset state is 0x8 which has MIN_HBI=4, we keep the default MIN_HBI
+	 * and just enable the pixel store functionality.
+	 */
+	val = (4 << RDI_PIX_STORE_CFG0_MIN_HBI) | RDI_PIX_STORE_CFG0_EN;
+	writel(val, csid->base + CSID_RDI_PIX_STORE_CFG0(rdi));
+}
+
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 port, u8 vc)
+{
+	u32 val;
+	u8 lane_cnt = csid->phy.lane_cnt;
+
+	/* Source pads matching RDI channels on hardware.
+	 * E.g. Pad 1 -> RDI0, Pad 2 -> RDI1, etc.
+	 */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + port];
+	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
+								   csid->res->formats->nformats,
+								   input_format->code);
+
+	if (!lane_cnt)
+		lane_cnt = 4;
+
+	val = RDI_CFG0_TIMESTAMP_EN;
+	val |= RDI_CFG0_TIMESTAMP_STB_SEL;
+	val |= RDI_CFG0_RETIME_BS;
+
+	/* note: for non-RDI path, this should be format->decode_format */
+	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
+	val |= vc << RDI_CFG0_VC;
+	val |= format->data_type << RDI_CFG0_DT;
+	writel(val, csid->base + CSID_RDI_CFG0(port));
+
+	val = RDI_CFG1_PACKING_FORMAT_MIPI;
+	writel(val, csid->base + CSID_RDI_CFG1(port));
+
+	/* Configure pixel store using dedicated register in 1190 */
+	if (!csid_is_lite(csid))
+		__csid_configure_rdi_pix_store(csid, port);
+
+	val = 0;
+	writel(val, csid->base + CSID_RDI_CTRL(port));
+
+	val = readl(csid->base + CSID_RDI_CFG0(port));
+
+	if (enable)
+		val |= RDI_CFG0_EN;
+
+	writel(val, csid->base + CSID_RDI_CFG0(port));
+}
+
+static void csid_configure_stream(struct csid_device *csid, u8 enable)
+{
+	u8 i, k;
+
+	__csid_configure_rx(csid, &csid->phy);
+
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS_1190; i++) {
+		if (csid->phy.en_vc & BIT(i)) {
+			__csid_configure_rdi_stream(csid, enable, i, 0);
+			__csid_configure_rx_vc(csid, 0);
+
+			for (k = 0; k < CAMSS_INIT_BUF_COUNT; k++)
+				__csid_addr_update(csid, i);
+
+			__csid_reg_update(csid, i);
+
+			__csid_ctrl_rdi(csid, enable, i);
+		}
+	}
+}
+
+static int csid_configure_testgen_pattern(struct csid_device *csid, s32 val)
+{
+	return 0;
+}
+
+static void csid_subdev_reg_update(struct csid_device *csid, int port_id,
+				   bool clear)
+{
+	if (clear)
+		__csid_reg_update_clear(csid, port_id);
+	else
+		__csid_reg_update(csid, port_id);
+}
+
+static void csid_subdev_addr_update(struct csid_device *csid, int port_id,
+				    bool clear)
+{
+	if (clear)
+		__csid_addr_update_clear(csid, port_id);
+	else
+		__csid_addr_update(csid, port_id);
+}
+
+/**
+ * csid_isr - CSID module interrupt service routine
+ * @irq: Interrupt line
+ * @dev: CSID device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t csid_isr(int irq, void *dev)
+{
+	struct csid_device *csid = dev;
+	u32 val, buf_done_val;
+	u8 reset_done;
+	int i;
+
+	val = readl(csid->base + CSID_TOP_IRQ_STATUS);
+	writel(val, csid->base + CSID_TOP_IRQ_CLEAR);
+
+	reset_done = val & INFO_RST_DONE;
+
+	buf_done_val = readl(csid->base + CSID_BUF_DONE_IRQ_STATUS);
+	writel(buf_done_val, csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS_1190; i++) {
+		if (csid->phy.en_vc & BIT(i)) {
+			val = readl(csid->base + CSID_CSI2_RDIN_IRQ_STATUS(i));
+			writel(val, csid->base + CSID_CSI2_RDIN_IRQ_CLEAR(i));
+
+			if (val & INFO_RUP_DONE) {
+				__csid_addr_update_clear(csid, i);
+				__csid_reg_update_clear(csid, i);
+			}
+
+			if (buf_done_val & BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i))
+				camss_buf_done(csid->camss, csid->id, i);
+		}
+	}
+
+	val = IRQ_CMD_CLEAR;
+	writel(val, csid->base + CSID_IRQ_CMD);
+
+	if (reset_done)
+		complete(&csid->reset_complete);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * csid_reset - Trigger reset on CSID module and wait to complete
+ * @csid: CSID device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_reset(struct csid_device *csid)
+{
+	unsigned long time;
+	u32 val;
+	int i;
+
+	reinit_completion(&csid->reset_complete);
+
+	val = INFO_RST_DONE | BUF_DONE_IRQ_STATUS;
+	writel(val, csid->base + CSID_TOP_IRQ_CLEAR);
+	writel(val, csid->base + CSID_TOP_IRQ_MASK);
+
+	val = 0;
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS_1190; i++) {
+		if (csid->phy.en_vc & BIT(i)) {
+			/*
+			 * Only need to clear buf done IRQ status here,
+			 * RUP done IRQ status will be cleared once isr
+			 * strobe generated by CSID_RST_CMD
+			 */
+			val |= BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i);
+		}
+	}
+	writel(val, csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+	writel(val, csid->base + CSID_BUF_DONE_IRQ_MASK);
+
+	/* Clear all IRQ status with CLEAR bits set */
+	val = IRQ_CMD_CLEAR;
+	writel(val, csid->base + CSID_IRQ_CMD);
+
+	val = RST_LOCATION | RST_MODE;
+	writel(val, csid->base + CSID_RST_CFG);
+
+	val = SELECT_HW_RST | SELECT_IRQ_RST;
+	writel(val, csid->base + CSID_RST_CMD);
+
+	time = wait_for_completion_timeout(&csid->reset_complete,
+					   msecs_to_jiffies(CSID_RESET_TIMEOUT_MS));
+
+	if (!time) {
+		dev_err(csid->camss->dev, "CSID reset timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void csid_subdev_init(struct csid_device *csid)
+{
+	csid->testgen.nmodes = CSID_PAYLOAD_MODE_DISABLED;
+}
+
+const struct csid_hw_ops csid_ops_1190 = {
+	.configure_stream = csid_configure_stream,
+	.configure_testgen_pattern = csid_configure_testgen_pattern,
+	.hw_version = csid_hw_version,
+	.isr = csid_isr,
+	.reset = csid_reset,
+	.src_pad_code = csid_src_pad_code,
+	.subdev_init = csid_subdev_init,
+	.reg_update = csid_subdev_reg_update,
+	.addr_update = csid_subdev_addr_update,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index a3ab2a384bb49ac24955e86c8452a8ce36ce71b2..7bdf183d28c8ac33833cc974cae2cc79d4bef415 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -226,6 +226,7 @@ extern const struct csid_hw_ops csid_ops_4_7;
 extern const struct csid_hw_ops csid_ops_340;
 extern const struct csid_hw_ops csid_ops_680;
 extern const struct csid_hw_ops csid_ops_1080;
+extern const struct csid_hw_ops csid_ops_1190;
 extern const struct csid_hw_ops csid_ops_gen2;
 extern const struct csid_hw_ops csid_ops_gen3;
 
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-1190.c b/drivers/media/platform/qcom/camss/camss-vfe-1190.c
new file mode 100644
index 0000000000000000000000000000000000000000..246519c2294b8d5021ebdd95e056f00d20897a0f
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-vfe-1190.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-vfe-1190.c
+ *
+ * Qualcomm MSM Camera Subsystem - VFE (Video Front End) Module 1190
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
+/* VFE-1190 Bus Register Base Addresses */
+#define BUS_REG_BASE				(0x800)
+#define BUS_REG_OFFSET(n)			(0x1000 + (n) * 0x200)
+
+#define VFE_BUS_WM_CGC_OVERRIDE			(BUS_REG_BASE + 0x4)
+#define		WM_CGC_OVERRIDE_ALL			(0x7FFFFFF)
+
+#define VFE_BUS_WM_TEST_BUS_CTRL		(BUS_REG_BASE + 0x144)
+
+#define VFE_BUS_WM_CFG(n)			(BUS_REG_BASE + BUS_REG_OFFSET(n))
+#define		WM_CFG_EN				BIT(0)
+#define		WM_VIR_FRM_EN				BIT(1)
+#define		WM_CFG_MODE				BIT(16)
+#define VFE_BUS_WM_IMAGE_ADDR(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x4)
+#define VFE_BUS_WM_FRAME_INCR(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x8)
+#define VFE_BUS_WM_IMAGE_CFG_0(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0xC)
+#define		WM_IMAGE_CFG_0_DEFAULT_WIDTH		(0xFFFF)
+#define VFE_BUS_WM_IMAGE_CFG_2(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x14)
+#define		WM_IMAGE_CFG_2_DEFAULT_STRIDE		(0xFFFF)
+#define VFE_BUS_WM_PACKER_CFG(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x18)
+
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PERIOD(n)	(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x30)
+#define VFE_BUS_WM_IRQ_SUBSAMPLE_PATTERN(n)	(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x34)
+
+/* VFE lite has no such registers */
+#define VFE_BUS_WM_FRAMEDROP_PERIOD(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x38)
+#define VFE_BUS_WM_FRAMEDROP_PATTERN(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x3C)
+
+#define VFE_BUS_WM_MMU_PREFETCH_CFG(n)		(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x64)
+#define VFE_BUS_WM_MMU_PREFETCH_MAX_OFFSET(n)	(BUS_REG_BASE + BUS_REG_OFFSET(n) + 0x68)
+
+/*
+ * VFE 1190 write master client IDs
+ *
+ * VIDEO_FULL_Y			0
+ * VIDEO_FULL_UV		1
+ * VIDEO_DC4_Y			2
+ * VIDEO_DC4_C			3
+ * VIDEO_DC16_Y			4
+ * VIDEO_DC16_C			5
+ * FD_Y				6
+ * FD_C				7
+ * RAW_OUT			8
+ * STATS_AEC_BG			9
+ * STATS_AEC_BHIST		10
+ * STATS_TINTLESS_BG		11
+ * STATS_AWB_BG			12
+ * STATS_AWB_BFW		13
+ * STATS_AF_BHIST		14
+ * STATS_ALSC_BG		15
+ * STATS_FLICKER_BAYERRS	16
+ * STATS_TMC_BHIST		17
+ * PDAF_0			18
+ * PDAF_1			19
+ * PDAF_2			20
+ * PDAF_3			21
+ * PDAF_4			22
+ * RDI0				23
+ * RDI1				24
+ * RDI2				25
+ * RDI3				26
+ * RDI4				27
+ * C2PA Y			28
+ * C2PA C			29
+ *
+ * VFE Lite 1190 write master client IDs
+ *
+ * RDI0			0
+ * RDI1			1
+ * RDI2			2
+ * RDI3			3
+ * GAMMA		4
+ * STATES_BG		5
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
+static inline void vfe_reg_update_clear(struct vfe_device *vfe,
+					enum vfe_line_id line_id)
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
+static inline void vfe_addr_update_clear(struct vfe_device *vfe,
+					 enum vfe_line_id line_id)
+{
+	int port_id = line_id;
+
+	camss_addr_update(vfe->camss, vfe->id, port_id, true);
+}
+
+static const struct camss_video_ops vfe_video_ops_1190 = {
+	.queue_buffer = vfe_queue_buffer_v2,
+	.flush_buffers = vfe_flush_buffers,
+};
+
+static void vfe_subdev_init(struct device *dev, struct vfe_device *vfe)
+{
+	vfe->video_ops = vfe_video_ops_1190;
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
+const struct vfe_hw_ops vfe_ops_1190 = {
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
index 221abf7bfd47e43e685d4b9a5efc10b066ff8bc2..96ac839663752b9c5164cc35f9fb7f877e67fda7 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -353,6 +353,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
 	case CAMSS_8550:
 	case CAMSS_8650:
 	case CAMSS_8775P:
+	case CAMSS_HAWI:
 	case CAMSS_KAANAPALI:
 	case CAMSS_X1E80100:
 		switch (sink_code) {
@@ -2021,6 +2022,7 @@ static int vfe_bpl_align_rdi(struct vfe_device *vfe)
 	case CAMSS_8550:
 	case CAMSS_8650:
 	case CAMSS_8775P:
+	case CAMSS_HAWI:
 	case CAMSS_KAANAPALI:
 	case CAMSS_X1E80100:
 		ret = 16;
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.h b/drivers/media/platform/qcom/camss/camss-vfe.h
index 0a91440cfe438625f7f1b71b60186491b3d24d5d..8cc5571e0b91080705c675bb09ff6eb931e6e5fc 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.h
+++ b/drivers/media/platform/qcom/camss/camss-vfe.h
@@ -252,6 +252,7 @@ extern const struct vfe_hw_ops vfe_ops_340;
 extern const struct vfe_hw_ops vfe_ops_480;
 extern const struct vfe_hw_ops vfe_ops_680;
 extern const struct vfe_hw_ops vfe_ops_1080;
+extern const struct vfe_hw_ops vfe_ops_1190;
 extern const struct vfe_hw_ops vfe_ops_gen3;
 
 int vfe_get(struct vfe_device *vfe);
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index df4b4cf30711be62e7403553fbc0f674217fcb56..0a67d4f746eebce0470a1d7648f05b3b76dd356c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4359,6 +4359,218 @@ static const struct resources_icc icc_res_sa8775p[] = {
 	},
 };
 
+static const struct camss_subdev_resources vfe_res_hawi[] = {
+	/* VFE0 - TFE Full */
+	{
+		.clock = { "vfe0_fast_ahb", "vfe0", "cpas_vfe0",
+			   "camnoc_rt_axi", "camnoc_nrt_axi", "qdss_debug_xo",
+			   "cpas_mnoc_hf", "cpas_mnoc_sf" },
+		.clock_rate = { { 0 },
+				{ 238200000, 397000000, 440000000, 480000000,
+				  630000000, 750000000, 833000000 },
+				{ 0 },
+				{ 171428571, 240000000, 300000000, 400000000,
+				  480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife0",
+			.hw_ops = &vfe_ops_1190,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE1 - TFE Full */
+	{
+		.clock = { "vfe1_fast_ahb", "vfe1", "cpas_vfe1",
+			   "camnoc_rt_axi", "camnoc_nrt_axi", "qdss_debug_xo",
+			   "cpas_mnoc_hf", "cpas_mnoc_sf" },
+		.clock_rate = { { 0 },
+				{ 238200000, 397000000, 440000000, 480000000,
+				  630000000, 750000000, 833000000 },
+				{ 0 },
+				{ 171428571, 240000000, 300000000, 400000000,
+				  480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife1",
+			.hw_ops = &vfe_ops_1190,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE2 - TFE Full */
+	{
+		.clock = { "vfe2_fast_ahb", "vfe2", "cpas_vfe2",
+			   "camnoc_rt_axi", "camnoc_nrt_axi", "qdss_debug_xo",
+			   "cpas_mnoc_hf", "cpas_mnoc_sf" },
+		.clock_rate = { { 0 },
+				{ 238200000, 397000000, 440000000, 480000000,
+				  630000000, 750000000, 833000000 },
+				{ 0 },
+				{ 171428571, 240000000, 300000000, 400000000,
+				  480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "vfe2" },
+		.interrupt = { "vfe2" },
+		.vfe = {
+			.line_num = 3,
+			.has_pd = true,
+			.pd_name = "ife2",
+			.hw_ops = &vfe_ops_1190,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE3 - IFE Lite */
+	{
+		.clock = { "vfe_lite_ahb", "vfe_lite", "cpas_vfe_lite",
+			   "camnoc_rt_axi", "camnoc_nrt_axi", "qdss_debug_xo",
+			   "cpas_mnoc_hf", "cpas_mnoc_sf" },
+		.clock_rate = { { 0 },
+				{ 200000000, 400000000, 480000000 },
+				{ 0 },
+				{ 171428571, 240000000, 300000000, 400000000,
+				  480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "vfe_lite0" },
+		.interrupt = { "vfe_lite0" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = true,
+			.hw_ops = &vfe_ops_1190,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+	/* VFE4 - IFE Lite */
+	{
+		.clock = { "vfe_lite_ahb", "vfe_lite", "cpas_vfe_lite",
+			   "camnoc_rt_axi", "camnoc_nrt_axi", "qdss_debug_xo",
+			   "cpas_mnoc_hf", "cpas_mnoc_sf" },
+		.clock_rate = { { 0 },
+				{ 200000000, 400000000, 480000000 },
+				{ 0 },
+				{ 171428571, 240000000, 300000000, 400000000,
+				  480000000, 600000000 },
+				{ 0 },
+				{ 0 },
+				{ 0 },
+				{ 0 } },
+		.reg = { "vfe_lite1" },
+		.interrupt = { "vfe_lite1" },
+		.vfe = {
+			.line_num = 3,
+			.is_lite = true,
+			.hw_ops = &vfe_ops_1190,
+			.formats_rdi = &vfe_formats_rdi_845,
+			.formats_pix = &vfe_formats_pix_845
+		}
+	},
+};
+
+static const struct camss_subdev_resources csid_res_hawi[] = {
+	/* CSID0 */
+	{
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 480000000 },
+				{ 480000000 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" },
+		.csid = {
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1190,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID1 */
+	{
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 480000000 },
+				{ 480000000 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" },
+		.csid = {
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1190,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID2 */
+	{
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 480000000 },
+				{ 480000000 } },
+		.reg = { "csid2" },
+		.interrupt = { "csid2" },
+		.csid = {
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1190,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE0 */
+	{
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
+		.clock_rate = { { 480000000 },
+				{ 480000000 } },
+		.reg = { "csid_lite0" },
+		.interrupt = { "csid_lite0" },
+		.csid = {
+			.is_lite = true,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1190,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE1 */
+	{
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
+		.clock_rate = { { 480000000 },
+				{ 480000000 } },
+		.reg = { "csid_lite1" },
+		.interrupt = { "csid_lite1" },
+		.csid = {
+			.is_lite = true,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1190,
+			.formats = &csid_formats_gen2
+		}
+	}
+};
+
+static const struct resources_icc icc_res_hawi[] = {
+	{
+		.name = "ahb",
+		.icc_bw_tbl.avg = 38400,
+		.icc_bw_tbl.peak = 76800,
+	},
+	{
+		.name = "hf_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+};
+
 static const struct camss_subdev_resources csiphy_res_x1e80100[] = {
 	/* CSIPHY0 */
 	{
@@ -6078,6 +6290,22 @@ static const struct camss_resources sm8650_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_sm8650),
 };
 
+static const struct camss_resources hawi_resources = {
+	.version = CAMSS_HAWI,
+	.pd_name = "top",
+	.pm_clks = { "cpas_fast_ahb", "cpas_ahb", "gcc_axi_hf" },
+	.csiphy_res = csiphy_res_kaanapali,
+	.tpg_res = tpg_res_x1e80100,
+	.csid_res = csid_res_hawi,
+	.vfe_res = vfe_res_hawi,
+	.icc_res = icc_res_hawi,
+	.icc_path_num = ARRAY_SIZE(icc_res_hawi),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_kaanapali),
+	.tpg_num = ARRAY_SIZE(tpg_res_x1e80100),
+	.csid_num = ARRAY_SIZE(csid_res_hawi),
+	.vfe_num = ARRAY_SIZE(vfe_res_hawi),
+};
+
 static const struct camss_resources x1e80100_resources = {
 	.version = CAMSS_X1E80100,
 	.pd_name = "top",
@@ -6113,6 +6341,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
 	{ .compatible = "qcom,sm8650-camss", .data = &sm8650_resources },
+	{ .compatible = "qcom,hawi-camss", .data = &hawi_resources },
 	{ .compatible = "qcom,x1e80100-camss", .data = &x1e80100_resources },
 	{ .compatible = "qcom,glymur-camss", .data = &x1e80100_resources },
 	{ }
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 97fec24e680461a477add23bf5fb0b486903ba5b..95bbf4eb2a63fcd1852716a8d47493f49247c732 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -96,6 +96,7 @@ enum camss_version {
 	CAMSS_8550,
 	CAMSS_8650,
 	CAMSS_8775P,
+	CAMSS_HAWI,
 	CAMSS_KAANAPALI,
 	CAMSS_X1E80100,
 };

-- 
2.34.1

