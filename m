Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5308B2FBDE0;
	Sun, 30 Aug 2026 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788117209; cv=none; b=jDaLOQz88H037HwKwkdc/sUeFuJVp1Lwvv6iT4ChEAC5cv+vDsWE7PCxNahpIlAWC+UvYXzWe8bE2RQ43DWS0sgYl9l9vu05cuLwxvxMksgf2tP8u9wZHHZjtr6d5gleTrLFMFg2Y/Rcf9abRoO+PVG0ogf58WcwXoQznvxL/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788117209; c=relaxed/simple;
	bh=/NS2NBffIO68mBxJrHpVdYDkSvuBO1m1IbtXD8kr5WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emzxs2hAhrde5N6GKeWw9RNWIeCuR4sozMcjkaJsw7HoK5fQ0uu/ZyWsTrwQEgLu0seqf0pJMzF4GbiHRl4z3QUM3Q145XNeNGhlwIGiXN1Wjaf6YRgWmWIkSXF6XllMDZCmPa64rnRXJeu0/kHRH8so1opBuxRJSdlWBIqvHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdvn1jrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdvn1jrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1205E1F000E9;
	Sun, 30 Aug 2026 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788117207;
	bh=RUU3i6s5skArqbnk9NmqfaGcrevs5tv2G1nvsItg2KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdvn1jrYRp7JLrYF6Tsgw1/ymCp7BvFmrVf+VHkjHOBzumFmE0rPofqjtKoiuz3sv
	 DfdqY92J9qcQZdQ9oVdepBL7lpAQxBS8N2ZG+dwtBVdMOiAjlgj0QiCVSpXc3aom4z
	 4l3PV7++Fl4jUD6zeVJZk6zrdCeNA5ZLgJ4qa1OXm3NJrMP6YgzzwqkzX45/XxSSWC
	 k0WuqRJDUUWhIlOpoTz3d1Asy0nqg0UPh9jFl0vh5HlwDrIBlesYUQSKcn2WgOFql7
	 zNbzq2yKoweUnQVbkvrHFbKnejrLdeABVA0vP7uGv092RaYOieY5wap3rXLXS786ew
	 RFVta8HQ9F0fQ==
Date: Sun, 30 Aug 2026 21:13:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Peter Rosin <peda@lysator.liu.se>
Cc: Farhad Alemi <farhad.alemi@berkeley.edu>, falemi@asu.edu, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: avoid WARN on benign symlink creation failures
Message-ID: <apSAfJARPgsbSDYb@zenone.zhora.eu>
References: <CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com>
 <20260830041303.1934825-1-peda@lysator.liu.se>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830041303.1934825-1-peda@lysator.liu.se>

Hi Peter,

On Sun, Aug 30, 2026 at 06:13:03AM +0200, Peter Rosin wrote:
> WARN() is a bit harsh and causes a crash for panic-on-warn users. Degrade
> the error reporting to ordinary dev_err() calls.
> 
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Link: https://lore.kernel.org/all/CA+0ovCij3QDLRzt8CwpjBy-BbJ5Zf5SV9w9QZXz8uD3Agws31g@mail.gmail.com/
> Signed-off-by: Peter Rosin <peda@lysator.liu.se>
> ---
> 
> Hi Farhad,
> 
> I assume this patch helps?

I sent this patch for a quick test:

https://lore.kernel.org/all/20260828135950.454799-1-andi.shyti@kernel.org/

Maybe they can be taken together, as I agree not to fire a WARN()
there.

Andi

> 
> Cheers,
> Peter
> 
>  drivers/i2c/i2c-mux.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 681a201c239b..52cd8cdf2307 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -393,14 +393,18 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  		}
>  	}
>  
> -	WARN(sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
> -			       "mux_device"),
> -	     "can't create symlink to mux device\n");
> +	ret = sysfs_create_link(&priv->adap.dev.kobj, &muxc->dev->kobj,
> +				"mux_device");
> +	if (ret)
> +		dev_err(muxc->dev, "can't create symlink to mux device\n");
>  
>  	snprintf(symlink_name, sizeof(symlink_name), "channel-%u", chan_id);
> -	WARN(sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
> -			       symlink_name),
> -	     "can't create symlink to channel %u\n", chan_id);
> +	ret = sysfs_create_link(&muxc->dev->kobj, &priv->adap.dev.kobj,
> +				symlink_name);
> +	if (ret)
> +		dev_err(muxc->dev,
> +			"can't create symlink to channel %u\n", chan_id);
> +
>  	dev_info(&parent->dev, "Added multiplexed i2c bus %d\n",
>  		 i2c_adapter_id(&priv->adap));
>  
> -- 
> 2.55.0
> 
