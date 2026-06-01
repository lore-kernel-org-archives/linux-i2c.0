Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D5346A0B;
	Mon,  1 Jun 2026 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299531; cv=none; b=PYEJcF6Pir7aMeKWKtPie94+sh5e3X3f74xVtZ8qRPzZQe8/EEYW1X5zCWoVstNWat9SErJDKqMzgYEoyKQqmhoOV9H0hGl+iKgANlEkcDYPnFpP0vnHqVqAKTm0/ayAVEKvxu9xG2cjmt/ofjlGdLBgzx2gVA0bAznEfK4mF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299531; c=relaxed/simple;
	bh=XhsrKV6fRE/86m2p+Ra1ZAImETGaCJGHGPmXSlmXQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnmfmSb2jnxy147eJe8kgA/x5WrEdLTI4KLlnghDZOxhMhg6+4Hwxo3jHKwNMoIgLgZKx+aVidpwS4tyssegBGLws+JrzPYwRzv4Z8z51lamPuXNpNkK2IOocBQc3X2cuC9pt34ZailqUwtwukNOogiE/BLaXCdl8Pmhs+AsD8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXHdKSdQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXHdKSdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAEA1F00893;
	Mon,  1 Jun 2026 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780299529;
	bh=hMzPJo/fiKy0MhTzPq/0U4Dd3j43qg/a3qMB29qEjZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WXHdKSdQAoD0SNcnDO5RD4lygJj98TBJq7/h+efe/D6FdgFRdh6Dg+SzYvo9/dJOe
	 tNpdURpStb24TCCvlDPCx1lmt0RK/H5O3n+9nr2tC5jPi2LsZQJ6L2ljBEpk+VQHcZ
	 dBgveehTTwpFTqJZbQEFovh92FB2b8xmUZAGPzjlH+iTw4IVs7CdfUomhauLwrxsQd
	 jpPU19ZA2RnBLDsdfcsQ9Rq5lgC2ziG+3uGnzr8w6CZzolmd7HJRWUYZHhNoTcDvnl
	 z5JlAeD3OCZ6HS96sfY6ZWgruF6SDnTh2gzWIkOOR+uCdIEihckBbc0m+ZIsMTHMo7
	 YQsHHjVgv60Ag==
Date: Mon, 1 Jun 2026 07:38:47 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Margherita Milani <margherita.milani@amarulasolutions.com>
Subject: Re: [PATCH] i2c: busses: make K1 driver default for SpacemiT
 platforms
Message-ID: <20260601073847-GKB3815935@kernel.org>
References: <20260526-orangepi-sd-card-i2c-v1-1-b92268bfd467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526-orangepi-sd-card-i2c-v1-1-b92268bfd467@gmail.com>

Hi Iker,

On 16:36 Tue 26 May     , Iker Pedrosa wrote:
> Enable I2C_K1 by default when ARCH_SPACEMIT is configured to ensure SD
> card functionality works out-of-the-box.
> 
> SpacemiT K1 boards use I2C-controlled PMICs (like the P1 chip) to
> provide SD card power supplies. Without the I2C_K1 driver enabled,
> regulators cannot be controlled and SD card detection/operation fails.
> 
> Suggested-by: Margherita Milani <margherita.milani@amarulasolutions.com>
> Suggested-by: Yixun Lan <dlan@kernel.org>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

I'd say, that make a fair good default, but still allow people to
adjust, to build as module if they like, thanks, so :

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
