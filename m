From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 08/13] i2c/i2c-nomadik: use pm_runtime API
Date: Tue, 10 May 2011 23:19:48 +0100
Message-ID: <20110510221948.GA634@freya.fluff.org>
References: <1304977077-31661-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1304977077-31661-1-git-send-email-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, May 09, 2011 at 11:37:57PM +0200, Linus Walleij wrote:
> From: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> 
> Use the pm_runtime API for pins control.
> 
> Signed-off-by: Rabin Vincent <rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-nomadik.c |   51 +++++++++++++++++++++++++++++++++----
>  1 files changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
> index c8bf81a..f3a0af0 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -23,6 +23,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <plat/i2c.h>
>  
> @@ -576,6 +577,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  
>  	if (dev->regulator)
>  		regulator_enable(dev->regulator);
> +	pm_runtime_get_sync(&dev->pdev->dev);
>  
>  	status = init_hw(dev);
>  	if (status)
> @@ -634,6 +636,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
>  out:
>  	clk_disable(dev->clk);
>  out2:
> +	pm_runtime_put_sync(&dev->pdev->dev);
>  	if (dev->regulator)
>  		regulator_disable(dev->regulator);
>  
> @@ -839,19 +842,50 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
>  
>  
>  #ifdef CONFIG_PM
> -static int nmk_i2c_suspend(struct platform_device *pdev, pm_message_t mesg)
> +static int nmk_i2c_suspend(struct device *dev)
>  {
> -	struct nmk_i2c_dev *dev = platform_get_drvdata(pdev);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct nmk_i2c_dev *nmk_i2c = platform_get_drvdata(pdev);
>  
> -	if (dev->busy)
> +	if (nmk_i2c->busy)
>  		return -EBUSY;
> -	else
> -		return 0;
> +
> +	/*
> +	 * During system suspend, runtime suspend transitions are disabled.
> +	 * This check and direct call are here so that even if some driver
> +	 * performs i2c transactions in its suspend rountine, we would properly
> +	 * runtime suspend the i2c driver.
> +	 */
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_suspend)
> +			dev->bus->pm->runtime_suspend(dev);
> +

surely there must be better way of calling this?

> +	return 0;
> +}

> +static int nmk_i2c_resume(struct device *dev)
> +{
> +	if (!pm_runtime_suspended(dev))
> +		if (dev->bus && dev->bus->pm && dev->bus->pm->runtime_resume)
> +			dev->bus->pm->runtime_resume(dev);
> +
> +	return 0;

ditto.

>  }
>  #else
>  #define nmk_i2c_suspend	NULL
> +#define nmk_i2c_resume	NULL
>  #endif
>  
> +/*
> + * We use noirq so that we suspend late and resume before the wakeup interrupt
> + * to ensure that we do the !pm_runtime_suspended() check in resume before
> + * there has been a regular pm runtime resume (via pm_runtime_get_sync()).
> + */
> +static const struct dev_pm_ops nmk_i2c_pm = {
> +	.suspend_noirq	= nmk_i2c_suspend,
> +	.resume_noirq	= nmk_i2c_resume,
> +};
> +
>  static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
>  {
>  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> @@ -913,6 +947,9 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
>  		dev->regulator = NULL;
>  	}
>  
> +	pm_suspend_ignore_children(&pdev->dev, true);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	dev->clk = clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(dev->clk)) {
>  		dev_err(&pdev->dev, "could not get i2c clock\n");
> @@ -958,6 +995,7 @@ static int __devinit nmk_i2c_probe(struct platform_device *pdev)
>   err_no_clk:
>  	if (dev->regulator)
>  		regulator_put(dev->regulator);
> +	pm_runtime_disable(&pdev->dev);
>  	free_irq(dev->irq, dev);
>   err_irq:
>  	iounmap(dev->virtbase);
> @@ -990,6 +1028,7 @@ static int __devexit nmk_i2c_remove(struct platform_device *pdev)
>  	clk_put(dev->clk);
>  	if (dev->regulator)
>  		regulator_put(dev->regulator);
> +	pm_runtime_disable(&pdev->dev);
>  	platform_set_drvdata(pdev, NULL);
>  	kfree(dev);
>  
> @@ -1000,10 +1039,10 @@ static struct platform_driver nmk_i2c_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = DRIVER_NAME,
> +		.pm = &nmk_i2c_pm,
>  	},
>  	.probe = nmk_i2c_probe,
>  	.remove = __devexit_p(nmk_i2c_remove),
> -	.suspend = nmk_i2c_suspend,
>  };

the rest looks ok.
