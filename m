Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793375;
	b=VXcrcUaPGnROKVLnfFAAarhBMrq5mptSRJUYf5K04H9BXBP/RYkyKyE6LArmEYtZ2UVu
	 JdXYTePs73spimzU133NHAf6xK9K+ShDVEh+QGMZtCfZk+8JAXHWNXHSFbRKbKDV3otCa
	 DXpDoJgPcWKl4Sj1XTcbJ1lOdz6girqKjLjA9/71OK8MrKJjGZCQZ3FxTlizeHMnCvH65
	 BF6LDSBJ/mQOJT9/3zqD511rQMQ6IElPQ0fpebl3ekOQilMIZjVLlGGvjBJqSlh1IVRCA
	 d0w1II8SF+g1MpQjpuSdSn4YEbpTyagJSPlf2skfXMFVFqcNM+t4Tif6nfkliigLIKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793375;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7dNcTbu9dSxbJpse2us0c/1XzcXfjLT8MtjeAWDpV5E=;
	b=cwFRvTN9sIdhvW/0Ryhfv6p0OR8Q+15r2SRa1ecddOIdpfEO/XjLvWytsBjaGI+4wrPl
	 i6IVCoUULOBvO5jeGxO8zLrTRFkl6gOOUYW26/OUaKQ8TxtY/4/wlALdgLDOau7ybfySC
	 Wci/2U+kvYWHOmA3tHesB3FDxXsKiYlGBdymny/E4WEcendPatgbtcfZQukxdLicu0pj7
	 jvtXvEWuHNHSy49wLH/K7f6jzdFORBxc9tXm8spbYriRUcLwKDimGVTJkSOegGxhQnJ/n
	 FRXm1MGcnuOdj8/LY63O4vuizlZGhhb7w1KFLS9GHDTlfcQcjdg1tYol812c0Pgm91Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFURxrdU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C6606A31A;
	Fri, 23 Oct 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XFURxrdU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3BB1F01825;
	Fri, 23 Oct 2026 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793375;
	bh=7dNcTbu9dSxbJpse2us0c/1XzcXfjLT8MtjeAWDpV5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XFURxrdUSG+mzs2T8f4F3J5m4XUZVPa1SBjwL1KoCVFhwfBRleq65OmmrtGcf3bHw
	 N4KF55MArNkG2FPnL42ZqDG4W1ABWVDgbAUa5e7N/2oVnDaxZM7FvdPJdR2uPatDBe
	 ZUriKPYBlaRtn80gaOBae+eQcyOgX0+h/lapt9ZxnTDJMQYzDLqIztZvg5JuBdoFHQ
	 7KihBC6oPDjVQDkn4VsN+6OwgGBJSgy5LbANoHmq9jHN3A43wJGtSgIxkxjg0ygkAv
	 RXz1ZaCenrgLX6u8Gbp9JoLt/klGsCveAq8A6pjRvbl6pZwcsTk/ZqQjUtocNmJHRX
	 AbfQ2BCuxQrbg==
Date: Sat, 24 Oct 2026 00:09:26 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-renesas-soc@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com
Subject: Re: [PATCH] i2c: sh_mobile: request IRQs after mapping registers
Message-ID: <atvUWb-PzouZzL5D@zenone.zhora.eu>
References: <20261017233416.47b09ffff48f.i2c-sh-mobile@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017233416.47b09ffff48f.i2c-sh-mobile@gmail.com>

Hi Myeounghun,

On Sat, Oct 17, 2026 at 11:35:16PM -0400, Myeonghun Pak wrote:
> The managed IRQ handlers are acquired before the managed register
> mapping, so devres unmaps the registers before freeing the IRQs. A
> transfer wakes its waiter before the ISR's final register read, and
> unregistering the adapter does not synchronize these IRQs. An in-flight
> handler can therefore still access the mapping when it is released
> during driver detach.
> 
> With forced-threaded IRQs, the handler can be preempted after waking the
> transfer waiter and before its final ICSR read.
> 
> Map the registers before requesting the IRQs so that managed cleanup
> frees and synchronizes all handlers before unmapping their registers.
> Keep IRQs available while unregistering the adapter because client
> removal may perform transfers.
> 
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
> 
> Fixes: 7fe8a9993337 ("i2c: sh_mobile: devm conversion, irq setup")

Normally, I don't like taking fixes that don't address real
issues, especially speculative AI-generated fixes.

However, this looks like a harmless reordering that seems
correct, although the issue it addresses is rather
hypothetical.

I'll remove the Fixes: tag, since this is purely speculative,
and apply the patch to i2c/i2c.

Thanks,
Andi
