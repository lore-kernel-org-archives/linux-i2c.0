Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580475;
	b=v7SGD0lHGTHwRts9hhk6vgJ4KvvDFpgB9ctSv8eSbx6LhSH0xEowH/g6s0mb8TGKX7UZ
	 CUyKJL7sfc6yBtcEsrxiwGzPlyd10McreIbIitdGbpq4wPZC0etAtfcHG/Vcdrs/MQ8ry
	 wCglxndjEzDUZb1kdTMZ1uo7/jZWXU2KLQw4yA7r3ET2PcfM/mcFHBIxKU9r1lHvF3++F
	 HMqmvmjY8+jfu1MaUrN8d/mpuQg3esWQXAqbv78Epmy271lX8r7bFmejlhlGCD9iqkqiA
	 OsG70DEqEJskzLRI51J7w7svNMvW/AYAsThJDHUJdKpZG/m8mNDokzO4cbAA3kpvlHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580475;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ieHFy23q8nzXaZ195Z0A67B/EMZuqN8/BFlEEwpO4ek=;
	b=oMtzZaKSC2XNzmwdzjQqiOmYkUoHYx7mSrFYaOVkyEEoDr/LQEXK36JOxfQyQkfFwjrd
	 W5pz5eoQ1l4ICu1cfhYbBuGMb6h3H8smmlF9pkCzUKrimTDdrmPmei9sUT2yV8sQ05ESK
	 Abm+J/fEL2DHvzxEJMqJNykGZyIYGs0kaizcs89iF00LBy9evd7A8HHfWAzEf7dvll2BU
	 RGQk33ZXApAP//zvKwjiD4Z2fXrkFDHXX/OAJ5yGdJjPgnpmktokSn+2aXz4ok5pXU696
	 eFj6tn8VnkWGU/iLqTQpHevf/pfitnmMWhrNLNzuQC1/mqV9J3CDmwWps18x+PXe8JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MBhgXHq8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwSHF80w;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FA606A329
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404FA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MBhgXHq8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gwSHF80w
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LA5pim3016035
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ieHFy23q8nzXaZ195Z0A67B/EMZuqN8/BFlEEwpO4ek=; b=MBhgXHq83hx5GCDn
	HWm/hqW7klNivdA3DkC75vnc7ODYHVPpIzCBPR//FxMDvtE1VO5nFQGB53GlcDtl
	s+ekgbYqcSvnZKF2rHhdp9JJ5Kcgtm3I+0pi6ljMBL8aAPDhQALTAWV3P5Q9wUGx
	qW9DskDF2rzKgr9BKqyZ6zbpLCfmqOieAduixM3Zxqjo8oEwiptAtBuDmybUajnw
	rbLXmEQmfdriUHKkDWhaNb29mZxwocQBjxWOpZdaPe8MXJabsXqq5vxMIFLVDFIC
	XweuuU6SP1wGYCN7ZeJaM594PK2pl1C2AhBmMD6ayWf37jwj+Ejv9h3SNQ7NYcLV
	lY9+Vw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy78pxm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 11:01:14 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a04d1cb2so1811556d6.0
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792580473; x=1793185273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ieHFy23q8nzXaZ195Z0A67B/EMZuqN8/BFlEEwpO4ek=;
        b=gwSHF80w6T43dAvGxUKxUFruFQJtNDZbyYZdJR67IOrmXgzqSwAzi33966C2MnuKUD
         smxRHPYoldyVwXD7OKpY3IAe4lQ1D+HIqA3LvhK/n6T+qHx80OWz7h0KIBfCIU5+7YGE
         UASzdk61q9wqhf9Rbim55SUPEPCvCdqAWqAhFt0gGepEvkR60FSMWSbxZ8q4Mrr5U/bf
         OPwl7Vn0H8LsLIEKUL/ZeM7ubQkGd/gafaSCgBZfQPYp0jk3dXhTVbADgJFQImO0w8YF
         tYqI7z7/M4p1yO/A2WDecS10BaSdpPskk+wd8fgFsti+I8IvTACBqRmVM+Y13in8zQcy
         biCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580473; x=1793185273;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieHFy23q8nzXaZ195Z0A67B/EMZuqN8/BFlEEwpO4ek=;
        b=uiItV6uH2VMIZrOKgSmSGdpOHtkAxZNxL/p4AtNwj3d7wIxEUESEhpvq1hu205JR2F
         jRhz2O8Jg54h2GgFOAwJ6BwEmdmexauo/L4tThbW8ic7cLMfpUgoR0wlkAihGxzPz0Xq
         e9xM3GMUfCqXW0l4I2CmwEHRTEC18RtMt5iGnYL4exDyQkcN59XAJYhgVDJgYRAgxdgK
         JTdW1wWkLBmWZHR2s18KeWqRmdexApPC92y/ELj1UDP9NtjFniKqwNDpeHqBr5gdMC0l
         d00YvWTHpYuuiRcj1gr8FdSPz7qKL8pNpQblKmAdBddaciqVOd2avvzHfs0HUs23PFvC
         uDwA==
X-Gm-Message-State: AFq9FYLnIHmIgw5X3GV6xvJWMCWzUN1umIodABS2Ao9/ADmFt35ai6m0
	yf/eZkWiMLFzgC1uypJmR26UlUOPQvzEK5jvAXrot+/XRJruGngiA5XP62ZKq4eWnJdDM3IVLyB
	KaE4dr23jn0WU10E/28QPjaQo2U4Z3BLYRL//QWTLK0K/p+MJiGfDOKCpEdOajkQ=
X-Gm-Gg: AYBFou1LNMsh+TrT/1zmgD3OZL6kCnmcuFqpckwm6LFimtGTOpri2GPF55q9zT1zAyE
	6jYTkTppIQKIwKYOJwEi3AOInF5/hPc+9+/2hyyxFuC7gLAZJZQGTh+1Drspxyf82SG69r0OnOt
	J1OMEClY5vqFlg97Om5I3LP3Em1y9sV4rmDg7z1jtjhIBamjOPXPL/aAoMIOpsg8Lqb24Goi0WP
	IRF359fB95b992CaeFLcb7G6CDlzRW2hX+1lbDL8LCmefGjhZ9W/iQZCP39mjevUIwV1m4uSJOB
	iDxof42A3o082nWwDtvDunQjuUtH+Cj7c/6KFE46+7GP/pVVBSBUuXjusAUXyI36yyQ3O/yEODI
	cEWoJcuP2Uv/1jsX2ArvciQ==
X-Received: by 2002:a05:622a:1aa5:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5369b5536dfmr28200091cf.2.1792580473088;
        Wed, 21 Oct 2026 04:01:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa5:b0:52e:3991:84c8 with SMTP id d75a77b69052e-5369b5536dfmr28197021cf.2.1792580470613;
        Wed, 21 Oct 2026 04:01:10 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4678e5b763sm66072366b.2.2026.10.21.04.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:01:09 -0700 (PDT)
Message-ID: <59888512-9938-4982-9869-5f1d0e3770be@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 13:01:07 +0200
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] i2c: qcom-cci: Add burst read support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016-cci-imp-v3-0-5ee7ec1ea1a1@oss.qualcomm.com>
 <20261016-cci-imp-v3-6-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016-cci-imp-v3-6-5ee7ec1ea1a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: szL0AaGwxMD-SkP3jJt-cT5yJxiJ0zJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfX4sTtJUQcG/rw
 KkYDwTOhxptrtLzgtAtxNf2nrJbOZiQXvsVt83ATRkHRyj2qCxeVpfWQ/R7SNPa1M685dHacK8y
 IGwZ4aPnz1Rr840Q2eYk6Ekwc7Us602BszvamUCLa54I9s0HXeVgCKYHbKTuMrnFYHS5WS1UBrd
 qGIOeLYA1uQzqEnEi8k9F8zcKb9RmSj26JuUG6h5cxcW05jZ4cQ1uZG+4jTiYKof486Bg4Wv199
 ZWP3595MOuNF28HFimILe5njH1zbqyTxeOMhPXNv5RQbEMBPzPJOK+5H/mEApUGI0bOrYzEut7A
 I3O8BfeQ3DY8oCypVfEFzqiug76ixyO7zW4sWbyyX8dLCiHNUExngV3Dr6EHz3BveKCZdWIYurD
 hLGCGGiDkYDju7Mzop1PMSyuMQHznjzaicNrvsMcIxXc3iNiUboG7JV4g59eDY5GaLk1Tf6tER7
 9vBs7y0TPG+K7DJuv/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0MyBTYWx0ZWRfX19SSOmVEcA6l
 tjSxWGg1yGEEKMu2+OKXw9UIJopP+DXboCZl0D1eyeC94XORLlmR/NsjIXmU9+cxUlNRYVZzURT
 pT7IrEDTLm1QpN/zBrshYs/pZSZo4sQ=
X-Proofpoint-ORIG-GUID: szL0AaGwxMD-SkP3jJt-cT5yJxiJ0zJ2
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad89b7a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=EWxcpF3ALA2S2w6I5qsA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210043

On 10/16/26 10:00 AM, Loic Poulain wrote:
> CCI_I2C_READ transfers are currently limited by max_read_len to the
> amount of data that fits in the read FIFO, as the driver only drains
> the FIFO once after receiving RD_DONE. On current hardware this limits
> reads to at most 254 bytes.
> 
> CCI v1.7 and later support reads larger than the FIFO depth by
> generating RD_THRESHOLD interrupts as the FIFO fills, allowing software
> to drain data while the transfer is still in progress. When the FIFO
> becomes full, the hardware can also apply backpressure by stretching
> SCL and reports this condition through RD_PAUSE_IRQ.
> 
> Program CCI_I2C_Mm_RD_THRESHOLD to half the FIFO depth on hardware that
> supports RD_THRESHOLD and update the read path to drain the FIFO on
> each threshold interrupt until the final RD_DONE event is received.
> 
> Older hardware revisions do not support RD_THRESHOLD, keep their read
> size limited to the FIFO depth and continue relying solely on RD_DONE
> for completion.
> 
> Also emit a warning when RD_PAUSE_IRQ is observed, as FIFO backpressure
> is unexpected under normal conditions and may indicate that software is
> not draining the FIFO quickly enough.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

[...]

> +#define CCI_IRQ_MASK_1				0xc10

This exists all the way back to 8974, nice

[...]

> -	ret = cci_run_queue(cci, master, queue);
> -	if (ret < 0)
> -		return ret;
> +	val = readl(cci->base + CCI_I2C_Mm_Qn_CUR_WORD_CNT(master, queue));
> +	writel(val, cci->base + CCI_I2C_Mm_Qn_EXEC_WORD_CNT(master, queue));
>  
> -	words_read = readl(cci->base + CCI_I2C_Mm_READ_BUF_LEVEL(master));
> -	words_exp = len / 4 + 1;

GPT says: can we keep this check for the legacy case?

> -	if (words_read != words_exp) {
> -		dev_err(cci->dev, "words read = %d, words expected = %d\n",
> -			words_read, words_exp);
> -		return -EIO;
> -	}
> +	reinit_completion(&cci->master[master].irq_complete);
> +
> +	cci_set_rd_threshold_irq(cci, master, true);
> +
> +	val = BIT(master * 2 + queue);
> +	writel(val, cci->base + CCI_QUEUE_START);
> +
> +	/*
> +	 * Hardware supporting RD_THRESHOLD can handle reads larger than the FIFO size.
> +	 * The FIFO is drained each time an RD_THRESHOLD interrupt is received, until
> +	 * the final RD_DONE interrupt completes the transfer.
> +	 * On hardware lacking RD_THRESHOLD support, reads are limited to the FIFO
> +	 * size and only one completion (RD_DONE interrupt) is expected.
> +	 */
> +	while (index < len) {

GPT says: the last transfer isn't waiting for RD_DONE

> +		if (!wait_for_completion_timeout(&cci->master[master].irq_complete,
> +						 CCI_TIMEOUT)) {
> +			dev_err(cci->dev, "master %d queue %d read timeout\n",
> +				master, queue);
> +			cci_reset(cci);
> +			return -ETIMEDOUT;

GPT says: disable the threshold irq here?

Konrad
