From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH-V2 07/12] i2c:pxa: Use devm_ variants in probe function
Date: Fri, 03 Jul 2015 17:28:02 +0200
Message-ID: <873815clbx.fsf@belgarion.home>
References: <vaibhav.hiremath@linaro.org>
	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1434383399-2370-8-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> @@ -1201,16 +1201,17 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  
>  	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
>  
> -	i2c->clk = clk_get(&dev->dev, NULL);
> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
>  	if (IS_ERR(i2c->clk)) {
> -		ret = PTR_ERR(i2c->clk);
> -		goto eclk;
> +		dev_err(&dev->dev, "failed to get the clk\n");
For consistency's sake, please use :
		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));

Once that is done, you can add my :
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

-- 
Robert
