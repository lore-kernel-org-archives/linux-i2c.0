From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [1/7] i2c-designware: move to managed functions (devm_*)
Date: Tue, 9 Apr 2013 11:00:32 +0200
Message-ID: <20130409090032.GA28509@the-dreams.de>
References: <1363867800-23861-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1363867800-23861-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, ben-linux@fluff.org, Jean Delvare <khali@linux-fr.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christian Ruppert <christian.ruppert@abilis.com>
List-Id: linux-i2c@vger.kernel.org


> @@ -108,32 +108,27 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  		return irq; /* -ENXIO */
>  	}
>  
> -	ioarea = request_mem_region(mem->start, resource_size(mem),
> -			pdev->name);
> -	if (!ioarea) {
> -		dev_err(&pdev->dev, "I2C region already claimed\n");
> -		return -EBUSY;
> -	}
> +	dev = devm_kzalloc(&pdev->dev, sizeof(struct dw_i2c_dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
>  
> -	dev = kzalloc(sizeof(struct dw_i2c_dev), GFP_KERNEL);
> -	if (!dev) {
> -		r = -ENOMEM;
> -		goto err_release_region;
> +	dev->base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(dev->base)) {
> +		dev_err(&pdev->dev, "I2C region already claimed\n");

No dev_err here. The devm function will print out errors already.

> @@ -164,13 +152,14 @@ static int dw_i2c_probe(struct platform_device *pdev)
>  	}
>  	r = i2c_dw_init(dev);
>  	if (r)
> -		goto err_iounmap;
> +		return r;
>  
>  	i2c_dw_disable_int(dev);
> -	r = request_irq(dev->irq, i2c_dw_isr, IRQF_SHARED, pdev->name, dev);
> +	r = devm_request_irq(&pdev->dev, dev->irq, i2c_dw_isr, IRQF_SHARED,
> +			pdev->name, dev);

Is it ensured that no interrupts will happen during remove? Because the
adapter will be deleted before devm will free the interrupt.

Thanks,

   Wolfram
