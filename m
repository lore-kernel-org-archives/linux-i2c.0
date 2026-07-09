Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2C3AEB4E
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 06:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783577133; cv=none; b=XCJfx15KcNK14R7i7aUowHYf8BtB82PHlBEOGOClcTbiNaGGAEWshnRK7Ep8JwzsV/BgUonYFX2beD5EjythYJoZSRf6pXDdba4FpMmoxATlPfVwPvW8ttfla+O9p3WkmPRRx6rb8X08cZ792hXon96flbyFgWcxEpg1r3cCAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783577133; c=relaxed/simple;
	bh=Q+LNTxMNTksgF9VnrFyj5EqxaEeRz8vjWVphTPzTZ5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OqA7Bth+uQT0Ovuv7w9bblrlSk5FpuZ5h6HhlGwus2WljlNrcvW+ML/N5koFRRVJKcj4YUpagHzqyYLPsuPUIabKRIpO7iRz5wwR678Ks63Z4K+EVz0oXlk47bvsseHEy9f+JjX/0Yq8Qxbo5TjeLdLekdBMiL83NbznEcVSi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lzUTMwVw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PnwCDwiJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lzUTMwVw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PnwCDwiJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960Nn9916737
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 06:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0F
	DOOPQOsk=; b=lzUTMwVwpM86ZbjFJ9yCK7tGFt6FK7njTFZy06AIu0A6AYI9hGR
	lhNajr4rP78OuO3SpD55+gFBUvS2408/pmhljHLiC7sqjaytBTA74ROSLUhNqDyB
	Jf5S5pBTLECW8ENBlct1qxjygssWjgmheodnUWZZb3fucUBFh5d46QROQlObPcwS
	HfXTENoPHBrh3PCY7iW8UEBPD0jRk41WkrgDEdntpaBiLcTmhJk3YxjiHp++AE1E
	J/gCjsspFQAOTPXYRxPMHfbrUB9Bjt88/YpBlJOFKE+TM6wUiFLBqEDcC9wV9Ugp
	mcR2GRT5NLlpKbTeygY+d3BiAMsJVAGwrdQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9hnv54w2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 06:05:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca3673560so9726125ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 23:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783577130; x=1784181930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0FDOOPQOsk=;
        b=PnwCDwiJEW7gXV9fr0lr58cQBoNK20VUue7RaVWj50WeaFA/Se3HwdtObS2qK5oTm5
         keykwnXUjB/APhSiUGvajEbFGzrWiGJLcHGuaGHOpBMtx/taDhLErCTSGkCi0D3nwkZf
         mcp4T/EdjXK8CytMh2BglioS97/H3iqG1t+epuk6Ik4ZRBIYgdmlvs258o/ZuejwzUDN
         9W+ePlLFzg1M8iXFQ/m1VLFQj/syuMjLUfHDVvJ4ITi++0Koo7wq/FQZUXVOKmDjjG7u
         A/AexuWefn7fJzI+oWPeE4JPR3gZEJ9CksTQbWhjSyj+ePMIkJO15OUyoGfAZBrdzD+j
         YBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783577130; x=1784181930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm7lobBZrOzogeeSZu3t/lsBp/vgw265Z0FDOOPQOsk=;
        b=WzT5EA923EjCLNBvRhzlGvhinu8CyqKQQWEYuZa9Nn2gZ9cILrQcUkpgKQ55gKGMim
         K5T0HHkaIkxNTQAdTfNy+BsraJ2B+uftmslS7ogg5bQDKeYYT29FgLaYmKOhCREcxLt5
         /oLdFff6uPfaPAieODTsZKKWp3I/K35Kf/JUUtiWjN8J5wOktWY81VpDoctQU1EeYiar
         BKfHpl6rapL96g8PEHnkVim+UwsoXhXhITvVCu8uHPcdDGnFwK8uFttsfxdWgYWpUa1w
         XeDCC45Vg9ObBpiuTI7/hBXU1Nl0eIPUjoj4Ea1FITTrXelIV9dmKiQeeEg32QFWqlEN
         yfHw==
X-Gm-Message-State: AOJu0YzXCMjKG3HM7oXnGISe4DopexPjoQ5p47UYOocPo6NTvx7EPC/Z
	yzvMmPKx2pQAj8uqmihj/rTAMBbO55TNWkKtlUETWXH6lV+6Loxknugb8vuZKsl2qdzMyU8Hw+S
	ed6ZyZo6fxaxZDD/gmPvsBto0NlinsgetDI7HrmHqjAQsMXfBHN/xzifGOa40W6Y=
X-Gm-Gg: AfdE7cnp1PebnZbccv6UHa8y08megM3bJYprrRXXlqg6z0hR6GGUVH8sM8UXM44Mw7I
	uQOBNEzJrRMCL36l7eD5YyNSfh2oLHgiI93vMrN8M5DKSy8pF+cmeDEKgTQWam+9oABkZn7tOhb
	mgK6A9TaKZq4sxwp1nIOpla1YjTZBbRtJj7C69ezMS5rE5QgI2Sgjl1FMiUYixDk8RLYOLYTEnH
	viuHLki7Zj+SI3ZzhfVC5LmfzqG9MkQkqFrTzwo5Mdmd/ltnCXG9WIDzxBF5q/yDJ+sCv1eWfHU
	ivlAWpBYzDOB60CLpiKLwYTCm6gAxpm7QMopwWegx9Uh8gRfm9aq0+MUGkl+jN5rjyKqkeLnldr
	bPUyNJSJNazClFT0JY2aXdst21BWQ6NvBkGEVVZ4uu8Cy1Q==
X-Received: by 2002:a17:902:d2cb:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2ccea3e1fdfmr65120415ad.21.1783577130173;
        Wed, 08 Jul 2026 23:05:30 -0700 (PDT)
X-Received: by 2002:a17:902:d2cb:b0:2c2:bd7f:ccd4 with SMTP id d9443c01a7336-2ccea3e1fdfmr65120005ad.21.1783577129651;
        Wed, 08 Jul 2026 23:05:29 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1f030sm38128135ad.51.2026.07.08.23.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:05:29 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH v3] i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency
Date: Thu,  9 Jul 2026 11:35:21 +0530
Message-Id: <20260709060521.4091523-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNNqylFo c=1 sm=1 tr=0 ts=6a4f3a2a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ThEsosvJOpkTSRB3RXoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX6n157PJ1lH1Y
 RiJLKGMtP/XStEFr8soiT0hIV6gQUPP9/GMG8V8LMujaMMXca2ckE7kQOphZcmaNZosTwgCijSD
 c5PyqGIL0nOBF2JfsVv3vlMas28Ih+4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfXwGKndjB2euFY
 RcqXLgRlH0D2LVNAe8G22zXIuUyVByHIzrH3gy2/fH4kVk2sHkaFUZ4QulUjg5hudy3WuUwjkdJ
 3o0GUJ5TSF+nxW3k6LLssuEhgJ7XHCg98NuCqmbdDpz6BPHGW061zfoiB5tGhhaj3Hu6OHZc5rW
 IrHoeYLZRZbhLWyo2aiFxhG6bbFho0ltMSc9cx0jOk+eZ3MCFdRifqXAJDMJiyPXvcEsAj8/efd
 mUfEXa/eX1jWYnXFpOoE0fxY2ChtszceJCi2u95z3pg3V96vCafQpK5zTPatH374SIDCL0PU5oy
 ofrO3zdNHKOZb5Zpu0xinZ71l2KBUBKreMyZ2CrLEwEnMcwb01kSslBc3BuY1A+fDNPxmw6HAMk
 xXtHZimcZ5acIa/f66ztwd3lPtPA2642bn9lMGHy6wWZqZAJgBeuLXZ05AwmJQa0wIIdRUR+57t
 cA5gEfa5ldfWTs0HDaw==
X-Proofpoint-ORIG-GUID: z5ykkGOeYTUMqTpif14FWytRxugX80jX
X-Proofpoint-GUID: z5ykkGOeYTUMqTpif14FWytRxugX80jX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090054

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time and a 300ms
floor. For GPI multi-descriptor transfers, use the maximum message
length across all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v3:
 - Added the extra variable to handle timeout value.

 drivers/i2c/busses/i2c-qcom-geni.c | 45 +++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..d43db77b3678 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,12 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin, 300ms floor */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -204,6 +207,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
+static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
+{
+	size_t bit_cnt = len * 9;
+	size_t bit_usec = (bit_cnt * USEC_PER_SEC) / gi2c->clk_freq_out;
+	size_t xfer_max_usec = (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
+			       I2C_TIMEOUT_MIN_USEC;
+
+	return usecs_to_jiffies(xfer_max_usec);
+}
+
 static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
@@ -445,7 +458,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +483,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +498,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +526,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +606,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +616,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +627,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +751,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			unsigned long timeout;
+			size_t max_len = 0;
+			int j;
+
+			for (j = 0; j < gi2c->num_msgs; j++)
+				max_len = max_t(size_t, max_len, msgs[j].len);
+
+			timeout = geni_i2c_xfer_timeout(gi2c, max_len);
 			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
-								      XFER_TIMEOUT, &gi2c->done);
+								      timeout, &gi2c->done);
 			if (ret) {
 				dev_err(gi2c->se.dev,
 					"I2C multi write msg transfer timeout: %d\n",
@@ -851,8 +874,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 		}
 
 		if (!gi2c->is_tx_multi_desc_xfer) {
+			unsigned long timeout = geni_i2c_xfer_timeout(gi2c, msgs[i].len);
+
 			dma_async_issue_pending(gi2c->tx_c);
-			time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+			time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 			if (!time_left) {
 				dev_err(gi2c->se.dev, "%s:I2C timeout\n", __func__);
 				gi2c->err = -ETIMEDOUT;
-- 
2.34.1

