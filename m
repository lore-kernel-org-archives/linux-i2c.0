Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078017;
	b=NcBHy/NHcvfM0AF+Mj62gQwpkOUDmxUf5ThHXFwwzJ73QT2WPzH7rPe8mpNUkkqNo4Yx
	 yyb2Xk9Np1t8k0iWTLUs4QADMbL4x1gMcSGld3jSkNVO2WsfXAwlnPj2KHIsnrjpFal+F
	 dex6cRa0N1YFJMQX6/OOSmwxN2fvl5oW2+lFkI7uyCgcrTDFzfqUwZR+GwN2PO0uXCcD3
	 52TSSoQ/zf1XMLGHsbbwlrIApC0mBRaiEwxkdSmrnI9OTMgFigvMIVN8tDP01LjGxOx/k
	 Ae1MxV9C4eQRrcTQZVCMxyMWFe/niLb98LBijbFAxdNpZgWv8v91Dzv7lfji4GolLZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078017;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1iBMHqRtb9KCVWuGmA0rW9gEgHupGsvkbN3KIIR5/gI=;
	b=wWK6pdiLgOl3BdBier9JKqKRtQytPs63QBgp8NRD0y5tICfBrLw2IVvSg04EAgxIZ+JB
	 PQojWCy+FSg104JAGTeandBdURnYkgnRkpgwnGMSIWf9Rb9NxyUWndXd22bBU1EJfZs38
	 vwPMdQeSirZdwP/39CoJgMCSQeFVBg2BJy1kX/kjeZHh+4TVD/xXMhwbDkhnR0sHzJqaR
	 4DZHgvmpVsZdBQvuAIsXn+mp2pvLMeclAMlaxDVoHdwIE7GOzUFtwE8tgVVfvpMIGWYXM
	 GNhgg6kLM5Ni5ttcjTee66vj8KPW28GVbzEjutKOtiPTIZDEse+xpRguA1yzacoUjYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UE6MPSbJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YgygeuuI;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D946A606A31B
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D946A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UE6MPSbJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YgygeuuI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R2F2IO4151922
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1iBMHqRtb9KCVWuGmA0rW9gEgHupGsvkbN3KIIR5/gI=; b=UE6MPSbJn3gFw3KV
	Mt0Ojo//+jZfYPRB36SH/wfSKeUV2FfJioEL2fwTzaxA1mN6wSqbL/ZQUMP8NF4E
	mW0iXtxeb1EnPykG3ix/kA28l8nQL9B01dFLgIP1HusyLmnxp4ZgYHmXrLu2KMs4
	zeko3eRTEtDN9bJgy0Z34zXcitxVlVE23ggmm0PYi2BB7+3MgikVy/KOnjAAeYWn
	c+vW8dbuxD08+4P9EKBaMz0LWcU9Q/gGApoVLCB4Elgvdwbzl2Xu7SPJguvNCtGw
	UFuOFRECsLLLCdzU+lw1hIcJ2JpElouxysPPCYCzn7YtD/zgouxSo9OmeQ45znDM
	aqtjAg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u642ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 05:13:36 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-139b62317d0so1611079c88.0
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2026 22:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793078016; x=1793682816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1iBMHqRtb9KCVWuGmA0rW9gEgHupGsvkbN3KIIR5/gI=;
        b=YgygeuuIHl2uDjHsnaPW9oKaiRxNFWp4br9LPhZB1GsrJ1S8AMhRBdkHW+7dVWUVTD
         TR4oVZbiBLuUXWEx/tgN2tArNVPJghwRaFxjgk8+cjyM7TcGRCWfyhr92RaOa4CbFKxk
         dtPuf3gU6gt9OksaJi3FyUpLda2U95e1qpnvnEI8jMhd0xXX3PKv/WvEdSVta3tQKdSF
         QhtcxujITKUshOHGLTpyIEQRSk8uV4EWGTJPzipJxqAmrfHxczc/a1f97h+cs/MP5Lcg
         Wh1ERbxEN4mjWUOeaix7RbfZgocwlnMLpjW1S3wLdwGh8Ib2XK8nz/SSGWlcCdU1ZtMy
         0ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793078016; x=1793682816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1iBMHqRtb9KCVWuGmA0rW9gEgHupGsvkbN3KIIR5/gI=;
        b=QOedpHISSEFk2WVbJ54GUlKLpWiXZZIfLE25wnPZER+LzSJoqrGMVjjEIdUKisNR1W
         HwjiYr6Zmq6VZTxsG/xRA0VOZIDJ3HOnR9f6ivMO2BxUL3G9IO2c4mUuLnZSU3Ce3Uf4
         K3WCOXKVAuZ22RdBi9jc0PD4yBmkhW23JAY88+PLAhkW3y7pOSl1kAzsN4dMTvJ7Tm5e
         QClUnpdjFUAkT3QQfpMWdGi9+Yw8id3vArQZi3e60z7jCSYIMiTZH/49GLi6SZmT0KlF
         xscHH/hSZHkHJuLJs3iXLOLCE6krWmarThcLs+1B9DgPLSXUEg+nbtCo/CILoOhYBWe3
         i+mw==
X-Forwarded-Encrypted: i=1; AKwUvBygniTR/p4EhH2neCIOZs4hRKDmnf+B3jAhJBk6jAwrYmTUgAPuGcNBcSFybbUMTV1DcLmq0YT+jjw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzb03vB5+dYd/OKbhvB4Eacy9Am5SijWhwjpoflncaspGfpodA
	EmRuH4zamG6udHIq32zDD2+vBNzQjjEUmjn5qItLhmTtyU5tXpWIQiHYZHR3gCC6FBfc/WfwMjd
	02lvcICYW5BEHUmoVyxv8uXPSLS0Y6P5hxxvIRTzEmcXeoKJXBwoLB3Pihh+i3Sw=
X-Gm-Gg: AYBFou1xLAR09sk1Coy5pU1itgP0EWXq7AgmH9SwjLJjfBS8YtCgwEtTU8yMZiCq/EH
	ziiuc8/jzL/ljptXhqFseg8mokE+vH1oFuNvPqIhrESaUSCAiUsDo60u3JSzNBGMT0J967BU+a6
	ECGuvdVfBDADBP0ri4RIZlKglRGx7hqgBb/Eedefbx2OqkJm8uzZ2W8mS+fGRcczww1Po/BCFR4
	dJX/L/+XHmGsw/Op4QuaB0e5qTnfBhJmSaeSHmd756XM5y8wv0fnhGn4VUeHBuuqgdsDkfXmB0t
	CyX77SECz2pFfpF6v69qiVEg/ltF58TAHMXD6SMk0HfPUKhVagQxctx6IHC1Xwy09lnBycb2gIq
	nX17a7LLAuTC+vtbGWtt7athn9P8WpnvQUg==
X-Received: by 2002:a05:7022:7f06:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1992afd1fb5mr13347958c88.5.1793078015269;
        Mon, 26 Oct 2026 22:13:35 -0700 (PDT)
X-Received: by 2002:a05:7022:7f06:b0:186:3f0c:bd09 with SMTP id a92af1059eb24-1992afd1fb5mr13347923c88.5.1793078014660;
        Mon, 26 Oct 2026 22:13:34 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm62298866c88.17.2026.10.26.22.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 22:13:34 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 10:43:17 +0530
Subject: [PATCH v3 3/3] i2c: qcom-geni: Add bus recovery support for GPI
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
Message-Id: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-3-7f2a6e572de9@oss.qualcomm.com>
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
In-Reply-To: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Aniket Randive <aniket.randive@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793077998; l=6226;
 i=aniket.randive@oss.qualcomm.com; s=20260325; h=from:subject:message-id;
 bh=oHW16ZLA84x86i3H4S8T1Hpo95kIY9SzvYZ1URod7wo=;
 b=7EPpT6xhz/3IQ+T5APz+XgApRVRSNwvbib5bjIh9yPnOKdfTuaWIQdknSvpESo7IyGbPrJG2P
 DY5sOzyiPStAikTCQ88gqN0mIiPkQSAusGncaVeDZzzfcuP1b4PpIu8
X-Developer-Key: i=aniket.randive@oss.qualcomm.com; a=ed25519;
 pk=4o37X1ZqGbCO/T2SR8kq/HnWvq0yb1RUlFuNukovbQk=
X-Proofpoint-GUID: vHMlSQfN3z-JZRLV3mFS5_Mo-dV8DhDz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX/ugZ0nkjMlYJ
 wXPO1WPA8lnRu4uKTpbtqGwq0Q7jsdS7gYn7L/lh+Lt5rtWWDo6PQDtNtyQ22we5GG4UFCx4rVC
 STj/t/83aQSXAG6rE4B+YaIF7zUuhp31DQyDujFCUlx2lW7DdzVANdn/FC3sLqKbpUnlLrGCABO
 6H9KMRewuMxAhD3Bq8YksnUQIQ7Ca/l5RpkvBbUMTsAbCF4EbGksPWuPs6cqv0jbbw/cS9Bhdg9
 BoqEmhlz4xxzqRSZM4bTADkcBgE56CR4heDqih4oYgtpJIpJJXVVBRA8rG8Aek7jQpyKRikcF0c
 JDz7baaRqKpaqLV6R5ZXDF0K0bT6PiZdOEU21fVbz8kY0LoQr7p5Jm6lO+07h6fPhD4U8qpH56B
 eC1eXWGBjg2ZWgqO+RLnXIFgj6AoDH3AR+VBFjFIFCKgrRcKGkpv04Lyh8+9X7aHoJTOwlIBO3u
 GlkqsxR0NaXkzkZ+9bg==
X-Proofpoint-ORIG-GUID: vHMlSQfN3z-JZRLV3mFS5_Mo-dV8DhDz
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6ae03300 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=k1huG3081okQl_w4-uUA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfX1NmycCcAxHsO
 60zYnZq++jg6SFj637hvf2kUXR/wZIlaMtjLTmSfFCnND30M+3P2+o1HqnqouWGXtbyhS565QPs
 4NjhTGfzZQoMl2jYb7yomaoJC9rfVdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270020

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
index d9e86f110ae9..ac9d1875b54f 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1065,13 +1065,81 @@ static bool geni_i2c_needs_bus_recovery(struct geni_i2c_dev *gi2c, int ret)
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
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return -EIO;
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
+	reinit_completion(&gi2c->done);
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
@@ -1105,20 +1173,35 @@ static int geni_i2c_recover_bus(struct i2c_adapter *adap)
 		return -EBUSY;
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
 	if (geni_i2c_bus_is_free(gi2c))
 		ret = 0;
 	else if (!ret)
 		ret = -EBUSY;
 
+out_pm:
 	pm_runtime_put_autosuspend(gi2c->se.dev);
 
 	return ret;
@@ -1359,10 +1442,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
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

