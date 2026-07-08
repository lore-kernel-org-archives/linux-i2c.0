Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DF73BF66C
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491336; cv=none; b=UC0lTa+xQBotYkUE8WEzqyPInH2zyW6ofXIZRXX/wm8ifiie8yVV31RRYZ/gSK/WYz+hPDQdEwTnuVDbJhZRi8bAh99xt+eAeqhbnlRVmiXEcsPVX5XfO3UhlxXVKynRl9GrevI98+AQdx1Rsye5cy0bt6Srj8h2nwnzlGP0xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491336; c=relaxed/simple;
	bh=AJr4tXEwpWIFZ9uohJ8aIXrS0/0noMhGeGnbh8GMRTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhDCm0dsGkvNA0GAiBCp4MoFbxi/iIEd1uxZoIjqQ30X/EMtWzX0NSnqoMwcoGpk3BL87Pz/WOSel6FF5KLvxqgJ7u0H8xC/gN1sYqbVS7wPB8+ElTkhp/dwLieqIoqScUdJcmSHLAbFbnjVQUWY+3t9kpCTx+sMWF89eLI8nuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QR5hyZKZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WusdPgVq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QR5hyZKZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WusdPgVq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842XV81447584
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 06:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6YqCzIIsJslLxIfUnnI9mEywo1c/jx/Ea+gq4LbmjlI=; b=QR5hyZKZ8l1adJQF
	k+Ge5467h2hok2o2gQV2yCBEqXlYCjXgb0aEodf7qr9mkZ4Z9zCEHzRKpo0FKQ43
	EgMz40f3nKCMjlrEAF8Znegk8OrN4r9FftWjgQwPKyIndgAH/fTVZgug73FLR2Cw
	41QX8HNtQPkqS09ctriJwTUTqxAl/7odZa3eIXiFDtguU1d4nOfWnZZNZ0SYnaWh
	bxQc70dk9o9UiUPDrm+XV2SLHm2TMhDFBq5SwYWqBiVQWMUNWdEW3l0VVwGBb6jr
	YwJihjKxYLCgWazMtKOE6wEG4bn8oOE3SNct6w8lHIyQy6WP+BhmzW+DFZJrtIuf
	E8p6vg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f97u11ybj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 06:15:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c354050c34so6194165ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 23:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491330; x=1784096130; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YqCzIIsJslLxIfUnnI9mEywo1c/jx/Ea+gq4LbmjlI=;
        b=WusdPgVqnczbtCb7nefXIYWF+DJF8tYUMzD5ew+M+k9bne+yn/PH2xgvTadnELy/3o
         tk//lXz63V5kr8dJs0rNydkKxZ0jwBZtGnK8Qo0t6Al55kAwzLISPJsGybMfAy03NRax
         YGDzwxAYQ9hub1eWFYsGZjaf6lCAR44VbrDbXBh+A609L6RclfwS2KV6A+dky1ZjFHRT
         CI8kMWafBIgtno8NPaYZ84kUbSC/Qy50YbqFFsR1w6V+Hv8ZGTqIGHEbXonUt6puqNR2
         oJOxsp7mGLDknjZSU/1+0HFex8wU+0yS2cRJmHTs8F+iFHXjWDuEodqg18VJIAKc1Wgc
         Oc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491330; x=1784096130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YqCzIIsJslLxIfUnnI9mEywo1c/jx/Ea+gq4LbmjlI=;
        b=VLzZ7ZOoiXA+gAVBgr5HFpJfnxdswMb1Cejy8X7smXWKy1HzKKyq2dgYO4gQRjsYK8
         HeGYg7Ph68tqDgQ27bOnmckIDO0YN1zu8E4PG+Tjc3QuatbLMbtKb1momxGYLNLR5xOr
         bfM2Kgw9IPNvw4g+Ici9OE+B5MYnt1+Yd8BMqOqTG4kHYCVCj+aI1W4vSLB/1i+Doq8f
         JblHzJ9ACLfDpq3h5o1yVnHi9FXE/dUdFd9yx7JugyAGHck5VKJdexsmjJHpv7ZzEPB8
         ILpNrJtDCaILNaMSLQoKjz1bwzyYGi7TTD7BH/5cpAwUOC/YTkmqRJrKiBt0BnXNqtsJ
         s01Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqjp6O6BNtEX305M4F9eFkHURXMOFzTJfOnVwae6yTlT60U9IfT3J8zo1HpHFJcY4x4DcoX8ogpVm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/O6zflpNAxepP6vCEN2t3e4+JgzEGXv6QZygyFAyFstjAe+7
	mSR9VOeL3MOdR+RqqoqBWGdHb/jLifJNkFTxGba1JWJcEWAzhJz5E1tr9FygzWNqSK6s+n1uU3V
	3wSLQHjQQBgjS0SG5WMzLPYzQT3TECoQztFIpFbNp5Des4bYg7gJcec7Ag35dRWQS4cvVDss=
X-Gm-Gg: AfdE7cmHQD+UlLW/8IKHITa/4ksyfkRxthLmoAzQkPQYnuu7w9K7jeSNfxg4OJljjca
	9G2Hx/8FiUSV+m7cb1J2rRomAq++gZGci/MZcutSTDkUBdraLfHVeA/d82P6iJTgEJG70OZGJod
	wC/i25x3nRerOOo5957LNCewfeeXOyG+74Ve9Nl4cmRTCqVrjH/1CKyz2mjY7FLzmiBYN3TALU5
	mH3i9zVcdtMq1TsoUeUJD5H4B7j2jscfb1QhRDqtEc9xmiiySpT+IrkL2BcIi9SJt/yuSouF5Pq
	0nGqiugXbadJ4dwB8nWlTrTn4Sb1y7gZysbIgX8pZ7vhBtWkseIfPUI1Uei2ivheEYIMpZXkgrf
	oaRHWC2nEPFLvNJJBeOQiw5wxILECeCEOpqTyfQ+RDNbX
X-Received: by 2002:a17:902:d481:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2ccea4646f0mr12450545ad.26.1783491330236;
        Tue, 07 Jul 2026 23:15:30 -0700 (PDT)
X-Received: by 2002:a17:902:d481:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2ccea4646f0mr12450275ad.26.1783491329644;
        Tue, 07 Jul 2026 23:15:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm23011555ad.4.2026.07.07.23.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:15:29 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:45:21 +0530
Subject: [PATCH 1/3] i2c: qcom-geni: use cancel command before abort on
 transfer timeout
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-1-dd8f841f36a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491323; l=3536;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=AJr4tXEwpWIFZ9uohJ8aIXrS0/0noMhGeGnbh8GMRTU=;
 b=kmFGJ4UFjcSZh/hDd84DbNqU7F2gcgsrHTRsNxHsY0Q1xI+2EUbi2wxOM/lcuCTYfCMIcxlrk
 9NTkSciBF//BSaB7hLGQanrOuyBANI63gnY+TPMNawQSi2IKAm7ikZ9
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: PnSFXs40bi88fLMyVugKxKdiTyXseu0t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfXwUdVh2kSSsQo
 Q+QXD8WdVjIgQUP66v/GvVOvRQ4l1eotF1KwW9xNcmJJbQ0lik0ukQLKqmUtfEbmtYHrCKpUZ33
 qWf4xgUGup0Sx2mib5LNUWBCnGCWj+U=
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a4deb02 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=HIFZfxgX9pW5VpyTZ0YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: PnSFXs40bi88fLMyVugKxKdiTyXseu0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX2256SvDfnYPU
 8o1wWeRidjNBb0mqGIS2lx5TkF+EZXHrT185nzsFBxChoc5q+2dGbzpDjO5XTucQka8HnMZOudt
 Qt74ia/z+gMnhhQRCTVClhyUDEeZrM33t4vomhyMjX38MEsyMxbuBQzoQZDUTDXd/MeFbU5Ldev
 GJ33iskgX4pGngLNdZvbzjA3L9G5qN/RtoBcSD6pQKSNJQVjq+Fkb90DOv9aJV9nCYXwKsjDO1j
 9BQtg8K+1oIGsQlpKdG4MGZaDzTuIWJ1jEv7Z5I6Hv2luswZ+ppFG4X+dPhYEXqFjScNPCtkx/y
 N5dY282WhzPGU66BZSPrIcnjVvfMF6hV4r9IGhxAeKvdy7nXaXxwEOIg72V5vrUxfAkLC5vKCbR
 SR3E+2WbylF7SEYDjIraSKv0+rjJcNcaUb8w8sF9ypusl1ZwVClG/glbvtOgxdKuP06RJh59yAT
 NwbRZDpzH3T7n3MAe6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080056

The GENI I2C driver currently invokes geni_se_abort_m_cmd() directly when
a transfer times out. However, the GENI hardware command cancellation
flow requires a cancel command to be issued first. An abort should only
be used as a fallback when the cancel operation itself fails to complete.

Introduce a dedicated cancel_done completion that is signalled on
M_CMD_CANCEL_EN. The timeout recovery path waits for cancel completion
and escalates to geni_i2c_abort_xfer() only if the cancel command does
not complete within the expected time.

Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
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

