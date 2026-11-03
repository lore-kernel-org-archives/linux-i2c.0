Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696223;
	b=mgTAh+XbYHysNy9P0wYNPUGDdGU5kUhYf9kK9wPw2h1LDtTC7xKPnXpfd3Mif737aUxu
	 p07dHxjmE/8wdEQohq335HB+B0MoUpjjbn/rQBlrPfVjhg1v2qADsnXmmdidmLDn1rChx
	 C6ulOk3ydpnZ2nqN82Y8gAAL6+BWwVMn5RP0N6p6G+BIPqbBoY6NvLvsw7P6+C8h11VOI
	 TZq9EAB15QApXPeG2IGPsvBMidq8wWPZxTCuovnfy/USIN6rS2c/AFf9BAYkwznKqL6Z1
	 wk5EgpRAXrwWhtIYdlkQLr0Dg68kSwkclcXoglQmYGPyJih/GHZkCkNUBgZg14fWmeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696223;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=hKcDKGT4XgxiM4YNoHtu46Rb42jfodjdkpL7uHJPAVk=;
	b=xuJxX45yiYPEIOz5aHRMFiHZiiMqHRyK1zFSYv3lLmN24UzCnQnBhP3UZJzLdBvR+JzV
	 fxZjGMb32x02tUnmL1o6m3M5JQrF2LzuIcu+3g2BXlf3UMoGTLYiz9SagyFYU7gVVnsB6
	 RNFxQOgA6u9km3tDRjxnas1jySFnYzHeqjcx+OsVZOw1uR24vc6UY8mtlyDZkLECNX7eG
	 lnQvYf1Hzt9Aa9nXtnwo/Q54259yT/1l320XgBGKz+yT3oDMfLqF0tlQwcZPugfYOtkYO
	 a/XZiRzyTCnqFnSPUw3nlXuayDkgyQLYr9P8MxplXXsA7Od9o2rMlSeVA6lRGjeQgPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jevWMVrK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUrggv8K;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC25606A335
	for <linux-i2c@vger.kernel.org>; Tue,  3 Nov 2026 08:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC25606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jevWMVrK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gUrggv8K
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A33i8mS1142752
	for <linux-i2c@vger.kernel.org>; Tue, 3 Nov 2026 08:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hKcDKGT4XgxiM4YNoHtu46Rb42jfodjdkpL7uHJPAVk=; b=jevWMVrK3YG/smJv
	PRUAAcZBTxEFbSHMEqlzpQfyqWh7W9MOGUyL34h8YvleqMDw4m27wU8oFGcN49O1
	aopGCyST9KWJ2ZI069FXC5nz3dPmsu4SFzI7nUQ2+Vw8tpn/T3Qa2Ub+i4t+gtAZ
	0U6cIVDKCUiUm/7fRS1MDE21bZsH4FiTD2fMx5TJPPmefEZW0sz0crq6XjdnddLq
	2VboE+dXJw+cqR7FJcfYWkG53FKziaeWC0r8qkKfCjbuJvtxS2yyKKkJeGGnXs04
	fE6+3L7Z3BbNY51C/AgNiWDjm1m5Ly0mdGsY7EnISYDD5nSB4hbNUbZ/vslX9Ns0
	+xXTUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq7ycs559-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 08:57:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a0688a43d3so2768904b3a.0
        for <linux-i2c@vger.kernel.org>; Tue, 03 Nov 2026 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793696222; x=1794301022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKcDKGT4XgxiM4YNoHtu46Rb42jfodjdkpL7uHJPAVk=;
        b=gUrggv8KH80pB7uIvNgERSJ5cnt8UvmBbTlDxvxCPLfGD1WB9xG4+exfGq1Qn6KTGD
         uBtRPg2GahDOQ/YcuBD16ow0RNvCG+autpN0veI1UbqNR3GauiclgvdfmwxREQxRuo9/
         EdVoUSHFg8mvTj8cF+IGOu8itfJiGZ/ckBoBK4445wEUsHQTs3beHN7Xi7EXG5z+PFNG
         AGlQTEXMuCPsaNaXs7bCLL5MORa5CaEMNC9KGCPOj+2X56V26hXgyarJGBX9GEvpbeHj
         jrh2DgP7+5zzoaNZ8ynKPOpdzgXFNS6I1Z/K0cQ43DviiPjDtSL9HgJxM7LikTdptR+Y
         cwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793696222; x=1794301022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hKcDKGT4XgxiM4YNoHtu46Rb42jfodjdkpL7uHJPAVk=;
        b=sRGvzWzCDi6Ia3OCpczX4qJLFJHRBbm/yVuPeqMLbGThlCtKK1TzOY9Df8ykHNIOOw
         aRGNH3L2ZRuQa1weNmcgJDwtYCBfazGTJ0ydK4ZtmEGpvVBCogjFElR61cFfccVh96Cp
         sXulb1B7u0qCPnHlgArzw6LLUH1/Vq3gC/gClBeop+XaKMZ9Vy0vUavswMn48BldPj75
         1WFvdf+W281L9G1umLvyBDwSnkhurEoYLMD9zH+N3J2HZ0FBxjfDciwE/Jf/wpjDe4MF
         GOnHPMJYbkJhec6GQijPb1DNSKGnf4sMWpNNKYqYXM8kEGyNIkZ1vZq+BECPJ7yH6oNI
         UAIA==
X-Forwarded-Encrypted: i=1; AKwUvBxXrBHd0qVpM+7TMzmWGE8QAnpmWvIw4XYehv9wXDsxwzNtiN/H2fIfl5EzJMtz4P1Ngb/KVBxcVvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gqQ1uCNQQk0+LBFTk9yL/TEy+Tcs7XSttoMns450jORNK/rEd
	nzJrMw4yaw7qZiOZaldaYAmawkJ8dKM2/vGp0bupH5qHfinnaTH4i0zpklrFV6RxwvhjPLrRRto
	KFJHxyuIzg/ytgtlyuymjbeAYkLTRnArkDTS0K/YeSPXLjL2hR7tuznSAZe7Wi8kEhRWhoa8=
X-Gm-Gg: AYBFou03G/hwDLHbPigHPTIFFkjY7jg+dS5CntQsAm4CIHotnf5W1sc0E2CRvKCz4Da
	gRWBsIMrzVTBOlgHSs+oX5VOsMw225Hp6z7quS3ZmjuwKEVWO0J3xvOwJnfLD83cGxUVs9tJjoT
	kFM4HsY0F7fjAi+40+zeX4QVpe9EtpagfyrFKwAbmDe08c7EQWMmwezTaQza+MSaPWB0Hna8rIh
	MUi6X+xGHXp+2OA0j4G/BQxySmIn4p/68/BBmZN4FITXHx0+d4XUZ64r/mrrjCg/5lE4sb0VSCy
	JKIN0eWKq4jVGI57PH0gFD7tqHfYom+XKqiYzvE95tqmU1EkyfA61VQ/EunEqfHTJEya9nnD1uv
	JQrqJvAB7uUpZzGrMRYI/WqsU8Guk/GPUMu4F6nTmL8aZwR+1AvSmVAgjamkaUoT9OAG1YmjseV
	N37427Gyg=
X-Received: by 2002:a05:6a00:3a1b:b0:882:94ab:20ec with SMTP id d2e1a72fcca58-8a9be587fd4mr10038546b3a.25.1793696221629;
        Tue, 03 Nov 2026 00:57:01 -0800 (PST)
X-Received: by 2002:a05:6a00:3a1b:b0:882:94ab:20ec with SMTP id d2e1a72fcca58-8a9be587fd4mr10038532b3a.25.1793696221115;
        Tue, 03 Nov 2026 00:57:01 -0800 (PST)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad963cfe7sm3017471b3a.19.2026.11.03.00.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:57:00 -0800 (PST)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 14:26:42 +0530
Subject: [PATCH v4 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
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
Message-Id: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-3-59b3ce96dc4b@oss.qualcomm.com>
References: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
In-Reply-To: <20261103-20260826_aniket_randive_oss_qualcomm_com-v4-0-59b3ce96dc4b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793696204; l=6139;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=OkAop6VQcxoEVUH+raJn/MdzrvaCmRT+U2bHKkK7yRU=;
 b=snezTj5q1ec0WOXdPcNQ4WHT818EUplJVlK3AsJrJ6LbsMxpdy6XLX9J2urMP34M/uXXZ9Oxm
 Rsttk3yeeA4B9UyRyx3T04yvTIXzGGEPIfD8ycvIcxVJV+SxbAlgyDb
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Authority-Analysis: v=2.4 cv=V7foQuni c=1 sm=1 tr=0 ts=6ae9a1de cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dp2dQu5AD0A0ugWeZkcA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 9e9E9uiNu6b3eA2KvFc0FrYrUzXkNXC4
X-Proofpoint-GUID: 9e9E9uiNu6b3eA2KvFc0FrYrUzXkNXC4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX09Jddzu3/YOY
 7Di+W+VFesVdyoybX/19T9orr8iP8z/eF4KupY3W5C17EtbnJXN0NqEsioMikW5hAglxQ06BWUa
 3PxuFQFiVT9F6SRlZJI4pbvgCs5fOJIbwUdcEuSa0XRGVTtoxeuyE0ZcOOCURviSpcJ2wNeTQy4
 t9w0rVHu7tQByUyh2gCpsdC5R6GJxnGVTFxrp90sInjjJoPiP/uQK1SG7QdtJENTxhUNrGV1/t3
 MJP6S9/o78+AxvPhdZVsGfOuSRrTZCRIFGnTK1XJuMU+zXGlFglPDqDp0fC8kLPBN5DyJNDeqhd
 BQXi3pcCErbLzCg5AjtvTJdP3BOISWqH4mLmYAR25siEnx+IjRZNla1OJZTTHyPOBCxOqL1Kyr+
 TAH3a7WtrI8qyTguYmAZRmwSXSQxAY7zILs/HekVeY1bNWZehZLg6uULeMQTXjLacwn2Ji3BlkL
 iL69HMmldPf7MEoTIrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzNSBTYWx0ZWRfX4ns0UJYy7RSd
 AeC/buHkY6weSL+22Wb644lu3TuLtD4qmnygAIeBmgSl9pKJ7TO22neECKayY6YyWKL16TPgiTG
 kCtF+7N84J/DKoCIqgDPxM0vFAMFRMM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030035

I2C transfers in GPI DMA mode can fail with -EIO when a target holds
SDA low, leaving the bus stuck and preventing subsequent transactions.
The GPI completion callback reports a NACK and a genuine bus error
alike as -EIO, and the existing recovery path switches the SE to FIFO
mode which is not valid in GPI DMA mode.

Add bus recovery support using the I2C_BUS_CLEAR and I2C_STOP_ON_BUS
opcodes issued via the GPI TX DMA channel. Guard the -EIO recovery
trigger with a SE_GENI_IOS I2C_BUS_FREE check to skip recovery when both
SDA and SCL are already released. Extend the recovery callback to dispatch
through the GPI DMA path when gi2c->gpi_mode is set.

Use the adapter timeout for GPI recovery commands, and preserve the DMA
configuration error code when GPI setup fails.

Stop recovery on a GPI command timeout and report DMA termination
failures. Do not issue another command or override the timeout with a
bus-idle result, since DMA cleanup may not have completed successfully.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 107 ++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index b08353616adc..d5d5d90544e8 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1065,13 +1065,82 @@ static bool geni_i2c_needs_bus_recovery(struct geni_i2c_dev *gi2c, int ret)
 	 * -EPROTO and -ETIMEDOUT indicate bus errors where the target may be
 	 * holding a bus line low. ARB_LOST (-EAGAIN) on a single-controller
 	 * bus indicates a stuck target, not a real arbitration loss.
-	 * GPI DMA mode extends this trigger separately.
+	 * In GPI DMA mode the completion callback reports NACK, BUS_PROTO and
+	 * ARB_LOST alike as -EIO, so the SE_GENI_IOS I2C_BUS_FREE check
+	 * distinguishes a genuinely stuck bus from a benign NACK. Recovery is
+	 * skipped when both SDA and SCL are released (high) after the STOP.
 	 */
-	return !gi2c->gpi_mode &&
-	       (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN) &&
+	return (ret == -EPROTO || ret == -ETIMEDOUT || ret == -EAGAIN ||
+		(gi2c->gpi_mode && ret == -EIO)) &&
 	       !geni_i2c_bus_is_free(gi2c);
 }
 
+static int geni_i2c_gpi_bus_cmd(struct geni_i2c_dev *gi2c, enum i2c_op cmd)
+{
+	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
+	struct dma_async_tx_descriptor *desc;
+	struct gpi_i2c_config peripheral = {};
+	struct dma_slave_config config = {};
+	unsigned long time_left;
+	unsigned long flags;
+	dma_cookie_t cookie;
+	int ret;
+
+	config.peripheral_config = &peripheral;
+	config.peripheral_size = sizeof(peripheral);
+
+	peripheral.set_config  = 1;
+	peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
+	peripheral.cycle_count = itr->t_cycle_cnt;
+	peripheral.high_count  = itr->t_high_cnt;
+	peripheral.low_count   = itr->t_low_cnt;
+	peripheral.clk_div     = itr->clk_div;
+	peripheral.op          = cmd;
+
+	ret = dmaengine_slave_config(gi2c->tx_c, &config);
+	if (ret) {
+		dev_err(gi2c->se.dev, "dma config error %d for bus cmd %u\n", ret, cmd);
+		return ret;
+	}
+
+	desc = dmaengine_prep_slave_single(gi2c->tx_c, 0, 0, DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EIO;
+
+	desc->callback_result = i2c_gpi_cb_result;
+	desc->callback_param = gi2c;
+
+	reinit_completion(&gi2c->done);
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	/*
+	 * cur and err are shared with geni_i2c_irq() and the GPI callback
+	 * i2c_gpi_cb_result(); both write err (the IRQ handler under
+	 * gi2c->lock). Reset them under the lock before issuing the transfer.
+	 */
+	spin_lock_irqsave(&gi2c->lock, flags);
+	gi2c->cur = NULL;
+	gi2c->err = 0;
+	spin_unlock_irqrestore(&gi2c->lock, flags);
+	dma_async_issue_pending(gi2c->tx_c);
+
+	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
+	if (!time_left) {
+		dev_err(gi2c->se.dev, "timeout waiting for GPI bus cmd %u\n", cmd);
+		ret = dmaengine_terminate_sync(gi2c->tx_c);
+		if (ret)
+			dev_err(gi2c->se.dev, "DMA termination failed for bus cmd %u: %d\n",
+				cmd, ret);
+		return -ETIMEDOUT;
+	}
+
+	return gi2c->err;
+}
+
 static int geni_i2c_recover_bus(struct i2c_adapter *adap)
 {
 	struct geni_i2c_dev *gi2c = i2c_get_adapdata(adap);
@@ -1104,14 +1173,28 @@ static int geni_i2c_recover_bus(struct i2c_adapter *adap)
 		goto out_pm;
 	}
 
-	ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
-	if (!ret)
-		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+	if (gi2c->gpi_mode) {
+		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_BUS_CLEAR);
+		/* Do not issue more commands after a timeout: DMA cleanup may have failed. */
+		if (ret == -ETIMEDOUT)
+			goto out_pm;
+		if (ret)
+			dev_dbg(gi2c->se.dev, "GPI bus clear returned %d, issuing stop anyway\n",
+				ret);
+
+		ret = geni_i2c_gpi_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+		if (ret == -ETIMEDOUT)
+			goto out_pm;
+	} else {
+		ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_BUS_CLEAR);
+		if (!ret)
+			ret = geni_i2c_fifo_bus_cmd(gi2c, I2C_STOP_ON_BUS);
+	}
 
 	/*
-	 * Recovery succeeds only once both bus lines are released. The bus
-	 * state is the authority, while a clean opcode status with either
-	 * line low is a failed recovery.
+	 * Recovery succeeds when both bus lines are released. Trust the bus
+	 * state over the opcode return path, which cannot flag a benign
+	 * recovery event in GPI mode.
 	 */
 	ret = geni_i2c_bus_is_free(gi2c) ? 0 : (ret ?: -EBUSY);
 
@@ -1356,10 +1439,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (!gi2c->gpi_mode) {
-		gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
-		gi2c->adap.bus_recovery_info = &gi2c->rinfo;
-	}
+	gi2c->rinfo.recover_bus = geni_i2c_recover_bus;
+	gi2c->adap.bus_recovery_info = &gi2c->rinfo;
 
 	ret = i2c_add_adapter(&gi2c->adap);
 	if (ret) {

-- 
2.34.1

