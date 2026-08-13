Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B8374730
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636383; cv=none; b=MczoevYuWJQaRszRVVofc5UQLGwZMOwv+UAPCtbaRe2TxDOVuNeGiSIlFQRGz3BuyqucQmuK23oL+BAdGfpSC8Ld4BextwQn6pz70lfIule9ArhAmmx6A/TzBtY4zB0ZmZ7gywNXODjI5l9TdEcotJ2Veg6DfuGoD/kyzBxlg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636383; c=relaxed/simple;
	bh=w2NK+UxF1WGy+ejBEEGkfK1KMVD2AQp69yayOMFYyJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFt7wxkvt7FtmoaH8NMfBuBs/M2CUxRqgejw25saL6iNlP6NAwNJhDg4MrFyBm8XfoyRbHP+24p4zv3Dxwei+BWCs5wyKwVBsQ7JO9chWkr7FkJsPZlFZfMlyeEI/dCvKS3e+BoSsWwq2D/lS1RyvcNraUw4Ud9gO+08rJB3EKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aO4t43Ji; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QD7jp98Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aO4t43Ji";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QD7jp98Z"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFqujo3180967
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 15:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yC3TryQESA4DO6vdLupW7dihOAneVFh4JcKLBHCxCIg=; b=aO4t43JiJCQ0Kx+k
	zRwTr+1HlIRVfEgxZSZN12A0xxZD2FMrBTNyy23Ica2dXtATyyW0slWuztJfGx4U
	deL+d09eleQElEKg3o5GEISlSnWPEeYzUd3bC5tSHgONaveKgGl279vwx7yxSReS
	oGdKSq+FRYVdYAoBXkwj8GzfQOUSEbmeeiJeXPDEhJXXJKR72QO5NhrmKrOEqgNL
	eYby+SVQw3v1Iv17UuN3VAFzU4H8IL/pcgLxrrGgKYSJcUKEcuWzgqv2eUTrDVsm
	zzRF5CVWJTTLfaHqu/lg5oMnoAGMXEz0X2LnshaJe6MgX5xaHWYuShMfMXwzKjfX
	FXdvFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4r00e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 15:52:56 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84885a4fcabso2347324b3a.3
        for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786636375; x=1787241175; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yC3TryQESA4DO6vdLupW7dihOAneVFh4JcKLBHCxCIg=;
        b=QD7jp98ZJIguQh+R40yvQsSynxbU/Xgo8RHgDrFJlBbcxxzcMdtuFqf/a9lire/HqY
         mNYrpH7lENPUFodQXewDYpLfTX1BoKabOKc7402yXxtvjkG0zT4wqtjfGX5KmYAURYys
         y5H+jgVlud/lL/AWZu1gGr60pX+7jBb0VtOMZ64alB/Pp2tuRWWlT2lZG4d66OKCKI2c
         GVZYWmUxrbD7t95grOZMSl8XeQCk2pj3FFzbnIgzGR0omizwGZ5hkUhDnmJIvuzSeaF3
         dswwFDFMW383d/jnSgsnWkoteuMFnWeGO41PF15YtUiqQ9ID0+hWSb1xr8fIVpL6FHAC
         TLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786636375; x=1787241175;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yC3TryQESA4DO6vdLupW7dihOAneVFh4JcKLBHCxCIg=;
        b=SoZJ/PTgrAD4+fj/p8sWy9/HNkatKFMgkfmVHZoyGEhwKHq2lr5s6XnYniqQB86iJk
         cr/8YQUezjUSEYk7vvjG6WGmuiDQeOCqaCTrG8zpxOG+QYeTduzpK+MBdSuRA1kndpOx
         45/MQG/MrFpqoW60NeeovyPLoXTnptqxFUslO+dBsdGXCBupyLs9pCwla4jqcTGUyQZa
         vtR+Fw4/p2EU7dp0h2q+kehsZyp9GIW8nn9Rfr8/2GzODbnCbypw9ze9QBi71ZP8igfJ
         fnw15lZbYw9hV451gLTJa4EsmbJG6afvnIQV1JLOnk672greP9rSwI8lvmZmuW0+s/N5
         BX6g==
X-Forwarded-Encrypted: i=1; AHgh+RqZ9IZfR2TeXGtDOmq9OfW0OfJGVOapuGbnHt9p1lu5ubo/KN3GHEACLwUKCx/XMh9EK/Jsadsp2F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgL2WjLKXj6rOvIITzknpeFJhTUQx5PWWlDn7febGZZMD2c60
	qaXcl/+eRdt5jXEmxczMMZ3srtuPq/V78tPbXIUXRo/lOamn1/7pefpw7ttNeITp+5oyXLYLBrp
	RDtx3GdHNXCpCM+w5mcz5kEtI/sgfwroMMvyuw8ltUcdZq/snZ9aXWkGh395/gss=
X-Gm-Gg: AR+sD13e8yM7IknCpQFeCH08YnFKWzP8mV4teCQm6w5lIOaP8QatqR7XiNpiYjyasZo
	BNRDVuWRBzAgWAA5LAVvff/I3RM3AfQ0DfT5mxQzBkT6+c66koRu1WlxFfLU3iSaTl+4nlkm0g0
	ITpvWZqu+tL6ZkjyAtMDqSRcLUfjXhU5ZAOqo0et5k56QBW1JYurF91U9eGIrR1/9UL2j96w4EA
	Tj4zo5aghP5pw1higBhEaRIaN9LbrFERQu1WquYE/LilCN+O7ptBpRrHCMNVZoBO65sGXqkFz8D
	2kSh36iUz+H46iHtdzzNgozi4HtwndzoMODt1fq2wyP9FLEfB09ggjQaFcdOwDFTFPbIIuIf2Ck
	YVr1HUJVSCdnW81P39T6TBRwtkABnvQ5nthma
X-Received: by 2002:a05:6a00:1d9e:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84fc7159dbamr7467301b3a.31.1786636374774;
        Thu, 13 Aug 2026 08:52:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d9e:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84fc7159dbamr7467228b3a.31.1786636374192;
        Thu, 13 Aug 2026 08:52:54 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc45627cdsm1156401b3a.5.2026.08.13.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:52:53 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 21:22:33 +0530
Subject: [PATCH v3 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260813-i2c-qcom-slave-v3-2-1d3742e2ad47@oss.qualcomm.com>
References: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
In-Reply-To: <20260813-i2c-qcom-slave-v3-0-1d3742e2ad47@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786636361; l=23051;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=w2NK+UxF1WGy+ejBEEGkfK1KMVD2AQp69yayOMFYyJk=;
 b=LeDwxhWX+G1DFTX7X23lphk/8xz0zkHk4cwVvSEHcP0qXH7QItWBVqS9b9VjWhq7+8ouRNdTT
 s9mH7C1lfWJCU9wdGr2H3oGSMPc3b+WUodKId1tAmb6s35XZa9Vn/+1
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 2h6922Ys-AhN_tt29uW-hxpIrEJIM9T6
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7de858 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=vwmBirkCen0xCiisDnMA:9
 a=inJLjF9DGj1vjSAe:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfX9Bf+otnaKU26
 ppBWgWIKF50BxTskdcEVF9uJU8/NW8m3l+7eVhnE3k+Ydq/k05QimjvGtSqp5WgN4sGSTOF2pAX
 D2yhGDwy8CQKDbyD9Yee/MvkgcWTjjA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNCBTYWx0ZWRfX6ajVme7Fvqs+
 E9PYKPghoXs5W9lU38IbNxWiVC5BhCk6dGhLG5YHs4DYeR8Tat+3ZFwN7jcGB7zy9Q6ugswVZDE
 gngaAJNc+Ewf8QkJJl1TF+Is8z0y6R56WRgTzBeo9QFMwaUfeG/ApKrTCQ+OxbZ/Qfs80G/afeW
 meQefC4txAvO6eDYPNPdhXxibYe9jWBk5nBj3oy90yyoVjiOVxaQDN9KH/0LBspUuW2p1elOMYx
 O9/qhzH7X6+36EgEzEy0IIYlEeQo4FWbMUalWlYvjH8ryM+sayHLhr+cVLb8sEehjAmd/8i4cmO
 Eoun24V+Y6bsg6dR4gjdTvnINKPXYG9mZ2ZGf+k4ZcQwvtx09bb9vLZu0B/0fIzAYEmLvHCF3RK
 t51mY+wLXWb1+/7yWgEQRjVtOalUMBdKbMbtU18mwQZdrwbiVnKDD0rkT2d5p6Yntclpol67A1W
 nbzbljWYo22wJ5sqL3g==
X-Proofpoint-GUID: 2h6922Ys-AhN_tt29uW-hxpIrEJIM9T6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130114

QDU1000 and related Qualcomm SoCs include a dedicated I2C target
controller that operates exclusively in target mode. The existing
Qualcomm I2C controller drivers (GENI, QUP) are master-only and cannot
serve systems where the SoC must respond as an I2C target on the bus.

Register the controller with the Linux I2C slave framework via
i2c_algorithm.reg_target and i2c_algorithm.unreg_target so that any
standard slave backend (e.g. slave-24c02) can be attached at runtime
via i2c_slave_register(). Handle IRQ events for RX FIFO service, clock
stretching during read and write phases, STOP and repeated-start
conditions, and error recovery with SW reset. Enable the required AHB
and XO clocks, vote for interconnect bandwidth, and restore hardware
state across suspend and resume using the noirq PM callbacks.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 MAINTAINERS                          |   9 +
 drivers/i2c/busses/Kconfig           |  15 +
 drivers/i2c/busses/Makefile          |   1 +
 drivers/i2c/busses/i2c-qcom-target.c | 588 +++++++++++++++++++++++++++++++++++
 4 files changed, 613 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe67f7bfa44c..7a2d66385e36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22380,6 +22380,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
 F:	drivers/i2c/busses/i2c-qcom-geni.c
 
+QUALCOMM I2C TARGET CONTROLLER DRIVER
+M:	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
+M:	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/qcom,qdu1000-i2c-target.yaml
+F:	drivers/i2c/busses/i2c-qcom-target.c
+
 QUALCOMM I2C CCI DRIVER
 M:	Loic Poulain <loic.poulain@oss.qualcomm.com>
 M:	Robert Foss <rfoss@kernel.org>
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311f..2e18238e0ae6 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1070,6 +1070,21 @@ config I2C_QCOM_GENI
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-qcom-geni.
 
+config I2C_QCOM_TARGET
+	tristate "Qualcomm I2C target controller"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on COMMON_CLK
+	depends on INTERCONNECT
+	select I2C_SLAVE
+	help
+	  This driver supports I2C target mode on Qualcomm Technologies
+	  SoCs. If you say yes to this option, support will be included
+	  for the built-in I2C target controller on QDU1000 and other
+	  compatible Qualcomm SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-qcom-target.
+
 config I2C_QUP
 	tristate "Qualcomm QUP based I2C controller"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 3755c54b3d82..ab3070cdb144 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
 obj-$(CONFIG_I2C_PXA_PCI)	+= i2c-pxa-pci.o
 obj-$(CONFIG_I2C_QCOM_CCI)	+= i2c-qcom-cci.o
 obj-$(CONFIG_I2C_QCOM_GENI)	+= i2c-qcom-geni.o
+obj-$(CONFIG_I2C_QCOM_TARGET)	+= i2c-qcom-target.o
 obj-$(CONFIG_I2C_QUP)		+= i2c-qup.o
 obj-$(CONFIG_I2C_RIIC)		+= i2c-riic.o
 obj-$(CONFIG_I2C_RK3X)		+= i2c-rk3x.o
diff --git a/drivers/i2c/busses/i2c-qcom-target.c b/drivers/i2c/busses/i2c-qcom-target.c
new file mode 100644
index 000000000000..277ea944eedb
--- /dev/null
+++ b/drivers/i2c/busses/i2c-qcom-target.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/* Register offsets */
+#define I2C_S_DEVICE_ADDR			0x00
+#define I2C_S_IRQ_STATUS			0x08
+#define I2C_S_IRQ_CLR				0x0C
+#define I2C_S_IRQ_EN				0x10
+#define I2C_S_CONFIG				0x18
+#define I2C_S_CONTROL				0x1C
+#define I2C_S_FIFOS_STATUS			0x20
+#define I2C_S_TX_FIFO				0x24
+#define I2C_S_RX_FIFO				0x28
+#define I2C_S_DEBUG_REG1			0x3C
+#define I2C_S_DEBUG_REG2			0x40
+#define I2C_S_SW_RESET_REG			0x4C
+#define I2C_S_CLK_LOW_TIMEOUT			0x50
+#define I2C_S_CLK_RELEASE_DELAY_CNT_VAL	0x54
+#define I2C_S_SDA_HOLD_CNT_VAL			0x58
+
+/* I2C_S_CONFIG register fields */
+#define I2C_S_CORE_EN				BIT(0)
+
+/* I2C_S_CONTROL register fields */
+#define CLEAR_RX_FIFO				BIT(0)
+#define CLEAR_TX_FIFO				BIT(1)
+#define NACK					BIT(2)
+#define ACK_RESUME				BIT(3)
+
+/* I2C_S_SW_RESET_REG register fields */
+#define SW_RESET				BIT(0)
+
+/* I2C_S_FIFOS_STATUS register fields */
+#define RX_FIFO_COUNT_MASK			GENMASK(31, 16)
+
+/* Interconnect bandwidth vote in bytes per second */
+#define APPS_PROC_TO_I2C_TARGET_VOTE		1190000
+
+/**
+ * enum qcom_i2c_target_irq - IRQ bit positions in I2C_S_IRQ_STATUS
+ * @STOP_DETECTED:	I2C stop condition detected on the bus
+ * @RX_FIFO_FULL:	receive FIFO has reached capacity
+ * @TX_FIFO_EMPTY:	transmit FIFO is empty
+ * @RX_DATA_AVAIL:	receive data is available in the RX FIFO
+ * @CLOCK_LOW_TIMEOUT:	SCL held low longer than the configured timeout
+ * @STRCH_WR:		clock stretching during a write (Rx) phase
+ * @STRCH_RD:		clock stretching during a read (Tx) phase
+ * @GCA_DETECTED:	general call address detected (not used)
+ * @ERR_CONDITION:	unexpected start or stop bit detected (error)
+ * @RESTART_DETECTED:	repeated start condition detected
+ */
+enum qcom_i2c_target_irq {
+	STOP_DETECTED,
+	RX_FIFO_FULL,
+	TX_FIFO_EMPTY,
+	RX_DATA_AVAIL,
+	CLOCK_LOW_TIMEOUT,
+	STRCH_WR,
+	STRCH_RD,
+	GCA_DETECTED,
+	ERR_CONDITION,
+	RESTART_DETECTED,
+};
+
+/*
+ * TX_FIFO_EMPTY is excluded: this driver fills the TX FIFO one byte at a
+ * time in response to STRCH_RD (clock-stretch during read phase), so
+ * TX_FIFO_EMPTY adds no value and would double the interrupt rate.
+ * GCA (general call address) is unsupported.
+ */
+#define QCOM_I2C_TARGET_ALL_IRQ	(GENMASK(RESTART_DETECTED, STOP_DETECTED) \
+				 & ~(BIT(GCA_DETECTED) | BIT(TX_FIFO_EMPTY)))
+
+/* Bit indices for the status bitmask, used with set_bit/test_bit/clear_bit */
+enum qcom_i2c_target_status {
+	READ_IN_PROGRESS,
+	WRITE_IN_PROGRESS,
+};
+
+/**
+ * struct qcom_i2c_target - Qualcomm I2C target controller private data
+ * @dev:		driver model device node
+ * @base:		base address of HW registers
+ * @adap:		I2C adapter (slave mode)
+ * @ahb_clk:		AHB bus clock
+ * @xo_clk:		XO reference clock
+ * @icc_path:		interconnect bandwidth path
+ * @slave:		currently registered slave backend client; written only
+ *			under disable_irq() in reg_slave()/unreg_slave() so the
+ *			ISR sees a stable pointer for its entire execution
+ * @status:		bitmask of enum qcom_i2c_target_status flags; must be
+ *			unsigned long for set_bit/test_bit/clear_bit; accessed
+ *			only from the ISR and from reg_slave()/unreg_slave()
+ *			under disable_irq(), so no additional lock is needed
+ * @irq:		interrupt line number
+ */
+struct qcom_i2c_target {
+	struct device		*dev;
+	void __iomem		*base;
+	struct i2c_adapter	adap;
+	struct clk		*ahb_clk;
+	struct clk		*xo_clk;
+	struct icc_path		*icc_path;
+	struct i2c_client	*slave;
+	unsigned long		status;
+	int			irq;
+};
+
+static void qcom_i2c_target_dump_regs(struct qcom_i2c_target *target)
+{
+	dev_dbg(target->dev, "I2C_S_DEVICE_ADDR:               0x%x\n",
+		readl_relaxed(target->base + I2C_S_DEVICE_ADDR));
+	dev_dbg(target->dev, "I2C_S_IRQ_STATUS:                0x%x\n",
+		readl_relaxed(target->base + I2C_S_IRQ_STATUS));
+	dev_dbg(target->dev, "I2C_S_CONFIG:                    0x%x\n",
+		readl_relaxed(target->base + I2C_S_CONFIG));
+	dev_dbg(target->dev, "I2C_S_IRQ_EN:                    0x%x\n",
+		readl_relaxed(target->base + I2C_S_IRQ_EN));
+	dev_dbg(target->dev, "I2C_S_FIFOS_STATUS:              0x%x\n",
+		readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
+	dev_dbg(target->dev, "I2C_S_DEBUG_REG1:                0x%x\n",
+		readl_relaxed(target->base + I2C_S_DEBUG_REG1));
+	dev_dbg(target->dev, "I2C_S_DEBUG_REG2:                0x%x\n",
+		readl_relaxed(target->base + I2C_S_DEBUG_REG2));
+	dev_dbg(target->dev, "I2C_S_CLK_LOW_TIMEOUT:           0x%x\n",
+		readl_relaxed(target->base + I2C_S_CLK_LOW_TIMEOUT));
+	dev_dbg(target->dev, "I2C_S_CLK_RELEASE_DELAY_CNT_VAL: 0x%x\n",
+		readl_relaxed(target->base + I2C_S_CLK_RELEASE_DELAY_CNT_VAL));
+	dev_dbg(target->dev, "I2C_S_SDA_HOLD_CNT_VAL:          0x%x\n",
+		readl_relaxed(target->base + I2C_S_SDA_HOLD_CNT_VAL));
+}
+
+static void qcom_i2c_target_hw_init(struct qcom_i2c_target *target)
+{
+	dev_dbg(target->dev, "HW init: resetting FIFOs, enabling IRQs\n");
+	writel(CLEAR_TX_FIFO | CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
+	writel(QCOM_I2C_TARGET_ALL_IRQ, target->base + I2C_S_IRQ_EN);
+}
+
+static void qcom_i2c_target_write_requested(struct qcom_i2c_target *target)
+{
+	u8 val = 0;
+
+	if (!test_and_set_bit(WRITE_IN_PROGRESS, &target->status)) {
+		dev_dbg(target->dev, "Write phase started\n");
+		i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED, &val);
+	}
+}
+
+static int qcom_i2c_target_drain_rx_fifo(struct qcom_i2c_target *target)
+{
+	unsigned int rx_count;
+	int ret = 0;
+	u8 val;
+
+	while (!ret) {
+		rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
+				     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
+		if (!rx_count)
+			break;
+
+		while (rx_count--) {
+			val = (u8)readl_relaxed(target->base + I2C_S_RX_FIFO);
+			dev_dbg(target->dev, "Data from RX FIFO: 0x%x\n", val);
+			ret = i2c_slave_event(target->slave, I2C_SLAVE_WRITE_RECEIVED, &val);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+static void qcom_i2c_target_hw_reset(struct qcom_i2c_target *target)
+{
+	/* Clear error bits before SW_RESET; the reset may not be instantaneous */
+	writel(BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT),
+	       target->base + I2C_S_IRQ_CLR);
+	writel(SW_RESET, target->base + I2C_S_SW_RESET_REG);
+	/*
+	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
+	 * Use a conservative delay to allow the reset to finish before
+	 * reconfiguring the controller.
+	 */
+	usleep_range(10, 20);
+	qcom_i2c_target_hw_init(target);
+	writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
+	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
+}
+
+static irqreturn_t qcom_i2c_target_handle_error(struct qcom_i2c_target *target,
+						u32 irq_stat)
+{
+	u8 val = 0;
+
+	if (irq_stat & BIT(ERR_CONDITION))
+		dev_err(target->dev, "Error condition: unexpected Start/Stop bits\n");
+	else
+		dev_err(target->dev, "Clock low timeout\n");
+	qcom_i2c_target_dump_regs(target);
+	qcom_i2c_target_hw_reset(target);
+	i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
+	target->status = 0;
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qcom_i2c_target_handle_stop(struct qcom_i2c_target *target,
+					       u32 irq_stat)
+{
+	u8 val = 0;
+
+	dev_dbg(target->dev, "Stop bit detected\n");
+	/*
+	 * Short-write corner case: WRITE_IN_PROGRESS was never set because
+	 * no RX_DATA_AVAIL or STRCH_WR fired before STOP. Do not call
+	 * qcom_i2c_target_write_requested() here — STOP ends the transaction
+	 * so setting WRITE_IN_PROGRESS now would leave a stale bit after
+	 * target->status is cleared below.
+	 */
+	if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {
+		unsigned int rx_count;
+
+		rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
+				     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
+		if (rx_count)
+			i2c_slave_event(target->slave, I2C_SLAVE_WRITE_REQUESTED,
+					&val);
+	}
+	qcom_i2c_target_drain_rx_fifo(target);
+	i2c_slave_event(target->slave, I2C_SLAVE_STOP, &val);
+	target->status = 0;
+	writel(CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
+	/*
+	 * STOP terminates the transaction, so any other Rx or clock
+	 * stretch bits latched in this same status read have already
+	 * been serviced by the drain above or are now stale. Ack the
+	 * whole word rather than just STOP_DETECTED; clearing only STOP
+	 * would leave those bits set and immediately re-enter the
+	 * handler, which for a co-asserted STRCH_RD would push a stale
+	 * byte into the TX FIFO.
+	 */
+	writel(irq_stat, target->base + I2C_S_IRQ_CLR);
+	return IRQ_HANDLED;
+}
+
+static void qcom_i2c_target_handle_rx_data(struct qcom_i2c_target *target,
+					   u32 rx_irq_bits)
+{
+	int ret;
+
+	dev_dbg(target->dev, "Rx data event (rx_irq_bits=0x%x)\n", rx_irq_bits);
+	qcom_i2c_target_write_requested(target);
+	ret = qcom_i2c_target_drain_rx_fifo(target);
+	if (ret)
+		dev_dbg(target->dev, "Backend requested NACK\n");
+	writel(ret ? NACK | CLEAR_RX_FIFO : ACK_RESUME,
+	       target->base + I2C_S_CONTROL);
+	writel(rx_irq_bits, target->base + I2C_S_IRQ_CLR);
+}
+
+static void qcom_i2c_target_handle_strch_rd(struct qcom_i2c_target *target)
+{
+	enum i2c_slave_event event = I2C_SLAVE_READ_PROCESSED;
+	u8 val = 0;
+
+	dev_dbg(target->dev, "Clock stretching during read (Tx) phase\n");
+	if (!test_and_set_bit(READ_IN_PROGRESS, &target->status)) {
+		/* Repeated-start: master switched direction from write to read */
+		clear_bit(WRITE_IN_PROGRESS, &target->status);
+		event = I2C_SLAVE_READ_REQUESTED;
+	}
+	i2c_slave_event(target->slave, event, &val);
+	dev_dbg(target->dev, "Data to TX FIFO: 0x%x\n", val);
+	writel(val, target->base + I2C_S_TX_FIFO);
+	writel(ACK_RESUME, target->base + I2C_S_CONTROL);
+	writel(BIT(STRCH_RD), target->base + I2C_S_IRQ_CLR);
+}
+
+static irqreturn_t qcom_i2c_target_irq(int irq, void *dev)
+{
+	struct qcom_i2c_target *target = dev;
+	u32 irq_stat, rx_bits;
+
+	/*
+	 * Dispatch priority (highest first):
+	 *   ERR_CONDITION / CLOCK_LOW_TIMEOUT  — hardware error, triggers SW reset
+	 *   STOP_DETECTED                      — end of transaction, clears all state
+	 *   RESTART_DETECTED                   — repeated start, resets state before
+	 *                                        any data phase in the same snapshot
+	 *   STRCH_RD                           — read-phase data supply
+	 *   RX_FIFO_FULL / RX_DATA_AVAIL /
+	 *   STRCH_WR                           — write-phase Rx, coalesced into one drain
+	 */
+	irq_stat = readl_relaxed(target->base + I2C_S_IRQ_STATUS);
+	if (!irq_stat)
+		return IRQ_NONE;
+
+	dev_dbg(target->dev, "IRQ status: 0x%x\n", irq_stat);
+
+	/*
+	 * Load target->slave once. Both reg_slave() and unreg_slave() disable
+	 * the IRQ before writing the pointer, so it cannot change while this
+	 * handler runs. Sub-handlers may dereference target->slave directly.
+	 *
+	 * The core is enabled only in reg_slave() and disabled in unreg_slave(),
+	 * so no bus activity is expected here. Clear and discard any stale IRQ.
+	 */
+	if (!READ_ONCE(target->slave)) {
+		writel(irq_stat, target->base + I2C_S_IRQ_CLR);
+		return IRQ_HANDLED;
+	}
+
+	if (irq_stat & (BIT(ERR_CONDITION) | BIT(CLOCK_LOW_TIMEOUT)))
+		return qcom_i2c_target_handle_error(target, irq_stat);
+
+	if (irq_stat & BIT(STOP_DETECTED))
+		return qcom_i2c_target_handle_stop(target, irq_stat);
+
+	if (irq_stat & BIT(RESTART_DETECTED)) {
+		dev_dbg(target->dev, "Repeated start bit detected\n");
+		target->status = 0;
+		writel(ACK_RESUME, target->base + I2C_S_CONTROL);
+		writel(BIT(RESTART_DETECTED), target->base + I2C_S_IRQ_CLR);
+	}
+
+	if (irq_stat & BIT(STRCH_RD))
+		qcom_i2c_target_handle_strch_rd(target);
+
+	/*
+	 * Coalesce all write-phase Rx bits into a single drain+ACK. When the
+	 * RX FIFO fills at threshold, RX_FIFO_FULL, RX_DATA_AVAIL and STRCH_WR
+	 * can all assert in the same irq_stat snapshot. Pass the combined mask
+	 * so ACK_RESUME is written exactly once and all bits are cleared together.
+	 */
+	rx_bits = irq_stat & (BIT(RX_FIFO_FULL) | BIT(RX_DATA_AVAIL) |
+			      BIT(STRCH_WR));
+	if (rx_bits)
+		qcom_i2c_target_handle_rx_data(target, rx_bits);
+
+	return IRQ_HANDLED;
+}
+
+static int qcom_i2c_target_reg_slave(struct i2c_client *slave)
+{
+	struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
+
+	if (target->slave)
+		return -EBUSY;
+
+	if (slave->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	disable_irq(target->irq);
+	WRITE_ONCE(target->slave, slave);
+	writel(slave->addr, target->base + I2C_S_DEVICE_ADDR);
+	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
+	enable_irq(target->irq);
+
+	return 0;
+}
+
+static int qcom_i2c_target_unreg_slave(struct i2c_client *slave)
+{
+	struct qcom_i2c_target *target = i2c_get_adapdata(slave->adapter);
+
+	if (!target->slave)
+		return -EINVAL;
+	disable_irq(target->irq);
+	writel(0, target->base + I2C_S_CONFIG);
+	WRITE_ONCE(target->slave, NULL);
+	target->status = 0;
+	writel(0, target->base + I2C_S_DEVICE_ADDR);
+	enable_irq(target->irq);
+
+	return 0;
+}
+
+static int qcom_i2c_target_icc_init(struct qcom_i2c_target *target)
+{
+	int ret;
+
+	target->icc_path = devm_of_icc_get(target->dev, NULL);
+	if (IS_ERR(target->icc_path))
+		return dev_err_probe(target->dev, PTR_ERR(target->icc_path),
+				     "failed to get ICC path\n");
+
+	/*
+	 * The controller only needs interconnect bandwidth while it is
+	 * powered. The vote is placed here and across resume with
+	 * icc_set_bw(), and dropped with icc_set_bw(path, 0, 0) on suspend
+	 * and remove, so the vote and unvote are always symmetric.
+	 */
+	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
+			 APPS_PROC_TO_I2C_TARGET_VOTE);
+	if (ret)
+		return dev_err_probe(target->dev, ret, "icc_set_bw failed\n");
+
+	return 0;
+}
+
+static u32 qcom_i2c_target_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SLAVE;
+}
+
+static const struct i2c_algorithm qcom_i2c_target_algo = {
+	.reg_target	= qcom_i2c_target_reg_slave,
+	.unreg_target	= qcom_i2c_target_unreg_slave,
+	.functionality	= qcom_i2c_target_func,
+};
+
+static int qcom_i2c_target_adap_init(struct qcom_i2c_target *target)
+{
+	target->adap.algo = &qcom_i2c_target_algo;
+	target->adap.dev.parent = target->dev;
+	target->adap.dev.of_node = target->dev->of_node;
+	strscpy(target->adap.name, "qcom-i2c-target",
+		sizeof(target->adap.name));
+	i2c_set_adapdata(&target->adap, target);
+
+	return i2c_add_adapter(&target->adap);
+}
+
+static int qcom_i2c_target_probe(struct platform_device *pdev)
+{
+	struct qcom_i2c_target *target;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	target = devm_kzalloc(dev, sizeof(*target), GFP_KERNEL);
+	if (!target)
+		return -ENOMEM;
+
+	target->dev = dev;
+
+	target->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(target->base))
+		return dev_err_probe(dev, PTR_ERR(target->base),
+				     "failed to map registers\n");
+
+	target->xo_clk = devm_clk_get(dev, "xo");
+	if (IS_ERR(target->xo_clk))
+		return dev_err_probe(dev, PTR_ERR(target->xo_clk),
+				     "failed to get XO clock\n");
+
+	target->ahb_clk = devm_clk_get(dev, "ahb");
+	if (IS_ERR(target->ahb_clk))
+		return dev_err_probe(dev, PTR_ERR(target->ahb_clk),
+				     "failed to get AHB clock\n");
+
+	ret = clk_prepare_enable(target->xo_clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable XO clock\n");
+
+	ret = clk_prepare_enable(target->ahb_clk);
+	if (ret) {
+		clk_disable_unprepare(target->xo_clk);
+		return dev_err_probe(dev, ret, "failed to enable AHB clock\n");
+	}
+
+	target->irq = platform_get_irq(pdev, 0);
+	if (target->irq < 0)
+		return target->irq;
+
+	ret = qcom_i2c_target_icc_init(target);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0,
+			       dev_name(dev), target);
+	if (ret)
+		return dev_err_probe(dev, ret, "request_irq failed for IRQ %d\n",
+				     target->irq);
+
+	qcom_i2c_target_hw_init(target);
+
+	platform_set_drvdata(pdev, target);
+
+	ret = qcom_i2c_target_adap_init(target);
+	if (ret)
+		return dev_err_probe(dev, ret, "i2c_add_adapter failed\n");
+
+	return 0;
+}
+
+static void qcom_i2c_target_remove(struct platform_device *pdev)
+{
+	struct qcom_i2c_target *target = platform_get_drvdata(pdev);
+
+	writel(0, target->base + I2C_S_CONFIG);
+	i2c_del_adapter(&target->adap);
+	icc_set_bw(target->icc_path, 0, 0);
+	clk_disable_unprepare(target->xo_clk);
+	clk_disable_unprepare(target->ahb_clk);
+}
+
+static int qcom_i2c_target_suspend(struct device *dev)
+{
+	struct qcom_i2c_target *target = dev_get_drvdata(dev);
+	int ret;
+
+	ret = icc_set_bw(target->icc_path, 0, 0);
+	if (ret)
+		dev_err(dev, "icc_set_bw failed on suspend: %d\n", ret);
+
+	clk_disable_unprepare(target->xo_clk);
+	clk_disable_unprepare(target->ahb_clk);
+
+	return 0;
+}
+
+static int qcom_i2c_target_resume(struct device *dev)
+{
+	struct qcom_i2c_target *target = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(target->ahb_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable AHB clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(target->xo_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable XO clock\n");
+		goto err_disable_ahb;
+	}
+
+	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
+			 APPS_PROC_TO_I2C_TARGET_VOTE);
+	if (ret) {
+		dev_err(dev, "icc_set_bw failed\n");
+		goto err_disable_xo;
+	}
+
+	qcom_i2c_target_hw_init(target);
+	target->status = 0;
+	if (target->slave) {
+		writel(target->slave->addr, target->base + I2C_S_DEVICE_ADDR);
+		writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
+	}
+
+	return 0;
+
+err_disable_xo:
+	clk_disable_unprepare(target->xo_clk);
+err_disable_ahb:
+	clk_disable_unprepare(target->ahb_clk);
+	return ret;
+}
+
+static const struct dev_pm_ops qcom_i2c_target_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_i2c_target_suspend,
+				      qcom_i2c_target_resume)
+};
+
+static const struct of_device_id qcom_i2c_target_dt_match[] = {
+	{ .compatible = "qcom,qdu1000-i2c-target" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_i2c_target_dt_match);
+
+static struct platform_driver qcom_i2c_target_driver = {
+	.driver = {
+		.name		= "qcom-i2c-target",
+		.pm		= &qcom_i2c_target_pm_ops,
+		.of_match_table	= qcom_i2c_target_dt_match,
+	},
+	.probe	= qcom_i2c_target_probe,
+	.remove	= qcom_i2c_target_remove,
+};
+module_platform_driver(qcom_i2c_target_driver);
+
+MODULE_DESCRIPTION("Qualcomm I2C target controller driver");
+MODULE_AUTHOR("Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1

