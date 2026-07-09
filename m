Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69E396D19
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783570866; cv=none; b=lyS+oiMHlpVlacDwHQdz2c1KZB/ZG5WJ6KPNOWVQOzNZ/e3xFOYkuQjhZeWzusSUKrVkyy70o2708x9/lygXGESSvls5podePJu/koqTpYhliiIgpbg/FzEWfsvNQ8iSXbdsqbuAPtoZ/8T7j9vVyMD1U6p5dUjwEJztEbd112o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783570866; c=relaxed/simple;
	bh=x/+r0WCxXhtvsxLk0MJfIGA9DJGnCC94KwQw1Pqe8RE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4NSHT0ao4X3lQ5HvXdUDHlnMoOR/kLoID0stblX64Ylqk/03r2UFBSyM7l+Qgj+ypg3eQWotTh73zM2Q5WQjxwTKghPUsSoaCKZ9Jb7ZmzbOedvIh1jZ7NRKzNDK3LiEJDM0OQx9Loldz1eX+iQUut8wS4i9JiKgPNuY4NrMlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ETWhkHh/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=khLjsrV5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ETWhkHh/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="khLjsrV5"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N8cwT4142601
	for <linux-i2c@vger.kernel.org>; Thu, 9 Jul 2026 04:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qdxbWtKb1vLZTfYD2ty+3H1szGedPOtaWbhOclXrueQ=; b=ETWhkHh/zslQr61a
	vNwiAk4RxaPhhieDbVwzKuxyF50idQ2B+hZqj1ZJMGiS/WpCh7EovF7VVNKCZwVb
	FlCjdKOTfENW0ynXfoqjF5BXBZVbxKhGDtMOcB1uve2/MOQqagPNd57DFSa1190R
	Q4RNopiTVKK6qHVrrW7GNikVkYIE/7e3/HUU2h+I4IPdcBJmuQYJlyKXcMp2c2zL
	WxOV6AuY8B5luBNKXFlwapLUGkFu8lq2EDy4uYFT3C1CTrN571nu0tacpQ+kevVz
	nLXuYWbvXjTIxQ/hoTa1Q0+0QwLwCmSm3IvS5MrUmHF+0qPA5n/pW9XAZBdObW+A
	SPkIBQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwa9kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 09 Jul 2026 04:21:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c891ed872ddso2487644a12.2
        for <linux-i2c@vger.kernel.org>; Wed, 08 Jul 2026 21:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783570863; x=1784175663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qdxbWtKb1vLZTfYD2ty+3H1szGedPOtaWbhOclXrueQ=;
        b=khLjsrV5SFGrr9qzuit/BsX+ShB+4rq52xYvkkxU5mm8E+iyMbnZHQiWu1OIHUjlkn
         aTD+Cu3z8pj/VQHW6jfOhsD3tGSsItw4auv1NcIpwdK2rhNjvpxeBgYxYQq77RnBQWC1
         dElo94yyNoHi6ZLA6Ze8iKKLtHMhWGMsL3ZQB3TkvJBxuW9F2HKMiQTtLnVxuibwi0ON
         Fce5gZEHz/rryAGHWUX5ZJEhhlyE9Hui46km2pM98Du64cx76bWGZ9+hcf4RRD0RbkW0
         REEbxajG/A/Qw7UuZNF/U45fmZnL8yt71OkoJEXKFut56IHKlfrCphOR16fhfH1rd48x
         AjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783570863; x=1784175663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qdxbWtKb1vLZTfYD2ty+3H1szGedPOtaWbhOclXrueQ=;
        b=EFT9Eeq0rCkUjR8xAMVqNBxb3C/LTmx2YQYpcvVDHY2y9Ow/3faS0YIPdKkkD8DkuT
         ADVEPcYU5Gap2S7mfrrK4TI0pHJcpOJlNo4tdM0q6t4wguQE7JrWsufZwwoZBlEPki+4
         iT+5c0Uw2kp4U4w5EI+RMiWntacQLHmi46HcXqdNp0B9OjH6qPJun/UQbBnZA4scarr9
         ceCnjDVdXAOWz8UeLMlCdBBnrF0xHyIlnI7qyPp8ceatGxAcP2uJois7FCytGO+Pw6ex
         pevh71O1rHWmCBwikUQoPF9hiIeRKfdyqYlJmBkjlKYHtDqN+Xg3itIpcWAq1+lWe4ql
         ND5w==
X-Forwarded-Encrypted: i=1; AHgh+Rrf5aEWcczQDvizsmvcZi1r0mMIKLc/WdRteJzWM+Mj2d1KshZm79krBr+C7iWkHupx2ybVt/KUd5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YcKbG7euYvTNDpd4bqE8UCIocxf9cuM8k7ubdH+G9mc2MUEe
	Pf056nTUWb3df07yJ45mGeUB4bbXAjGQ1Z5+b7UMILAPvMcaJJk1bpQHIAZsJMvZj0MgB79xhVy
	Wc9Lhqpl8jIlVuITULAltzNhEIPc9hfJYiCaXDM/MofO0TXQ8Vj2LTS8rNWGVSJsm9G+obs8=
X-Gm-Gg: AfdE7ckZUiB8gNU342vbKsGWHCiq02XrHJRt9GZroVhwXhuLAkEBUMeDR/W+I/IV6IK
	HGvhKqC6usMWWwS+WiXWhJZestfBE37oFJ64MmmwUCudAsW5LRDQ+UYeLq+8HK3a8ExPg79I+vd
	+R9ZSTK2+mmuJUXx814V/SlFn0NhmHRNObATkgSZ9YGLC3yG0IQOjUIVKlwmPI6vMWQGnklDHXS
	aKxjEr5GzrB0WI25G1O6VtFwpVtRtZa5v31xlZLfRtPWR0htgHSJ7gkSlP+UwhnQm3m1QC5UJGz
	WA8Qo83O6mOWbFG+A/PvCpsqBPIha4iqmr5auiSx1fkZmtJlsGhjurCvBAMHUktvooKGDLd1x6G
	cmeO03YjzsUag9sgewC5kfPzvRlES+56KhVWlPF23nxC3
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3c0bcbc1353mr6751622637.37.1783570863206;
        Wed, 08 Jul 2026 21:21:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id adf61e73a8af0-3c0bcbc1353mr6751582637.37.1783570862650;
        Wed, 08 Jul 2026 21:21:02 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm25490098eec.2.2026.07.08.21.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:21:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 09:50:42 +0530
Subject: [PATCH v2 3/3] i2c: qcom-geni: distinguish address-phase and
 data-phase NACK
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix_cancel_sequence_on_failure_for_i2c-v2-3-1db178c695bb@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783570849; l=4782;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=x/+r0WCxXhtvsxLk0MJfIGA9DJGnCC94KwQw1Pqe8RE=;
 b=Oo938cWNx5pvZgK8W1p87S7pXAl/lGcTpZBp5riU+IBimPSduPLPbIKl6d96vZI0q6OIHZLFn
 n/FfwrpDK15A3965ibUOSic2+UnKGOFGY92ZRIFjyxgSkdykzMWDS3n
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX38m+ehh8JmMo
 lT9yucZuVGDaTUWwQZaBy6dFgMVfDu8PAmWNPkk1MktlgEnmJKxHsBBW8o3nuonHgoX0CviFmvZ
 BVGKhqaL63velg4YHXe3zKtf+WzEopuczPQylbJ5pDdfJ5PRKgG4+fXZxeRAyl+T+RgQHqJJ7tO
 sww+em3JCH9XMInemp28sK01QvcHI1H8X8AvbvBSoXrp+EpW/E1LUVsDg8zjmFjRfbsVdy7Ljrj
 1EZGilNiwqCeXF/Qxgu0JU7DEQLjK2mVI4Oc8apqEI/60OA4P8grtyATSFSoD65jfduPBQ0rCiy
 8xb9CF5DS+fkgZvZINpPHhmib2zGMbiFxSZYLR7nbpwFMFGA+A9CMcY4RxAkttkI1TcsjWWeEwb
 fzWW9tn15P1wWuOO0N4pSDAMc8A+q6k0bkBLOnqRj1t9BDmGPtbolH5mElVg1gYLRB9lE6gaiS0
 xbhFCkj1m5tPrnYU2bA==
X-Proofpoint-GUID: uJMB9nnYmeA_19ILUk-DCAbfH3xiVv5e
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f21b0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=wcK_sNrN2goZDBkbqrQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: uJMB9nnYmeA_19ILUk-DCAbfH3xiVv5e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAzNyBTYWx0ZWRfX8caG6nmXcSVg
 bkimR/q7D56NTatNtXABuxeyLjUf2bwcxCciM3umPnJqKLukTMw0IUnWSuk+EOJI7U7xuSDidb9
 /vSWw4zowe7g4qdEq/PJQQTkhan/UQ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090037

The M_GP_IRQ_1 interrupt signals a NACK condition, but does not
distinguish whether it occurred during the address phase or the data
phase.  The driver always attempted cancel and DMA FSM reset on any
NACK, which is incorrect for an address NACK since the DMA engine was
never armed and the hardware requires no recovery.

Add geni_i2c_check_addr_data_nack() to distinguish the two cases by
reading SE_GENI_M_GP_LENGTH after the NACK event.  A zero value means
the address phase was NACKed (ADDR_NACK) and no DMA recovery is needed.
A non-zero value on a write transfer means a data byte was NACKed
(DATA_NACK) and the normal cancel and DMA FSM reset path must run.

Co-developed-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Naresh Maramaina <naresh.maramaina@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9490aee4928c..b1cd027b5ff2 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -56,7 +56,8 @@
 
 enum geni_i2c_err_code {
 	GP_IRQ0,
-	NACK,
+	ADDR_NACK,
+	DATA_NACK,
 	GP_IRQ2,
 	BUS_PROTO,
 	ARB_LOST,
@@ -67,7 +68,7 @@ enum geni_i2c_err_code {
 	GENI_TIMEOUT,
 };
 
-#define DM_I2C_CB_ERR		((BIT(NACK) | BIT(BUS_PROTO) | BIT(ARB_LOST)) \
+#define DM_I2C_CB_ERR		((BIT(ADDR_NACK) | BIT(BUS_PROTO) | BIT(ARB_LOST)) \
 									<< 5)
 
 #define I2C_AUTO_SUSPEND_DELAY	250
@@ -143,7 +144,8 @@ struct geni_i2c_err_log {
 
 static const struct geni_i2c_err_log gi2c_log[] = {
 	[GP_IRQ0] = {-EIO, "Unknown I2C err GP_IRQ0"},
-	[NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},
+	[ADDR_NACK] = {-ENXIO, "NACK: slv unresponsive, check its power/reset-ln"},
+	[DATA_NACK] = {-EIO, "Data NACK: device NACK before end of TX"},
 	[GP_IRQ2] = {-EIO, "Unknown I2C err GP IRQ2"},
 	[BUS_PROTO] = {-EPROTO, "Bus proto err, noisy/unexpected start/stop"},
 	[ARB_LOST] = {-EAGAIN, "Bus arbitration lost, clock line undriveable"},
@@ -258,7 +260,8 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 
 	switch (err) {
 	case GENI_ABORT_DONE:
-	case NACK:
+	case ADDR_NACK:
+	case DATA_NACK:
 	case GENI_TIMEOUT:
 		dev_dbg(gi2c->se.dev, "%s\n", gi2c_log[err].msg);
 		break;
@@ -269,6 +272,14 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 	}
 }
 
+static void geni_i2c_check_addr_data_nack(struct geni_i2c_dev *gi2c)
+{
+	if (!readl_relaxed(gi2c->se.base + SE_GENI_M_GP_LENGTH))
+		geni_i2c_err(gi2c, ADDR_NACK);
+	else if (!(gi2c->cur->flags & I2C_M_RD))
+		geni_i2c_err(gi2c, DATA_NACK);
+}
+
 static irqreturn_t geni_i2c_irq(int irq, void *dev)
 {
 	struct geni_i2c_dev *gi2c = dev;
@@ -294,7 +305,7 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	    m_stat & (M_CMD_FAILURE_EN | M_CMD_ABORT_EN) ||
 	    dm_rx_st & (DM_I2C_CB_ERR)) {
 		if (m_stat & M_GP_IRQ_1_EN)
-			geni_i2c_err(gi2c, NACK);
+			geni_i2c_check_addr_data_nack(gi2c);
 		if (m_stat & M_GP_IRQ_3_EN)
 			geni_i2c_err(gi2c, BUS_PROTO);
 		if (m_stat & M_GP_IRQ_4_EN)
@@ -443,7 +454,7 @@ static void geni_i2c_rx_msg_cleanup(struct geni_i2c_dev *gi2c,
 {
 	gi2c->cur_rd = 0;
 	if (gi2c->dma_buf) {
-		if (gi2c->err)
+		if (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err)
 			geni_i2c_rx_fsm_rst(gi2c);
 		geni_se_rx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
@@ -455,7 +466,7 @@ static void geni_i2c_tx_msg_cleanup(struct geni_i2c_dev *gi2c,
 {
 	gi2c->cur_wr = 0;
 	if (gi2c->dma_buf) {
-		if (gi2c->err)
+		if (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err)
 			geni_i2c_tx_fsm_rst(gi2c);
 		geni_se_tx_dma_unprep(&gi2c->se, gi2c->dma_addr, gi2c->xfer_len);
 		i2c_put_dma_safe_msg_buf(gi2c->dma_buf, cur, !gi2c->err);
@@ -493,7 +504,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-	if (!time_left)
+	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_rx_msg_cleanup(gi2c, cur);
@@ -535,7 +546,7 @@ static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
 
 	cur = gi2c->cur;
 	time_left = wait_for_completion_timeout(&gi2c->done, XFER_TIMEOUT);
-	if (!time_left)
+	if (!time_left || (gi2c->err && gi2c->err != gi2c_log[ADDR_NACK].err))
 		geni_i2c_cancel_xfer(gi2c);
 
 	geni_i2c_tx_msg_cleanup(gi2c, cur);

-- 
2.34.1

