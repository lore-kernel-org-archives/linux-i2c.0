Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9033E7;
	Fri, 23 Jan 2026 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769201607; cv=none; b=V8SbPhGry5JcqFz+VOjjYJ4dXoXcH6s4cH4HpSAJ2M1SqSWgUkGHhgVI70SuXxhIuJIvOaOcToIaYmLqPb4nXQdhX6IcdOtwC6tSMEBuHT23ifEZ0Lfk7e/13E3wGOYWbFK9jvOK8c/JEYaBUWGnSdjS2UKP+FdJuxP+Q06upbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769201607; c=relaxed/simple;
	bh=g669giUV/bECjUp566rX1gBxfE10+0G+DB5+tXOc+d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTap19clcTOQg64w1yB6Ui1BAnG87UvGF2B/NFJw7RcOq5Hrb6GLKXong2iZampP1VANuIegzK4tOwjzMDkVSzILAfqSghvlgK9jlirFBgNp9EigYEpJZ+4INtm4WgiJbqxlxDx+tSFPG/1a/BlS/M57bnVU3VCrYz0tNATu0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DCD9A341432;
	Fri, 23 Jan 2026 20:53:23 +0000 (UTC)
Date: Sat, 24 Jan 2026 04:53:13 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 11/21] i2c: spacemit: Remove IRQF_ONESHOT
Message-ID: <20260123205313-GYA71302@gentoo.org>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-12-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123113708.416727-12-bigeasy@linutronix.de>

Hi Sebastian, 

On 12:36 Fri 23 Jan     , Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> Remove IRQF_ONESHOT from irqflags.
> 

I've sent out a similar patch which already accepted and queued, see
https://lore.kernel.org/r/20260122-05-k1-i2c-irq-v1-1-9b8d94bbcd22@kernel.org

> Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Yixun Lan <dlan@gentoo.org>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/i2c/busses/i2c-k1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
> index d42c03ef5db59..8ef6d5d1927b7 100644
> --- a/drivers/i2c/busses/i2c-k1.c
> +++ b/drivers/i2c/busses/i2c-k1.c
> @@ -566,7 +566,7 @@ static int spacemit_i2c_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, i2c->irq, "failed to get irq resource");
>  
>  	ret = devm_request_irq(i2c->dev, i2c->irq, spacemit_i2c_irq_handler,
> -			       IRQF_NO_SUSPEND | IRQF_ONESHOT, dev_name(i2c->dev), i2c);
> +			       IRQF_NO_SUSPEND, dev_name(i2c->dev), i2c);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to request irq");
>  
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)
