Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89B1235C01;
	Wed, 29 Jul 2026 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785359206; cv=none; b=UcKNLG8ZGKUpNjzManqB74Cr8bpfiyvBE/zkZqITFHS2rnXdjXsmTYP0YMZ3OGZABxJivNvoy2hNiQL5+2Ooy2LLbEvsg+dRcsdwKa89xn4eXhkf0dMTYZtxuh8N1G+5uzRJggMYPoZFdiqqM1taB7ojhX/Gn3JYpQ+riZxjwWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785359206; c=relaxed/simple;
	bh=HgfY090xy0vuEUd+5KPG4ENtkxTKypqg2iIs6aVHUa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1JlajhX7FKZbkjY81BAYEWZckIIPK8+OpjXnu/DqfOepo5kMNeoZMuy8tJpT+d7FzNU7XRWjO6ctC7r5WfAL4oOQIYOr1YAoF1kbtcKltRMZ+1WYgLlj5KdoWPSSraVWatTfjUrtHAnpNnUs3NTxnCH4e57uq2NALzoZtoaS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU1ZOudV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU1ZOudV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0641F000E9;
	Wed, 29 Jul 2026 21:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785359205;
	bh=7+FCVvhI3Xheokbmt2/UdTHQUuxm0dysdqGb3CqIcBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IU1ZOudVvxPdWnp1DPRNuIk8LrhrFjyL6heQEcgdMHrqZu2ZHxDPsLsRHugbCbxHg
	 BLua11y1f68ZEwt8a5rYDZfsB+PpaZGCLCYeJBOCBLXofequouIJr3rQHrkpHY58ER
	 VPWK6VDyKrQsA81yAi/Su0JWhGVQnZLcIabB/PldOfq80ers9sRkKAHOpiEaqLrKAt
	 YKoU4bRiM27NGLG5vVwL+eWjip40D61q5xvabdhf+DhD/GGedgiOsbTOkpM8ck8ZwJ
	 DfSH5l/Sw1UiX0jKJeGFVBvJZyI0gRgULNvB2a+scepCPtEE7bahaHxiuXTQ1BW/qQ
	 EZ9AdpkzebQGw==
Date: Wed, 29 Jul 2026 23:06:40 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v7 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
Message-ID: <ampnhe-GqNoQwmJZ@zenone.zhora.eu>
References: <20260727081859.1737223-1-zychennvt@gmail.com>
 <20260727081859.1737223-3-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727081859.1737223-3-zychennvt@gmail.com>

Hi Zi-Yu,

...

> +static void ma35d1_i2c_stop(struct ma35d1_i2c *i2c, int ret)
> +{
> +	ma35d1_i2c_write_ctl(i2c, MA35_CTL_STO_SI);

I think there is a valid review from sashiko here.

> +	if (ret)
> +		i2c->err = ret;
> +
> +	ma35d1_i2c_controller_complete(i2c);
> +}

...

> +static irqreturn_t ma35d1_i2c_irq(int irqno, void *dev_id)
> +{
> +	struct ma35d1_i2c *i2c = dev_id;
> +	unsigned long status;
> +
> +	status = readl(i2c->regs + MA35_STATUS0);
> +
> +	if (status == MA35_BUS_ERROR) {
> +		dev_err(i2c->dev, "Bus error during transfer\n");
> +		ma35d1_i2c_stop(i2c, -EIO);
> +		goto out;
> +	}
> +
> +	if (ma35d1_is_controller_status(status))
> +		ma35d1_i2c_irq_controller_trx(i2c, status);
> +	else
> +		ma35d1_i2c_irq_target_trx(i2c, status);

Why are these functions void? We should at least print an error
in case of failures.

> +
> +out:
> +	return IRQ_HANDLED;
> +}

...

> +static int ma35d1_i2c_probe(struct platform_device *pdev)
> +{
> +	struct ma35d1_i2c *i2c;
> +	struct resource *res;
> +	int ret, clkdiv;
> +	u32 val;
> +	unsigned int busfreq;

you can immediately initialize busfreq here.

> +	struct device *dev = &pdev->dev;

nit: can you please sort the declaration by line length, in a
reverse christmast tree shape?

> +	i2c = devm_kzalloc(dev, sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;

...

> +	ret = devm_add_action_or_reset(dev, ma35d1_i2c_pm_cleanup, dev);
> +	if (ret)
> +		goto rpm_put;
> +
> +	writel(MA35_CTL_I2CEN | MA35_CTL_INTEN, i2c->regs + MA35_CTL0);
> +	writel(FIELD_PREP(MA35_CLKDIV_MSK, clkdiv), i2c->regs + MA35_CLKDIV);
> +
> +	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, 0, dev_name(dev),
> +			       i2c);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "cannot claim IRQ %d\n", i2c->irq);
> +		goto rpm_put;

The actions in rpm_put are executed twice, considering
devm_add_action_or_reset.

Thanks,
Andi

> +	}
