From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: nomadik: adopt pinctrl support
Date: Thu, 24 Jan 2013 08:28:35 +0100
Message-ID: <20130124072835.GN8364@nekote.pengutronix.de>
References: <1357515117-21992-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1357515117-21992-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anmar Oueja <anmar.oueja-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> @@ -857,15 +885,44 @@ static int nmk_i2c_suspend(struct device *dev)
>  {
>  	struct amba_device *adev = to_amba_device(dev);
>  	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
> +	int ret;
>  
>  	if (nmk_i2c->busy)
>  		return -EBUSY;
>  
> +	if (!IS_ERR(nmk_i2c->pins_sleep)) {
> +		ret = pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_sleep);
> +		if (ret)
> +			dev_err(dev,
> +				"could not set pins to sleep state\n");

One line please.

> +	}
> +
>  	return 0;
>  }
>  
>  static int nmk_i2c_resume(struct device *dev)
>  {
> +	struct amba_device *adev = to_amba_device(dev);
> +	struct nmk_i2c_dev *nmk_i2c = amba_get_drvdata(adev);
> +	int ret;
> +
> +	/* First go to the default state */
> +	if (!IS_ERR(nmk_i2c->pins_default)) {
> +		ret = pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_default);
> +		if (ret)
> +			dev_err(dev,

One line please.

> +				"could not set pins to default state\n");
> +	}
> +	/* Then let's idle the pins until the next transfer happens */
> +	if (!IS_ERR(nmk_i2c->pins_idle)) {
> +		ret = pinctrl_select_state(nmk_i2c->pinctrl,
> +				nmk_i2c->pins_idle);
> +		if (ret)
> +			dev_err(dev,
> +				"could not set pins to idle state\n");

One line please.

> +	}
>  	return 0;
>  }
>  #else
> @@ -953,6 +1010,40 @@ static int nmk_i2c_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev->adev = adev;
>  	amba_set_drvdata(adev, dev);
>  
> +	dev->pinctrl = devm_pinctrl_get(&adev->dev);
> +	if (IS_ERR(dev->pinctrl)) {
> +		ret = PTR_ERR(dev->pinctrl);
> +		goto err_pinctrl;
> +	}
> +
> +	dev->pins_default = pinctrl_lookup_state(dev->pinctrl,
> +						 PINCTRL_STATE_DEFAULT);
> +	if (IS_ERR(dev->pins_default))
> +		dev_err(&adev->dev, "could not get default pinstate\n");
> +	else {

braces before else, please.

> +		ret = pinctrl_select_state(dev->pinctrl,
> +					   dev->pins_default);
> +		if (ret)
> +			dev_dbg(&adev->dev, "could not set default pinstate\n");
> +	}
> +
> +	dev->pins_idle = pinctrl_lookup_state(dev->pinctrl,
> +					      PINCTRL_STATE_IDLE);
> +	if (IS_ERR(dev->pins_idle))
> +		dev_dbg(&adev->dev, "could not get idle pinstate\n");
> +	else {

braces before else, please.

> +		/* If possible, let's go to idle until the first transfer */
> +		ret = pinctrl_select_state(dev->pinctrl,
> +					   dev->pins_idle);
> +		if (ret)
> +			dev_dbg(&adev->dev, "could not set idle pinstate\n");
> +	}
> +
> +	dev->pins_sleep = pinctrl_lookup_state(dev->pinctrl,
> +					       PINCTRL_STATE_SLEEP);
> +	if (IS_ERR(dev->pins_sleep))
> +		dev_dbg(&adev->dev, "could not get sleep pinstate\n");
> +

Thanks,

   Wolfram
