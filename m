Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639333937B
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 05:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790054236; cv=none; b=ZIrSiqlw/HXzgFe8naPyUq8UUR+rV5r6ew/wxyA7rMXpRTOcwT3lcDurJoQNDJMEwVbr98jLNYB/B1VMJNwpCuQkQ2oqLR1A2zNizZk7OzSxInz8bB+7fDPBsiQA95z+EWKRro1/hjL92NuG1Jb/8u0SobAJeR4i5GHPRhER9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790054236; c=relaxed/simple;
	bh=cJ8LYFjzTM0muHUyVe+/MCjNYgwZO4f/9W0uzAKmrqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUc10j3Xp0bE1J4Gczyieyq8ZFns4QV1uJzTtMSs5ulW5SZY+wsTbih3Br2g5TeBQcuRNXpdaQcyAqVCpFqaCsNuruzHUqduMf93enmOYN8fpHjliC308Fvg8nyRF7o8XD6pn8SAKXbzgL6XtpDLirroSCvNZ7Ac0D67j011tys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VoNLgpnW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DzjpVvyL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoNLgpnW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzjpVvyL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790054232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
	b=VoNLgpnW0iP+P6i+oUby4bEh7uDA0nzjUFsPeVMuA3JBw8KBCv0sBJCxXnV8YMKx5q1bne
	dzTrfVbTZrvKAmz4u8pqtPmW+91zMNblpiQq8WKdcnEleN0BjAnwGb2u86+1GZXVfngDMr
	hTd6kaE4sLtsHrEVwR+pXNf/+cq73s4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-nFockeydNOyvkYjyl7hzPg-1; Tue, 22 Sep 2026 01:17:11 -0400
X-MC-Unique: nFockeydNOyvkYjyl7hzPg-1
X-Mimecast-MFC-AGG-ID: nFockeydNOyvkYjyl7hzPg_1790054230
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso27334435e9.2
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790054230; x=1790659030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
        b=DzjpVvyLQbK+J0ImsSVj1PjansFk16/JqKP32w3PPrU1bINsbMQmdK7+SyfZffEk/J
         t6tdkMzKdW/y8ZqJB9r96rLfk64KXhmRW/x1JZAAq9dTQLUsr4zx31Zoq6qVTbiDV1Ik
         FoTHXrXb3Wi6v+PgYFvSonlxFJcemzh8pq1b8rua2ZFGTNbs09ueCtEY+HVmw6mP5YGc
         H6jE9YI4VItFK/lFU3JuiG5Z+BTUI5UTAJ5g88i+VWTg/nBp5ssquVr77nuTN1Jv39r7
         2GtUib+sNsnt8POCZuOzZzLCWCNJvMgGDfgRLyw+eIiNVa09rFXzqmEQQVZ7yJnoCZ+l
         Bn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790054230; x=1790659030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZbjiIJwGtn50Qj/9ch4dBHBIATv1QNB49rzuobzPxM4=;
        b=v04h/XsJWxRddhzDGzd86a6Wbuwf+CPRHno9MkWzwEXn+7q5BwSQ9bwf4AagGnRTvL
         CwpYFv96vRNVLnH21q/0t4Qd9lyBT6YiLw7HNRoQHd4ERLciXYYhJl7rXMKB5Kq8Ygsz
         ACAmu6bzzboTfW9Xtdo6fHmyT4dunXWHRiWbXI4nf0ReV7kDFV60im9pCHpLks7q97LQ
         klEjSHjzZxmfmkosSwPpQKFvg9U0Ek/tgdGIB6fTBGewf3CuQLrcHQjutFK+NgnPP5iA
         QiPJ+Qi552Ia/ijPr6VTqOeKjZFdybh7MfZ+vdo2g+ctcnJm3WvwiQ8IK3oT+gyPyro9
         vaVA==
X-Forwarded-Encrypted: i=1; AKwUvBw3DY8TdtSUlPO8GwzyCGKKUzIz/prNxcppAWmiYNHmP3K/vfJa3iHysnF/ObSFhlFKJwcN84CG8RY=@vger.kernel.org
X-Gm-Message-State: AFuF++kNczV254lvRXKoFnDf8BwXUp91jy4gXNgvVcz9hbj1wbHFXfeZ
	BkgdoTV26IvqSyu6K+VqISFjLWGu6MpA5t9aN9s3bzPR4A6ckVuh7XmdnpS3Qb25Bseg2IuBASd
	ZvKi9Ng/ZDjYsGs00uojgCkmd9kMK1sHq+W/UvQDRGo2z2IHX8t4uqicIB2hjfQ==
X-Gm-Gg: AYBFou2lbaQnYeg3FNmd40tGWhdYk4ZN0fRTuOoyaRYFiaL6LDa816lU5+ZxztrRau0
	VNo7VAevNArA9au7DyXZF1Nhz1VDLMzy/yuNgRNTXqPUPtCzqOPSShp20UDRa8vloRzj2+RU0Pd
	YxILePFj0XqpyIqkfAtecU/ktzS4lWIv8T9VQ3kPtu0PnNsfakQamqP/clLh73nMsZanwLpASdA
	Bc9UrcyqB5npskWqLJtDVbxKXjEhS1+fBnYGC34T6AtFdKLRredQImExvVZdromiNWgbTSq+i+7
	bLuCt9N5wRmtR0UUDjUoyerGTNUHlcCN8UOucsrZlNMVoHxDZtbtd5qLjUlmY6XPPbW8RjS9q7Q
	5j8I2POPCUh+sQ1KnhOh6d5M=
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430385e9.5.1790054230087;
        Mon, 21 Sep 2026 22:17:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4f41:b0:49e:8191:e5cb with SMTP id 5b1f17b1804b1-49fc56db975mr194430075e9.5.1790054229668;
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8cc05f9sm44650175e9.3.2026.09.21.22.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:17:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 01:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	linux-i2c@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] Revert "i2c: virtio: Avoid hang by using
 interruptible completion wait"
Message-ID: <20260922011619-mutt-send-email-mst@kernel.org>
References: <20260922050251.403857-1-oss.patchbox@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922050251.403857-1-oss.patchbox@gmail.com>

On Tue, Sep 22, 2026 at 01:02:51AM -0400, Yuho Choi wrote:
> This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.
> 
> When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
> stops waiting for the remaining requests and virtio_i2c_xfer() frees the
> reqs array while the virtqueue descriptors are still in flight on the
> device.  The backend can then write into freed memory, and
> virtio_i2c_msg_done() calls complete() on already-freed requests.
> 
> Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
> exact same failure mode caused by timeouts, concluding there was no simple
> fix because the buffers must be held until the device returns them.  A hang
> due to an unresponsive backend is preferable to guest memory corruption.
> Restore the unconditional wait until request lifetime can be decoupled
> safely.
> 
> Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> A proper interruptible wait requires refcounting requests and bounce
> buffering to hold memory until the backend returns descriptors (similar
> to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
> stable, revert to uninterruptible wait first.

another way is ring or device reset, if that is acceptable.

>  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..581e55b5c65ba 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  	for (i = 0; i < num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
>  
> -		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> -		}
> +		wait_for_completion(&req->completion);
> +
> +		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> +			failed = true;
>  
>  		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +
> +		if (!failed)
> +			j++;
>  	}
>  
>  	return j;
> 
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> -- 
> 2.43.0

