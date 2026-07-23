Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C654459AC3;
	Thu, 23 Jul 2026 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.236.254.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804743; cv=none; b=U4Nkb7sdvfAzAC/W4Z4iOb3gpssZy3ZMFHxCLdk1Rl33794PvQfcqsNMtEfrbNpNoE9056Ew8nDkyKil0kI7D+n+u0QGZNrwUqelmS8SYoHrcnQyv/vM/mTEDO4ReoRQuZ/rALnyxy/Zc+7iiAwP5ExpKWUVTeLh7U60R+DI6XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804743; c=relaxed/simple;
	bh=in9hEhcN7GZIhf5isSbTI+bdoIywHLb1dvz0Fr6zf8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUC2ugvoqynwCy3ilXjq+NSO0HH2Bih2UXizyGpk1Uj09O1IAHSIZ12os1exiaLksV3Uttbx1cdkthyw7I1OVU4BBzR8l6XeSRJbFaQmWFUvh9TBRWc23xrHFdD6QdpwtdyRcAngliqAD0kIAUzdMg1ZD0lqhtTIRzf0k0ZqWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se; spf=pass smtp.mailfrom=lysator.liu.se; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=OJjqPOJu; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=OJjqPOJu; dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b=cDADhrnS; arc=none smtp.client-ip=130.236.254.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lysator.liu.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="OJjqPOJu";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="OJjqPOJu";
	dkim=pass (2048-bit key) header.d=lysator.liu.se header.i=@lysator.liu.se header.b="cDADhrnS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804740;
	bh=in9hEhcN7GZIhf5isSbTI+bdoIywHLb1dvz0Fr6zf8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJjqPOJu8qkHAYgZTQtmLxZ1m3oeDMWIZJrspOG9jU2KR4cLAOOVQhH626KXgzYqn
	 7ANVLw/HvH67/QJ0PjUYgpGtGegI03rrqTGQ47OFYFYs2oF8fq1loRPpCr5O/gWAfX
	 9s4hvf1SmC0NN1+EZFnN0mHn3lRjrV1r4RHMzqSgmCB8pGV2GI8e+NabaUm9p7hDCW
	 HCqZQrDbzJkCSlWVwuP+hUec848qDhmB88rt8zHkx9MjxoL1aIDoxUEc9inv/ldrW2
	 dUo1cHjgcyL5f5a31xDsUn9pt1aS1Lr6j0q4YPomRxVuYGOVfyro/6yS5CMnXx91lL
	 xOIPpjyyi7FeQ==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 26BBC1BA3F;
	Thu, 23 Jul 2026 13:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804740;
	bh=in9hEhcN7GZIhf5isSbTI+bdoIywHLb1dvz0Fr6zf8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJjqPOJu8qkHAYgZTQtmLxZ1m3oeDMWIZJrspOG9jU2KR4cLAOOVQhH626KXgzYqn
	 7ANVLw/HvH67/QJ0PjUYgpGtGegI03rrqTGQ47OFYFYs2oF8fq1loRPpCr5O/gWAfX
	 9s4hvf1SmC0NN1+EZFnN0mHn3lRjrV1r4RHMzqSgmCB8pGV2GI8e+NabaUm9p7hDCW
	 HCqZQrDbzJkCSlWVwuP+hUec848qDhmB88rt8zHkx9MjxoL1aIDoxUEc9inv/ldrW2
	 dUo1cHjgcyL5f5a31xDsUn9pt1aS1Lr6j0q4YPomRxVuYGOVfyro/6yS5CMnXx91lL
	 xOIPpjyyi7FeQ==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
	id 0CDB91B9E5; Thu, 23 Jul 2026 13:05:40 +0200 (CEST)
X-Spam-Level: 
X-Spam-Score: -1.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
	s=2026; t=1784804735;
	bh=in9hEhcN7GZIhf5isSbTI+bdoIywHLb1dvz0Fr6zf8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cDADhrnSooOAJAKlP+6sPGj0ZmHprOaXuXCNwO1rm0KW0Rqbt5pFqHg2dJuvM8jO4
	 8/urmtjseU0trg4HV1gDOchC/QWfMB0NBzT3Y6ZnL85L7pVnUz10cBfWFJ3DCo7O2B
	 3Pc7FR20gSzCiGy+ulFQlBBMCY9nFSRhsXUkqgNUmf4opyW5WtnQBtLkCLeAsTrzPl
	 +CU1up2o0xr4GhrNW7ptRZKrdEWEupLgGktl9E1CqFZ3qOPqwBMVOGUBuWQWS/uzSk
	 oVIbCkGYL1HQTLDlMsLgqnhgP8b7orjWAlIMzt/z0JW7ei6b+MS4/+l67gYVUX0nR0
	 4r0nSwWfogwHA==
Received: from [192.168.2.172] (81-225-28-11-no2391.tbcn.telia.com [81.225.28.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTPSA id 55D2B1BAAF;
	Thu, 23 Jul 2026 13:05:35 +0200 (CEST)
Message-ID: <5df2c584-c63c-4393-99e1-909528f0c085@lysator.liu.se>
Date: Thu, 23 Jul 2026 13:05:35 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/7] i2c: davinci: add support for setting bus
 frequency
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andi Shyti <andi.shyti@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260719-i2c-mux-v12-0-a5010d623a57@gmail.com>
 <20260719-i2c-mux-v12-5-a5010d623a57@gmail.com>
Content-Language: en-US, sv-SE
From: Peter Rosin <peda@lysator.liu.se>
In-Reply-To: <20260719-i2c-mux-v12-5-a5010d623a57@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP

Hi!

On 2026-07-19 16:59, Marcus Folkesson wrote:
> Populate adapter with clock_Hz and .set_clk_freq() to enable support for
> dynamic bus frequency.
> 
> Remove bus_freq_Hz entirely and only use clock_Hz instead.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/i2c/busses/i2c-davinci.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index f543997c31e9..87fef17bca55 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -132,8 +132,6 @@ struct davinci_i2c_dev {
>  #ifdef CONFIG_CPU_FREQ
>  	struct notifier_block	freq_transition;
>  #endif
> -	/* standard bus frequency */
> -	unsigned int		bus_freq_Hz;
>  	/* Chip has a ICPFUNC register */
>  	bool			has_pfunc;
>  };
> @@ -171,6 +169,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>  	u32 clkh;
>  	u32 clkl;
>  	u32 input_clock = clk_get_rate(dev->clk);
> +	u32 bus_freq_Hz = dev->adapter.clock_Hz;
>  
>  	/* NOTE: I2C Clock divider programming info
>  	 * As per I2C specs the following formulas provide prescaler
> @@ -207,16 +206,16 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
>  	if (device_is_compatible(dev->dev, "ti,keystone-i2c"))
>  		d = 6;
>  
> -	clk = (input_clock / (psc + 1)) / (dev->bus_freq_Hz);
> +	clk = (input_clock / (psc + 1)) / (bus_freq_Hz);

Repeat bracket comment from 4/7. I.e.

	clk = input_clock / (psc + 1) / bus_freq_Hz;

Cheers,
Peter

>  	/* Avoid driving the bus too fast because of rounding errors above */
> -	if (input_clock / (psc + 1) / clk > dev->bus_freq_Hz)
> +	if (input_clock / (psc + 1) / clk > bus_freq_Hz)
>  		clk++;
>  	/*
>  	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
>  	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
>  	 * to LOW ratio as 1 to 2 is more safe.
>  	 */
> -	if (dev->bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
> +	if (bus_freq_Hz > I2C_MAX_STANDARD_MODE_FREQ)
>  		clkl = (clk << 1) / 3;
>  	else
>  		clkl = (clk >> 1);
> @@ -267,7 +266,7 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKL_REG));
>  	dev_dbg(dev->dev, "CLKH = %d\n",
>  		davinci_i2c_read_reg(dev, DAVINCI_I2C_CLKH_REG));
> -	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->bus_freq_Hz);
> +	dev_dbg(dev->dev, "bus_freq_Hz = %dHz\n", dev->adapter.clock_Hz);
>  
>  
>  	/* Take the I2C module out of reset: */
> @@ -279,6 +278,23 @@ static int i2c_davinci_init(struct davinci_i2c_dev *dev)
>  	return 0;
>  }
>  
> +static int davinci_i2c_set_clk(struct i2c_adapter *adap, u32 clock_Hz)
> +{
> +	struct davinci_i2c_dev *dev = i2c_get_adapdata(adap);
> +
> +	/* put I2C into reset */
> +	davinci_i2c_reset_ctrl(dev, 0);
> +
> +	/* compute clock dividers */
> +	adap->clock_Hz = clock_Hz;
> +	i2c_davinci_calc_clk_dividers(dev);
> +
> +	/* Take the I2C module out of reset: */
> +	davinci_i2c_reset_ctrl(dev, 1);
> +
> +	return clock_Hz;
> +}
> +
>  /*
>   * This routine does i2c bus recovery by using i2c_generic_scl_recovery
>   * which is provided by I2C Bus recovery infrastructure.
> @@ -755,12 +771,13 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	dev->dev = &pdev->dev;
>  	dev->irq = irq;
>  	platform_set_drvdata(pdev, dev);
> +	adap = &dev->adapter;
>  
>  	r = device_property_read_u32(&pdev->dev, "clock-frequency", &prop);
>  	if (r)
>  		prop = I2C_MAX_STANDARD_MODE_FREQ;
>  
> -	dev->bus_freq_Hz = prop;
> +	adap->clock_Hz = prop;
>  
>  	dev->has_pfunc = device_property_present(&pdev->dev, "ti,has-pfunc");
>  
> @@ -800,7 +817,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> -	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
>  	adap->class = I2C_CLASS_DEPRECATED;
> @@ -809,6 +825,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->timeout = DAVINCI_I2C_TIMEOUT;
>  	adap->dev.of_node = dev_of_node(&pdev->dev);
> +	adap->set_clk_freq = davinci_i2c_set_clk;
>  
>  	if (dev->has_pfunc)
>  		adap->bus_recovery_info = &davinci_i2c_scl_recovery_info;
> 

