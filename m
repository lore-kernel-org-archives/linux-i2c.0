Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111508;
	b=RcmLykDSrRjyUYwGDekAPs/2+lsiM5vxCKgAnN0pYrtMWNoG9ujPLVh3784b7hVqmI2c
	 gYY5szTQZsDIUjTXD0nalg08DggjNvZncO2qnZoudG5T/JpGggo5cFP8kNNOWceHdgwE+
	 l+die7qZrMGN5YqR9L90ygoPIyjAIm/Gr04XSGLdgQ0WS4mJebXNgbLrAeqqawe3pbJSh
	 UAxqbujRPFcb7zK0jzl0DYMTiowRU221c7A/E9azpiKJQyQWzCppibGzZ9S/H+n501A2h
	 pCj4/HTVl+P4PH5znon1qqUsiPFee4fjF1B25BfU32bSomJ8WjF89X97FjsTcRPKDLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111508;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YlwVcIUY8gMD3eqih4RJVxsvUcuNodLGMkC2yTuphK8=;
	b=KW82o+CsuDwl4Nv6yTzht0AnNaapdTyha7KQLGr7XUCWNOlvFLjGzsPiHqCI5vwKu3v+
	 qPw6CWnXZmzNGHbaJdJobGmhfkJp7BjZjG84atz99ajJqbq8jV5zM+s8CfUOtUlPnomrk
	 EHDazzA65MVg16oNiKGOSL/Sk44gdi4QobLIzwvpt/ACab0mSM0uAXYv7fSfFN1p6QE3z
	 ETlwyvSo9FYNGT//Tl3ycmmOIInKlCJEXvr2/aOzmvEHWwjjUNDrCkCqndOE8rbuK4Idg
	 b/4ras7ahMrfPhz0L6LgHFuj5EUuty2ydIU75anE4QLKRnwVcZN+Fkdp4ogRQqVuJnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i+rtoxO0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FDFQzwcs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B48606A323
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i+rtoxO0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FDFQzwcs
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDoZR91850905
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YlwVcIUY8gMD3eqih4RJVxsvUcuNodLGMkC2yTuphK8=; b=i+rtoxO0Noy20qKm
	uYJ5YCbW+8Se7Z5KqAT+4MTHNH7Tk5vnE+7P6LhYkSFvvWTwpU2OMlZhuyekZWkM
	MdePTZiVPh0iXmOWlx3tfH6tCdqcZCr45Y5I6vNFMQkFdHMucSNsjajaCSXDe5uA
	0BLEd9gHtBOWQH8CsEpx8uzBl21U2QcSAg8NqTqbrtjND5KjrzTWnyQtIJbQvwpb
	tt52HCsZd5gqChQeQLy6RIvtWiNvooN0NhzvA+RvOZlVgZiLh1+EMwcjlw4zz7a+
	EnAJJVZpPtJcFKKkeDGujrHGXSVVO6cZjiRLxo8liKqrd5HUH/G6vqw55CNKZG5D
	8qXoSg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmc3f6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 14:31:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e941532594so46726955ad.3
        for <linux-i2c@vger.kernel.org>; Tue, 27 Oct 2026 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793111506; x=1793716306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YlwVcIUY8gMD3eqih4RJVxsvUcuNodLGMkC2yTuphK8=;
        b=FDFQzwcsVN+VQyVMwEc0zOwbZJJmVWYg0F7b2ToVFIY4g0BPtv7kdNxAjtiStWJMV+
         Y3ZQsG0Vg3FKcICRWK3D3qCxZWjUAI5hhI/BGIYTM4Pf4xz/o3x5LiZLoEBY9NDn08Tr
         WBdQwvJwTIi/qmBHG6FZRWK/W7B89d0IM28Z+DZhb15BCrzKaDQtOVxaKmZdaPZCg9Xj
         fVVISTWl28PEocWpF1EqGbNNSHLMawIqgHdBkD3KUT8AAkU8Jmu3AHOtkIJj9/NF4KVy
         YJLogtJPJ3R/ypf+GIzycEc9uoWTB/jhgsvTuCT7xwsaxD6y7R2eeIAwUIOR9KUuorfl
         nH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111506; x=1793716306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YlwVcIUY8gMD3eqih4RJVxsvUcuNodLGMkC2yTuphK8=;
        b=UHJON7m1PItAhB4ue4eJJgI77XjM/btH1ZgZUCFZj7OuAj/XSPONwh7JfSlHojhfPd
         xqnNWIglR5TKPFqJlYcukG/fBhclC0xbZgkwBUI1IqNV1hi9sf66H5n9Opad6fUkR9qC
         HYrKzuXW2IUseD4LwSIYU7Kc/1Iav0RoSvyZ3PXwlVejfONxgaEpX6IHmccZrdIvCSAe
         /u/F6S8hFL+egGprjlhlbJ+DCc4E6yT+PmN8X5SyN4uCSU8bOeclLczplvGRWQo8NAc7
         BAOo8zxMRHBdCbmyutfkY+I/kTdJfDbfEB5g9/SD0//7R5fmUCypr8uPQ3Xko1cWNl5O
         xvlg==
X-Forwarded-Encrypted: i=1; AKwUvBx/D98Nt20wtnUpO19OrVmZOvqB8eTQVxwwuSN+LDxn6KI1dy2N6nQsPsOPP+lfarlxsIaVgFtp8qM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUAaBPrsBL01gyHus6lSKTHtB3dkRZfEVRGF/dHaj+zBa1xfl7
	4zR5+ID4tJknPtUPAND2PA5yCikLMKFGYmqPbj+bs3HWeW14Poxsl42aUXFauioivlo9Ivr6nw2
	b7x4CAmkHINBdSpPs/31e9lp1CNVx3w0yAqwAicy8E3igV69P1/AOCL3VbeZbK9M=
X-Gm-Gg: AYBFou2jRJVhWrk+7i8oHoFoSBda7f0bsIdFHueWQsv4kwfpddXn+nem/8Qe5YUTvgf
	Wpehva+nw3Wpmx80Slz/cxfFzO52QikDXL4vVSR+/mJyImteVCpdsh7HN8D+0zwYva7kmnGWYT0
	bi4jMrIy+mcLUCXKXtkT+9oXct2sfzrDrSpazzYa7qal62nsZvXt2Db7noPMD70eLwp2k93lBu8
	/BPQGv29dcUCG4VMxyjZQT5eFHLpq2tFFc5BD0uPyISpaYWwkk7RMVI3sui/jNa/tAN0sRhU8+g
	pO3lHGlMkWFKUGdT/pl/FGZ30mpcWl46JJhTmsw5Q8O/XB9SZaN8OyPcjT+qjUHbHDjGYSoNFD2
	NrsuBHrDehzZu7dcpfCEDAY6dAvu8eTG4
X-Received: by 2002:a17:902:ea12:b0:2e9:64b9:a332 with SMTP id d9443c01a7336-2ea9c68c8b1mr90167205ad.15.1793111506191;
        Tue, 27 Oct 2026 07:31:46 -0700 (PDT)
X-Received: by 2002:a17:902:ea12:b0:2e9:64b9:a332 with SMTP id d9443c01a7336-2ea9c68c8b1mr90166425ad.15.1793111504651;
        Tue, 27 Oct 2026 07:31:44 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6454a29sm10749995ad.9.2026.10.27.07.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:31:44 -0700 (PDT)
Message-ID: <b88efeae-6041-4189-a559-a16be07450bc@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 20:01:39 +0530
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
Subject: Re: [PATCH v3 3/3] i2c: qcom-geni: Add bus recovery support for GPI
 DMA mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: naresh.maramaina@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-0-7f2a6e572de9@oss.qualcomm.com>
 <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-3-7f2a6e572de9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261027-20260826_aniket_randive_oss_qualcomm_com-v3-3-7f2a6e572de9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfX7+W2uuvleTLs
 PY7kXT+eJeOCRQGo8O0By7C66BiM2Z3UmwVvPdg5bAt78PUAkGRi2a6c9r0ejtYm+4pz4bVJvVz
 Py+fBwlGFwVzEKM8bL6Hog2Mg65KS34=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NyBTYWx0ZWRfX0oxija0pOKF8
 0Ks/yTiZCX2ALEDrH1z43u270xnxMmxXYjqnXO4Lb2TdYVgvkL4GqXI1HN/0pSLHdD18WtnRvtT
 z+GILUNuMyniczIpUUtoPN57xJrJ+B/nV2vIH+gcAzqCaDJ7B0wDGuw2DIJKsZWBDvBbpoL77Oz
 MsDrRGhs7KRSwcTBmcmAj9Smk/QAifox+xtCT5LE/eYQfD7/8xcsHeooorjoz4ZhAJEm0y/VZVx
 EbESTTJOoz9870S1kg0GkTkGXEHfyfE2AxkKy7EtJuWoyb5lHbEOypKDJHP+0AzxdQOV+tVcyFM
 051YYrPbSHz8u3Yhmz/bFT6dG78c2ZQKnDKalFFHtTue8uM71+VEFV3m6Ja9sZGtrrLFa5icV3P
 81INYZDOToxm0sZztoCk3qsT3UT4Do1Q1vu8qsonECHs7Zx/46JoclE0nnTJ6lm9YSeph6sPsEs
 rsjlToj9jP5vcjG4bcQ==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae0b5d2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ee05V1XPiC3bpTzN_coA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: yI1IoCaNfYa16Em0zfxBzJxQ4fkNv9Zs
X-Proofpoint-GUID: yI1IoCaNfYa16Em0zfxBzJxQ4fkNv9Zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270057



On 10/27/2026 10:43 AM, Aniket Randive wrote:
[...]

> +static int geni_i2c_gpi_bus_cmd(struct geni_i2c_dev *gi2c, enum i2c_op cmd)
> +{
> +	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
> +	struct dma_async_tx_descriptor *desc;
> +	struct gpi_i2c_config peripheral = {};
> +	struct dma_slave_config config = {};
> +	unsigned long time_left;
> +	unsigned long flags;
> +	dma_cookie_t cookie;
> +	int ret;
> +
> +	config.peripheral_config = &peripheral;
> +	config.peripheral_size = sizeof(peripheral);
> +
> +	peripheral.set_config  = 1;
> +	peripheral.pack_enable = I2C_PACK_TX | I2C_PACK_RX;
> +	peripheral.cycle_count = itr->t_cycle_cnt;
> +	peripheral.high_count  = itr->t_high_cnt;
> +	peripheral.low_count   = itr->t_low_cnt;
> +	peripheral.clk_div     = itr->clk_div;
> +	peripheral.op          = cmd;
> +
> +	ret = dmaengine_slave_config(gi2c->tx_c, &config);
> +	if (ret) {
> +		dev_err(gi2c->se.dev, "dma config error %d for bus cmd %u\n", ret, cmd);
> +		return ret;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(gi2c->tx_c, 0, 0, DMA_MEM_TO_DEV,
> +					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!desc)
> +		return -EIO;
> +
> +	desc->callback_result = i2c_gpi_cb_result;
> +	desc->callback_param = gi2c;
> +
> +	cookie = dmaengine_submit(desc);
> +	if (dma_submit_error(cookie))
> +		return -EIO;

Rather capture ret and return it if it's an error ?

> +
> +	/*
> +	 * cur and err are shared with geni_i2c_irq() and the GPI callback
> +	 * i2c_gpi_cb_result(); both write err (the IRQ handler under
> +	 * gi2c->lock). Reset them under the lock before issuing the transfer.
> +	 */
> +	spin_lock_irqsave(&gi2c->lock, flags);
> +	gi2c->cur = NULL;
> +	gi2c->err = 0;
> +	spin_unlock_irqrestore(&gi2c->lock, flags);
> +	reinit_completion(&gi2c->done);
Safe to init before dmaengine_submit().> + 
dma_async_issue_pending(gi2c->tx_c);
> +
> +	time_left = wait_for_completion_timeout(&gi2c->done, gi2c->adap.timeout);
> +	if (!time_left) {
> +		dev_err(gi2c->se.dev, "timeout waiting for GPI bus cmd %u\n", cmd);
> +		ret = dmaengine_terminate_sync(gi2c->tx_c);
> +		if (ret)
> +			dev_err(gi2c->se.dev, "DMA termination failed for bus cmd %u: %d\n",
> +				cmd, ret);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return gi2c->err;
> +}
> +[...]
