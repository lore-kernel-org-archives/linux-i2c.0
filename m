From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH] I2C bus driver for SH7760 SoC, #2
Date: Sat, 23 Feb 2008 17:15:13 +0100
Message-ID: <20080223171513.678f04d0@hyperion.delvare>
References: <20071105172313.GB17951@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20071105172313.GB17951-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: linuxsh-dev-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Manuel,

Sorry for the delay, I missed your post...

On Mon, 5 Nov 2007 18:23:13 +0100, Manuel Lauss wrote:
> Here goes try #2 for the sh7760 i2c bus driver.
> 
> Changes sind #1:
> - incorporate Paul Mundt's suggestions

Thanks Paul for the initial review :)

> Comments appreciated!

Review:

> I2C master driver for the 2 I2C interfaces on the Renesas SH7760 SoC.
> 
> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> 
> ---
>  drivers/i2c/busses/Kconfig      |   11 +
>  drivers/i2c/busses/Makefile     |    1 +
>  drivers/i2c/busses/i2c-sh7760.c |  627 +++++++++++++++++++++++++++++++++++++++
>  include/asm-sh/i2c-sh7760.h     |   23 ++
>  4 files changed, 662 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index c466c6c..94d6cc9 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -675,4 +675,15 @@ config I2C_PMCMSP
>  	  This driver can also be built as module. If so, the module
>  	  will be called i2c-pmcmsp.
>  
> +config I2C_SH7760
> +	tristate "Renesas SH7760 I2C Controller"
> +	depends on I2C && CPU_SUBTYPE_SH7760

The dependency upon I2C is now handled at menu level, no need to
mention it here.

> +	default n

Not sure if this default makes much sense, as the option is only
available if CPU_SUBTYPE_SH7760=y, in which case I guess most users
will want to build the driver?

> +	help
> +	  If you say yes to this option, support will be included for the
> +	  built-in I2C interface of the Renesas SH7760 processor.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-sh7760.
> +
>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 81d43c2..95d6284 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_I2C_PROSAVAGE)	+= i2c-prosavage.o
>  obj-$(CONFIG_I2C_PXA)		+= i2c-pxa.o
>  obj-$(CONFIG_I2C_S3C2410)	+= i2c-s3c2410.o
>  obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
> +obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
>  obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
>  obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
>  obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
> diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
> new file mode 100644
> index 0000000..cd2b183
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sh7760.c
> @@ -0,0 +1,627 @@
> +/*
> + * I2C bus driver for the SH7760 I2C Interfaces.
> + *
> + * (c) 2005-2007 MSC Vertriebsges.m.b.H.
> + *	<mlau-XXGV8rIhxyHQT0dZR+AlfA@public.gmane.org>., <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
> + *
> + * licensed under the terms outlined in the file COPYING.
> + *
> + */
> +
> +/* NOTE: SMBus QUICK Probe feature is "emulated" by reading 1 byte from
> + *	 the slave address, because the SH7760 I2C cannot be programmed
> + *	 to send a stop immediately after receiving the slave ACK/NACK.
> + *	 If this behavior is not wanted, set platform_data.noquick to 1.
> + */

This is not acceptable. This will have to be removed from the driver if
you want me to take it upstream. The SMBus quick command should no
longer be needed anyway with the advent of new-style i2c chip drivers.

> +
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>

Not sure what you need this one for?

OTOH you need <linux/init.h> for module_init and module_exit, and
<linux/ioport.h> for struct resource.

> +
> +#include <asm/clock.h>
> +#include <asm/i2c-sh7760.h>
> +#include <asm/io.h>
> +
> +/* register offsets */
> +#define I2CSCR		0x0		/* slave ctrl */
> +#define I2CMCR		0x4		/* master ctrl */
> +#define I2CSSR		0x8		/* slave status */
> +#define I2CMSR		0xC		/* master status */
> +#define I2CSIER		0x10		/* slave irq enable */
> +#define I2CMIER		0x14		/* master irq enable */
> +#define I2CCCR		0x18		/* clock dividers */
> +#define I2CSAR		0x1c		/* slave address */
> +#define I2CMAR		0x20		/* master address */
> +#define I2CRXTX		0x24		/* data port */
> +#define I2CFCR		0x28		/* fifo control */
> +#define I2CFSR		0x2C		/* fifo status */
> +#define I2CFIER		0x30		/* fifo irq enable */
> +#define I2CRFDR		0x34		/* rx fifo count */
> +#define I2CTFDR		0x38		/* tx fifo count */
> +
> +#define REGSIZE		0x3C
> +
> +#define MCR_MDBS	0x80
> +#define MCR_FSCL	0x40		/* override SCL pin */
> +#define MCR_FSDA	0x20		/* override SDA pin */
> +#define MCR_OBPC	0x10		/* override pins */
> +#define MCR_MIE		0x08		/* master if enable */
> +#define MCR_TSBE	0x04
> +#define MCR_FSB		0x02		/* force stop bit */
> +#define MCR_ESG		0x01		/* enable start generation */
> +
> +#define MSR_MNR		0x40		/* nack received */
> +#define MSR_MAL		0x20		/* arbitration lost */
> +#define MSR_MST		0x10		/* sent a stop */
> +#define MSR_MDE		0x08
> +#define MSR_MDT		0x04
> +#define MSR_MDR		0x02
> +#define MSR_MAT		0x01		/* sent out slave addr */
> +
> +#define MIE_MNRE	0x40		/* nack irq en */
> +#define MIE_MALE	0x20		/* arblos irq en */
> +#define MIE_MSTE	0x10		/* stop irq en */
> +#define MIE_MDEE	0x08
> +#define MIE_MDTE	0x04
> +#define MIE_MDRE	0x02
> +#define MIE_MATE	0x01		/* address sent irq en */
> +
> +#define FCR_RFRST	0x02		/* reset rx fifo */
> +#define FCR_TFRST	0x01		/* reset tx fifo */
> +
> +#define FSR_TEND	0x04
> +#define FSR_RDF		0x02		/* rx fifo trigger */
> +#define FSR_TDFE	0x01
> +
> +#define FIER_TEIE	0x04		/* tx fifo empty irq en */
> +#define FIER_RXIE	0x02		/* rx fifo trig irq en */
> +#define FIER_TXIE	0x01		/* tx fifo trig irq en */
> +
> +#define FIFO_SIZE	16
> +
> +struct cami2c {
> +	void __iomem *iobase;	/* channel base address */
> +	struct i2c_adapter adap;
> +
> +	/* message processing */
> +	struct i2c_msg	*msg;
> +#define IDF_SEND	1
> +#define IDF_RECV	2
> +#define IDF_STOP	4
> +	int		flags;
> +
> +#define IDS_DONE	1
> +#define IDS_ARBLOST	2
> +#define IDS_NACK	4
> +	int		status;
> +	struct completion xfer_done;
> +
> +	u32 func;		/* supported functions */
> +	int irq;		/* IRQ vector */
> +	struct resource *ioarea;
> +};
> +
> +static inline void OUT32(struct cami2c *cam, int reg, unsigned long val)
> +{
> +	ctrl_outl(val, (unsigned long)cam->iobase + reg);
> +}
> +
> +static inline unsigned long IN32(struct cami2c *cam, int reg)
> +{
> +	return ctrl_inl((unsigned long)cam->iobase + reg);
> +}
> +
> +static irqreturn_t sh7760_i2c_irq(int irq, void *ptr)
> +{
> +	struct cami2c *id = ptr;
> +	struct i2c_msg *msg;
> +	unsigned long msr, fsr, fier, len;
> +	char *data;
> +
> +	msg = id->msg;
> +	data = msg->buf;
> +
> +	msr = IN32(id, I2CMSR);
> +	fsr = IN32(id, I2CFSR);
> +
> +	/* arbitration lost */
> +	if (msr & MSR_MAL) {
> +		OUT32(id, I2CMCR, 0);
> +		OUT32(id, I2CSCR, 0);
> +		OUT32(id, I2CSAR, 0);
> +		id->status |= IDS_DONE | IDS_ARBLOST;
> +		goto out;
> +	}
> +
> +	if (msr & MSR_MNR) {
> +		/* NACK handling is very screwed up.  After receiving a
> +		 * NAK IRQ one has to wait a bit  before writing to any
> +		 * registers, or the ctl will lock up. After that delay
> +		 * do a normal i2c stop. Then wait at least 1 ms before
> +		 * attempting another xfer or risk another ctl hang.
> +		 */
> +		udelay(100);	/* wait or risk ctl hang */
> +		OUT32(id, I2CFCR, FCR_RFRST | FCR_TFRST);
> +		OUT32(id, I2CMCR, MCR_MIE | MCR_FSB);
> +		OUT32(id, I2CFIER, 0);
> +		OUT32(id, I2CMIER, MIE_MSTE);
> +		OUT32(id, I2CSCR, 0);
> +		OUT32(id, I2CSAR, 0);
> +		id->status |= IDS_NACK;
> +		msr &= ~MSR_MAT;
> +		fsr = 0;
> +		/* In some cases the MST bit is also set; so don't go
> +		 * to the end of the handler
> +		 */
> +	}
> +
> +	/* i2c-stop was sent */
> +	if (msr & MSR_MST) {
> +		id->status |= IDS_DONE;
> +		goto out;
> +	}
> +
> +	/* i2c slave addr was sent; set to "normal" operation */
> +	if (msr & MSR_MAT)
> +		OUT32(id, I2CMCR, MCR_MIE);
> +
> +	fier = IN32(id, I2CFIER);
> +
> +	if (fsr & FSR_RDF) {
> +		/* data in rx fifo */
> +		len = IN32(id, I2CRFDR);
> +		if (msg->len <= len) {
> +			/* all data received, stop if required */
> +			if (id->flags & IDF_STOP) {
> +				OUT32(id, I2CMCR, MCR_MIE | MCR_FSB);
> +				OUT32(id, I2CFIER, 0);
> +				/* manual says: wait >= 0.5 SCL times */
> +				udelay(5);
> +				/* next int should be MST */
> +			} else {
> +				id->status |= IDS_DONE;
> +				/* keep the RDF bit: ctrl holds SCL low
> +				 * until the setup for the next i2c_msg
> +				 * clears this bit and ctl resumes work.
> +				 */
> +				fsr &= ~FSR_RDF;
> +			}
> +		}
> +		/* read fifo */
> +		while (msg->len && len) {
> +			*data++ = IN32(id, I2CRXTX);
> +			msg->len--;
> +			len--;
> +		}
> +
> +		if (msg->len) {
> +			/* (re)adjust rx-fifo trigger */
> +			len = (msg->len >= FIFO_SIZE) ? FIFO_SIZE - 1
> +						      : msg->len - 1;
> +
> +			OUT32(id, I2CFCR, FCR_TFRST | ((len & 0xf) << 4));
> +		}
> +
> +	} else if (id->flags & IDF_SEND) {
> +		if ((fsr & FSR_TEND) && (msg->len < 1)) {
> +			/* transfer has ended, and no more data to send */
> +			if (id->flags & IDF_STOP) {
> +				OUT32(id, I2CMCR, MCR_MIE | MCR_FSB);
> +			} else {
> +				id->status |= IDS_DONE;
> +				/* keep the TEND bit: ctl holds SCL low
> +				 * until the setup for the next i2c_msg
> +				 * clears this bit and ctl resumes work.
> +				 */
> +				fsr &= ~FSR_TEND;
> +			}
> +		}
> +		if (fsr & FSR_TDFE) {
> +			/* free space in tx fifo */
> +			while (msg->len && (IN32(id, I2CTFDR) < FIFO_SIZE)) {
> +				OUT32(id, I2CRXTX, *data++);
> +				msg->len--;
> +			}
> +
> +			if (msg->len < 1) {
> +				fier &= ~FIER_TXIE;
> +				OUT32(id, I2CFIER, fier);
> +			} else {
> +				/* adjust tx-fifo trigger */
> +				len = (msg->len >= FIFO_SIZE) ? 2 : 0;
> +				OUT32(id, I2CFCR,
> +					  FCR_RFRST | ((len & 3) << 2));
> +			}
> +		}
> +	}
> +out:
> +	if (id->status & IDS_DONE) {
> +		OUT32(id, I2CMIER, 0);
> +		OUT32(id, I2CFIER, 0);
> +		id->msg = NULL;
> +		complete(&id->xfer_done);
> +	}
> +	/* clear status flags and ctrl resumes work */
> +	OUT32(id, I2CMSR, ~msr);
> +	OUT32(id, I2CFSR, ~fsr);
> +	OUT32(id, I2CSSR, 0);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +
> +/* prepare and start a master receive operation */
> +static void sh7760_i2c_mrecv(struct cami2c *id)
> +{
> +	int len;
> +
> +	/* set the slave addr reg; otherwise rcv wont work! */
> +	OUT32(id, I2CSAR, 0xfe);
> +	OUT32(id, I2CMAR, (id->msg->addr << 1) | 1);
> +
> +	/* adjust rx fifo trigger */
> +	if (id->msg->len >= FIFO_SIZE)
> +		len = FIFO_SIZE - 1;	/* trigger at fifo full */
> +	else
> +		len = id->msg->len - 1;	/* trigger before all received */
> +
> +	OUT32(id, I2CFCR, FCR_RFRST | FCR_TFRST);
> +	OUT32(id, I2CFCR, FCR_TFRST | ((len & 0xF) << 4));
> +
> +	id->flags |= IDF_RECV;
> +
> +	OUT32(id, I2CMSR, 0);
> +	if (id->msg->flags & I2C_M_NOSTART)

Do you actually need this? Is there any chip that is connected to this
bus in practice which needs this flag? Implementing this feature is
totally optional and should only be done when really needed (this is a
violation of the I2C standard.)

> +		OUT32(id, I2CMCR, MCR_MIE);
> +	else
> +		OUT32(id, I2CMCR, MCR_MIE | MCR_ESG);
> +
> +	OUT32(id, I2CMIER, MIE_MNRE | MIE_MALE | MIE_MSTE | MIE_MATE);
> +	OUT32(id, I2CFIER, FIER_RXIE);
> +}
> +
> +/* prepare and start a master send operation */
> +static void sh7760_i2c_msend(struct cami2c *id)
> +{
> +	int len;
> +
> +	/* set the slave addr reg; otherwise xmit wont work! */
> +	OUT32(id, I2CSAR, 0xfe);
> +	OUT32(id, I2CMAR, (id->msg->addr << 1) | 0);
> +
> +	/* adjust tx fifo trigger */
> +	if (id->msg->len >= FIFO_SIZE)
> +		len = 2;	/* trig: 2 bytes left in TX fifo */
> +	else
> +		len = 0;	/* trig: 8 bytes left in TX fifo */
> +
> +	OUT32(id, I2CFCR, FCR_RFRST | FCR_TFRST);
> +	OUT32(id, I2CFCR, FCR_RFRST | ((len & 3) << 2));
> +
> +	while (id->msg->len && IN32(id, I2CTFDR) < FIFO_SIZE) {
> +		OUT32(id, I2CRXTX, *(id->msg->buf));
> +		(id->msg->len)--;
> +		(id->msg->buf)++;
> +	}
> +
> +	id->flags |= IDF_SEND;
> +
> +	OUT32(id, I2CMSR, 0);
> +	if (id->msg->flags & I2C_M_NOSTART)

Ditto.

> +		OUT32(id, I2CMCR, MCR_MIE);
> +	else
> +		OUT32(id, I2CMCR, MCR_MIE | MCR_ESG);
> +
> +	OUT32(id, I2CFSR, 0);
> +
> +	OUT32(id, I2CMIER, MIE_MNRE | MIE_MALE | MIE_MSTE | MIE_MATE);
> +	OUT32(id, I2CFIER, FIER_TEIE | (id->msg->len ? FIER_TXIE : 0));
> +}
> +
> +static inline int sh7760_i2c_busy_check(struct cami2c *id)
> +{
> +	return (IN32(id, I2CMCR) & MCR_FSDA);
> +}
> +
> +static int sh7760_i2c_master_xfer(struct i2c_adapter *adap,
> +				  struct i2c_msg *msgs,
> +				  int num)
> +{
> +	struct cami2c *id = adap->algo_data;
> +	struct i2c_msg *msg = msgs, qmsg;
> +	int i, addr, retr;
> +	unsigned char buf;	/* dummy for qmsg */
> +
> +	if (sh7760_i2c_busy_check(id)) {
> +		pr_debug("sh7760-i2c%d: bus is busy!\n", adap->nr);

Please use dev_dbg() instead. Or even better dev_err(), as you return
with an error, the user will want to know.

> +		num = -EBUSY;
> +	}
> +
> +	i = 0;
> +	while ((i < num) && (num > 0)) {

The second half of the test is not needed.

> +		addr = msg->addr << 1;
> +		if (msg->len < 1) {
> +			/* SMBus Quick "emulation":
> +			 * setup a dummy msg to read 1 byte from addr.
> +			 */

As said before: nack.

> +			qmsg.addr = msg->addr;
> +			qmsg.len = 1;
> +			qmsg.flags = msg->flags;
> +			qmsg.buf = &buf;
> +			addr |= 1;
> +			id->msg = &qmsg;
> +		} else {
> +			if (msg->flags & I2C_M_RD)
> +				addr |= 1;
> +			if (msg->flags & I2C_M_REV_DIR_ADDR)
> +				addr ^= 1;

Again, do you actually need this? If not, please don't implement it.

> +			msg->addr = addr >> 1;
> +			id->msg = msg;
> +		}
> +		retr = adap->retries;
> +
> +retry:
> +		id->flags = ((i == (num-1)) ? IDF_STOP : 0);
> +		id->status = 0;
> +		init_completion(&id->xfer_done);
> +
> +		if (addr & 1)

You could test for msg->flags & I2C_M_RD instead, then you wouldn't
need "addr" at all. This would be slightly more efficient than your
current code.

> +			sh7760_i2c_mrecv(id);
> +		else
> +			sh7760_i2c_msend(id);
> +
> +		wait_for_completion(&id->xfer_done);
> +
> +		if (id->status == 0) {
> +			num = -EIO;
> +			break;
> +		}
> +
> +		if (id->status & IDS_NACK) {
> +			/* little delay. Without it, subsequent transfers
> +			 * hang the i2c ctl... */
> +			mdelay(1);
> +			num = -EREMOTEIO;
> +			break;
> +		}
> +
> +		if (id->status & IDS_ARBLOST) {
> +			if (retr--) {
> +				mdelay(2);
> +				goto retry;
> +			}
> +			num = -EREMOTEIO;
> +			break;
> +		}
> +
> +		/* message successfully processed. YAY! */
> +		msg++;
> +		i++;
> +	}
> +
> +	id->msg = NULL;
> +	id->flags = 0;
> +	id->status = 0;
> +
> +	OUT32(id, I2CMCR, 0);
> +	OUT32(id, I2CMSR, 0);
> +	OUT32(id, I2CMIER, 0);
> +	OUT32(id, I2CFIER, 0);
> +
> +	/* important: reset slave regs too: master mode enables slave
> +	 * module for receive ops (ack, data). Without this reset,
> +	 * eternal bus activity might be reported after NACK / ARBLOST.
> +	 */
> +	OUT32(id, I2CSCR, 0);
> +	OUT32(id, I2CSAR, 0);
> +	OUT32(id, I2CSSR, 0);
> +
> +	return num;
> +}
> +
> +static u32 sh7760_i2c_func(struct i2c_adapter *adap)
> +{
> +	struct cami2c *id = adap->algo_data;
> +	return id->func;
> +}
> +
> +static struct i2c_algorithm sh7760_i2c_algo = {

Count be const.

> +	.master_xfer	= sh7760_i2c_master_xfer,
> +	.functionality	= sh7760_i2c_func,
> +};
> +
> +/* calculate CCR register setting for a desired scl clock */
> +static int __devinit calc_CCR(unsigned long scl_hz)
> +{
> +	struct clk *mclk;
> +	unsigned long mck, m1, dff, odff, iclk;
> +	signed char cdf, cdfm = 0;
> +	int scgd, scgdm;
> +
> +	mclk = clk_get(NULL, "module_clk");
> +	if (IS_ERR(mclk)) {
> +		return PTR_ERR(mclk);
> +	} else {
> +		mck = mclk->rate;
> +		clk_put(mclk);
> +	}
> +
> +	/* pclock/CDF = i2c_module clock (iclk)/SCGD = SCL */
> +	odff = scl_hz;
> +	scgdm = cdfm = m1 = 0;

cdfm was already initialized to 0 at the beginning of the function.

> +	for (cdf = 3; cdf >= 0; cdf--) {
> +		iclk = mck / (1 + cdf);
> +		/* iclk must not be > 20MHz */
> +		if (iclk >= 20000000)

> or >=?

> +			continue;
> +		for (scgd = 0; scgd < 63; scgd++) {
> +			m1 = iclk / (20 + (scgd << 3));
> +			dff = abs(scl_hz - m1);
> +			if (dff < odff) {
> +				odff = dff;
> +				cdfm = cdf;
> +				scgdm = scgd;
> +			}
> +		}
> +	}

These imbricated loops don't look exactly optimal. Is there no way to
compute the right value right away?

> +	/* fail if more than 25% off of requested SCL */
> +	if (odff > (scl_hz >> 2))
> +		return -EINVAL;
> +
> +	/* create a CCR register value */
> +	m1 = ((scgdm & 63) << 2) | (cdfm & 3);

cdfm can't be more than 3 anyway, can it? Likewise, scgdm can't be more
than 63 if I read the code properly, thus the masks are not needed.

> +
> +	return m1;
> +}
> +
> +/* register a channel with the i2c core */
> +static int __devinit sh7760_i2c_probe(struct platform_device *pdev)
> +{
> +	struct sh7760_i2c_platdata *pd;
> +	struct resource *res;
> +	struct cami2c *id;
> +	int ret;
> +
> +	pd = pdev->dev.platform_data;
> +	if (!pd) {
> +		ret = -ENODEV;
> +		dev_err(&pdev->dev, "no platform_data!\n");
> +		goto out0;
> +	}
> +
> +	ret = -ENOMEM;
> +	id = kzalloc(sizeof(struct cami2c), GFP_KERNEL);
> +	if (!id) {
> +		dev_err(&pdev->dev, "no mem for private data\n");
> +		goto out0;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no mmio resources\n");

-ENOMEM isn't the right error value for this case. I'd suggest -ENODEV
instead.

> +		goto out1;
> +	}
> +
> +	id->ioarea = request_mem_region(res->start, REGSIZE, pdev->name);
> +	if (!id->ioarea) {
> +		dev_err(&pdev->dev, "mmio already reserved\n");
> +		ret = -EBUSY;
> +		goto out1;
> +	}
> +
> +	id->iobase = ioremap(res->start, REGSIZE);
> +	if (!id->iobase) {
> +		dev_err(&pdev->dev, "cannot ioremap\n");
> +		goto out2;
> +	}
> +
> +	id->irq = platform_get_irq(pdev, 0);
> +	id->func = I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	if (pd->noquick)
> +		id->func &= ~I2C_FUNC_SMBUS_QUICK;
> +
> +	id->adap.nr = pdev->id;
> +	id->adap.algo = &sh7760_i2c_algo;
> +	id->adap.class = I2C_CLASS_ALL;
> +	id->adap.timeout = 100;

You don't actually use this value anywhere?

> +	id->adap.retries = 3;
> +	id->adap.algo_data = id;
> +	id->adap.dev.parent = &pdev->dev;
> +	strcpy(id->adap.name, SH7760_I2C_DEVNAME);

Please use strlcpy instead. Also, this string is supposed to be unique,
so in fact I'd suggest something like:

	snprintf(id->adap.name, sizeof(id->adap.name),
		 "SH7760 I2C at %08lx", (unsigned long)res->start);

> +
> +	OUT32(id, I2CMCR, 0);
> +	OUT32(id, I2CMSR, 0);
> +	OUT32(id, I2CMIER, 0);
> +	OUT32(id, I2CMAR, 0);
> +	OUT32(id, I2CSIER, 0);
> +	OUT32(id, I2CSAR, 0);
> +	OUT32(id, I2CSCR, 0);
> +	OUT32(id, I2CSSR, 0);
> +	OUT32(id, I2CFIER, 0);
> +	OUT32(id, I2CFCR, FCR_RFRST | FCR_TFRST);
> +	OUT32(id, I2CFSR, 0);
> +
> +	ret = calc_CCR(pd->speed_khz * 1000);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "invalid SCL clock\n");
> +		goto out3;
> +	}
> +	OUT32(id, I2CCCR, ret);
> +
> +	if (request_irq(id->irq, sh7760_i2c_irq, IRQF_DISABLED,
> +			SH7760_I2C_DEVNAME, id)) {
> +		dev_err(&pdev->dev, "cannot get irq %d\n", id->irq);
> +		ret = -EBUSY;
> +		goto out3;
> +	}
> +
> +	ret = i2c_add_numbered_adapter(&id->adap);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "reg adap failed: %d\n", ret);
> +		goto out4;
> +	}
> +
> +	platform_set_drvdata(pdev, id);
> +
> +	printk(KERN_INFO "SH7760 I2C-%d, %d kHz, mmio %08x, irq %d\n",
> +		id->adap.nr, pd->speed_khz, res->start, id->irq);

Use dev_info (and you will no longer need to print id->adap.nr).

> +
> +	return 0;
> +
> +out4:
> +	free_irq(id->irq, id);
> +out3:
> +	iounmap(id->iobase);
> +out2:
> +	release_resource(id->ioarea);
> +	kfree(id->ioarea);
> +out1:
> +	kfree(id);
> +out0:
> +	return ret;
> +}
> +
> +static int __devexit sh7760_i2c_remove(struct platform_device *pdev)
> +{
> +	struct cami2c *id = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&id->adap);
> +	free_irq(id->irq, id);
> +	iounmap(id->iobase);
> +	release_resource(id->ioarea);
> +	kfree(id->ioarea);
> +	kfree(id);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sh7760_i2c_drv = {
> +	.driver	= {
> +		.name	= SH7760_I2C_DEVNAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= sh7760_i2c_probe,
> +	.remove		= __devexit_p(sh7760_i2c_remove),
> +};
> +
> +static int __init sh7760_i2c_init(void)
> +{
> +	return platform_driver_register(&sh7760_i2c_drv);
> +}
> +
> +static void __exit sh7760_i2c_exit(void)
> +{
> +	platform_driver_unregister(&sh7760_i2c_drv);
> +}
> +
> +module_init(sh7760_i2c_init);
> +module_exit(sh7760_i2c_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("SH7760 I2C bus driver");
> +MODULE_AUTHOR("Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>");
> diff --git a/include/asm-sh/i2c-sh7760.h b/include/asm-sh/i2c-sh7760.h
> new file mode 100644
> index 0000000..d2a86bd
> --- /dev/null
> +++ b/include/asm-sh/i2c-sh7760.h
> @@ -0,0 +1,23 @@
> +/*
> + * MMIO/IRQ and platform data for SH7760 I2C channels
> + */
> +
> +#ifndef _I2C_SH7760_H_
> +#define _I2C_SH7760_H_
> +
> +#define SH7760_I2C_DEVNAME	"i2c-sh7760"
> +
> +#define SH7760_I2C0_MMIO	0xFE140000
> +#define SH7760_I2C0_MMIOEND	0xFE14003B
> +#define SH7760_I2C0_IRQ		62
> +
> +#define SH7760_I2C1_MMIO	0xFE150000
> +#define SH7760_I2C1_MMIOEND	0xFE15003B
> +#define SH7760_I2C1_IRQ		63
> +
> +struct sh7760_i2c_platdata {
> +	unsigned int speed_khz;
> +	unsigned int noquick;
> +};
> +
> +#endif

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
