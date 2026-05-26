Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5B40629D;
	Tue, 26 May 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808137; cv=none; b=ZCi/grXKyg241QHtVsaf4velnYmccah8upKffjYh9cSI3k9sECAPIUyjrDZpyuBmluAI2hmVMjvEYm0/PRr5ilInI6Khphcav5T2SYanhpStexPhasrxKsR0xfZdSPQpu+2AIyExfqUH0pc9O6qON5y61eG2Q1xCiSgjjwvEe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808137; c=relaxed/simple;
	bh=dXk3/5u72CKjhzprVz3lCgVq4BqsRCmOtAppcmbLofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1quOJ2Z6aYZkKpWqHDdQgwvkVfq33lNf2cbaA8efs/3U6IpJ0bqn5jCrpm66H9zGQVOE/7aQwd32CXgVQAzXDev49ML5VtvhzNULgu3bX2/psqlXGWTJaDlOGLU8cnGPHEvAqwMNtGMWU7E17KX0m1wYk7qkMrVGyBYpURLDy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyg4i9n7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyg4i9n7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64571F000E9;
	Tue, 26 May 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808136;
	bh=FKHVkP4pt3/MMLKj9R3/Tx7Le0s7TGMEbB0F5S6E+x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hyg4i9n7rcig0U62YcJRp+9nN9QSa70Mw7kQtNs29COkTzOKm3LA58EcN5Lb/zvIy
	 mmoZjMHOS9Cau/8/mtNVQeZc9PwWIre6JBv5gttHDl8nbkRIOS7KS/P34ImGeBII6m
	 SuVDaTfcN24Xq14m0F1kUl83x5ayqpM+tjZM+G6/h4eMyY0yEkJxPTpcMKc17AfatC
	 N1j0WVIGOk5ZvGNqyFPrNygAnrexEikcjCnUgQnRvrBW+802OBaAM6EQIUZ86K+HJP
	 lFMS+Z/5YhHHdC4PjlHI3Jwq+x1xTbKYl4LHwV3/JxSJ0RtpNlE65u4DYDwuUP5VAk
	 TH06mPd6qTrbA==
Date: Tue, 26 May 2026 17:08:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev
Subject: Re: [PATCH v4 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <20260526-pompous-gopher-of-serendipity-d72f1f@quoll>
References: <20260526031021.32662-1-wanghongliang@loongson.cn>
 <20260526031021.32662-3-wanghongliang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526031021.32662-3-wanghongliang@loongson.cn>

On Tue, May 26, 2026 at 11:10:21AM +0800, Hongliang Wang wrote:
>  };
>  
>  /*
> @@ -96,6 +104,8 @@ static irqreturn_t ls2x_i2c_isr(int this_irq, void *dev_id)
>  static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  {
>  	u16 val;
> +	u32 pclk, div;
> +	struct clk *clk;
>  	struct i2c_timings *t = &priv->i2c_t;
>  	struct device *dev = priv->adapter.dev.parent;
>  	u32 acpi_speed = i2c_acpi_find_bus_speed(dev);
> @@ -107,12 +117,29 @@ static void ls2x_i2c_adjust_bus_speed(struct ls2x_i2c_priv *priv)
>  	else
>  		t->bus_freq_hz = LS2X_I2C_FREQ_STD;
>  
> +	if (dev_of_node(dev)) {
> +		clk = devm_clk_get_optional_enabled(dev, NULL);
> +		if (clk && !IS_ERR(clk))

So IS_ERR_OR_NULL?

> +			pclk = clk_get_rate(clk);
> +		else
> +			pclk = LS2X_I2C_PCLK_FREQ;
> +
> +		div = priv->div;
> +
> +		val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
> +	} else {
> +		if (!device_property_read_u32(dev, "clocks", &pclk) &&

Please document here that these are *only* ACPI properties.

> +		    !device_property_read_u32(dev, "clock-div", &div))
> +			val = (pclk * 10) / (div * t->bus_freq_hz) - 1;
> +		else
> +			val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
> +	}
> +
>  	/*
>  	 * According to the chip manual, we can only access the registers as bytes,
>  	 * otherwise the high bits will be truncated.
>  	 * So set the I2C frequency with a sequential writeb() instead of writew().
>  	 */
> -	val = LS2X_I2C_PCLK_FREQ / (5 * t->bus_freq_hz) - 1;
>  	writeb(FIELD_GET(GENMASK(7, 0), val), priv->base + I2C_LS2X_PRER_LO);
>  	writeb(FIELD_GET(GENMASK(15, 8), val), priv->base + I2C_LS2X_PRER_HI);
>  }
> @@ -295,6 +322,8 @@ static int ls2x_i2c_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->div = (unsigned int)(unsigned long)device_get_match_data(dev);

unsigned int cast should not be necessary, right?

Best regards,
Krzysztof

