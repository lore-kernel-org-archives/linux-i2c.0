From: Greg Ungerer <gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH V3] m68knommu: driver for Freescale Coldfire I2C controller.
Date: Fri, 18 May 2012 16:09:08 +1000
Message-ID: <4FB5E784.2090502@snapgear.com>
References: <201205161910.36693.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201205161910.36693.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Steven,

On 17/05/12 12:10, Steven King wrote:
> D'oh!  I really dropped the ball on this, but I figure better late than never ;-).
>
> Changes since V2:
>
> drivers/i2c/busses/i2c-coldfire.c:
> * As Ben suggested, making the interrupt handler do most of the message
>    processing and wake the thread when its done vastly improves performance.
> * preliminary support for PM_RUNTIME; but as there isn't arch support for for
>    PM_RUNTIME it doesn't do anything yet.
> * fixed a bug when the driver would hang on waiting for bus busy if the bus
>    never went busy.
>
> drivers/i2c/busses/Kconfig:
> * its easier to list the Coldfire MCUs that don't have I2C.
>
> arch/m68k/include/asm/mcfi2c.h:
> * moved the defines for the various Coldfire MCUs to the specific header
>     file for the various Coldfire MCUs.
>
>
> Support for the Freescale Coldfire I2C controller.
>
> Signed-off-by: Steven King<sfking-wDEDg+HZl8U@public.gmane.org>

Looks good to me.

Acked-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>

Regards
Greg


> ---
>   arch/m68k/include/asm/mcfi2c.h    |   15 ++
>   drivers/i2c/busses/Kconfig        |   10 +
>   drivers/i2c/busses/Makefile       |    1 +
>   drivers/i2c/busses/i2c-coldfire.c |  497 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 523 insertions(+)
>
> diff --git a/arch/m68k/include/asm/mcfi2c.h b/arch/m68k/include/asm/mcfi2c.h
> new file mode 100644
> index 0000000..24b0453
> --- /dev/null
> +++ b/arch/m68k/include/asm/mcfi2c.h
> @@ -0,0 +1,15 @@
> +/*
> + * Definitions for Coldfire I2C interface
> +*/
> +#ifndef mcfi2c_h
> +#define mcfi2c_h
> +
> +/**
> + * struct mcfi2c_platform_data - platform data for the coldfire i2c driver
> + * @bitrate: bitrate to use for this i2c controller.
> +*/
> +struct mcfi2c_platform_data {
> +	u32	bitrate;
> +};
> +
> +#endif /* mcfi2c_h */
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d2c5095..159404e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -327,6 +327,16 @@ config I2C_BLACKFIN_TWI_CLK_KHZ
>   	help
>   	  The unit of the TWI clock is kHz.
>
> +config I2C_COLDFIRE
> +	tristate "Freescale Coldfire I2C driver"
> +	depends on !M5272
> +	help
> +	  This driver supports the I2C interface availible on most Freescale
> +	  Coldfire processors.
> +
> +	  This driver can be built as a module.  If so, the module
> +	  will be called i2c-coldfire.
> +
>   config I2C_CPM
>   	tristate "Freescale CPM1 or CPM2 (MPC8xx/826x)"
>   	depends on (CPM1 || CPM2)&&  OF_I2C
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 569567b..2c88c4a 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>   obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
>   obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
>   obj-$(CONFIG_I2C_BLACKFIN_TWI)	+= i2c-bfin-twi.o
> +obj-$(CONFIG_I2C_COLDFIRE)	+= i2c-coldfire.o
>   obj-$(CONFIG_I2C_CPM)		+= i2c-cpm.o
>   obj-$(CONFIG_I2C_DAVINCI)	+= i2c-davinci.o
>   obj-$(CONFIG_I2C_DESIGNWARE_PLATFORM)	+= i2c-designware-platform.o
> diff --git a/drivers/i2c/busses/i2c-coldfire.c b/drivers/i2c/busses/i2c-coldfire.c
> new file mode 100644
> index 0000000..97351c0
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-coldfire.c
> @@ -0,0 +1,497 @@
> +/* Freescale/Motorola Coldfire I2C driver.
> + *
> + * Copyright 2010, 2012 Steven King<sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include<linux/kernel.h>
> +#include<linux/module.h>
> +#include<linux/interrupt.h>
> +#include<linux/errno.h>
> +#include<linux/platform_device.h>
> +#include<linux/io.h>
> +#include<linux/clk.h>
> +#include<linux/err.h>
> +#include<linux/i2c.h>
> +#include<linux/slab.h>
> +#include<linux/pm_runtime.h>
> +#include<asm/mcfi2c.h>
> +
> +#define	DRIVER_NAME "mcfi2c"
> +
> +#define	MCFI2C_ADR			0x00
> +#define	MCFI2C_FDR			0x04
> +#define	MCFI2C_CR			0x08
> +#define		MCFI2C_CR_IEN		0x80
> +#define		MCFI2C_CR_IIEN		0x40
> +#define		MCFI2C_CR_MSTA		0x20
> +#define		MCFI2C_CR_MTX		0x10
> +#define		MCFI2C_CR_TXAK		0x08
> +#define		MCFI2C_CR_RSTA		0x04
> +#define	MCFI2C_DR			0x10
> +#define	MCFI2C_SR			0x0C
> +#define		MCFI2C_SR_ICF		0x80
> +#define		MCFI2C_SR_IAAS		0x40
> +#define		MCFI2C_SR_IBB		0x20
> +#define		MCFI2C_SR_IAL		0x10
> +#define		MCFI2C_SR_SRW		0x04
> +#define		MCFI2C_SR_IIF		0x02
> +#define		MCFI2C_SR_RXAK		0x01
> +
> +#define	DEFAULT_I2C_BUS_SPEED		100000
> +
> +struct mcfi2c {
> +	struct i2c_adapter	adapter;
> +	void __iomem		*iobase;
> +	int			irq;
> +	struct clk		*clk;
> +	struct completion	completion;
> +
> +	u8			*buf;
> +	u16			flags;
> +	u16			len;
> +	int			more;
> +	int			status;
> +};
> +
> +static u8 mcfi2c_rd_cr(struct mcfi2c *mcfi2c)
> +{
> +	return readb(mcfi2c->iobase + MCFI2C_CR);
> +}
> +
> +static void mcfi2c_wr_cr(struct mcfi2c *mcfi2c, u8 val)
> +{
> +	writeb(val, mcfi2c->iobase + MCFI2C_CR);
> +}
> +
> +static u8 mcfi2c_rd_sr(struct mcfi2c *mcfi2c)
> +{
> +	return readb(mcfi2c->iobase + MCFI2C_SR);
> +}
> +
> +static void mcfi2c_wr_sr(struct mcfi2c *mcfi2c, u8 val)
> +{
> +	writeb(val, mcfi2c->iobase + MCFI2C_SR);
> +}
> +
> +static u8 mcfi2c_rd_dr(struct mcfi2c *mcfi2c)
> +{
> +	return readb(mcfi2c->iobase + MCFI2C_DR);
> +}
> +
> +static void mcfi2c_wr_dr(struct mcfi2c *mcfi2c, u8 val)
> +{
> +	writeb(val, mcfi2c->iobase + MCFI2C_DR);
> +}
> +
> +static void mcfi2c_start(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN | MCFI2C_CR_IIEN | MCFI2C_CR_MSTA |
> +		     MCFI2C_CR_MTX);
> +}
> +
> +static void mcfi2c_repeat_start(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN | MCFI2C_CR_IIEN | MCFI2C_CR_MSTA |
> +		     MCFI2C_CR_MTX | MCFI2C_CR_RSTA);
> +}
> +
> +static void mcfi2c_stop(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN);
> +}
> +
> +static void mcfi2c_tx_ack(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN | MCFI2C_CR_IIEN | MCFI2C_CR_MSTA);
> +}
> +
> +static void mcfi2c_tx_nak(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN | MCFI2C_CR_IIEN | MCFI2C_CR_MSTA |
> +		     MCFI2C_CR_TXAK);
> +}
> +
> +static irqreturn_t mcfi2c_irq_handler(int this_irq, void *dev_id)
> +{
> +	struct mcfi2c *mcfi2c = dev_id;
> +	u8 sr;
> +
> +	if (pm_runtime_suspended(&mcfi2c->adapter.dev))
> +		return IRQ_NONE;
> +
> +	/* clear interrupt */
> +	mcfi2c_wr_sr(mcfi2c, 0);
> +
> +	sr = mcfi2c_rd_sr(mcfi2c);
> +	if (sr&  MCFI2C_SR_IAL) {
> +		mcfi2c_wr_sr(mcfi2c, ~MCFI2C_SR_IAL);
> +		mcfi2c->status = -EIO;
> +	} else if (mcfi2c_rd_cr(mcfi2c)&  MCFI2C_CR_MTX) {
> +		if (sr&  MCFI2C_SR_RXAK) {
> +			mcfi2c_stop(mcfi2c);
> +			mcfi2c->status = -EIO;
> +		} else if (mcfi2c->flags&  I2C_M_RD) {
> +			if (mcfi2c->len>  1)
> +				mcfi2c_tx_ack(mcfi2c);
> +			else
> +				mcfi2c_tx_nak(mcfi2c);
> +			/* dummy read */
> +			mcfi2c_rd_dr(mcfi2c);
> +			goto not_complete;
> +
> +		} else if (mcfi2c->len--) {
> +			mcfi2c_wr_dr(mcfi2c, *(mcfi2c->buf++));
> +			goto not_complete;
> +		} else {
> +			if (mcfi2c->more)
> +				mcfi2c_repeat_start(mcfi2c);
> +			else
> +				mcfi2c_stop(mcfi2c);
> +		}
> +	} else if (--mcfi2c->len) {
> +		if (!(mcfi2c->len>  1))
> +			mcfi2c_tx_nak(mcfi2c);
> +		*(mcfi2c->buf++) = mcfi2c_rd_dr(mcfi2c);
> +		goto not_complete;
> +	} else {
> +		if (mcfi2c->more)
> +			mcfi2c_repeat_start(mcfi2c);
> +		else
> +			mcfi2c_stop(mcfi2c);
> +		*(mcfi2c->buf++) = mcfi2c_rd_dr(mcfi2c);
> +	}
> +	complete(&mcfi2c->completion);
> +not_complete:
> +	return IRQ_HANDLED;
> +}
> +
> +static void mcfi2c_reset(struct mcfi2c *mcfi2c)
> +{
> +	mcfi2c_wr_cr(mcfi2c, 0);
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN | MCFI2C_CR_MSTA);
> +	mcfi2c_rd_dr(mcfi2c);
> +	mcfi2c_wr_sr(mcfi2c, 0);
> +	mcfi2c_wr_cr(mcfi2c, 0);
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN);
> +}
> +
> +static int mcfi2c_wait_for_bus_idle(struct mcfi2c *mcfi2c)
> +{
> +	unsigned long timeout = jiffies + HZ / 2;
> +	while (mcfi2c_rd_sr(mcfi2c)&  MCFI2C_SR_IBB) {
> +		if (time_after(jiffies, timeout))
> +			return -EIO; /* bus is busy, try again */
> +		cond_resched();
> +	}
> +	return 0;
> +}
> +
> +static int mcfi2c_wait_for_bus_busy(struct mcfi2c *mcfi2c)
> +{
> +	unsigned long timeout = jiffies + HZ / 10;
> +	u8 sr;
> +	while (!((sr = mcfi2c_rd_sr(mcfi2c))&  MCFI2C_SR_IBB)) {
> +		if (sr&  MCFI2C_SR_IAL)
> +			return -EIO; /* lost arbitration, try again */
> +		if (time_after(jiffies, timeout)) {
> +			/* if we dont get bus busy and dont get an arbitration
> +			 * loss, then the bus is probably glitched, see if we
> +			 * can recover.
> +			*/
> +			dev_dbg(&mcfi2c->adapter.dev,
> +				"unable to send START, trying to reset the bus\n");
> +			mcfi2c_reset(mcfi2c);
> +			return -EIO;
> +		}
> +		cond_resched();
> +	}
> +	return 0;
> +}
> +
> +static int mcfi2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
> +		int num)
> +{
> +	struct mcfi2c *mcfi2c = i2c_get_adapdata(adapter);
> +	int cnt = 0;
> +
> +	pm_runtime_get_sync(&adapter->dev);
> +
> +	while (num--) {
> +		int retries = adapter->retries;
> +		if (msgs->flags&  ~I2C_M_RD) {
> +			mcfi2c->status = -EINVAL;
> +			goto done;
> +		}
> +		do {
> +			mcfi2c->flags = msgs->flags;
> +			mcfi2c->buf = msgs->buf;
> +			mcfi2c->len = msgs->len;
> +			mcfi2c->more = num;
> +			mcfi2c->status = 0;
> +
> +			if (!(mcfi2c_rd_cr(mcfi2c)&  MCFI2C_CR_MSTA)) {
> +				mcfi2c->status =
> +					       mcfi2c_wait_for_bus_idle(mcfi2c);
> +				if (mcfi2c->status)
> +					continue;
> +
> +				INIT_COMPLETION(mcfi2c->completion);
> +				mcfi2c_start(mcfi2c);
> +
> +				mcfi2c->status =
> +					       mcfi2c_wait_for_bus_busy(mcfi2c);
> +				if (mcfi2c->status)
> +					continue;
> +			}
> +
> +			mcfi2c_wr_dr(mcfi2c, (msgs->addr<<  1) |
> +					(msgs->flags&  I2C_M_RD));
> +			if (!wait_for_completion_timeout(&mcfi2c->completion,
> +						adapter->timeout * msgs->len)) {
> +				mcfi2c->status = -ETIMEDOUT;
> +				mcfi2c_stop(mcfi2c);
> +			}
> +
> +		} while (mcfi2c->status&&  retries--);
> +		if (mcfi2c->status)
> +			goto done;
> +		++cnt;
> +		++msgs;
> +	}
> +done:
> +	pm_runtime_put(&adapter->dev);
> +
> +	return mcfi2c->status ?: cnt;
> +}
> +
> +static u32 mcfi2c_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm mcfi2c_algo = {
> +	.master_xfer	= mcfi2c_xfer,
> +	.functionality	= mcfi2c_func,
> +};
> +
> +static const u16 mcfi2c_fdr[] = {
> +	  28,   30,   34,   40,   44,   48,   56,   68,
> +	  80,   88,  104,  128,  144,  160,  192,  240,
> +	 288,  320,  384,  480,  576,  640,  768,  960,
> +	1152, 1280, 1536, 1920, 2304, 2560, 3072, 3840,
> +	  20,   22,   24,   26,   28,   32,   36,   40,
> +	  48,   56,   64,   72,   80,   96,  112,  128,
> +	 160,  192,  224,  256,  320,  384,  448,  512,
> +	 640,  768,  896, 1024, 1280, 1536, 1792, 2048
> +};
> +
> +static u8 __devinit mcfi2c_calc_fdr(struct mcfi2c *mcfi2c,
> +				    struct mcfi2c_platform_data *pdata)
> +{
> +	u32 bitrate = (pdata&&  pdata->bitrate) ?
> +			pdata->bitrate : DEFAULT_I2C_BUS_SPEED;
> +	int div = clk_get_rate(mcfi2c->clk)/bitrate;
> +	int r = 0, i = 0;
> +
> +	do
> +		if (abs(mcfi2c_fdr[i] - div)<  abs(mcfi2c_fdr[r] - div))
> +			r = i;
> +	while (++i<  ARRAY_SIZE(mcfi2c_fdr));
> +
> +	return r;
> +}
> +
> +static int __devinit mcfi2c_probe(struct platform_device *pdev)
> +{
> +	struct mcfi2c *mcfi2c;
> +	struct resource *res;
> +	int status;
> +
> +	mcfi2c = kzalloc(sizeof(*mcfi2c), GFP_KERNEL);
> +	if (!mcfi2c) {
> +		dev_dbg(&pdev->dev, "kzalloc failed\n");
> +
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_dbg(&pdev->dev, "platform_get_resource failed\n");
> +		status = -ENXIO;
> +		goto fail0;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
> +		dev_dbg(&pdev->dev, "request_mem_region failed\n");
> +		status = -EBUSY;
> +		goto fail0;
> +	}
> +
> +	mcfi2c->iobase = ioremap(res->start, resource_size(res));
> +	if (!mcfi2c->iobase) {
> +		dev_dbg(&pdev->dev, "ioremap failed\n");
> +		status = -ENOMEM;
> +		goto fail1;
> +	}
> +
> +	mcfi2c->irq = platform_get_irq(pdev, 0);
> +	if (mcfi2c->irq<  0) {
> +		dev_dbg(&pdev->dev, "platform_get_irq failed\n");
> +		status = -ENXIO;
> +		goto fail2;
> +	}
> +	status = request_irq(mcfi2c->irq, mcfi2c_irq_handler, 0, pdev->name,
> +			mcfi2c);
> +	if (status) {
> +		dev_dbg(&pdev->dev, "request_irq failed\n");
> +		goto fail2;
> +	}
> +
> +	mcfi2c->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(mcfi2c->clk)) {
> +		dev_dbg(&pdev->dev, "clk_get failed\n");
> +		status = PTR_ERR(mcfi2c->clk);
> +		goto fail3;
> +	}
> +	clk_enable(mcfi2c->clk);
> +
> +	platform_set_drvdata(pdev, mcfi2c);
> +
> +	init_completion(&mcfi2c->completion);
> +
> +	writeb(mcfi2c_calc_fdr(mcfi2c, pdev->dev.platform_data),
> +	       mcfi2c->iobase + MCFI2C_FDR);
> +
> +	writeb(0x00, mcfi2c->iobase + MCFI2C_ADR);
> +
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN);
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	/* if the bus busy (IBB) is set, reset the controller */
> +	if (mcfi2c_rd_sr(mcfi2c)&  MCFI2C_SR_IBB)
> +		mcfi2c_reset(mcfi2c);
> +
> +	mcfi2c->adapter.algo		=&mcfi2c_algo;
> +	mcfi2c->adapter.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD;
> +	mcfi2c->adapter.dev.parent	=&pdev->dev;
> +	mcfi2c->adapter.nr		= pdev->id;
> +	mcfi2c->adapter.retries		= 2;
> +	snprintf(mcfi2c->adapter.name, sizeof(mcfi2c->adapter.name),
> +			DRIVER_NAME ".%d", pdev->id);
> +
> +	i2c_set_adapdata(&mcfi2c->adapter, mcfi2c);
> +
> +	status = i2c_add_numbered_adapter(&mcfi2c->adapter);
> +	if (status<  0) {
> +		dev_dbg(&pdev->dev, "i2c_add_numbered_adapter failed\n");
> +		goto fail4;
> +	}
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	dev_info(&pdev->dev, "Coldfire I2C bus driver\n");
> +
> +	return 0;
> +
> +fail4:
> +	pm_runtime_put(&pdev->dev);
> +
> +	clk_disable(mcfi2c->clk);
> +	clk_put(mcfi2c->clk);
> +fail3:
> +	free_irq(mcfi2c->irq, mcfi2c);
> +fail2:
> +	iounmap(mcfi2c->iobase);
> +fail1:
> +	release_mem_region(res->start, resource_size(res));
> +fail0:
> +	kfree(mcfi2c);
> +
> +	return status;
> +}
> +
> +static int __devexit mcfi2c_remove(struct platform_device *pdev)
> +{
> +	struct mcfi2c *mcfi2c = platform_get_drvdata(pdev);
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	/* disable the hardware */
> +	mcfi2c_wr_cr(mcfi2c, 0);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	i2c_del_adapter(&mcfi2c->adapter);
> +	clk_disable(mcfi2c->clk);
> +	clk_put(mcfi2c->clk);
> +	free_irq(mcfi2c->irq, mcfi2c);
> +	iounmap(mcfi2c->iobase);
> +	release_mem_region(res->start, resource_size(res));
> +	kfree(mcfi2c);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_RUNTIME
> +static int mcfi2c_runtime_suspend(struct device *dev)
> +{
> +	struct mcfi2c *mcfi2c = platform_get_drvdata(to_platform_device(dev));
> +
> +	mcfi2c_wr_cr(mcfi2c, 0);
> +	clk_disable(mcfi2c->clk);
> +
> +	return 0;
> +}
> +
> +static int mcfi2c_runtime_resume(struct device *dev)
> +{
> +	struct mcfi2c *mcfi2c = platform_get_drvdata(to_platform_device(dev));
> +
> +	clk_enable(mcfi2c->clk);
> +	mcfi2c_wr_cr(mcfi2c, MCFI2C_CR_IEN);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops mcfi2c_pm = {
> +	SET_RUNTIME_PM_OPS(mcfi2c_runtime_suspend, mcfi2c_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver mcfi2c_driver = {
> +	.driver.name	= DRIVER_NAME,
> +	.driver.owner	= THIS_MODULE,
> +	.driver.pm	=&mcfi2c_pm,
> +	.remove		= __devexit_p(mcfi2c_remove),
> +};
> +
> +static int __init mcfi2c_init(void)
> +{
> +	return platform_driver_probe(&mcfi2c_driver, mcfi2c_probe);
> +}
> +module_init(mcfi2c_init);
> +
> +static void __exit mcfi2c_exit(void)
> +{
> +	platform_driver_unregister(&mcfi2c_driver);
> +}
> +module_exit(mcfi2c_exit);
> +
> +MODULE_AUTHOR("Steven King<sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>");
> +MODULE_DESCRIPTION("I2C-Bus support for Freescale Coldfire processors");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
>
>
>
>


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg-XXXsiaCtIV5Wk0Htik3J/w@public.gmane.org
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
