Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AE337B99
	for <linux-i2c@vger.kernel.org>; Mon,  8 Jun 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890278; cv=none; b=GM331BWfpE1nZC8rmOgwBGJ/Qm1M94q0MTHtlslokImTRKiCP3PU1e7slrC14hJC1DJTJJ89ZX/cHFzRBhdG1/iY4ckbQX1Knj4bnQYHqSbWJVIzi6OwpZlSEnhwR94LHL1qXt1esChM2AdxtGwLamKUkD4xhgJGEDIfoejF+S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890278; c=relaxed/simple;
	bh=x/jE3WkInHWhOYnc0mIGEzA3lMatPTNns944BHfelV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+jUWv8t1Kh6xSmeRBOTOPsmjt206GlM4rtRPTEHxCAh41dt/s/gGRg70oe8AK5j+P9xTSPRRAKMEUzvoV/xy9IY7q8VXhpaKOLZUM0MS/BgyHwyWDTwLcXmNjnJ8XEGpHJ2tT/GZPQYQ1KQvFY2ynWZBvNjCQNKTP9vySh7s6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wh1L/78r; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wh1L/78r"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84236f9b638so1637679b3a.2
        for <linux-i2c@vger.kernel.org>; Sun, 07 Jun 2026 20:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780890275; x=1781495075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2lKo0muPPjvxZp63cMcIf07S+igkG9mD6vGKVSxOx8=;
        b=wh1L/78rlna65xNHybMclAYZ+h5IcwbYv8Bu1ydNG2a+GTO2cBGl7q2vhupYWPArmx
         4yLeSH1jHl25RN0CY21l0TgmP6f/xjcOQQmKicSm12HDuVufVyqBmalPfMeWDw7Pay4p
         5aYM0tMpbIEiKt2SEYemfNE6jCUzmorQQnYsWaRb6XbmdPNj4/5irbK3udl9BQAj1XoS
         1na00Pm/NQCZ94+KI3Q625VqiAiundJ9uoZJbnvmwicefsQwh1r2/nMbdmODnppA1e8/
         04cPBTSPZo8TU11Jx1ZRNWxKa+V/h7QixQVGteL8R5zTCpjKPVNiTWw/lAaScJlAB4LP
         Zi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780890275; x=1781495075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2lKo0muPPjvxZp63cMcIf07S+igkG9mD6vGKVSxOx8=;
        b=mM6wKCJ4sfNs6iNK2N7MOcF83WNUw60FxTLh+hLhXJ4cjupXEfwlLQxFcSdc8AyWwj
         lymHYhYEobGRGkhLb8UTIQrWbLY6jHgMxliq0HxuCHOH5vp6ChdhMEav6W6bUe6ks2oc
         MlBKhhkMF/t9GuaNrFqIdZne6/4d/X/cV/y9a+aA+r89sWCys4ye+bHEiqxwXblmyCZ3
         4NLKG2wpKq+3QkDk9MhLLoRiB0nzx8sce3sse4V/YGzZDKOKqP5hPA2aP5ZYncSIWgJu
         sJQNmrEx/Jkf15w9A2bvjHa6F4ksSIoB13pKdWr+vbN1BjZQRlMbSpXIJJXr8ubkIx7h
         Xz2w==
X-Gm-Message-State: AOJu0Yzi8GkFibY4/z0LAHzCQyVGbCV1ZJFTxsBo7qqNng9EZVd1fm5k
	HVa0d2ZA0SI67elUbl+rmKwG5uRQBWWD/fSho7z0mvz/i+z/KSr1Cr/e+qJ5ZIVhClg=
X-Gm-Gg: Acq92OGNrXL8Bbc0nkigdbwynDg5QP4+mHqKqZo/sPaUx3JUQQ42IQdi1LtzkL8Mx6s
	4vxq9B0VjESEnf0RUJQ+Mc09ckYGgnInHyDuhFHvlP4TyKnSQ3VcPaWIAd2n4CyBCeyPaSOr+yS
	OFJkb1ALa7ABzY9A2z7gmHHKswSof47qLEHGJTy76czFGmdgYGivAgEmAZ+eueP2K5Dm4j8cGU4
	uYLgsDnS3qTfrLzCkmd2Jka3TJu/JeGXJfcKoYhD2HIeSVaTVtg1QP8P1sZGvnnPBABSlGK/Uel
	i8Un9eTL6nYHxFsqdBRQTFst1jUrmYph3fPskknRYhRtYlxB8nIOVObNxhJ/TQswbO8+stIwBkY
	GO8KJJQwaE5x4qkIRgDdLDcuYFzmcjPZkJvgZ5KhWzcgmoDI3DirSdFeOhIBtJjYNWFFhirQOan
	z4Ig6lLQlxzC9QbInZ12GbOoGzdIlf4icFc5dVJkChV7Ze
X-Received: by 2002:a05:6a00:a89:b0:842:83d1:ee6d with SMTP id d2e1a72fcca58-842b1004ac0mr13892308b3a.45.1780890274866;
        Sun, 07 Jun 2026 20:44:34 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842823512b0sm17180032b3a.15.2026.06.07.20.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 20:44:33 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:14:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v1] i2c: virtio: wait uninterruptibly for completions to
 avoid UAF
Message-ID: <ars6vptfsifv3zvdbx2p7ihcw4rbwbgkvft3xpqyjbvkdckfzy@zxx2exbtuib4>
References: <20260607143608.76122-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607143608.76122-1-gavin.li@samsara.com>

On 07-06-26, 10:36, Gavin Li wrote:
> virtio_i2c_complete_reqs() uses wait_for_completion_interruptible() and stops
> waiting when a signal arrives. virtio_i2c_xfer() then frees reqs and the
> per-request DMA bounce buffers while the device may still hold virtqueue tokens
> pointing at &reqs[i] and DMA into read bounce buffers. Additionally, when the
> device later completes those requests, virtio_i2c_msg_done() calls complete()
> on freed memory and can corrupt the slab freelist.
> 
> Wait uninterruptibly for every completion before freeing reqs. This
> matches how other virtio drivers retain request storage until the device
> completes it. The virtio spec unfortunately does not provide a way to
> cancel an in-flight request, so waiting uninterruptibly is required.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

This is a revert of (and maybe better if that is mentioned in the logs):

commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")

I don't think this is the right approach here. We shouldn't hang the kernel
indefinitely if the other side is dead.

-- 
viresh
