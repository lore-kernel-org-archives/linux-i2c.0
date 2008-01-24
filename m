From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 5/6] pca-isa driver uses the new pca-algorithm
Date: Thu, 24 Jan 2008 12:00:44 +0100
Message-ID: <20080124120044.4052c351@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143658.662633756@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121143658.662633756-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 21 Jan 2008 15:20:15 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> This is untested, due to no hardware!

Did you at least try to build it? I guess not, because it fails here:

  CC [M]  drivers/i2c/busses/i2c-pca-isa.o
drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_waitforcompletion':
drivers/i2c/busses/i2c-pca-isa.c:84: error: `adap' undeclared (first use in this function)
drivers/i2c/busses/i2c-pca-isa.c:84: error: (Each undeclared identifier is reported only once
drivers/i2c/busses/i2c-pca-isa.c:84: error: for each function it appears in.)
drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_resetchip':
drivers/i2c/busses/i2c-pca-isa.c:96: error: syntax error before "DRIVER"
drivers/i2c/busses/i2c-pca-isa.c: At top level:
drivers/i2c/busses/i2c-pca-isa.c:108: error: unknown field `wait_for_competion' specified in initializer
drivers/i2c/busses/i2c-pca-isa.c:110: error: initializer element is not constant
drivers/i2c/busses/i2c-pca-isa.c:110: error: (near initialization for `pca_isa_data.my_slave_addr')
drivers/i2c/busses/i2c-pca-isa.c:111: error: initializer element is not constant
drivers/i2c/busses/i2c-pca-isa.c:111: error: (near initialization for `pca_isa_data.i2c_clock')
drivers/i2c/busses/i2c-pca-isa.c: In function `pca_isa_probe':
drivers/i2c/busses/i2c-pca-isa.c:140: error: implicit declaration of function `i2c_pca_add_bus'
make[3]: *** [drivers/i2c/busses/i2c-pca-isa.o] Error 1
make[2]: *** [drivers/i2c/busses] Error 2
make[1]: *** [drivers/i2c] Error 2
make: *** [drivers] Error 2

Please fix.

> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pca-isa.c |   52 +++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> Index: linux-playground/drivers/i2c/busses/i2c-pca-isa.c
> ===================================================================
> --- linux-playground.orig/drivers/i2c/busses/i2c-pca-isa.c	2008-01-21 12:39:28.000000000 +0100
> +++ linux-playground/drivers/i2c/busses/i2c-pca-isa.c	2008-01-21 13:19:48.000000000 +0100
> @@ -1,6 +1,12 @@
>  /*
>   *  i2c-pca-isa.c driver for PCA9564 on ISA boards
>   *    Copyright (C) 2004 Arcom Control Systems
> + *    Copyright (C) 2008 Pengutronix
> + *
> + *  History:
> + *        2004: initial version [Ian Campbell]
> + *    Jan 2008: updates to use the newer PCA-algorithm
> + *              [Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>]

No history in drivers.

>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by
> @@ -22,7 +28,6 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/delay.h>
> -#include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
> @@ -30,16 +35,14 @@
>  #include <linux/isa.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-algo-pca.h>
> -
> -#include <asm/io.h>
> -#include <asm/irq.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>

Why? Many drivers include <asm/io.h> and <asm/irq.h>, it looks OK to me.

>  
>  #include "../algos/i2c-algo-pca.h"
>  
>  #define IO_SIZE 4
>  
>  #undef DEBUG_IO
> -//#define DEBUG_IO

While you're here, the line before could be discarded as well.

>  
>  static unsigned long base   = 0x330;
>  static int irq 	  = 10;
> @@ -52,18 +55,7 @@
>  
>  static wait_queue_head_t pca_wait;
>  
> -static int pca_isa_getown(struct i2c_algo_pca_data *adap)
> -{
> -	return (own);
> -}
> -
> -static int pca_isa_getclock(struct i2c_algo_pca_data *adap)
> -{
> -	return (clock);
> -}
> -
> -static void
> -pca_isa_writebyte(struct i2c_algo_pca_data *adap, int reg, int val)
> +static void pca_isa_writebyte(void *pd, int reg, int val)
>  {
>  #ifdef DEBUG_IO
>  	static char *names[] = { "T/O", "DAT", "ADR", "CON" };
> @@ -72,20 +64,19 @@
>  	outb(val, base+reg);
>  }
>  
> -static int
> -pca_isa_readbyte(struct i2c_algo_pca_data *adap, int reg)
> +static int pca_isa_readbyte(void *pd, int reg)
>  {
>  	int res = inb(base+reg);
>  #ifdef DEBUG_IO
>  	{
> -		static char *names[] = { "STA", "DAT", "ADR", "CON" };	
> +		static char *names[] = { "STA", "DAT", "ADR", "CON" };

Such whitespace cleanups would rather belong to patch 1/6.

>  		printk("*** read  %s => %#04x\n", names[reg], res);
>  	}
>  #endif
>  	return res;
>  }
>  
> -static int pca_isa_waitforinterrupt(struct i2c_algo_pca_data *adap)
> +static int pca_isa_waitforcompletion(void *pd)
>  {
>  	int ret = 0;
>  
> @@ -93,23 +84,32 @@
>  		ret = wait_event_interruptible(pca_wait,
>  					       pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI);
>  	} else {
> -		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0) 
> +		while ((pca_isa_readbyte(adap, I2C_PCA_CON) & I2C_PCA_CON_SI) == 0)

Same here.

>  			udelay(100);
>  	}
>  	return ret;
>  }
>  
> +static void pca_isa_resetchip(void *pd)
> +{
> +	/* apparently only an external reset will do it. not a lot can be done */
> +	printk(KERN_ERR DRIVER ": Haven't figured out how to do a reset yet\n");
> +}
> +
>  static irqreturn_t pca_handler(int this_irq, void *dev_id) {
>  	wake_up_interruptible(&pca_wait);
>  	return IRQ_HANDLED;
>  }
>  
>  static struct i2c_algo_pca_data pca_isa_data = {
> -	.get_own		= pca_isa_getown,
> -	.get_clock		= pca_isa_getclock,
> +	.data			= NULL,

No need to initialize to NULL, the compiler does it for you. On a side
note though, I fail to see how this could work, given that you changed
the callbacks so that you pass this private data pointer to them
instead of a pointer to struct i2c_algo_pca_data. This probably needs
some more thinking.

>  	.write_byte		= pca_isa_writebyte,
>  	.read_byte		= pca_isa_readbyte,
> -	.wait_for_interrupt	= pca_isa_waitforinterrupt,
> +	.wait_for_competion	= pca_isa_waitforcompletion,
> +	.reset_chip		= pca_isa_resetchip,
> +	.my_slave_addr		= own,
> +	.i2c_clock		= clock,
> +	.timeout		= 100,
>  };
>  
>  static struct i2c_adapter pca_isa_ops = {
> @@ -157,7 +157,7 @@
>  {
>  	i2c_del_adapter(&pca_isa_ops);
>  
> -	if (irq > 0) {
> +	if (irq > -1) {

This deserves an explanation... In the light of previous discussions on
the i2c list, I'd rather expect comparisons with NO_IRQ.

>  		disable_irq(irq);
>  		free_irq(irq, &pca_isa_ops);
>  	}
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
