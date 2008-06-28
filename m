From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 1/1] i2c_gpio: keep probe resident for hotplugged
 devices.
Date: Sat, 28 Jun 2008 11:40:11 +0200
Message-ID: <20080628114011.594cebd0@hyperion.delvare>
References: <20080625145943.941439236@fluff.org>
	<20080625145944.012741187@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080625145944.012741187-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Wed, 25 Jun 2008 15:59:44 +0100, Ben Dooks wrote:
> Change the i2c_gpio driver to use platform_driver_register()
> instead of platform_driver_probe() to ensure that is can
> attach to any devices that may be loaded after it has initialised.
> 
> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> 
> --- linux-2.6.26-rc5-quilt1.orig/drivers/i2c/busses/i2c-gpio.c	2008-06-11 00:17:08.000000000 +0100
> +++ linux-2.6.26-rc5-quilt1/drivers/i2c/busses/i2c-gpio.c	2008-06-11 00:18:00.000000000 +0100
> @@ -77,7 +77,7 @@ static int i2c_gpio_getscl(void *data)
>  	return gpio_get_value(pdata->scl_pin);
>  }
>  
> -static int __init i2c_gpio_probe(struct platform_device *pdev)
> +static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  {
>  	struct i2c_gpio_platform_data *pdata;
>  	struct i2c_algo_bit_data *bit_data;
> @@ -196,6 +196,7 @@ static struct platform_driver i2c_gpio_d
>  		.name	= "i2c-gpio",
>  		.owner	= THIS_MODULE,
>  	},
> +	.probe		= i2c_gpio_probe,
>  	.remove		= __exit_p(i2c_gpio_remove),
>  };
>  
> @@ -203,7 +204,7 @@ static int __init i2c_gpio_init(void)
>  {
>  	int ret;
>  
> -	ret = platform_driver_probe(&i2c_gpio_driver, i2c_gpio_probe);
> +	ret = platform_driver_register(&i2c_gpio_driver);
>  	if (ret)
>  		printk(KERN_ERR "i2c-gpio: probe failed: %d\n", ret);
>  
> 

This patch looks incomplete to me. If the device can be hot-plugged, I
guess it can be hot-unplugged as well? Then i2c_gpio_remove should be
__devexit, not __exit.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
