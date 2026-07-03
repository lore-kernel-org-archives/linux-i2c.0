Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3C414DD7
	for <linux-i2c@vger.kernel.org>; Fri,  3 Jul 2026 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091319; cv=none; b=MkfQ3haV/LlY5XnBb4DyiZBnmrQlPsxlUfPAx3kswYOCy8Rbhb+Dfcqe78ajl4QH3LykTEtg06Jiyx0BuZwqDQ1nsz4VY/63Q62mRS5klmqEzgX+Ig8qw49gED3/kUq/yruweZX3x5MMS1ha4SX9ER5KBUSlO7SgccUjI+tqrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091319; c=relaxed/simple;
	bh=SLKzc36ANlrTJ4UXlcsIz09mjFA5+gvF0IFn1cNkn98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oj9RcqdnWS3C4FMWXd+OwWCkbILEwasoPe9+le8OSuPS0pM/v8CQjHWc3yU8Buvx1zfqvzO2N01BqkWI5wgtXnB6jmZBx17nN79DcdhQ3TmTgXM0IsgRITCH6tFvusRPo3Mg62XtFPw2U75MWDpUNr3EwDqPxNrP50mZ7KjN5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPysxJXq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqxXtVR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPysxJXq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqxXtVR3"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BqhF24091014
	for <linux-i2c@vger.kernel.org>; Fri, 3 Jul 2026 15:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=; b=nPysxJXq1ISRuwU9
	P2PC8iBK5waFLilC4+WmGC5SzHiWxW+A9Bm4VK5fhPi0CY7uZ2A+rJasK+Zo2DyI
	O/YOCB7rNMHvCWGFf7GCTA3YbM5ywR0lvSAlDCAfc6iIbGQrvgcct2YsHDvSHT5u
	Bu0fwLZJzPYsr41RjJvTxN4Ahtg92hoqHdNNUAoDNwHh02JKOm5iz5to8wmaKUah
	tq1ASDyN7E7x4+QJJEBuXSLhHNxbZGf4yzoev/WydYbZY5olQiSlMDG4oeoqbu3H
	5BBRt1c8y7ROp1lpFkpYVIy/Hmd1CILkrckidVAYupNXFKPxyqv5Izvek7eboCXZ
	k8r13g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0n7r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 15:08:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-380a0925d7bso1040014a91.2
        for <linux-i2c@vger.kernel.org>; Fri, 03 Jul 2026 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091313; x=1783696113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=;
        b=fqxXtVR3wk2iVwu9WknZ2TEjtbbH5DXKpw2febV+vZE/WkW5TeLVLcFDgn+1RZG/ju
         vf9bhLuvZkYSeHHc/NAONbs/Tevnmcee8uFaALq0dmhRV5yHVJnusCuuvPmvOS0wVCVX
         eZEt5FwSat59XS8VJMmyQqoq+KKZU7yFiAOfj7Oow6LAHuGTDwI0Z1jn/fEmmiOyOeFp
         bAlTvuj69zjspknteOTip3ua5VItKsNu3/X6IACnuSoMYImlntAORbE6I+BTAaeB0CBC
         CrvHponqp5MXAuKrsXRkzzmBLNIw2msKQXOYO1aXRwcl0iPckDBdqw49hIaFnu3iDSn6
         LUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091313; x=1783696113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=;
        b=ASzjqx5ab/fRFtt2rAzulgabyiGqjZ2+Ewjt6hhmNEFs6jYHX5bOO1WY/Defe7JeBE
         0SROuisqWmzVtLrwP1jfy4MCwAoPytObPxaUk031DMQJjiwSOGB9x6dVvFtOiG5jWGRm
         3XGzPf5eOpP05T2O9x+CzuD7gbSvigWFRX8as0RGhQVp2N+dUEvW6UirnwTyoNM06+R2
         OyJzfoz1nv+uW7B/ComrtHTMZIqyVAdXErzn+SlfQ8vJJ4FjtOiZ/czykKODySFa8mEr
         CAzlfruYp9O+NF61IEKpvPrvZcl7Rj06KDJhAz5gi/ecqAsyOrOz7fQ40llEunVvogG4
         CT2g==
X-Forwarded-Encrypted: i=1; AHgh+Rqjm4sRrhqSk2G5MLcHL9RNfKYAWhteoq/m9+VgY4WhEzrcwtbwoDnoZZVs7YcWqQ87kJJNJEkKnnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPTx0NJ77oAIrbzg+vC3mJzIzjMxznqrLeHFF0Z1Y0MWA3FgQ
	7jrvuNgPHZ2fbYHr0oRRrjkaEIZStGiNcOFtE57M2KpzpMuK2/RDI/yrEQywsklhBo9oib31njv
	mEH4RnU4lckXRT8N7vgbAXD4x+9O/23zrAopafSWEBaeBr2eg/3DZ2NfuEz5+16Y=
X-Gm-Gg: AfdE7cnZNZ00rYGvWEm1merCx0eRXDyB68koU1yZv3kP50c9JKM62JnhhzSh3I6oCy9
	iirH64GlWOubuSW61DRNfbMyYCm1muM2ewKWtdFQB98w1zrEEG+ck3r0BHuF6aqWRHQP1Kp6aRa
	Equ5DNo+h+xcBDLUMhe5uLaec9iDPPbokE+Qn8+DJMnD5o1ba5yd+AgBvUL6rDbZoPHNakcbA1Z
	aM6SSecKdzmxd63tF6hqEYfizYMIUiKxlWnv8aKcfD1vF3sCymNQ6LiygpjPUg6wWHF2gfT4ndY
	Ku3GmwPeUxmRLuZRqyh76TOpsB4pr0kOUclSNipRRY+EAhwX8lssxdHIJwgHMBLuEUVukhqJD+Q
	XFnZG5Y84UxCMjoYZyAdc7b1LWLp6cAvNieADw1VrzFNO
X-Received: by 2002:a17:90b:4c07:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-380aa098483mr11495585a91.3.1783091312882;
        Fri, 03 Jul 2026 08:08:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4c07:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-380aa098483mr11495518a91.3.1783091312156;
        Fri, 03 Jul 2026 08:08:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:31 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:38:10 +0530
Subject: [PATCH v2 2/2] i2c: qcom-geni: Add trace events for Qualcomm GENI
 I2C driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-2-e8bf8b178290@oss.qualcomm.com>
References: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
In-Reply-To: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=2744;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=SLKzc36ANlrTJ4UXlcsIz09mjFA5+gvF0IFn1cNkn98=;
 b=BbTVYqz5bGt9wh4r4Hh2lALYtRHB9DlCQjB3Kn9E6j0DgfJLpHUnGcX4xVbKeyo0TT1r2Rh2p
 I8ATEYBIqkjBldCmObXaMUJOR3nHbQoRwIKWiId5ygTGWHIYb4r3M0D
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX9LDeaskFIayt
 fEXR8iqIwFvSCdjLEmk/Gr7em5nEKj1Ne6jPM4ypZA9/BiqoMX/0OqdgMKRmvLJyTaJRi4XLDGX
 7URXXjLoD/DeapdakFpsfj4xAtn0+1k=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47d071 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0MkepCNd34v6RWspawgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: jS4HUOIk0C0feh3jpgF7kNc5LxGsn6k_
X-Proofpoint-GUID: jS4HUOIk0C0feh3jpgF7kNc5LxGsn6k_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX+sYdvjmY/R9Y
 i2IUbt+Gg0Zkh2c1v11cou6KRWSPFdGlH5sQblYWkvMwTJk5dnItrHg4UdrhLRFNIbtXb9cX9Hz
 WOcZ73fomTzwQ1mzdpVytKzOKn866A0I77tFOdl9zOzxjDvedwM/EPXBh5fxc6Pdf6cTe/uMliW
 FsWGrkTyNvTOrMnDUv6/Mf93QZYOGBMg/XZuBQB6M+IKZv6/D6/NiJzUL6ekGSMzkxVNbC+CLIM
 ZAloveIW3CqoBPLg/+iD3y9YZaGgV1ti+gFNvGcg6LCcNyEeuTU9ZmZCPboNjSG9Bg1whjsZMd3
 69yzYcwA9FyxekCH2U0Z2vzStlCWpPxX0RwrmWbJPAxB2+d5rc/Z5PQZ8eyoA59dW6Ap4d8VAhu
 KrcAUkM4Q7iWUjfgrXm+0YJ16fF4Ld8U8ZLHvakP80u/RWuuJDskEcgbXPAZFvWTpchCfEeKgBT
 ZwuDRR6ipZDeKKr4PAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030150

Add trace event definitions for the Qualcomm GENI (Generic Interface)
I2C driver. These trace events enable runtime debugging and performance
analysis of I2C operations.

The trace events capture I2C clock configuration, interrupt status and
error code and message.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..3227fab6d76e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_i2c.h>
+
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
@@ -219,6 +222,9 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
+				 itr->clk_div, itr->t_high_cnt,
+				 itr->t_low_cnt, itr->t_cycle_cnt);
 	return 0;
 }
 
@@ -252,6 +258,8 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 		dev_dbg(gi2c->se.dev, "len:%d, slv-addr:0x%x, RD/WR:%d\n",
 			gi2c->cur->len, gi2c->cur->addr, gi2c->cur->flags);
 
+	trace_geni_i2c_err(gi2c->se.dev, gi2c_log[err].err, gi2c_log[err].msg);
+
 	switch (err) {
 	case GENI_ABORT_DONE:
 		gi2c->abort_done = true;
@@ -288,6 +296,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	dma = readl_relaxed(base + SE_GENI_DMA_MODE_EN);
 	cur = gi2c->cur;
 
+	trace_geni_i2c_irq(gi2c->se.dev, m_stat, rx_st, dm_tx_st, dm_rx_st);
+
 	if (!cur ||
 	    m_stat & (M_CMD_FAILURE_EN | M_CMD_ABORT_EN) ||
 	    dm_rx_st & (DM_I2C_CB_ERR)) {
@@ -788,6 +798,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	peripheral.set_config = 1;
 	peripheral.multi_msg = false;
 
+	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
+				 itr->clk_div, itr->t_high_cnt,
+				 itr->t_low_cnt, itr->t_cycle_cnt);
+
 	gi2c->num_msgs = num;
 	gi2c->is_tx_multi_desc_xfer = false;
 
@@ -895,6 +909,7 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
 		gi2c->cur = &msgs[i];
+
 		if (msgs[i].flags & I2C_M_RD)
 			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
 		else

-- 
2.34.1

