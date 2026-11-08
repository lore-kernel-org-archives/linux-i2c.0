Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133167;
	b=1zQ+YgJ5YjkzRDvLHK9hLfKdNFKB3LUbdBzx4rpRWXiE1+DQ34R6vHxkFXNU6UskeXAO
	 4l3qcMN0ZD/VGSPu7XDTU+NX3EpmHCDhttCYbjzNx1JiGEiWZLsVbbWAFnyz+gCheTfOB
	 DkAqamcsCr+Cpa2mcSDrQcrndDkEYKZzllvjnIkwUY+FfBjFaGh2y9qEK3cpRS6pcRm9e
	 9VKncGDm31L+dWH9uxpVkkJV9UfPApD19OxZpE9D24NFiXRcJjgjuVYTI0ILOhPWRgMTS
	 VRlyuaXkEKz5MYqycLcgSrIy0qPCvxCd/Z2PbdPPSvFlJqE8+TP3wG132scmfRQvMZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133167;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PpQxkPSco3s1l1g6k6xE1/ySXul2oC8Rp3+HSn9NQlY=;
	b=LIYbWAhYnXXAEnSFXPchJ8d+15WIRRIhRcgUgazOXCAxlMjtI+b5+CUr/sn+tw7cswSW
	 O2RetSEtKlmjmPKxfEfVpod7vdvpj2pY0xSby/RMb54x7PwpgiAdwEhwxGnmHRc/qfJEM
	 pYvB8C9hm5PNfD4AXcpKp8zPgyVkVPEvNywBpG1ETOHpasu4brFDp8OrQt3RoiTLpllVf
	 oBR/gfVcwfxnBi0HXzA3YqN5hcZjUzzYxfiWgw8AelNQcKwrQ9mjY8CEOl1MJcw5e6x+P
	 Auh5ISQVJIJ2Sfh+lbI0K3VCWSlgSDZns4gADY+0HGSFbEJzQJGjAWJtaFyGE/tw4Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IEXWQ+mB;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5A606A31C
	for <linux-i2c@vger.kernel.org>; Sun,  8 Nov 2026 10:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2B5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=IEXWQ+mB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=PpQx
	kPSco3s1l1g6k6xE1/ySXul2oC8Rp3+HSn9NQlY=; b=IEXWQ+mBbOzgPIY6Y0BP
	ZC+Rj3HVGsEhuIT4uLC5vLLpint7+s+KyHTzqEwiM4s+dO57XeMkGHIkmD7zXwjv
	qDZXOEu/RwvoMIfW/ujClr1XI608mbUOYUy3oCwrysSWTO6pgSvy8FkW/AkpEiaz
	c7gcdTdqgI0ND/KF9EXbtHZ2b/5+ph5jJvFOuL0eyCIkskt18I+zAL49UDjfFPef
	gqGYYjdSyH9iyb78JFAzM31aLy8aUq0hI8CQA3z8opONaISgcwH7phqTwBITlJps
	IQY9rebsBJxdRGnOGU9gffEMQtZ7Gti5JX4Bd+qHEhpGzysZbB+BHtAOblUfH6a6
	QA==
Received: (qmail 2808556 invoked from network); 8 Nov 2026 11:19:22 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Nov 2026 11:19:22 +0100
X-UD-Smtp-Session: l3s3148p1@CH2rLcFfwo9e20rG
Date: Sun, 8 Nov 2026 11:19:17 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Dmitry Guzman <Dmitry.Guzman@mobileye.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Andrea Gallo <andrea.gallo@stericsson.com>,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] i2c: nomadik: reduce FIFO flush timeout to avoid
 long interrupt handling
Message-ID: <avBMpSKHPnsz4vMR@shikoro>
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com>
 <20261103-i2c-nomadik-fixes-v1-8-655c6af2cb70@mobileye.com>
 <CAD++jLnLz_Y_W3Yg13WNntN=iy8tzxAWN4Z0rr5YnO2QfYdrCg@mail.gmail.com>
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
In-Reply-To: <CAD++jLnLz_Y_W3Yg13WNntN=iy8tzxAWN4Z0rr5YnO2QfYdrCg@mail.gmail.com>


> > In flush_i2c_fifo(), the driver sets FTX and FRX flags and waits until
> > they are reset (these bits are self-clearing). If after the first read
> > one or both of these bits is set, it waits until both are reset. The
> > timeout is 10 * I2C transfer timeout. I2C transfer timeout is by default
> > 200 milliseconds. 2 seconds are much more than needed: as stated in the
> > comment above, the flushing operation takes just several cycles before
> > completed.
> >
> > flush_i2c_fifo() is called from init_hw() that may be called from
> > interrupt handler. So, if the I2C controller is stuck and the FIFO does
> > not get flushed, the CPU may spend up to 2 seconds in the interrupt
> > handler and cause watchdog timeout or other unwanted consequences.
> > Moreover, if the interrupt is handled by the same CPU core that updates
> > jiffies, the loop may not finish at all.
> >
> > To avoid too long waiting, reduce the timeout to 100 microseconds and
> > use read_poll_timeout_atomic() instead of relying on jiffies.
> >
> > Fixes: 3f9900f17cdb ("i2c: Add support for Ux500/Nomadik I2C controller")
> 
> Is it really "fixing" that? I don't know if I agree that this is an error
> in the initial submission in 2010...

Removed it.

> > Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
> 
> Surplus newline above? Maintainer can remove it when applying.

Fixed this.

Thanks for the reviews, Linus.

