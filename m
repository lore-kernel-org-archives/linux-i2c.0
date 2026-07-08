Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86493C2782
	for <linux-i2c@vger.kernel.org>; Wed,  8 Jul 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783491342; cv=none; b=eWPpSrqRxR2Ic9WjRcIzNpMpcTcVQS8P4uqrE3Apu/Zb5P+nrQroIAs2RE+tzib3r7X3tUwb1kwKDrLRASUsalxtiBGknleo4w9Jps2q1PI5jeP3emfjNlK+B05G9/NnxDIuXxjSEr/bOsn8OUAJRBP+VGla4oDIvZ62iEW6hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783491342; c=relaxed/simple;
	bh=p8bexT1dnYfA28Dx6f/K9t0rSOHXSXRTJvrhxTIDEOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fj1egR8OI+rTnK8IfJ6sAeRPGSL+H9nL2VHhzi+Or3F1qLgyL6Z25Z2fS3Pd6vrGOyt6SfrGPPwpgrwbXwuKbpa/m3hF9T1UQtSsUMtJFHu/P2bI+uYsss+rok/7yuxd93hQ1pAfWMWWUZU0hLHK57Qfxr1gluVove+P/m29ZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+3WaYRH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dojzAC2P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+3WaYRH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dojzAC2P"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842lHo1625560
	for <linux-i2c@vger.kernel.org>; Wed, 8 Jul 2026 06:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8Z9XwdwNPnvmUsig+q9KX5vhhyT/MzJuWsROOPCiqZc=; b=C+3WaYRHQmBp9taQ
	CAQjb+pOX1N06/4TubNStppSzYWBprUIKNB5Hv4bFUDm+Pv4J2EJEb/bn4e/uDYS
	pBpxf7CUlAvTRV2oLpMf54foWKxVMHeYGY4ONkEWduvmc0TKQ4c+VevLdXEyUiz7
	GXOfIkjRNn9pjON+vdrVKBJA63Cm/CMmm1XFuw8GJ/JrHt4tznjXMt/DoHkCyFib
	K7jdCnjjF4TCVp/ER9+yFuzD8fh+Cqi2Mg2jOEJCpREqWIwC0U6FoCxW430/nQ08
	rldYLVpmtZ9bLjc5lbDxFoQoQj12Dm8tgzVVrHKukKtlErXGkBD4qsmBbV2d4gHS
	VPM0Wg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd2yjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 06:15:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccbb61893fso10630985ad.0
        for <linux-i2c@vger.kernel.org>; Tue, 07 Jul 2026 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783491337; x=1784096137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Z9XwdwNPnvmUsig+q9KX5vhhyT/MzJuWsROOPCiqZc=;
        b=dojzAC2PJfBmPNNZFESjc4gB2RD2sWRD1RY4NsoNBPQO7CX8czOMsG4ldNc3yMf/UZ
         hjshOlnr7rVgHYWe2eRj7y3YUBGHqVNMjhWzXlokIMWIgRor9cv3uSQTQJpokgtUCAfO
         rs3tAqvE9TfqY9935hNrn2vRmAx7Bgl5nmbcab0ZJbNu8IyGGkyR92+dZqrSj1HZ/rxg
         XlGvg5jkaHHT8sXEsXtUm0bfFXgP4NryyEuOmaWXFT7X8PMVTB+p7y8NDfdZkM/R1zGQ
         KLN6KA7JlNtf65EQFfQATE2z0J8Nz8f7SyeEXmYlWqpAgpWPoztKMIGECQJh1UEyuKML
         qRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783491337; x=1784096137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Z9XwdwNPnvmUsig+q9KX5vhhyT/MzJuWsROOPCiqZc=;
        b=phaG4MhILSUhJ6Nir3Quqm22K1r5jQuxM0uJBI0XJLT2Cx0PErsrVKO5o1WHZSfSBs
         h/iDvTU9qVdtMWlRaHVhqALrutr+iCGLN7j645dgu/jNh0fr+mVapXOodCWvyp2Wf1kR
         f2VAsb9m+FPOdMxR/2aN3oy7gUJ22ubGitWIeiH8dTFgKhyh7u+tvdX7ucwQpT2lrI4+
         t4P6L7TgrKr3i5bSBlT0fREqZ4dVCGqyAU3T3JpB5Xx7iAGjZEMyVGZ9m9uuzh6GOaqT
         GHF3lF1ZVcLUe53KXNvTF0uJQciDxPDAhE2Jznz3tg7L+8ObHkGnuA4clWdinV/jFOey
         fo0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoeKzbiwac6J9M8Ptd4yPqHoQ5bjtGWKK3nI6PH8D/LBTGz2CNwySZO/PhnKJzi/b9+Qg2FNm5Qraw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+yNub7qXDCDnfOJfd5Ubt2nUk60ZOnmWs3ZyGDKYOKZq+YRB
	PUxodp7OTCgdTdOXgB5lyuJ2CoFssyA0zn2yp0xuEzBYHuiefiRZSl5Lyq7BdtoMvKvaBSwAVQK
	LtqMJN+yiiG8XtgkKRvekAPOpUubpjUMEEY8I9eKXnanohmol6WPO04L7cTGLcgJRbcYC0wg=
X-Gm-Gg: AfdE7ckStp+ukTRNeaZdORZMgRksOtaUVnjg1k++2GIHzWxNqHZc6Jxq+7rhujEIXjb
	4hVivulMInKuMrnASMzAUq2qVnj+4ib7mG2mTDXOEvivioTJrTQzy9QstlTP94bu6DMaUDH8vcU
	/u+lOuuvd1E4N/kcOzUE8AGdQBNGT2NZEyZB3P3ZWfrxYmFKtv1zQ+uVShXMCeKqGyUzr38GJa6
	dMuZl4hkU2HNEpbV3+N/ZgwtCLAIiymA+bK4qJOB+bLoonio0KRB8yHKNYKPRkwoTeVS3MLa3Gf
	GtSXxbBG37RAo/Er+4af4TpssHEqsRpvgcvir3hySPMjP2AOec/PRtPibo1bjSjGTsueHsObg/j
	18aP1lyTpeQicNq5ZLAQvAnLwLF1r1besCfyfabTObq+f
X-Received: by 2002:a17:902:ec90:b0:2ca:bad4:33a2 with SMTP id d9443c01a7336-2ccea3a28dbmr12187915ad.11.1783491336884;
        Tue, 07 Jul 2026 23:15:36 -0700 (PDT)
X-Received: by 2002:a17:902:ec90:b0:2ca:bad4:33a2 with SMTP id d9443c01a7336-2ccea3a28dbmr12187485ad.11.1783491336206;
        Tue, 07 Jul 2026 23:15:36 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb9bbsm23011555ad.4.2026.07.07.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 23:15:35 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 11:45:23 +0530
Subject: [PATCH 3/3] i2c: qcom-geni: Avoid unnecessary transfer cancel on
 address NACK
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fix_cancel_sequence_on_failure_for_i2c-v1-3-dd8f841f36a2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783491323; l=3863;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=p8bexT1dnYfA28Dx6f/K9t0rSOHXSXRTJvrhxTIDEOA=;
 b=+FpuMKkxvy4k7ZJowgcdrGDby/96nq59laWEXTUYTugA8Jz0pGVc/3Mrjs9p/oOotvSKHuWl1
 Eoe74ThWQiNCm8pWHDJ6yIchRun3j+2PYkv2TQtqyFPVAkZtt7kIlDm
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX+uOpjGOvfB5Q
 h9yDLbVIJxL/Dvp+ccc2IC5HrcFazgmgfs6HEg0+m3m9Ixgi7jFev1F6o0ELPLqBpAKw9Gp4KPQ
 +Ek9ra4d+3fUZiKfauhpDif+uix1V792v9XzAR84faHU5HW4OBU8WsIY1FWiXU1PQv9ItNH+dTw
 FloClEFGmKgEohbZ2gcVkxxkHXm9mo7tiRRJDoJZAgOKMA7z/3B68op0ffL5iIdL62KXr4DBlQp
 jjuXcNTN6Zab0lQl33GZplJpWfR+HguHZytuwNUAl0TLK95uOOluzfsONzJQcYCjPRhq8hJj6Qv
 0RHyDYUzjY38hat22w5FoqHmSnQwkdevrSqUXsYzmkzTjCiViQ8kN5UdwI42Iicmk7UsMBhEr3C
 2MHgxNvxaK9S+BxELvCl2enNlFwgsB77oH2dEyDyj8myo7j6HJQkfhdDUXRNJxztjLNx69Wp0uR
 p0pTU12DlvKW9ixKJvA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4deb09 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9WHUdGnV1KnJ8Vak2loA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: hunY-Mh_YFHamYZnlsB29SxNKqeIBGcr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA1NiBTYWx0ZWRfX79foJMhrb8Jt
 77Wb45WCanADJupXW87JNF/GPqg3ySzo6I57TzTjkQkV9UnPUawnkGjBFDSSL8sRImeU4jyjkLb
 1waNwWpfxd6UXMv2z7NjdA+VnSA5iV0=
X-Proofpoint-GUID: hunY-Mh_YFHamYZnlsB29SxNKqeIBGcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080056

When a target does not acknowledge its address phase, the GENI hardware
raises a NACK interrupt. In this case, SE_GENI_M_GP_LENGTH remains zero,
indicating that no data phase has started and the transfer was aborted at
the address stage.

The driver currently treats all transfer errors similarly and always
issues geni_i2c_cancel_xfer() followed by TX/RX FSM resets for DMA
transfers. For address NACKs, the transfer has already terminated in
hardware and issuing an additional cancel/reset sequence is unnecessary.

Track address NACKs separately by checking the transfer progress length
when a NACK interrupt is reported. Skip the transfer cancel operation and
DMA FSM reset paths when the NACK occurred during the address phase.

This avoids redundant cancel/reset operations for a normal address NACK
condition while preserving the existing error recovery flow for all other
transfer failures.

Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9490aee4928c..0448654f2678 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -130,6 +130,7 @@ struct geni_i2c_dev {
 	struct dma_chan *rx_c;
 	bool no_dma;
 	bool gpi_mode;
+	bool addr_nack;
 	bool is_tx_multi_desc_xfer;
 	u32 num_msgs;
 	struct geni_i2c_gpi_multi_desc_xfer i2c_multi_desc_config;
@@ -293,8 +294,12 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	if (!cur ||
 	    m_stat & (M_CMD_FAILURE_EN | M_CMD_ABORT_EN) ||
 	    dm_rx_st & (DM_I2C_CB_ERR)) {
-		if (m_stat & M_GP_IRQ_1_EN)
+		if (m_stat & M_GP_IRQ_1_EN) {
 			geni_i2c_err(gi2c, NACK);
+			val = readl_relaxed(base + SE_GENI_M_GP_LENGTH);
+			if (!val)
+				gi2c->addr_nack = true;
+		}
 		if (m_stat & M_GP_IRQ_3_EN)
 			geni_i2c_err(gi2c, BUS_PROTO);
 		if (m_stat & M_GP_IRQ_4_EN)
@@ -443,7 +448,7 @@ static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c,
 {
 	gi2c->cur_rd = 0;
 	if (gi2c->dma_buf) {
-		if (gi2c->err)
+		if (gi2c->err && !gi2c->addr_nack)
 			geni_i2c_rx_fsm_rst(gi2c);
 		geni_se_rx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
@@ -455,7 +460,7 @@ static void geni_i2c_tx_msg_cleanup(struct geni_i2c_dev *gi2c,
 {
 	gi2c->cur_wr = 0;
 	if (gi2c->dma_buf) {
-		if (gi2c->err)
+		if (gi2c->err && !gi2c->addr_nack)
 			geni_i2c_tx_fsm_rst(gi2c);
 		geni_se_tx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
@@ -493,7 +498,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-	if (!time_left)
+	if (!time_left || (gi2c->err && !gi2c->addr_nack))
 		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_rx_msg_cleanup(gi2c, cur);
@@ -535,7 +540,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-	if (!time_left)
+	if (!time_left || (gi2c->err && !gi2c->addr_nack))
 		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_tx_msg_cleanup(gi2c, cur);
@@ -917,6 +922,7 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
 		gi2c->cur = &msgs[i];
+		gi2c->addr_nack = false;
 		gi2c->err = 0;
 		reinit_completion(&gi2c->done);
 		if (msgs[i].flags & I2C_M_RD)

-- 
2.34.1

