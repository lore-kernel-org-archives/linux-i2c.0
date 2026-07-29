Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4B32BF24;
	Wed, 29 Jul 2026 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361617; cv=none; b=I3dyx4R7hZgr3l5usIcb3eLybGW4RcULHSCyZMV3BXhKZfQQE1Yl0/H8YaMRFlqdA4IXr3JS3mjJJN4bzdfvNzHm4JAw/rql/lQu1qMrejRqNfORc5SKhSqHDZTfSD6xDVBQebauB7GB3+zFs+lVzlYEPLCmjDqtpge5YLSocMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361617; c=relaxed/simple;
	bh=W4kqLTTzHRHp7ju4ZHj75RDQEVcrazNkC2JEEvcHFLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYEPtjUU+fysrDZUUYkrYIANdqBaGezRWlViaF93XUAiVCvuWQUAb7YM4lTbqsvLUARODeZ9Uraf1Lw1dq3KVBcsIYO4FFxYcxBref5xkcsQ9qX8CK2JOktMFI6qmlaXjCPrvpItOvBZ2a8cFz4M2AfMI6bjv0qb+hfzG+q2ySg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0XlNcoG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0XlNcoG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D1D1F000E9;
	Wed, 29 Jul 2026 21:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785361615;
	bh=4gA1444DY6SQVAsZxsUoZsvLvroO8i1ItHFwF6UxiXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N0XlNcoGPY+iu+7ddvduJgMw9cv26Z8wc8a+2pqR/f4KUP/6w8RH6zCdk6rNZNpPG
	 RLDid2Cq1+nwRSHd0f3cSk/aaupzCR6mFLl3zmDIDSftJEF4VNkABKguCkBi2zz9rW
	 LlkVowZwwwjZNB/V15g71i4KuD8oepEPhRwd3ZckLPjTPstd7scZk698s0IWloOLBZ
	 c5QpVZ/aPOK7f868LkE6tt6nMX2M+v+TAVjnTHHWdl0pzsP+dWuy3ngEJtB035Yavq
	 nxzmzxiqW2n1oXC17xZt6NDEdYRy9iaK4WIfpqn0k1EprwvaedxLjUCV8EbL87yLiU
	 Ss8AWnnipgL+g==
Date: Wed, 29 Jul 2026 23:46:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Jie Li <lj29312931@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Wolfram Sang <wsa@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jie Li <jie.i.li@nokia.com>
Subject: Re: [PATCH v5 2/2] i2c: core: support recovery for single-ended GPIOs
Message-ID: <amp0b2jpiV9VO9Pe@zenone.zhora.eu>
References: <CAMRc=MfMcEbQ3kkW3fMn-jzDoT2xdJWjp2xVBVsu7n683_5g9A@mail.gmail.com>
 <20260511113726.49041-1-jie.i.li@nokia.com>
 <20260511113726.49041-3-jie.i.li@nokia.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511113726.49041-3-jie.i.li@nokia.com>

Hi Jie,

On Mon, May 11, 2026 at 01:37:26PM +0200, Jie Li wrote:
> Currently, i2c_init_recovery() only assigns the set_sda/set_scl
> hooks if gpiod_get_direction() returns GPIO_LINE_DIRECTION_OUT.
> 
> This logic fails on certain SoC controllers where open-drain lines
> in a high-impedance state are physically reported as inputs. This
> leads to a "deadlock" where the I2C core refuses to assign the
> recovery hooks because it incorrectly assumes the pins are
> input-only, even though they are fully capable of driving the bus
> low for recovery.
> 
> Update the recovery initialization to use the new
> gpiod_is_single_ended() helper. If a GPIO is configured as
> open-drain or open-source in the firmware, it is safe to assume
> it can be used for bus recovery, even if the current hardware
> direction is reported as input.
> 
> Signed-off-by: Jie Li <jie.i.li@nokia.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Please do not send subsequent versions as --in-reply-to, it's
difficult to track them.

> ---
>  drivers/i2c/i2c-core-base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 9c46147e3506..a3c33e804d47 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -445,8 +445,8 @@ static int i2c_init_recovery(struct i2c_adapter *adap)
>  		bri->set_scl = set_scl_gpio_value;
>  		if (bri->sda_gpiod) {
>  			bri->get_sda = get_sda_gpio_value;
> -			/* FIXME: add proper flag instead of '0' once available */
> -			if (gpiod_get_direction(bri->sda_gpiod) == 0)
> +			if (gpiod_get_direction(bri->sda_gpiod) == GPIO_LINE_DIRECTION_OUT ||
> +			    gpiod_is_single_ended(bri->sda_gpiod))

there was a little conflict here which I fixes and merged to
i2c/i2c.

Thanks,
Andi
