From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Forcing an adapter onto a bus
Date: Tue, 8 Jan 2008 17:58:04 +0100
Message-ID: <20080108175804.2bb2671b@hyperion.delvare>
References: <9e4733910801030909v70ddc068xfb658bf15c5f8924@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <9e4733910801030909v70ddc068xfb658bf15c5f8924-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jon,

On Thu, 3 Jan 2008 12:09:27 -0500, Jon Smirl wrote:
> If adapter->dev.parent is NULL the current i2c code forces the adapter
> onto the platform bus.  But this may not be what you want on the
> powerpc since it mainly uses of_platform_bus.  What about changing
> this to an error condition and fixing the drivers that don't set it
> right?

I've been there and tried to do that, some times ago. See for example:
http://lists.lm-sensors.org/pipermail/i2c/2007-February/000781.html

I converted a good load of drivers back then but there are still more
to do.

I don't really get the link between the patch below and the fact that
powerpc uses of_platform_bus. With or without your patch, the powerpc
drivers will have to properly declare their parent device.

> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index fce06fd..d0bb1e1 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -346,6 +346,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	struct list_head   *item;
>  	struct i2c_driver  *driver;
> 
> +	if (adap->dev.parent == NULL) {
> +		printk(KERN_ERR "I2C adapter driver [%s] forgot to specify "
> +			 "physical device\n", adap->name);
> +		return -ENODEV;
> +	}
>  	mutex_init(&adap->bus_lock);
>  	mutex_init(&adap->clist_lock);
>  	INIT_LIST_HEAD(&adap->clients);
> @@ -357,11 +362,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  	 * If the parent pointer is not set up,
>  	 * we add this adapter to the host bus.
>  	 */
> -	if (adap->dev.parent == NULL) {
> -		adap->dev.parent = &platform_bus;
> -		pr_debug("I2C adapter driver [%s] forgot to specify "
> -			 "physical device\n", adap->name);
> -	}
>  	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
>  	adap->dev.release = &i2c_adapter_dev_release;
>  	adap->dev.class = &i2c_adapter_class;
> 

I just can't apply this now. We'd first need to convert all the
remaining drivers, so that the change doesn't break them. A first step
in this direction would be to change the debug message into a warning
message, so that driver authors have a chance to see it and fix their
driver (unless you plan to fix them all by yourself.) I seem to
remember that we've done that already at some point in time, but then
stepped back as this appeared to be more work than was worth. But if
you want to go on with this, that's fine with me.

-- 
Jean Delvare
