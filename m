From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 7/7] i2c: designware: style changes in existing code
Date: Wed, 28 Dec 2016 17:50:23 +0200
Message-ID: <1482940223.9552.167.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <4ff96e7320ebaef28c0ccb47c29bd9a2fe16027c.1482934380.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4ff96e7320ebaef28c0ccb47c29bd9a2fe16027c.1482934380.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> Replaced all the return variables 'r' in the existing
> code by 'ret' to make the code easier to read (and
> more standard).

I'm not sure it makes sense as a separate change.

> 
> Signed-off-by: Luis Oliveira <lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
> ---
> Changes V4->V5: (Andy Shevchenko)
> - Replaced all the old code using "r" as return to "ret". For
> consistency 
> purposes.
> 
>  drivers/i2c/busses/i2c-designware-master.c  | 30 ++++++++++++++----
> -----------
>  drivers/i2c/busses/i2c-designware-platdrv.c | 16 +++++++--------
>  2 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-master.c
> b/drivers/i2c/busses/i2c-designware-master.c
> index b55a7f4c5149..0d5aca6edb48 100644
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -644,18 +644,18 @@ EXPORT_SYMBOL_GPL(i2c_dw_read_comp_param);
>  int i2c_dw_probe(struct dw_i2c_dev *dev)
>  {
>  	struct i2c_adapter *adap = &dev->adapter;
> -	int r;
> +	int ret;
>  	u32 reg;
>  
>  	init_completion(&dev->cmd_complete);
>  
> -	r = i2c_dw_init(dev);
> -	if (r)
> -		return r;
> +	ret = i2c_dw_init(dev);
> +	if (ret)
> +		return ret;
>  
> -	r = i2c_dw_acquire_lock(dev);
> -	if (r)
> -		return r;
> +	ret = i2c_dw_acquire_lock(dev);
> +	if (ret)
> +		return ret;
>  
>  	/*
>  	 * Test if dynamic TAR update is enabled in this controller
> by writing
> @@ -681,13 +681,13 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>  	i2c_set_adapdata(adap, dev);
>  
>  	i2c_dw_disable_int(dev);
> -	r = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
> +	ret = devm_request_irq(dev->dev, dev->irq, i2c_dw_isr,
>  			     IRQF_SHARED | IRQF_COND_SUSPEND,
>  			     dev_name(dev->dev), dev);
> -	if (r) {
> +	if (ret) {
>  		dev_err(dev->dev, "failure requesting irq %i: %d\n",
> -			dev->irq, r);
> -		return r;
> +			dev->irq, ret);
> +		return ret;
>  	}
>  
>  	/*
> @@ -697,12 +697,12 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
>  	 * registered I2C slaves that do I2C transfers in their
> probe.
>  	 */
>  	pm_runtime_get_noresume(dev->dev);
> -	r = i2c_add_numbered_adapter(adap);
> -	if (r)
> -		dev_err(dev->dev, "failure adding adapter: %d\n", r);
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret)
> +		dev_err(dev->dev, "failure adding adapter: %d\n",
> ret);
>  	pm_runtime_put_noidle(dev->dev);
>  
> -	return r;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_probe);
>  
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index ef75031f8a62..785f4380c9a9 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -234,7 +234,7 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	struct fwnode_handle *child;
>  	u32 acpi_speed, ht = 0;
>  	struct resource *mem;
> -	int irq, r;
> +	int irq, ret;
>  	u32 reg;
>  
>  	irq = platform_get_irq(pdev, 0);
> @@ -293,9 +293,9 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	r = i2c_dw_eval_lock_support(dev);
> -	if (r)
> -		return r;
> +	ret = i2c_dw_eval_lock_support(dev);
> +	if (ret)
> +		return ret;
>  
>  	if (ACPI_HANDLE(&pdev->dev) == NULL) {
>  		device_for_each_child_node(&pdev->dev, child) {
> @@ -336,14 +336,14 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	}
>  
>  	if (dev->mode == DW_IC_SLAVE)
> -		r = i2c_dw_probe_slave(dev);
> +		ret = i2c_dw_probe_slave(dev);
>  	else
> -		r = i2c_dw_probe(dev);
> +		ret = i2c_dw_probe(dev);
>  
> -	if (r && !dev->pm_runtime_disabled)
> +	if (ret && !dev->pm_runtime_disabled)
>  		pm_runtime_disable(&pdev->dev);
>  
> -	return r;
> +	return ret;
>  }
>  
>  static int dw_i2c_plat_remove(struct platform_device *pdev)

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
