Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B1314B62
	for <linux-i2c@vger.kernel.org>; Sat,  6 Jun 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780780884; cv=none; b=UhaYXNBJeAUHCNTlOUGHwq7S6EDlVOlh1Av5JmOoFfJ69TDhGKMwmLVOfyOHHWsJC8pLYtfcyscr6MvPiRbuyN3aKG8redbnMSHex3EKyTv6oj/iWO4k+6tdcya8zZ9irarMzCZ7wBAPdGVqYVHuyV8TepUdl6KvgInDMBCARxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780780884; c=relaxed/simple;
	bh=1kleD5edmIL9Nd8fK+cN9BmJ6zq7PDslknlYkBMTkRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxfttQJMStRqfEnHTpcRzPeBWGKzm2CnsU7QbTnqr+AFCpgKN86VR7YXJIYIXebal7ou2ISKCLNLN4shFEcNWH2yZ4sDvP4W9vbEIhgQo5hCJytdSnU3Wj0J7O4gxUJYXYqtxUd2ujrElDBB9HQhnK/+zw+/DgRUhc5S94EGLRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B5+Az6ma; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B5+Az6ma"
Date: Sat, 6 Jun 2026 23:20:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780780871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6rzC60MH7dtsvVZRejPalevBzRoUeowvPvaKZrdMnec=;
	b=B5+Az6maH6RVy4Nba14uHv7Aoj6PWyPD57ffWAfxbw1IaVqFD6vpGQbJ3FIgAvxulwuTGh
	uX3KgPCjh5nzgBePG/v1ba0FeOuyhX40QuPwKTEHsTE517XPvwx0omePvjY4Yv/HXPNnUG
	9tR6uvrb5EVTuqZuQLMq+3aAn9Pzv1Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: algo: bit: use str_plural helper in bit_xfer
Message-ID: <aiSPOfKPkrqcYa8b@linux.dev>
References: <20260511104911.183606-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511104911.183606-3-thorsten.blum@linux.dev>
X-Migadu-Flow: FLOW_OUT

Gentle ping?

On Mon, May 11, 2026 at 12:49:13PM +0200, Thorsten Blum wrote:
> Replace the manual ternary "s" pluralizations with str_plural() to
> simplify the code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/i2c/algos/i2c-algo-bit.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
> index 6544d27e4419..d1d9a6c1a1e2 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/errno.h>
>  #include <linux/sched.h>
> +#include <linux/string_choices.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-bit.h>
>  
> @@ -562,7 +563,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>  			ret = readbytes(i2c_adap, pmsg);
>  			if (ret >= 1)
>  				bit_dbg(2, &i2c_adap->dev, "read %d byte%s\n",
> -					ret, ret == 1 ? "" : "s");
> +					ret, str_plural(ret));
>  			if (ret < pmsg->len) {
>  				if (ret >= 0)
>  					ret = -EIO;
> @@ -573,7 +574,7 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>  			ret = sendbytes(i2c_adap, pmsg);
>  			if (ret >= 1)
>  				bit_dbg(2, &i2c_adap->dev, "wrote %d byte%s\n",
> -					ret, ret == 1 ? "" : "s");
> +					ret, str_plural(ret));
>  			if (ret < pmsg->len) {
>  				if (ret >= 0)
>  					ret = -EIO;
