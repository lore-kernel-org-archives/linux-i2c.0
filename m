Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E199D37206F;
	Mon, 28 Sep 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598261; cv=none; b=jRlFFR2vl7YasDlmwSbN2JFhifHtCwIIb5d/8phz3cighZq+muCILXNcCj3YinZPmbrctax+Q9RLVaVHVuAHKkqPu7WdOUYnFyzkRa34yBo3GOQX/5Zvd9fMO+PVBLqxuDXhiUf7HrkMHzeteb/dlsx2CjA3Fs+jqOvtXJ1f6dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598261; c=relaxed/simple;
	bh=qcyJyBseXbZS90zaOng45prybqLv9ZAZSjFBw+qb4Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glfvpGzwghp6k3vlXRAacmRtqOjEvWrXcpYS/0yyHoHaqduTAOcZyHBjSp0/XNW3B8+n5RQFmm9OTgvz8v6QpWMZyvkyDH+5WnhnVQ+15IZE50E7lEy8qFwQz+DP66rdep5qyU30mvRx9XjO8SDQUstit+hBHb6BdUPSF/CBQN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLRpJa7i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLRpJa7i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE86F1F00893;
	Mon, 28 Sep 2026 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790598259;
	bh=XrvuQ5S7vUig/3iGGMMV/FCD0w6ruETLjU2iIyssM5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QLRpJa7ihe8BNoFi0vwJrxl93TUD/Y2GHFKJv9EZpkAA4ypzjyuZwg9Vp9WGJ/tMz
	 yUywzyXXA2WUcgAxgZRntBsGwVrs72XaWlatZ6yJEZ/+JHnzXuRiwxfHumQHIRE7K9
	 iUNoRiLAXQwuXZl8Fgn9snkloAK5dKCjZbtGkgTzANsrH90SVosilLNChjexSETemE
	 akNF7SyXnho96J4elepwaYMd4sXTgC8HUvnQ0TbUFWDmrt2c5t+QeT461ij8tt7xkC
	 TSrdlfCxsAYNwjV7+xVDUoXqt91X+3+u/VKxxvlde1iYsd+iI3ymosiypnKRzFnFut
	 X5SloFiPx8uxQ==
Date: Mon, 28 Sep 2026 14:24:16 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: Re: [PATCH v10 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver
 support
Message-ID: <aro-QitaRwK87gdO@zenone.zhora.eu>
References: <20260921083753.1109826-1-zychennvt@gmail.com>
 <20260921083753.1109826-3-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921083753.1109826-3-zychennvt@gmail.com>

Hi Zi-Yu,

...

> +/* Constants */
> +#define MA35_CLKDIV_MSK		GENMASK(9, 0)
> +#define I2C_PM_TIMEOUT_MS	5000
> +#define STOP_TIMEOUT_MS		50

these two defines are the only ones without the MA35 prefix.

...

> +static irqreturn_t ma35d1_i2c_irq_target_trx(struct ma35d1_i2c *i2c,
> +					     unsigned long i2c_status)
> +{
> +	unsigned char byte = 0;
> +
> +	switch (i2c_status) {
> +	case MA35_S_RECE_ARB_LOST:
> +		/*
> +		 * Arbitration lost during address transmission phase.
> +		 * The hardware switches to Target Transmitter mode when
> +		 * our own SLA+W is detected on the bus.
> +		 */
> +		i2c->err = -EAGAIN;
> +		ma35d1_i2c_controller_complete(i2c);
> +		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED, &byte);

All the return values of these i2c_slave_event()'s are ignored.

> +		break;
> +
> +	case MA35_S_RECE_ADDR_ACK:
> +		/* Own SLA+W has been receive; ACK has been return */
> +		i2c_slave_event(i2c->target, I2C_SLAVE_WRITE_REQUESTED, &byte);
> +		break;
> +
> +	case MA35_S_TRAN_DATA_NACK:
> +	case MA35_S_RECE_DATA_NACK:
> +		/*
> +		 * Data byte or last data in I2CDAT has been transmitted and NACK received,
> +		 * or previously addressed with own SLA address and NACK returned.
> +		 */
> +		break;
> +

...

> +	default:
> +		dev_err(i2c->dev, "Status 0x%02lx is NOT processed\n",
> +			i2c_status);
> +		ma35d1_i2c_restore_idle(i2c);
> +		return IRQ_NONE;
> +	}
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_SI_AA);

As far as I understood, this this is an unconditional ACK enabled
for the next bytes received, right? In that case are we ignoring
failed communications as above where we are supposed to send
NACKs?

> +	return IRQ_HANDLED;
> +}

...

> +	i2c->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(i2c->regs))
> +		return PTR_ERR(i2c->regs);
> +
> +	i2c->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(i2c->rst))
> +		return dev_err_probe(dev, PTR_ERR(i2c->rst),
> +				     "failed to get reset control\n");
> +
> +	ret = reset_control_deassert(i2c->rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to deassert reset line\n");
> +
> +	/* Setup info block for the I2C core */
> +	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
> +	i2c->adap.owner = THIS_MODULE;
> +	i2c->adap.algo = &ma35d1_i2c_algorithm;
> +	i2c->adap.quirks = &ma35d1_i2c_quirks;
> +	i2c->adap.retries = 2;
> +	i2c->adap.algo_data = i2c;
> +	i2c->adap.dev.parent = &pdev->dev;
> +	i2c->adap.dev.of_node = pdev->dev.of_node;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +
> +	if (!device_property_read_u32(dev, "clock-frequency", &val)) {
> +		if (val != 0 && val <= MEGA)
> +			busfreq = val;
> +	}
> +	/* Calculate divider based on the current peripheral clock rate */
> +	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
> +	if (clkdiv < 0 || clkdiv > 0x3ff)
> +		return dev_err_probe(dev, -EINVAL, "invalid clkdiv value: %d\n",
> +				     clkdiv);
> +
> +	i2c->irq = platform_get_irq(pdev, 0);
> +	if (i2c->irq < 0)
> +		return dev_err_probe(dev, i2c->irq, "failed to get irq\n");
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT_MS);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = devm_add_action_or_reset(dev, ma35d1_i2c_pm_cleanup, dev);
> +	if (ret)
> +		return ret;

you are printing an error message everywhere, except of here.

> +
> +	writel(MA35_CTL_I2CEN | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
> +	writel(FIELD_PREP(MA35_CLKDIV_MSK, clkdiv), i2c->regs + MA35_CLKDIV);
> +
> +	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, 0, dev_name(dev),
> +			       i2c);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "cannot claim IRQ %d\n", i2c->irq);
> +		return ret;
> +	}
> +
> +	ret = devm_i2c_add_adapter(dev, &i2c->adap);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to add bus to i2c core\n");
> +		return ret;

return dev_err_probe(...)

Thanks,
Andi

> +	}
> +
> +	dev_info(&i2c->adap.dev, "%pa MA35D1 I2C adapter registered\n",
> +		 &res->start);
> +	return 0;
> +}
