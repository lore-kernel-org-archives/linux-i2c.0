Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236391;
	b=2aDjOwAMfsFmOAfxOjuBPO5vBMzNfPKHvMrjiTcdPYHUbp2KzYzk5ZA8maEsZon2uHr1
	 QfviEz42HkI3JHa89+A9EQj0SkT34cAZXdJouIudvEhRMyo1XlibrgPtsS1vDDaazTQ8+
	 1L1vhb/3hMqWYD5fgLRwQ05dj/3XvbxdYtcFxcNIAw86NDr1DZZO6/RexoyDUltbpFFjO
	 86sJipswajnWsb6woUeVdBbD35nl18kjf0gvykeN2dSEk/EAZnMedzk1MhRspDSM8150f
	 hm5+pz/ABJUfy6JqAOX5zqSCLl+IQYNA9AH5SDjETEj7HJDuPkA4WChHmG9rqbuenSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236391;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G71sYzjhugH4uQfeqvNsU6Z3tBFA+lN/tz6YjlgWMoY=;
	b=Qpa/uGCssEsuWAam/kXmR6DK9Uw0Dx9yraIoPWJr9OQ6volW9KTPmS9xXKo1k3U7KV7U
	 UElJFvVhvvvcAZDN7k7ZqclqeOYYxMC2UH4M7f/IfRy5fgD1NKOjGFPvwkyKg5wNosItj
	 IhAj15neAZ2ZhLx0q1D8Zm6+KIlUQ2iaeGGsX3Z5HcsE3Uo8qwU3Pp6CGauBy/FSirzaq
	 Ipe3T9fuYn9ivLNSupSnxMHlMkN2nLBNg7VchVlsbovjJksANhdTdNmKO4YxAV+4PfRRj
	 R/puY3cOWdYqjaBj+3gV8YAQmBI7NZ8AA+meXR+FpUusdcrVNXuCmoy/WmZIuKQC6ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdLOCnJ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EBE8B606A325;
	Mon,  9 Nov 2026 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdLOCnJ6
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C176D1F008A3;
	Mon,  9 Nov 2026 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236390;
	bh=G71sYzjhugH4uQfeqvNsU6Z3tBFA+lN/tz6YjlgWMoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdLOCnJ6f4QR9j5qES6Is1nPTu85ZFqdJ4CD2I2oQ+FTxhEWg7q/tmmMkxGQmqOjl
	 A+9lvAdp+HczdAYrINk0W4pPS6bC/MeIR99hnxP/fBRwJED8HOsc0f5XySxjR6NQmY
	 rTVnK+3fRozyEQUzU4WWoOoKCZBpkv38jim0IWgyTDE/ab9K97o8X+L2Sb5tV5bYK8
	 KzGEKhC63UTgGM25kKuK3DsmIQXaFbwCrxlpqe8ciO5gZIPx+p6d0pFm+vXmNlV4fk
	 aFa+MWgkMICP34JCM/3REe+Vm9ZsSZJ7I+YL15e4iV5gp1vngsLcx1XWDkAgh7CDgK
	 wolhnkXUGdDDQ==
Date: Mon, 9 Nov 2026 15:59:47 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] i2c: dev: drop unnecessary sysfs device lookup
Message-ID: <7q2j3fxgj6ara7vkscdo3ryxytpy5huokyjs7edglfjmkfcgwt@23qcn7ceagdv>
References: <20260827102043.673273-1-johan@kernel.org>
 <20260827102043.673273-3-johan@kernel.org>
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
In-Reply-To: <20260827102043.673273-3-johan@kernel.org>

On Thu, Aug 27, 2026 at 12:20:42PM +0200, Johan Hovold wrote:
> The sysfs lifetime rules guarantees that the i2c-dev class device is
> still valid while its attribute callbacks are executing so drop the
> unnecessary reverse lookup.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
