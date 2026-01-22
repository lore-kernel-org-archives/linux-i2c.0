Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4A3D34AE;
	Thu, 22 Jan 2026 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078939; cv=none; b=Km2OzfY/CmKmR8j7EPd1El3B8jjVNotzQV5KQLezDHltQ4ALndRWQ8aBJt5FJcsI3vzkk4vViNzS9AtDCkXufIwfTIr4GCfxHuEV8U5JnnAeskuxhUHz1Dpt0z5EzdRsBvIJDFJPVHP2zn0BuHhDkZ16Imi44YcqO1BZDJzxqYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078939; c=relaxed/simple;
	bh=/pYGcnquk1Ry5ELKwl0/q78NNQ/wVwQETibzYeFu6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=il1gT/hIPaAzqtptEA2/gqM5v8ejgLEAIMdOl3pXkeHqZ/e5dHpkPJgBq6UzX7IHj8SPi7lGhH0zWynGDWhDSbO3XkYLhE+wSL3zm8hBNPbTMjqBQgE/ODbFBnMMVsNSw2lfq5e7aOsRPUZIACXDSIhs23UO57HFgtmrGVGCkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKRSpAd9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKRSpAd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDA3C16AAE;
	Thu, 22 Jan 2026 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078938;
	bh=/pYGcnquk1Ry5ELKwl0/q78NNQ/wVwQETibzYeFu6GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKRSpAd9jCmYqtF+/gk6uYCaYpeQmXfM45Sy1o8usS7BIY8+fxV6o2KDsbKNjFOtT
	 W10mLs3tWygoR81upQAnJi1ijSF0iGhW2R32sobMl6bVjqth0cC+luAjdmbqe0kD2T
	 W76zUPcNV/O85cD47aWdX75vKrsgqFUt/7tR1oE6jFSTR3HODv5me5XZtI/N7/FWHu
	 njuoTiSWlyxpAXySkAzuzn89IsEESzbs7F67Un6cebu76V3L+a/V31gfGOQAur+s6p
	 7QSa1tbEXX1L5+xlsOOXPDkXlXYwPmZrFp16lq+7npFCJx7mJ7eM0L3dvLZLModIou
	 eTb8+tFi2uNxw==
Date: Thu, 22 Jan 2026 11:48:54 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, s.hauer@pengutronix.de, festevam@gmail.com, 
	linux-i2c@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V3 1/2] i2c: imx: preserve error state in block data
 length handler
Message-ID: <aXH_agPD8D2QIVs0@zenone.zhora.eu>
References: <20260116111906.3413346-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20260116111906.3413346-2-Qing-wu.Li@leica-geosystems.com.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116111906.3413346-2-Qing-wu.Li@leica-geosystems.com.cn>

Hi Li,

I'm adding also Stefan in the Cc list as he has authored the
lines you are changing.

On Fri, Jan 16, 2026 at 11:19:05AM +0000, LI Qingwu wrote:
> When a block read returns an invalid length, zero or >I2C_SMBUS_BLOCK_MAX,
> the length handler sets the state to IMX_I2C_STATE_FAILED. However,
> i2c_imx_master_isr() unconditionally overwrites this with
> IMX_I2C_STATE_READ_CONTINUE, causing an endless read loop that overruns
> buffers and crashes the system.
> 
> Guard the state transition to preserve error states set by the length
> handler.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

I asked you to add the Fixes tag here. Perhaps you need to add:

Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
Cc Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: <stable@vger.kernel.org> # v6.13+

You can get the information above with "git blame".

I'll wait for comments from Oleksij and/or Stefan here.

Andi

> ---
>  drivers/i2c/busses/i2c-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 205cc132fdec..05ba41144648 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1102,7 +1102,8 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
>  
>  	case IMX_I2C_STATE_READ_BLOCK_DATA_LEN:
>  		i2c_imx_isr_read_block_data_len(i2c_imx);
> -		i2c_imx->state = IMX_I2C_STATE_READ_CONTINUE;
> +		if (i2c_imx->state == IMX_I2C_STATE_READ_BLOCK_DATA_LEN)
> +			i2c_imx->state = IMX_I2C_STATE_READ_CONTINUE;
>  		break;
>  
>  	case IMX_I2C_STATE_WRITE:
> -- 
> 2.43.0
> 
