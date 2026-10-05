Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552744908C4
	for <linux-i2c@vger.kernel.org>; Mon,  5 Oct 2026 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218772; cv=none; b=MkydIA66otpvt4zTT+YzxE9kf3owRvI2n/nY8RM7ARezA/Qp8AcSSAFyUXhbDlcd+L2z111k92B5oryS8hjygsopE5U68l3SR7vOPKRLk2EASsuTrQnaXOeeJT5sSE1Xc21bCPtw2kiKVnExFDekxSMyT8/kAQ5czoBq8Xz5v1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218772; c=relaxed/simple;
	bh=aBst1lFBqVxUVkk2nsnTBlvfHzGHyrZ4h76HfRgnMjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J4SU0LF96bHCpHByBZCD9FTloEuZxeW1zCJPdDWsssC86XmK14yPzB4nj6/OXebD9Ig81J280Gdd/pX04xEeNaiLLSdImdH/rv3rpw5WD5zxmllPJeQRynumIZ2fEw6gkqBpbeIMDgNCyiR6un/SjYKbZp/yh5W/5YIzYhBBdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESEZP6p1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YDju7uXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESEZP6p1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YDju7uXV"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EOrRE3187990
	for <linux-i2c@vger.kernel.org>; Mon, 5 Oct 2026 16:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QahbYQrhMHK48NoZqFr7W3FRQVnj2Dti61hSHW5Qu/k=; b=ESEZP6p1oIxhBQx5
	OeX8fz7OueQMwVezRFzQhbQ9bwVLRvw5GWmQOupSttNhmfOs8p9x4xdi0Pmzhxsv
	V+Vzbudb/GzyVJDuE2lBzKwO86jrGAxpH0k1zhm1sUKm2O9hd6N2CTGRb2BWs9Qz
	V6fCKEGtSJXNw6FbjQmukpizfQuVgAQrVFlR3i/KGsIPB2TB/uPvQMVylBx42ZC1
	+rY/jaR80SsiX9TnqpIvwR7dU0ri+2u96iJegh+vJ44O+WA0j6IGur/I7l+u+HwC
	njjNKSlxMfWe4JYt5qj/dhMjUEUoKvJe6fQfoIwALQDPH0CPHx9FGZCESETS7OmF
	VA3OGQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cuu0t10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 16:46:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df7bc60df6so11990685ad.3
        for <linux-i2c@vger.kernel.org>; Mon, 05 Oct 2026 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791218768; x=1791823568; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QahbYQrhMHK48NoZqFr7W3FRQVnj2Dti61hSHW5Qu/k=;
        b=YDju7uXVoISfxfw3kPZwPz3/f/uuMtYcXQQ8dJ4qzz/tyrWoxL33v+oG2YOYo+JRHf
         s5yx9KQVwEZEsNEbwSfArI7h5qZ5Wih+IXPq7FrPMffg+W4gyW8pVzAOxuVohZCS79Xv
         +hqH+wtH/pPehKIYj2KEmf8BjQiB8oHwQAe90+MTkHtrKr+ngoLD1RhsexYPP+f74LD/
         tYjyq5aHoG812m/z0lWhqmL9xxKL+obT0ZeatifUptE1GLzcFaa6uxNxXer2TmDHEuje
         QJvkAFVWset2jpqvOi0Zl9ehgc3/bafhn5ETWVJ3u2RmkMS2PYeLKMHOWzd23+796UJ0
         rTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218768; x=1791823568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QahbYQrhMHK48NoZqFr7W3FRQVnj2Dti61hSHW5Qu/k=;
        b=y5tdnJVpOnnkFty0Mi+XcgTOUd1AULtJX/TztvGj9+E18MwrZKZDKgbKfjaq5pqpKA
         3BfIerwkFbjUwZY3veBo2fgW+M10HOiyYewIQk2m+S/CA4p6I+bZjvouBoS1IuF9O2CJ
         EsctleBVeLMoBW0277GR8cMoG6rnv3iBZvc+p0X0PjiUQAEDb11LRl0e4zuJ/XKp28EU
         qmAyQnFzbllN9J2c+KoCys3AuL6wP0ViE4RXfDZE7a8hRWjqD3T/xjryF4bIwrX9lBJ/
         smhtrgvZRgmES3D0rqbZyq8b3VJ6rXWs+H1KIk6w8HX79IewBxCm+R9aUgN9klW/a19D
         KDMA==
X-Forwarded-Encrypted: i=1; AKwUvBxsgXqbw10Ra6oArdVEuALIzVFUB3fkEggKC37fVjStBHpwIGm8xRU7uW4ap3B6mvB+MxX18m5mKQs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ21dN+Kt1NklYf6+b8V53YE+cXbx0V0eCci9kWptaU5aCzB/K
	TpkiQ6qCZ1AoS3Z+ISzoMsE5TPRafIxXGyaSAyg/1CEKFEQUU5G3YGVEhVPrane4sH2LxRK4dyD
	X1JqFGn7KaPRRPO/u2WgQZ13i+Xop3L8BLqqruDrFKYnVXl6qMQa+zkvEpeLJidI=
X-Gm-Gg: AYBFou0x+0D7gAOvGsUQPq5QcCmOQcUii0LP/d0lGaa5KnFgjc5vJLeME3+EimxI592
	Ps9CcweKfuLZCJnQjkR4tqzcYouXDzXR/LvbaR7mSp50ENX0ZQN/R1k5JZsMDNx51gIjcWj3xOq
	qwehw45dEm/qp2xPDkmY65IesBYXCg0RwXYzXjMUHSuOkthrP3txvSIhB6S3mdI2MTL7hqtn5Iz
	agVpVBY3rA173J0GAQG3P359TLRhxVNLQgRNpAMPjufIZPLfgwytmB2SK9Ltal1A/sotyn3nvkN
	AzbzF26s+LSeNmHEFJxLXttWozXAeSMSuSz4ZcZX1Bsy4lhFqYqC050WNLGXHyLBjR9gcrDo1og
	Fm9UlpkAXNmVmEx33KR3DBVM8BzucP+RqAv8=
X-Received: by 2002:a17:902:ec92:b0:2dd:8e7d:90f7 with SMTP id d9443c01a7336-2e49b6052bfmr110696145ad.9.1791218767796;
        Mon, 05 Oct 2026 09:46:07 -0700 (PDT)
X-Received: by 2002:a17:902:ec92:b0:2dd:8e7d:90f7 with SMTP id d9443c01a7336-2e49b6052bfmr110695795ad.9.1791218766914;
        Mon, 05 Oct 2026 09:46:06 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e5a55b6161sm10665605ad.1.2026.10.05.09.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:46:06 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 22:15:45 +0530
Subject: [PATCH v5 2/2] i2c: qcom-target: Add driver for Qualcomm I2C
 target controller
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261005-i2c-qcom-slave-v5-2-6254cc7c08d3@oss.qualcomm.com>
References: <20261005-i2c-qcom-slave-v5-0-6254cc7c08d3@oss.qualcomm.com>
In-Reply-To: <20261005-i2c-qcom-slave-v5-0-6254cc7c08d3@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791218753; l=24319;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=aBst1lFBqVxUVkk2nsnTBlvfHzGHyrZ4h76HfRgnMjQ=;
 b=xLrsg8YROUqm/7e1HKDCij1hq//NbHHHG1wypKR0r0j0rhWc+qxq2vUjHjyfac7R0LYaPgyzW
 Z2QmfZd2gyJAMH8KqxZ/I8PCRQVoNfL9bqWxVkIXuiCvXVHpYty1ECO
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfX7jG3nuhlslTD
 sdNRTayVxtL72I1vUv4ilopCUNfs4PDHnLs1jRl3m5OJ/rcG97aBMS9MwHyPyBMqULpY4G03F2+
 FTpJm9ZEuZA/vvGA8Glzwv/XqZj1uYY=
X-Authority-Analysis: v=2.4 cv=aKRlOr9m c=1 sm=1 tr=0 ts=6ac3d451 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=iIKCYw4gT12KdBNlG30A:9
 a=nJGRtjP3OGHk9UOb:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 79wjiRuBxfiu8dsInAmPFTt-wiWoJo8F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2NSBTYWx0ZWRfX9VcCmnVgqS3r
 /cJ/hVhsa+7zfRohmLTF9NNurG7fPvrkijAzmzf7QSCGggnjdBoj23Th8cRxMGL6I89c1mfPnph
 1NNVAxOilhuVZUPBYsAA5JPMdEu/65shsAt7BwHEeAQEGoYckER5alQ+6NEet7hzOtLp3MPDSfN
 tUKqDaTviMs5WGqauhX9/G1XmB+wwYktF+imB5qJm6/b8pl04LCOb4KbR9JviwuLLZca2oV61C/
 GGINKoGCZMlk4tV3ys0Y//ezePnAV/RIHqTBsqG4CvuhoPt+ruDBS90Ax9ZtD2D3q8gYOgPBu/d
 kDjjlLGOUrl3XfMnTyaCjQRDI+Hnbtbkq/7ytO5PA5ArIjJPDpcUZ6FJ+PiUECue7AIwc3AIEHw
 q8ATaE6xKNa8Jlty8X4eDVrIiFyhyZlRRdvK3NqyeT/oYejMdJ6bhVPw4eo4oTnj4euSIJfq6Ng
 WdjP1ryR96IShe3O8NA==
X-Proofpoint-GUID: 79wjiRuBxfiu8dsInAmPFTt-wiWoJo8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050065

QDU1000 and related Qualcomm SoCs include a dedicated I2C target
controller that operates exclusively in target mode. The existing
Qualcomm I2C controller drivers, GENI and QUP, are master-only and
cannot serve systems where the SoC must respond as an I2C target on
the bus.

Register the controller with the Linux I2C slave framework through
i2c_algorithm.reg_slave and i2c_algorithm.unreg_slave. This allows
standard slave backends, such as slave-24c02, to be attached at
runtime through i2c_slave_register().

Handle IRQ events for RX FIFO service, clock stretching during read
and write phases, STOP and repeated-start conditions, and error
recovery through a software reset.

Enable the required AHB and XO clocks and vote for interconnect
bandwidth. Restore the hardware state across system suspend and
resume using regular system-sleep PM callbacks.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 MAINTAINERS                          |   9 +
 drivers/i2c/busses/Kconfig           |  15 +
 drivers/i2c/busses/Makefile          |   1 +
 drivers/i2c/busses/i2c-qcom-target.c | 638 +++++++++++++++++++++++++++++++++++
 4 files changed, 663 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ff3bfd42d3f3..309c27d627ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22837,6 +22837,15 @@ S:	Maintained
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
index 9d60d4b650ec..63428b16de7e 100644
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
index 000000000000..c72fca068f5e
--- /dev/null
+++ b/drivers/i2c/busses/i2c-qcom-target.c
@@ -0,0 +1,638 @@
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
+/* Interconnect bandwidth vote in kilobytes per second */
+#define APPS_PROC_TO_I2C_TARGET_VOTE		Bps_to_icc(1190000)
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
+	WRITE_NACK,
+};
+
+/**
+ * struct qcom_i2c_target - Qualcomm I2C target controller private data
+ * @dev:		driver model device node
+ * @base:		base address of HW registers
+ * @adapter:		I2C adapter (target mode)
+ * @ahb_clk:		AHB bus clock
+ * @xo_clk:		XO reference clock
+ * @icc_path:		interconnect bandwidth path
+ * @target:		currently registered target backend client; written only
+ *			under disable_irq() in reg_target()/unreg_target() so the
+ *			ISR sees a stable pointer for its entire execution
+ * @status:		bitmask of enum qcom_i2c_target_status flags; must be
+ *			unsigned long for set_bit/test_bit/clear_bit; accessed
+ *			only from the ISR and from reg_target()/unreg_target()
+ *			under disable_irq(), so no additional lock is needed
+ * @irq:		interrupt line number
+ */
+struct qcom_i2c_target {
+	struct device		*dev;
+	void __iomem		*base;
+	struct i2c_adapter	adapter;
+	struct clk		*ahb_clk;
+	struct clk		*xo_clk;
+	struct icc_path		*icc_path;
+	struct i2c_client	*target;
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
+static int qcom_i2c_target_write_requested(struct qcom_i2c_target *target)
+{
+	u8 val = 0;
+	int ret = 0;
+
+	if (!test_and_set_bit(WRITE_IN_PROGRESS, &target->status)) {
+		dev_dbg(target->dev, "Write phase started\n");
+		ret = i2c_slave_event(target->target, I2C_SLAVE_WRITE_REQUESTED, &val);
+		if (ret)
+			set_bit(WRITE_NACK, &target->status);
+	}
+
+	return ret;
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
+			ret = i2c_slave_event(target->target, I2C_SLAVE_WRITE_RECEIVED, &val);
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
+
+	/*
+	 * I2C_S_SW_RESET_REG is write-only so completion cannot be polled.
+	 * This helper is called from the hard IRQ handler, so the reset delay
+	 * must not sleep. Use a short busy wait before reconfiguring the
+	 * controller.
+	 */
+	udelay(20);
+	qcom_i2c_target_hw_init(target);
+	writel(target->target->addr, target->base + I2C_S_DEVICE_ADDR);
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
+	i2c_slave_event(target->target, I2C_SLAVE_STOP, &val);
+	target->status = 0;
+
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
+	 * no RX_DATA_AVAIL or STRCH_WR fired before STOP. Notify the backend
+	 * before delivering the STOP event if data is still in the RX FIFO.
+	 */
+	if (!test_bit(WRITE_IN_PROGRESS, &target->status)) {
+		unsigned int rx_count;
+
+		rx_count = FIELD_GET(RX_FIFO_COUNT_MASK,
+				     readl_relaxed(target->base + I2C_S_FIFOS_STATUS));
+		if (rx_count)
+			qcom_i2c_target_write_requested(target);
+	}
+
+	if (!test_bit(WRITE_NACK, &target->status))
+		qcom_i2c_target_drain_rx_fifo(target);
+	i2c_slave_event(target->target, I2C_SLAVE_STOP, &val);
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
+
+	return IRQ_HANDLED;
+}
+
+static void qcom_i2c_target_handle_rx_data(struct qcom_i2c_target *target,
+					   u32 rx_irq_bits)
+{
+	int ret;
+
+	dev_dbg(target->dev, "Rx data event (rx_irq_bits=0x%x)\n", rx_irq_bits);
+	ret = qcom_i2c_target_write_requested(target);
+	if (ret || test_bit(WRITE_NACK, &target->status)) {
+		dev_dbg(target->dev, "Backend requested NACK\n");
+		writel(NACK | CLEAR_RX_FIFO, target->base + I2C_S_CONTROL);
+		writel(rx_irq_bits, target->base + I2C_S_IRQ_CLR);
+		return;
+	}
+
+	ret = qcom_i2c_target_drain_rx_fifo(target);
+	if (ret)
+		dev_dbg(target->dev, "Backend requested NACK\n");
+
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
+		/* Repeated-start: controller switched direction from write to read */
+		clear_bit(WRITE_IN_PROGRESS, &target->status);
+		event = I2C_SLAVE_READ_REQUESTED;
+	}
+
+	i2c_slave_event(target->target, event, &val);
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
+	 * Load target->target once. Both reg_target() and unreg_target() disable
+	 * the IRQ before writing the pointer, so it cannot change while this
+	 * handler runs. Sub-handlers may dereference target->target directly.
+	 *
+	 * The core is enabled only in reg_target() and disabled in unreg_target(),
+	 * so no bus activity is expected here. Clear and discard any stale IRQ.
+	 */
+	if (!READ_ONCE(target->target)) {
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
+		/*
+		 * Keep clock stretch asserted when STRCH_RD is co-asserted so
+		 * qcom_i2c_target_handle_strch_rd() can fill TX FIFO first.
+		 */
+		if (!(irq_stat & BIT(STRCH_RD)))
+			writel(ACK_RESUME, target->base + I2C_S_CONTROL);
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
+static int qcom_i2c_target_reg_target(struct i2c_client *client)
+{
+	struct qcom_i2c_target *target = i2c_get_adapdata(client->adapter);
+
+	if (client->flags & I2C_CLIENT_TEN)
+		return -EAFNOSUPPORT;
+
+	if (target->target)
+		return -EBUSY;
+
+	disable_irq(target->irq);
+	WRITE_ONCE(target->target, client);
+	writel(client->addr, target->base + I2C_S_DEVICE_ADDR);
+	writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
+	enable_irq(target->irq);
+
+	return 0;
+}
+
+static int qcom_i2c_target_unreg_target(struct i2c_client *client)
+{
+	struct qcom_i2c_target *target = i2c_get_adapdata(client->adapter);
+
+	if (!target->target)
+		return -EINVAL;
+
+	disable_irq(target->irq);
+	writel(0, target->base + I2C_S_CONFIG);
+	WRITE_ONCE(target->target, NULL);
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
+static u32 qcom_i2c_target_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SLAVE;
+}
+
+static const struct i2c_algorithm qcom_i2c_target_algo = {
+	.reg_target	= qcom_i2c_target_reg_target,
+	.unreg_target	= qcom_i2c_target_unreg_target,
+	.functionality	= qcom_i2c_target_func,
+};
+
+static int qcom_i2c_target_adapter_init(struct qcom_i2c_target *target)
+{
+	target->adapter.owner = THIS_MODULE;
+	target->adapter.algo = &qcom_i2c_target_algo;
+	target->adapter.dev.parent = target->dev;
+	target->adapter.dev.of_node = target->dev->of_node;
+	strscpy(target->adapter.name, "qcom-i2c-target",
+		sizeof(target->adapter.name));
+	i2c_set_adapdata(&target->adapter, target);
+
+	return i2c_add_adapter(&target->adapter);
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
+		dev_err_probe(dev, ret, "failed to enable AHB clock\n");
+		goto err_disable_xo;
+	}
+
+	target->irq = platform_get_irq(pdev, 0);
+	if (target->irq < 0) {
+		ret = target->irq;
+		goto err_disable_ahb;
+	}
+
+	ret = qcom_i2c_target_icc_init(target);
+	if (ret)
+		goto err_disable_ahb;
+
+	ret = devm_request_irq(dev, target->irq, qcom_i2c_target_irq, 0,
+			       dev_name(dev), target);
+	if (ret) {
+		dev_err_probe(dev, ret, "request_irq failed for IRQ %d\n",
+			      target->irq);
+		goto err_disable_icc;
+	}
+
+	qcom_i2c_target_hw_init(target);
+
+	platform_set_drvdata(pdev, target);
+
+	ret = qcom_i2c_target_adapter_init(target);
+	if (ret) {
+		dev_err_probe(dev, ret, "i2c_add_adapter failed\n");
+		goto err_free_irq;
+	}
+
+	return 0;
+
+err_free_irq:
+	devm_free_irq(dev, target->irq, target);
+err_disable_icc:
+	icc_set_bw(target->icc_path, 0, 0);
+err_disable_ahb:
+	clk_disable_unprepare(target->ahb_clk);
+err_disable_xo:
+	clk_disable_unprepare(target->xo_clk);
+
+	return ret;
+}
+
+static void qcom_i2c_target_remove(struct platform_device *pdev)
+{
+	struct qcom_i2c_target *target = platform_get_drvdata(pdev);
+
+	writel(0, target->base + I2C_S_CONFIG);
+	i2c_del_adapter(&target->adapter);
+	devm_free_irq(&pdev->dev, target->irq, target);
+	icc_set_bw(target->icc_path, 0, 0);
+	clk_disable_unprepare(target->ahb_clk);
+	clk_disable_unprepare(target->xo_clk);
+}
+
+static int __maybe_unused qcom_i2c_target_suspend(struct device *dev)
+{
+	struct qcom_i2c_target *target = dev_get_drvdata(dev);
+	int ret;
+
+	disable_irq(target->irq);
+	writel(0, target->base + I2C_S_IRQ_EN);
+	writel(0, target->base + I2C_S_CONFIG);
+
+	ret = icc_set_bw(target->icc_path, 0, 0);
+	if (ret)
+		dev_err(dev, "icc_set_bw failed on suspend: %d\n", ret);
+
+	clk_disable_unprepare(target->ahb_clk);
+	clk_disable_unprepare(target->xo_clk);
+
+	return 0;
+}
+
+static int __maybe_unused qcom_i2c_target_resume(struct device *dev)
+{
+	struct qcom_i2c_target *target = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(target->xo_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable XO clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(target->ahb_clk);
+	if (ret) {
+		dev_err(dev, "failed to enable AHB clock\n");
+		goto err_disable_xo;
+	}
+
+	ret = icc_set_bw(target->icc_path, APPS_PROC_TO_I2C_TARGET_VOTE,
+			 APPS_PROC_TO_I2C_TARGET_VOTE);
+	if (ret) {
+		dev_err(dev, "icc_set_bw failed\n");
+		goto err_disable_ahb;
+	}
+
+	qcom_i2c_target_hw_init(target);
+	target->status = 0;
+	if (target->target) {
+		writel(target->target->addr, target->base + I2C_S_DEVICE_ADDR);
+		writel(I2C_S_CORE_EN, target->base + I2C_S_CONFIG);
+	}
+
+	enable_irq(target->irq);
+
+	return 0;
+
+err_disable_ahb:
+	clk_disable_unprepare(target->ahb_clk);
+err_disable_xo:
+	clk_disable_unprepare(target->xo_clk);
+
+	return ret;
+}
+
+static const struct dev_pm_ops qcom_i2c_target_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_i2c_target_suspend,
+				qcom_i2c_target_resume)
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

