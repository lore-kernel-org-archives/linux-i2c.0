Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F0371878
	for <linux-i2c@vger.kernel.org>; Wed, 10 Jun 2026 06:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071392; cv=none; b=fhosRD4Cn2KP52Iqm47/uIuQdaQ5r68pyHa9+sAG2oe8KMTggXGMEirC5xu5FNxDuUF07a1Py+o1piZ5o3kJknbeDkQT3GJdhg15iOIP+GWLcBrgxgoiCksST+CwydB97sxAmR88pj62e9h1E2sVKBORk7g2vBo1ab51oucG1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071392; c=relaxed/simple;
	bh=pw88L/ouDyuHyWNL2/y8YiHC2YxgRVKO24sWCq/8McI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvUsXFz2mk4XWaQ0YX8C9TxQa0wvRi0JsGmrtO26ATajedovbEdxc7F6dX4Zfbp9Xwdmco4NhALJgasbXWYw4HNXf0Fdp1OnpsKkqs7t8bNSNjGuzMQYCJ+WJshGKPLhRLTtyPWnzr9Jk70ZkiGUHrge/0Ksup2P7XbEjMpYJpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxJ19J1A; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxJ19J1A"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-842338c18e0so4449839b3a.1
        for <linux-i2c@vger.kernel.org>; Tue, 09 Jun 2026 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781071390; x=1781676190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yk7RSWHHdbxWdBcudFPBcLz7KkZ0UbwwurunM9RMroo=;
        b=WxJ19J1AJdBjA+C9Zs3NZ7T3RUfD7/LnELTBFDTVR6VBth3ItldEHm6NWbYAi4qLmp
         zQGX6ryluTKOc/uAMTKvbOBPaAY4TE8b1OumwRv70Tq1mmaqamkKl1aihDlJmxlJpCAQ
         qFGcKFS0Hf1+cQ8BpZtf+irfvlu+tvAvuvrmMEjZ/ZhFz499CRLdjknn0sbK7ioexGCg
         LygOMAT8cgxHsv+8g5HJMEO3V3y5A3MklKbxRZjrqKNBa83U2xCHsZ9zXCRPYTjE4eMK
         B8a6j3dgJ/CSSjX3iV7j6NC81tEAGrtj3D4/5QWAZFz7ttarjFMWFW0YikJv6bzVCeMx
         LDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071390; x=1781676190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yk7RSWHHdbxWdBcudFPBcLz7KkZ0UbwwurunM9RMroo=;
        b=M23bummPIKr3U2dhFjHQr3dSvgUytmRMtqtasgiccQSqZXmPlTCEOqo2pwo+v9okSW
         1XzoxExvsljrlTyh1rX9zzDwZcQcHPvgALdyVoH/J0NIG/qdIXBC9e/bGHiNc/L9zHwO
         Xkh8gP+d8K/yWESYmY4fifdl9nyqtI/w+K7A+0V8ipyrQdM7l3KtvQz1zv0zIAv2P3Wp
         LNAxTPRP4SixoUEi5EGCmExfAt5C8f1j+4DUDz+Pfu9Zgza8qwg0t9E1PvKXKM+oEPeL
         hYevIbwZutSHGmrd6QkESca35haVoUjGHsWOcGJxhyBJ0GByHoALtQEaFUgnHZFeHqmP
         Y/Sg==
X-Gm-Message-State: AOJu0YzZ2mUzjhBGL8NJhg+5buVt+vNjZqFmgCKRvqnXOOfDWfnxj9Fx
	X+W7Hqc77rEb4/NJAkeFp+TtOx9S/KtBkReyI4mYrLzoVc2yyoGGHSdSzya6VxnoaBE=
X-Gm-Gg: Acq92OFevhNnFooXuW/eQuCrWEoaMe1cVJO68ERRmjakxCgYXTm3A2h2BC4aegD4n5j
	29rU7F+fpWLsjfJOgNkN/h8GxVXDmrPLkqZPqRqXUW6zlKLFmLuNfoaGicMga2ui76m7PLvV543
	f1OkHf1g5GCYk1MYpsy3/ssj6HzmBcwA9h5e1r/0pKpVXaEjbRgDS6/KnkqLHGybimL/1qv3HBt
	fX1jZVVloo13ytEEnGHPjLMb3F7L+ZbzpxR0YzRBAh2cyiky5D0ngHg+N4HyjzfLYDPz4opcaJN
	GRkzpsVu959A1n/ZOThqXlgxBZmeozJK+geGuc0Vzl9y2JTU5/L/M5r4vYtuIgoa1dccUwupqbr
	4Qb1SFgfoePzeQypWRN1o+OzUkvSoMViLpRgGVHU2W+skjE0p11mf5B/aME2TSZfqVJUivLAExo
	FHw95MT5msxxcpXZJmo8Tt9JiovfvFa2n4XA==
X-Received: by 2002:a05:6a00:4b55:b0:842:5da3:9b8c with SMTP id d2e1a72fcca58-842b0f94b60mr24102426b3a.36.1781071390457;
        Tue, 09 Jun 2026 23:03:10 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828fa877sm23675026b3a.51.2026.06.09.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:03:09 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:33:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <sw3omsbthxztl7p237jp2hamdxhauulh6nadlaefkms73qwbgj@2afkjcqrwbez>
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

Ccing I2C/Virtio maintainers.

On 09-06-26, 09:43, Gavin Li wrote:
> Additionally, force usage of a bounce buffer even if the i2c_msg buf is
> DMA-safe, since the buffer passed to the virtqueue must remain valid
> even if the transfer is interrupted. Remove usage of
> i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
> This results in an extra allocation+copy when I2C_M_DMA_SAFE is used.

Please always create separate patches for such changes. It would be better to
not fix multiple issues in the same patch. That would also allow for a clean
revert of the change, just in case.

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
>  			if (!reqs[i].buf)
>  				break;
> +			if (!(msgs[i].flags & I2C_M_RD))
> +				memcpy(reqs[i].buf, msgs[i].buf, msgs[i].len);
>  
>  			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);

I don't think this is acceptable, bringing the performance down because the
remote device may misbehave.

Maybe its time for I2C and Virtio maintainers to provide some feedback here.

-- 
viresh
