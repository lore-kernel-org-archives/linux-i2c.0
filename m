Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7482364059;
	Thu,  1 Oct 2026 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894197; cv=none; b=MSf/NLk23PKOpLY2VVlfkcKNeHYM5CUaXNezhz5YZXxW7Ie4Gjdi8TSdAImN2UI0IWUKcyyxWzixgH5hIqxqHfmqgYdzJYUOHmk+jyJYzQlzdMtCt+diKh+pBzO3yRWcKPavo8flktaYxJ4zZXoDmXgQ2AAhI+Juw3l54LagL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894197; c=relaxed/simple;
	bh=O+ubMMrg1DnMOR2nvMGXNNFQe1PbuBPCDuU02y0uAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V70/lUXUe8ZzrLQpTcRlxAGzh4jxP6crKZDEbowKNpUkwbUyrfAKRgCtSLbqYvBb0X+Xdd92kO2ZsN0evDsiHsfN516wEUvkwqdScd3bwHBEChf9gEMRFx3T/Y/LDdHqfbfldWGq8ii8hQQNDLFy2WeuhqmNqeWX6jbVYB+TKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjZUvxqf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjZUvxqf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71331F000FF;
	Thu,  1 Oct 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790894195;
	bh=AwNxNeaNpD6uE4Gg7BQoNluSVl3Qj4wQb6AvWZjUprY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RjZUvxqf/0Xcyoh3Y2wcNkYVE8cIlu2jnCDtLDY5fzTLOLBTOd5tK4k7iQ0pDmltY
	 85mXJg3W+INuH7wxv14IwuA4vgb8+Fym/yLLboqcsXBMkv9z8k7mCGuxeITYLGqkhB
	 zfXptKxS3uKrUcubsUr9eOWv5YHKXooe34ypwHC//oJQWtZPXXoyPwo4eLlgnaG09f
	 RrNpc5W5jKyAIoRGHNOPnhPLarn5dxJSdK4huWIDmiXoJmRK1Ww+UigYi4I64Agf3U
	 CJzpkAqlCY3/oxLAkVzQAraNde/C01BP88o7s8bmnBJWcs+S6T2FyI72T+lvHWQJK8
	 UYFp6qOFfzXbw==
Date: Fri, 2 Oct 2026 00:36:31 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Hongjian Dai <daihongjian@kylinsec.com.cn>
Cc: codrin.ciubotariu@microchip.com, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, me@cherr.cc
Subject: Re: [PATCH] i2c: at91: release DMA channels when probe defers
Message-ID: <ar7gTv9It4L_kuSM@zenone.zhora.eu>
References: <7D85C6CB6BF0A82E+20260929164340.41628-1-daihongjian@kylinsec.com.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D85C6CB6BF0A82E+20260929164340.41628-1-daihongjian@kylinsec.com.cn>

Hi Hongjian,

On Wed, Sep 30, 2026 at 12:43:40AM +0800, Hongjian Dai wrote:
> at91_twi_probe_master() can return -EPROBE_DEFER from
> at91_init_twi_recovery_info() after at91_twi_configure_dma() has already
> claimed the tx/rx DMA channels. at91_twi_probe() then returns without
> releasing them, and since dma_request_chan() is not devres-managed the
> channels leak on every deferred probe attempt.
> 
> Release the channels before deferring the probe.
> 
> Fixes: f7eeb1af8537 ("i2c: at91: release DMA channels on remove and probe error")
> Assisted-by: LLM
> Signed-off-by: Hongjian Dai <daihongjian@kylinsec.com.cn>

pushed to i2c/i2c-fixes.

Thanks,
Andi
