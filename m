Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B9397347
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 04:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570862; cv=none; b=apdx8NoYGv3okLCC1/NTEo/CRArWMC5FrD12ZqYgVM9f2+hOT9XOkptnnMIZFrTB7cEc3y3C8TTNdzped/K3UWqP4LII/8+ygUH+QaOUBI1VfukNw61ydAHIPQ73b+8fwgwTyJGugHFCfB8nVwJerGblX57Zaq/i8k76Vjkzxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570862; c=relaxed/simple;
	bh=rvm1wz1ZLi+Wu8yKfQSbMLnWcPgwIpdMwa2eQX4CXKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PaMvw35Lz57hKtTHUaTIMiUlzo8Ta0gbVGhYesxiZ/PoIs0KBhzrqjr8Ynwu0cUVL0/mm3Ej864+VO/+aK4OXqKgE605qceS8/RQ6e4PHASsqv6ehz3lyagBrfKilwvO+PX6HTNLz9A+uYn506O5XtvF7B1pS2n5R0wqjhNUwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k/6CHhaq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SnK6C5yY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k/6CHhaq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SnK6C5yY"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8OH24087854
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 04:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nsz1H97/3mIQwsbA/XJBmxwh8+fKOZ0DFWQS+InwXQs=; b=k/6CHhaqcdFDevPc
	qdtrG50BN4sU3AOsD4sw5qrU/hdwu7pJxOK5vniJEka2MATwftQMCm+163/OnMvr
	m6T5l2eQYv5/dKT2dpl8DJHoQgvRlGAYIeORgWm6qG70yybtiZbCcMzrjlW3ifAK
	t6NX0XHFZqWfqGJ/yBgxeBaBirE+AayuqujJVfbir5sRdeC4dQkpkluK6Qx7MQ9y
	dSUlUl9vzpJqETtx6iOZehU26cSKZ9y6e/oH2stqJmlHEUCgcwjDphrJML24hu6S
	cZt6ObYMMD6IjFCY4T8gj48jnvXJ8OQnG32ZCd5o7vE/9fCKvkYi9FMBJbVVBNNt
	yhuoeg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u1rpj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 04:21:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-384419c6c74so1950412a91.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 21:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783570860; x=1784175660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nsz1H97/3mIQwsbA/XJBmxwh8+fKOZ0DFWQS+InwXQs=;
        b=SnK6C5yYS9thEDgbzKKrA5eVaVsy7cLWqjWSEnPsN5gR22z6oznHLs3/jyKxQCK7zp
         PlDiknTWKhl/dyKjZgas0I52IE8AnaC+Ur06bXhwXFZJ+yE6yMU7maMLKDxB2uIigWBI
         Jbwkp1eK1S8IlxBXPVlsYq7H4N88nf+9IW9r09969jwOKSua/fBo3g9CN5DOLGg8SC6T
         iMYBJEL/5dEZXc1WgsgRIqTUkw8aw0Li0b3VKqNz09OyATEhSHF1qTr0Pa3jYDDlP4sJ
         0ypU86UBlRrlVYfsZobF2h0XY2LXTBjg1/1j8d4vIdkL4Awc99hVeNDPNCimOPAXxa2t
         EBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570860; x=1784175660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nsz1H97/3mIQwsbA/XJBmxwh8+fKOZ0DFWQS+InwXQs=;
        b=Oy51a2ogq4Y3wWDO0vp7KT9SRnoWvQgs1oP6ZpOsjK8GzYovvHAJ4DPkMJrmNtp3dh
         Irv0bvyeFBUlyplQX1VEiUgCeQlJOA3pcVeifjiK2Pqr9D5U7gPaJK8HFOk5+k+zAvh+
         ihyV+nlcj9lllwWEtBa6jdpPwtnDYBnlN37Bbr1c3nreyy0KMdd5wucdGf0GQ+ivnlkc
         IV7meK60jjnKnW6r+no7uHHCWMBDl/RD5AzPyJEjR05XXfueUtfjo0ithH+IDIARHX9l
         jncYlsYO0y6uEIbuJth/4eTSjPg/hoo08KCEPyql9t11Y5HKzvnK0iDVzp82X5/yLwTs
         oeAw==
X-Forwarded-Encrypted: i=1; AHgh+RoCu56MEImbFX9SKrxURYCKQ3+ACHQGkpxDwWJuB85QHduF4Zzx7R9PI/0EhUFmDf8RiUTd4CyoE58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxdHDFecDecQQLui0xNPeIz3exZ+BMKymnYzPncNLa9yveicI
	sLgdJYKFAFWZLIPgmC4gse8gj3kJkTP6xcTue3vOYC6cgASmNEyIyd3hIlxktm2KesynKB3Geg4
	lZWBTrJmLBjTs6JfH5UPRhIn/K4snSDn/faIt54eeRq5MT2V7jeZE9kvap3NLIt0=
X-Gm-Gg: AfdE7ckkaSVQMKZrl5ONOeoWcIOxTROtvKDSdjYFNDF4d6Ekxon172Mfv/Z9Arf1+5A
	WrVFY022AAunN7CLm4bICQWZV8e940z2CEHH/ImzMa9Dj1xuLfLPz0qqracXPp/dumeY3A6aDG/
	IsYIyNdlIeAniNn2YY5W8EfKPxEldTFkOwqnyRqsf5GFzGS7HY8NL3Kxzcq/fuHHOdcMUZ/eWJc
	bHyBNeYUqlFCY9vw4XumbwNaoQiogqQJckUDkZZ6qDPHRb4OYOkFoBYNcCuM/DqgDvPrSBz1M5x
	XdrreAnSSFPfZq76sWVr2INw0kjgA+mAYsqzXWf/mrVbA99cxUlP9IHou30lWMnJLYyo52UXRuZ
	Fpz4NFEK/0dz8WE0KzM2GhyFyCzzpEVNJ3MGhOTWf6XCn
X-Received: by 2002:a17:90a:d606:b0:37f:c683:e643 with SMTP id 98e67ed59e1d1-389421ae110mr5398318a91.24.1783570859880;
        Wed, 08 Jul 2026 21:20:59 -0700 (PDT)
X-Received: by 2002:a17:90a:d606:b0:37f:c683:e643 with SMTP id 98e67ed59e1d1-389421ae110mr5398288a91.24.1783570859310;
        Wed, 08 Jul 2026 21:20:59 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm25490098eec.2.2026.07.08.21.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:20:58 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 09:50:41 +0530
Subject: [PATCH v2 2/3] i2c: qcom-geni: use dedicated completions for abort
 and reset events
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-2-1db178c695bb@oss.qualcomm.com>
References: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com>
In-Reply-To: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-0-1db178c695bb@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783570849; l=5993;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=rvm1wz1ZLi+Wu8yKfQSbMLnWcPgwIpdMwa2eQX4CXKA=;
 b=vLdbT+65qynAFb5+3LAb+VXPtCTywzS0LgL3bE43v5KiGPrD3WeEwwabWztdms/jyiD9wSW8j
 bUwhpKBOMiBCT3QIKrcGuUaRNhoLEsI8UwQ5lS3D0yuJlFTW5c81rbS
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX2KZOspMGXH2f
 MUImJ6Z1UP/45azZDbtzq/+hzSI+20zoq8vyuK/yvYaWiaY/JzspJX/vaw9jgLju9A+PiLLcRk2
 cdk3zdVHv43f7k8lO/0CxBYRKR7XYNY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX4K62oWJgBSND
 TId5eXU1XHph4xJ6FoKyWpXqiGorFR9Oi5YLiKHM9aRENOJ7y5+snMM3mAfzEQ8nH6sFwlRWoQZ
 J4WYv/y2rtq43pH+POSfJxTT/DQVdJZkRgPz0/12jPqgDEqF43zn+etRxZ88ZSr7l5Hqq0zMqVQ
 Yxc4CY3D7nS4SBNUsFsn+I6c7+2ZwA/5vQabo/fIZfeLgMsYnwZ1if3FQq3pq/4VQkp/iX3EI1C
 +UhKq6qcl3qPMmmy+0q4Zsnlo0SUNX40pv76ZpodNddJRU57RNVRJ6QT+f86LT+qmGaTeLWau4b
 3O9xzFNUYJcORgYun2IzBYpXqgBH8qWq8hCiVpPryz6RT1ml6rTwycEIO9juS1dQ4yly+g5ck0Y
 4r7Tru4skFtfwyuwg6v1UetBBaGMfjxhzKEM57o5NKObFnZaS1Fv4yftv8WQ9rliu30IHX5ajqM
 r6mVUHfAWy+GzB3n4xQ==
X-Proofpoint-GUID: ZK_5pvs2qnlmUuT7jtflC52QrDTXxcxY
X-Proofpoint-ORIG-GUID: ZK_5pvs2qnlmUuT7jtflC52QrDTXxcxY
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f21ac cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KPPVM4V1oce58VYRkwwA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090037

The driver uses a common completion event for transfer, abort and DMA
reset operations.  This allows unrelated completion events to
prematurely wake abort and reset waiters, leading to incorrect
synchronization.

Introduce dedicated completions for abort, TX reset, and RX reset
operations, and signal them only from their respective interrupt
events.  This removes the dependency on shared completion state and
eliminates the abort_done flag-based synchronization.

Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 54 +++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 15403edb355a..9490aee4928c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -113,7 +113,10 @@ struct geni_i2c_dev {
 	int err;
 	struct i2c_adapter adap;
 	struct completion done;
+	struct completion abort_done;
 	struct completion cancel_done;
+	struct completion tx_reset_done;
+	struct completion rx_reset_done;
 	struct i2c_msg *cur;
 	int cur_wr;
 	int cur_rd;
@@ -127,7 +130,6 @@ struct geni_i2c_dev {
 	struct dma_chan *rx_c;
 	bool no_dma;
 	bool gpi_mode;
-	bool abort_done;
 	bool is_tx_multi_desc_xfer;
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
@@ -256,8 +258,6 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 
 	switch (err) {
 	case GENI_ABORT_DONE:
-		gi2c->abort_done = true;
-		break;
 	case NACK:
 	case GENI_TIMEOUT:
 		dev_dbg(gi2c->se.dev, "%s\n", gi2c_log[err].msg);
@@ -359,12 +359,18 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 		writel_relaxed(dm_rx_st, base + SE_DMA_RX_IRQ_CLR);
 
 	/* if this is err with done-bit not set, handle that through timeout. */
-	if (m_stat & M_CMD_DONE_EN || m_stat & M_CMD_ABORT_EN ||
-	    dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
-	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
+	if (m_stat & M_CMD_DONE_EN ||
+	    dm_tx_st & TX_DMA_DONE ||
+	    dm_rx_st & RX_DMA_DONE)
 		complete(&gi2c->done);
 	if (m_stat & M_CMD_CANCEL_EN)
 		complete(&gi2c->cancel_done);
+	if (m_stat & M_CMD_ABORT_EN)
+		complete(&gi2c->abort_done);
+	if (dm_tx_st & TX_RESET_DONE)
+		complete(&gi2c->tx_reset_done);
+	if (dm_rx_st & RX_RESET_DONE)
+		complete(&gi2c->rx_reset_done);
 
 	spin_unlock(&gi2c->lock);
 
@@ -376,17 +382,13 @@ static void geni_i2c_abort_xfer(struct geni_i2c_dev *gi2c)
 	unsigned long time_left = ABORT_TIMEOUT;
 	unsigned long flags;
 
+	reinit_completion(&gi2c->abort_done);
+
 	spin_lock_irqsave(&gi2c->lock, flags);
-	geni_i2c_err(gi2c, GENI_TIMEOUT);
-	gi2c->cur = NULL;
-	gi2c->abort_done = false;
 	geni_se_abort_m_cmd(&gi2c->se);
 	spin_unlock_irqrestore(&gi2c->lock, flags);
 
-	do {
-		time_left = wait_for_completion_timeout(&gi2c->done, time_left);
-	} while (!gi2c->abort_done && time_left);
-
+	time_left = wait_for_completion_timeout(&gi2c->abort_done, time_left);
 	if (!time_left)
 		dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
 }
@@ -414,31 +416,25 @@ static void geni_i2c_cancel_xfer(struct geni_i2c_dev *gi2c)
 
 static void geni_i2c_rx_fsm_rst(struct geni_i2c_dev *gi2c)
 {
-	u32 val;
 	unsigned long time_left = RST_TIMEOUT;
 
+	reinit_completion(&gi2c->rx_reset_done);
 	writel_relaxed(1, gi2c->se.base + SE_DMA_RX_FSM_RST);
-	do {
-		time_left = wait_for_completion_timeout(&gi2c->done, time_left);
-		val = readl_relaxed(gi2c->se.base + SE_DMA_RX_IRQ_STAT);
-	} while (!(val & RX_RESET_DONE) && time_left);
 
-	if (!(val & RX_RESET_DONE))
+	time_left = wait_for_completion_timeout(&gi2c->rx_reset_done, time_left);
+	if (!time_left)
 		dev_err(gi2c->se.dev, "Timeout resetting RX_FSM\n");
 }
 
 static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
 {
-	u32 val;
 	unsigned long time_left = RST_TIMEOUT;
 
+	reinit_completion(&gi2c->tx_reset_done);
 	writel_relaxed(1, gi2c->se.base + SE_DMA_TX_FSM_RST);
-	do {
-		time_left = wait_for_completion_timeout(&gi2c->done, time_left);
-		val = readl_relaxed(gi2c->se.base + SE_DMA_TX_IRQ_STAT);
-	} while (!(val & TX_RESET_DONE) && time_left);
 
-	if (!(val & TX_RESET_DONE))
+	time_left = wait_for_completion_timeout(&gi2c->tx_reset_done, time_left);
+	if (!time_left)
 		dev_err(gi2c->se.dev, "Timeout resetting TX_FSM\n");
 }
 
@@ -851,6 +847,7 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	for (i = 0; i < num; i++) {
 		gi2c->cur = &msgs[i];
 		gi2c->err = 0;
+		reinit_completion(&gi2c->done);
 		dev_dbg(gi2c->se.dev, "msg[%d].len:%d\n", i, gi2c->cur->len);
 
 		peripheral.stretch = 0;
@@ -920,6 +917,8 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
 		gi2c->cur = &msgs[i];
+		gi2c->err = 0;
+		reinit_completion(&gi2c->done);
 		if (msgs[i].flags & I2C_M_RD)
 			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
 		else
@@ -939,8 +938,6 @@ static int geni_i2c_xfer(struct i2c_adapter *adap,
 	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
 	int ret;
 
-	gi2c->err = 0;
-	reinit_completion(&gi2c->done);
 	ret = pm_runtime_get_sync(gi2c->se.dev);
 	if (ret < 0) {
 		dev_err(gi2c->se.dev, "error turning SE resources:%d\n", ret);
@@ -1132,7 +1129,10 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
+	init_completion(&gi2c->abort_done);
 	init_completion(&gi2c->cancel_done);
+	init_completion(&gi2c->tx_reset_done);
+	init_completion(&gi2c->rx_reset_done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 

-- 
2.34.1

