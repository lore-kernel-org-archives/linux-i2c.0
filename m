Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63A36C9E5
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786599921; cv=none; b=aO5IKixlg3gIAyva/EPv1aHVf4axLB1VR+VEyPh5ghBaX10Y9Lr+k0Wtb8YXIyP8gT06wsvq8xXwYfHBR0zTMY79CFcEp3yYpr3WrrjwiPImJsbSzhMhFR0Cjx5RBQBkebEuDM92e4WpWmlVAy1e07Yw5rGuR3wFasfa9mOcdWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786599921; c=relaxed/simple;
	bh=XuNbNdezUta+HaP/HnPqF/Qiyl+9RxcAukqvc3MaBLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFKLvcxDHkdSPLBgfAfbVnOCUM+PNJVAoRYz6XeebxWXefb4QaBw5dai6wMdh3gX5zpXVZno/nKaPsXPQ1dukRibKdV4wD1s7ozxR/P5x6naJHjcx+Cb5LFHO+Ndd3zxnOABtWhJ3kURoyxBaCpfz+d8oA/bA+DMUbxstLBf6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ad9p+tYK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SNSGZjme; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ad9p+tYK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNSGZjme"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D5gB6F1476799
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mU+bqaVAcam260I0995R65cz5gHTBDXU+X7V9XX7Mlw=; b=Ad9p+tYKKl84HWnU
	+9Hrr6N9TWCM7+PWrYaoG60Rd6D7xCYcW8ICPtGvefa8CElVGvZBRS5HLRX8e3xL
	BPR0rykWIqu5ZuxTqvbCt7nGtb8A+oOuKS6+LuWiO6KKp1Co3ZWiueEsMUPpy8du
	4aSb8PdmHWSH9KO3dubVmWKwZizKMZMnZitY9GJZoMjWuOPS4dwChpUvn8dLvVaZ
	3Y/c2iLNFUubiDWdCp3xk5gXsmEztEjhSsW/KZShgh6UwyV0WB5cPkHtNGfhsqqi
	GNUXjP/DHIAhwCXbVhdv7Te42TznE/N81NmwhOEbXdLIHrWH+ftooxQPSvWXRg6D
	raHaWw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0uts30yd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 13 Aug 2026 05:45:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so2464140b3a.3
        for <linux-i2c@vger.kernel.org>; Wed, 12 Aug 2026 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786599918; x=1787204718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mU+bqaVAcam260I0995R65cz5gHTBDXU+X7V9XX7Mlw=;
        b=SNSGZjmevQo04rWmX/3GfOaqH8/YqdKSsjwHmg4XUmF9GHF+qLR0WH1YeIZvBNoHVU
         0LwloRJokqlmOZxjbqJ24GPPX8E70Lv+eLba0np+mPLtldE7QiAJODaQ0lqgUfy1GRWA
         VY7pKah/3IO+sS+YblYUp0cnVqjJ49hJL/5WMv2MReibN1C3ADDGDQJuwpixL04ZPNZC
         s3BDT0HVXR8/jZhQK+UQysnaCwSWTZwe2wILl2AcywPQOxXDrDKH8SF+mwDeJ3ngkAm7
         eU5g3ixsMNMhA91zP4uzfKfiCpDCSnL40tUU4CbzBtzomGxLEnN+KckY7xoGGsdqlDkH
         j6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786599918; x=1787204718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mU+bqaVAcam260I0995R65cz5gHTBDXU+X7V9XX7Mlw=;
        b=ZECyRPnRLVgEtcGh1LP+E6kPtKJ20OtTAwZ/egiilfOU6B6gvGRJnr7/DoDKq/6Hw1
         ImGa9N0mGNptHcUUfdMURsSapMSqGC5Qlk/G1JcDQ07XKAwi83/Ur0H0klq2oOJjMLH6
         O6cBkRThfehKUaKCIJ/EdXHzguyFFBq4cPZowDdtwr7724e3uM4Ne0tg6NRmWDxnWp0D
         QorczAi9d46HfOBwX1DN7caL4I3/nLU93ehvLDFb/SzcHWRqfYF1BYnN+V6dOtHhm5cH
         a3ZOebeifjT4BiyRXIjn/DlV4LM0Hx5bBUX07Obs5ecO/BK2UircjyXX/b7v4clOj6Un
         QrAg==
X-Forwarded-Encrypted: i=1; AHgh+RomkLkSMrmUrCCXpdYdUDLpy2EpcrjQJZkQCTsk+dI48g7Fa6s6INYIi3EZy35abBg5UqyM9FJoAHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Nre1mUxpQavFTFv9cWtdG7i/ES0rO9fMSWF7E8OAsllj6Awi
	5bvTucC8IwrNG6inoiQawb0ICC4OzqhPr1xVzt7oJS32p5UvbFiiEVRd0HaWkSNWx/m+Hhnnhfl
	+rWJRHkOxfKk/wQji7/lTC6YN0E810b34Iq329DUYikruHcU+Kgk422L8cJx7mek=
X-Gm-Gg: AR+sD10df1TvPgIsYUC8N29n5RCfkZfQBSJ9O3vBn3v5MBLMHm1xQNAAexDX4KxcwIB
	mCo5XQiQlEgLKI1JYuuMFjHZKg4UTqLmE3NeGoPCayySPmBfpW1ASYLT7d7/gKt4/q1qy9BfD2S
	Ek/JqgHLkRe/yRLcjfnAKHlMnV0EdkZpwHeUF3ATa8Qqt5sslqeTLDCJTsKBwVqvrEiClg4zE4g
	QJCh0raaTU/T7y4ayOb5ac1UjNHNER50JEYZruZEX6cyQ5LFKBG4Pa0e8V21gMlVLr7bw5jeRmQ
	L3zuW5dLYqhbI9480cjgnKjfpadvrGJz8taz0247JPa2DTLZhBb/ZIVB2uA77r5E1vgCuotka7m
	inKPHQsmneJDc697TPxiWWQvG8XAZ82xP2iY=
X-Received: by 2002:a05:6a00:23d5:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-84fc6d3d156mr3197900b3a.2.1786599917921;
        Wed, 12 Aug 2026 22:45:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:23d5:b0:837:e9cc:d474 with SMTP id d2e1a72fcca58-84fc6d3d156mr3197843b3a.2.1786599917327;
        Wed, 12 Aug 2026 22:45:17 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc477e53esm381500b3a.14.2026.08.12.22.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 22:45:16 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 11:15:03 +0530
Subject: [PATCH v7 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-master-v7-2-3f9010cf9229@oss.qualcomm.com>
References: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
In-Reply-To: <20260813-master-v7-0-3f9010cf9229@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786599906; l=5871;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=XuNbNdezUta+HaP/HnPqF/Qiyl+9RxcAukqvc3MaBLs=;
 b=gTI3LtgjT4uUvYl0gMWjqCV8lwTHFV44qD//aj33NDH+uQBGuUfj5aGuU7AEg+RXy0DBZ1Aq7
 JBX1jl8kFtSC7AM1hTTPY+7dmWuR30ILxdMu5Cil+K7pVuB1yx+/f3L
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: lHRI273eUQidOCoyWgilhTaiWWS2PQV4
X-Authority-Analysis: v=2.4 cv=aPDAb79m c=1 sm=1 tr=0 ts=6a7d59ee cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=S_uJhbi9Giy6tt7Agy8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: lHRI273eUQidOCoyWgilhTaiWWS2PQV4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfX+n8mg6rpH62z
 RsJ5rM+uxqsDHEXnFxq3dxcwUYbU7DvisombQ3U4/sQ1tgyi2wXlISaEluTznXTPjsxnQLrfc2z
 7G88dhHcSIVvHeVRfYeIHU8rLa+kIN8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNyBTYWx0ZWRfXxwyJpXptmV9w
 +TamKrH6FNaKqV0vSPhLusc+baoYRGfejjKtf8uFfARWaT7VX67Qk/ksFgfQc4p+4T7DebcBcxo
 lS+4j6Jjj8Mb1Y/5DRdzjTY8bzPZeNYJwPdtgYM69eNK9M1lTs7i9qlq1CeGhA4Z2dVavGFHuUU
 pynMWsOPDHPJ19PuhhB5ZObDHY3H/e4cm8RC6BSuOKm8+2oHEh8UO4xaD1MUVN3jeRazpGPMEQ7
 KW/zAk2PsN0pfQrVd6TOGimlIDrNflRHEODoKGjXTNs4ILRhcGymm+vmgq+LyCVzBRcrMyeX7A2
 /35SIB3jyFHYAxurE9H5W2EvQDOs5VpdUAq5ASunSUux/xk8f48VRqJoPeU9b2/N2mtmY5MEV8x
 HwvishpKFyEkCKq7Ur+wQ5DsykU7Qz0uYFbbmaYjzjNsOPGfRr+L1iz3YqNVl2pEMTHoKo8m5WD
 EfygHwyn5rijATLgQoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130037

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Use i2c_update_timeout() from i2c-core to compute the timeout dynamically
from the message length and the bus frequency, then read adap->timeout at
each wait site.  For FIFO, SE-DMA, and GPI single-descriptor paths the
timeout is computed per message using that message's length.  For the GPI
multi-descriptor path, the maximum message length across the batch is used
since one completion covers the entire BEI batch and the timeout must
cover the longest individual message.

A 10x safety margin over the theoretical wire time is applied, with a
300ms floor to account for I2C clock stretching and other situations where
a slave may keep SCL asserted for an extended period, including faulty
devices holding the bus.  Both constants remain private to this driver.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 44 ++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..c98d9e7b250c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -79,9 +79,14 @@ enum geni_i2c_err_code {
 
 #define ABORT_TIMEOUT		HZ
 #define CANCEL_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+
+/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -513,7 +518,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	}
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
@@ -555,7 +562,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
@@ -633,7 +642,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @timeout_jiffies: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -643,18 +652,18 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
-	u32 time_left;
+	unsigned long time_left;
 
 	for (i = 0; i < multi_xfer->msg_idx_cnt - 1; i++) {
 		reinit_completion(transfer_comp);
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -778,8 +787,22 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			size_t max_len = 0;
+			int j;
+
+			/*
+			 * Use the longest message as the timeout base: one completion
+			 * covers the whole BEI batch, so the budget must fit the worst
+			 * case single-message wire time.
+			 */
+			for (j = 0; j < gi2c->num_msgs; j++)
+				max_len = max_t(size_t, max_len, msgs[j].len);
+			i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, max_len,
+					   I2C_TIMEOUT_SAFETY_COEFFICIENT,
+					   I2C_TIMEOUT_MIN_USEC);
 			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
-								      XFER_TIMEOUT, &gi2c->done);
+								      gi2c->adap.timeout,
+								      &gi2c->done);
 			if (ret) {
 				dev_err(gi2c->se.dev,
 					"I2C multi write msg transfer timeout: %d\n",
@@ -899,7 +922,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 
 		if (!gi2c->is_tx_multi_desc_xfer) {
 			dma_async_issue_pending(gi2c->tx_c);
-			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+			i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, msgs[i].len,
+					   I2C_TIMEOUT_SAFETY_COEFFICIENT,
+					   I2C_TIMEOUT_MIN_USEC);
+			time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 			if (!time_left) {
 				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
 				gi2c->err = -ETIMEDOUT;

-- 
2.34.1

