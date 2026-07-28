Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8D4749D8;
	Tue, 28 Jul 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250231; cv=none; b=tLebXAOm0yIp35BHseKjeE03Ri4JnlhdHWzXFiJ/MfMdGtSrlgmom0Tod3GJXD4A5e0FdLQyPnIboDf01F0h7U5E+06q1AGbudZ9i/p7ZWU4nproQ/wc2tdwrIkv5DtEFG/uI/EcA/WwQBIZkXp1z6DjizuNVEz2j4rM56U02oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250231; c=relaxed/simple;
	bh=FcKMq7ivEVGdNeKjq0ySmvgAH9sJGQCW3CDz04d2SX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/DrAUQI6IISMslBOObzbakzB1NFEJyVi39L2kxY9uCal41w6NN9IaNWMt+YcSAAJZvjvW15CpF/rcNHgiUxtqgzjaWlUMBlCAj/bXmbDKwLCT/TI1r1+4u8kaPbRSU46YW7aLAoY8SqUBBzFtLqbJDXkfNjH/PELUdTfMvsoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx3AY1dc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx3AY1dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA441F00A3E;
	Tue, 28 Jul 2026 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785250229;
	bh=lmIYHvk+gGwj+4CXSQhmRwSaIFfa2O0uQrBaGsucooY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yx3AY1dchgmXCM0ZH0vMpO6Lj8rjRHa051sDqYcYuTuvKsCP+YOVyiMEE4n94U49m
	 YPW5MWJgHY8AXxkI+k5RjlNv2Q03bbmjtq4IMLFRAhgl2uhE+4kYuLRi7EIrVBo8BQ
	 HTOhauaMnwYXUkUFp73l33brWuNs8bFo4gmgyV7dlRpVIV6rRGO75Gqzq5/OL7Kyk9
	 sWURKFi+SfGTQbfp0cYcW+OEZ7ZXMReXdLjTF68PJaKKl5UK7RUbWD3MNdu3bsHJo7
	 B8RBnhJW1ErldYt+zBsfAfEOWdGRLOhwxUUYuGILcwvLKC8pozbuJ65lPJSiiMrt4v
	 Mckh6rhYmxygA==
Date: Tue, 28 Jul 2026 16:50:24 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] i2c: i801: keep the byte-by-byte ISR buffer private
 to the driver
Message-ID: <ami-gn0BRV3Fa429@zenone.zhora.eu>
References: <20260718090329.1622366-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718090329.1622366-2-bestswngs@gmail.com>

Hi Weiming,

Jean, any chance you can review this?

On Sat, Jul 18, 2026 at 02:03:30AM -0700, Weiming Shi wrote:
> For interrupt-driven byte-by-byte block transfers,
> i801_block_transaction_byte_by_byte() points priv->data at the caller's
> union i2c_smbus_data and lets the BYTE_DONE interrupt handler
> i801_isr_byte_done() fill or drain it one byte at a time.  In the i2c-dev
> ioctl path that buffer lives on the caller's kernel (vmap) stack.
> 
> On a wait_for_completion_timeout() the transfer thread returns -ETIMEDOUT
> without fencing the interrupt, and a BYTE_DONE that is still in flight or
> fires later then writes a byte through priv->data
> (priv->data[priv->count++] = inb(...)) after the caller has returned and
> its vmap stack has been freed:

How are you fixing in this patch the pending BYTE_DONE interrupt?

Andi

>   BUG: KASAN: stack-out-of-bounds in i801_isr
>   Write of size 1 at addr ffffc90002a2fda9 by task exploit/5144
>    <IRQ>
>    i801_isr_byte_done drivers/i2c/busses/i2c-i801.c:546 [inlined]
>    i801_isr drivers/i2c/busses/i2c-i801.c:613
>    __handle_irq_event_percpu kernel/irq/handle.c:158
>    handle_irq_event kernel/irq/handle.c:195
>    handle_fasteoi_irq kernel/irq/chip.c:661
>    __common_interrupt arch/x86/kernel/irq.c:263
>    common_interrupt arch/x86/kernel/irq.c:240
>    </IRQ>
>   The buggy address belongs to a freed vmap kernel stack (task exploit),
>   created by kernel_clone -> copy_process.
> 
> The completion-based paths (i801_transaction(),
> i801_block_transaction_by_block()) never expose the caller's buffer to the
> handler: they copy to/from the hardware block buffer in process context
> and use the interrupt only to signal completion.  Give the byte-by-byte
> path the same property.  The handler now fills a driver-private buffer
> (priv->data_buf); the transfer copies the caller's data in before starting
> and copies the result back out on success, so a late or spurious BYTE_DONE
> can only ever touch driver-owned memory.  i801_block_transaction() already
> bounds data->block[0] to I2C_SMBUS_BLOCK_MAX, so the buffer cannot overflow.
> 
> Fixes: d3ff6ce40031 ("i2c-i801: Enable IRQ for byte_by_byte transactions")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
> Changes in v2:
> - Fix the author: From/Signed-off-by. No code change.
> 
>  drivers/i2c/busses/i2c-i801.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index c8cb5ed55..37741fdca 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -279,6 +279,9 @@ struct i801_priv {
>  	int count;
>  	int len;
>  	u8 *data;
> +	/* Driver-private buffer the isr fills/drains, so a late interrupt
> +	 * never dereferences a pointer into the caller's block buffer. */
> +	u8 data_buf[I2C_SMBUS_BLOCK_MAX + 2];
>  
>  #if IS_ENABLED(CONFIG_I2C_MUX_GPIO) && defined CONFIG_DMI
>  	const struct i801_mux_config *mux_drvdata;
> @@ -671,12 +674,23 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>  		priv->cmd = smbcmd | SMBHSTCNT_INTREN;
>  		priv->len = len;
>  		priv->count = 0;
> -		priv->data = &data->block[1];
> +		/*
> +		 * The interrupt handler fills or drains this buffer
> +		 * asynchronously and may still run after a timeout, so keep it
> +		 * in driver-private storage instead of pointing into the
> +		 * caller's block buffer, which is freed once we return.
> +		 */
> +		memcpy(priv->data_buf, data->block, len + 1);
> +		priv->data = &priv->data_buf[1];
>  
>  		reinit_completion(&priv->done);
>  		outb_p(priv->cmd | SMBHSTCNT_START, SMBHSTCNT(priv));
>  		result = wait_for_completion_timeout(&priv->done, adap->timeout);
> -		return result ? priv->status : -ETIMEDOUT;
> +		if (!result)
> +			return -ETIMEDOUT;
> +		if (priv->is_read)
> +			memcpy(data->block, priv->data_buf, priv->len + 1);
> +		return priv->status;
>  	}
>  
>  	for (i = 1; i <= len; i++) {
> -- 
> 2.43.0
> 
