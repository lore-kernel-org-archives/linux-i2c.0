From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/6] i2c: davinci: use devm_ functions
Date: Mon, 27 Aug 2012 20:55:50 +0400
Message-ID: <503BA696.6080701@mvista.com>
References: <1345916499-6657-6-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1345916499-6657-6-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello.

On 08/25/2012 09:41 PM, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.

> The call to platform_get_resource is moved down to the call to
> devm_request_and_ioremap that uses it.

> Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>

> ---
> Not compiled.

   I see. :-)

> I was not sure what to do with the comment on the first line, so I just
> left it where it is.
> I was also concerned about the calls to get_device and put_device, and
> whether they would cause &pdev->dev to be freed before the devm-allocated
> objects were freed.  Most other platform drivers don't seem to have these
> calls.

>  drivers/i2c/busses/i2c-davinci.c |   51 +++++++++------------------------------
>  1 file changed, 12 insertions(+), 39 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index b6185dc..c8e9c87 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -647,30 +647,16 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	int r;
>  
>  	/* NOTE: driver uses the static register mapping */
> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem) {
> -		dev_err(&pdev->dev, "no mem resource?\n");
> -		return -ENODEV;
> -	}
> -
>  	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (!irq) {
>  		dev_err(&pdev->dev, "no irq resource?\n");
>  		return -ENODEV;
>  	}
>  
> -	ioarea = request_mem_region(mem->start, resource_size(mem),
> -				    pdev->name);
> -	if (!ioarea) {
> -		dev_err(&pdev->dev, "I2C region already claimed\n");
> -		return -EBUSY;
> -	}

   Shouldn't you have dropped the 'ioarea' variable? It should be unused now...

> @@ -699,14 +685,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
[...]
> -	dev->base = ioremap(mem->start, resource_size(mem));
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

   Why you dropped check form 'mem' being NULL?

> +	dev->base = devm_request_and_ioremap(&pdev->dev, mem);
>  	if (!dev->base) {
>  		r = -EBUSY;
>  		goto err_mem_ioremap;
> @@ -714,16 +701,17 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  
>  	i2c_davinci_init(dev);
>  
> -	r = request_irq(dev->irq, i2c_davinci_isr, 0, pdev->name, dev);
> +	r = devm_request_irq(&pdev->dev, dev->irq, i2c_davinci_isr, 0,
> +			     pdev->name, dev);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure requesting irq %i\n", dev->irq);
> -		goto err_unuse_clocks;
> +		goto err_mem_ioremap;

   The label no longer corresponds the failure happening. Perhaps it's better to
leave 'err_unuse_clocks'...

>  	}
>  
>  	r = i2c_davinci_cpufreq_register(dev);
>  	if (r) {
>  		dev_err(&pdev->dev, "failed to register cpufreq\n");
> -		goto err_free_irq;
> +		goto err_mem_ioremap;

   Ditto...

> @@ -740,26 +728,18 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure adding adapter\n");
> -		goto err_free_irq;
> +		goto err_mem_ioremap;

   Ditto...

WBR, Sergei
