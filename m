Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC5346FC4
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183944; cv=none; b=h/1PLly+0+hWkn98jnj6SfgeeAOX+K5eU4jrWVk00izItKSq51MBcRkcmzqt8NKhVMK6v5iQ0MEO8idokAvIHUQdstKduGmt63DhxjR34mkBZxpP8Ty+N6sntIC9J1yyEWQS1/Arr84kpeSuV/sgTY0ciFu7GMb6BdtTdNQ8/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183944; c=relaxed/simple;
	bh=fUysjhNtvV8X/Ql+qqACuezU5OdURq9AJeR3Khazz4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBdeO6bGh82hGcX1PdSQINpzcjVfpAGsO0n5y0qIjpOtPT8Ii9ETczmUq8w6LkmH74xjptCYUwB+w61H9d0Sg1l+bgml7McWsH2JRjN8Zovb7VIKuPmFNrMpZWWqGPlyAJzrR8fgnVUue56VLxwWdJvQrj/Jfj6mR24ZCHlsdf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dOjJlECL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z+PD7kyP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dOjJlECL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z+PD7kyP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wMsb1444477
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=; b=dOjJlECLtklxPlhE
	szJga4Ci7SnXTF8SqMYpl5tKE64ogJw+UO5mLTSFfhIJL0dX9jlk9up7Ax7TTkui
	sxvVDlWQtPXs8oXoxVkdmqdcLNzeJWx6UJDYBpxBm0xoZD40YKZbv9hH504fyCAn
	h+VguRvlKN7cd3jxqs4KcdtK7zdl7enUu+dBbaRI4I9d7kZp/vcWdcehnW/sFnlh
	Yje7BNGyULPnfZ42gQv6+Kv6XkCQL6yuNV9vsTg/k7Havd6lEWbICg65pVAxwDaI
	LOVcglha3jiOEymMOLEEYw7Qu6ZA0exAwlZivvMcwg9Mk9TtZh6GNQaU0y84+BDv
	jf13KA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehvadc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 16 Jul 2026 06:39:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9c26587e67so443922a12.0
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jul 2026 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784183942; x=1784788742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=;
        b=Z+PD7kyPoGCuenYqyTJO8WQcr/cP1MOu335FBZ2jR3d4yVQ+L362NsXxoh++RaUFbE
         m76xKydy/VZGOGnXazc1G5ThMb745LUjzXGrMkD96cGoTUcEfW+GOw4F5lizS0TRpU6A
         pypF27KYBpu+ScmUEpm3geO75k1wb/QRwHEBPw5VhcfwbS4tEsGb19gjSWG4uQAdLcE4
         UnCT0HTumdNKsLELnQAWNRvPTH99QkIPNJtjr1ObOsBjHN+rMij2C8m792Pim2/06CSL
         Wc9CR3QS5dYJWxlBioeZoYz293U3zHiNWJmcG8CWdNyDPSE+uajbVKIsskN2Ff4DS4SS
         tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183942; x=1784788742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=;
        b=T3WJbSuPsoutbd2gkzMkgcUED4rXp5IKMabrMMLX1AiT6b11nabiT/WYXUXc3H4Xsl
         DUQcN5MFF0Y7BshiJoaJkNcp4g2VsTxoyaA+YFxVhA8LsrWy1KkEQ8eWMX+oNlfS2A/T
         HmCFGuZ1p6JpN54yPiiSY+AnVZozvibIh2AcoDMIQAuvd4rvM2+IEj2IqWyOD6FQc2MB
         hCLcU7dKHW1OqVIzrpuW3XAsNobbKuu3gqnOJ1f6EFF5EDxOwH/LqeQyUrfjxfqQ/3Gw
         kvVlVa8Ulm+aRCBL+ynH1p3HXVDqdxKbTTfznzXVRI87QjUcUwMjvf3q6w1UyVHktx4m
         +rTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTCpAoOihj+bGRd8g4KB6sHKzsfYM/QMb+aW5bebn8OUJnLzVKdRKHrXdIA9G1d4L3hm7nhJaTJaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmESzNCjSOQKWJgeaTsccmqP2Mz/EOfRP0j1cRjfpoM5IfSdyV
	PlH77H8G7AX9B2UWtF2ymL6/kKo//ciIE2WZgOVPtSm683NlnAIYDPaAkfJnnO6NsqXJEjrKfSM
	PQWdLciGF0ARaFXvzLddg7i9hOTNfb0nV8T5Vqq9c1WOdjgBc1TeJiqmKxOEiZTw=
X-Gm-Gg: AfdE7ckChvKTF1AA52PfQWD+HqKQI+VA8nW0Wh0X+LtKV6zB3Ptm8yXwhkFt+gj8uq8
	L1IPWnr0dAcNe5QPiETEePhdZjafYcCCgzeT+H7U9QONWJHhlVya8cxNSl9BOy16qY6nl1VM6MW
	mXQxVADjugWayxdlaRUCcW5187ub+BEGufSOETGOm3uGu+tt5v+Ivv7gXSwGRUIZ/fO2nM+TnJL
	A5EFSaLVN8WXM4r1bWzvn7iwAOCXvrSs10UNHTrBOfiiVmK27Ut7qhid+dBBopdjkPtpUxc4Pz2
	9NAyH1AEz6TJvppwmVV5mFi4YvVMNb08T55E2yLgbnWJtu7PyJQbV4ztGXjI3U6c4Eaphg+MvDq
	yAT2xYxw4rVUo94sngZ9f4goH/vODVs5HOg==
X-Received: by 2002:a05:6a20:430a:b0:3bf:78a1:c140 with SMTP id adf61e73a8af0-3c38d909932mr1390165637.7.1784183941976;
        Wed, 15 Jul 2026 23:39:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:430a:b0:3bf:78a1:c140 with SMTP id adf61e73a8af0-3c38d909932mr1390150637.7.1784183941443;
        Wed, 15 Jul 2026 23:39:01 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eb82desm1320870a12.2.2026.07.15.23.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:39:01 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 12:08:43 +0530
Subject: [PATCH v3 1/3] i2c: qcom-geni: use cancel command before abort on
 transfer timeout
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-1-9091315a33a0@oss.qualcomm.com>
References: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>
In-Reply-To: <20260716-fix_cancel_sequence_on_failure_for_i2c-v3-0-9091315a33a0@oss.qualcomm.com>
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784183935; l=3620;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fUysjhNtvV8X/Ql+qqACuezU5OdURq9AJeR3Khazz4E=;
 b=jA6EeEBkgOP3ceb+J3l6rt9a6ZbWLjNSVQVUGyOZH76Oq6/e+yY6lySjkGMWeo/AFQYWBUWZz
 6aNtKrr27MSAWFp7BSbQq57niUVqh4as03Haqcq8RvVPODSOG/D4yLj
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a587c86 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=HIFZfxgX9pW5VpyTZ0YA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA2NyBTYWx0ZWRfX6lz4IGqwXBMq
 q0/eioi+ZOKGl/u+t3P2vXra2pD8kN2t+Oh3jBjiIKlNMXZzT0qRkeeCNShQahHZlXl4Rs7ltwv
 lrjjhyevtP5gG6+SE66JgUG1X9kjTu8yFa3rwJD2WcquvmyteTdhJD9hp9HLOGfYLf8oSIpkAd/
 beASuVtZFbwSDWvEV0J0sOrWJyM2xwt3ZQWBrIaysIWyvGp1Ozyc6WAKcT+eBg657DYwpNJzy4Q
 +2iEW5jpP3UhKERPbyr67TfX2k+AjzeYf8OcBOGmbzieMmTwjODQKx6bwnA0xZ7rTg89P7m8mej
 7lVaX0S1TnME6Z8X3ISQZlkzc8KeZSNX93r7FpZQa4gIJ/E1nq1TfS9V6NHZlZ0P36QNN6P6hcV
 mHE4X8SOK2zYR6QryCYtcScPIn+2IXYuhr9u8cIFoLDXFmP0Id4/DUjgBfauFqmjJuYH/IrZZTp
 vuBJxWjx/QpW9+Fvo3g==
X-Proofpoint-GUID: D5qc0XQWdzU0vBnmsOq1D8zX3ZIKVMUb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA2NyBTYWx0ZWRfXxAJtTcGlSv1T
 KeSF4jsIdvuNtTyYLRNt6pL5Y94ASATyW/Nr9xlyaNsrEBKPOTrFJelBWqmB/lAno8Fayklo5D/
 FJyvVydyEM0kSWtHTu4d3G1qPLaB4xo=
X-Proofpoint-ORIG-GUID: D5qc0XQWdzU0vBnmsOq1D8zX3ZIKVMUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160067

The GENI I2C driver currently invokes geni_se_abort_m_cmd() directly when
a transfer times out. However, the GENI hardware command cancellation
flow requires a cancel command to be issued first. An abort should only
be used as a fallback when the cancel operation itself fails to complete.

Introduce a dedicated cancel_done completion that is signaled when
M_CMD_CANCEL_EN is received. The timeout recovery path waits for cancel
completion and escalates to geni_i2c_abort_xfer() only if the cancel
command does not complete within the expected time.

Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..15403edb355a 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -74,6 +74,7 @@ enum geni_i2c_err_code {
 #define PACKING_BYTES_PW	4
 
 #define ABORT_TIMEOUT		HZ
+#define CANCEL_TIMEOUT		HZ
 #define XFER_TIMEOUT		HZ
 #define RST_TIMEOUT		HZ
 
@@ -112,6 +113,7 @@ struct geni_i2c_dev {
 	int err;
 	struct i2c_adapter adap;
 	struct completion done;
+	struct completion cancel_done;
 	struct i2c_msg *cur;
 	int cur_wr;
 	int cur_rd;
@@ -361,6 +363,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	    dm_tx_st & TX_DMA_DONE || dm_tx_st & TX_RESET_DONE ||
 	    dm_rx_st & RX_DMA_DONE || dm_rx_st & RX_RESET_DONE)
 		complete(&gi2c->done);
+	if (m_stat & M_CMD_CANCEL_EN)
+		complete(&gi2c->cancel_done);
 
 	spin_unlock(&gi2c->lock);
 
@@ -387,6 +391,27 @@ static void geni_i2c_abort_xfer(struct geni_i2c_dev *gi2c)
 		dev_err(gi2c->se.dev, "Timeout abort_m_cmd\n");
 }
 
+static void geni_i2c_cancel_xfer(struct geni_i2c_dev *gi2c)
+{
+	unsigned long time_left = msecs_to_jiffies(CANCEL_TIMEOUT);
+	unsigned long flags;
+
+	reinit_completion(&gi2c->cancel_done);
+
+	spin_lock_irqsave(&gi2c->lock, flags);
+	if (!gi2c->err)
+		geni_i2c_err(gi2c, GENI_TIMEOUT);
+	gi2c->cur = NULL;
+	geni_se_cancel_m_cmd(&gi2c->se);
+	spin_unlock_irqrestore(&gi2c->lock, flags);
+
+	time_left = wait_for_completion_timeout(&gi2c->cancel_done, time_left);
+	if (!time_left) {
+		dev_err(gi2c->se.dev, "Timeout cancel_m_cmd\n");
+		geni_i2c_abort_xfer(gi2c);
+	}
+}
+
 static void geni_i2c_rx_fsm_rst(struct geni_i2c_dev *gi2c)
 {
 	u32 val;
@@ -473,7 +498,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
-		geni_i2c_abort_xfer(gi2c);
+		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_rx_msg_cleanup(gi2c, cur);
 
@@ -515,7 +540,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
 	if (!time_left)
-		geni_i2c_abort_xfer(gi2c);
+		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_tx_msg_cleanup(gi2c, cur);
 
@@ -1107,6 +1132,7 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	gi2c->adap.algo = &geni_i2c_algo;
 	init_completion(&gi2c->done);
+	init_completion(&gi2c->cancel_done);
 	spin_lock_init(&gi2c->lock);
 	platform_set_drvdata(pdev, gi2c);
 

-- 
2.34.1

