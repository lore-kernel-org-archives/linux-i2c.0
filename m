From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: busses: i2c-pxa.c:  Fix for possible null pointer
 dereferenc
Date: Fri, 04 Jul 2014 09:02:07 +0900
Message-ID: <002401cf971b$32209120$9661b360$%han@samsung.com>
References: <1404418756-10550-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <1404418756-10550-2-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1404418756-10550-2-git-send-email-rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Rickard Strandqvist' <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, 'Grant Likely' <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, 'Rob Herring' <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, 'Leilei Shang' <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, 'Peter Korsgaard' <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Friday, July 04, 2014 5:19 AM, Rickard Strandqvist wrote:
> 
> Fix for possible null pointer dereferenc, and there is a risk
> for memory leak if something unexpected

s/dereferenc/dereference

The columns of this commit is too long.
Please keep about 80 columns.

> happens and the function returns.
> It now use Managed Device Resource instead.

s/use/uses

> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist-IW2WV5XWFqGZkjO+N0TKoMugMpMbD5Xr@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c |   37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index be671f7..2edb633 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1141,10 +1141,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	struct resource *res = NULL;
>  	int ret, irq;
> 
> -	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> +	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
>  	if (!i2c) {
>  		ret = -ENOMEM;
> -		goto emalloc;
> +		goto err_nothing_to_release;
>  	}
> 
>  	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
> @@ -1154,18 +1154,19 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	if (ret > 0)
>  		ret = i2c_pxa_probe_pdata(dev, i2c, &i2c_type);
>  	if (ret < 0)
> -		goto eclk;
> +		goto err_nothing_to_release;
> 
>  	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(dev, 0);
>  	if (res == NULL || irq < 0) {
>  		ret = -ENODEV;
> -		goto eclk;
> +		goto err_nothing_to_release;
>  	}
> 
> -	if (!request_mem_region(res->start, resource_size(res), res->name)) {
> +	if (!devm_request_mem_region(&dev->dev, res->start,
> +				resource_size(res), res->name)) {
>  		ret = -ENOMEM;
> -		goto eclk;
> +		goto emalloc;
>  	}
> 
>  	i2c->adap.owner   = THIS_MODULE;
> @@ -1176,16 +1177,16 @@ static int i2c_pxa_probe(struct platform_device *dev)
> 
>  	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
> 
> -	i2c->clk = clk_get(&dev->dev, NULL);
> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
>  	if (IS_ERR(i2c->clk)) {
>  		ret = PTR_ERR(i2c->clk);
> -		goto eclk;
> +		goto emalloc;
>  	}
> 
> -	i2c->reg_base = ioremap(res->start, resource_size(res));
> -	if (!i2c->reg_base) {
> +	i2c->reg_base = devm_ioremap_resource(&adev->dev, res));
> +	if (IS_ERR(i2c->reg_base)) {
>  		ret = -EIO;
> -		goto eremap;
> +		goto emalloc;
>  	}
> 
>  	i2c->reg_ibmr = i2c->reg_base + pxa_reg_layout[i2c_type].ibmr;
> @@ -1227,10 +1228,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  		i2c->adap.algo = &i2c_pxa_pio_algorithm;
>  	} else {
>  		i2c->adap.algo = &i2c_pxa_algorithm;
> -		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
> -				  dev_name(&dev->dev), i2c);
> +		ret = devm_request_irq(&dev->dev, irq, i2c_pxa_handler,
> +				 IRQF_SHARED, dev_name(&dev->dev), i2c);
>  		if (ret)
> -			goto ereqirq;
> +			goto emalloc;
>  	}
> 
>  	i2c_pxa_reset(i2c);
> @@ -1261,15 +1262,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  eadapt:
>  	if (!i2c->use_pio)
>  		free_irq(irq, i2c);
> -ereqirq:
> -	clk_disable_unprepare(i2c->clk);
> -	iounmap(i2c->reg_base);
> -eremap:
> -	clk_put(i2c->clk);
> -eclk:
> -	kfree(i2c);
>  emalloc:
>  	release_mem_region(res->start, resource_size(res));

This function can be removed, because devm_request_mem_region()
is used. So, please remove release_mem_region().

Best regards,
Jingoo Han

> +err_nothing_to_release:
>  	return ret;
>  }
> 
> --
> 1.7.10.4
