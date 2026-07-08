Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518B3BD647
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 06:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491338; cv=none; b=EWrUR1ZJCw/55Fqjlue0LGGnIrsm2jy4XWPjc9F9UchCzLFNj3HFmiOBpswPUKcR9tb+ic4Xto1IERJpIJ34rEkFXdnu/pTjzfCTSpvdksciAx9tez5dtS5FrvJNQwplZtb8c3C30r3DNpEbUh/nLBkYXzcQlxIbpl4M/XWA5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491338; c=relaxed/simple;
	bh=PI+ilmBs01sD5mUu5TXS4A9CnGEXCungshT+FhvCh/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mWQ+7vHXBq/drOo5SUGR6IHXu9Y8E9FRAlJZr6DqbucUUzRVWad5Sglr7AS9U7qaJbG4bvqXrGISpgTp0SbFZQ8eNz94T+8GcSP2ax9YaXvqUOEYORA7wCdG7DWLpaUPNmj9rIoAYiTOlp/qfVrAfCFWOMbDjA5EwqGLOvlv82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wrje79v/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KnCezt/R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wrje79v/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KnCezt/R"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842qIX1645773
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 06:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iqMSj+BNsNc0r4ArAgvYq2QQGji5aiM6iMd0E9HaYgE=; b=Wrje79v/rTRACVBD
	p8kQNKoZH46sOQ1fFTadgP87rfPpJTrnyb+eO1ZQxPozZruew3268dh5WAdZHYmv
	urD9yNohl/NWvY9TSnS08A+3H1Ek80OI5ftjhO46wcbBmIOBbX9ugHlcwcz+VV6S
	hBVRXUm91UfqSOT6vbV5YujHQAwq9Xk5M68GES7r8nnWONu9+z2ovXuTwzSJw0WL
	d54kHNZw39N+mOiRxXNRB6XSsDvyzWHGjpzR4mS0HMVlR+U1xVJI2nSQNdaiUTrp
	ESK67rnB8/en0nYS1Fj29ar/319mk6KvmWsu9SuMIoH2ro/YXZjbeZArZ3FftzUv
	zg9fLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8ye0mfgg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 06:15:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ca0481106cso5630155ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 23:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491333; x=1784096133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iqMSj+BNsNc0r4ArAgvYq2QQGji5aiM6iMd0E9HaYgE=;
        b=KnCezt/RSH24FUTcfywl/RtLOh0wdjYglWhLfPrkMO8xwAFApLtly2I75XeFqjNAHY
         cK8sin3FHyp74b4K6YuKiEHcpAthfxvfqj08mM/JHILpmrxohbfAjewZ1So48PuAmO93
         cBhXQA1tCWH+lF5ArXOORf8xBy2kN70Jtmq2YT/I4tjqBgobA58mqLqAactbIIsYuq7i
         k4teRs6p3u6qqKQ3uXD664s4GylDsZNMQYrFM55AwdpN2JXX007Wu/4xTgj88rb7Q5Ef
         CGVFg6A2YUZSAkBQkjx+vO3h8F0wyV+aF05qwT/UHyVnTBlNZlhPFy+HxwZbHW138Upa
         32VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491333; x=1784096133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iqMSj+BNsNc0r4ArAgvYq2QQGji5aiM6iMd0E9HaYgE=;
        b=XiDN3/gZ+rMK4PA20B5VH1f2DCOW2oVM7UGwJKqhV5vHOt40gOP2NujEedoUo2j2sv
         iyPaO4cnuUQ5eV3w1dBLQdspQU+CNvojJW9zfWNFwmLZ13+NEdMFAL4JoFL41ErzIwAM
         ywPN7QpvdODeMXT0xLapGNx3e6aJtmYcqe6dxS5YFuHG0E/sM4K2/00OMdtYI8RDq4vT
         eoqoUPMrwTzxPagF5YH+91+Ll1+V7Qwlc/Z+3C/2cU05vETDlz6X1SaDix7l626rIxaO
         /tioo+rVMk0lZgD4fit3pVu4AjOzc3TWZe1hkoNK8fV8nnF7THtqpqVSwIudBaxVLwMO
         a39w==
X-Forwarded-Encrypted: i=1; AHgh+RqQBaLYCSyeBOo5VxZs0QF7kI7HxgdtqD2cIqj0O0n8BvNSStKV2lKs7al4q16I/IrHYO+UZxQI2yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0aJbI/jywOkO6GjpdGLrvVsGluqoLdeQ5X/4FYiLdJWBjc7AZ
	z293qZQcjGFV72ASjBVMLHs+xWGde1F4Ew/OFpyJCdNx+YilOH63vGYlcR4mr+bdSwVb/n85n4G
	AN5RY65oB9z/NxHzI9KW4l7Q7x3ZWS+B8ERy7ptJQ2/MCTC6OJNnPe14yjy/4984=
X-Gm-Gg: AfdE7ckxSyuJtYi55OupaSILNj3kMCE2Pm6XzFxm6dnDNAJZbvHoKArtMUWKD22hpnX
	PqsQK6cBLQ88WE1xl3K0AV0OFgXQ8q/r1hKiOGpQ2RFe8aQ/8hssN3aw+M/X2qA/LEXpme+dIBl
	HDshR6ECPWV5+PaED01xr2HvLOHUGADO8CCFJUHUdK6G6NUwcTkIB+2DqddlLu5lpTmGPMV0hqE
	bKC3H24h3KyKSJK4FGQ9wA3nsHKLHtBhsezPuStHYSdJ5agQN3nYlu2oWXqPdrMLtVMvifv+/U8
	ssv2n2o12MsiukeeRFv+SMnzQRoW0fnnuA85Vygnj/XDygNIes9GjQIMSz6mCyelu1NvikZ+3HS
	dSmW4U/X5ZgSu6nkZyc0YOQnpgUPiIsyuFUo4vgPRzr/H
X-Received: by 2002:a17:903:1987:b0:2c9:aae1:a61c with SMTP id d9443c01a7336-2ccea3d97b9mr11476335ad.20.1783491333440;
        Tue, 07 Jul 2026 23:15:33 -0700 (PDT)
X-Received: by 2002:a17:903:1987:b0:2c9:aae1:a61c with SMTP id d9443c01a7336-2ccea3d97b9mr11476075ad.20.1783491332894;
        Tue, 07 Jul 2026 23:15:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm23011555ad.4.2026.07.07.23.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:15:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:45:22 +0530
Subject: [PATCH 2/3] i2c: qcom-geni: use dedicated completions for abort
 and reset events
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-2-dd8f841f36a2@oss.qualcomm.com>
References: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
In-Reply-To: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-0-dd8f841f36a2@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491323; l=5999;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=PI+ilmBs01sD5mUu5TXS4A9CnGEXCungshT+FhvCh/Y=;
 b=C92gBYUi10IgYMZtG4DPxhnp6issR4v0szybsbOS+bXRUuyKPOlNjJmQRPtKlsD7Ye3AIRMtr
 /8KyAhyFIcgDCY+mgVgNWNmmtTomd7BUdJdfuhdbDKe2GZaj7jmxUSQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: id1kUvSXLXa3TCAO40erMmfJKP99BrWd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX2T151Oqv/6Wy
 VAWJ8bU0VFIqvsIVXUEh9gV1jXjjiIeiPRhlbR0ecoTBd9qAnjdSyVZ2Gu8bv1XmAqOBQ2jc4hX
 cxZPqBVeqN6urNircAfrW+daiizJ4AU=
X-Authority-Analysis: v=2.4 cv=SZfHsPRu c=1 sm=1 tr=0 ts=6a4deb06 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KPPVM4V1oce58VYRkwwA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: id1kUvSXLXa3TCAO40erMmfJKP99BrWd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX4631N2TibW2a
 2jK15N0s9bpGAGJEoWshVSEaAb4KyGU4QX9DYtRKcfI3xBDxLkrXyL2cBBnajCP092UaOQPCNfH
 h3woObxIo4Pz94i8w5dnCzZEjB53Ogaa05ylISrAzZBdl3rt0FBvzsxh0yhuZCKhNxhAcVwPlkL
 59Um34Usy4VmNZxgdhccOQh5dyiYksW7xXkp1DK5ERTpWIfs8gxyXTBHjyhG1ZpN8XpYiLghGcE
 fo+Y0YJt/w+JsRTHPnZA1ZgKG+EsMbABdLYQW/WduIbjwKwdQI7peL9p2N+WFRMNb6BnrHK718k
 ZmpsYgdW1fu0yTkrawFfincS88NQUrO+siupwWFNNYXY6uHjHX5C+rPy8mYHCvfz38fcQxsU2vM
 DfEwBDLmNAIEcP+X5ePtraqRWYMByI+bejDoi5r75QscsbwafCHtkXPLOvjW6zzg0dfLGVh/5up
 sV3cxYk749znixu3YiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056

The driver uses the shared gi2c->done completion for transfer, abort,
and DMA reset operations. This allows unrelated completion events to
prematurely wake abort and reset waiters, leading to incorrect
synchronization.

Introduce dedicated completions for abort, TX reset, and RX reset
operations, and signal them only from their respective interrupt
events. This removes the dependency on shared completion state and
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

