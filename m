Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66039396B79
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 04:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570859; cv=none; b=oOkXpaZIz8Tyl6DqPTEgsR7DpPoXPpVEEv3N+56O1aUBtlM0NgFUJcCIcfmHlDrcJTmS6q1y6N5elcggM03q1oumHQLZKNwj9NxRdSO//+njZX2HWoxV0qAKz+e81kyFt05IVhtSxbCaa9+wxtw2hV0SCH59j7k0T0/6XBPmSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570859; c=relaxed/simple;
	bh=fUysjhNtvV8X/Ql+qqACuezU5OdURq9AJeR3Khazz4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CmwgnJKVNAfEqqZrxuTy9xrPPAkHg06HS3PDhhvCqr4p+3R09PgFa2FzIkEV/ogcqNFDT/M3YpLjgZWGxvQOgcVJ7O+b6/7nPOYddvDzd+NHlC++iHn73sBL1TqsV4CuyYKKct69K31PM//gpUpI+fXw9PaA2TQ7Gwy4w1hbxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ihY6abod; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g0qgyh77; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ihY6abod";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g0qgyh77"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N9iYV002839
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 04:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=; b=ihY6abodggriP8Uw
	iZq/2fM/LWeypOhwHR1PAZVlnGgqi+6XJlQ5MuXbf0X7jDwx04Gps6SRevfRalNy
	jiK/bOhKwNKGegH9pRGAQss/kus/fyo7TAGEosYodOYZrDpwhscnzNgZHO64acjK
	nfAAjbnDzt8ozjdSbJIRuEimC3nSYb0jQrpNqty0U/pfweZl263TLC8SRoXHheCU
	Hd/yq5d8cBGBYGt5grBKvp7cp8Z4sYYg3vqrQ/focHc8jAEiDkC+s1V9hF31SNLW
	b2HxfIOva9eYY7ZBBG2wG6ROVSMwy6dyEN1UdjMD7FsHHlwWXEsLk0uMPHZOp1Ll
	x2bkZw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvsqta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 04:20:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so29540405ad.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 21:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783570856; x=1784175656; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=;
        b=g0qgyh77GlnDu5XrjlYXOh6hp1fWDi1BVjYFBAHuCr0hF/2G6jd8FVnVnUEGWvQXsL
         3hN2f+G1GVOkGqxF6hrCYFV4jjBHvdaSbrZLHJXAs8OeLgjjz8O/sjOIhNcIxOvzUqL7
         iPBZ0Mb74ILfsrHpFfrhHwtgbCpx+73LXOu6QWu8/Ci1dMvcRShctlR5Amfdf+NzTsX/
         7X9mZoPo5PbMauJkAZiRlqDQb3TteEgJybC8m+Uj6dptETa4PMeWA1iDWS6vUGpIrqU9
         gQYYc0/dMXLBoZvL11gHZcpoHiDvIciuz6d1BJXdZQm7Q2MYBgM++RSUnwVWq14tjdNv
         DJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570856; x=1784175656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/olJtL4EEXjuiuE/Fu9MLOtE57HZJ7p/f88ZnmXBGcw=;
        b=idKcoN8PzFmsNz9U4WOSVpc5MlDfpgkx7vZTc6a/SUem+xTArsFh0WqKPqwpX9NNYr
         oh+Qwq/iF0nUTEGWxLoQJk6sHTZ5BXO2aLYVElngKD4rQWDYFFw67iJupINg5juW+IRB
         U9Ptu21dHx/BFg5EoD8Nr8y7psfwc6a1YqQ90UCP48O4Ftk9om12sIIBCThLdKPkOSks
         4xc7UA1MxS8h1Kyt79rSCreUgEqOWrYOGWgxtEUlKre+xEyqdjlZNY6kQ2H/l/M7yPrw
         VldhZM+nDkTrcg3PY6upa/uEDcdweJvnonH2Rc+aKxnHLp5+ItZ1B6slDY0WsRiWOM5z
         8DjQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqUGsID/w4jxyEQW2mx5Lew/RwKjghrel469vX7WoiMX0fmdWCf8C6e0Coq7rW6N6EsnsG9WW0As4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7DYHm+qMjfuAHQN1r1Q6/+R/CSlsFf+z70iXOELy6hfHJeBMZ
	NFTyxSTEY1h5u+EJwVdBE+s3vDg6Kw4M4y/RQTbfHKGYitJjRlzc4f/FtiF8U+SrQHiufuCxF8X
	FStihrQOUFcPzZnEqQQCXdoarobLKfdsAuybr3LRFS4N7fJxjHnS5VIeeOjucdr4=
X-Gm-Gg: AfdE7cn7yhq8TkmGSNBX3u76Q8GUN5fDZXrH8GQV22iyX0PzULecFFyrlMFRFrrs/pG
	3RBuwTeQ5sAEUl362SxYLolly818g8iUHkacr4owIBO2E1VB7FwYDjZxx1LAN4liiG+/0wydon6
	Id/Vs5hcWqwYnFESOsVuWuQBqbgUiVYtvpoCuZE6KcmjA/tOfsvcmi8NfQCLFgd8RCKX6YRo09L
	BPKv9tsR1FlQUQDMy1TTIQQIelA39tECR9pcHO3JPY1om3pF1F+fvbpMpBsgcCBF+bstlwbO9AD
	uO4zXmA4N7DjKQtza/coFT3es3kM8/cADzxNj8/ei9nJVRaQ4PAwHyiObkf9FIhEH3ghIXcREYk
	NW9zRwQbHMDufxWLdPHSglNiIczTq4lFOCa0P9nG3bnZP
X-Received: by 2002:a05:6a20:3d8b:b0:3c0:9c19:65c2 with SMTP id adf61e73a8af0-3c0bcd20145mr6948227637.74.1783570856306;
        Wed, 08 Jul 2026 21:20:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8b:b0:3c0:9c19:65c2 with SMTP id adf61e73a8af0-3c0bcd20145mr6948187637.74.1783570855798;
        Wed, 08 Jul 2026 21:20:55 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm25490098eec.2.2026.07.08.21.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:20:55 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 09:50:40 +0530
Subject: [PATCH v2 1/3] i2c: qcom-geni: use cancel command before abort on
 transfer timeout
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-1-1db178c695bb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783570849; l=3620;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=fUysjhNtvV8X/Ql+qqACuezU5OdURq9AJeR3Khazz4E=;
 b=tcpnCaPmpdRfdgIMv0FhXQPBBupfektEgs90MvtZmgXWpK90KxU//rHmtcSeBBxBnlBbsRYxO
 hsBqscZaPx/Cm3S0ecwrkLyh3IzzPbX5BdKADVu9t7DU6lb6aVRd1Mw
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX3TCDfsWg04C+
 MjeYoi8P+1+QOhPzEpnkXMTHdWkoxV6snvFv3sXg6hzdjDRRLDt4a8Xj0XoBKpTlQqWPqZvD9a2
 yAcyKKGK9IlXyT3hQJDyhZSvJmSXDPA=
X-Proofpoint-GUID: 4Vs-xDQ6IJhYLlrS04LnH49jxrheuwK0
X-Proofpoint-ORIG-GUID: 4Vs-xDQ6IJhYLlrS04LnH49jxrheuwK0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX9QQBYuQCJ6wt
 Wjp1jn5zN+o2a7VrQLrHcvRtDHEDsIh8Waa0ASLu/ILPkmUCZ0B7xyUlsb4sExHJlJiV4ddsk78
 IXGkkBiTQ9D8bmuR9fE3x2ObvwVXGvs6qHqU76uVuutlkh0JKzK57omNoYy0/NenSZfH0yfBcnE
 lfO1vH3itJKXO4rVpTf7cif8oBrktug4lPncrv+HR1E86IRKeeFItD2sr4i9YuAKU1UbUBPcq5J
 bMtaZ5Axgd/DdpzY/LdXeBuIZ7ESxJph4jlgzjpevxi1R0BFxneOsfDXm/q2djyfAjTYokG83Qf
 /dPZkymryGsA8e4Tb+K1matBh9CIFRRiplfpAHItdcdyzLxTLWkOrwNWGE/gNHovqQZTYB/cHXF
 T/VpOzgIn6DcxC5HoHxGX7zr0/+27yA0Bzy9/N7DCn9SCUGczODuZYqljx8Ht04GmxZFW9HLYvU
 BXapr+BUtgs7p05e4jg==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f21a9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=HIFZfxgX9pW5VpyTZ0YA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090037

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

