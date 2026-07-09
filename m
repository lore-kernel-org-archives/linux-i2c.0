Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D93AEF3E
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 06:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576818; cv=none; b=JZSPkHAZ3r9cBxEGznHCdu6KFcFXsHw9OYmtHbrwS5xvVsO4HUuC+scXjxCG72dqlde+0lOrdl/BzFXI3F/ifkySsjyyd2jeyt2Sr8qx4HsATcuAOjRP3MMMP56JIcHJaHECPcsqcqPNcpemuvWa4swzjok9+0dmnyHpP9S66mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576818; c=relaxed/simple;
	bh=IAMjpAROrbIxgKLXNKMtTjoTS5BkaDQyk/j9B8rbF60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AvL9gYXQUr0jX0UXIWr2wQ1rlF2HnzsF3H01VISuVvnc+UNUpusKkVZpRzhbdyPBO1SdL7cay46g1g1m86Zgurci/KbgViFhmoObRA11wtoSkArHG9kX5+qApIsbvE0HrRlFpPvCoT8lPqA8i30rNZptPsCe457DdbFGcpyZsNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W18p0KLO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dyfV0tcu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W18p0KLO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dyfV0tcu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960FVD749619
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 06:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPC
	pZLTjswY=; b=W18p0KLOMqGgiuhbsBZ44PvbjZxW6wgKHH4ebgV7ChQ5lzGfKw4
	jKV9zTj/d3hG+ns1/8t6yRA9n1rNkjzW4Xmeb+mKP8WU7IMj1z6nSiQ0qV8cSg6d
	75ZsBmvDJfqz/zoSbxbH/SV+arwQcmJfIY8GRqcbkbFuQk4zGkMluvFFbCRpOkcj
	9oAUklE8k3iJbJKkkvJpxUFMfm8sB8cCXVdHbOmrvj80LV/XmMNFAQ4yxJ31IiNH
	U+YcFj/r6Q/1otLfYS1CoNYbx66HWYu6M4u9qvHPJSBp+HjPluJ+M9DTp8xPAcmt
	19aIauhynvKLn79unjY0DeyJB55v5YA6+bA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9wwfshk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 06:00:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c804e38c65so35032785ad.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 23:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783576808; x=1784181608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPCpZLTjswY=;
        b=dyfV0tcuCBScPAhUp3SJ9DbgdpZuz/SZLCQTcvUiW9SumH6jsXUubCEJw52uaIk97p
         B/R0XPSf49dOA8TfhUOr/EV4+H6gXcmnNfC0koZjCY+WafoVZ0kQ9FusP7DI6kscFk8L
         XHYYkc5nuYT3HlJFjnjDnej8oHT5tINq5So74eYDtGyX876/MjYuHe9W+hPv5gBi9DdX
         4z+hv44s6XbpDuRTAxKW/zRrqwluPHOhdpScT7RXvQIqfjHMbrmVGSSbPW05n4S0k35J
         W4bupeGnPNgPhc743MOy3fFN81h6Ij9em5RvNjzZuxMCtmB2ngcHE3MZvgrl43GRoDY2
         nuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783576808; x=1784181608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KVejRE01iSJ9Cu8Vv9/R1+qSCrCIqHbYQPCpZLTjswY=;
        b=Wgp9Iz8QN5Qr/wmVowid9xo42jJpXYpwAQ2V+nyXYfMD/swxPWyQJjPV/b6DHTqOjr
         i7VHDXsy+x4HYes2SrsKiLLDUGT6bmclNts72jyhaWIQdsfuwwwZUX7AcZyy2x3OSV7n
         IlPDMc9Va1Ak9OzzH77zD/cYiGfDH29TiY9+gavaFjOf+wAtvnzK8ugeRslz4D3XfC+d
         VZvnImNsYH4tiYnPSr7w7FUh3DkaU4s1zWn97nKf/TDIfHCSjiklGJDiCuXCNrQRU0tV
         K7JYkXs871RPdZzudOfY53jqTMVKUDpSCV1/zhrR4YZh6uNAqwJRp18R2k2foVxzfYme
         DS2Q==
X-Gm-Message-State: AOJu0Yymcd1y+Cz3yDjEejLU0GOATw1tT8Ng5Cdvm+bMtR8CI18WjFbh
	njw49gL9vI7/lCXEcoURxg+3J5TbNn6GgoUAfl5HJBFeivu9rFNfqmyXv//vuUB8De3BXh6Bbiv
	hyQP88M6ZYKK4ZvtDnT0kBhbsgDgClniBL+q8TNWGLKDv10jARcxzHrqYyYjG0+o=
X-Gm-Gg: AfdE7clCRzabI07krdLYRBdP1B9IPimfACy6cfTT3SkVuVXtYu4/7Dh8KhOXlvLtqNl
	Hcjz9Gu5P4NaS5do7TijaVA9f+uXw0+3M4fB0Dn4xAX4lstgLaWvR9SCSKORCapqyMqushtmgoI
	ttb4Gsnb+G+z5EasogkywaTrtQ6qwVg3ygzywYbfd46/lh4mhiGsgjjilpLbr0t2LGWGI7SweZU
	MSwgesDaAvWXUP0Ogw19CH5I0cssm2kz80c3oNrdJkX1ga+xXNBHSYcRTR83h4YYglUhHf+D9fJ
	4lgFG53ADO6QbkWORBh37VzrFRjGFvpsdQM/csZJUR+719jXDbxBIyW7zuq+hd6eRR/uxlkhLQi
	n8NIqDHxQKFr9qYMt4qrOVpEnxlEmoPVZkK3hoC5nA/fNww==
X-Received: by 2002:a17:903:22ca:b0:2cc:777f:d67d with SMTP id d9443c01a7336-2ccea42ca48mr61321505ad.30.1783576807293;
        Wed, 08 Jul 2026 23:00:07 -0700 (PDT)
X-Received: by 2002:a17:903:22ca:b0:2cc:777f:d67d with SMTP id d9443c01a7336-2ccea42ca48mr61320405ad.30.1783576806265;
        Wed, 08 Jul 2026 23:00:06 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5c361sm37864555ad.80.2026.07.08.23.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:00:05 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH v2] i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency
Date: Thu,  9 Jul 2026 11:29:58 +0530
Message-Id: <20260709055958.4089039-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX42HfbsW32HD3
 R5pJvVQEVC2KZQjU/7iuSXHVGLeCdYEeC+doGHuUtSQGJNzAdsT9tSwsqShzjSsFPe/cbUVCB13
 QgyhIbplKN5TlNDmYPk+1Cu/QZokSzs3OWWN9NyM0bdYfEb/0BdAKf47Le6EQS/CsqB0139NCTP
 symmoqnaO1fqMzPq4N3V25FfY3mHjyPtAHZjaa9XGkW4lzKxD7N/Yd6D989e9aDo7ibzBxMbUvp
 C9zAWg/CwNhOeXNWYbNZYhoLcnluhvB7B9Pq6hDw8jwTSzyvmM2EJWGpQ1nsDsXTHFwxvZbFurW
 Zvby/UGnH44vHB7Vtk+2gb+79bCF3CJ+IEosAnLSW6c4q1PTTM4YOWlYBtQyhjr2ypo7E9y4FDd
 /kvWP2HVZw4DZARTtJhASGzKa3wOA7rZ3mPTMiqWwU078/B49j+3axjVvEmJqIozTru8u38GaA1
 6gGylbmAtsIG1mOkkgg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1NCBTYWx0ZWRfX2NEZOLh1u6vB
 A5BELdH/W0cFxuqZPA+2L7m25VXdcXhy+41zZxldM6aekQMm5F7DCusoWlpFIE8lbfANTnEjIc3
 v7OVXlm8aF02WD8vKmziGW+tQhVapyw=
X-Proofpoint-ORIG-GUID: hmkqSCHTSqEo2CV23MztDhzVH0JC0nTT
X-Proofpoint-GUID: hmkqSCHTSqEo2CV23MztDhzVH0JC0nTT
X-Authority-Analysis: v=2.4 cv=Krh9H2WN c=1 sm=1 tr=0 ts=6a4f38e8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ThEsosvJOpkTSRB3RXoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090054

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time and a 300ms
floor. For GPI multi-descriptor transfers, use the maximum message
length across all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
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

