Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6943B4B5
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 16:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699885; cv=none; b=kpB7WDMLgRJqNcMlOUnbv8P0slg5dTnhiM8E8RrmY1kZUItiL4+HYEf1hr+w1exwJ59iml3+7Czeku67pghyNfvZ6LfSdyauD6soQbNEXmSCotUcnzE8WrUMXVNH3IaYZ3l1nGvEsVP4GMkzGqZp8XhahxfoWoIISKZMQr6Xs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699885; c=relaxed/simple;
	bh=9AdOw2utOUy8At6CB5zdi6t3HYQn47X5MK/JJiqcs1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BBT6MATBKv5cA1oyAeBtAB/nhoBaGgmBGLLyOa8eThv3arwXW/2YbDHtUaKklUmt16aa7KzXKFzd51t5yguYe8KlessdoSir3Is/B/KQgBjn2entEhvAJNHt50ECE+7o2m8JEqY/nDFSDaGXAXnX8PFI9Lth5lCxZsZ4SRVJYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niHyyzJ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RMjoaN/C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niHyyzJ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMjoaN/C"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEcSa91078379
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 16:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVF
	g/AQ6n/g=; b=niHyyzJ9n6F4jllZESey+VgnsJ0EmhI0zq+OrGKZ2UwTUmL+iVx
	MbG+8FhcJ9BGjmfpQNPgJ10f3rax8Yy1oVVmGZexTbWWfEXs2zyGUEx2Xx+XHoGP
	vec/AL4xZr9vJRXrNgKyhH4BuDWhg85OkpYNKccqNFArk0DywZIIzTLHH2dHMq8V
	tds6InoIiZLKpgKPjpcXteW619tfxI/VIYu+Ulvhf6wFJQRT+g3quUsI4f+lTE5t
	RjXLxLhOWy2vXCbv52voip4K4hdIVLhFXTw66snsH86nWSIz3AmsCUDPsnPrwrsV
	UsOkVzZUIoCF+XKmIP6GrfxsBS4AlrG+hfg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f9gjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 16:11:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1fcso2038789a12.3
        for <linux-i2c@vger.kernel.org>; Fri, 10 Jul 2026 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783699867; x=1784304667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVFg/AQ6n/g=;
        b=RMjoaN/CujgIA1VsRygCHjqn8SBuidqNfcUDEfOJjN8vQxrDwL+d2BqoI5PmN+miSd
         Ma1eI+zCFES6LYNHRUUXDUVpxhpcoglEMir/mAFBLVGa3VwY7+VM3LqwhWe3FoaLnqBj
         5GubG/kMPra2RkcCL0IFGM9CBWfLQvjc2sHEDK9IWlrgmAnJ3lu9CfjE6A92+sQFBKoE
         ZoLnykVPzMd0FB34rDtkHXx2AWU7+mmW1VzxxqcvKOdkN3ShzmsXMy/ufzpja90sv19H
         J5CPdGIBrbTK4MtvFdAbhGLXQRzv0o7OJhBtTgYWqvmO1WyoqlP+NRv/hl8Vg9eWPSXG
         QDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699867; x=1784304667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KheAc7I+aBb0Mu9MvhRuCgqeY8ZW+ixLVFg/AQ6n/g=;
        b=WP9t8xQfc02Dmx5+nFbk81mAPV++/LC8LyGRJeOtfJAi722VPUaZcqqDtmO9JlSlCb
         bT90QYgVLHLfEm5EeJyqGzMimLWoIFNFaNzsMw6WZdaPsYgRn5uJoq4BZd9zfFFU6Q1E
         qvcYT2/enwIYbEBbNnV+3Dr1DVks6LD20iYqMd+XCfQf/zsvqlZfkDiiE3BsZ1ml6wQC
         6YZf65fTNK5mB+XK/6U5ukCYS9KSIbgNCV4OzTVkXiqpZubgVbwa5xvcHEvfr1NyDv4J
         qG/2q6Lwfo4ElDQ5ZabFi0kmzOzw8i21Ywu3T/3hSMeFEBjt+QhdiQCnjeTwyVRCJZyD
         T8Aw==
X-Gm-Message-State: AOJu0YxpU3GvOlsLsbm92WG17Yi5O/cbVIaCEklSRmxR0OGGF3LgMTrR
	7SmyEPn8he5eHZkbaGsq4xnZHF8VjGvD27Pf6beJPYBdnvYr+sTEUee3sWqRGcsBq4BznU4BKhL
	b09Fb/Qnlg11iReOTSkLRE5Wf9ayvmTbNVK0Y7pA07tC4c/jE8qSA9ogOxvZ0GWA=
X-Gm-Gg: AfdE7cn52D1WbF2lw5ixJQwdfSLHgzbTWdgJtWS+MZ8haig1S6w/EAh5sSnWE7UamBN
	mKyji4TMINujQG3P/+O9941BIaVD/iUlvLTa/ZMaTIzYBtFvIRkh9OBo/pRcMUR6nQAvjp5A3Bp
	kEgONNWLQ32mJ0C0AqnLJtdEQiE6d6Xu9fpEfJkUnXEuf8tAUy/WXqRwv7UWutx6MDN42ee5X/e
	8wXCQCdkfRPELbjX2+bYKac0VEG/kTr5u9ezqPVsznajDy7LRhyHtK3ucyr1QZmaOXPxguHsaWZ
	vFFaV2/6h+VQccl8Kh34mlz+07rdA2LMo/eKRHLlLK2Hdrnj8NtpQK16dBr4rd7IK9ix7dG4161
	5H8RtnYegGjfHJ1XTRrFmfM+IDGwu/9+BHF3/j7G9isBHEA==
X-Received: by 2002:a05:6a20:a123:b0:3bf:97e8:a026 with SMTP id adf61e73a8af0-3c0bced45eamr14574929637.25.1783699866556;
        Fri, 10 Jul 2026 09:11:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:a123:b0:3bf:97e8:a026 with SMTP id adf61e73a8af0-3c0bced45eamr14574892637.25.1783699866069;
        Fri, 10 Jul 2026 09:11:06 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3b251eesm5128818a12.31.2026.07.10.09.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:11:05 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        andi.shyti@kernel.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        naresh.maramaina@oss.qualcomm.com, aniket.randive@oss.qualcomm.com
Subject: [PATCH V4] i2c: qcom-geni: Add dynamic transfer timeout based on transfer length and frequency
Date: Fri, 10 Jul 2026 21:40:56 +0530
Message-Id: <20260710161056.1799019-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a51199b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=z1CpEO-fZNADMcIYu6MA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: qSXlZaTp7bwZMsvSui8tUa24OI3z67yQ
X-Proofpoint-GUID: qSXlZaTp7bwZMsvSui8tUa24OI3z67yQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE2MSBTYWx0ZWRfX/McT103/kSnj
 z8+uA5LCR1+fb1pFJzXhkI82fMuNPuWA0Wrx8T9RGEnfZzho1jSCQ0AbQH6mF0Cjx+oIbugd6Vi
 BRyENH+7sfG/Q3U6/F2Mj1ryNQFaknA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE2MSBTYWx0ZWRfXwUY9JYHs4u8A
 UBTocLpbqDF6E+ThqNO4TNzuu/AQXKejN5VHTSfo7iqvw0S6zWknXNNbYnGU91xHSe5RpPX0mL9
 MUkELuayQOKXhAm0k/2d8wW56fbV+pnNgBf0tetbkXgvFrm9Nh+g4hIdQHPnCp3xsvYFbEqyAFm
 U+HHOnPWBo7/SUHHymvf/LE58swX8gzPB/SAZHBUnszM8xlMO/JKHzcXKuzMdFf2UELmrrVDqW4
 LJgDoBCvvtMU8VFCu52cPQze/wwWy+AE6EZvZRKxBjnNwsd5QYXvSlcEozmQZSJ+LQNVkd3ML3F
 0Wt1j1AuORYJy4JfhYAjgBZO9G8h7yKYRP5gaPJObE/SUrCFYkzswb03z+cZWqxXoGdPlWbaoA+
 F6aSWPg1o+2eHuTSbauV5tusDm69A/GiM/LZokfe2P1PfX7fVMYiP2ynaI2c60NNDdgDRMpjLYs
 JMRYP7S38HtlnQMSJtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100161

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Compute the timeout dynamically from message length and bus frequency
with a 10x safety margin over the theoretical wire time. Add a 300ms
floor to budget for I2C clock stretching, where a slave may hold SCL
low indefinitely during internal processing. This detects real hangs
3x faster than the old 1s static timeout.

For GPI multi-descriptor transfers, use the maximum message length across
all queued messages as the per-completion timeout.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v4:
 - As per konrad suggestion used mult_frac() for bit_usec to avoid intermediate
  overflow on 32-bit targets.
 - Updated the commit message and added a driver comment explaining the
   rationale for the 0.3-second minimum timeout floor value.

 drivers/i2c/busses/i2c-qcom-geni.c | 46 +++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..c5c3adc8ec77 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,9 +74,13 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
-#define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
+/* 9 bits per byte (8 data + 1 ACK), 10x safety margin */
+#define I2C_TIMEOUT_SAFETY_COEFFICIENT	10
+/* 300ms floor: budget for clock stretching; slave may hold SCL low indefinitely */
+#define I2C_TIMEOUT_MIN_USEC		300000
+
 struct geni_i2c_desc {
 	bool no_dma_support;
 	unsigned int tx_fifo_depth;
@@ -204,6 +208,16 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
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
@@ -445,7 +459,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t rx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -470,8 +484,9 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		gi2c->dma_buf = dma_buf;
 	}
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -484,7 +499,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 				u32 m_param)
 {
 	dma_addr_t tx_dma = 0;
-	unsigned long time_left;
+	unsigned long time_left, timeout;
 	void *dma_buf;
 	struct geni_se *se = &gi2c->se;
 	size_t len = msg->len;
@@ -512,8 +527,9 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	if (!dma_buf) /* Get FIFO IRQ */
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
+	timeout = geni_i2c_xfer_timeout(gi2c, len);
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	time_left = wait_for_completion_timeout(&gi2c->done, timeout);
 	if (!time_left)
 		geni_i2c_abort_xfer(gi2c);
 
@@ -591,7 +607,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @transfer_timeout_msecs: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -601,7 +617,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  */
 static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 						   struct geni_i2c_gpi_multi_desc_xfer *multi_xfer,
-						   u32 transfer_timeout_msecs,
+						   unsigned long timeout_jiffies,
 						   struct completion *transfer_comp)
 {
 	int i;
@@ -612,7 +628,7 @@ static int geni_i2c_gpi_multi_xfer_timeout_handler(struct device *dev,
 
 		if (multi_xfer->msg_idx_cnt != multi_xfer->irq_cnt) {
 			time_left = wait_for_completion_timeout(transfer_comp,
-								transfer_timeout_msecs);
+								timeout_jiffies);
 			if (!time_left) {
 				dev_err(dev, "%s: Transfer timeout\n", __func__);
 				return -ETIMEDOUT;
@@ -736,8 +752,16 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
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
@@ -851,8 +875,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
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

