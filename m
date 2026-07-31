Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE939349CE4;
	Fri, 31 Jul 2026 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533758; cv=none; b=r4mK4WXoVB2t0cYKEGIiALg3KD0FRcDwEu/0skEUQMQg6Fxwqv5U5WDJXSFZOV3XHVPESlgxvdRUzmOd+316ezld/1xbmCwBcTjwizhX8h1b8Vsc6UWYC7rBlOZustQ3Pgc6zIax52k7DF2w9DXjhCw9BJeHGG6jLdHOwufTEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533758; c=relaxed/simple;
	bh=wMBBWj1WvBkCyuzEjmOhv3I4C7UPU29ygfZoJn1NHtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTuXPhuypbo0ltWrez4BUncmmk0Xn+zhpBhGEW1metdvYTgRYel1PhwcyUA/irukhlbKZlOBWZhDOX13u1aI0sbYW4Nd0giEZFq2L6JgCpNo+img8I/pQluSNhcF/RBMt31wpHvcuENXwYxv6HymbHEqO7l7Ztyrg6oBGjx1sRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nneOyY+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nneOyY+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1C91F00AC4;
	Fri, 31 Jul 2026 21:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533757;
	bh=tMdPgT7O5rRbNyI6n8bml9CMZqfYZ0TXUVKBQDNkGog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nneOyY+50JtvIH1ycZXJ9JVaSgeEtcNODy/Jm/g8IY0P/3UckB7tj38IkEjg2nIUF
	 AEiNbJavAVGnnrVSP3x507Y5GjXKL0qu8uJiRNF7WslGXX2MgqmHaC+FFfXURl75Qe
	 sE18uvWkR447FIf220YwIaFY9LYmG7F2wHPnT3GiDzjTrTuzwcLceNZKK6nD7nuyVs
	 yyI2LKuqABQAwc/3vQYmLWF4mFXBhJTsMzDfY4JCU8eNaVPRyFmLsmU1tThKekNQVo
	 G1LrqKRen3X/e+mMbBEZpL5PDQ91DV4H4eZQdDTXs6z7FMW6ABVqmud7qCH12yhKFh
	 ZcCjqyfnzxgWQ==
Date: Fri, 31 Jul 2026 23:35:54 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Vasileios Almpanis <vasilisalmpanis@gmail.com>
Cc: wsa+renesas@sang-engineering.com, johan@kernel.org, hdanton@sina.com, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+23ad911c819b923238b7@syzkaller.appspotmail.com
Subject: Re: [PATCH] i2c: core: fix debugfs UAF on adapter removal
Message-ID: <am0Mk1KapCw0SD1s@zenone.zhora.eu>
References: <20260730162540.291570-1-vasilisalmpanis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730162540.291570-1-vasilisalmpanis@gmail.com>

Hi Vasileios,

...

> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 3ec04787a737..b894563f5a75 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -1826,8 +1826,6 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>  
>  	i2c_host_notify_irq_teardown(adap);
>  
> -	debugfs_remove_recursive(adap->debugfs);
> -
>  	/* wait until all references to the device are gone
>  	 *
>  	 * FIXME: This is old code and should ideally be replaced by an
> @@ -1839,6 +1837,9 @@ void i2c_del_adapter(struct i2c_adapter *adap)
>  	device_unregister(&adap->dev);
>  	wait_for_completion(&adap->dev_released);
>  
> +	/* clients use this directory as their debugfs parent */
> +	debugfs_remove_recursive(adap->debugfs);
> +

Speaking of sysfs, this can't work if a new device is created
through the new_device interface. Perhaps you can remove the
attribute first with device_remove_file(), but we need to check
whether that could lead to a double removal when the device
attributes are cleaned up during device removal.

Thanks,
Andi

>  	/* free bus id */
>  	mutex_lock(&core_lock);
>  	idr_remove(&i2c_adapter_idr, adap->nr);
> -- 
> 2.47.3
> 
