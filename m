From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 2/2] i2c/designware: Provide i2c bus recovery support
Date: Thu, 24 Jan 2013 08:24:56 +0100
Message-ID: <20130124072456.GB8364@nekote.pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <7f319334237d8cfad4e6d29499d7424c3e739608.1354502924.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7f319334237d8cfad4e6d29499d7424c3e739608.1354502924.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 03, 2012 at 08:24:05AM +0530, Viresh Kumar wrote:
> Add bus recovery support for designware_i2c controller. It uses generic gpio
> based i2c_gpio_recover_bus() routine. Platforms need to pass struct
> i2c_bus_recovery_info as platform data designware I2C controller.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> V7->V8:
> - Removed setting clock_rate_khz.
> 
>  drivers/i2c/busses/i2c-designware-core.c    |  6 +++++-
>  drivers/i2c/busses/i2c-designware-platdrv.c | 17 +++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
> index cbba7db..24feaaf 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -538,7 +538,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>  	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
>  	if (ret == 0) {
>  		dev_err(dev->dev, "controller timed out\n");
> -		i2c_dw_init(dev);
> +		if (adap->bus_recovery_info) {
> +			dev_dbg(dev->dev, "try i2c bus recovery\n");
> +			adap->bus_recovery_info->recover_bus(adap);
> +		}
> +

I think we need something like i2c_recover_bus in the core which does
the above and also returns the return code from recover_bus. If there is
no recover_bus it should return EOPNOTSUPP.

Then the driver can do

	ret = i2c_recover_bus(adap);
	if (ret < 0)
		i2c_dw_init();

If not calling i2c_dw_init, you will probably cause a regression.

>  		ret = -ETIMEDOUT;
>  		goto done;
>  	} else if (ret < 0)
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0506fef..8c44eb9 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -55,6 +55,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev;
>  	struct i2c_adapter *adap;
>  	struct resource *mem, *ioarea;
> +	struct i2c_bus_recovery_info *recovery_info;
>  	int irq, r;
>  
>  	/* NOTE: driver uses the static register mapping */
> @@ -141,17 +142,27 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  
> +	/* Bus recovery support */
> +	recovery_info = dev_get_platdata(&pdev->dev);
> +	if (recovery_info) {
> +		recovery_info->recover_bus = i2c_generic_gpio_recovery;
> +		adap->bus_recovery_info = recovery_info;
> +	} else {
> +		adap->bus_recovery_info = NULL;
> +	}
> +

Please post the platform patch next time, too. Then I can get a better
understanding...

>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
>  	if (r) {
>  		dev_err(&pdev->dev, "failure adding adapter\n");
> -		goto err_free_irq;
> +		goto err_free_recovery_info;
>  	}
>  	of_i2c_register_devices(adap);
>  
>  	return 0;
>  
> -err_free_irq:
> +err_free_recovery_info:
> +	kfree(recovery_info);

... because I am wondering about the kfree here.

>  	free_irq(dev->irq, dev);
>  err_iounmap:
>  	iounmap(dev->base);
> @@ -174,6 +185,8 @@ static int __devexit dw_i2c_remove(struct platform_device *pdev)
>  	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
>  	struct resource *mem;
>  
> +	kfree(dev->adapter.bus_recovery_info);
> +
>  	platform_set_drvdata(pdev, NULL);
>  	i2c_del_adapter(&dev->adapter);
>  	put_device(&pdev->dev);
> -- 
> 1.7.12.rc2.18.g61b472e
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
