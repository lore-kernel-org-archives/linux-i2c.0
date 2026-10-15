Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520719644B;
	Thu, 15 Oct 2026 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108299; cv=none; b=fXsdOySZb/RaQeoN21qhm9A4FIisn6CARA5IEMwwR0vCW6sWQE9iVjevNmVWms6g4Hh3B53BMSdj8UKwwVUFLTn2QOespd5LhTuvV9m3Po1kikgqA4N0o177SP66kmyz0BLMabc9TgZd29Gf710fqCqDQf7G8rqQUL5Zxj8T+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108299; c=relaxed/simple;
	bh=Bz7s2jXAh/f2QSrdnAOesX3O4LT10qkh8YRVM+1uu4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQueqvEvp2NaO55AxMVD+uMew3ppq6obKvSjBN9fVXg88bebYL3IFVtC9Z9fLPKyGxIZWDBM4ACcKW30LQUMKqsCHtiyULRWKe4RkQqU1gjW6XlKvL1s9fxOtGAuLhbrQTVzMvGd0ogRxdpX99k9WWNxOZAhDCoGTZWzGgpv9B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpLG1J7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpLG1J7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844FF1F000C4;
	Thu, 15 Oct 2026 23:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792108298;
	bh=/RRbiKX1IIdlTwNCQqDikgAOOiBg6jsNei09RfgsCA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpLG1J7ORRhLp6RnZaE1SYJmNPWjSIkzHmq+PHFjPOwCVpz+s+IrxIyPUutaSL0pJ
	 6NF5zCscdGImjBADIJl0Wqjbzv2Pt0+Dn+i2Sze/ZlS2baQsGE0a7LkHymtqRexd92
	 VbKJtbqwF+4B/dy4TOeTDlv/iX0lJrOIIiBxN1/WvARAx0lDJPJY4sMoPoODItbT9z
	 +8iA1NPZDO8NRP8NWhCcZd0/iho4d/98/0BACUMaW4l7fE527PRcexypUOn9X251eh
	 zEz5QipXHYmovX72LZWFm3YUtGN+qa5XKuwHPy98cKO/Rp3H+YeUyEMzTZ6ERmQggM
	 mLcllYSBbCncQ==
Date: Fri, 16 Oct 2026 01:51:35 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thilo Zirnstein <thi.zirnstein@gmail.com>
Cc: michal.simek@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] i2c: i2c-xiic: fix clearing of bnb irq
Message-ID: <atFf1ZbNi29Lbdbb@zenone.zhora.eu>
References: <20261015081127.1566244-1-thi.zirnstein@gmail.com>
 <20261015081127.1566244-2-thi.zirnstein@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015081127.1566244-2-thi.zirnstein@gmail.com>

Hi Thilo,

On Thu, Oct 15, 2026 at 10:11:27AM +0200, Thilo Zirnstein wrote:
> Add a function for clearing the bnb bit,
> It waits for all preconditions before clearing the bnb bit or times out.
> 
> Tested on Zynqmp dev board with some custom logic.
> Tested-by: Thilo Zirnstein <thi.zirnstein@gmail.com>
> 

Please, don't leave blank lines between tags. Moreover in this
case I don't need your Tested-by, I believe you tested your patch
before sending.

> Signed-off-by: Thilo Zirnstein <thi.zirnstein@gmail.com>

I'd need here an ack from Michal.

> ---
>  drivers/i2c/busses/i2c-xiic.c | 42 +++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 5e397a7e63f6..da9cedb86f94 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -230,7 +230,9 @@ static const struct timing_regs timing_reg_values[] = {
>  
>  #define XIIC_RESET_MASK             0xAUL
>  
> -#define XIIC_PM_TIMEOUT		1000	/* ms */
> +#define XIIC_PM_TIMEOUT 1000 /* ms */

Why this change?

> +/* timeout waiting for bus busy */
> +#define XIIC_BB_TIMEOUT		(msecs_to_jiffies(1))

I don't see much benefit from this define as it's used only once.
It just makes it more difficult to read.

>  /* timeout waiting for the controller to respond */
>  #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
>  /* timeout waiting for the controller finish transfers */
> @@ -392,6 +394,30 @@ static int xiic_wait_tx_empty(struct xiic_i2c *i2c)
>  	return 0;
>  }
>  
> +static int xiic_clear_en_bnb(struct xiic_i2c *i2c)

Why do you need to return an error value if you ignore it
everywhere?

> +{
> +	u8 sr = 0, isr = 0;
> +	unsigned long timeout;
> +
> +	timeout = jiffies + XIIC_BB_TIMEOUT;
> +	for (isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET);
> +		(isr & XIIC_INTR_BNB_MASK);
> +		isr = xiic_getreg8(i2c, XIIC_IISR_OFFSET)) {

this for loop is quite ugly. I believe that with a do...while()
you can write a clearer code.

> +
> +		sr = xiic_getreg8(i2c, XIIC_SR_REG_OFFSET);
> +		if (sr & XIIC_SR_BUS_BUSY_MASK)
> +			xiic_setreg8(i2c, XIIC_IISR_OFFSET, XIIC_INTR_BNB_MASK);
> +
> +		if (time_after(jiffies, timeout)) {

If this is called in a context where interrupts are disabled,
jiffies might not be incremented and you end up looping forever.
How about using read_poll_timeout_atomic() instead?

> +			dev_err(i2c->dev, "Failed to clear bnb\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	xiic_irq_en(i2c, XIIC_INTR_BNB_MASK);
> +	return 0;
> +}
> +
>  /**
>   * xiic_setclk - Sets the configured clock rate
>   * @i2c: Pointer to the xiic device structure

...

> @@ -1225,8 +1248,9 @@ static void xiic_start_send(struct xiic_i2c *i2c)
>  
>  		/* Clear any pending Tx empty, Tx Error and then enable them */
>  		xiic_irq_clr_en(i2c, XIIC_INTR_TX_EMPTY_MASK |
> -				XIIC_INTR_TX_ERROR_MASK |
> -				XIIC_INTR_BNB_MASK);
> +						XIIC_INTR_TX_ERROR_MASK);
> +

this needs to be aligned properly.

Andi

> +		xiic_clear_en_bnb(i2c);
>  	}
>  
>  	i2c->prev_msg_tx = true;
> -- 
> 2.43.0
> 
