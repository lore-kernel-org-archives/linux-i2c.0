Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426553F44F7;
	Wed, 17 Jun 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691650; cv=none; b=iE+pqte0Qd288po+74ucMEHhS7c4aYH+rqTXg0t2LIGyEjpa3mmmsaTDaM7QWlHSx3SoNiKqBc5OBBtBY7K/kBxMHX48JURBROBdN2FRPXgqr/Omdd1BSnj6KCGiWzFPTa57etSFdI/skoCnTXY+hiNnCI6K3zUe9bWKTz6GuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691650; c=relaxed/simple;
	bh=OfSFu5mGtzotwPKSYXRKabdGa33Ss7x2dODA142hnEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dG+SMQ8KBS1NL4aFcRkDEfB/bgdQhpRDFGn/OmeLckgNMVWussPyZAjYNXfy3LLRI9KpNpaiuyAAh0xeYdxsflZjQysopwZWv+vHXnxwKvyeNqYmE2+um04YAb6KEzcxZjDObbFUElDEghB4JWyjRVfSzom7WMLxgwCWg5tTXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDZ/fstv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDZ/fstv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C701F000E9;
	Wed, 17 Jun 2026 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781691643;
	bh=ciBzbB3mSSaXFTWuJqz3BXFm/InXYvZDvmh4IwdowZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EDZ/fstvNT6VLRYFnlXWfYaUNfIE3i/sFprZYgLblIPQOLMcgQ5ZE7BzDABWfPcT1
	 MeO0YVC7ojcMzLeH5uQU8PFboNavMDgJvPYai7qJWennV6HKjAwE8DRb3JT9te+SNY
	 IAQNgLJOo2MQFIZdafsqh14fMBabIVY4ZbiETKr/slM1hMVbzWDVF4/hrv2oZaaaEW
	 hV42MAU3yM+CKAAkrNiQspIg3WDkF1uchFT3At9KFSJNG6qXOdeU6FcktGk7Bd6nK4
	 /hVHcGeUl/aCDm8PwvhSc8klvui2wY1ojD+OPlx1hN/2c66GpabFmOcfs2GyNYPkVC
	 3coTXCov/nntg==
Date: Wed, 17 Jun 2026 12:20:38 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Paritosh Potukuchi <paritoshpotukuchi@gmail.com>
Cc: shyam-sundar.s-k@amd.com, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paritosh Potukuchi <paritosh.potukuchi@amd.com>
Subject: Re: [PATCH] i2c: amd-asf: Validate firmware-reported length
Message-ID: <ajJt18_NBGSAvMJf@zenone.zhora.eu>
References: <20260612093502.3805287-1-paritosh.potukuchi@amd.com>
 <20260612101815.4124804-1-paritosh.potukuchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612101815.4124804-1-paritosh.potukuchi@amd.com>

Hi Paritosh,

On Fri, Jun 12, 2026 at 10:18:15AM +0000, Paritosh Potukuchi wrote:
> The firmware may sometimes return a length greater than the
> allocated buffer size, which can lead to out-of-bounds access
> and a kernel panic.

How often does it happen? Should it be considered a fix?

Shyam, any comments on this?

> Currently, the driver does not validate the length read from
> firmware.
> 
> Add a check to ensure the firmware-reported length stays within
> the bounds of the data buffer.
> 
> Fix indentation issues reported by checkpatch.

I'm going to remove this comment here as I'm going to take only
this patch and it's a meaningless information to leave in the log
history.

> Signed-off-by: Paritosh Potukuchi <paritosh.potukuchi@amd.com>
> ---
>  drivers/i2c/busses/i2c-amd-asf-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-amd-asf-plat.c b/drivers/i2c/busses/i2c-amd-asf-plat.c
> index ca45f0f23321..e1699da838c2 100644
> --- a/drivers/i2c/busses/i2c-amd-asf-plat.c
> +++ b/drivers/i2c/busses/i2c-amd-asf-plat.c
> @@ -90,6 +90,9 @@ static void amd_asf_process_target(struct work_struct *work)
>  		outb_p(reg, ASFDATABNKSEL);
>  		cmd = inb_p(ASFINDEX);
>  		len = inb_p(ASFDATARWPTR);
> +		if (len > ASF_BLOCK_MAX_BYTES)
> +			return;
> +

Your patch makes sense to me. I'd just like a blank line before
the 'if' statement. No need to resend it; I'll add it while
applying the patch unless you disagree.

Besides that, the patch is not properly formatted. It is missing:

1. Versioning: this should have been "[PATCH v2] ...".

2. Changelog: for a single patch, it should be added below
   the '---' line, after your Signed-off-by. You added
   "Fix indentation issues..." as a sort of changelog, but
   it is in the wrong place and it is not clear that it is
   a changelog.

3. Please don't send a new version as a reply to the previous
   one. From a maintainer's point of view, that makes it more
   difficult to track and apply.

That said, I believe this is your first patch, and that's
perfectly fine. Welcome to the community :-)

Unless there are further comments, I'll apply your patch to
i2c/i2c-for-7.2.

Thanks,
Andi
