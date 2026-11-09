Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232987;
	b=I8gL+BDio2MMvm/nfJLcXKIXCpmxE99EdUhiBZA/hTelZuaDEJtJVOR42NcW9XnbcWXd
	 4gzZ8lEOa0PLmvsyTpW60ZVyyCQkQxdqZ8m4ooalAzxsvY1L7e2tJSVCfM4T02BkKYNo9
	 catGn4Qwuf6EIRWfVqVxP+4DQ0eOMnYtMzmyOh9oqob4LphUY9ENxEeesswabw38N2EHn
	 3w2cja7Jpt7BNrCKmkKQhXnSaDhbMi9DOu2dFET1a93Td/ebVAC8Mm1vGsT2u8x1RjMbF
	 j6m10GM5DRsiouvizsStvQpuNwZ4OlQfPRkh2vGTKENEBWEk0mpc9E4HexBLQkWYMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232987;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zczUGJMJr16Lwoik/OCfJSBE0uj+CsPw2l16ybKYvnA=;
	b=dm3f0bOPKpjuH0OZUzpNhzg8GHYkJURHnkdy22/D5KyEq61u2KC8Xul6alaXqfyBfHdC
	 G2bkc0rXH/Pl8NLM7L5EVks/32riWzFhCqGsG9exTeCCQ2jm3FHUtghCIWMZdj857dirB
	 eJfoC0XP6VxXFAA9DrfL69J0Tp5CaSGyIB9Hn6lRYwBGKc3bELuQumZ6kLV4g8hHNNLlJ
	 yVa5JZH+5FB3mxIg0tLXXmFZhmAh9N1POtpq4uxATNcmPyGvF18pVhQ5WOvnKT4JsVTvF
	 8DSc8IrpA1v/NNkGj8W5hIfAuG0MfcMX2RF5VFnsdx6eMtd7dMBBU09kdcPiarSS4IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SGQSGVrE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cC2c6mLB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F441606A323
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 14:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F441606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SGQSGVrE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cC2c6mLB
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFEMp4025867
	for <linux-i2c@vger.kernel.org>; Mon, 9 Nov 2026 14:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zczUGJMJr16Lwoik/OCfJSBE0uj+CsPw2l16ybKYvnA=; b=SGQSGVrEQQtXuBTN
	fQqxTE1QcXa66mulU2C8HB3DL687I2Qn+BSlq2Yb3IVZK9kxwXQNo8062oueCmiH
	OOkg/SSw/DJ5EuHWHVrMDm7HWo6YfdnB6tZR+QxTHGYgZv/FYYiUi2/TzWSrBW/T
	SL0DBWP9BapDS6wSXp1uukvudgdg+J+dL2SrGQlxeJcgvz0uxDehXOVQAJ6D2fl8
	nC7soCt2jjxU8nkuztVBhiw4zktiR4nB3YqEv2vwnk2arS+Bg+RBEfWGFCW6OZiN
	SdkXgQzNrhAikLotOXk+Erl9VaK5BoRaKwHzvcv48bM/RNq9Ah8BHWBGg71YwkDj
	D0sGmg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua5898q4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 14:03:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5337ed1ba44so19860621cf.3
        for <linux-i2c@vger.kernel.org>; Mon, 09 Nov 2026 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794232985; x=1794837785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zczUGJMJr16Lwoik/OCfJSBE0uj+CsPw2l16ybKYvnA=;
        b=cC2c6mLBdj5N5dbqw8o0X9QHx9ZkmHSUH/LZgxcR7rNbZpf0L6m2vLH4KzP1tAF7IF
         DxEgNO5L6I5WvxM9ADoXpZ/wv9BU2FXmz0HiqS8Ij0xFumqQj4uskLrxqq3b0Kn5R1s1
         nsSi40Ei8FsB5hr2cs9cLVeXA/Ke8fzVP1+4vLYdv5LdYowOAB8FbIUmMpIyw8PMdLF2
         JZpnQhLJU2DklPIW8JNX32ojKKqd29OvGafWtX0wlmjv1sHLv1dTXfZn2iwKjQY0UNOt
         x79Iy3swnOfxwRI60FZ3Ag3jQHoN8VX64l5qCzFlMPWnkhWTCkTPqKr+vVodOMeelBv2
         50OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232985; x=1794837785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zczUGJMJr16Lwoik/OCfJSBE0uj+CsPw2l16ybKYvnA=;
        b=jKhvGhRszBjAYGJtEUGh0pvWB+lkI3FVYjsjv/6Ps1vm1IFVLljYZA6Jll9Rzt1m9j
         hmswD6E8DUS4ZWo+crNWXuMKxtT2NAed6dXp5SGGGr+0MqGJZjuGTd6L/oaOlDJ2zt4U
         a0012QEyoSCTtuRhf0j90ADQdfZ+2T7N7tGuzzTv65GlHk3YXXsc6stlxpRrt5+767/m
         C524iP/xlOug2phLsysMLGrEKnnidQ+V3/tc8T/TqEB5+ppcTCmbX7FYr9uXO4uGVtMm
         lktyKsh7aSXWBqyOWXxaRax65RiGabCoH+wNTfSd8hDO/H9gipggKdBVH200608kPmA1
         96Fw==
X-Gm-Message-State: APuU4Z/ppuHmasb3FuKF5gATNrcacARWOX3z2sQ4b3YKjCKaMGCk50Rq
	YYaVQsbxOIC8xz4lp7CtHg0j6Fc3BCJ9/aC1ThEWAlb1g3cPOtR+qUM6f49m/vS0CJs+d0Mpg3h
	taN4CB7anPow5jjPwiZg7+FRFg0IcGvy/fecA7npNgVO2CRPrYxcogyw7JrzL2QzVx7EJ3gXnXA
	==
X-Gm-Gg: AYBFou1odcl9gUZmQuS5tMv5en3gYLtOc6r2+3DQ5yG4SxcnFxFH8LC2TME5E8f1qVO
	xILU3fJU7UHr7TLnNToIeVx0RN9H9a7SNKBHoZkS/2JF5uF7Iw/758o1QmpTkwM7b4zwSc2eNWW
	R8UWJZ4bxd9GympGsERVQlWbDT0/dDc2/E1/xO9vHs89n0/KPm/K2kRw8CeG+O88WPbwtRAHuf7
	y624oLis9aGvACM7jPk8y1V7ldhiQBfzqf7cC7NrPWzaLVko7dNK6qcwsU4xq8ojFP06MOAFl6J
	JWK7v8l9yLUqiXCJougPzKGpKBvxxIqW35Mec6IN25UYpnzzPWa2LA2YZMiid3ufXY3+5H0KuZe
	7KYME1Fs7q19uARAbyzkiX63DSJEaPz6spWr7WNu9+5oRMRvr4M0ARAvrQFkkPbD2Jrufws9yMc
	Y5h0XSHSEkzrKu+yl3noSHh97wujf6dohQ88/IUz8CMVLWczWeYlilDIqpkgvQHPzAqOHW6UDRH
	TAzQKJNnzkOcWex9f0szLgDVtpF
X-Received: by 2002:a05:622a:1247:b0:545:de78:a6fb with SMTP id d75a77b69052e-552a4ad48a3mr65058281cf.33.1794232984604;
        Mon, 09 Nov 2026 06:03:04 -0800 (PST)
X-Received: by 2002:a05:6122:e266:b0:5ea:e7aa:acb9 with SMTP id 71dfb90a1353d-5ece720b077mr1143331e0c.6.1794232928829;
        Mon, 09 Nov 2026 06:02:08 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f9b5:154f:6aa3:35d3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79502652csm161515845e9.4.2026.11.09.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:02:07 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 09 Nov 2026 15:01:56 +0100
Subject: [PATCH v4 3/7] i2c: qcom-cci: Detect capabilities from
 CCI_HW_VERSION at runtime
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-cci-imp-v4-3-4dc4095dd052@oss.qualcomm.com>
References: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
In-Reply-To: <20261109-cci-imp-v4-0-4dc4095dd052@oss.qualcomm.com>
To: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX1o1IFS2n9qWX
 s6Y6YgQJuoA717jtw9ItAe3pmXxk2v2iErvWaXr6Y2W2Qvod/uuGSoN8FmxJqsUADF2a1iARrTh
 bUTfmf825VzrL150wsU+viWIhbih9spVpj7DSCsNBVEb/KFgHq5/g8GRjnnyEI87sVxEgbxz5l7
 qXV4PGE36m9PS69ep6c6WX+meENpI3k0gIgGv+zjak+PRfOTuohv6UApMj+Id8AmqKkfXSux4ZI
 NOce0/ctPOxXZ66b8GDP2WYDdyAmzyiFgQVHrT7xGFDhlhRLHPizZQDz0f4jnOM38+LitdKmbl3
 3grt0M7Ojys6HBBNyizoG9CIOlTQGrFsOtQHMr9uJUiUb1n3oKlW2Dqv5XG2zfzsZAU9qiR8bq7
 58TgFMC62D12dx1abu+qvz6JBBL7vy7bAjUS6RZiEawCWRHnX3KUwoorduotmYnji6fizRUIWvB
 tn/JGW7OKTBikd0vlsQ==
X-Proofpoint-ORIG-GUID: _2_Vx1dvuok-og176PM-7q-A5UYND-Lu
X-Proofpoint-GUID: _2_Vx1dvuok-og176PM-7q-A5UYND-Lu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NSBTYWx0ZWRfX4SNhVeSJ0Y+M
 pFuTIcZPZaQPHMfupoY7ZmCbqPhYtWCHcI5e8l5WsFTSgqG97HvPTNojIWykKcMQ9LxPErauiQF
 Lag99gUmszVmHZaqgk0IdkF+tJn0QhM=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af1d29a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=8R-5LDRAFMUVkZqLBecA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090055

In theory, every SoC integrating a CCI revision that differs from
an existing one should introduce a dedicated compatible string.
In practice, most CCI instances still fall back to the msm8996
compat (v1.4.0), one of the oldest supported versions. In order
to take advantage of capabilities introduced in later versions,
such as larger queues (v1.6.0) or threshold IRQ support (v1.7.0),
we need to properly distinguish the different variants.

Replace the static per-compatible cci_data definitions with a
version-sorted capability table keyed by (hw_major, hw_minor).
During probe, read CCI hardware revision register and select
the newest capability entry whose version is less than or equal
to the detected hardware revision. This allows revisions to
automatically inherit the closest supported capability set
without requiring additional compatible strings.

Several compatibles that currently fall back to the msm8996
configuration (e.g. sdm845, sm8250 and sm8450) will now resolve
to the corresponding capability tier, gaining access to their
larger queue sizes instead of the conservative msm8996 defaults.

- v1.2.x CCI increase I2C write payload + burst write support
- v1.6.x CCI has increased queue sizes (64,16) -> (128,32)
- v1.7.x CCI introduces threshold IRQs (leveraged later)
- v1.10.x CCI increase queue 0 size (128) -> (1024)

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 162 +++++++++++++++++++++++++-------------
 1 file changed, 106 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 3ccb5cc90f62b0996acde0b1df568ad4e022907b..48dabd923b690864eccc29d232847c80f3c3b46c 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
 // Copyright (c) 2017-2022 Linaro Limited.
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
@@ -14,6 +15,10 @@
 #include <linux/pm_opp.h>
 
 #define CCI_HW_VERSION				0x0
+#define CCI_HW_VERSION_MAJOR_MASK		GENMASK(31, 28)
+#define CCI_HW_VERSION_MINOR_MASK		GENMASK(27, 16)
+#define CCI_HW_VERSION_STEP_MASK		GENMASK(15, 0)
+#define QCOM_CCI_VERSION(major, minor)		.hw_major = (major), .hw_minor = (minor)
 #define CCI_RESET_CMD				0x004
 #define CCI_RESET_CMD_MASK			0x0f73f3f7
 #define CCI_RESET_CMD_M0_MASK			0x000003f1
@@ -133,7 +138,8 @@ struct cci_master {
 };
 
 struct cci_data {
-	unsigned int num_masters;
+	u16 hw_major;
+	u16 hw_minor;
 	struct i2c_adapter_quirks quirks;
 	u16 queue_size[NUM_QUEUES];
 	/* Highest I2C mode supported by this variant. */
@@ -144,6 +150,7 @@ struct cci {
 	struct device *dev;
 	void __iomem *base;
 	unsigned int irq;
+	unsigned int num_masters;
 	const struct cci_data *data;
 	struct clk_bulk_data *clocks;
 	int nclocks;
@@ -245,7 +252,7 @@ static int cci_halt(struct cci *cci, u8 master_num)
 	struct cci_master *master;
 	u32 val;
 
-	if (master_num >= cci->data->num_masters) {
+	if (master_num >= cci->num_masters) {
 		dev_err(cci->dev, "Unsupported master idx (%u)\n", master_num);
 		return -EINVAL;
 	}
@@ -366,7 +373,7 @@ static int cci_init(struct cci *cci)
 
 	writel(val, cci->base + CCI_IRQ_MASK_0);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		int mode = cci->master[i].mode;
 		const struct hw_params *hw;
 
@@ -616,7 +623,7 @@ static int cci_get_required_rate(struct cci *cci, unsigned long *rate)
 		if (clk_round_rate(cci->cci_clk, cci_clk_rates[ri]) != cci_clk_rates[ri])
 			continue;
 
-		for (int i = 0; i < cci->data->num_masters; i++) {
+		for (int i = 0; i < cci->num_masters; i++) {
 			int mode = cci->master[i].mode;
 
 			if (!cci->master[i].cci)
@@ -696,6 +703,81 @@ static void cci_put_of_node(void *data)
 	of_node_put(data);
 }
 
+/* Hardware capabilities, ascending by version major,minor */
+static const struct cci_data cci_hw_catalog[] = {
+	{
+		QCOM_CCI_VERSION(1, 0),
+		.max_mode = I2C_MODE_FAST,
+		.queue_size = { 64, 16 },
+		.quirks = {
+			.max_write_len = 10,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 2),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 64, 16 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 6),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 128, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 7),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 128, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+	{
+		QCOM_CCI_VERSION(1, 10),
+		.max_mode = I2C_MODE_FAST_PLUS,
+		.queue_size = { 1024, 32 },
+		.quirks = {
+			.max_write_len = 11,
+			.max_read_len = 12,
+		},
+	},
+};
+
+static void cci_detect_hw_caps(struct cci *cci, u32 hw_version)
+{
+	u8 major = FIELD_GET(CCI_HW_VERSION_MAJOR_MASK, hw_version);
+	u16 minor = FIELD_GET(CCI_HW_VERSION_MINOR_MASK, hw_version);
+	u16 step = FIELD_GET(CCI_HW_VERSION_STEP_MASK, hw_version);
+	const struct cci_data *data = &cci_hw_catalog[0];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cci_hw_catalog); i++) {
+		if (cci_hw_catalog[i].hw_major > major ||
+		    (cci_hw_catalog[i].hw_major == major && cci_hw_catalog[i].hw_minor > minor))
+			break;
+		data = &cci_hw_catalog[i];
+	}
+
+	dev_dbg(cci->dev, "CCI HW version %u.%u.%u, using caps tier %u.%u\n",
+		major, minor, step, data->hw_major, data->hw_minor);
+
+	cci->data = data;
+
+	for (i = 0; i < cci->num_masters; i++) {
+		if (cci->master[i].cci)
+			cci->master[i].adap.quirks = &cci->data->quirks;
+	}
+}
+
 static int cci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -710,9 +792,6 @@ static int cci_probe(struct platform_device *pdev)
 
 	cci->dev = dev;
 	platform_set_drvdata(pdev, cci);
-	cci->data = device_get_match_data(dev);
-	if (!cci->data)
-		return -ENOENT;
 
 	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		struct cci_master *master;
@@ -724,14 +803,16 @@ static int cci_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		if (idx >= cci->data->num_masters) {
+		if (idx >= NUM_MASTERS) {
 			dev_err(dev, "%pOF invalid 'reg' value: %u (max is %u)",
-				child, idx, cci->data->num_masters - 1);
+				child, idx, NUM_MASTERS - 1);
 			continue;
 		}
 
+		if (idx >= cci->num_masters)
+			cci->num_masters = idx + 1;
+
 		master = &cci->master[idx];
-		master->adap.quirks = &cci->data->quirks;
 		master->adap.algo = &cci_algo;
 		master->adap.dev.parent = dev;
 		master->adap.dev.of_node = of_node_get(child);
@@ -785,10 +866,6 @@ static int cci_probe(struct platform_device *pdev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to add OPP table\n");
 
-	ret = cci_set_core_rate(cci);
-	if (ret)
-		return ret;
-
 	ret = cci_enable_clocks(cci);
 	if (ret < 0)
 		return ret;
@@ -807,7 +884,11 @@ static int cci_probe(struct platform_device *pdev)
 	}
 
 	val = readl(cci->base + CCI_HW_VERSION);
-	dev_dbg(dev, "CCI HW version = 0x%08x", val);
+	cci_detect_hw_caps(cci, val);
+
+	ret = cci_set_core_rate(cci);
+	if (ret)
+		goto disable_clocks;
 
 	ret = cci_reset(cci);
 	if (ret < 0)
@@ -820,7 +901,7 @@ static int cci_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(dev);
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (!cci->master[i].cci)
 			continue;
 
@@ -848,7 +929,7 @@ static void cci_remove(struct platform_device *pdev)
 	struct cci *cci = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < cci->data->num_masters; i++) {
+	for (i = 0; i < cci->num_masters; i++) {
 		if (cci->master[i].cci) {
 			i2c_del_adapter(&cci->master[i].adap);
 			cci_halt(cci, i);
@@ -856,51 +937,20 @@ static void cci_remove(struct platform_device *pdev)
 	}
 }
 
-static const struct cci_data cci_v1_data = {
-	.num_masters = 1,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 10,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST,
-};
-
-static const struct cci_data cci_v1_5_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 10,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST,
-};
-
-static const struct cci_data cci_v2_data = {
-	.num_masters = 2,
-	.queue_size = { 64, 16 },
-	.quirks = {
-		.max_write_len = 11,
-		.max_read_len = 12,
-	},
-	.max_mode = I2C_MODE_FAST_PLUS,
-};
-
 static const struct of_device_id cci_dt_match[] = {
-	{ .compatible = "qcom,msm8226-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,msm8953-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,msm8974-cci", .data = &cci_v1_5_data},
-	{ .compatible = "qcom,msm8996-cci", .data = &cci_v2_data},
-
+	{ .compatible = "qcom,msm8226-cci" },
+	{ .compatible = "qcom,msm8953-cci" },
+	{ .compatible = "qcom,msm8974-cci" },
+	{ .compatible = "qcom,msm8996-cci" },
 
 	/*
 	 * Legacy compatibles kept for backwards compatibility.
 	 * Do not add any new ones unless they introduce a new config
 	 */
-	{ .compatible = "qcom,msm8916-cci", .data = &cci_v1_data},
-	{ .compatible = "qcom,sdm845-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8250-cci", .data = &cci_v2_data},
-	{ .compatible = "qcom,sm8450-cci", .data = &cci_v2_data},
+	{ .compatible = "qcom,msm8916-cci" },
+	{ .compatible = "qcom,sdm845-cci" },
+	{ .compatible = "qcom,sm8250-cci" },
+	{ .compatible = "qcom,sm8450-cci" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, cci_dt_match);

-- 
2.34.1

