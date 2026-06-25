Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDE86341
	for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378682; cv=none; b=lQCNjjxnDqXwvq1yeEwH8ynktz43BA4+jAEf6BOmUOzhff8Tg+kqfuwpIBcxAMOwfKWSza8WziPyKDS8pJsJ5UU64Rf7SHShpMMImNuQYjFY6FdY54o9HkAppM/G3nOO89PQ46cIh9VRdqF+xV9CcMzJazO0V6BIQkfuxQa79/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378682; c=relaxed/simple;
	bh=7Vni6aoU/U+1ED5C8Gh3fxPndlG3z+xryt5KP9cLmiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5BvTAA+exMhNRYWiEv7obPlbdfviQDtA2rfEHBc4rF9tAMiWDweGdX3LPgwIJ27qvuNduLTIAmq/2U3kGg4YPc+2LTWO0aq/05e1Le8lp44xShet7JVHUkzVPZH5to3AvdaFLVHgltJLsZD7sHCuTnH7Fgv06N/UBV2Jx5UXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bq7A6eTR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bq7A6eTR"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46dd46901dbso358737f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782378679; x=1782983479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G69PCEOlnq92SdyMP8AGIKg5XJgYw5Jrc7HuDLGgvos=;
        b=Bq7A6eTRUrMs6DJCvsPR1BpweBfzA+pIixKc9P8gT7IOo+FzYzwLdFzRy7okuwDllh
         sPQU1bIAG58YlPkxGJEWum+aMh6LLuVkT2PWZwlzZCCo5zt92Uvb9ClIiBBSNibdIyQx
         HnXvlhY51yFHKa/Wl7O7ROrWVP1JUI8mqLeUQYxuZ2mOM3coJMqiohOgTQJxQdmOF3Ez
         DR4qL52ZUZ6iX6EYWlaO3U9d1bAbFil9ZCh23rJa+AJCMfX1+jpAdH8racdZfsC6yA40
         i63NiwfDIqpU/Zi6E2d8JLfISQQ4s0NIR56ILFztHS9z2xAnG+BGawaDvXFcdL9sQsvb
         p+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378679; x=1782983479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G69PCEOlnq92SdyMP8AGIKg5XJgYw5Jrc7HuDLGgvos=;
        b=qyiXd4U2Duf0Vr3Z8g/1Qile+lje3pLkgBTnzbj/8N0S84i0A+MrATyfgR0yzVuv4+
         CnmXS/+6MiyHqom1tWIU691xsaKvMOUzm6UANxNBqT5DODNT+vZAB5E5DKpmiXLGZ7tx
         nvKbf4pCsJ3XTjhACjWe/RH5wIpIEzMjbED2iauWBUTMUX17JpXMn0q7W4LAFIZBst2w
         +CXhnKH7F1Ddrh23GCCjz+QBn6ssmiBWuQg/dOVqNRCNT+hsrM1Bqt/eG1WlBiGxSOvK
         QXGpMRW8XnnQxxlA/NsmVx4mlL6bPoZ4SL6bZQZ+NHdDKY9a2AreHQ4gfGso6c1mAcZU
         zq5w==
X-Forwarded-Encrypted: i=1; AHgh+RrgM74lt4YEg2jFPePAblmJfluH2idnOHftxFacWPj2LZQW3Ze3JaylhoFPhNllK1XkkuD1Z/j6XjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOjJg1Bf/JtPcR+MjIqxfletJLNoJpw7gvC/9kwPXVZqrQRu/b
	G5w8k6clQfOUpsHs+kfPzi5a9YwhGpeiRa40IlYiBkecQiaLUErftFGj
X-Gm-Gg: AfdE7cm6qUWs0t++j2dO+ddIZ8+NFWYB83INsEn2qh90CLw/qSPo6h6zplrToM9s7Pf
	mC0mJnER8BTjnxhLAhgEXjnBIky0h+qBA3hKLf/fBOwTHmlJf94UdSnQOaL5B9C8eYOzR+BfDNI
	LeaGHwodtggpSStwoMUxnuTOvtWOPIFVliGMef6jSklPBiCsZe7EPSsGukwY8rDhwKrPuGP3bg8
	aZ/9yC6H41hG4KlKAKYpghTuHV0N4QMNc/m35ZeUzmVHMKwobuqnojgcDsjj6Cp3pNEQdBLXQsE
	MxcDwNjyZFOpQ1/65uDEfh0VZkmo5gz2k90K2p016TYaa83Hndy84sjTIc1qCrjGx86TXfF6Exy
	wfD9L6jlwzMRBWyFwE+ptFkPTBOr47r97ifripH1KxasQwMi5ODLEhD7FIUV4C3KJuA==
X-Received: by 2002:a05:6000:41fc:b0:46d:47bb:d711 with SMTP id ffacd0b85a97d-46dc0e050d9mr2295206f8f.23.1782378679096;
        Thu, 25 Jun 2026 02:11:19 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm209356f8f.33.2026.06.25.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:11:18 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:11:16 +0200
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
Subject: Re: [PATCH v2 2/2] i2c: imx: fix locked bus on SMBus block-read of 0
 (IRQ)
Message-ID: <ajzwtNbCKXdxQAUA@eichest-laptop>
References: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-0-26a3cc8cd055@free.fr>
 <20260525-for-upstream-i2c-lx2160-fix-v1-v2-2-26a3cc8cd055@free.fr>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-for-upstream-i2c-lx2160-fix-v1-v2-2-26a3cc8cd055@free.fr>

On Mon, May 25, 2026 at 06:43:16PM +0200, Vincent Jardin wrote:
> SMBus 3.1 6.5.7 allows a Block Read byte count of 0, but the
> interrupt-driven block-read state machine rejects it as -EPROTO. Worse,
> it returns without a NACK+STOP: the next receive cycle has already
> started, so the target keeps holding SDA and the bus stays stuck until a
> power cycle of this i2c controller.
> 
> Accept count=0: NACK the in-flight dummy byte (TXAK) and set msg->len to
> 2 so i2c_imx_isr_read_continue() emits STOP via its normal last-byte
> path. The dummy byte is discarded; block-read callers only consume
> buf[0..count-1].
> 
> Reading I2DR has likewise already armed the next byte on the
> count > I2C_SMBUS_BLOCK_MAX error path, so NACK it (TXAK) before aborting
> with -EPROTO; otherwise the failing transfer's STOP cannot complete and
> the bus stays held.
> 
> The atomic path regressed earlier (v3.16) and is fixed separately; this
> patch covers only the v6.13 state-machine rework.
> 
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/i2c/busses/i2c-imx.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 14107e1ad413..8db8d2e10f5c 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1061,11 +1061,28 @@ static inline enum imx_i2c_state i2c_imx_isr_read_continue(struct imx_i2c_struct
>  static inline void i2c_imx_isr_read_block_data_len(struct imx_i2c_struct *i2c_imx)
>  {
>  	u8 len = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> +	unsigned int temp;
>  
>  	if (len == 0 || len > I2C_SMBUS_BLOCK_MAX) {
> +		/*
> +		 * SMBus 3.1 6.5.7: support count byte of 0.
> +		 * I2C_SMBUS_BLOCK_MAX case should not hold the SDA either.
> +		 * So NACK it (TXAK) to not hold the bus.
> +		 */
> +		temp = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> +		temp |= I2CR_TXAK;
> +		imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2CR);
> +
> +		if (len == 0) {
> +			i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = 0;
> +			i2c_imx->msg->len = 2;
> +			return;
> +		}
> +
>  		i2c_imx->isr_result = -EPROTO;
>  		i2c_imx->state = IMX_I2C_STATE_FAILED;
>  		wake_up(&i2c_imx->queue);
> +		return;
>  	}
>  	i2c_imx->msg->len += len;
>  	i2c_imx->msg->buf[i2c_imx->msg_buf_idx++] = len;
> 
> -- 
> 2.43.0
> 

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
