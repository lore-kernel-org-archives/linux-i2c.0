Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3034C28CF5F
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799396; cv=none; b=Rp4Qe0D6vO1gXiApI+p6ePHbLeZcpz5y11MJtFtsWp6HvMalI+S/UXkJjTtl7rGvCA026tZwRyCs1+VhmwcEB0SUIS99ZiyNW3raEkGcNXax0sZsJa1Q0Ur8ui13eyNjsV0KOWGEIfn+c7pL/P9lFEqCq1YajBHNQOUEGXoLTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799396; c=relaxed/simple;
	bh=IBRzc0iiDr752RyZmlrhOmlck4XRVCM5D9K2KWosX6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUfHBURiiPZk/T5CDOlbnDL20qx1aVF7yWqvYsc6cUwz4wvujgYbwwdc+b6Sng6sgUS2F8nf7Wg63nwbBD+ifUNwvrOzmqJXL8viTqfvwRxpfClUWtpJy9MNEGi8wpurB4SkkfMswKRDW86qBUDFMH3UaZYWaww+qEaCQ41bDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eAIDybuO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGbrmv/M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eAIDybuO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGbrmv/M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5cccf1019910
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=; b=eAIDybuO0PlFE4OQ
	+bURNWG5cxgvKNIeEka15ZEQEOvOvSfqh3y+uo1Ps+saXwmCcMIb797E3ONEmX/z
	Sgvcm2UMYg7G2C2jB+nNPuogTwBzmBLk1Z7fKsMmmWKbbJEBRwZLvqM+ALSnqeXX
	6g0ejkSB3LrHT+NOW1kScBtkMydkrgGbjmoFzddH5hsTn6+ukycR3+wyob6VBuyf
	qdh4bpY+VsjwMibuEM0jXcQS0+TCFE3//j+XwfXp7G+JUh/8vocBfYVjVxnAh3W2
	GQahPOrbNZ7kGDGhTM4ydu//v55Ml848D3UkZtwLg3ULCu9SujXVcLJ9LTohpdh5
	2adiPg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gruk0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 30 Jun 2026 06:03:14 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so1219911b3a.1
        for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782799394; x=1783404194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=;
        b=fGbrmv/MRQQYe/y/BoTA3kzXAyNMJ7b+Cx86lSH7psSaVrgyAa+VWWHT06G4TLTw6z
         ugAoPXSqQoPQX8xQiC2hTDgROZl0TY4mBfTXNQ2XZWZt+dTLQbagojcbvesGUXNEY7BF
         sltILnda8h9UKyOyoXRNZw4NQPGfBJfhGeorpW5kYlwlrpZBNzQtyX0075pSK2mCtxiJ
         oz2QHYuUJ9lnftjWElu3CNVnBpWWXUwq18DITvQabnQw/VfhOAzcheTt0gBLkUmqEcGd
         SSDRxQYQ/D5KhVnztA8dPSNKSFGQYkfrWZ6rmjZWSdKHO/N2sOg3+mBLF2ZaGZ9Z/93D
         9nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799394; x=1783404194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=;
        b=ByJLxI79Tk9rIbtUeQ2lu0KWL4QxTmvJsFTqdzhpW5yEl5sgz00Zg/BO6annxFzBY7
         Y4ESxZhXk8fiFjmy52Gqe10gsY6FwTGDibJUMy5zFstkyJkg2VuMS3eKnLvTLY21hMAh
         pwU757YoohJgXCvdhytF9exWNZ2VT2mPgVeO/36gMC0k2tI5mklZDCPAWvFju/fArkbJ
         /PZAsieSSvduVoxdJf7Aznmgs5GArHgh6QXuJ0zdDUb13DfgFyvwfrcOmU4bF/gDJIgA
         Sdewguw/fYHVkCdZnJCgRWM9sfx7wmkZk+sP5+J4BH7bl3fiHqStAyGpfdMp3ecZn8HH
         AWfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvPU3W61DwpfKZiJlgq+CtegdmX0YMwRZkXX/nYNpV30ku/IqwigclatwmAvxkf1gbJMDtiEGwlr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAEecDu+E51KE06TrF499LKAPtGq5jgmUCJQ3QpqmonpWF7Wp
	ffhlp1x+pw92FlV6ZZYBmJPsIqgA50sObSXl6WDUJ/Ndnc1Nqhgeibw42qHJ9L4VA+tR00FNwEF
	cSZOV5AOg2c/RJEV1W8wSzT8RvvZ5SgboDNZsYhVIK2XzGiSFkvQ44r6ZFKL2At4=
X-Gm-Gg: AfdE7cmZ4Yxo4ggI5eHLAPrZd2TwKQHVqoD6/1Qb/izpNw7JRSMM7Gw4kvffgeYOx/K
	OrBzXv+jHb23HrHGKvmNAypA/wpDAI2p2q3FE3lVlXlzVVYuyJvW4KLV7wf1l/30atoTt4olQJL
	KDwMgRpwe48wp9xSHyVKI8UxaDQDvJPtm8w8O52s2mzKvGxWlZTsOuKeZ7eVL8zGYoYHgG45nUm
	EWcVf79USAIaxY1rB3OLwmkKRL70cTVfyCLwMpPEfbxXTa0es4odNNcjbIVVbjOs96pZy8nFMmF
	hFo1yN6Cg0QtW7x9MKYw/n9QVjydSgNivYZDfG9spisLo4k0waGr+ptZv5VbUIORF9PtIV7gPjc
	11uPoEv4qiEpetDelmB0WEEz4ChKOzH6sZjWoCn+vOvaX
X-Received: by 2002:a05:6a00:23c2:b0:847:7128:ecf1 with SMTP id d2e1a72fcca58-8479f2714cdmr1949401b3a.42.1782799393716;
        Mon, 29 Jun 2026 23:03:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c2:b0:847:7128:ecf1 with SMTP id d2e1a72fcca58-8479f2714cdmr1949364b3a.42.1782799393145;
        Mon, 29 Jun 2026 23:03:13 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm1112600b3a.20.2026.06.29.23.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:03:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:32:46 +0530
Subject: [PATCH 2/2] i2c: qcom-geni: Add trace events for Qualcomm GENI I2C
 driver
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-2-474cd6cdbe27@oss.qualcomm.com>
References: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
In-Reply-To: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782799380; l=2683;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=IBRzc0iiDr752RyZmlrhOmlck4XRVCM5D9K2KWosX6k=;
 b=GRguIRps1Bi3/M9o4D0IBX2JCV68BDEGYAw2wtgV0LraRIlf9wFlQpXsBIPhHDiRfhFk9qBdE
 KSTkwrXjSn6BmKlkDtE9UeZzmRb7e5wTKZ/O7Gb1BrdbzXqWbcmg4d7
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfXzFmSHfl+/lx3
 n7EiGrARrV2jILSpf7VRiEkZ0nPNqsgj+T3v5SifgSUeU3DqKtHF27/yz8QODRN8qBS6HGtH4Kh
 EEVBSKqElbaebAdJt1uG5fkUC8uUjJo=
X-Proofpoint-ORIG-GUID: iiOmZ1T1XfvREwuORUqM0m8DQetseXJk
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a435c22 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0MkepCNd34v6RWspawgA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX7HqF7iEbc6E+
 KMzMDMoo82IldXPuaq7jYpupcQlX/0QBvp7TrbU/ZQKLPSziXeOKOuornSqgimq4/4pb8zs/AK2
 ZilG7H1otMAR7U3JPgTGtK8FQMM75oPWoNEA2yC5zgBDmTg4rxyzURVw0qHAnkSXDI7qNl83cJZ
 vbkTbudIGOmMiZC2z9xfdLz3rbIYs6q4KqZ5xhkFfVeZZrmXdx+Tv8SPdov1FyxZRu7O3vkoFHi
 yRUFZD1yVlArYU3oRPp+Skay+OD5Eaxa7EvlCvFNjjhKZVbarJy0hfdBb21StCpeHVfSG1fWBKE
 +cbIQ7oWzbgkpGVM1Plb3383jtt9FTs1F1xtlh97ySTphXVS8p7Fci2hQ//Q4FdRfsSBVGgXZEz
 raTzIlQHWQdPbltdt9rB/Bv6flSdQ41ObTl92xoTaERLXNIN08kYqE0u7a/7stMdn5Qdf/O2Krx
 FOX0KlhiilP08KgOwmQ==
X-Proofpoint-GUID: iiOmZ1T1XfvREwuORUqM0m8DQetseXJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300049

Add trace event definitions for the Qualcomm GENI (Generic Interface)
I2C driver. These trace events enable runtime debugging and performance
analysis of I2C operations.

The trace events capture I2C clock configuration, interrupt status and
error code and message.

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

