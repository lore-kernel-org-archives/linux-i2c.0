Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DC32B105
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378282; cv=none; b=PmTdJiy5l1NRuHNtvhDzGYgmG05mstebd+JGv/oLzvM0yXFGcA2zH7vstqPC0ISttdv1fAUN9CAJLF4pUIg0VPcoEZbvv4Wwwt5xLo+JDCGkXDE6FwM3UdGLR+kDWkO9DHO9yN1yYdTDUytQFWqk1VTqiO3nujUCG+/UtfdXVGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378282; c=relaxed/simple;
	bh=Fxdlux4xKPEUY23/deSXomK7ZVU4GMGdOEjfBvmQcWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLI4iq6h6oCKH+1jIcEQbUbYBI6hoxkZyu+juEINKJ0aXtNwhmaldLiZoZwd6OHr6jFqvfNlB2kxOV5WhfXw/uc5YRjSb6IFGdpGyWjoJTsVQ+5kgEVaHcohHGpH+m6w3oOdRVCS6A6rI+W4sbz5Yg8VNslQ2NlXMD7JuOV1vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSXfHDJp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSXfHDJp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b613a17bso18867585e9.3
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378279; x=1782983079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twZyJNe4oKAUakpXmtBipZs2eMFjp62u4eaHu+ufJQQ=;
        b=NSXfHDJp0lc0BwkOvBFnLVC7Xd+dwmRK5UYLfeHXolOjGYZ329uok3SZZXMe9zSLj5
         DNGCxkW+Yue98Amaj6cydaZJaSqeKsyV7o2/3liNkFCC/e/DxjlSAyphYoaW6nuqRPdq
         BT24aN5ekHpGV+Dmk/FqHvgRgEWDzVtMyRzjwd3Sp63fBXRS02mES1W0xebBBY4nQ1A6
         ATYU8eKNmq/7VgXfZnqKKZaYZyIxsRMORi8aNznpHQJy3tsv5HpBUoFyqKiOgDiv0cOt
         qJBAFTq25JucCO1YqBAIdJGipY8BpDbozBOIOYGWApFcfENY3S4Z4sywhN0ddhBfqJtv
         ySYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378279; x=1782983079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twZyJNe4oKAUakpXmtBipZs2eMFjp62u4eaHu+ufJQQ=;
        b=nV0v3ogx1vrg3iIEQqEKf0Y4y8s0zgklC4VkALaAtzttIFMhXzsAPZslCLPZkH/dpT
         Y2yjoxwDiLPEX49c+OWpDttyqocEkq5gQLsMwkL5vIiV+UVH03/Lpx9bvw7MtwhsezvC
         A+ZvWBSpaooZWPOF40nwX7Jv3v6NXd9KSmiwBbinZDE1un06LcDfGQbyX+rm2Dj2T+Aj
         zDswd2NyuFcRsRQF5TayNOvb0xTm8FR6D3e4uIbihuTDNAxavMFzjTY4vBfTzyO1iWrS
         HS+HpD2wqSqwUGL9Z7bA7PtJJ2nX/QL5/WNc1/GAuuaWh/sUj3mmHA4l7r+tfG8Y8SLj
         hSAg==
X-Forwarded-Encrypted: i=1; AFNElJ9NU7zpCPd6QuD9UHHoV7pFSpT1J/zegwUuSZRuC4I83P3fYWo7FBDgCuazaekYSzAbbo2If+6fRQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUkNLHTyBh2kNcVOEBd6NB466FIgWrbyMzJ1GqxdVhjB80qFG4
	TzeInXmBa+XPPin9zanITzWmTyFu15y0YEPLF54PM9dQO9oyUrHFzgX8
X-Gm-Gg: AfdE7cmw7uLhWSxttk3o5cgZIiZKtZKkgM+K6WlRkHQ4L4UoADVngiHESiwPtB/civN
	7nCsTsVmPJjOBd6MUKKowEIuYLiOYRAFed4minjus4OKLrNaiNzuPB4RQZN3xX25JOwBRTU0OnP
	YYbsrWNEi2SgaFI/LlzSSQ3CajdTCo79p+s5DoFEQbvgCVewpCfGDQ3BZiaZHn7Sy8PhUep6sxn
	m2C/DNkGCajW4jx/eYWg7YDkAlJkY68jWi+KUgUV/WX/PImUaMc5gjVcp8XJClTJhhopnP0ATlL
	nH26hLq4GJgdEMVOJCrLNYskrdC/I92r1LElJSOLw/yfqkydYS0F+3v3MYmhsOmwSzbmPUMhWDM
	zztvVqMMjOf34fv7DFfyyqBAg8nBLbiL+q4OeSTmjUEdVgvdByRxLwevQa9Xp28e+FQ==
X-Received: by 2002:a05:600c:c058:b0:492:48c8:c705 with SMTP id 5b1f17b1804b1-49266865fe5mr18834925e9.1.1782378279131;
        Thu, 25 Jun 2026 02:04:39 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926494f129sm47950825e9.0.2026.06.25.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:04:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:04:36 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Wolfram Sang <wsa@kernel.org>,
	Kaushal Butala <kaushalkernelmailinglist@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (atomic)
Message-ID: <ajzvJE5LuzvLmpZN@eichest-laptop>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-1-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-1-26a3cc8cd055@free.fr>

Sorry for the late reply.

On Mon, May 25, 2026 at 06:43:15PM +0200, Vincent Jardin wrote:
> SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the atomic
> (polling) path rejects it as -EPROTO. Worse, it returns without a
> NACK+STOP: the next receive cycle has already started, so the target
> keeps holding SDA and the bus stays stuck until a power cycle for
> this i2c controller.
> 
> Reading I2DR to obtain the count likewise arms the next byte on the
> count > I2C_SMBUS_BLOCK_MAX path, which also returned -EPROTO directly
> and left the bus held.
> 
> Handle both: NACK the in-flight dummy byte (TXAK) and extend msgs->len so
> the existing last-byte handling emits STOP; the dummy byte is discarded.
> A count of 0 is a valid empty block read; a count above
> I2C_SMBUS_BLOCK_MAX is still reported as -EPROTO, but only after the bus
> has been released.
> 
> The interrupt-driven path has the same flaw from a later commit and is
> fixed separately, as it carries a different Fixes: tag and stable range.
> 
> Fixes: 8e8782c71595 ("i2c: imx: add SMBus block read support")
> Cc: <stable@vger.kernel.org> # v3.16+
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/i2c/busses/i2c-imx.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a208fefd3c3b..14107e1ad413 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1415,6 +1415,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  	int i, result;
>  	unsigned int temp;
>  	int block_data = msgs->flags & I2C_M_RECV_LEN;
> +	int block_err = 0;
>  
>  	result = i2c_imx_prepare_read(i2c_imx, msgs, false);
>  	if (result)
> @@ -1436,8 +1437,20 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  		 */
>  		if ((!i) && block_data) {
>  			len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> -			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX))
> -				return -EPROTO;
> +			if ((len == 0) || (len > I2C_SMBUS_BLOCK_MAX)) {
> +				/*
> +				 * SMBus 3.1 6.5.7: support count byte of 0.
> +				 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
> +				 */
> +				if (len > I2C_SMBUS_BLOCK_MAX)
> +					block_err = -EPROTO;
> +				temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +				temp |= I2CR_TXAK;
> +				imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +				msgs->buf[0] = 0;
> +				msgs->len = 2;
> +				continue;
> +			}
>  			dev_dbg(&i2c_imx->adapter.dev,
>  				"<%s> read length: 0x%X\n",
>  				__func__, len);
> @@ -1485,7 +1498,7 @@ static int i2c_imx_atomic_read(struct imx_i2c_struct *i2c_imx,
>  			"<%s> read byte: B%d=0x%X\n",
>  			__func__, i, msgs->buf[i]);
>  	}
> -	return 0;
> +	return block_err;
>  }

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
