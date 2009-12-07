From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: davinci: Add cpufreq support
Date: Mon, 07 Dec 2009 14:00:14 +0300
Message-ID: <4B1CE03E.7040608@ru.mvista.com>
References: <1260178136-26416-1-git-send-email-chaithrika@ti.com>	<1260178136-26416-2-git-send-email-chaithrika@ti.com>	<1260178136-26416-3-git-send-email-chaithrika@ti.com> <1260178136-26416-4-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260178136-26416-4-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

Chaithrika U S wrote:

> Add cpufreq support for DaVinci I2C driver.
> Tested on DA850/OMAP-L138 EVM. For the purpose of testing, the patches
> which add cpufreq support [1] for this SoC are needed.
>
> [1]http://linux.davincidsp.com/pipermail/davinci-linux-open-source/
> 2009-September/016118.html
>
> Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-davinci.c |   59 +++++++++++++++++++++++++++++++++++++-
>  1 files changed, 58 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 5f0888d..0f41da4 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c

[...]

> @@ -508,6 +517,39 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>  	return count ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> +#ifdef CONFIG_CPU_FREQ
> +static int i2c_davinci_cpufreq_transition(struct notifier_block *nb,
> +				     unsigned long val, void *data)
> +{
> +	struct davinci_i2c_dev *dev;
> +
> +	dev = container_of(nb, struct davinci_i2c_dev, freq_transition);
> +	if (val == CPUFREQ_PRECHANGE) {
> +		wait_for_completion(&dev->xfr_complete);
> +		davinci_i2c_reset_ctrl(dev, 0);
> +	} else if (val == CPUFREQ_POSTCHANGE) {
> +		i2c_davinci_calc_clk_dividers(dev);
> +		davinci_i2c_reset_ctrl(dev, 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int i2c_davinci_cpufreq_register(struct davinci_i2c_dev *dev)
> +{
> +	dev->freq_transition.notifier_call = i2c_davinci_cpufreq_transition;
> +
> +	return cpufreq_register_notifier(&dev->freq_transition,
> +					 CPUFREQ_TRANSITION_NOTIFIER);
> +}
> +
> +static inline void i2c_davinci_cpufreq_deregister(struct davinci_i2c_dev *dev)
> +{
> +	cpufreq_unregister_notifier(&dev->freq_transition,
> +				    CPUFREQ_TRANSITION_NOTIFIER);
> +}
> +#endif
> +
>  static struct i2c_algorithm i2c_davinci_algo = {
>  	.master_xfer	= i2c_davinci_xfer,
>  	.functionality	= i2c_davinci_func,
> @@ -547,6 +589,9 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	}
>  
>  	init_completion(&dev->cmd_complete);
> +#ifdef CONFIG_CPU_FREQ
> +	init_completion(&dev->xfr_complete);
> +#endif
>  	dev->dev = get_device(&pdev->dev);
>  	dev->irq = irq->start;
>  	platform_set_drvdata(pdev, dev);
> @@ -567,6 +612,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  		goto err_unuse_clocks;
>  	}
>  
> +#ifdef CONFIG_CPU_FREQ
> +	r = i2c_davinci_cpufreq_register(dev);
> +	if (r) {
> +		dev_err(&pdev->dev, "failed to register cpufreq\n");
> +		goto err_free_irq;
> +	}
> +#endif
>   

   You should instead define this function as just returning 0 in the 
#else branch above, so that #ifdef here can be avoided...

> +
>  	adap = &dev->adapter;
>  	i2c_set_adapdata(adap, dev);
>  	adap->owner = THIS_MODULE;
> @@ -606,6 +659,10 @@ static int davinci_i2c_remove(struct platform_device *pdev)
>  	struct davinci_i2c_dev *dev = platform_get_drvdata(pdev);
>  	struct resource *mem;
>  
> +#ifdef CONFIG_CPU_FREQ
> +	i2c_davinci_cpufreq_deregister(dev);
> +#endif
> +
>   

   Same comment here. #ifdef's in the function code are frowned upon....

WBR, Sergei
