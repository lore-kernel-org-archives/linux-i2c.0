From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c/busses: Add support for Aeroflex Gaisler I2CMST
	controller
Date: Wed, 23 Feb 2011 01:06:27 +0000
Message-ID: <20110223010627.GZ15795@trinity.fluff.org>
References: <1297859448-6621-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297859448-6621-1-git-send-email-jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 01:30:48PM +0100, Jan Andersson wrote:
> This patch adds support for the I2CMST core found on LEON/GRLIB SoCs.
> 
> Signed-off-by: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
> ---
> The I2CMST core is basically the OpenCores I2C master with an AMBA APB
> interface. This driver re-uses much of i2c-ocores.c. It is submitted as
> a separate driver since the register interfaces differ sligthly. Also the
> two IP cores are maintained separately so they may diverge further in
> the future.

Hmm, some more of that should go above the "---" line.

Going to do a quick review and then get back to this once I've had some
time to think on it.
 
> The driver is identical in terms of transfer handling and HW control.
> The original module author string has been kept.
> 
>  drivers/i2c/busses/Kconfig         |   10 +
>  drivers/i2c/busses/Makefile        |    1 +
>  drivers/i2c/busses/i2c-gr-i2cmst.c |  371 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-gr-i2cmst.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 113505a..06a3150 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -646,6 +646,16 @@ config I2C_EG20T
>            is an IOH(Input/Output Hub) for x86 embedded processor.
>            This driver can access PCH I2C bus device.
>  
> +config I2C_GR_I2CMST
> +	tristate "Aeroflex Gaisler I2CMST I2C Controller"
> +	depends on SPARC_LEON
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2CMST I2C controller present on some LEON/GRLIB SoCs.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-gr-i2cmst.
> +
>  comment "External I2C/SMBus adapter drivers"
>  
>  config I2C_PARPORT
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 9d2d0ec..1e16e66 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -62,6 +62,7 @@ obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
>  obj-$(CONFIG_I2C_OCTEON)	+= i2c-octeon.o
>  obj-$(CONFIG_I2C_XILINX)	+= i2c-xiic.o
>  obj-$(CONFIG_I2C_EG20T)         += i2c-eg20t.o
> +obj-$(CONFIG_I2C_GR_I2CMST)	+= i2c-gr-i2cmst.o
>  
>  # External I2C/SMBus adapter drivers
>  obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
> diff --git a/drivers/i2c/busses/i2c-gr-i2cmst.c b/drivers/i2c/busses/i2c-gr-i2cmst.c
> new file mode 100644
> index 0000000..90b23a8
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-gr-i2cmst.c
> @@ -0,0 +1,371 @@
> +/*
> + * i2c-gr-i2cmst.c I2C bus driver for GRLIB I2CMST core
> + *
> + * Main parts of this driver re-used from:
> + *
> + * i2c-ocores.c: I2C bus driver for OpenCores I2C controller
> + * by Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
> + *
> + * Adaption to GRLIB/I2CMST by Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/wait.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +
> +/* I2CMST APB registers */
> +struct i2cmst_regs {
> +	u32 prescaler;
> +	u32 control;
> +	u32 data;
> +	u32 cmdstat; /* Command (write), Status (read) */
> +};

using structures for memory mapped registers makes me want to go
EURGH. the compiler is free to pack and order as it feels.

> +struct gr_i2cmst_i2c {
> +	struct i2cmst_regs *regs;
> +	wait_queue_head_t wait;
> +	struct i2c_adapter adap;
> +	struct i2c_msg *msg;
> +	int pos;
> +	int nmsgs;
> +	int state; /* see STATE_ */
> +	int clock_khz;
> +};
> +
> +/* register fields and commands */
> +#define I2CMST_CTRL_IEN		0x40
> +#define I2CMST_CTRL_EN		0x80
> +
> +#define I2CMST_CMD_START	0x91
> +#define I2CMST_CMD_STOP		0x41
> +#define I2CMST_CMD_READ		0x21
> +#define I2CMST_CMD_WRITE	0x11
> +#define I2CMST_CMD_READ_ACK	0x21
> +#define I2CMST_CMD_READ_NACK	0x29
> +#define I2CMST_CMD_IACK		0x01
> +
> +#define I2CMST_STAT_IF		0x01
> +#define I2CMST_STAT_TIP		0x02
> +#define I2CMST_STAT_ARBLOST	0x20
> +#define I2CMST_STAT_BUSY	0x40
> +#define I2CMST_STAT_NACK	0x80
> +
> +#define STATE_DONE		0
> +#define STATE_START		1
> +#define STATE_WRITE		2
> +#define STATE_READ		3
> +#define STATE_ERROR		4
> +
> +static inline void i2cmst_setreg(void __iomem *reg, u32 value)
> +{
> +	__raw_writel(cpu_to_be32(value), reg);
> +}
> +
> +static inline u32 i2cmst_getreg(void __iomem *reg)
> +{
> +	return be32_to_cpu(__raw_readl(reg));
> +}

do you really need to use the __raw versions of thees calls?

> +static void gr_i2cmst_process(struct gr_i2cmst_i2c *i2c)
> +{
> +	struct i2c_msg *msg = i2c->msg;
> +	u32 stat = i2cmst_getreg(&i2c->regs->cmdstat);
> +
> +	if ((i2c->state == STATE_DONE) || (i2c->state == STATE_ERROR)) {
> +		/* stop has been sent */
> +		i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_IACK);
> +		wake_up(&i2c->wait);
> +		return;
> +	}
> +
> +	/* error? */
> +	if (stat & I2CMST_STAT_ARBLOST) {
> +		i2c->state = STATE_ERROR;
> +		i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_STOP);
> +		return;
> +	}
> +
> +	if ((i2c->state == STATE_START) || (i2c->state == STATE_WRITE)) {
> +		i2c->state =
> +			(msg->flags & I2C_M_RD) ? STATE_READ : STATE_WRITE;
> +
> +		if (stat & I2CMST_STAT_NACK) {
> +			i2c->state = STATE_ERROR;
> +			i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_STOP);
> +			return;
> +		}
> +	} else
> +		msg->buf[i2c->pos++] = i2cmst_getreg(&i2c->regs->data);
> +
> +	/* end of msg? */
> +	if (i2c->pos == msg->len) {
> +		i2c->nmsgs--;
> +		i2c->msg++;
> +		i2c->pos = 0;
> +		msg = i2c->msg;
> +
> +		if (i2c->nmsgs) {	/* end? */
> +			/* send start? */
> +			if (!(msg->flags & I2C_M_NOSTART)) {
> +				u8 addr = (msg->addr << 1);
> +
> +				if (msg->flags & I2C_M_RD)
> +					addr |= 1;
> +
> +				i2c->state = STATE_START;
> +
> +				i2cmst_setreg(&i2c->regs->data, addr);
> +				i2cmst_setreg(&i2c->regs->cmdstat,
> +					I2CMST_CMD_START);
> +				return;
> +			} else
> +				i2c->state = (msg->flags & I2C_M_RD)
> +					? STATE_READ : STATE_WRITE;
> +		} else {
> +			i2c->state = STATE_DONE;
> +			i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_STOP);
> +			return;
> +		}
> +	}
> +
> +	if (i2c->state == STATE_READ) {
> +		i2cmst_setreg(&i2c->regs->cmdstat, i2c->pos == (msg->len-1) ?
> +			I2CMST_CMD_READ_NACK : I2CMST_CMD_READ_ACK);
> +	} else {
> +		i2cmst_setreg(&i2c->regs->data, msg->buf[i2c->pos++]);
> +		i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_WRITE);
> +	}
> +}
> +
> +static irqreturn_t gr_i2cmst_isr(int irq, void *dev_id)
> +{
> +	struct gr_i2cmst_i2c *i2c = dev_id;
> +
> +	gr_i2cmst_process(i2c);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int gr_i2cmst_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	struct gr_i2cmst_i2c *i2c = i2c_get_adapdata(adap);
> +
> +	i2c->msg = msgs;
> +	i2c->pos = 0;
> +	i2c->nmsgs = num;
> +	i2c->state = STATE_START;
> +
> +	i2cmst_setreg(&i2c->regs->data, (i2c->msg->addr << 1) |
> +			((i2c->msg->flags & I2C_M_RD) ? 1 : 0));
> +
> +	i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_START);
> +
> +	if (wait_event_timeout(i2c->wait, (i2c->state == STATE_ERROR) ||
> +			       (i2c->state == STATE_DONE), HZ))
> +		return (i2c->state == STATE_DONE) ? num : -EIO;
> +	else
> +		return -ETIMEDOUT;
> +}
> +
> +static void gr_i2cmst_init(struct gr_i2cmst_i2c *i2c)
> +{
> +	int prescale;
> +	u32 ctrl = i2cmst_getreg(&i2c->regs->control);
> +
> +	/* make sure the device is disabled */
> +	i2cmst_setreg(&i2c->regs->control,
> +			ctrl & ~(I2CMST_CTRL_EN|I2CMST_CTRL_IEN));
> +
> +	/* Required prescaler = (AMBAfreq)/(5 * SCLfreq)-1 */
> +	prescale = (i2c->clock_khz / (5*100)) - 1;
> +	/* Minimum value of precaler is 3 due to HW sync */
> +	prescale = prescale < 3 ? 3 : prescale;
> +	i2cmst_setreg(&i2c->regs->prescaler, prescale);
> +
> +	/* Init the device */
> +	i2cmst_setreg(&i2c->regs->cmdstat, I2CMST_CMD_IACK);
> +	ctrl |= I2CMST_CTRL_IEN | I2CMST_CTRL_EN;
> +	i2cmst_setreg(&i2c->regs->control, ctrl);
> +}
> +
> +
> +static u32 gr_i2cmst_func(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +}
> +
> +static const struct i2c_algorithm gr_i2cmst_algorithm = {
> +	.master_xfer	= gr_i2cmst_xfer,
> +	.functionality	= gr_i2cmst_func,
> +};
> +
> +static struct i2c_adapter gr_i2cmst_adapter = {
> +	.owner		= THIS_MODULE,
> +	.name		= "i2c-gr-i2cmst",
> +	.class		= I2C_CLASS_HWMON | I2C_CLASS_SPD,
> +	.algo		= &gr_i2cmst_algorithm,
> +};
> +
> +
> +static int __devinit gr_i2cmst_of_probe(struct platform_device *ofdev, const struct of_device_id *match)

please avoid line-wrap like this.

> +{
> +	struct gr_i2cmst_i2c *i2c;
> +	const unsigned int *busfreq;
> +	int ret;
> +
> +	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;

would be nice to have an error print here.

> +	/* Get frequency of APB bus that core is attached to */
> +	busfreq = of_get_property(ofdev->dev.of_node, "freq", NULL);
> +	if (!busfreq) {
> +		dev_err(&ofdev->dev, "Missing parameter 'freq'\n");
> +		return -ENODEV;
> +	}
> +	i2c->clock_khz = *busfreq/1000;
> +
> +	i2c->regs = of_ioremap(&ofdev->resource[0], 0,
> +			resource_size(&ofdev->resource[0]),
> +			"grlib-i2cmst regs");
> +	if (!i2c->regs) {
> +		dev_err(&ofdev->dev, "Unable to map registers\n");
> +		ret = -EIO;
> +		goto map_failed;
> +	}
> +
> +	gr_i2cmst_init(i2c);
> +
> +	init_waitqueue_head(&i2c->wait);
> +	ret = request_irq(ofdev->archdata.irqs[0], gr_i2cmst_isr, 0,
> +			ofdev->name, i2c);
> +	if (ret) {
> +		dev_err(&ofdev->dev, "Cannot claim IRQ\n");
> +		goto request_irq_failed;
> +	}
> +
> +	/* hook up driver to tree */
> +	dev_set_drvdata(&ofdev->dev, i2c);
> +	i2c->adap = gr_i2cmst_adapter;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	i2c->adap.dev.parent = &ofdev->dev;
> +	i2c->adap.dev.of_node = ofdev->dev.of_node;
> +
> +	/* add i2c adapter to i2c tree */
> +	ret = i2c_add_adapter(&i2c->adap);
> +	if (ret) {
> +		dev_err(&ofdev->dev, "Failed to add adapter\n");
> +		goto add_adapter_failed;
> +	}
> +
> +	return 0;
> +
> +add_adapter_failed:
> +	free_irq(ofdev->archdata.irqs[0], i2c);
> +request_irq_failed:
> +	of_iounmap(&ofdev->resource[0], i2c->regs,
> +		resource_size(&ofdev->resource[0]));
> +map_failed:
> +	kfree(i2c);
> +
> +	return ret;
> +}
> +
> +static int __devexit gr_i2cmst_of_remove(struct platform_device *ofdev)
> +{
> +	struct gr_i2cmst_i2c *i2c = dev_get_drvdata(&ofdev->dev);
> +	u32 ctrl = i2cmst_getreg(&i2c->regs->control);
> +
> +	/* disable i2c logic */
> +	i2cmst_setreg(&i2c->regs->control,
> +		ctrl & ~(I2CMST_CTRL_EN|I2CMST_CTRL_IEN));
> +
> +	/* remove adapter & data */
> +	i2c_del_adapter(&i2c->adap);
> +	dev_set_drvdata(&ofdev->dev, NULL);
> +
> +	free_irq(ofdev->archdata.irqs[0], i2c);
> +
> +	of_iounmap(&ofdev->resource[0], i2c->regs,
> +		resource_size(&ofdev->resource[0]));
> +
> +	kfree(i2c);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int gr_i2cmst_suspend(struct platform_device *ofdev, pm_message_t state)
> +{
> +	struct gr_i2cmst_i2c *i2c = dev_get_drvdata(&ofdev->dev);
> +	u32 ctrl = gr_i2cmst_getreg(&i2c->regs->control);
> +
> +	/* make sure the device is disabled */
> +	gr_i2cmst_setreg(&i2c->regs->control,
> +			ctrl & ~(I2CMST_CTRL_EN|I2CMST_CTRL_IEN));
> +
> +	return 0;
> +}
> +
> +static int gr_i2cmst_resume(struct platform_device *ofdev)
> +{
> +	struct gr_i2cmst_i2c *i2c = dev_get_drvdata(&ofdev->dev);
> +
> +	gr_i2cmst_init(i2c);
> +
> +	return 0;
> +}
> +#else
> +#define gr_i2cmst_suspend	NULL
> +#define gr_i2cmst_resume	NULL
> +#endif
> +
> +static struct of_device_id gr_i2cmst_of_match[] = {
> +	{ .name = "GAISLER_I2CMST", },
> +	{ .name = "01_028", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, gr_i2cmst_of_match);
> +
> +static struct of_platform_driver gr_i2cmst_of_driver = {
> +	.driver = {
> +		.name = "grlib-i2cmst",
> +		.owner = THIS_MODULE,
> +		.of_match_table = gr_i2cmst_of_match,
> +	},
> +	.probe = gr_i2cmst_of_probe,
> +	.remove = __devexit_p(gr_i2cmst_of_remove),
> +	.suspend = gr_i2cmst_suspend,
> +	.resume  = gr_i2cmst_resume,
> +};
> +
> +
> +static int __init i2cmst_init(void)
> +{
> +	return of_register_platform_driver(&gr_i2cmst_of_driver);
> +}
> +
> +static void __exit i2cmst_exit(void)
> +{
> +	of_unregister_platform_driver(&gr_i2cmst_of_driver);
> +}
> +
> +module_init(i2cmst_init);
> +module_exit(i2cmst_exit);
> +
> +MODULE_AUTHOR("Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>");
> +MODULE_DESCRIPTION("GRLIB I2CMST I2C bus driver");
> +MODULE_LICENSE("GPL");

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
