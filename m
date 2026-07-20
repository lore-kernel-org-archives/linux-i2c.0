Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9E3988FB
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547704; cv=none; b=kbvfm55sM7KrRs8Xi/zfrOI1of6AYglc17L8XPrQ/ENfMhQGkhPdaJy1SomXzByI3ydIsgzHXpMPrTIFftkgvTk8lVZCXVlAt3WG3uHzT+VmX7RBBZA5OeB2BshkuE7Hh6QSNAtN+y5yUGR4z+syrsrLafG/TIcIzm5U/foRv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547704; c=relaxed/simple;
	bh=jchbetBd13C8tpwMYHDplyU8W2EBYr6hvA/y/3aWq7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG96yWziIswbI21yo2KHNtoq4O2sCP01X87WCYynF6PdhwIGmUUFl1MTMlk/qBtIYHRN1c6lbG7kQJsESl6shLbJACkjvG0/Vz/6h2HLScd3HINcV7UBV1cxJjgthNq6qGrl2AUd52wCPJ53B9pUFarwC+8IdrF8vZQ7VFnHZxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3kQFsBb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJHPVwSf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3kQFsBb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJHPVwSf"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAvaPK2430721
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYAcywDZPEMGMOkfGefFOa5YEZJOmG8sDGPXejEMrao=; b=Q3kQFsBbXY1N+4RR
	GDY38qxk/S2b/HpDY0fsqtUIMKBhMTJG1gvSHN26GRLQmBiKichgpk9rXkthRZH4
	U7r3W7xPn+kuHRi+FlnL9HaNemaZ0ZEX7XMCz3SGlOeUa7fvHo6bmmZZMxWik25b
	u5rvdS9PU4wX/h20LaE7NM3ts51vkw6znI6wZfxwAoZ9I5NrDItakw0S0VENOlC9
	Hjm5rioh+Cg8xjhEFcF9z6soYvYEqnmdAGnAk3q6+IlwKiibIJPyAuqCR0tTue8E
	e8soGaYqahBgzL9EitJTE/7q6QOQiclmhnhrLr0b/qK/qGDnlbmu6prHMb0Jo6qG
	1W46jg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhhgyre3n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 11:41:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84865f326efso10419064b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 20 Jul 2026 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784547695; x=1785152495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYAcywDZPEMGMOkfGefFOa5YEZJOmG8sDGPXejEMrao=;
        b=VJHPVwSf247z80AathXeFaIdWo9p2IFurY7XYrsQ2J/bXRRzL5zvMdpq7MznITY8pj
         0Y0N/hodDzz0mif2Q+L+G8lstZxwOePud/bg/LHkt6KG/hXSXskYxXFMX++a3hM3pNOz
         9hpemsGnQO02bKr+6hckKdJrCyUgsUYtSoErujzrfFRWZH78gfKx2c4FLHdZW5s3ZnbV
         +g6n4eGIw9Xmq8mKVE+zwXfz8hguUa1vLkAN/VL+VqXChqBZbB/P1kilWRG9sRmdJZVa
         JBFDzFMS0jKKcejz0fhvCMBs5A47AZsfLGnA3TtAypYcmCm35Wp7llFQnKD+p8DnZnS0
         7kOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784547695; x=1785152495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYAcywDZPEMGMOkfGefFOa5YEZJOmG8sDGPXejEMrao=;
        b=kgDB03Y+LyTFU8XgyLqAeCwu5j43lMOazXzbUV94MTf5FmsUeRuDXqIWvIzPY5V6B6
         C4BuLsilPMv44CGpn62cwT+XEqgbf4o+PtpVVBOW/OdECFOIynx865uv/VX6TC1VFz8c
         YdqfICyWN2ngqsJ9gJQ0zSzITHfUR2584wrL35fLcorKIoIPb/xgcxq08qYxvF78x12b
         XNafjrQpRZVvCvUhaXMc5GSeQAHPG+7P6fCk1eYsiI6PqneyrXAQPjSgq8SYRojHvnBt
         XgoWa2t/Z0LrmPMj5ok/ZxicrdbRHHiBOHhpbH6jxX6KRBf02HEkx4c5//5ltyGB3gIN
         xSHQ==
X-Gm-Message-State: AOJu0Yxtf+DqsCloVhwKBI/pXVOcjYCVECXhN7mDRpc9zUsXcB3L+6L2
	qcgnJ9yha5k5MRWtHqfHlkGKAHeSw5ai5MfF7SC+wxsVBkznsPyU5zoMGCF6QSnjK+2YUrApA+G
	8UDT3VkfntVea74iLvYKjuQHP4yg0AIPrXe6XuzINc3jNeWjLEvkoZOVQ2P/61B8=
X-Gm-Gg: AfdE7cmVYNX7Wmgo08dvgjfsuDk0WyiL8ukDNtolrF+t5/MnCGgwr0ne6YuwCDEAyZI
	4lG3VJyZK8/6Do0p+wGa9z3JAeQPy08BGYw1lbHfyTeK7Q8ZXtpS/mZJ4S0JBrc5tPO5Z9RWXjV
	LPl2ANQWHwDm9jyythzjKO+0OmqczvBGWyFYCaRe203e0+HqBYDu+I3vISHmS02cYeyJV52GhwF
	n8pod3ZZdh8oXhuTm1t1YBQw7lISCeJ3uEqu0y/8Lk+MfDv1twewPPw7kwuERF4bHMEpSeC5Tss
	AGNtt1oHeuYDkXSLXjALgw/QpWv1ZvqUsrjTwsVApOAMVtoXRixxbxa8OX9nvFqv/Rd88TruBAt
	Ql8EPK3qJUDZOMBPT9S954QWPzDqjpPeKR3M=
X-Received: by 2002:a05:6a00:1a94:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84c2930540cmr13432685b3a.16.1784547695087;
        Mon, 20 Jul 2026 04:41:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a94:b0:847:770f:da4c with SMTP id d2e1a72fcca58-84c2930540cmr13432653b3a.16.1784547694597;
        Mon, 20 Jul 2026 04:41:34 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfe9sm5450701b3a.27.2026.07.20.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:41:34 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 17:11:20 +0530
Subject: [PATCH v6 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-master-v6-2-671261b05c61@oss.qualcomm.com>
References: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
In-Reply-To: <20260720-master-v6-0-671261b05c61@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784547685; l=5385;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=jchbetBd13C8tpwMYHDplyU8W2EBYr6hvA/y/3aWq7I=;
 b=Gh6RVhZemNZ4QiUP98gCN2YcGrvaoFid1cnKAKNiRFA19Lb9SVceCC9I27CZNo4JpQDJpMLiQ
 TTE5od8goIPBD3BGDjcMJBLFa7l/s8GHGeOjRNUvuW1tl1IDDqhOFSQ
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfXxH8Dihll2cTf
 GcoU2wqI/oT+z4u11p7pfN4GPLoWrrG+tbIEjC3n7V/FIKcpiYC7bnY0lVYVdn+H4lH75OdHrkR
 xdq70vzPsf5TDoX2fcgKIWUL0MZ/dJA=
X-Authority-Analysis: v=2.4 cv=LK9WhpW9 c=1 sm=1 tr=0 ts=6a5e0970 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=S_uJhbi9Giy6tt7Agy8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: XzpkRG8cHQbaax_6uXhCztmkWUs7Stnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyOSBTYWx0ZWRfX70eTKTT+2Oho
 Ce9Mac86zz5wEHzkkqgubWegLN55bNaCj0c9o+2lZAKT5j0WUOB2BoHJc2vs1tdNZ4FZTv1D3qB
 Z8SOSHc+1RTaUdhRbZnORhAD56eNCLx4bKuYjKno5jvIvdY+Ci0iLR7bF+F/4pI5vvFfQUENEuz
 5NhoY193A2yG3Looet+F76syymTDTGX8/8lY9mRPJeajAO0SvIrCe+g93VReSfpJBrKJznUBnvP
 5kqsBzWVnqLsg8DmpoxW6Bab+cACsvvsB14+LJ04inL4O+J4Y/84slrWgcKQV0z9TspMts4lzb2
 HgRupiR8V82OMwusX1pZHE/e2O54os73TO8XLGyOrjLAabpjoVdArJRH0mukpVk/XR2DssKe9ub
 BNyeTiH051L/LQboxxAZqnsX1aaSnB0NQqffIIjxoqFP8Agg572yj2yFG4WfGui++quwUiyr/Et
 0qiPwBUzwxFLCpG9YJA==
X-Proofpoint-GUID: XzpkRG8cHQbaax_6uXhCztmkWUs7Stnx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200129

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Use i2c_update_timeout() from i2c-core to compute the timeout dynamically
from the maximum message length across the transfer batch and the bus
frequency, then read adap->timeout at each wait site.  The timeout is
updated once per transfer batch in geni_i2c_xfer() so all internal paths
(FIFO rx/tx and both GPI modes) use a consistent value.

A 10x safety margin over the theoretical wire time is applied, with a
300ms floor to account for I2C clock stretching and other situations where
a slave may keep SCL asserted for an extended period, including faulty
devices holding the bus.  Both constants remain private to this driver.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..d6fab3aa8468 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,14 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
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
@@ -471,7 +476,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	}
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -513,7 +520,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT, I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +600,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +610,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +621,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +745,17 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			size_t max_len = 0;
+			int j;
+
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
@@ -852,7 +870,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 
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

