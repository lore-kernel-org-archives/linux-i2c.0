Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2F480DE0;
	Thu, 13 Aug 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629704; cv=none; b=E0t8KLrk7Cfula1zbayYNRHZzef65cMIES8pkupkWrH0dgntNCWKy62xrryUABAX1FVwUaKLWG0unxKARjOHHurbDWbjVhRDDECZPV5JCL4hE/DYusT0x9JGR5PCdHJJevOJxUewAk7iOcmVLj++Q6yeSToOSUt01HO2JJe/5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629704; c=relaxed/simple;
	bh=V9q7w1yIpcy8THe6bM/Td7y8uFskAOY04LQtPWzsRu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ospi9Vke2Xd6LULce2EO2gtlh7FyaRPUdKG7K2j1uTERNmKx7ljcm0qzHiWtoHbkI5zBTrwa8NKTbBLaHndueTb4qPKbkMY5AYU1Y/SRHznYecBpJRPuPdCnvfCwP7MDosFMTCHClfvrrkjDHMFSnRdFcTO2CpRdMOPzFNhwoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hS5wpCvz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hS5wpCvz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCKsrG2766097;
	Thu, 13 Aug 2026 14:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3hKDbLuTPrF
	mDsImldFLZIJL4Y4mdifyZ1NqvaEBtqA=; b=hS5wpCvzfPFr1r+CIlzYZdcadx5
	g/APgg+niQ8gv0+pJXkISGzMpiKRKUiOmsUr8T1Qo/EFkwvF7wPxVbM/GYsNV4LB
	UaZpyIPnjz7dAOXARbo1kSAMo9+cOKRtLJNYHXWi3JMZJBuEs3hSkMupG2uhBGKf
	1VxCNwZYW3kKoR2Hh4hKHFvmoDwu3gE66lk+Yfr5FhDAUnxJE2rmmfufABpghmzg
	F0+EDrxfYTrp36BLrJKXkt2kr5lefjuuq5apQAUmzXGAMwtZBeT6vtAVyu2k5hYW
	c1RHsMj7pc/xIszn/T2MwG6503WHKjgkb2U5xEpuB1R4MZ6B2lKFIjR4tvg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g11askeas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:35 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DE1VWX008870;
	Thu, 13 Aug 2026 14:01:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4g0bs34pv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:31 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67DE1V4F008864;
	Thu, 13 Aug 2026 14:01:31 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 67DE1Vos008860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:01:31 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 4F0AB220EC; Thu, 13 Aug 2026 19:31:30 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        zhengxingda@iscas.ac.cn, kees@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        brgl@kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v9 2/4] dmaengine: qcom: gpi: Add lock/unlock TREs for multi-owner I2C transfers
Date: Thu, 13 Aug 2026 19:30:41 +0530
Message-ID: <20260813140047.1006478-3-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260813140047.1006478-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=EujiaycA c=1 sm=1 tr=0 ts=6a7dce3f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=tjWtz1YETuxYaikmwkEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX+geEw5NXK+t0
 sZxC19jCRcEPuX21OZUic0gAYPOV48WcA5rvQOGXTVG8c/KJ66jiesU6xQCU5/7w3ItspKe4icu
 OIYGo1yXEffEmhWUbAcb2KS9XGvD4blR3xUQjfmAbUgH38ON9LF1EniD2l0vOEFm69v8Le3kv4S
 JzcK5kqG7CrjUI+nxt0bz22it3pniCNn814Ytnrz6ckPJMQltHXZxbestr2/WapWVYGkY4C6mev
 M/CM26yX/4wLwkGABayW6+P5phrdV+0+ORotCBP3qtvpYjdJNFdJdKPvs8uvi4iC7oCOSHHWHzj
 2TOhxC19mWa2PoXj4K0XHXaBS9cHFlbadS2ggSl73RKpIKaac4dxDGMcOY3ynONnu4xEjr2kfCq
 TVJauUID9UUJC8fEG0H622hZDi/IMqDQNVw3DbBk86aI0/E9jmQn4DOJUdEkukBrHx3sZVyCE4y
 uTXjqxiL96cRxLYbK2w==
X-Proofpoint-GUID: a3bIpdpxr46WshXk9mIDRAcux5S51rgy
X-Proofpoint-ORIG-GUID: a3bIpdpxr46WshXk9mIDRAcux5S51rgy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwMCBTYWx0ZWRfX6TshPskNTkGL
 DIPZGY+rORi2K/vKB1n+9SNnM8QA6Dovs2R6/1MpPkaBMdod//rAhmogKQ9MZvqxZharNVeAHh+
 KvJZ4+dv0Zo77LgybuVQiGJ7zktTjLc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130100

Some platforms use a QUP-based I2C controller in a configuration where the
controller is shared with another system processor (described in DT using
qcom,qup-multi-owner). In such setups, GPI hardware lock/unlock TREs can be
used to serialize access to the controller.

Add support to emit lock and unlock TREs around I2C transfers and increase
the maximum TRE count to account for the additional elements.

The GPI driver determines lock/unlock TRE placement autonomously based on
transaction boundaries, with no guidance required from the DMA client:
- A LOCK TRE is inserted before the first transfer in a transaction. The
  driver detects the start of a new transaction by checking that no lock
  is currently held (lock_pending == false).
- An UNLOCK TRE is inserted after the final write transfer in a
  transaction. The DMA_PREP_INTERRUPT flag on the descriptor marks the
  last descriptor in the batch.

The multi-owner flag is communicated once via the initial dmaengine_slave_
config call (set_config == 1) through the multi_owner field of struct
gpi_i2c_config, and is latched in gchan->multi_owner for the lifetime of
the transfer sequence. This keeps the locking mechanism as an internal GPI
implementation detail, consistent with the BAM-DMA approach, so DMA
consumers remain unaware of the underlying locking hardware.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c           | 77 +++++++++++++++++++++++++++++++-
 include/linux/dma/qcom-gpi-dma.h |  4 ++
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..25fe7410bee2 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <dt-bindings/dma/qcom-gpi.h>
@@ -67,6 +68,14 @@
 #define TRE_DMA_LEN		GENMASK(23, 0)
 #define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
 
+/* Lock TRE */
+#define TRE_LOCK		BIT(0)
+#define TRE_MINOR_TYPE		GENMASK(19, 16)
+#define TRE_MAJOR_TYPE		GENMASK(23, 20)
+
+/* Unlock TRE */
+#define TRE_UNLOCK		BIT(8)
+
 /* Register offsets from gpi-top */
 #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
 #define GPII_n_CH_k_CNTXT_0_EL_SIZE	GENMASK(31, 24)
@@ -492,6 +501,8 @@ struct gchan {
 	u32 dir;
 	struct gpi_ring ch_ring;
 	void *config;
+	bool multi_owner;   /* controller is shared; insert lock/unlock TREs */
+	bool lock_pending;  /* LOCK TRE has been inserted, UNLOCK not yet emitted */
 };
 
 struct gpii {
@@ -518,7 +529,7 @@ struct gpii {
 	bool ieob_set;
 };
 
-#define MAX_TRE 3
+#define MAX_TRE 5
 
 struct gpi_desc {
 	struct virt_dma_desc vd;
@@ -1605,6 +1616,7 @@ static int
 gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 {
 	struct gchan *gchan = to_gchan(chan);
+	struct gpi_i2c_config *i2c_cfg;
 	void *new_config;
 
 	if (!config->peripheral_config)
@@ -1617,6 +1629,17 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
 	gchan->config = new_config;
 	memcpy(gchan->config, config->peripheral_config, config->peripheral_size);
 
+	/*
+	 * Latch the multi_owner flag from the initial config call so the GPI
+	 * driver can autonomously insert LOCK/UNLOCK TREs without the client
+	 * having to track transfer boundaries.
+	 */
+	if (gchan->protocol == QCOM_GPI_I2C) {
+		i2c_cfg = gchan->config;
+		if (i2c_cfg->set_config)
+			gchan->multi_owner = i2c_cfg->multi_owner;
+	}
+
 	return 0;
 }
 
@@ -1627,10 +1650,33 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 	struct gpi_i2c_config *i2c = chan->config;
 	struct device *dev = chan->gpii->gpi_dev->dev;
 	unsigned int tre_idx = 0;
+	bool is_last = !!(flags & DMA_PREP_INTERRUPT);
 	dma_addr_t address;
 	struct gpi_tre *tre;
 	unsigned int i;
 
+	/*
+	 * Insert a LOCK TRE before the first transfer of a multi-owner
+	 * transaction.  The GPI driver detects the transaction start
+	 * autonomously: if multi_owner is set and no lock has been issued
+	 * since the last unlock (lock_pending == false), this is the first
+	 * descriptor in a new transaction.
+	 */
+	if (chan->multi_owner && !chan->lock_pending) {
+		tre = &desc->tre[tre_idx];
+		tre_idx++;
+
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		tre->dword[2] = 0;
+		tre->dword[3] = u32_encode_bits(1, TRE_LOCK);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+		tre->dword[3] |= u32_encode_bits(0, TRE_MINOR_TYPE);
+		tre->dword[3] |= u32_encode_bits(3, TRE_MAJOR_TYPE);
+
+		chan->lock_pending = true;
+	}
+
 	/* first create config tre if applicable */
 	if (i2c->set_config) {
 		tre = &desc->tre[tre_idx];
@@ -1690,6 +1736,35 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
 
 		if (!(flags & DMA_PREP_INTERRUPT))
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
+
+		/*
+		 * Chain the DMA TRE to the UNLOCK TRE when this is the last
+		 * descriptor in the transaction (DMA_PREP_INTERRUPT set) and
+		 * the channel is in multi-owner mode.
+		 */
+		if (chan->multi_owner && is_last && i2c->op != I2C_READ)
+			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
+	}
+
+	/*
+	 * Insert an UNLOCK TRE after the last write transfer of a multi-owner
+	 * transaction.  DMA_PREP_INTERRUPT marks the final descriptor in the
+	 * batch; reads carry their own completion event so the unlock follows
+	 * the write leg of each read message.
+	 */
+	if (chan->multi_owner && is_last && i2c->op != I2C_READ) {
+		tre = &desc->tre[tre_idx];
+		tre_idx++;
+
+		tre->dword[0] = 0;
+		tre->dword[1] = 0;
+		tre->dword[2] = 0;
+		tre->dword[3] = u32_encode_bits(1, TRE_UNLOCK);
+		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
+		tre->dword[3] |= u32_encode_bits(1, TRE_MINOR_TYPE);
+		tre->dword[3] |= u32_encode_bits(3, TRE_MAJOR_TYPE);
+
+		chan->lock_pending = false;
 	}
 
 	for (i = 0; i < tre_idx; i++)
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 332be28427e4..590ca7935f2b 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2020, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef QCOM_GPI_DMA_H
@@ -68,6 +69,8 @@ enum i2c_op {
  * @rx_len: receive length for buffer
  * @op: i2c cmd
  * @multi_msg: is part of multi i2c r-w msgs
+ * @multi_owner: controller is shared with another system processor;
+ *               the GPI driver will insert lock/unlock TREs automatically
  */
 struct gpi_i2c_config {
 	u8 set_config;
@@ -81,6 +84,7 @@ struct gpi_i2c_config {
 	u32 rx_len;
 	enum i2c_op op;
 	bool multi_msg;
+	bool multi_owner;
 };
 
 #endif /* QCOM_GPI_DMA_H */
-- 
2.43.0

