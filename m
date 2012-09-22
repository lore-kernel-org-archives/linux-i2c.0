From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: i2c-mux-gpio: Use devm_kzalloc instead of
 kzalloc
Date: Sat, 22 Sep 2012 15:09:05 +0200
Message-ID: <20120922150905.643f7604@endymion.delvare>
References: <1348241535-27754-1-git-send-email-maxime.ripard@free-electrons.com>
	<1348241535-27754-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348241535-27754-2-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 21 Sep 2012 17:32:12 +0200, Maxime Ripard wrote:
> Use the devm_kzalloc managed function to stripdown the error and remove
> code.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-gpio.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> index 68b1f8e..fbc400b 100644
> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> @@ -71,7 +71,7 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
> +	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
>  	if (!mux) {
>  		ret = -ENOMEM;
>  		goto alloc_failed;
> @@ -79,11 +79,12 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
>  
>  	mux->parent = parent;
>  	mux->data = *pdata;
> -	mux->adap = kzalloc(sizeof(struct i2c_adapter *) * pdata->n_values,
> -			    GFP_KERNEL);
> +	mux->adap = devm_kzalloc(&pdev->dev,
> +				sizeof(struct i2c_adapter *) * pdata->n_values,
> +				GFP_KERNEL);

Alignment is off by one here.

>  	if (!mux->adap) {
>  		ret = -ENOMEM;
> -		goto alloc_failed2;
> +		goto alloc_failed;
>  	}
>  
>  	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
> @@ -128,9 +129,6 @@ add_adapter_failed:
>  err_request_gpio:
>  	for (; i > 0; i--)
>  		gpio_free(pdata->gpios[i - 1]);
> -	kfree(mux->adap);
> -alloc_failed2:
> -	kfree(mux);
>  alloc_failed:
>  	i2c_put_adapter(parent);
>  
> @@ -150,8 +148,6 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  	i2c_put_adapter(mux->parent);
> -	kfree(mux->adap);
> -	kfree(mux);
>  
>  	return 0;
>  }

Other than this it looks OK.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

I don't know a thing about DT and ARM so I won't review the following
patches of this series. For this reason I will not pick this one in my
tree either, to avoid inter-tree dependencies.

-- 
Jean Delvare
