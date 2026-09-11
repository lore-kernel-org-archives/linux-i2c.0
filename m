Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C985443E4E
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110041; cv=none; b=GstasdCzmHQcl6Qd9tr3GvCgVLDmZtdycgjXpwKB8cWCoWZc6N/EsfqJJUhQ0nTIGclO4x3qTI6X1j3OhoL9hGn0Un8P9mQgbqmUt2hzWezG7ry5lIP9BNvm5noYDBRFXZF3W3vTAMUcEQn8a0Nrb7Ait0AvMrjOH/zKzL1VuZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110041; c=relaxed/simple;
	bh=WK14kF4EOiz8WnbFV9tZuZCiFiCbHnSjpwVMdu0yWYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fBBmSHElS3CObxtwDHeEoesX5iwCFu20O+afNHXTOpseumMHZavQlRhRsPEEUM94PYt100FRjVdI8nieS48sAHgk+13vkx6puxNzV+igB1RMjujUIFM29DQC8f1g/Eei2/VvuRMywbkKjvFPOpI6Hd2T5NAlv+6cpxBRZnE9RAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SntMglK8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6kMNA2K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SntMglK8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6kMNA2K"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B6kEOg006415
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KeXCEwNC4fRFjlbOCrwn9li1Urokjxh0CwWMHmoG4No=; b=SntMglK8u85aI4Ww
	NS15XRYuNs9vhkivmKz1UiaRVxbYiVuG5KsQSEBKWJND3nZu1pEna1+8CbVOBdM3
	OEWNFyjCdxbYWxTLXSDhoEAX9+QVZXIxSHF2JHr9dAYRrw0g2vLDjDDXufioQJgT
	iXaYRAn2ZCftr7FZtIYmEPK7jW3tBEFzzbwXjuY/lynVYQpvCrL86xkrnrwwWmes
	VUoyWlkhTlBxCEm4kUOXz1Zgn2WVMMobFgWNrTpq9y3hkFujr7s4lDO1b5CuRIqE
	wzznIHT6t8oypCPiKUvhOXq3IWrVa0oA07yZCiBWNk7+fIkGCBnIMKS+f72+KXfI
	X3zrDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd38cqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 07:00:16 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f57e31b6eso729793a91.1
        for <linux-i2c@vger.kernel.org>; Fri, 11 Sep 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789110015; x=1789714815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KeXCEwNC4fRFjlbOCrwn9li1Urokjxh0CwWMHmoG4No=;
        b=H6kMNA2K5OV9fzPNGQWAz8k6h49iQgFbLgODsOU2MUS7qs5JNS9M8eCJnKWPKwmpaP
         EyZcZ7B2AWsyIkfDq5AXs2XiOo/a6erA3zrmqPTXommG2fUMrbeamP3RZBlcVjzBjZrc
         /7o/XZcJtLDx6ls8sbHRz24DE5ABjRUSoziHy3T5F/b+AGz1bz6l85G+9ubWrDb1nryg
         0WraGb6k8x+Mqt6b0P6lTF0VL/PejmPeJtJPSV8s+sAlC0KzOeQF4C4INwO23cqgTRpd
         vAf7REWbb97dmVnJmO4WjvTitNckC/L4xiI1jqd19qNYqB/VevwZdC1Q6RyUMt9oN4GV
         +H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110015; x=1789714815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeXCEwNC4fRFjlbOCrwn9li1Urokjxh0CwWMHmoG4No=;
        b=CCCCAxsAPHQ3rcmGwksT9RZ7HafUWEiU+jdShWGwYRq8jXmfY5OQ875tE9p8yZlFhu
         YprdfVqBROtC12mbsudaKAzVpmJMWWxLhKyKcxaPVcv/HqQhbC19ZbRNoHxozoP1pyuO
         UZQGCddE2Zi9sdRhsyrpIWPAQ2mHj2YDL61IeHoWbOnNjSJHCzCtCTZXVhZzOvDpUOfF
         WXuEQtT483NvNuxLbGfmeZ6hrt5E+GgE3J7Nxwe6Nuj5mQ2EazYpbgWGjQ6PpuuQp1+E
         cy7ilOl1wV/C0P2Mu5MeSyYiS5L2SgHAZdnnSGHKNi9wAToLwaYOiz+qNagjUu5bVFxN
         ZOGA==
X-Forwarded-Encrypted: i=1; AKwUvBzVvs8yy5WHss68tKnzcMCpkqptA8O9wtxTfLKqvxNlfPYvbN5WlD5duY5bzwZyCpSyumwRm5rbEjk=@vger.kernel.org
X-Gm-Message-State: AFuF++ke7uNAB8P7R83mSwdZYsgjZXeJMuPG0f3nTw5qGVfLUnHyHq12
	IfAPAO+MH7I06cU/W9HMNZafhprzFdY31QHATQoLGYsgWbqo5j10s/AjnRKPMJmD75xuJHWOF/x
	meVBSnu1uf5Y57MOAgHBkdOCw1Q2GVjjZucz2TVVVObMlgkto+6v6LQRIy73wk1A=
X-Gm-Gg: AYBFou1NL3ynxfJi2BhvmDSJOty8XyYKUlWhG/tfeKfIcWThvh4+32Jggty5xfKsFJW
	UcGGtGJLX5y7NZN8MAIdPWl4ylT20uwrGCRyT8d0yYKDai0djqbHAThLYTAl4TxVFlIf/kykHf7
	NXQrx1nuO+XwIu3jNHo056BLEpGZgNdT5kJ8R0nPF7g66tAOHTrrxROa9pgUJLMRFYTh+ZGoG1b
	DDG/dpR/1wWHMj2Id9Jw4Hdih/G949ahWSeCusvdZcDwNFsbf4qgUWTHFS3isiN0rf/c3XgrF7l
	BmM2+8MBhu+zTKKv2dWDYLeDF/YvTWupEAfAcQRnv3vIocwYT+CjrpchlFgVXlG3WIKFy5yPBZJ
	zOtnDzbaXPxfmU2jvowTyJcDH3EpYtj3gHRk=
X-Received: by 2002:a17:90b:528b:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39d9c35a3ccmr4600104a91.24.1789110015230;
        Fri, 11 Sep 2026 00:00:15 -0700 (PDT)
X-Received: by 2002:a17:90b:528b:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39d9c35a3ccmr4600015a91.24.1789110014699;
        Fri, 11 Sep 2026 00:00:14 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a8a9sm3799532eec.13.2026.09.11.00.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 00:00:14 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:52 +0530
Subject: [PATCH v9 2/2] i2c: qcom-geni: Add dynamic transfer timeout based
 on transfer length and frequency
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-master-v9-2-77ac458344e2@oss.qualcomm.com>
References: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
In-Reply-To: <20260911-master-v9-0-77ac458344e2@oss.qualcomm.com>
To: Andi Shyti <andi.shyti@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
        naresh.maramaina@oss.qualcomm.com, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789110003; l=5876;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=WK14kF4EOiz8WnbFV9tZuZCiFiCbHnSjpwVMdu0yWYg=;
 b=cfr3RKHUK1mVL30/osItLwyNJY/nue0fQhMRoECppqbxf1VUEoMs6jRVDxjStxHYx7ULUn9GX
 CCO08czr8yMAUoIiJ6YPRTJt4ZFKsQE1uynsG9xbOLlN7Vmlwlcuey5
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa3a700 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ZP9fceawhsPimmF_JtQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 3OZrcjPFX3MCbiHTHbM7C4sY3YT375WV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfXwTUx78D7rtwC
 K5MTs52mGEB9xdCgzoiHwSLURm0OyrKEv//HG6+Gj1n1jOZLvx3owut8Ub1NrvSHC+VZCe9wbFD
 5Bbf46lYxFNbQ3SvPj3H7QwEGO4aX2w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDA5NSBTYWx0ZWRfX7JmNLp0Xuiwy
 WjqujXGUjRgXxcz56cGtprOWrVcgLqnGZCZzrzmTngWrQwprYGCyyX747lvE6SVbOdOpMaGCmrr
 jluDL/OTrJgDawfQSYdRdD4dER0/7B2sTYfy2W/fqaRl04hVdHg0xoIvLcxi2JfrrJKcNqja+yY
 K8iMUpFrd9zRnjfYgmEMQ0Ip2aOJZ0FTNB9auGyf47RE8f7nUAqk3NhOLo8GurRLFMMhT0fsJ3o
 kS+vaD3SkBXEuM0NH/tKTaEOXxAmPzRgjnkqVb/aMq1PmIy1XKgLF+6iQrwPceMDcpBv/zWyDOZ
 vDPMY/Q7J2hZNpt2grtRGWh9gyH6XrR159CVbz6SQV3+XZrh8oodaQ/HI6rBeDp3UIuNvdYgO5p
 H/TeACpEpvmeCN4fIszafiFlwTjQBJ8Fc/Fb3irnhhaaRT0oTNzBz3fs+LTbFZ74iUybJmvsSVG
 73ScDLes09pwmolv8sw==
X-Proofpoint-ORIG-GUID: 3OZrcjPFX3MCbiHTHbM7C4sY3YT375WV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110095

The driver uses a static XFER_TIMEOUT of HZ (1 second) for all transfers
regardless of message length or bus frequency, causing unnecessary
delays on error paths.

Use i2c_update_timeout() API to calculate transfer timeouts dynamically
based on message length and bus frequency. update the timeout per message
for FIFO, SE-DMA and GPI single descriptor transfers. For GPI multi
descriptor transfers, calculate the timeout from the combined length of
all messages, as completion is reported only after the entire batch has
finished.

A 10x safety margin over the theoretical wire time is applied, with a
300ms floor to account for I2C clock stretching and other situations where
a slave may keep SCL asserted for an extended period, including faulty
devices holding the bus.

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 48 +++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..203f4d627ca1 100644
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
@@ -513,7 +518,10 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	}
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT,
+			   I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
@@ -555,7 +563,10 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 		writel_relaxed(1, se->base + SE_GENI_TX_WATERMARK_REG);
 
 	cur = gi2c->cur;
-	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
+	i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, len,
+			   I2C_TIMEOUT_SAFETY_COEFFICIENT,
+			   I2C_TIMEOUT_MIN_USEC);
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
 	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
@@ -633,7 +644,7 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
  * geni_i2c_gpi_multi_xfer_timeout_handler() - Handles multi message transfer timeout
  * @dev: Pointer to the corresponding dev node
  * @multi_xfer: Pointer to the geni_i2c_gpi_multi_desc_xfer
- * @transfer_timeout_msecs: Timeout value in milliseconds
+ * @timeout_jiffies: Per-message completion timeout in jiffies
  * @transfer_comp: Completion object of the transfer
  *
  * This function waits for the completion of each processed transfer messages
@@ -643,18 +654,18 @@ static void geni_i2c_gpi_multi_desc_unmap(struct geni_i2c_dev *gi2c, struct i2c_
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
@@ -778,8 +789,24 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],
 		dma_async_issue_pending(gi2c->tx_c);
 
 		if ((msg_idx == (gi2c->num_msgs - 1)) || flags & DMA_PREP_INTERRUPT) {
+			size_t total_len = 0;
+			int j;
+
+			/*
+			 * All TREs except the last carry the BEI bit, so a single
+			 * completion interrupt fires only after the entire batch has
+			 * drained on the wire. The timeout budget must therefore cover
+			 * the combined wire time of every message in the batch.
+			 */
+			for (j = 0; j < gi2c->num_msgs; j++)
+				total_len += msgs[j].len;
+
+			i2c_update_timeout(&gi2c->adap, gi2c->clk_freq_out, total_len,
+					   I2C_TIMEOUT_SAFETY_COEFFICIENT,
+					   I2C_TIMEOUT_MIN_USEC);
 			ret = geni_i2c_gpi_multi_xfer_timeout_handler(gi2c->se.dev, gi2c_gpi_xfer,
-								      XFER_TIMEOUT, &gi2c->done);
+								      gi2c->adap.timeout,
+								      &gi2c->done);
 			if (ret) {
 				dev_err(gi2c->se.dev,
 					"I2C multi write msg transfer timeout: %d\n",
@@ -899,7 +926,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 
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

