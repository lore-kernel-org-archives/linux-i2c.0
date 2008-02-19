From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-s3c2410: Pass I2C bus number via platform data
Date: Tue, 19 Feb 2008 18:06:13 +0100
Message-ID: <20080219180613.0e635a4f@hyperion.delvare>
References: <20080131112452.859942220@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080131112452.859942220-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
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

On Thu, 31 Jan 2008 11:24:53 +0000, Ben Dooks wrote:
> Allow the platform data to specify the bus bumber of the
> I2C bus (or automatically choose one) for the driver.
> 
> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Review:

> 
> Index: linux-2.6.22-16/drivers/i2c/busses/i2c-s3c2410.c
> ===================================================================
> --- linux-2.6.22-16.orig/drivers/i2c/busses/i2c-s3c2410.c
> +++ linux-2.6.22-16/drivers/i2c/busses/i2c-s3c2410.c
> @@ -753,9 +753,12 @@ static int s3c24xx_i2c_init(struct s3c24
>  static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  {
>  	struct s3c24xx_i2c *i2c = &s3c24xx_i2c;
> +	struct s3c2410_platform_i2c *pdata;
>  	struct resource *res;
>  	int ret;
>  
> +	pdata = s3c24xx_i2c_get_platformdata(&pdev->dev);
> +
>  	/* find the clock and enable it */
>  
>  	i2c->dev = &pdev->dev;
> @@ -833,7 +836,17 @@ static int s3c24xx_i2c_probe(struct plat
>  	dev_dbg(&pdev->dev, "irq resource %p (%lu)\n", res,
>  		(unsigned long)res->start);
>  
> -	ret = i2c_add_adapter(&i2c->adap);
> +	i2c->adap.nr = pdata->bus_num;

This should be moved...

> +
> +	/* if there is no bus specified, then use a dynamic number to
> +	 * register. If there has been none set (ie, 0) then you will
> +	 * get i2c bus 0. */
> +
> +	if (pdata->bus_num < 0)
> +		ret = i2c_add_adapter(&i2c->adap);
> +	else

... here. You aren't supposed to set i2c->adap.nr if you don't call
i2c_add_numbered_adapter().

> +		ret = i2c_add_numbered_adapter(&i2c->adap);
> +
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
>  		goto err_irq;
> Index: linux-2.6.22-16/include/asm-arm/plat-s3c/iic.h
> ===================================================================
> --- linux-2.6.22-16.orig/include/asm-arm/plat-s3c/iic.h
> +++ linux-2.6.22-16/include/asm-arm/plat-s3c/iic.h
> @@ -13,6 +13,8 @@
>  #ifndef __ASM_ARCH_IIC_H
>  #define __ASM_ARCH_IIC_H __FILE__
>  
> +#define S3C_IIC_BUS_AUTO	(-1)	/* use next available bus number */
> +
>  #define S3C_IICFLG_FILTER	(1<<0)	/* enable s3c2440 filter */
>  
>  /* Notes:
> @@ -21,6 +23,7 @@
>  */
>  
>  struct s3c2410_platform_i2c {
> +	int		bus_num;	/* bus number to use */
>  	unsigned int	flags;
>  	unsigned int	slave_addr;	/* slave address for controller */
>  	unsigned long	bus_freq;	/* standard bus frequency */
> 

Other than that the patch looks OK to me, although I am wondering if
it's not more complex than it needs to be. Other i2c bus drivers for
embedded platforms call i2c_add_numbered_adapter() unconditionally,
using the platform device id to set the bus number. This takes less
code. Maybe you should consider this for the s3c24xx platform, unless
there are additional constraints I do not know.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
