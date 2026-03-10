Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D9E305047;
	Tue, 10 Mar 2026 15:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154944; cv=none; b=CEmJkbSBdEA53eFj7wh9vQYw3VkFaBRxvvHDRpO7o+DLhLruSVYla8ngoNLNYzhXeEOA++S8nHEtvd/CFKKExsFEPNyZ/wwLe/SrjjMxuxf4uGP/pkHrfo1+illm/ymgo15fD7Y2R3BAS6mFcZIO35WPkpEWQtn7jMEJLPfiSlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154944; c=relaxed/simple;
	bh=PVYLHKHTusieIrUcWVG4L06T+l4DVqT2vSF2grzHQ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT23SnR5zgvWTc2CKYGsXlbTHZAL/or5YCyM8Fs6M1U6zcGhAQXczDKPmv1MjOMnrnOwczxzUJo360Ahtt2eJ15wZA38vww+14jtH6eayRbcm6P2axjA53FZMQD9ry2nL4W8XmRRLuM9YjPlpsKJnpGa0iNaJzhZIdbnxVMjvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HanI0CXg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HanI0CXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773154942; x=1804690942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PVYLHKHTusieIrUcWVG4L06T+l4DVqT2vSF2grzHQ+A=;
  b=HanI0CXgW8EsBzB0o6e3vM9u0/nsSLxTULeyieeIUXN/cyWgDFs53Rjk
   GGuZn5Xt0aHZCqT+M4icIfbUt4VDsxzRLmhWN4RVJMu/im8n5OVoZXaRJ
   NpRzTQjwF+qDcRlRz9k50Kf2p1YFcL3neBG658y26X6tLlxwbaq7yKRbm
   IFg/knzA8+VSbtmjW2zOpaLXs8R5igvyWfyDnTigjcQMThWoTIAEx+6J6
   yyvRAbF5XavDrHR8TVazpUmn8AmKEGjkn1HTLeCHtIQ6SCTmQiKz8zGYB
   1hg5rLYm6VR7U+CMVYc3pWC9c9ui8iBf0a4IlrWv0Q5z2MOAapLCaH502
   g==;
X-CSE-ConnectionGUID: tp4nm4EyRK+minteN42yJw==
X-CSE-MsgGUID: +y1pnraVSJqbXTDeyLC0rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85294278"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85294278"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:02:21 -0700
X-CSE-ConnectionGUID: neLwN0iBSfaO6Ijz9wQIrw==
X-CSE-MsgGUID: boggGDclQdqzjz+A0gAwRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="224322566"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 08:02:18 -0700
Date: Tue, 10 Mar 2026 17:02:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andy Shevchenko <andy@kernel.org>, linux-i2c@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <abAyd9uyl3TC8vC_@ashevche-desk.local>
References: <cover.1773142933.git.zhoubinbin@loongson.cn>
 <bd5c06a20ef2e61f76902c4209f2be539ca91a97.1773142933.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd5c06a20ef2e61f76902c4209f2be539ca91a97.1773142933.git.zhoubinbin@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 07:48:53PM +0800, Binbin Zhou wrote:
> This I2C module is integrated into the Loongson-2K0300 SoCs.
> 
> It provides multi-master functionality and controls all I2C bus-specific
> timing, protocols, arbitration, and timing. It supports both standard
> and fast modes.

Nothing really worrying, this version only has an issue to access embedded
struct device in the i2c_adapter. See below.

...

> +/**
> + * struct loongson2_i2c_priv - private data of the controller
> + * @adapter: I2C adapter for this controller
> + * @complete: completion of I2C message
> + * @clk: hw i2c clock
> + * @regmap: regmap of the I2C device
> + * @parent_rate_MHz: I2C clock parent rate in MHz

' in MHz' now is redundant.

> + * @msg: I2C transfer information
> + */

...

> +	/*
> +	 * Acknowledge failure:
> +	 * In master transmitter mode a Stop must be generated by software

Missing period.

> +	 */

...

> +	case 3:
> +		/*
> +		 * In order to generate the NACK after the last received data byte, enable NACK
> +		 * before reading N-2 data
> +		 */

Ditto.

> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_ACK, 0);
> +		loongson2_i2c_read_msg(priv);
> +		break;

...

> +	event = status & possible_status;
> +	if (!event) {
> +		dev_dbg(dev, "spurious evt irq (status=0x%08x, ien=0x%08x)\n", status, ien);

IRQ

> +		return IRQ_NONE;
> +	}

...

> +	/*
> +	 * The BTF (Byte Transfer finished) event occurs when:
> +	 * - in reception : a new byte is received in the shift register

Extra space before :.

> +	 * but the previous byte has not been read yet from data register
> +	 * - in transmission: a new byte should be sent but the data register
> +	 * has not been written yet
> +	 */

...

> +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *priv)
> +{
> +	struct device *dev = priv->adapter.dev.parent;

Derive it from regmap (and check elsewhere) as accessing dev in the adapter
may lead to issues related to the object lifetime.

> +	struct i2c_timings i2c_t;
> +	u32 val, freq_MHz, ccr;
> +
> +	i2c_parse_fw_timings(dev, &i2c_t, true);
> +	priv->parent_rate_MHz = clk_get_rate(priv->clk);
> +
> +	if (i2c_t.bus_freq_hz == I2C_MAX_STANDARD_MODE_FREQ) {
> +		 /* Select Standard mode */
> +		ccr = 0;
> +		val = DIV_ROUND_UP(priv->parent_rate_MHz, i2c_t.bus_freq_hz * 2);
> +	} else if (i2c_t.bus_freq_hz == I2C_MAX_FAST_MODE_FREQ) {
> +		/* Select Fast mode */
> +		ccr = LOONGSON2_I2C_CCR_FS;
> +		val = DIV_ROUND_UP(priv->parent_rate_MHz, i2c_t.bus_freq_hz * 3);
> +	} else {
> +		return dev_err_probe(dev, -EINVAL, "Unsupported speed (%uHz)\n", i2c_t.bus_freq_hz);
> +	}
> +
> +	FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> +	regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);
> +
> +	freq_MHz = DIV_ROUND_UP(priv->parent_rate_MHz, HZ_PER_MHZ);
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_FREQ,
> +			   FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_MHz));
> +
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_TRISE, LOONGSON2_I2C_TRISE_SCL,
> +			   LOONGSON2_I2C_TRISE_SCL);
> +
> +	/* Enable I2C */
> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_PE,
> +			   LOONGSON2_I2C_CR1_PE);
> +
> +	return 0;
> +}

...

> +static int loongson2_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct loongson2_i2c_priv *priv;
> +	struct i2c_adapter *adap;
> +	void __iomem *base;
> +	int irq, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	priv->regmap = devm_regmap_init_mmio(dev, base, &loongson2_i2c_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to init regmap.\n");
> +
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to enable clock.\n");
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	adap = &priv->adapter;
> +	adap->retries = 5;
> +	adap->nr = pdev->id;
> +	adap->dev.parent = dev;
> +	adap->owner = THIS_MODULE;
> +	adap->algo = &loongson2_i2c_algo;
> +	adap->timeout = 2 * HZ;

> +	device_set_node(&adap->dev, dev_fwnode(dev));

Why?! i2c_adapter_set_node() is part of the i2c-next.

> +	i2c_set_adapdata(adap, priv);
> +	strscpy(adap->name, pdev->name);
> +	init_completion(&priv->complete);
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = loongson2_i2c_adjust_bus_speed(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_irq(dev, irq, loongson2_i2c_isr_event, IRQF_SHARED, pdev->name, priv);
> +	if (ret)
> +		return ret;
> +
> +	return devm_i2c_add_adapter(dev, adap);
> +}

-- 
With Best Regards,
Andy Shevchenko


