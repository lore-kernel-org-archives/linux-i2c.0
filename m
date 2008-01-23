From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] i2c-bfin-twi: Register adapter with a specific
	bus	number
Date: Wed, 23 Jan 2008 15:56:59 +0800
Message-ID: <1201075019.6725.7.camel@roc-laptop>
References: <Pine.LNX.4.64.0801222335050.11948@pc-213-140-179-32.aina.net>
Reply-To: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801222335050.11948-er0LZAA46r2WwDxiJSwuDc1vFkv34tBQrE5yTffgRl4@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Kalle Pokki <kalle.pokki-loK5ZF7nR+A@public.gmane.org>
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Tue, 2008-01-22 at 23:40 +0200, Kalle Pokki wrote:
> All the users of this driver explicitly specify the I2C bus numbers
> to be used in their platform data. Make the driver respect that.
> 
> Signed-off-by: Kalle Pokki <kalle.pokki-loK5ZF7nR+A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 67224a4..7dbdaeb 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -550,6 +550,7 @@ static int i2c_bfin_twi_probe(struct platform_device *dev)
>  
>  	p_adap = &iface->adap;
>  	p_adap->id = I2C_HW_BLACKFIN;
> +	p_adap->nr = dev->id;

How do you think of following code, Kalle?

	 /*
         * If "dev->id" is negative we consider it as zero.
         * The reason to do so is to avoid sysfs names that only make
         * sense when there are multiple adapters.
         */
        p_adap->nr = dev->id >= 0 ? dev->id : 0;

I found some i2c-gpio, i2c-ibm_iic.c and i2c-pxa.c using this code,
while others use your idea.

>  	strlcpy(p_adap->name, dev->name, sizeof(p_adap->name));
>  	p_adap->algo = &bfin_twi_algorithm;
>  	p_adap->algo_data = iface;
> @@ -576,7 +577,7 @@ static int i2c_bfin_twi_probe(struct platform_device *dev)
>  	bfin_write_TWI_CONTROL(bfin_read_TWI_CONTROL() | TWI_ENA);
>  	SSYNC();
>  
> -	rc = i2c_add_adapter(p_adap);
> +	rc = i2c_add_numbered_adapter(p_adap);
>  	if (rc < 0)
>  		free_irq(iface->irq, iface);
>  	else

Thanks a lot
-Bryan Wu

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
