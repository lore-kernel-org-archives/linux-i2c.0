From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2/6] Extension of pca-algorithm
Date: Wed, 23 Jan 2008 20:52:41 +0100
Message-ID: <20080123205241.3e1235e7@hyperion.delvare>
References: <20080121142010.988419876@pengutronix.de>
	<20080121143657.455317984@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080121143657.455317984-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Mon, 21 Jan 2008 15:20:12 +0100, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org wrote:
> It now conatins a private data field and more per-instance data. The reset 

Typo: contains.

> routine has been moved to the adapters. It also supports add_numbered_adapter.

I would like a more detailed changelog entry. Please explain all the
changes you did and why you had to do them. If might be obvious to you,
but it may not be to others (including me.)

> 
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/algos/i2c-algo-pca.c |   94 ++++++++++++++++++++++-----------------
>  drivers/i2c/algos/i2c-algo-pca.h |    9 ---
>  include/linux/i2c-algo-pca.h     |   25 +++++++---
>  3 files changed, 73 insertions(+), 55 deletions(-)
> 

This patch break the i2c-pca-isa driver, which is not OK. Your patchset
should be such that everything still builds and work after each
incremental patch. In practice, this means that patches 2/6 and 5/6
should be merged. Except for white-space cleanups which would rather
belong to patch 1/6.

> Index: linux-playground/include/linux/i2c-algo-pca.h
> ===================================================================
> --- linux-playground.orig/include/linux/i2c-algo-pca.h	2008-01-21 12:39:28.000000000 +0100
> +++ linux-playground/include/linux/i2c-algo-pca.h	2008-01-21 12:42:14.000000000 +0100
> @@ -1,14 +1,27 @@
>  #ifndef _LINUX_I2C_ALGO_PCA_H
>  #define _LINUX_I2C_ALGO_PCA_H
>  
> +#define I2C_PCA_CON_330kHz	0x00
> +#define I2C_PCA_CON_288kHz	0x01
> +#define I2C_PCA_CON_217kHz	0x02
> +#define I2C_PCA_CON_146kHz	0x03
> +#define I2C_PCA_CON_88kHz	0x04
> +#define I2C_PCA_CON_59kHz	0x05
> +#define I2C_PCA_CON_44kHz	0x06
> +#define I2C_PCA_CON_36kHz	0x07
> +
>  struct i2c_algo_pca_data {
> -	int  (*get_own)			(struct i2c_algo_pca_data *adap); /* Obtain own address */
> -	int  (*get_clock)		(struct i2c_algo_pca_data *adap);
> -	void (*write_byte)		(struct i2c_algo_pca_data *adap, int reg, int val);
> -	int  (*read_byte)		(struct i2c_algo_pca_data *adap, int reg);
> -	int  (*wait_for_interrupt)	(struct i2c_algo_pca_data *adap);
> +	void 				*data;	/* private low level data */
> +	void (*write_byte)		(void *data, int reg, int val);
> +	int  (*read_byte)		(void *data, int reg);
> +	int  (*wait_for_completion)	(void *data);
> +	void (*reset_chip)		(void *data);
> +	unsigned int			my_slave_addr;
> +	unsigned int			i2c_clock;
> +	unsigned int			timeout;
>  };

I do not understand why you change struct i2c_algo_pca_data *adap to
void *data in these prototypes?

struct i2c_adapter already has a timeout field, so why define your own?

>  
> -int i2c_pca_add_bus(struct i2c_adapter *);
> +int i2c_pca_add_adapter(struct i2c_adapter *);

Why change this? All other algorithm drivers have i2c_foo_add_bus().

> +int i2c_pca_add_numbered_adapter(struct i2c_adapter *);
>  
>  #endif /* _LINUX_I2C_ALGO_PCA_H */
> Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.h
> ===================================================================
> --- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.h	2008-01-21 12:39:28.000000000 +0100
> +++ linux-playground/drivers/i2c/algos/i2c-algo-pca.h	2008-01-21 12:42:14.000000000 +0100
> @@ -14,13 +14,4 @@
>  #define I2C_PCA_CON_SI		0x08 /* Serial Interrupt */
>  #define I2C_PCA_CON_CR		0x07 /* Clock Rate (MASK) */
>  
> -#define I2C_PCA_CON_330kHz	0x00
> -#define I2C_PCA_CON_288kHz	0x01
> -#define I2C_PCA_CON_217kHz	0x02
> -#define I2C_PCA_CON_146kHz	0x03
> -#define I2C_PCA_CON_88kHz	0x04
> -#define I2C_PCA_CON_59kHz	0x05
> -#define I2C_PCA_CON_44kHz	0x06
> -#define I2C_PCA_CON_36kHz	0x07
> -
>  #endif /* I2C_PCA9564_H */

Maybe you could get rid of this header file altogether? It never made
much sense to me. Symbols internal to i2c-algo-pca do not need to be in
a header file. Symbols needed by bus drivers or platform code should be
in a header file under include/linux, not drivers/i2c/algos.

> Index: linux-playground/drivers/i2c/algos/i2c-algo-pca.c
> ===================================================================
> --- linux-playground.orig/drivers/i2c/algos/i2c-algo-pca.c	2008-01-21 12:39:28.000000000 +0100
> +++ linux-playground/drivers/i2c/algos/i2c-algo-pca.c	2008-01-21 12:56:43.000000000 +0100
> @@ -1,6 +1,12 @@
>  /*
>   *  i2c-algo-pca.c i2c driver algorithms for PCA9564 adapters
>   *    Copyright (C) 2004 Arcom Control Systems
> + *    Copyright (C) 2008 Pengutronix
> + *
> + *  History:
> + *        2004: initial version [Ian Campbell]
> + *    Jan 2008: extended algo_data and adapter initialization to support
> + *              platform drivers [Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>]

History doesn't belong there, we have git for that.

>   *
>   *  This program is free software; you can redistribute it and/or modify
>   *  it under the terms of the GNU General Public License as published by
> @@ -21,7 +27,6 @@
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/delay.h>
> -#include <linux/slab.h>
>  #include <linux/init.h>
>  #include <linux/errno.h>
>  #include <linux/i2c.h>
> @@ -36,15 +41,16 @@
>  
>  static int i2c_debug;
>  
> -#define pca_outw(adap, reg, val) adap->write_byte(adap, reg, val)
> -#define pca_inw(adap, reg) adap->read_byte(adap, reg)
> +#define pca_outw(adap, reg, val) adap->write_byte(adap->data, reg, val)
> +#define pca_inw(adap, reg) adap->read_byte(adap->data, reg)
>  
>  #define pca_status(adap) pca_inw(adap, I2C_PCA_STA)
> -#define pca_clock(adap) adap->get_clock(adap)
> -#define pca_own(adap) adap->get_own(adap)
> +#define pca_clock(adap) adap->i2c_clock
> +#define pca_own(adap) adap->my_slave_addr
>  #define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
>  #define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
> -#define pca_wait(adap) adap->wait_for_interrupt(adap)
> +#define pca_wait(adap) adap->wait_for_completion(adap->data)
> +#define pca_reset(adap) adap->reset_chip(adap->data)
>  
>  /*
>   * Generate a start condition on the i2c bus.
> @@ -168,15 +174,6 @@
>  	pca_wait(adap);
>  }
>  
> -/*
> - * Reset the i2c bus / SIO
> - */
> -static void pca_reset(struct i2c_algo_pca_data *adap)
> -{
> -	/* apparently only an external reset will do it. not a lot can be done */
> -	printk(KERN_ERR DRIVER ": Haven't figured out how to do a reset yet\n");
> -}
> -
>  static int pca_xfer(struct i2c_adapter *i2c_adap,
>                      struct i2c_msg *msgs,
>                      int num)
> @@ -187,7 +184,7 @@
>  	int numbytes = 0;
>  	int state;
>  	int ret;
> -	int timeout = 100;
> +	int timeout = adap->timeout;
>  
>  	while ((state = pca_status(adap)) != 0xf8 && timeout--) {
>  		msleep(10);
> @@ -317,7 +314,7 @@
>  			pca_reset(adap);
>  			goto out;
>  		default:
> -			printk(KERN_ERR DRIVER ": unhandled SIO state 0x%02x\n", state);
> +			dev_err(&i2c_adap->dev, "unhandled SIO state 0x%02x\n", state);
>  			break;
>  		}
>  
> @@ -337,51 +334,68 @@
>          return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>  }
>  
> -static int pca_init(struct i2c_algo_pca_data *adap)
> +static const struct i2c_algorithm pca_algo = {
> +	.master_xfer	= pca_xfer,
> +	.functionality	= pca_func,
> +};
> +
> +static int pca_init(struct i2c_adapter *adap)
>  {
>  	static int freqs[] = {330,288,217,146,88,59,44,36};
>  	int own, clock;
> +	struct i2c_algo_pca_data *pca_data = adap->algo_data;
> +
> +	if (pca_data->i2c_clock > 7) {
> +		dev_warn(&adap->dev, "Invalid I2C clock speed selected. Trying default.\n");
> +		pca_data->i2c_clock = I2C_PCA_CON_59kHz;
> +	}
> +	/* No need to check my_slave_addr. driver can't handle slave mode */

Why define it at all then?

> +
> +	adap->algo = &pca_algo;
> +	adap->retries = 1;

Please don't set retries, the driver doesn't actually implement a retry
mechanism, and this structure field will be dropped soon in favor of a
different approach anyway.

>  
> -	own = pca_own(adap);
> -	clock = pca_clock(adap);
> -	DEB1(KERN_INFO DRIVER ": own address is %#04x\n", own);
> -	DEB1(KERN_INFO DRIVER ": clock freqeuncy is %dkHz\n", freqs[clock]);
> +	pca_reset(pca_data);
>  
> -	pca_outw(adap, I2C_PCA_ADR, own << 1);
> +	own = pca_own(pca_data);
> +	clock = pca_clock(pca_data);
>  
> -	pca_set_con(adap, I2C_PCA_CON_ENSIO | clock);
> +	DEB1(KERN_INFO "%s: Own address is %#04x\n", adap->name, own);
> +	DEB1(KERN_INFO "%s: Clock freqeuncy is %dkHz\n", adap->name, freqs[clock]);

Typo: frequency.

> +
> +	pca_outw(pca_data, I2C_PCA_ADR, own << 1);
> +
> +	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
>  	udelay(500); /* 500 us for oscilator to stabilise */
>  
>  	return 0;
>  }
>  
> -static const struct i2c_algorithm pca_algo = {
> -	.master_xfer	= pca_xfer,
> -	.functionality	= pca_func,
> -};
> -
>  /*
>   * registering functions to load algorithms at runtime
>   */
> -int i2c_pca_add_bus(struct i2c_adapter *adap)
> +int i2c_pca_add_adapter(struct i2c_adapter *adap)
>  {
> -	struct i2c_algo_pca_data *pca_adap = adap->algo_data;
>  	int rval;
>  
> -	/* register new adapter to i2c module... */
> -	adap->algo = &pca_algo;
> +	rval = pca_init(adap);
> +	if (rval)
> +		return rval;
>  
> -	adap->timeout = 100;		/* default values, should	*/
> -	adap->retries = 3;		/* be replaced by defines	*/
> +	return i2c_add_adapter(adap);
> +}
> +EXPORT_SYMBOL(i2c_pca_add_adapter);
>  
> -	if ((rval = pca_init(pca_adap)))
> -		return rval;
> +int i2c_pca_add_numbered_adapter(struct i2c_adapter *adap)
> +{
> +	int rval;
>  
> -	rval = i2c_add_adapter(adap);
> +	rval = pca_init(adap);
> +	if (rval)
> +		return rval;
>  
> -	return rval;
> +	return i2c_add_numbered_adapter(adap);
>  }
> -EXPORT_SYMBOL(i2c_pca_add_bus);
> +EXPORT_SYMBOL(i2c_pca_add_numbered_adapter);
>  
>  MODULE_AUTHOR("Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>");
>  MODULE_DESCRIPTION("I2C-Bus PCA9564 algorithm");
> 


-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
