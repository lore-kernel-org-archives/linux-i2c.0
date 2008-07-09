From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Wed, 9 Jul 2008 18:48:22 +0200
Message-ID: <20080709184822.27535d1a@hyperion.delvare>
References: <486B9E30.80806@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <486B9E30.80806-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 02 Jul 2008 16:26:40 +0100, Jonathan Cameron wrote:
> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
> different normal and fast frequencies.
> 
> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c        |    4 +++-
>  include/asm-arm/arch-pxa/i2c.h      |    1 +
>  include/asm-arm/arch-pxa/pxa-regs.h |    1 +
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/include/asm-arm/arch-pxa/pxa-regs.h	2008-06-30 20:06:02.000000000 +0100
> +++ b/include/asm-arm/arch-pxa/pxa-regs.h	2008-07-02 14:03:19.000000000 +0100
> @@ -448,6 +448,7 @@
>  #define ICR_ALDIE	(1 << 12)	   /* enable arbitration interrupt */
>  #define ICR_SADIE	(1 << 13)	   /* slave address detected int enable */
>  #define ICR_UR		(1 << 14)	   /* unit reset */
> +#define ICR_FM		(1 << 15)	   /* fast mode */
>  
>  #define ISR_RWM		(1 << 0)	   /* read/write mode */
>  #define ISR_ACKNAK	(1 << 1)	   /* ack/nak status */
> --- a/include/asm-arm/arch-pxa/i2c.h	2008-06-30 20:04:02.000000000 +0100
> +++ b/include/asm-arm/arch-pxa/i2c.h	2008-07-02 13:59:59.000000000 +0100
> @@ -66,6 +66,7 @@ struct i2c_pxa_platform_data {
>  	struct i2c_slave_client	*slave;
>  	unsigned int		class;
>  	int			use_pio;
> +	int			fast_mode;
>  };
>  
>  extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> --- a/drivers/i2c/busses/i2c-pxa.c	2008-06-30 20:05:51.000000000 +0100
> +++ b/drivers/i2c/busses/i2c-pxa.c	2008-07-02 15:50:31.000000000 +0100
> @@ -67,6 +67,7 @@ struct pxa_i2c {
>  
>  	int			irq;
>  	int			use_pio;
> +	int			fast_mode;
>  };
>  
>  #define _IBMR(i2c)	((i2c)->reg_base + 0)
> @@ -365,7 +366,7 @@ static void i2c_pxa_reset(struct pxa_i2c
>  	writel(i2c->slave_addr, _ISAR(i2c));
>  
>  	/* set control register values */
> -	writel(I2C_ICR_INIT, _ICR(i2c));
> +	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
>  
>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, "Enabling slave mode\n");
> @@ -1041,6 +1042,7 @@ static int i2c_pxa_probe(struct platform
>  	if (plat) {
>  		i2c->adap.class = plat->class;
>  		i2c->use_pio = plat->use_pio;
> +		i2c->fast_mode = plat->fast_mode;
>  	}
>  
>  	if (i2c->use_pio) {

Patch looks OK to me. Ben, i2c-pxa is embedded so this is something for
you.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
