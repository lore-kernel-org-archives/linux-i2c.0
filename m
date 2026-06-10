Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241637472F
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074234; cv=none; b=bYGDz4iaq74Bei0ZXaNKm7Fq5b3wLsKKLDoAw+ra62ZkrUlJrDjoj+ODU7fqfKeKf6w0xRKKxBQYIfPJyFKRWL7QU6cvOIvPNH2WbsqATI+oZrrZcGoXMoz3YTdK8n7MpgB6gg6rLxaptcy+gF7M9a7SjoYbHZcbebfpQwl1R4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074234; c=relaxed/simple;
	bh=5zbfRKvUMDiYGm7OudeEOu/ptLf1QQWwKAWAuLDKtvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZr7SilWKWO7VaWiNOv50XOGQQStANzgqiugLImCbVAq6oT8tUhfBF/RvrJhBxGPv7EIG+MF3ijS+31y8Aw7NXDFu+LSd1wlWyqyB7zEOLG2/3yn/JSXycsUcZBsTcB2ZKQop7VU7v4Ji6VClfWgKYSyAFtmJ8iC8eFPEvztxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCyETg+8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEOaZlAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCyETg+8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEOaZlAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781074231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QYek8+yL3O4Fxzy/c9PQif40Zszusm54JpxaZSHrzZ8=;
	b=WCyETg+8f9fb2J9RbWEvESR0rRQ239KkLmsQCePPnScTPxsayNMEM2EeDjyaPGQ7HSTw/g
	zTADp34b/33PDGJXnCkfAMTTSL5ywrrmvtYD1zuXKK0dm1VJtVUhICKL393/MB5B9Qj0aW
	Lrmm14SNCY2vS/jbl1HKdZliWXRY9ZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-JKy8f6pvNy6KBC0L_MaKbg-1; Wed, 10 Jun 2026 02:50:30 -0400
X-MC-Unique: JKy8f6pvNy6KBC0L_MaKbg-1
X-Mimecast-MFC-AGG-ID: JKy8f6pvNy6KBC0L_MaKbg_1781074229
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b9318944so45138175e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 23:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781074229; x=1781679029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYek8+yL3O4Fxzy/c9PQif40Zszusm54JpxaZSHrzZ8=;
        b=iEOaZlAkvrkBL3KRFU0xt6UiaLCWqK2VjzjOTskLa8T8gxBnxe8VqszCP1oDEEHTbE
         ulp/y+6R5b9Zl9ixwDu6XFJ42NHvcHzMDC39J99iGeuf0KUsH9Vmc5PfpOMsPoSf7lBE
         8+lKdAOb9oGo2WTVlgzODuXn8npLRDmPd82ouZUHs4RJzzFFAw72XHmYwevbJOJuBSnJ
         1Z0OGaaTlQx9inKuTM03ltFMEJ771Nwn+oX7wWAeFxNaUFfhUP6asuU5zRGMZYqhfYwa
         tE9Ymc6QbwPR0SEVaW2G/DjAnAv2YpzhdpYYBd0yJTpRol5OwxjkWoLOvkWwHd2giT6Z
         FSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781074229; x=1781679029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYek8+yL3O4Fxzy/c9PQif40Zszusm54JpxaZSHrzZ8=;
        b=dLzELOEENC9YX2w++bGXbV6+wQML1TKrIjkf0xhTyIGAhca2eRgLqHqy3kyIGdEfVk
         L4ngo1Z7rs/1DiRd56TqHquNNu3Q3Zf48l8qxV5DDSipnxtmKC+pNuC2FlWbyQ45CryW
         6WhVw4k8kGcyIoJSSq2Dhd5R9frc4a9m4Ro0SHIN+oF//hwAKgCc5WaN8f18ff20sAwU
         dnT/UyLag7QB/LGIxbcOy1UsxECRkh4Vr7UopfxDip9ivc5vs/CHtRQJabz4r3i2TggD
         6mkID7w0xXj5AsdAnXCyNSAilSkeQ/iLhaWOqruraUPBAm1DOBdtbBQyNZI14BL/imXj
         CFcQ==
X-Gm-Message-State: AOJu0YznuratqHyb0Uqn5PC0bP9Rxm9cIYiWMvxazs+iPl6CCillqe1s
	Uyg4Qx/YEkd5+yF30QIW8gbeql5SHSf5ZLIRdbvInUcBbkSXKFZWeATY3c6mle27Gu5FYBKhXt6
	rzgZnN7M852LO3EKJ2OmkIeOQu7rBjBdjhHlwLOy6ZBhRKTdA76RzsG1O6ISBeQ==
X-Gm-Gg: Acq92OGT7GnO+c2pqhW4s5W3AplvtI/rMF8rzlmitPt82q41442vEhOk0uii6KxhOR0
	fD+1a6DdIoipI25SAHx3m1PNOGpo6S1rsTmolJWLJtFellmJ/3GvYZY3yzno9f3V3miWHgG71rd
	MXdYgGoCAMAImvxbL0f0ktG8Io8wZbK7kDDZbfCkHobhMGf5lSuBsfUYjGy3TBj05wAytpL+ays
	EtIcpLHluaUKp7mbbS5wOKZDGdjjMOND5TTiL0g7PYGGY3YR4XwAneMnNCpusu7+wAqbWZqFFOM
	bSCMu6luvLr3Tf4Ki+iedR7Kbqfw9HIJjt05K0eCsYOUM5rKrl8Vg0DpAdvZT1h93DZ1E76ZgNb
	Sx8MtjoJAXWequ2PV2mk45sZPfMY26bn5ZBq/R24Z52gshjlmjRopew==
X-Received: by 2002:a05:600c:34d6:b0:490:ccf2:6dca with SMTP id 5b1f17b1804b1-490d7223706mr69112825e9.20.1781074228552;
        Tue, 09 Jun 2026 23:50:28 -0700 (PDT)
X-Received: by 2002:a05:600c:34d6:b0:490:ccf2:6dca with SMTP id 5b1f17b1804b1-490d7223706mr69112245e9.20.1781074227533;
        Tue, 09 Jun 2026 23:50:27 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm543379695e9.6.2026.06.09.23.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:50:26 -0700 (PDT)
Date: Wed, 10 Jun 2026 02:50:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v3] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610022437-mutt-send-email-mst@kernel.org>
References: <20260607143608.76122-1-gavin.li@samsara.com>
 <20260609134358.36583-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609134358.36583-1-gavin.li@samsara.com>

On Tue, Jun 09, 2026 at 09:43:58AM -0400, Gavin Li wrote:
> commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> completion wait") switched virtio_i2c_complete_reqs() to
> wait_for_completion_interruptible() so a stuck device cannot hang a
> task forever. That left a use-after-free: if the wait returns early on
> a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while the
> device may still hold virtqueue tokens pointing at &reqs[i] and DMA
> into read buffers. When those requests complete later,
> virtio_i2c_msg_done() calls complete() on freed memory.
> 
> Waiting uninterruptibly for every completion before freeing avoids the
> UAF but can hang the caller indefinitely if the virtio side never
> completes the request. The virtio spec provides no way to cancel an
> in-flight transfer, so that is not an acceptable tradeoff.

except for a queue reset, or a device reset if that's not
available.

> This commit manages the freeing of the xfer allocations via kref, and
> ensures that each in-flight request holds a reference. This fixes the
> use-after-free by ensuring that the virtio device has a valid location
> to write to until the request completes. This will cause a memory leak
> in cases where the device hangs, but that is much preferable to memory
> corruption.
> 
> Additionally, force usage of a bounce buffer even if the i2c_msg buf is
> DMA-safe, since the buffer passed to the virtqueue must remain valid
> even if the transfer is interrupted. Remove usage of
> i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
> This results in an extra allocation+copy when I2C_M_DMA_SAFE is used.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>

It's possible that copying unconditionally is the best you could do.
Some vague ideas below but it's possible they are not practical.


> ---

pls start a new thread with each version, and include a changelog there.


>  drivers/i2c/busses/i2c-virtio.c | 110 ++++++++++++++++++++++++--------
>  1 file changed, 83 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..7ee96b08f6685 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/module.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
> @@ -31,39 +32,72 @@ struct virtio_i2c {
>  	struct virtqueue *vq;
>  };
>  
> +struct virtio_i2c_xfer;
> +
>  /**
>   * struct virtio_i2c_req - the virtio I2C request structure
> + * @xfer: owning transfer
>   * @completion: completion of virtio I2C message
>   * @out_hdr: the OUT header of the virtio I2C message
> - * @buf: the buffer into which data is read, or from which it's written
> + * @buf: bounce buffer for i2c_msg.buf, set to NULL upon free
>   * @in_hdr: the IN header of the virtio I2C message
>   */
>  struct virtio_i2c_req {
> +	struct virtio_i2c_xfer *xfer;
>  	struct completion completion;
>  	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
>  	uint8_t *buf				____cacheline_aligned;
>  	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
>  };
>  
> +/**
> + * struct virtio_i2c_xfer - a queued I2C transfer
> + * @ref: one ref for the caller, plus one per in-flight virtqueue request
> + * @num: number of messages
> + * @reqs: the virtio I2C requests
> + */
> +struct virtio_i2c_xfer {
> +	struct kref ref;
> +	int num;
> +	struct virtio_i2c_req reqs[];
> +};
> +
> +static void virtio_i2c_xfer_release(struct kref *ref)
> +{
> +	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
> +	int i;
> +
> +	for (i = 0; i < xfer->num; i++) {
> +		struct virtio_i2c_req *req = &xfer->reqs[i];
> +		kfree(req->buf);
> +	}
> +
> +	kfree(xfer);
> +}
> +
>  static void virtio_i2c_msg_done(struct virtqueue *vq)
>  {
>  	struct virtio_i2c_req *req;
>  	unsigned int len;
>  
> -	while ((req = virtqueue_get_buf(vq, &len)))
> +	while ((req = virtqueue_get_buf(vq, &len))) {
>  		complete(&req->completion);
> +		kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
> +	}
>  }
>  
> -static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> -				   struct virtio_i2c_req *reqs,
> +static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
> +				   struct virtio_i2c_xfer *xfer,
>  				   struct i2c_msg *msgs, int num)
>  {
>  	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	struct virtio_i2c_req *reqs = xfer->reqs;
>  	int i;
>  
>  	for (i = 0; i < num; i++) {
>  		int outcnt = 0, incnt = 0;
>  
> +		reqs[i].xfer = xfer;
>  		init_completion(&reqs[i].completion);
>  
>  		/*
> @@ -82,9 +116,16 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  		sgs[outcnt++] = &out_hdr;
>  
>  		if (msgs[i].len) {
> -			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> +			/*
> +			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
> +			 * buffer is required because the transfer may be
> +			 * interrupted, after which msg->buf is no longer valid.
> +			 */
> +			reqs[i].buf = kzalloc(msgs[i].len, GFP_KERNEL);

is len always reasonably small?

>  			if (!reqs[i].buf)
>  				break;
> +			if (!(msgs[i].flags & I2C_M_RD))
> +				memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
>  
>  			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
>

maybe there's some way to hang on to the original memory?


  
> @@ -97,38 +138,51 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
>  		sgs[outcnt + incnt++] = &in_hdr;
>  
> +		/* This reference is released in virtio_i2c_msg_done(). */
> +		kref_get(&xfer->ref);
> +
>  		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
> -			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			kref_put(&xfer->ref, virtio_i2c_xfer_release);
> +
> +			kfree(reqs[i].buf);
> +			reqs[i].buf = NULL; /* prevent free by virtio_i2c_xfer_release */
> +
>  			break;
>  		}
>  	}
>  
> +	xfer->num = i;
>  	return i;
>  }
>  
> -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> -				    struct virtio_i2c_req *reqs,
> -				    struct i2c_msg *msgs, int num)
> +static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
> +				    struct i2c_msg *msgs)
>  {
> -	bool failed = false;
> -	int i, j = 0;
> +	struct virtio_i2c_req *reqs = xfer->reqs;
> +	int i, fail_index = -1;
>  
> -	for (i = 0; i < num; i++) {
> +	for (i = 0; i < xfer->num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
> +		struct i2c_msg *msg = &msgs[i];
>  
> -		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> +		if (wait_for_completion_interruptible(&req->completion))
> +			return -EINTR;
> +
> +		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
> +			/* Don't break yet. Try to wait until all requests complete. */
> +			if (fail_index < 0)
> +				fail_index = i;
>  		}
>  
> -		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +		if (fail_index < 0 && (msg->flags & I2C_M_RD))
> +			memcpy(msg->buf, req->buf, msg->len);
> +
> +		kfree(req->buf);
> +		req->buf = NULL; /* prevent free by virtio_i2c_xfer_release */
>  	}
>  
> -	return j;
> +	/* Return number of successful transactions */
> +	return fail_index >= 0 ? fail_index : xfer->num;
>  }
>  
>  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> @@ -136,14 +190,16 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  {
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
> -	struct virtio_i2c_req *reqs;
> +	struct virtio_i2c_xfer *xfer;
>  	int count;
>  
> -	reqs = kzalloc_objs(*reqs, num);
> -	if (!reqs)
> +	xfer = kzalloc(struct_size(xfer, reqs, num), GFP_KERNEL);
> +	if (!xfer)
>  		return -ENOMEM;
>  
> -	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> +	kref_init(&xfer->ref);
> +
> +	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
>  	if (!count)
>  		goto err_free;
>  
> @@ -157,10 +213,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	virtqueue_kick(vq);
>  
> -	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
> +	count = virtio_i2c_complete_xfer(xfer, msgs);
>  
>  err_free:
> -	kfree(reqs);
> +	kref_put(&xfer->ref, virtio_i2c_xfer_release);
>  	return count;
>  }
>  
> -- 
> 2.54.0
> 

