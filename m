Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2C322B8C;
	Fri, 13 Mar 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389842; cv=none; b=BHBBJnvbiz8Xs0dTZ1GBdVyxh55fTv4TLaG1vhODHB7zoQRy7BilNHXz1ti0r265g/8k3mfStXPwQU8FgOhN6HzxwhPXw6sy0PEsqGPGQpqIQx+ivzba7msmNvztr1saMs0hIyGYJSgG6zQZ8kmrhYvcYJ0fH6RiOhu6oZoP69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389842; c=relaxed/simple;
	bh=R2fon5pzajJZitAIkcVtPhbUt65B/YCLWO8IrF9U0TQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=jtCxX+MdkEYxBQC+YGEfw4UberzRfpOqMzXx2ShcjdWYJipD+2Vo/VwG/d8vdVwz8zxx9RbK+wt+NNHZP63Edku8Ex6r9n+8yLcARBiz5Uv8KsDP/ZdVKje9hgjWXqAe5nwcGfnJ/z0TeeAIcWRDeJFWkKEwAI/7u8WhamPc5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QOV5/YEP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QOV5/YEP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6A5424E4265D;
	Fri, 13 Mar 2026 08:17:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F48660027;
	Fri, 13 Mar 2026 08:17:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1AA9B10369C8B;
	Fri, 13 Mar 2026 09:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773389831; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4nfwtz9pCMH5vgqfUwq/GzIjQmaSYzvxqLV8rNp3KWU=;
	b=QOV5/YEPTRHPbUOlNDbTU+OOq0yBtrq6nnMvg8PUr5YJAI7cpw6fE+08/WsO/qt6FpSzg9
	e96OZvcHR3m1UcJsI+7gonwdzvqcNsPRjMOMGD/zUxACm1w6He1TJjpSWwA2CiaWgwT5MJ
	NkB+qJpERk41hrVWB7CCMga1ThktulTU7IN/GnXKp04VDMaJhvY9KiAhzohpoS9DMpAc1E
	uN9DtBJzDHrQADhivFWlR8IFQRzmwwkpYA5QqnqeQEQbRTrKBhPA+hbgH549PcE5nuuXOj
	OY42hzQpPZ71EgwDPXJoeUBqGfeDje6YcbplX3ALLguxCgEEIAGZqGIEiBrMJA==
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Mar 2026 09:17:09 +0100
Message-Id: <DH1I88QT17NI.1MZERF8Z4M6P5@bootlin.com>
To: "Rosen Penev" <rosenp@gmail.com>, <linux-i2c@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] i2c: atr: use kzalloc_flex
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:KERNEL HARDENING (not covered by
 other areas):Keyword:b__counted_by(_le|_be)?b"
 <linux-hardening@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260313002308.119343-1-rosenp@gmail.com>
In-Reply-To: <20260313002308.119343-1-rosenp@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Rosen,

On Fri Mar 13, 2026 at 1:23 AM CET, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
>
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.

Not sure what you mean by the last sentence, you are not moving the
assignment.

> --- a/drivers/i2c/i2c-atr.c
> +++ b/drivers/i2c/i2c-atr.c
> @@ -58,8 +58,8 @@ struct i2c_atr_alias_pool {
>
>  	/* Protects aliases and use_mask */
>  	spinlock_t lock;
> -	u16 *aliases;
>  	unsigned long *use_mask;
> +	u16 aliases[] __counted_by(size);

Please reorder the parameters accordingly in the kdoc documentation above.

> @@ -137,22 +137,16 @@ static struct i2c_atr_alias_pool *i2c_atr_alloc_ali=
as_pool(size_t num_aliases, b
>  	struct i2c_atr_alias_pool *alias_pool;
>  	int ret;
>
> -	alias_pool =3D kzalloc_obj(*alias_pool);
> +	alias_pool =3D kzalloc_flex(*alias_pool, aliases, num_aliases);
>  	if (!alias_pool)
>  		return ERR_PTR(-ENOMEM);
>
>  	alias_pool->size =3D num_aliases;

I'm not really sure about that, but I suspect kzalloc_flex() does set the
counter variable automatically if it's annotated using __counted_by. If
that's true, you can drop this line.

Otherwise LGTM.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
