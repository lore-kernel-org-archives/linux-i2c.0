Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE18466AEC;
	Thu, 23 Jul 2026 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804733; cv=none; b=k7VMiOtZjlyoCQPrcpoj9hak/6UzTvaJR0Bnh77Bu4MYnAWeYLIW/CTjxrtjGJxTUEJzkmhjdKwHL+goyeXewYzFw46FOEfkLT+Nf4LeLj9xTxC0ESJof1npkztYk2x8aZSExb0kP7JgzXwRcVldOwcH/Ie66lfGPsYrFxvOvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804733; c=relaxed/simple;
	bh=YihPJyE3Si2dwoMq60eb7rEWr/RemrZtosY6FUWafRQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NXLVIAU5Ok7nYEdnut+dbh8KoFwpvD627yXxDACupO/vSsTIxH9ngZZLebvByuwne0v8Bh+mVr1pwpdzwiwmPI4jVjYEUfNmZx0Ql519D6M2SGa4V0K5yn15X2U2Tx2e0mtnzyOPmWmL/CONZKdc4k+wpOuO3pxq3gDROfK/mSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=TaeveSBJ; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=fjMHBomt; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=juun7K1f; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="TaeveSBJ";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="fjMHBomt";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="juun7K1f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804729;
	bh=YihPJyE3Si2dwoMq60eb7rEWr/RemrZtosY6FUWafRQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=TaeveSBJk+YMoTZ60rUXthqP9TzdiwgJm9Cc+tXv1ZtF1NJ4InxULCQZ9+OuXna3O
	 CVcVNYdEiYXDNt1PzJ2BZF9MFbsMlTp+IQB4F3YIegnqnrvM3wwWP7Uk9g0GPPXFSX
	 b5kyV3Q5pcA/RlmGXbBIQOn7f2V2LYMRx/gsg810cOwVyzgNqecRHbYpuysDO9QU6e
	 +7uepZb6/hboy/G3N2pr1AXUe9HCMonoYARJHtnzv//o13XWhlKVrpgl/U3Sa+tjHg
	 lfIDbGuZ1SRLYccymjAozwGJkHCgObTnQzq65V8DjLd6fdwaLQcXds0GOlDB0r8pLY
	 0M+IyzOD10IqA==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 089AF1BAAD;
	Thu, 23 Jul 2026 13:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804728;
	bh=YihPJyE3Si2dwoMq60eb7rEWr/RemrZtosY6FUWafRQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=fjMHBomtbv6uFNkJ4l1aeZqxWtr6/LY7wqP4wJwUgDpYkmaPBO5FplA5E3VCNdNhP
	 JBhQANmXp9+1eEAlUBMroYkFbuKLmIZh+qDlZ18TQsoRPIP5ca9H79PyAc/TWqhruh
	 979EjQLonSZ+grUvaDNzwGgGjGuE27yidJptsJfFjoFu5T7nS9JRGDfz7QXU4vrH0w
	 NkZDIszvafwmhJei6bQZd55EhHrmFwnBy1O8tlhzScgnEq8YF9/elPiARtpwSqf+Jo
	 GDjx4R7rg7mQGQT6FEj9qNY54FkOO/rb02hwzDsVuorN+v8TsBjdYlc2helNutsWTD
	 OH8vaBu36Jhyg==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id E17BA1BAAC; Thu, 23 Jul 2026 13:05:28 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804724;
	bh=YihPJyE3Si2dwoMq60eb7rEWr/RemrZtosY6FUWafRQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=juun7K1ft/J3QuLU2Dg9JAgoPyPFX+rYwfX5Gcfe5cnDmdxmYghJvagQXtY9OM9T+
	 /zAPnyO+g1eBC47v4xK6vJGast7t2v2oPvxel59DDmJ5vDUd1h1DlLPRA8tfYSO7Bq
	 AJuA0p7Pn5eIZUQhe/udnSBD6SdmYuEuXP9XR/icfmvh2DMw97uLQ23fsM9bw48Osb
	 4e630togwa0fVldDiUXWMlxM2o+SFqjTHhAuT3ju3ZHPhtkRWbWmZMoLjYFQKmclbb
	 yYLtGlbF/S91xUNZ5K6R/FGyE7o5Z2mFYTnLC5UQEgwxt735TG7G2W3KVLnmi7soWS
	 stg1Z4LVOq0cQ==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 80BDF1BAAA;
	Thu, 23 Jul 2026 13:05:24 +0200 (CEST)
Message-ID: <66e7e285-9ead-4caf-90d6-9dbbb9d86c54@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:05:24 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Peter Rosin <peda@lysator.liu.se>
Subject: Re: [PATCH v12 4/7] i2c: davinci: calculate bus freq from Hz instead
 of kHz
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-4-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
In-Reply-To: <20260719-i2c-mux-v12-4-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> The bus frequency is unnecessarily converted between Hz and kHz in
> several places.
> This is probably an old legacy from the old times (pre-devicetrees)
> when the davinci_i2c_platform_data took the bus_freq in kHz.
> 
> Stick to Hz.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>   drivers/i2c/busses/i2c-davinci.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index e15eef163a8f..f543997c31e9 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -132,8 +132,8 @@ struct davinci_i2c_dev {
>   #ifdef CONFIG_CPU_FREQ
>   	struct notifier_block	freq_transition;
>   #endif
> -	/* standard bus frequency (kHz) */
> -	unsigned int		bus_freq;
> +	/* standard bus frequency */
> +	unsigned int		bus_freq_Hz;
>   	/* Chip has a ICPFUNC register */
>   	bool			has_pfunc;
>   };
> @@ -207,16 +207,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>   	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
>   		d = 6;
>   
> -	clk = ((input_clock / (psc + 1)) / (dev->bus_freq * 1000));
> +	clk = (input_clock / (psc + 1)) / (dev->bus_freq_Hz);

You can lose some brackets, e.g.

	clk = input_clock / (psc + 1) / dev->bus_freq_Hz;

Cheers,
Peter

>   	/* Avoid driving the bus too fast because of rounding errors above */
> -	if (input_clock / (psc + 1) / clk > dev->bus_freq * 1000)
> +	if (input_clock / (psc + 1) / clk > dev->bus_freq_Hz)
>   		clk++;
>   	/*
>   	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
>   	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
>   	 * to LOW ratio as 1 to 2 is more safe.
>   	 */
> -	if (dev->bus_freq > 100)
> +	if (dev->bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
>   		clkl = (clk << 1) / 3;
>   	else
>   		clkl = (clk >> 1);
> @@ -240,7 +240,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>   	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
>   	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKL_REG, clkl);
>   
> -	dev_dbg(dev->dev, "input_clock = %d, CLK = %d\n", input_clock, clk);
> +	dev_dbg(dev->dev, "input_clock = %u, CLK = %u\n", input_clock, clk);
>   }
>   
>   /*
> @@ -267,7 +267,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>   		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
>   	dev_dbg(dev->dev, "CLKH = %d\n",
>   		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
> -	dev_dbg(dev->dev, "bus_freq = %dkHz\n", dev->bus_freq);
> +	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->bus_freq_Hz);
>   
>   
>   	/* Take the I2C module out of reset: */
> @@ -760,7 +760,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>   	if (r)
>   		prop = I2C_MAX_STANDARD_MODE_FREQ;
>   
> -	dev->bus_freq = prop / 1000;
> +	dev->bus_freq_Hz = prop;
>   
>   	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
>   
> 

