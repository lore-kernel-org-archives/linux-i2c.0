From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH V8] I2C driver for IMX
Date: Tue, 8 Jul 2008 13:38:04 +0200
Message-ID: <20080708113804.GJ4595@pengutronix.de>
References: <g4v9vl$ei2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <g4v9vl$ei2$1@ger.gmane.org>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Darius <augulis.darius@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Hi Darius,

On Tue, Jul 08, 2008 at 11:48:10AM +0300, Darius wrote:
> Changes from V7 version:
>
> - .remove function now is declarated with __devexit
>
> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> ---

> Index: linux-2.6.26-rc8/arch/arm/mach-imx/mx1ads.c
> ===================================================================
> --- linux-2.6.26-rc8.orig/arch/arm/mach-imx/mx1ads.c
> +++ linux-2.6.26-rc8/arch/arm/mach-imx/mx1ads.c
> @@ -109,10 +109,31 @@ static struct platform_device imx_uart2_
>  	}
>  };
>  
> +static struct resource imx_i2c_resources[] = {
> +	[0] = {
> +		.start  = 0x00217000,
> +		.end    = 0x00217010,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = I2C_INT,
> +		.end    = I2C_INT,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device imx_i2c_device = {
> +	.name           = "imx-i2c",
> +	.id             = 0,
> +	.resource       = imx_i2c_resources,
> +	.num_resources  = ARRAY_SIZE(imx_i2c_resources),
> +};
> +
>  static struct platform_device *devices[] __initdata = {
>  	&cs89x0_device,
>  	&imx_uart1_device,
>  	&imx_uart2_device,
> +	&imx_i2c_device,
>  };
>  
>  #ifdef CONFIG_MMC_IMX
> Index: linux-2.6.26-rc8/drivers/i2c/busses/i2c-imx.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6.26-rc8/drivers/i2c/busses/i2c-imx.c
> @@ -0,0 +1,629 @@
> +/*
> + *	Copyright (C) 2002 Motorola GSG-China
> + *
> + *	This program is free software; you can redistribute it and/or
> + *	modify it under the terms of the GNU General Public License
> + *	as published by the Free Software Foundation; either version 2
> + *	of the License, or (at your option) any later version.
> + *
> + *	This program is distributed in the hope that it will be useful,
> + *	but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *	GNU General Public License for more details.
> + *
> + *	You should have received a copy of the GNU General Public License
> + *	along with this program; if not, write to the Free Software
> + *	Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307,
> + *	USA.
> + *
> + * Author:
> + *	Darius Augulis, Teltonika Inc.
> + *
> + * Desc.:
> + *	Implementation of I2C Adapter/Algorithm Driver
> + *	Driver for I2C Bus integrated in i.MXL, i.MX1
> + *
> + *	module parameters:
> + *		- clkfreq:
> + *			Sets the desired clock rate
> + *			The default value is 100000
> + *			Max value is 400000
> + *		- imxslave:
> + *			IMX slave I2C address in decimal format
> + *			The default value is 0xAC in hex

Does this variable change anything? AFAIK Linux does not have I2C slave
support, so what does this driver send if in slave mode?

> + *
> + *	Derived from Motorola GSG China I2C example driver
> + *
> + *	Copyright (C) 2005 Torsten Koschorrek <koschorrek at synertronixx.de
> + *	Portions:
> + *	Copyright (C) 2005 Matthias Blaschke <blaschke at synertronixx.de
> + *	Copyright (C) 2007 RightHand Technologies, Inc. <adyeratrighthandtech.com>
> + *	Copyright (C) 2008 Darius Augulis <darius.augulis at teltonika.lt>
> + *
> + */
> +
> +/** Includes *******************************************************************
> +*******************************************************************************/
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>

not needed

> +#include <linux/proc_fs.h>

ditto

> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <asm/arch/irqs.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/arch/imx-regs.h>
> +
> +/** Defines ********************************************************************
> +*******************************************************************************/
> +
> +/* This will be the driver name the kernel reports */
> +#define DRIVER_NAME "imx-i2c"
> +
> +/* Default values of module parameters */
> +#define IMX_I2C_SLAVE_ADDR	0xAC
> +#define IMX_I2C_BIT_RATE	100000	/* 100kHz */
> +
> +/* Timeouts */
> +#define I2C_IMX_TIME_BUSY	2000	/* loop count */
> +#define I2C_IMX_TIME_ACK	2000	/* loop count */
> +#define I2C_IMX_TIME_TRX	5	/* seconds */
> +
> +/* Error numbers */
> +#define I2C_IMX_ERR_BUSY	1
> +#define I2C_IMX_ERR_TX_TIMEOUT	2
> +#define I2C_IMX_ERR_RX_TIMEOUT	3
> +#define I2C_IMX_ERR_RX_NO_ACK	4

You define your own error values here but never test for them, so this
is quite unnessecary. Even worse, you pass the numbers to the I2C layer,
so I2C_IMX_ERR_TX_TIMEOUT will translate to ENOENT which is surely not
what you want.


<snip>

> +
> +static int i2c_imx_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
> +{
> +	unsigned int i, temp;
> +	int err = 0;
> +	struct imx_i2c_struct *i2c_imx = i2c_get_adapdata(adapter);
> +
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> +
> +	/* Check or i2c bus is not busy */
> +	err = i2c_imx_bus_busy(i2c_imx);
> +	if (err)
> +		goto fail0;
> +
> +	/* Enable i2c */
> +	i2c_imx_enable(i2c_imx);
> +
> +	/* Start I2C transfer */
> +	i2c_imx_start(i2c_imx);

These two functions are called only once and both modify the same
register. Is it worth it to make them extra functions?
Regarding the slave mode, you disable the whole I2C module outside the
transfers, so there won't be any slave support at all.

> +
> +	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +
> +	/* read/write data */
> +	for (i = 0; i < num; i++) {
> +		if (i) {
> +			dev_dbg(&i2c_imx->adapter.dev,
> +				"<%s> repeated start\n", __func__);
> +			temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +			temp |= I2CR_RSTA;
> +			writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
> +		}
> +		dev_dbg(&i2c_imx->adapter.dev,
> +			"<%s> transfer message: %d\n", __func__, i);
> +		/* write/read data */
> +#ifdef CONFIG_I2C_DEBUG_BUS
> +		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
> +		dev_dbg(&i2c_imx->adapter.dev, "<%s> CONTROL: IEN=%d, IIEN=%d, "
> +			"MSTA=%d, MTX=%d, TXAK=%d, RSTA=%d\n", __func__,
> +			(temp&I2CR_IEN ? 1 : 0), (temp&I2CR_IIEN ? 1 : 0),
> +			(temp&I2CR_MSTA ? 1 : 0), (temp&I2CR_MTX ? 1 : 0),
> +			(temp&I2CR_TXAK ? 1 : 0), (temp&I2CR_RSTA ? 1 : 0));
> +		temp = readb(i2c_imx->base + IMX_I2C_I2SR);
> +		dev_dbg(&i2c_imx->adapter.dev,
> +			"<%s> STATUS: ICF=%d, IAAS=%d, IBB=%d, "
> +			"IAL=%d, SRW=%d, IIF=%d, RXAK=%d\n", __func__,
> +			(temp&I2SR_ICF ? 1 : 0), (temp&I2SR_IAAS ? 1 : 0),
> +			(temp&I2SR_IBB ? 1 : 0), (temp&I2SR_IAL ? 1 : 0),
> +			(temp&I2SR_SRW ? 1 : 0), (temp&I2SR_IIF ? 1 : 0),
> +			(temp&I2SR_RXAK ? 1 : 0));
> +#endif
> +		if (!(msgs[i].flags & I2C_M_RD))

positive logic would be easier to read.

> +			err = i2c_imx_write(i2c_imx, &msgs[i]);
> +		else
> +			err = i2c_imx_read(i2c_imx, &msgs[i]);
> +	}
> +
> +fail0:
> +	/* Stop bus */
> +	i2c_imx_stop(i2c_imx);
> +	/* disable i2c bus */
> +	i2c_imx_disable(i2c_imx);
> +	dev_dbg(&i2c_imx->adapter.dev, "<%s> exit with: %s: %d\n", __func__,
> +		(err < 0) ? "error" : "success msg", (err < 0) ? err : num);
> +	return (err < 0) ? err : num;
> +}
> +
-- 
Pengutronix e.K. - Linux Solutions for Science and Industry
-----------------------------------------------------------
Kontakt-Informationen finden Sie im Header dieser Mail oder
auf der Webseite -> http://www.pengutronix.de/impressum/ <-

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
