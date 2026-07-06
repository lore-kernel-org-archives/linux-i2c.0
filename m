Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46543A9D9B
	for <linux-i2c@vger.kernel.org>; Mon,  6 Jul 2026 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783310942; cv=none; b=BPiaemTyQhWjjXBofKAniyet/b+DLp2EA1bjh+WSVv8EBqCMHmjKmfP6C1Lu+c0e7NDuZ49oxdX49glLV0fIlevvvQIZvm0JGcEYMWgbNTjKdSV7va28b3mgZfSQUBJHhnhDm/4L1777WIkw01XLcFzl7UMBtIY/03y4494CMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783310942; c=relaxed/simple;
	bh=gesLhmjDATHcNmyKwVTHjKEW+LBwNmx7XQdwBmxHfxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQYLsmQ3LqPhcSWdWmrb0m/u4sAETubjN1RVJuRcr2+vd7yiG2J4tKtE6lIeeKow7WjjM3uYnNWefx1D0Kuty+ORXImFAwfzEq/EKXmLuVZtQHv+lEZzFGSimrPEXpqv+0SwHurPDWO3HIiYmdtL/UIMpj1tGqc9nN8SvEIDMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIOHVYTK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIOHVYTK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so1969519a12.3
        for <linux-i2c@vger.kernel.org>; Sun, 05 Jul 2026 21:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783310941; x=1783915741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUpTmSp9slqIVLS0De2fE7WAIj9ccgm7yyep1NzPYZg=;
        b=MIOHVYTK8/DYR8x6S011sFuLv/9Ovy1S8AJHtt0x3FKvJgNfcbdhltRg2tvH4rP94d
         mkj3AnFLubwpMW/q+NOK+8WBHYJi38lK9Y9rax6zMSt0/mo10DJ5ALz3MyhVSvEuDkQn
         xckPMftLYPma3xezt5IvwKUdR17Lv7gUE0vDGPSJwJY1NhFIUuTlAdwORw6Kn6yR+Fwv
         I9aEUn7Eol3HWXQJgAhx/YjWWhZG22G5RTMOxQ3RNFXx3nF0cnWO09jHSrzA5kSdMl8u
         KG25SQNPAZgRtxFRtsISM9cIp+72PW9di1RcFnRAt3iTKFVvMgbX0d1oKnogbbw1EU5W
         UodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783310941; x=1783915741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUpTmSp9slqIVLS0De2fE7WAIj9ccgm7yyep1NzPYZg=;
        b=afbWwtChFS6JWHKC9/UvXKFoLno9iKTSIHgyb3N343mGf5xnFxAIUgzWZPfNx0eCbA
         OT2AXsq91/1o49EEgfok3UdpQES0I/T5nujFJkf0f8CLLg48Uvua0J3xOtbl8H4CbOwP
         MCDw4bhmZGuhWx3Qqjs9dqwAz/w5HdfUCdinYRtSZ5Zib6/cbZPX5uASrl4xByMM2I3a
         ctm65CXfLML2ZxrXs2ymGFbbibyaPV5HFQUn3SVvGLbQcyOYxjjnEkwjUcOwRpxEzS9b
         jISqgLdTITH/GAmJSozlVT7xCkB2TChIYvnuJAG6feqMI8BSfJ6oM53ob//uOXyr2Mc6
         3qkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDVKZ9BMrFNbyrAHeKmZ9TH1abTMG00krWiQIauRV0QAqA7xke42Hm1FIVs3VN2g1eu5Bwl80NEoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffHoReKnjdYAt5JyER7kWMW/jzpQQGL/4LhQw8z77r37lYVkt
	Ap+BHFYwAcSvaga0sVvWEcNa+hWpHNWR/mQm6n1dnKwNeB8t3uyeLUxjPM81Y/z+6/o=
X-Gm-Gg: AfdE7cltiXqRqVKGfc/74fWQRL1x5TtT+aAXfP0UfRCDxuLM/Ts0ON61s49pSXPDjZ7
	oEUIqPVcgPTDkKmhaH1MaTVV5oU2OrnLNFvI2TJPF7iYY1nArKhV5kVbuFpjxZarpePxyhDfakd
	H86RBGVy+EFgcgvaeADtQNv/4jguo1xgk6f9rbIRtzksFHH5jeqIBBj2AUdX7Pkxzd9lzIwENQr
	ILVD4gxT7FZHp6Cvwg3wSmiP5UUCVDQyRFw0ytfpLCNrP2dzyCqrtV8QYLPa2Q9Wr9RRLN9lP8U
	3YAlQrPKamdZ+p7KI05lVPj2UX0458rwVSMzCPcfiq4tyhqu/ZDi9xjQ8cHhOUOa38R0UOTJBQp
	mxb/C13UEsVz7Ff4pveSBX/ajCU/QtUlcqcHPX3/33OAtjCFBw+HuyCWtRxK7YzjnOXpgkX6G/3
	hci6LIp+JNGEv/
X-Received: by 2002:a05:6a21:310e:b0:3bf:9fc0:f6c2 with SMTP id adf61e73a8af0-3c03e18bc01mr8997778637.11.1783310940716;
        Sun, 05 Jul 2026 21:09:00 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc2e119sm48016654eec.28.2026.07.05.21.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:08:59 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:38:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guangshuo Li <lgs201920130244@gmail.com>, 
	Gavin Li <gavin.li@samsara.com>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: virtio: Reset virtqueue before freeing interrupted
 requests
Message-ID: <krqh3ya6km5g43tp3nmtq5n6liwghilfsvzrsyh7zdywtn23of@5iztbohhsxfg>
References: <20260705155925.292765-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705155925.292765-1-lgs201920130244@gmail.com>

On 05-07-26, 23:59, Guangshuo Li wrote:
> virtio_i2c_complete_reqs() waits for each queued request to complete
> before releasing the per-message DMA-safe buffer. The request array is
> then freed by virtio_i2c_xfer().
> 
> After wait_for_completion_interruptible() was introduced, the wait can
> return before the current request has completed. In that case, the
> request and the remaining requests may still be owned by the virtqueue
> and may still be completed by the device later.
> 
> The error path nevertheless continues to release each message buffer and
> virtio_i2c_xfer() frees the request array. A later device completion can
> then write to freed request memory or call complete() on a freed
> completion object.
> 
> Reset the virtqueue when the wait is interrupted so that outstanding
> buffers are recovered before the request array and message buffers are
> freed.
> 
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec..6ef09eda3ed0 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -117,12 +117,19 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  		struct virtio_i2c_req *req = &reqs[i];
>  
>  		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> +			if (wait_for_completion_interruptible(&req->completion)) {
> +				/*
> +				 * The remaining buffers may still be owned by
> +				 * the device. Reset the virtqueue before freeing
> +				 * the request array and message buffers.
> +				 */
> +				virtqueue_reset(vq, NULL, NULL);
>  				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> +			} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
>  				failed = true;
> -			else
> +			} else {
>  				j++;
> +			}
>  		}
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);

+ Gavin, who was also trying to solve this path recently.

https://lore.kernel.org/all/20260610155834.79207-1-gavin.li@samsara.com/

-- 
viresh
