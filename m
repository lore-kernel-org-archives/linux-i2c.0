From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 02/12] i2c: meson: remove member irq from struct
 meson_i2c
Date: Wed, 08 Mar 2017 10:07:35 +0100
Message-ID: <1488964055.2514.3.camel@baylibre.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
         <814868c2-af8c-23d0-db19-84d597fe713d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35592 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdCHJfi (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 04:35:38 -0500
Received: by mail-wm0-f48.google.com with SMTP id v186so109950658wmd.0
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 01:35:07 -0800 (PST)
In-Reply-To: <814868c2-af8c-23d0-db19-84d597fe713d@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-03-08 at 07:43 +0100, Heiner Kallweit wrote:
> Member irq can be replaced with a local variable in probe
> because it's nowhere else accessed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-
> meson.c
> index 40e5da9a..50059d09 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -82,7 +82,6 @@ struct meson_i2c {
>  	struct device		*dev;
>  	void __iomem		*regs;
>  	struct clk		*clk;
> -	int			irq;
>  
>  	struct i2c_msg		*msg;
>  	int			state;
> @@ -391,7 +390,7 @@ static int meson_i2c_probe(struct platform_device
> *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct meson_i2c *i2c;
>  	struct resource *mem;
> -	int ret = 0;
> +	int irq, ret = 0;
>  
>  	i2c = devm_kzalloc(&pdev->dev, sizeof(struct meson_i2c),
> GFP_KERNEL);
>  	if (!i2c)
> @@ -418,14 +417,14 @@ static int meson_i2c_probe(struct
> platform_device *pdev)
>  	if (IS_ERR(i2c->regs))
>  		return PTR_ERR(i2c->regs);
>  
> -	i2c->irq = platform_get_irq(pdev, 0);
> -	if (i2c->irq < 0) {
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
>  		dev_err(&pdev->dev, "can't find IRQ\n");
> -		return i2c->irq;
> +		return irq;
>  	}
>  
> -	ret = devm_request_irq(&pdev->dev, i2c->irq, meson_i2c_irq,
> -			       0, dev_name(&pdev->dev), i2c);
> +	ret = devm_request_irq(&pdev->dev, irq, meson_i2c_irq, 0,
> +			       dev_name(&pdev->dev), i2c);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "can't request IRQ\n");
>  		return ret;

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
