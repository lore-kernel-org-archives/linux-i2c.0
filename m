From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Wed, 15 Oct 2008 14:19:14 +0200
Message-ID: <20081015141914.7d6c3dd5@hyperion.delvare>
References: <20080821.024322.35962617.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080821.024322.35962617.davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Cc: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Thu, 21 Aug 2008 02:43:22 -0700 (PDT), David Miller wrote:
> 
> i2c-pcf: Add adapter hooks around xfer begin and end.
> 
> Some I2C bus implementations need to synchronize with external
> entities, such as system firmware, which might also be programming the
> same I2C bus.
> 
> In order to facilitate this add ->xfer_begin() and ->xfer_end() hooks
> which are invoked around pcf_xfer().

I get the idea, but I'm not sure about the implementation. I had a
request several months ago for something similar for the i2c-algo-bit
driver. I don't think we want to duplicate this mechanism in every
i2c-algo driver, so it would probably make sense to implement it
at the i2c-core level?

Michael, do you still need this for i2c-algo-bit? We did not discuss
this again recently, so I admit I don't know what is the status of this
request.

Probably only bus drivers which rely on an abstracted algorithm driver
will ever need this. Or maybe not... maybe it could be used later to
synchronize SMBus access between ACPI and native drivers?

Of course we can start with a local implementation in i2c-algo-pcf and
we move it to i2c-core later if needed.

More comments below:

> 
> Signed-off-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
> 
> diff --git a/drivers/i2c/algos/i2c-algo-pcf.c b/drivers/i2c/algos/i2c-algo-pcf.c
> index a8a5b6d..b57bc9a 100644
> --- a/drivers/i2c/algos/i2c-algo-pcf.c
> +++ b/drivers/i2c/algos/i2c-algo-pcf.c
> @@ -331,13 +331,15 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
>  	int i;
>  	int ret=0, timeout, status;
>      
> +	adap->xfer_begin(adap->data);
>  
>  	/* Check for bus busy */
>  	timeout = wait_for_bb(adap);
>  	if (timeout) {
>  		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
>  		            "Timeout waiting for BB in pcf_xfer\n");)
> -		return -EIO;
> +		i = -EIO;
> +		goto out;
>  	}
>  	
>  	for (i = 0;ret >= 0 && i < num; i++) {
> @@ -359,12 +361,14 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
>  		if (timeout) {
>  			if (timeout == -EINTR) {
>  				/* arbitration lost */
> -				return (-EINTR);
> +				i = -EINTR;
> +				goto out;
>  			}
>  			i2c_stop(adap);
>  			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
>  				    "for PIN(1) in pcf_xfer\n");)
> -			return (-EREMOTEIO);
> +			i = -EREMOTEIO;
> +			goto out;
>  		}
>      
>  #ifndef STUB_I2C
> @@ -372,7 +376,8 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
>  		if (status & I2C_PCF_LRB) {
>  			i2c_stop(adap);
>  			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
> -			return (-EREMOTEIO);
> +			i = -EREMOTEIO;
> +			goto out;
>  		}
>  #endif
>      
> @@ -404,6 +409,8 @@ static int pcf_xfer(struct i2c_adapter *i2c_adap,
>  		}
>  	}
>  
> +out:
> +	adap->xfer_end(adap->data);
>  	return (i);
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-elektor.c b/drivers/i2c/busses/i2c-elektor.c
> index 05f7d09..37bb528 100644
> --- a/drivers/i2c/busses/i2c-elektor.c
> +++ b/drivers/i2c/busses/i2c-elektor.c
> @@ -186,6 +186,14 @@ static int pcf_isa_init(void)
>  	return 0;
>  }
>  
> +static void pcf_isa_xfer_begin(void *data)
> +{
> +}
> +
> +static void pcf_isa_xfer_end(void *data)
> +{
> +}
> +
>  /* ------------------------------------------------------------------------
>   * Encapsulate the above functions in the correct operations structure.
>   * This is only done when more than one hardware adapter is supported.
> @@ -196,6 +204,8 @@ static struct i2c_algo_pcf_data pcf_isa_data = {
>  	.getown	    = pcf_isa_getown,
>  	.getclock   = pcf_isa_getclock,
>  	.waitforpin = pcf_isa_waitforpin,
> +	.xfer_begin = pcf_isa_xfer_begin,
> +	.xfer_end   = pcf_isa_xfer_end,
>  };

That's not exactly elegant. I'd rather make .xfer_begin and .xfer_end
optional and check for NULL before calling them from pcf_xfer(). That's
less intrusive also, you don't even need to touch the individual bus
drivers using the i2c-algo-pcf module if they don't need these hooks.

>  static struct i2c_adapter pcf_isa_ops = {

> diff --git a/include/linux/i2c-algo-pcf.h b/include/linux/i2c-algo-pcf.h
> index 5de8a31..78c62ed 100644
> --- a/include/linux/i2c-algo-pcf.h
> +++ b/include/linux/i2c-algo-pcf.h
> @@ -33,6 +33,9 @@ struct i2c_algo_pcf_data {
>  	int  (*getclock) (void *data);
>  	void (*waitforpin) (void *data);
>  
> +	void (*xfer_begin)(void *data);
> +	void (*xfer_end)(void *data);
> +
>  	/* Multi-master lost arbitration back-off delay (msecs)
>  	 * This should be set by the bus adapter or knowledgable client
>  	 * if bus is multi-mastered, else zero


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
