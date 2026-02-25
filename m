Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6713921DA;
	Wed, 25 Feb 2026 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014006; cv=none; b=pS1Rd2HUSCf1h4I4NO72wn97nZgwPg27G8cfq5Lt99lFhaTgdfmZTh1g5CJ8eX3isRnvqqVNBp109f8GPhgGg+quEY+0OAgT+io21ItdEqCAHuBQc/If/DblDzY98q3SzETPZxc9eCrN2SJGpW2xtSXmHVULz2TYdpRmdGO/Y+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014006; c=relaxed/simple;
	bh=t+gG1MpnxtUkriPFy6ubFIFH+p6QlnNvobrG4pNA9FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWJURR0XUJCT97mLfoBCGKOhO2NFoG4WgY3rBKTmXpqnl6E7D7mgw/M70Muk5LA5rHSLLulq9xJ/Im5OkDuLS7Pz5sGnHnOAuRUALNz8MO843G91Pa2amlwTQ8ulZ9laDvGADHIDR7pjC9/epSHsZSYpji5VSuGqGJT3M+nAIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFwuW+Tp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFwuW+Tp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772014005; x=1803550005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+gG1MpnxtUkriPFy6ubFIFH+p6QlnNvobrG4pNA9FY=;
  b=KFwuW+TpLJUYM+G5TPHeWN2JrZJ9ZQmZgia+8AOUr8rUXuONBv/EZCIK
   iiO6HdhpDfKHaEF6+Im9D6K+FgKMiijwjUtXld70bsWljUhblNAKB2e1T
   ncQuwu7X9LfIEr8h7OC6LjQMr1yLihnMSu2NBO02EbNWmi3ULSfRVLqJf
   OloxKWjp4vHlBFlplvU7g8e3Hnm4GdStvSsrJnxxc2UBba/2CsWMmqFy1
   szSLTMhHI0/ZfXAd6uK4KIeBIiv9iPPsoOhbKIB9df5phDucMDKeLQAtv
   5Q1cD+Ehvq2EEZ8d4OKT+Bft1cwJyM80wJxlxkoK/hBtzEpthjTMFCmf0
   g==;
X-CSE-ConnectionGUID: WZyOu0jlSoGs7s0f8xt59A==
X-CSE-MsgGUID: lSfX9PZGTwGW/DxievjpGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76654271"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="76654271"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:44 -0800
X-CSE-ConnectionGUID: c7fTSj09RCO2vb+z1ZtwGw==
X-CSE-MsgGUID: IH9RcsUCSZe4c5qbjLIfgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="239194276"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 02:06:41 -0800
Date: Wed, 25 Feb 2026 12:06:35 +0200
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
Subject: Re: [PATCH v3 2/2] i2c: ls2x-v2: Add driver for Loongson-2K0300 I2C
 controller
Message-ID: <aZ7Jq5GTbROvcrJH@smile.fi.intel.com>
References: <cover.1772001073.git.zhoubinbin@loongson.cn>
 <27899156d9218ced7cb0679cad2b2f59f688bd99.1772001073.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27899156d9218ced7cb0679cad2b2f59f688bd99.1772001073.git.zhoubinbin@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 03:34:44PM +0800, Binbin Zhou wrote:
> This I2C module is integrated into the Loongson-2K0300 SoCs.
> 
> It provides multi-master functionality and controls all I2C bus-specific
> timing, protocols, arbitration, and timing. It supports both standard
> and fast modes.

...

> +struct loongson2_i2c_priv {
> +	struct i2c_adapter		adapter;
> +	struct completion		complete;
> +	struct clk			*clk;
> +	struct regmap			*regmap;

> +	int				speed;
> +	int				parent_rate;

May any of these two be negative? The kernel doc says nothing about that.

> +	struct loongson2_i2c_msg	msg;
> +};

...

> +static void loongson2_i2c_handle_read(struct loongson2_i2c_priv *priv, int flag)
> +{
> +	struct loongson2_i2c_msg *msg = &priv->msg;
> +	unsigned int i;
> +	bool changed;
> +
> +	switch (msg->count) {
> +	case 1:
> +		/* only transmit 1 bytes condition */
> +		loongson2_i2c_disable_irq(priv);
> +		loongson2_i2c_read_msg(priv);
> +		complete(&priv->complete);
> +		break;
> +	case 2:
> +		if (flag != 1) {
> +			/* ensure only transmit 2 bytes condition */
> +			regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
> +					   LOONGSON2_I2C_CR2_ITBUFEN, 0);
> +			break;
> +		}
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_OP_MASK,
> +				   msg->stop ? LOONGSON2_I2C_CR1_STOP : LOONGSON2_I2C_CR1_START);
> +
> +		loongson2_i2c_disable_irq(priv);
> +
> +		for (i = msg->count; i > 0; i--)
> +			loongson2_i2c_read_msg(priv);
> +
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_POS, 0);
> +		complete(&priv->complete);
> +		break;
> +	case 3:
> +		regmap_update_bits_check(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_ITBUFEN,
> +					 0, &changed);
> +		if (changed)
> +			break;
> +		regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR1, LOONGSON2_I2C_CR1_ACK, 0);
> +		fallthrough;

Instead better to spell it explicitly:

		loongson2_i2c_read_msg(priv);
		break;

> +	default:
> +		loongson2_i2c_read_msg(priv);

Missing break.

> +	}
> +}

This also make me think for the possible optimisations.
if regmap_updates_bit() in case 2 can be run after the completion,
the case 1 with a parameter may be split to a helper.

Also would be nice to have a comment why in case 3 we only read a single
message.

...

> +static void loongson2_i2c_handle_write(struct loongson2_i2c_priv *priv)
> +{
> +	struct loongson2_i2c_msg *msg = &priv->msg;
> +
> +	if (msg->count) {
> +		loongson2_i2c_write_msg(priv, *msg->buf++);

> +		msg->count--;
> +		if (!msg->count)

Can be

		if (!--msg->count)

but someone may find it difficult to correctly parse.

> +			regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2,
> +					   LOONGSON2_I2C_CR2_ITBUFEN, 0);
> +	} else {
> +		loongson2_i2c_terminate_xfer(priv);
> +	}
> +}

...

> +static int loongson2_i2c_adjust_bus_speed(struct loongson2_i2c_priv *priv)
> +{
> +	u32 val, freq_mhz, ccr;
> +
> +	priv->parent_rate = clk_get_rate(priv->clk);

> +	freq_mhz = DIV_ROUND_UP(priv->parent_rate, HZ_PER_MHZ);

Usually the rule of thumb to put assignments close to its first user...

> +	if (priv->speed == I2C_MAX_STANDARD_MODE_FREQ) {
> +		 /* Select Standard mode */
> +		ccr = 0;
> +		val = DIV_ROUND_UP(priv->parent_rate, I2C_MAX_STANDARD_MODE_FREQ * 2);
> +	} else {
> +		/* Select Fast mode */
> +		ccr = LOONGSON2_I2C_CCR_FS;
> +		val = DIV_ROUND_UP(priv->parent_rate, I2C_MAX_FAST_MODE_FREQ * 3);
> +	}
> +
> +	FIELD_MODIFY(LOONGSON2_I2C_CCR_CCR, &ccr, val);
> +	regmap_write(priv->regmap, LOONGSON2_I2C_CCR, ccr);

...somewhere here.

> +	regmap_update_bits(priv->regmap, LOONGSON2_I2C_CR2, LOONGSON2_I2C_CR2_FREQ,
> +			   FIELD_GET(LOONGSON2_I2C_CR2_FREQ, freq_mhz));
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

> +	priv->speed = I2C_MAX_STANDARD_MODE_FREQ;
> +	ret = device_property_read_u32(dev, "clock-frequency", &clk_rate);
> +	if (!ret && clk_rate >= I2C_MAX_FAST_MODE_FREQ)
> +		priv->speed = I2C_MAX_FAST_MODE_FREQ;

Please, use i2c_parse_fw_timings() instead of custom approach.

-- 
With Best Regards,
Andy Shevchenko


