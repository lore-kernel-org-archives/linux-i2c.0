From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] Add support for on-board i2c device on
	NXP	PNX833x SOC
Date: Mon, 16 Jun 2008 01:21:18 +0100
Message-ID: <20080616002118.GC30539@fluff.org.uk>
References: <64660ef00806060502n369d495l79c68351c3799d60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <64660ef00806060502n369d495l79c68351c3799d60-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Daniel Laird <daniel.j.laird-3arQi8VN3Tc@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 06, 2008 at 01:02:43PM +0100, Daniel Laird wrote:
> The following patch add support for the NXP PNX833x SOC i2c device.
> The SOC code is pending with linux-mips.
> 
>  drivers/i2c/busses/Kconfig       |   12 +
>  drivers/i2c/busses/Makefile      |    1
>  drivers/i2c/busses/i2c-pnx0105.c |  328 +++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-id.h           |    1
>  include/linux/i2c-pnx0105.h      |   58 ++++++
>  5 files changed, 400 insertions(+)
> 
> Signed-off-by: daniel.j.laird <daniel.j.laird-3arQi8VN3Tc@public.gmane.org>
> 
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pnx0105.c
> linux-2.6.26-rc4/drivers/i2c/busses/i2c-pnx0105.c
> --- linux-2.6.26-rc4.orig/drivers/i2c/busses/i2c-pnx0105.c	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/drivers/i2c/busses/i2c-pnx0105.c	2008-06-05
> 11:25:57.000000000 +0100
> @@ -0,0 +1,328 @@
> +/*
> + *  i2c-pnx0105.c: driver for PNX833X I2C (IP0105 Block)
> + *
> + *  Copyright 2008 NXP Semiconductors
> + *    Daniel Laird <daniel.j.laird-3arQi8VN3Tc@public.gmane.org>
> + *
> + *  Copyright (C) 2006 Nikita Youshchenko <yoush-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>

Please ensure that this authour is copied in. If the original authour
isn't interested, then it would be useful to find this out, otherwise
please CC: and attempt to get a Signed-off-by: line for this.

> + *
> + *  Partially based on i2c-pca-isa driver, Copyright (C) 2004 Arcom Control
> + *  Systems.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c-id.h>
> +#include <linux/i2c-pnx0105.h>
> +#include <linux/i2c-algo-pca.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +static inline unsigned long i2c_pnx0105_in(struct i2c_pnx0105_dev
> *dev, int offset)
> +{
> +	return readl((unsigned long *)(dev->base + offset));
> +}

Firstly, 'unsigned long *' is missing the __iomem attribute, which
sparse should moan about if you've not tried running sparse during
the compile process.

Secondly, if you define 'dev->base' as 'void __iomem *', then readl()
should just accept that (and if not, then your architecture's readl
is, IMHO, broken). This should also remove the necessity to cast
dev->base to readl.

> +static inline void i2c_pnx0105_out(struct i2c_pnx0105_dev *dev, int
> offset, unsigned long value)
> +{
> +	writel(value, (unsigned long *)(dev->base + offset));
> +}

See above comments for i2c_pnx0105_in.

> +static void i2c_pnx0105_writebyte(void *pa, int reg, int val)
> +{
> +	struct i2c_algo_pca_data *algo_data = container_of(pa, struct
> i2c_algo_pca_data, data);
> +	struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
> i2c_pnx0105_dev, algo_data);
> +	int old_si;
> +
> +#ifdef DEBUG
> +	static char *names[] = { "T/O", "DAT", "ADR", "CON"};
> +	printk(KERN_DEBUG "i2c_pnx0105(0x%08lx): write %s <= %#04x\n",
> dev->base, names[reg], val);
> +#endif

One, i'd suggest making a single area of debug which is then inlined
Two, keep a pointer to the device your driver bound to and use 
dev_dbg() to output debug information.


> +
> +	switch (reg) {
> +
> +	case I2C_PCA_DAT:
> +		i2c_pnx0105_out(dev, I2C_PNX0105_DAT, val & 255);
> +		break;
> +
> +	case I2C_PCA_ADR:
> +		i2c_pnx0105_out(dev, I2C_PNX0105_ADDRESS, val & 255);
> +		break;

out of interest, is it possible to avoid the '& 255' on these?

> +
> +	case I2C_PCA_CON:
> +		/* Possible RACE: just after init, or after stop,
> +		   SI bit is zero. That means that when STA bit
> +		   is written, hardware starts to process it
> +		   immediately. It could complete very fast (or
> +		   perhaps thread may get preempted), so when code
> +		   several lines below is executed, SI could already
> +		   be set to indicate that STA processing is complete.
> +		   In this case, SI must NOT be cleared here, so
> +		   hardware won't continue and send slave address
> +		   before it was written to register.
> +		   However, if SI bit is currently set, hardware
> +		   won't process command immediately, and SI should
> +		   be cleared at the bottom, to enable processing.
> +		   Solution: just check SI here, and clear it only
> +		   if it was set before any new value was written
> +		   to command register.
> +		 */
> +		old_si = i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS) & 1;
> +
> +		i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val & 255);
> +
> +		/* We have to process STO bit separately */
> +		if (val & I2C_PCA_CON_STO)
> +			i2c_pnx0105_out(dev, I2C_PNX0105_STOP, 1);
> +
> +		/* And also SI bit ... */
> +		if (old_si && !(val & I2C_PCA_CON_SI)) {
> +			i2c_pnx0105_out(dev, I2C_PNX0105_INT_CLEAR, 1);
> +			if (dev->irq > -1 && !(val & I2C_PCA_CON_STO))
> +				i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 1);
> +		}
> +
> +		break;
> +
> +	default:
> +		BUG();
> +	}
> +}
> +
> +static int i2c_pnx0105_readbyte(void *pa, int reg)
> +{
> +	struct i2c_algo_pca_data *algo_data = container_of(pa, struct
> i2c_algo_pca_data, data);
> +	struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
> i2c_pnx0105_dev, algo_data);

these wrap, it would be nicer if you had a pair of inline functions, such
as to_pca() and  to_pnxdev() to deal with this.

> +	int res = 0;
> +
> +	switch (reg) {
> +
> +	case I2C_PCA_STA:
> +		if (dev->timeout) {
> +			res = 0xff;
> +			dev->timeout = 0;
> +		} else
> +			res	= i2c_pnx0105_in(dev, I2C_PNX0105_STATUS) & 255;

whopping great space between 'res' and i2c_pnx0105_in().

> +		break;
> +
> +	case I2C_PCA_DAT:
> +		res = i2c_pnx0105_in(dev, I2C_PNX0105_DAT) & 255;
> +		break;
> +
> +	case I2C_PCA_CON:
> +		res = i2c_pnx0105_in(dev, I2C_PNX0105_CONTROL) & 255;
> +
> +		/* Read SI bit from elsewhere */
> +		if (i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS))
> +			res |= I2C_PCA_CON_SI;
> +		else
> +			res	&= ~I2C_PCA_CON_SI;

oops, big space again?

> +
> +		break;
> +
> +	default:
> +		BUG();
> +	}
> +
> +#ifdef DEBUG
> +	{
> +		static char *names[] = { "STA", "DAT", "ADR", "CON"};
> +		printk(KERN_DEBUG "i2c_pnx0105(0x%08lx): read %s => %#04x\n",
> dev->base, names[reg], res);
> +	}
> +#endif

could you turn these bits of debug into inline functions and group
them at the top of the file together.

> +	return res;
> +}
> +
> +static inline void i2c_pnx0105_reset(struct i2c_pnx0105_dev *dev)
> +{
> +	unsigned long val = i2c_pnx0105_in(dev, I2C_PNX0105_CONTROL) & 0x47;

blank line in here would be nice. What is 0x47? and add to that, can
we have constants for some of these values you are using? 

> +	i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val | 0x40);
> +	i2c_pnx0105_out(dev, I2C_PNX0105_STOP, 1);
> +	i2c_pnx0105_out(dev, I2C_PNX0105_INT_CLEAR, 1);
> +	udelay(200);
> +	i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, val);
> +}
> +
> +static inline int i2c_pnx0105_intr_condition(struct i2c_pnx0105_dev *dev)
> +{
> +	return i2c_pnx0105_in(dev, I2C_PNX0105_INT_STATUS) & 1;
> +}
> +
> +static int i2c_pnx0105_waitforcompletion(void *pa)
> +{
> +	struct i2c_algo_pca_data *algo_data = container_of(pa, struct
> i2c_algo_pca_data, data);
> +	struct i2c_pnx0105_dev *dev = container_of(algo_data, struct
> i2c_pnx0105_dev, algo_data);
> +
> +	/* Set some timeout */
> +#define JIFFIES_TO_WAIT	((HZ / 100) + 1)	/* attempt to model 10 milliseconds */

there are valid calls for jiffies=>msecs.

> +
> +	if (dev->irq > -1) {
> +		wait_event_timeout(dev->wait,
> +						   i2c_pnx0105_intr_condition(dev), JIFFIES_TO_WAIT);

hmm, is that indeting proprely or is my mail client doing silliness?

> +	} else {
> +		unsigned long end = jiffies + JIFFIES_TO_WAIT;
> +		while (!i2c_pnx0105_intr_condition(dev) &&
> +			   time_before(jiffies, end)) {
> +			if (in_atomic())
> +				udelay(100);
> +			else
> +				schedule();
> +		}

is there a better way to do this other than udelay/schedule? I'm also
not entirely sure if the in_atomic() bit is a good diea, why would it
be called in an atomic context?

> +	}
> +
> +	if (i2c_pnx0105_intr_condition(dev))
> +		return 0;
> +
> +	/* Timeout. Reset device and make next status read to return 0xff */
> +	i2c_pnx0105_reset(dev);
> +	dev->timeout = 1;
> +	return -EIO;	/* Ignored anyway */
> +}
> +
> +static irqreturn_t i2c_pnx0105_interrupt(int this_irq, void *dev_id)
> +{
> +	struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)dev_id;
> +
> +	/* Disable interrupt for a while (until it's actually handled) */
> +	i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 0);
> +
> +	/* Wake up any process waiting for this interrupt */
> +	wake_up_interruptible(&dev->wait);
> +
> +	return IRQ_HANDLED;
> +}

An explanation of why you need to use a process, would it be possible
to deal with some of the interrupt conditions iwhtin the interrupt
handler?

> +
> +static int __devinit i2c_pnx0105_probe(struct platform_device *pdev)
> +{
> +	struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)
> pdev->dev.platform_data;

you don't need a cast here.

> +	struct i2c_algo_pca_data *algo_data = &dev->algo_data;
> +	struct i2c_adapter *adap = &dev->adap;
> +	int res;
> +
> +	algo_data->write_byte = i2c_pnx0105_writebyte;
> +	algo_data->read_byte = i2c_pnx0105_readbyte;
> +	algo_data->wait_for_completion = i2c_pnx0105_waitforcompletion;
> +
> +	adap->owner = THIS_MODULE;
> +	adap->id = I2C_HW_A_PNX0105;
> +	adap->algo_data = algo_data;
> +	strncpy(adap->name, pdev->name, I2C_NAME_SIZE);
> +
> +	dev->timeout = 0;
> +	init_waitqueue_head(&dev->wait);
> +
> +	if (request_region(dev->base, I2C_PNX0105_IO_SIZE, "i2c-pnx") == 0) {

Passing in an IO-address like this isn't standard, usually the physical
address of the device is passed in via the resource structure. You could
also pass in the IRQ number like this.

> +		printk(KERN_ERR "i2c-pnx0105: request_region(0x%08lx) failed\n",
> +			   dev->base);
> +		return -EBUSY;
> +	}

you've got a platform device, use dev_err() here.

> +
> +	/* Disable interrupt - just to be sure ... */
> +	i2c_pnx0105_out(dev, I2C_PNX0105_INT_ENABLE, 0);
> +
> +	if (dev->irq > -1) {
> +		res = request_irq(dev->irq, i2c_pnx0105_interrupt, 0, "i2c-pnx", dev);
> +		if (res < 0) {
> +			printk(KERN_ERR "i2c-pnx0105: request_irq() failed\n");
> +			goto err_region;
> +		}
> +	}

add dev_err() is the write thing to do here ttoo.

> +	/* Rude attempt to probe hardware, to avoid future hangups if it is
> +	   not responding */

is this to ensure the hardware is there and working? why was it added to
the platform bus if you're not sure if it is there?

> +	i2c_pnx0105_out(dev, I2C_PNX0105_CONTROL, 0x60);
> +	udelay(200);
> +	res = i2c_pnx0105_intr_condition(dev) ? 0 : -ENODEV;
> +	i2c_pnx0105_reset(dev);
> +
> +	if (res < 0) {
> +		printk(KERN_ERR "i2c-pnx0105: device at 0x%08lx is not responding\n",
> +			   dev->base);
> +		goto err_irq;
> +	}

and here, dev_err is also your friend, ie:

		dev_err(&pdev->dev, "device at 0x%08lx is not responding\n");

PS, %08lx is not good enough for a resource type as there is the possibility
of building a kernel with 64bit resources, so:

	dev_err(&pdev->dev, "device at 0x%llx is not responding\n".
		(unsigned long long)dev->base).

Alternatively, drop the dev base, the platform device has a unique id.  

> +
> +	res = i2c_pca_add_bus(adap);
> +	if (res < 0) {
> +		printk(KERN_ERR "i2c-pnx0105: i2c_pca_add_bus() failed\n");
> +		goto err_irq;
> +	}
> +
> +	printk(KERN_INFO "i2c-pnx0105: registered device at 0x%08lx", dev->base);
> +	if (dev->irq > -1)
> +		printk(KERN_ERR ", irq %d", dev->irq);
> +	printk(KERN_INFO "\n");
> +
> +	return 0;
> +
> +err_irq:
> +	if (dev->irq > -1)
> +		free_irq(dev->irq, dev);
> +
> +err_region:
> +	release_region(dev->base, I2C_PNX0105_IO_SIZE);
> +
> +	return res;
> +}
> +
> +static int __devexit i2c_pnx0105_remove(struct platform_device *pdev)
> +{
> +	struct i2c_pnx0105_dev *dev = (struct i2c_pnx0105_dev *)
> pdev->dev.platform_data;

cast is not needed here.

> +	struct i2c_adapter *adap = &dev->adap;
> +	int res;
> +
> +	res = i2c_del_adapter(adap);
> +	if (res < 0)
> +		return res;

print an error, this is seroues.

> +
> +	if (dev->irq > -1)
> +		free_irq(dev->irq, dev);
> +
> +	release_region(dev->base, I2C_PNX0105_IO_SIZE);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver i2c_pnx0105_driver = {
> +	.probe      = i2c_pnx0105_probe,
> +	.remove     = __devexit_p(i2c_pnx0105_remove),
> +				  .driver     = {

over-indented?

> +		.owner  = THIS_MODULE,
> +		.name   = "i2c-pnx0105",
> +	},
> +};

out of interest, no suspend/resume?

> +
> +static int __init i2c_pnx0105_init(void)
> +{
> +	return platform_driver_register(&i2c_pnx0105_driver);
> +}
> +
> +static void __exit i2c_pnx0105_cleanup(void)
> +{
> +	platform_driver_unregister(&i2c_pnx0105_driver);
> +}
> +
> +module_init(i2c_pnx0105_init);
> +module_exit(i2c_pnx0105_cleanup);
> +
> +MODULE_AUTHOR("Nikita Youshchenko <yoush-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>");
> +MODULE_DESCRIPTION("PNX833X I2C driver");
> +MODULE_LICENSE("GPL");

One, you're after MODULE_LICENSE("GPL v2"); here
Two, you've missed the MODULE_ALIAS("platform:i2c-pnx0105");

> +
> +
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/drivers/i2c/busses/Kconfig
> linux-2.6.26-rc4/drivers/i2c/busses/Kconfig
> --- linux-2.6.26-rc4.orig/drivers/i2c/busses/Kconfig	2008-06-03
> 10:56:53.000000000 +0100
> +++ linux-2.6.26-rc4/drivers/i2c/busses/Kconfig	2008-06-04
> 09:29:35.000000000 +0100
> @@ -677,6 +677,18 @@
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called i2c-pnx.
> 
> +config I2C_PNX0105
> +	tristate "I2C bus support for Philips PNX8XXX targets"
> +	depends on I2C && SOC_PNX833X
> +	select I2C_ALGOPCA
> +	default y
> +	help
> +	  Support for NXP PNX SoC internal I2C (IP0105).
> +	  Say y or m if you want to use PNX I2C interfaces.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-pnx0105.
> +
>  config I2C_PMCMSP
>  	tristate "PMC MSP I2C TWI Controller"
>  	depends on PMC_MSP
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/drivers/i2c/busses/Makefile
> linux-2.6.26-rc4/drivers/i2c/busses/Makefile
> --- linux-2.6.26-rc4.orig/drivers/i2c/busses/Makefile	2008-06-03
> 10:56:53.000000000 +0100
> +++ linux-2.6.26-rc4/drivers/i2c/busses/Makefile	2008-06-04
> 09:29:40.000000000 +0100
> @@ -34,6 +34,7 @@
>  obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
>  obj-$(CONFIG_I2C_PMCMSP)	+= i2c-pmcmsp.o
>  obj-$(CONFIG_I2C_PNX)		+= i2c-pnx.o
> +obj-$(CONFIG_I2C_PNX0105)	+= i2c-pnx0105.o
>  obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
>  obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
> diff -urN --exclude=.svn linux-2.6.26-rc4.orig/include/linux/i2c-id.h
> linux-2.6.26-rc4/include/linux/i2c-id.h
> --- linux-2.6.26-rc4.orig/include/linux/i2c-id.h	2008-06-05
> 11:41:44.000000000 +0100
> +++ linux-2.6.26-rc4/include/linux/i2c-id.h	2008-06-04 09:33:51.000000000 +0100
> @@ -129,6 +129,7 @@
> 
>  /* --- PCA 9564 based algorithms */
>  #define I2C_HW_A_ISA		0x1a0000 /* generic ISA Bus interface card */
> +#define I2C_HW_A_PNX0105	0x1a0001 /* NXP PNX833X SoC I2C	*/
> 
>  /* --- PowerPC on-chip adapters						*/
>  #define I2C_HW_OCP		0x120000 /* IBM on-chip I2C adapter */
> diff -urN --exclude=.svn
> linux-2.6.26-rc4.orig/include/linux/i2c-pnx0105.h
> linux-2.6.26-rc4/include/linux/i2c-pnx0105.h
> --- linux-2.6.26-rc4.orig/include/linux/i2c-pnx0105.h	1970-01-01
> 01:00:00.000000000 +0100
> +++ linux-2.6.26-rc4/include/linux/i2c-pnx0105.h	2008-06-05
> 09:32:31.000000000 +0100
> @@ -0,0 +1,58 @@
> +/*
> + *  i2c-pnx0105.h: driver for PNX833X I2C (IP0105 Block)
> + *    Copyright (C) 2006 Nikita Youshchenko <yoush-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +#ifndef _LINUX_I2C_PNX0105_H
> +#define _LINUX_I2C_PNX0105_H
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-pca.h>
> +#include <linux/wait.h>
> +
> +struct i2c_pnx0105_dev {
> +	unsigned long base;
> +	int irq;
> +	unsigned char clock;	/* value to write to freq bits of control reg */
> +	unsigned char bus_addr;	/* bus address for slave mode; currently not
> supported */
> +
> +	int timeout;		/* non-zero when timeout was detected */
> +	wait_queue_head_t wait;
> +
> +	struct i2c_algo_pca_data algo_data;
> +	struct i2c_adapter adap;
> +};

I'd move the 'struct i2c_pnx0105_dev' into the driver, where it is
easier to see and you don't end up having to include three files
for a head.

> +
> +/* Register area size */
> +#define I2C_PNX0105_IO_SIZE		0x1000
> +
> +/* Register offsets */
> +#define I2C_PNX0105_CONTROL     0x0000
> +#define I2C_PNX0105_DAT         0x0004
> +#define I2C_PNX0105_STATUS		0x0008
> +#define I2C_PNX0105_ADDRESS		0x000C
> +#define I2C_PNX0105_STOP		0x0010
> +#define I2C_PNX0105_PD          0x0014
> +#define I2C_PNX0105_SET_PINS	0x0018
> +#define I2C_PNX0105_OBS_PINS	0x001C
> +#define I2C_PNX0105_INT_STATUS	0x0FE0
> +#define I2C_PNX0105_INT_ENABLE	0x0FE4
> +#define I2C_PNX0105_INT_CLEAR	0x0FE8
> +#define I2C_PNX0105_INT_SET		0x0FEC
> +#define I2C_PNX0105_POWER_DOWN	0x0FF4
> +#define I2C_PNX0105_MODULE_ID	0x0FFC
> +
> +#endif

As a note, have you run either of sparse or kernel/scripts/checkpatch.pl
over this?

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
