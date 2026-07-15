Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0443A80F
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110698; cv=none; b=AwhixF07t/XkYXcTKOTlUFM2j7KcDGOori9C30d9Fhp/0+rKbac0/nF8TpCcVPt/eeE4wQBPWqNqPtxLiKnUJCB8hKcZNkpDn4TrpOusis2/ynDN4XJ9xxCCGlpstcxm3klncSckPlolvFizRzMcdJNQjSTlxgu01nEawh8gmdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110698; c=relaxed/simple;
	bh=iMJjmuvPvoYpRAixN62qPcDLK79DdaTSn21a3CqpsiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kvc24JK4igh0xfEcGSL/3rNGMSGgwIOdFWASYn56VVDS3f2R1yxfXoN/1sFe/DTd+Z/fgs3lWyc/rfgsT9xn075uwJIvTAiMFk0gm3XMX658mbihAzI0oah5nr/1428IEnAOEk7ucXKhN9fCyoz5zgE+cvhlUdecdGhq5jp1t+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZEk2b+L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hj2qQOxV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZEk2b+L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hj2qQOxV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F6hXD62796465
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxD
	EGdffRFw=; b=lZEk2b+LNVUSg/1a8Nuf9mafJTg9ai8UIjsVqnY9L1PfDiuawkn
	RwM2Dh15emzuB8cGKqrqWvS1KInsUGKThkLn+oZDEm/PsdYIbOpGUbsuSbO5dx40
	04cUmCbgxlhnwnkrPU41FghT70XzMfeJVTe0jRwVVghRHHPN4Mgs8IIKRZ+9KRnN
	CZXKI2UB9FNAcWdykzAoK2vaS8KMfJx+3Rx9JyQQu+GliLYldzCuaAsVGIYDXiYj
	Z5o58RgRLcuAppHbUNiNK/PtckDtaBhAGo5JID9WCc1iFZbS9uodAlvuc+j/0FYy
	52bLZJlH0y8/AdFyntaUOcKI3DUeP0YxU3g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe56h8sux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 10:18:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so32203415ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784110696; x=1784715496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxDEGdffRFw=;
        b=Hj2qQOxVymQGFQvoGNBvsZo2+m2llFevBJ50lOSgndn8ZGfvO2vuBKfMEWzV8PZPJY
         wNxDtS5IYwKpg+h2u5LoGqu+4EcmJjLP6CkttynbhcW07BlEG/pqR3Jpq6GH4DsQlSFv
         QZo0upQKa6mWTF6mhetaTIumYK+1RrGmYKzaorapE6er5G3OQ/ZvrtBQEXTEasH2ifEV
         3Pn4+639A3sF4JH46Fag7Gx2+3550ymjsUwb2o9GptDnoAlWCRNN+qB/tckXSbJK7jPb
         dwM8DnaN43bXge83JUQpL0c40oa9uTgOFviZ9qWRftF689kZcWCFjqlQnmmRm05UzTXm
         woTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110696; x=1784715496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6N0CWGkPVZZZBaPfB3WmWHTmuDOaLDUgxDEGdffRFw=;
        b=PJY6deZ56f8QU/7D+4vua8n1PH79ESpLVNjPCon1miIOYQix8TfLYRSdJl8SCvTWtA
         RhNRfbhFJJ+iQJ1RznEF4pdE9m/kR0VxMroPSeKjd2RMptl2bzBi0fpPZUe5UKwdoiGN
         ze6xOZQ7HvW0Lg52af6mK+4ipZVuToCVgdAKNJD7Hl6gD+Dq6VNDe/wSZajOpyDHBGSt
         q/e6bZhPL2uy8sVRtkPQG6FYCD5pDnu2cohEO3EXp+kgJdNo0GEUMdNzF5VCv7lcCS7C
         I+wLkwF2Huxu4+AiQs7rqd6MqEdTD1UPwt9wOmm/r5qGZkemyYylVOnKErmWGDzgXSDM
         Pgqw==
X-Gm-Message-State: AOJu0YwwQVPyhFgjbwVWUV8jX9+yyQkHSzRC5P+SxBYbyz+lQBx0LqFJ
	6AOOHMVL1TcKJpbuBj04tiGr/E+hHgTiBIGAUqnEYiNPUYnncTYiaTloQ7edT6kvXzmj3yoHHsJ
	m52BF33jjxfBFrKHishaUBjgPyK150OTJ7BZwlsNTZZc5I3944uIdT0RONHMlXvs=
X-Gm-Gg: AfdE7cn3bw7WWoFtkdIztvJinwYHWmwH7bXQytHTbsdqaPAdPwzHOdiHP7yKF1LoFEB
	nZHqpwu1XKGbk9eNM0NvU0aczsNSRclRAfQEkxRFYRvxtbFrFBvwjmu1EVnaPzRqW3eArxjVBEU
	4mMoKUI3sbZQ1Uh/mA6crJWmf9GUqASDhiP8Xw4/hHFRYViCHzjg7a9aSNVw3+H/gM7GsgFQYbY
	O/gGbZiyClACIGCAL30tu//2KDnXoqzLPtAErP/a0asgZ64RlHMGeDUBgiAw17mt8GrQAiXxTE1
	5Xys8R1ZvQh3cVlJiVBbeBUQ3mG0oGEXg5GeXgeQFCNZ7SXyiJ/uzBebKLrwxoSpfyzjhMKk63R
	JZvX9RkXkHGNfZHdmLEdEU/ej65ujUB6nwGeJSQxJW/md2g==
X-Received: by 2002:a17:902:d510:b0:2c9:e846:a589 with SMTP id d9443c01a7336-2cea17f9ccamr157653515ad.13.1784110695739;
        Wed, 15 Jul 2026 03:18:15 -0700 (PDT)
X-Received: by 2002:a17:902:d510:b0:2c9:e846:a589 with SMTP id d9443c01a7336-2cea17f9ccamr157653245ad.13.1784110695206;
        Wed, 15 Jul 2026 03:18:15 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e33sm129267985ad.74.2026.07.15.03.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:18:14 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V5] i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency
Date: Wed, 15 Jul 2026 15:48:05 +0530
Message-Id: <20260715101805.3615166-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEwMCBTYWx0ZWRfX92xeIIbuxtkD
 5pNDuGfS/bVItkRWTi5fKemJkvvKxIsDHgAIna94TphM0jfvKwlJPivQxW9B2dTKbq4bYh7R5AE
 kyagxZ21c6O57U4DVqZhDS2UJmAyjgY=
X-Proofpoint-ORIG-GUID: dOfwZ36Hd0waYZTB9SXBoJMqaUXqMOA7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEwMCBTYWx0ZWRfX5d86DI97Ys36
 ZbZeA5WT9jnkZgg7ipX5uEEx+JXdeEME9HexiAIwm70JT3d23NMuwGCrfYXxE34ApR5mguHjzms
 KFjby8ZUEgwFD6NaFiHcPTtVVdN5WeiZwOpxXsYZpO/rTsiFeoNfDdUipGJ/75ttR8Ne9DhjlT2
 syropL8LFic7CIiil+VnKrMBL27eV1epDl8RMAUtMDB9QQ0t3Wb2/hT8eQ1U5BneMh2H5JZF2CP
 kIaZB4QmH2mTe33nQawO27RUdiCHAnBnxfHV/CLmJ/Chgk3ZlZW7gUgy+kbo9XOjUXUcegsHQ4A
 b7mFPLBk3qlRvYThL4rwzIS+CJAt0EEZ8qWRPsY0k8Z+6vIt3fECCEkyQq0Hy4NCVHb51d23jZy
 Xj+/UlpZDgnc0GQZNRobVETKwarJmA9B5h+hooR9ylMKuePhenZ8xkk1ySCVIJrGxNsASETZDNh
 5bDUKhm4jDBm+kxSDsQ==
X-Authority-Analysis: v=2.4 cv=LpKiDHdc c=1 sm=1 tr=0 ts=6a575e68 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=z1CpEO-fZNADMcIYu6MA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: dOfwZ36Hd0waYZTB9SXBoJMqaUXqMOA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150100

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time. Add a 300 ms
floor to account for I2C clock stretching and other situations where a
slave may keep SCL asserted for an extended period, including faulty
devices holding the bus.

This replaces the fixed 1-second timeout with a transfer-specific
timeout while preserving sufficient margin for software overheads and
bus-level delays.

For GPI multi-descriptor transfers, use the maximum message length
across all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in V5:
- Updated the commit message as per the review comments.

Changes in V4:
- As per konrad suggestion used mult_frac() for bit_usec to avoid
 intermediate overflow on 32-bit targets.
- Updated the commit message and added a driver comment explaining the
 rationale for the 0.3-second minimum timeout floor value.

 drivers/i2c/busses/i2c-qcom-geni.c | 47 +++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..f011d2564cd2 100644
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
@@ -204,6 +209,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 	return -EINVAL;
 }
 
+static unsigned long geni_i2c_xfer_timeout(struct geni_i2c_dev *gi2c, size_t len)
+{
+	size_t bit_cnt = len * 9;
+	size_t bit_usec = mult_frac(bit_cnt, USEC_PER_SEC, gi2c->clk_freq_out);
+	size_t xfer_max_usec = (bit_usec * I2C_TIMEOUT_SAFETY_COEFFICIENT) +
+			       I2C_TIMEOUT_MIN_USEC;
+
+	return usecs_to_jiffies(xfer_max_usec);
+}
+
 static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 {
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
@@ -445,7 +460,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +485,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +500,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +528,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +608,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +618,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +629,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +753,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
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
@@ -851,8 +876,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
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

