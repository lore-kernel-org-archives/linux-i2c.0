Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028158;
	b=wsQ7ahUSBsL1XtNYTkYyweWn2I24U69WgeB1CR4sZQ1QNXqL2311T2Qj+xT9PiG+3HQF
	 UZBhkPcRcWLF6lPMco7ucubQjjAzv7AMIwdvNOmGKLlnvwA7JB3IUtOVdfoQBy7BWfzjk
	 BihjQA/5C6R5BaiLc7zU7r0NUnwjWIbe4aTZrWq6RE0rLTj83XISE4jFFRxhYgM4CyAoK
	 LQOHG8H2EiaHxO9EIBv5snYbeFIP5vVDDVUqv4H8qtgrb4AmyIfKzqjq3hg68XeErYyAI
	 n0ifitQ6Ikk5X6ccZp7+A1RSU7HBjykhM3sbHTR3Qp+mipAWZbBe3rrumwFvd2b4+HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028158;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RZDDaJ57x7rY16pTWiAgH2N6hWJkfwlHnV205h0LFhw=;
	b=Sp85zHeFhsy+U6J5deGOjM9YrgW++riyNsi9T/6ONaSge2SF6TGZhq38+YTT+3I4mKS6
	 eDBA3sn1736BpOoqpHrGOCfzsHDrCGJrZPDtRdda5ncU62J//iREjmUCBy2mLUiW61GNi
	 oHorY4XTyLU6HaLuQ+6AJ/gIRwPgffYze+29bo08kCXqEy6+y4AllWkNsRRET1pFHrg7T
	 1YVK/gN07SdxlXzkB70zbakovOG47y/1jffqkOK/9Gf7agCtdfoC/Pk8fyHJUvtp/7dWN
	 rmtynn2hUajVKvgtTqpCG/sQb4P4JhGH4oEAL6XdXGR/0yj5hNklP0xo4PH6S7sj7Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnFAugCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA26606A31A;
	Mon, 26 Oct 2026 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FnFAugCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3319F1F01825;
	Mon, 26 Oct 2026 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028158;
	bh=RZDDaJ57x7rY16pTWiAgH2N6hWJkfwlHnV205h0LFhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FnFAugCV2anMB8GwwB//iiEOTlFCvHL4vGHno2iTe+GQfR3JvTClws4We8W6Xpw6h
	 WywyeqBz2SbedLzQXZnhBV5LqqKXUL3qDO9xfsWrLY8Cy575GtuWYPYdyWnMIf4+ii
	 4g5q5cFR6H88yv5JWvlD+zUbxmnqPru6OQp9hCMuXl+t8JcvlzejGxR7iXJ8U2dCTa
	 VP7V1elV/PpCapJjDhEKRbLhvZAIfjrarAUNU8+trmOnLbq4QgizSxtQfqJUcTvSa/
	 74OrWew4/OrvFmxOa9YM9nhfmZrYO+bpq2PkEA9LDGccSa8r5EKnAKJuFry74/ZL2U
	 dRJlcg5Df2X4Q==
Date: Mon, 26 Oct 2026 16:22:33 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Junyi Zhao <junyi.zhao@amlogic.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xianwei Zhao <xianwei.zhaol@amlogic.com>, Junyi Zhao <junyi.zhaol@amlogic.com>, linux-i2c@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: amlogic: Add Amlogic A9 I2C controller driver
Message-ID: <at8nuDtiHEDq4AZ2@zenone.zhora.eu>
References: <20261022-a9-i2c-v2-0-45e3cef175bf@amlogic.com>
 <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>
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
In-Reply-To: <20261022-a9-i2c-v2-2-45e3cef175bf@amlogic.com>

Hi Junyi,

Sashiko's comments look legit to me, can you please take a look
at those?

Besides...

> +static irqreturn_t aml_i2c_irq(int irqno, void *dev_id)
> +{
> +	struct aml_i2c *i2c = dev_id;
> +	u8 *buf = NULL;
> +	int ret;
> +	u32 rd_len, i;
> +	u32 rd_val;
> +
> +	spin_lock(&i2c->lock);
> +	ret = controller_is_error(i2c);
> +	if (ret) {
> +		i2c->error = ret;
> +		goto complete_irq_out;
> +	}
> +
> +	switch (i2c->state) {
> +	case A9_STATE_READ:
> +		buf = i2c->msg->buf;
> +		rd_len = min(i2c->msg->len - i2c->pos, A9_I2C_FIFO_DEPTH);
> +		for (i = 0; i < rd_len; i++) {
> +			rd_val = readl(i2c->regs + REG_CFG_RX);
> +			buf[i2c->pos++] = rd_val & TX_RX_DATA;
> +		}
> +		/* Rx must clear thresh after read fifo */
> +		clear_irq_status(i2c, A9_RX_THRESH_READ);
> +		break;
> +	case A9_STATE_WRITE:
> +		aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_HALF);
> +		if ((i2c->pos + A9_I2C_HALF_FIFO) >= i2c->msg->len)
> +			aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE, A9_TX_THRESH_WRITE, 0);
> +		i2c->pos += i2c->count;
> +		/* Tx must clear thresh after write fifo */
> +		clear_irq_status(i2c, A9_TX_THRESH_WRITE);
> +		break;
> +	case A9_STATE_IDLE:
> +		dev_warn(i2c->dev, "i2c irq triggered abnormally, irq_state:0x%x,irq_en:0x%x\n",
> +			 readl(i2c->regs + REG_CFG_IRQ_STATE),
> +			 readl(i2c->regs + REG_CFG_IRQ_ENABLE));
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!controller_is_done(i2c)) {
> +		goto irq_trans_out;
> +	} else {
> +		if (i2c->state == A9_STATE_READ && (i2c->msg->len - i2c->pos))
> +			goto irq_trans_out;
> +	}

No need for brackets here:

if (...)
	goto ...;
else if (...)
	goto ...;

But perhaps the two can be even merged.

(i2c->msg->len - i2c->pos) is equal to (i2c->pos < i2c->msg->len)

> +
> +complete_irq_out:
> +	reset_fifo_pos(i2c);
> +	complete(&i2c->done);
> +	i2c->state = A9_STATE_IDLE;
> +	aml_i2c_set_mask(i2c, REG_CFG_IRQ_ENABLE, A9_RX_THRESH_READ | A9_TX_THRESH_WRITE, 0);
> +	clear_irq_status(i2c, IRQ_ALL_MASK);
> +irq_trans_out:
> +	spin_unlock(&i2c->lock);

...

> +	i2c->state = (msg->flags & I2C_M_RD) ? A9_STATE_READ : A9_STATE_WRITE;
> +	spin_lock_irqsave(&i2c->lock, flags);
> +	aml_i2c_prepare_xfer(i2c, A9_FIFO_FILL_FULL);
> +	i2c->pos += i2c->count;
> +	spin_unlock_irqrestore(&i2c->lock, flags);
> +	reinit_completion(&i2c->done);
> +
> +	if (last)
> +		aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, 0);
> +	else
> +		aml_i2c_set_mask(i2c, REG_CFG_BUS, BUS_NO_STOP, BUS_NO_STOP);
> +	/* Start the transfer */
> +	aml_i2c_do_start(i2c, msg);

I think this should also be under spinlock in order to avoid that
the interrupt handler accesses a partially initialized state.

> +
> +	time_left = msecs_to_jiffies(I2C_TIMEOUT_MS);
> +	time_left = wait_for_completion_timeout(&i2c->done, time_left);
> +
> +	/*
> +	 * Protect access to i2c struct and registers from interrupt
> +	 * handlers triggered by a transfer terminated after the
> +	 * timeout period
> +	 */
> +
> +	spin_lock_irqsave(&i2c->lock, flags);
> +	if (!time_left) {
> +		i2c->state = A9_STATE_IDLE;
> +		clear_irq_status(i2c, IRQ_ALL_MASK);
> +		reset_fifo_pos(i2c);
> +		ret = -ETIMEDOUT;

the next instruction overwrites this error. Perhaps you could
use a goto to spin_unlock and return.

Andi

> +	}
> +
> +	if (i2c->error)
> +		ret = i2c->error;
> +	spin_unlock_irqrestore(&i2c->lock, flags);
> +
> +	return ret;
> +}
