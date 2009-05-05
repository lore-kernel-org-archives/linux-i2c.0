From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] ST DDC I2C bus driver v1
Date: Tue, 5 May 2009 14:40:02 +0100
Message-ID: <20090505134002.GO32548@trinity.fluff.org>
References: <63386a3d0905050452v5ade99cav7265c38d74699a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63386a3d0905050452v5ade99cav7265c38d74699a8c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, May 05, 2009 at 01:52:22PM +0200, Linus Walleij wrote:
> This adds support for the ST Microelectronic DDC I2C bus
> driver. This bus is used in the U300 architecture recently
> added to RMK:s ARM tree. (Patch based on 2.6.30-rc4.)
> 
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig        |   11 +
>  drivers/i2c/busses/Makefile       |    1 +
>  drivers/i2c/busses/i2c-stddci2c.c |  973 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 985 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-stddci2c.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a48c8ae..42ae0ba 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -513,6 +513,17 @@ config I2C_SIMTEC
>  	  This driver can also be built as a module. If so, the module
>  	  will be called i2c-simtec.
> 
> +config I2C_STDDCI2C
> +	tristate "ST Microelectronics DDC I2C interface"
> +	default y if MACH_U300
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C interface from ST Microelectronics simply called "DDC I2C"
> +	  supporting both I2C and DDC.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called i2c-stddci2c.
> +
>  config I2C_VERSATILE
>  	tristate "ARM Versatile/Realview I2C bus support"
>  	depends on ARCH_VERSATILE || ARCH_REALVIEW
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 776acb6..677a0b0 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_I2C_S6000)		+= i2c-s6000.o
>  obj-$(CONFIG_I2C_SH7760)	+= i2c-sh7760.o
>  obj-$(CONFIG_I2C_SH_MOBILE)	+= i2c-sh_mobile.o
>  obj-$(CONFIG_I2C_SIMTEC)	+= i2c-simtec.o
> +obj-$(CONFIG_I2C_STDDCI2C)	+= i2c-stddci2c.o
>  obj-$(CONFIG_I2C_VERSATILE)	+= i2c-versatile.o
> 
>  # External I2C/SMBus adapter drivers
> diff --git a/drivers/i2c/busses/i2c-stddci2c.c
> b/drivers/i2c/busses/i2c-stddci2c.c
> new file mode 100644
> index 0000000..4057c3d
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-stddci2c.c
> @@ -0,0 +1,973 @@
> +/*
> + *
> + * drivers/i2c/busses/i2c-stddci2c.c

Is it really just for DDC? is there another i2c block in the chip?
if not, can we just call this sti2c or similar?

> + *
> + *
> + * Copyright (C) 2007-2009 ST-Ericsson AB
> + * License terms: GNU General Public License (GPL) version 2
> + * ST DDC I2C master mode driver.
> + * Author: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
> + * Author: Jonas Aaberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> + */
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/spinlock.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/kernel.h>
> +#include <linux/stddef.h>

do you really need this?

> +#include <linux/init.h>
> +#include <asm/atomic.h>

is there a better way of including <asm/atomic.h> ?

> +#define NAME "stddci2c"
> +
> +/* CR (Control Register) 8bit (R/W) */
> +#define I2C_CR					(0x00000000)
> +#define I2C_CR_RESET_VALUE			(0x00)
> +#define I2C_CR_RESET_UMASK			(0x00)
> +#define I2C_CR_DDC1_ENABLE			(0x80)
> +#define I2C_CR_TRANS_ENABLE			(0x40)
> +#define I2C_CR_PERIPHERAL_ENABLE		(0x20)
> +#define I2C_CR_DDC2B_ENABLE			(0x10)
> +#define I2C_CR_START_ENABLE			(0x08)
> +#define I2C_CR_ACK_ENABLE			(0x04)
> +#define I2C_CR_STOP_ENABLE			(0x02)
> +#define I2C_CR_INTERRUPT_ENABLE			(0x01)
> +/* SR1 (Status Register 1) 8bit (R/-) */
> +#define I2C_SR1					(0x00000004)
> +#define I2C_SR1_RESET_VALUE			(0x00)
> +#define I2C_SR1_RESET_UMASK			(0x00)
> +#define I2C_SR1_EVF_IND				(0x80)
> +#define I2C_SR1_ADD10_IND			(0x40)
> +#define I2C_SR1_TRA_IND				(0x20)
> +#define I2C_SR1_BUSY_IND			(0x10)
> +#define I2C_SR1_BTF_IND				(0x08)
> +#define I2C_SR1_ADSL_IND			(0x04)
> +#define I2C_SR1_MSL_IND				(0x02)
> +#define I2C_SR1_SB_IND				(0x01)
> +/* SR2 (Status Register 2) 8bit (R/-) */
> +#define I2C_SR2					(0x00000008)
> +#define I2C_SR2_RESET_VALUE			(0x00)
> +#define I2C_SR2_RESET_UMASK			(0x40)
> +#define I2C_SR2_MASK				(0xBF)
> +#define I2C_SR2_SCLFAL_IND			(0x80)
> +#define I2C_SR2_ENDAD_IND			(0x20)
> +#define I2C_SR2_AF_IND				(0x10)
> +#define I2C_SR2_STOPF_IND			(0x08)
> +#define I2C_SR2_ARLO_IND			(0x04)
> +#define I2C_SR2_BERR_IND			(0x02)
> +#define I2C_SR2_DDC2BF_IND			(0x01)
> +/* CCR (Clock Control Register) 8bit (R/W) */
> +#define I2C_CCR					(0x0000000C)
> +#define I2C_CCR_RESET_VALUE			(0x00)
> +#define I2C_CCR_RESET_UMASK			(0x00)
> +#define I2C_CCR_MASK				(0xFF)
> +#define I2C_CCR_FMSM				(0x80)
> +#define I2C_CCR_CC_MASK				(0x7F)
> +/* OAR1 (Own Address Register 1) 8bit (R/W) */
> +#define I2C_OAR1				(0x00000010)
> +#define I2C_OAR1_RESET_VALUE			(0x00)
> +#define I2C_OAR1_RESET_UMASK			(0x00)
> +#define I2C_OAR1_ADD_MASK			(0xFF)
> +/* OAR2 (Own Address Register 2) 8bit (R/W) */
> +#define I2C_OAR2				(0x00000014)
> +#define I2C_OAR2_RESET_VALUE			(0x40)
> +#define I2C_OAR2_RESET_UMASK			(0x19)
> +#define I2C_OAR2_MASK				(0xE6)
> +#define I2C_OAR2_FR_25_10MHZ			(0x00)
> +#define I2C_OAR2_FR_10_1667MHZ			(0x20)
> +#define I2C_OAR2_FR_1667_2667MHZ		(0x40)
> +#define I2C_OAR2_FR_2667_40MHZ			(0x60)
> +#define I2C_OAR2_FR_40_5333MHZ			(0x80)
> +#define I2C_OAR2_FR_5333_66MHZ			(0xA0)
> +#define I2C_OAR2_FR_66_80MHZ			(0xC0)
> +#define I2C_OAR2_FR_80_100MHZ			(0xE0)
> +#define I2C_OAR2_FR_MASK			(0xE0)
> +#define I2C_OAR2_ADD_MASK			(0x06)
> +/* DR (Data Register) 8bit (R/W) */
> +#define I2C_DR					(0x00000018)
> +#define I2C_DR_RESET_VALUE			(0x00)
> +#define I2C_DR_RESET_UMASK			(0xFF)
> +#define I2C_DR_D_MASK				(0xFF)
> +/* ECCR (Extended Clock Control Register) 8bit (R/W) */
> +#define I2C_ECCR				(0x0000001C)
> +#define I2C_ECCR_RESET_VALUE			(0x00)
> +#define I2C_ECCR_RESET_UMASK			(0xE0)
> +#define I2C_ECCR_MASK				(0x1F)
> +#define I2C_ECCR_CC_MASK			(0x1F)
> +
> +enum stddci2c_event {
> +	STDDCI2C_EVENT_NONE = 0,
> +	STDDCI2C_EVENT_1,
> +	STDDCI2C_EVENT_2,
> +	STDDCI2C_EVENT_3,
> +	STDDCI2C_EVENT_4,
> +	STDDCI2C_EVENT_5,
> +	STDDCI2C_EVENT_6,
> +	STDDCI2C_EVENT_7,
> +	STDDCI2C_EVENT_8,
> +	STDDCI2C_EVENT_9
> +};
> +
> +enum stddci2c_error {
> +	STDDCI2C_ERROR_NONE = 0,
> +	STDDCI2C_ERROR_ACKNOWLEDGE_FAILURE,
> +	STDDCI2C_ERROR_BUS_ERROR,
> +	STDDCI2C_ERROR_ARBITRATION_LOST
> +};
> +
> +/* timeout waiting for the controller to respond */
> +#define STDDCI2C_TIMEOUT (msecs_to_jiffies(1000))
> +
> +/*
> + * The number of address send athemps tried before giving up.
> + * If the first one failes it seems like 5 to 8 attempts are required.
> + */
> +#define NUM_ADDR_RESEND_ATTEMPTS 10
> +
> +/* I2C clock speed, in Hz 0-400kHz*/
> +static unsigned int scl_frequency = 100000;
> +module_param(scl_frequency, uint,  0644);
> +
> +/*
> + * The block needs writes in both MSW and LSW in order
> + * for all data lines to reach their destination.
> + */
> +#define STDDCI2C_WRITE_DATA_8_BIT(Value, Address) \
> +     writel((Value << 16) | Value, Address)

Hmm, eww.

This would be better as a inline function, and finding a shorter
name for it would also be good.

> +/*
> + * This merely masks off the duplicates which appear
> + * in bytes 1-3.
> + */
> +#define STDDCI2C_READ_DATA_8_BIT(Address) \
> +     (readl(Address) & 0x000000FFU)

does this unit not respond to readb? it would save you having
to mask the result.

the name is also rather long.

> +struct stddci2c_dev {
> +	struct platform_device	*pdev;
> +	u32			phybase;
> +	u32			physize;
> +	void __iomem		*virtbase;
> +	struct clk		*clk;
> +	int			irq;
> +	struct i2c_adapter	adapter;
> +	spinlock_t		cmd_issue_lock;
> +	struct completion	cmd_complete;
> +	enum stddci2c_event	cmd_event;
> +	enum stddci2c_error	cmd_err;
> +	unsigned int		speed;
> +	int			msg_index;
> +	int			msg_len;
> +};

some documentation of what each of this is for would be appreciated.

> +/* Local forward function declarations */
> +static int stddci2c_init_hw(struct stddci2c_dev *dev);
> +
> +/* Tells whether a certain event or events occurred or not */
> +static int stddci2c_event_occurred(struct stddci2c_dev *dev,
> +				   enum stddci2c_event mr_event) {
> +	u8 status1;
> +	u8 status2;

Changing these to u32 would stop the following casts, and probably
make the code better (gcc tends to treat (u8) as an AND with 0xff).

> +	/* What event happened? */
> +	status1 = (u8) STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR1);
> +	if (!(status1 & I2C_SR1_EVF_IND))
> +		/* No event at all */
> +		return 0;
> +	status2 = (u8) STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR2);
> +
> +	switch (mr_event) {
> +	case STDDCI2C_EVENT_1:
> +		if (status1 & I2C_SR1_ADSL_IND)
> +			return 1;
> +		break;
> +	case STDDCI2C_EVENT_2:
> +	case STDDCI2C_EVENT_3:
> +	case STDDCI2C_EVENT_7:
> +	case STDDCI2C_EVENT_8:
> +		if (status1 & I2C_SR1_BTF_IND) {
> +			if (status2 & I2C_SR2_AF_IND)
> +				dev->cmd_err = STDDCI2C_ERROR_ACKNOWLEDGE_FAILURE;
> +			else if (status2 & I2C_SR2_BERR_IND)
> +				dev->cmd_err = STDDCI2C_ERROR_BUS_ERROR;
> +			return 1;
> +		}
> +		break;
> +	case STDDCI2C_EVENT_4:
> +		if (status2 & I2C_SR2_STOPF_IND)
> +			return 1;
> +		break;
> +	case STDDCI2C_EVENT_5:
> +		if (status1 & I2C_SR1_SB_IND)
> +			/* Clear start bit */
> +			return 1;
> +		break;
> +	case STDDCI2C_EVENT_6:
> +		if (status2 & I2C_SR2_ENDAD_IND) {
> +			/* First check for any errors */
> +			if (status2 & I2C_SR2_AF_IND)
> +				dev->cmd_err = STDDCI2C_ERROR_ACKNOWLEDGE_FAILURE;
> +			return 1;
> +		}
> +		break;
> +	case STDDCI2C_EVENT_9:
> +		if (status1 & I2C_SR1_ADD10_IND)
> +			return 1;
> +		break;
> +	default:
> +		break;
> +	}
> +	if (status2 & I2C_SR2_ARLO_IND)
> +		dev->cmd_err = STDDCI2C_ERROR_ARBITRATION_LOST;
> +	return 0;
> +}

again documentation on the function would be useful.

> +static irqreturn_t stddci2c_irh(int irq, void *data)
> +{
> +	struct stddci2c_dev *dev = data;
> +	int res;
> +
> +	/* See if this was what we were waiting for */
> +	spin_lock(&dev->cmd_issue_lock);
> +	if (dev->cmd_event != STDDCI2C_EVENT_NONE) {
> +		res = stddci2c_event_occurred(dev, dev->cmd_event);
> +		if (res || dev->cmd_err != STDDCI2C_ERROR_NONE) {
> +			u32 val;
> +
> +			complete(&dev->cmd_complete);
> +			/* Block any multiple interrupts */
> +			val = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_CR);
> +			val &= ~I2C_CR_INTERRUPT_ENABLE;
> +			STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +		}
> +	}
> +	spin_unlock(&dev->cmd_issue_lock);
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Sends a command and then waits for the bits masked by *flagmask*
> + * to go high or low by IRQ awaiting.
> + */
> +static int stddci2c_start_and_await_event(struct stddci2c_dev *dev,
> +					  u8 cr_value,
> +					  enum stddci2c_event mr_event)
> +{
> +	int ret;
> +
> +	if (unlikely(irqs_disabled())) {
> +		/* TODO: implement polling for this case if need be. */
> +		dev_err(&dev->pdev->dev, "irqs are disabled on this "
> +			"system!\n");
> +		return -EIO;
> +	}
> +	spin_lock_irq(&dev->cmd_issue_lock);
> +	init_completion(&dev->cmd_complete);
> +	dev->cmd_err = STDDCI2C_ERROR_NONE;
> +	dev->cmd_event = mr_event;
> +	spin_unlock_irq(&dev->cmd_issue_lock);
> +	/* Turn on interrupt, send command and wait. */
> +	cr_value |= I2C_CR_INTERRUPT_ENABLE;
> +	STDDCI2C_WRITE_DATA_8_BIT(cr_value, dev->virtbase + I2C_CR);
> +	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> +							STDDCI2C_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&dev->pdev->dev,
> +		       "wait_for_completion_interruptible_timeout() "
> +		       "returned %d waiting for event %04x\n", ret, mr_event);
> +		return ret;
> +	}
> +	if (ret == 0) {
> +		dev_err(&dev->pdev->dev, "controller timed out "
> +		       "waiting for event %d, reinit hardware\n", mr_event);
> +		(void) stddci2c_init_hw(dev);
> +		return -ETIMEDOUT;
> +	}
> +	if (dev->cmd_err != STDDCI2C_ERROR_NONE) {
> +		dev_err(&dev->pdev->dev, "controller (start) "
> +		       "error %d waiting for event %d, reinit hardware\n",
> +		       dev->cmd_err, mr_event);
> +		(void) stddci2c_init_hw(dev);
> +		return -EIO;
> +	}
> +	return 0;
> +}

the odd blank like would make these long functions far more readable.

> +/*
> + * This waits for a flag to be set, if it is not set on entry, an interrupt is
> + * configured to wait for the flag using a completion.
> + */
> +static int stddci2c_await_event(struct stddci2c_dev *dev,
> +				enum stddci2c_event mr_event)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (unlikely(irqs_disabled())) {
> +		/* TODO: implement polling for this case if need be. */
> +		dev_err(&dev->pdev->dev, "irqs are disabled on this "
> +			"system!\n");
> +		return -EIO;
> +	}
> +	/* Is it already here? */
> +	spin_lock_irq(&dev->cmd_issue_lock);
> +	dev->cmd_err = STDDCI2C_ERROR_NONE;
> +	if (stddci2c_event_occurred(dev, mr_event)) {
> +		spin_unlock_irq(&dev->cmd_issue_lock);
> +		goto exit_await_check_err;
> +	}
> +	init_completion(&dev->cmd_complete);
> +	dev->cmd_err = STDDCI2C_ERROR_NONE;
> +	dev->cmd_event = mr_event;
> +	/* Turn on the I2C interrupt for current operation */
> +	val = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_CR);
> +	val |= I2C_CR_INTERRUPT_ENABLE;
> +	STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +
> +	/* Twice paranoia (possible HW glitch) */
> +	STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +
> +	/* Check again: is it already here? */
> +	if (unlikely(stddci2c_event_occurred(dev, mr_event))) {
> +		/* Disable IRQ again. */
> +		val &= ~I2C_CR_INTERRUPT_ENABLE;
> +		STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +		spin_unlock_irq(&dev->cmd_issue_lock);
> +		goto exit_await_check_err;
> +	}
> +	spin_unlock_irq(&dev->cmd_issue_lock);
> +	ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete,
> +							STDDCI2C_TIMEOUT);
> +	if (ret < 0) {
> +		dev_err(&dev->pdev->dev,
> +		       "wait_for_completion_interruptible_timeout()"
> +		       "returned %d waiting for event %04x\n", ret, mr_event);
> +		return ret;
> +	}
> +	if (ret == 0) {
> +		if (mr_event != STDDCI2C_EVENT_6) {
> +			dev_err(&dev->pdev->dev, "controller "
> +				"timed out waiting for event %d, reinit "
> +				"hardware\n", mr_event);
> +			(void) stddci2c_init_hw(dev);
> +		}
> +		return -ETIMEDOUT;
> +	}
> + exit_await_check_err:
> +	if (dev->cmd_err != STDDCI2C_ERROR_NONE) {
> +		if (mr_event != STDDCI2C_EVENT_6) {
> +			dev_err(&dev->pdev->dev, "controller "
> +				"error (await_event) %d waiting for event %d, "
> +			       "reinit hardware\n", dev->cmd_err, mr_event);
> +			(void) stddci2c_init_hw(dev);
> +		}
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Waits for the busy bit to go low by repeated polling.
> + */
> +#define BUSY_RELEASE_ATTEMPTS 10
> +static int stddci2c_wait_while_busy(struct stddci2c_dev *dev)
> +{
> +	unsigned long timeout;
> +	int i;
> +
> +	for (i = 0; i < BUSY_RELEASE_ATTEMPTS; i++) {
> +		timeout = jiffies + STDDCI2C_TIMEOUT;
> +
> +		while (!time_after(jiffies, timeout)) {
> +			/* Is not busy? */
> +			if ((STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR1) &
> +			     I2C_SR1_BUSY_IND) == 0)
> +				return 0;
> +			msleep(1);
> +		}
> +		dev_err(&dev->pdev->dev, "transaction timed out "
> +			"waiting for device to be free (not busy). "
> +		       "Attempt: %d\n", i+1);
> +		dev_err(&dev->pdev->dev, "base address = "
> +			"0x%08x, reinit hardware\n", (u32) dev->virtbase);
> +		(void) stddci2c_init_hw(dev);
> +	}
> +	dev_err(&dev->pdev->dev, "giving up after %d attempts "
> +		"to reset the bus.\n",  BUSY_RELEASE_ATTEMPTS);
> +	return -ETIMEDOUT;
> +}
> +
> +static int stddci2c_set_clk(struct stddci2c_dev *dev, unsigned long clkrate)
> +{
> +
> +	u32 val;
> +
> +	if (clkrate < 2500000) {
> +		dev_err(&dev->pdev->dev, "too low clock rate "
> +			"(%lu Hz).\n", clkrate);
> +		return -EINVAL;
> +	} else if (clkrate >= 2500000 && clkrate < 10000000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_25_10MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 10000000 && clkrate < 16670000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_10_1667MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 16670000 && clkrate < 26670000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_1667_2667MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 26670000 && clkrate < 40000000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_2667_40MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 40000000 && clkrate < 53330000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_40_5333MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 53330000 && clkrate < 66000000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_5333_66MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 66000000 && clkrate < 80000000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_66_80MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else if (clkrate >= 80000000 && clkrate < 100000000) {
> +		STDDCI2C_WRITE_DATA_8_BIT(I2C_OAR2_FR_80_100MHZ,
> +					  dev->virtbase + I2C_OAR2);
> +	} else {
> +		dev_err(&dev->pdev->dev, "too high clock rate (%lu Hz).\n",
> +			clkrate);
> +		return -EINVAL;
> +	}

that lot is worthy of a table to search.

> +	pr_debug(NAME ": Clock rate %lu Hz, I2C bus speed %d Hz virtbase %p\n",
> +		 clkrate, dev->speed, dev->virtbase);
> +
> +	if (dev->speed > 100000)
> +		/* Fast Mode I2C */
> +		val = ((clkrate/dev->speed)-9)/3;
> +	else
> +		/* Standard Mode I2C */
> +		val = ((clkrate/dev->speed)-7)/2;
> +
> +	/* According to spec the divider must be > 2 */
> +	if (val < 0x002) {
> +		dev_err(&dev->pdev->dev, "too low clock rate (%lu Hz).\n",
> +		       clkrate);
> +		return -EINVAL;
> +	}
> +
> +	/* We have 12 bits clock divider only! */
> +	if (val & 0xFFFFF000U) {
> +		dev_err(&dev->pdev->dev, "too high clock rate (%lu Hz).\n",
> +		       clkrate);
> +		return -EINVAL;
> +	}
> +
> +	if (dev->speed > 100000) {
> +		/* CC6..CC0 */
> +		STDDCI2C_WRITE_DATA_8_BIT((val & I2C_CCR_CC_MASK) | I2C_CCR_FMSM,
> +					  dev->virtbase + I2C_CCR);
> +		pr_debug(NAME ": set clock divider to 0x%08x, "
> +			 "Fast Mode I2C\n", val);
> +	} else {
> +		/* CC6..CC0 */
> +		STDDCI2C_WRITE_DATA_8_BIT((val & I2C_CCR_CC_MASK),
> +					  dev->virtbase + I2C_CCR);
> +		pr_debug(NAME ": set clock divider to "
> +		       "0x%08x, Standard Mode I2C\n", val);
> +	}
> +
> +	/* CC11..CC7 */
> +	STDDCI2C_WRITE_DATA_8_BIT(((val >> 7) & 0x1F),
> +				  dev->virtbase + I2C_ECCR);
> +
> +	return 0;
> +}
> +
> +
> +static int stddci2c_init_hw(struct stddci2c_dev *dev)
> +{
> +	u32 dummy;
> +	unsigned long clkrate;
> +	int ret;
> +
> +	/* Disable controller */
> +	STDDCI2C_WRITE_DATA_8_BIT(0x00, dev->virtbase + I2C_CR);
> +	/*
> +	 * Set own address to some default value (0x00).
> +	 * We do not support slave mode anyway.
> +	 */
> +	STDDCI2C_WRITE_DATA_8_BIT(0x00, dev->virtbase + I2C_OAR1);
> +	/*
> +	 * The I2C controller only operates properly in 26 MHz but we
> +	 * program this driver as if we didn't know. This will also set the two
> +	 * high bits of the own address to zero as well.
> +	 * There is no known hardware issue with running in 13 MHz
> +	 * However, speeds over 200 kHz are not used.
> +	 */
> +	clkrate = clk_get_rate(dev->clk);
> +	ret = stddci2c_set_clk(dev, clkrate);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Enable block, do it TWICE (hardware glitch)
> +	 * Setting bit 7 can enable DDC mode. (Not used currently.)
> +	 */
> +	STDDCI2C_WRITE_DATA_8_BIT(I2C_CR_PERIPHERAL_ENABLE,
> +				  dev->virtbase + I2C_CR);
> +	STDDCI2C_WRITE_DATA_8_BIT(I2C_CR_PERIPHERAL_ENABLE,
> +				  dev->virtbase + I2C_CR);
> +	/* Make a dummy read of the status register SR1 & SR2 */
> +	dummy = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR2);
> +	dummy = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR1);
> +
> +	return 0;
> +}
> +
> +
> +
> +/* Send slave address. */
> +static int stddci2c_send_address(struct stddci2c_dev *dev,
> +				 struct i2c_msg *msg, int resend)
> +{
> +	u32 val;
> +	int ret;
> +
> +	if (msg->flags & I2C_M_TEN)
> +		/* This is probably how 10 bit addresses look */
> +		val = (0xf0 | (((u32) msg->addr & 0x300) >> 7)) &
> +			I2C_DR_D_MASK;
> +	else
> +		val = ((msg->addr << 1) & I2C_DR_D_MASK);
> +
> +	if (msg->flags & I2C_M_RD) {
> +		/* This is the direction bit */
> +		val |= 0x01;
> +		if (resend)
> +			pr_debug(NAME ": read resend\n");
> +	} else if (resend)
> +		pr_debug(NAME ": write resend\n");
> +	STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_DR);
> +
> +	/* For 10bit addressing, await 10bit request (EVENT 9) */
> +	if (msg->flags & I2C_M_TEN) {
> +		ret = stddci2c_await_event(dev, STDDCI2C_EVENT_9);
> +		/*
> +		 * The slave device wants a 10bit address, send the rest
> +		 * of the bits (the LSBits)
> +		 */
> +		val = msg->addr & I2C_DR_D_MASK;
> +		/* This clears "event 9" */
> +		STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_DR);
> +		if (ret != 0)
> +			return ret;
> +	}
> +	/* FIXME: Why no else here? two events for 10bit?
> +	 * Await event 6 (normal) or event 9 (10bit)
> +	 */
> +
> +	if (resend)
> +		pr_debug(NAME ": await event 6\n");
> +	ret = stddci2c_await_event(dev, STDDCI2C_EVENT_6);
> +
> +	/*
> +	 * Clear any pending EVENT 6 no matter what happend during
> +	 * await_event.
> +	 */
> +	val = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_CR);
> +	val |= I2C_CR_PERIPHERAL_ENABLE;
> +	STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +
> +	return ret;
> +}
> +
> +static int stddci2c_xfer_msg(struct i2c_adapter *adap,
> +			     struct i2c_msg *msg, int stop)
> +{
> +	u32 cr;
> +	u32 val;
> +	u32 i;
> +	int ret;
> +	int attempts = 0;
> +	struct stddci2c_dev *dev = i2c_get_adapdata(adap);
> +
> +
> +	clk_enable(dev->clk);
> +
> +	/* Remove this #if 0 to trace each and every message. */
> +#if 0
> +	pr_debug(NAME ": I2C message to: 0x%04x, len: %d, flags: "
> +		 "0x%04x, stop: %d\n",
> +		 msg->addr, msg->len, msg->flags, stop);
> +#endif

bah, #if 0 considered evil. either if (0) {} or remove please.

> +	if (msg->len == 0) {
> +		ret = -EINVAL;
> +		goto exit_disable;
> +	}

I thought messages with no data should just issue the address to the
bus and check for ack and then issue a stop?

> +	/*
> +	 * For some reason, sending the address sometimes fails when running
> +	 * on  the 13 MHz clock. No interrupt arrives. This is a work around,
> +	 * which tries to restart and send the address up to 10 times before
> +	 * really giving up. Usually 5 to 8 attempts are enough.
> +	 */
> +	do {
> +		if (attempts)
> +			pr_debug(NAME ": wait while busy\n");
> +		/* Check that the bus is free, or wait until some timeout */
> +		ret = stddci2c_wait_while_busy(dev);
> +		if (ret != 0)
> +			goto exit_disable;
> +
> +		if (attempts)
> +			pr_debug(NAME ": re-int hw\n");
> +		/*
> +		 * According to ST, there is no problem if the clock is
> +		 * changed between 13 and 26 MHz during a transfer.
> +		 */
> +		ret = stddci2c_init_hw(dev);
> +		if (ret)
> +			goto exit_disable;
> +
> +		/* Send a start condition */
> +		cr = I2C_CR_PERIPHERAL_ENABLE;
> +		/* Setting the START bit puts the block in master mode */
> +		if (!(msg->flags & I2C_M_NOSTART))
> +			cr |= I2C_CR_START_ENABLE;
> +		if ((msg->flags & I2C_M_RD) && (msg->len > 1))
> +			/* On read more than 1 byte, we need ack. */
> +			cr |= I2C_CR_ACK_ENABLE;
> +		/* Check that it gets through */
> +		if (!(msg->flags & I2C_M_NOSTART)) {
> +			if (attempts)
> +				pr_debug(NAME ": send start event\n");
> +			ret = stddci2c_start_and_await_event(dev, cr,
> +							     STDDCI2C_EVENT_5);
> +		}
> +
> +		if (attempts)
> +			pr_debug(NAME ": send address\n");
> +
> +		if (ret == 0)
> +			/* Send address */
> +			ret = stddci2c_send_address(dev, msg, attempts != 0);
> +
> +		if (ret != 0) {
> +			attempts++;
> +			pr_debug(NAME ": failed sending address, retrying. "
> +			       "Attempt: %d msg_index: %d/%d\n",
> +			       attempts, dev->msg_index, dev->msg_len);
> +		}
> +
> +	} while (ret != 0 && attempts < NUM_ADDR_RESEND_ATTEMPTS);
> +
> +	if (attempts < NUM_ADDR_RESEND_ATTEMPTS && attempts > 0) {
> +		pr_debug(NAME ": managed to get address "
> +		       "through after %d attempts\n", attempts);
> +	} else if (attempts == NUM_ADDR_RESEND_ATTEMPTS) {
> +		pr_debug(NAME ": I give up, tried %d times "
> +		       "to resend address.\n",
> +		       NUM_ADDR_RESEND_ATTEMPTS);
> +		goto exit_disable;
> +	}
> +
> +	if (msg->flags & I2C_M_RD) {
> +		/* READ: we read the actual bytes one at a time */
> +		for (i = 0; i < msg->len; i++) {
> +			if (i == msg->len-1) {
> +				/*
> +				 * Disable ACK and set STOP condition before
> +				 * reading last byte
> +				 */
> +				val = I2C_CR_PERIPHERAL_ENABLE;
> +
> +				if (stop)
> +					val |= I2C_CR_STOP_ENABLE;
> +
> +				STDDCI2C_WRITE_DATA_8_BIT(val,
> +							  dev->virtbase + I2C_CR);
> +			}
> +			/* Wait for this byte... */
> +			ret = stddci2c_await_event(dev, STDDCI2C_EVENT_7);
> +			if (ret != 0)
> +				goto exit_disable;
> +			/* This clears event 7 */
> +			msg->buf[i] = (u8) STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_DR);
> +		}
> +	} else {
> +		/* WRITE: we send the actual bytes one at a time */
> +		for (i = 0; i < msg->len; i++) {
> +			/* Write the byte */
> +			STDDCI2C_WRITE_DATA_8_BIT(msg->buf[i],
> +						  dev->virtbase + I2C_DR);
> +			/* Check status */
> +			ret = stddci2c_await_event(dev, STDDCI2C_EVENT_8);
> +			/* Next write to DR will clear event 8 */
> +			if (ret != 0) {
> +				dev_err(&dev->pdev->dev, "error awaiting "
> +				       "event 8 (%d)\n", ret);
> +				goto exit_disable;
> +			}
> +		}
> +		/* Check NAK */
> +		if (!(msg->flags & I2C_M_IGNORE_NAK)) {
> +			if (STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR2) &
> +			    I2C_SR2_AF_IND) {
> +				dev_err(&dev->pdev->dev, "I2C payload "
> +				       "send returned NAK!\n");
> +				ret = -EIO;
> +				goto exit_disable;
> +			}
> +		}
> +		if (stop) {
> +			/* Send stop condition */
> +			val = I2C_CR_PERIPHERAL_ENABLE;
> +			val |= I2C_CR_STOP_ENABLE;
> +			STDDCI2C_WRITE_DATA_8_BIT(val, dev->virtbase + I2C_CR);
> +		}
> +	}
> +
> +	/* Check that the bus is free, or wait until some timeout occurs */
> +	ret = stddci2c_wait_while_busy(dev);
> +	if (ret != 0) {
> +		dev_err(&dev->pdev->dev, "timout waiting for transfer "
> +		       "to commence.\n");
> +		goto exit_disable;
> +	}
> +
> +	/* Dummy read status registers */
> +	val = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR2);
> +	val = STDDCI2C_READ_DATA_8_BIT(dev->virtbase + I2C_SR1);
> +	ret = 0;
> +
> + exit_disable:
> +	/* Disable controller */
> +	STDDCI2C_WRITE_DATA_8_BIT(0x00, dev->virtbase + I2C_CR);
> +	clk_disable(dev->clk);
> +	return ret;
> +}
> +
> +static int stddci2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			 int num)
> +{
> +	int ret = -1;
> +	int i;
> +	struct stddci2c_dev *dev = i2c_get_adapdata(adap);
> +	dev->msg_len = num;
> +	for (i = 0; i < num; i++) {
> +		/*
> +		 * Another driver appears to send stop for each message,
> +		 * here we only do that for the last message. Possibly some
> +		 * peripherals require this behaviour, then their drivers
> +		 * have to send single messages in order to get "stop" for
> +		 * each message.
> +		 */
> +		dev->msg_index = i;
> +
> +		ret = stddci2c_xfer_msg(adap, &msgs[i], (i == (num - 1)));
> +		if (ret != 0) {
> +			num = ret;
> +			break;
> +		}
> +	}
> +
> +	return num;
> +}
> +
> +static u32 stddci2c_func(struct i2c_adapter *adap)
> +{
> +	/* This is the simplest thing you can think of... */
> +	return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> +}
> +
> +static const struct i2c_algorithm stddci2c_algo = {
> +	.master_xfer	= stddci2c_xfer,
> +	.functionality	= stddci2c_func,
> +};
> +
> +static int __init
> +stddci2c_probe(struct platform_device *pdev)

__devinit, iirc.

> +{
> +	struct stddci2c_dev *dev;
> +	struct i2c_adapter *adap;
> +	struct resource *res;
> +	int bus_nr;
> +	int ret = 0;
> +
> +	dev = kzalloc(sizeof(struct stddci2c_dev), GFP_KERNEL);
> +	if (!dev) {
> +		ret = -ENOMEM;
> +		goto err_no_devmem;
> +	}
> +
> +	bus_nr = pdev->id;
> +	dev->clk = clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(dev->clk)) {
> +		ret = PTR_ERR(dev->clk);
> +		dev_err(&pdev->dev, "could not retrieve i2c bus clock\n");
> +		goto err_no_clk;
> +	}
> +
> +	dev->pdev = pdev;
> +	platform_set_drvdata(pdev, dev);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		ret = -ENOENT;
> +		goto err_no_resource;
> +	}
> +
> +	dev->phybase = res->start;
> +	dev->physize = resource_size(res);
> +
> +	if (request_mem_region(dev->phybase, dev->physize,
> +			       NAME " I/O Area") == NULL) {
> +		ret = -EBUSY;
> +		goto err_no_ioregion;
> +	}
> +
> +	dev->virtbase = ioremap(dev->phybase, dev->physize);
> +	pr_debug(NAME ": initialize bus device I2C%d on virtual base 0x%08x\n",
> +	       bus_nr, (u32) dev->virtbase);

why not use dev_dbg() here?

> +	if (!dev->virtbase) {
> +		ret = -ENOMEM;
> +		goto err_no_ioremap;
> +	}
> +
> +	dev->irq = platform_get_irq(pdev, 0);
> +	if (request_irq(dev->irq, stddci2c_irh, IRQF_DISABLED,
> +			NAME, dev)) {
> +		ret = -EIO;
> +		goto err_no_irq;
> +	}
> +
> +	dev->speed = scl_frequency;
> +
> +	clk_enable(dev->clk);
> +	ret = stddci2c_init_hw(dev);
> +	clk_disable(dev->clk);
> +
> +	if (ret != 0) {
> +		dev_err(&dev->pdev->dev, "error initializing hardware.\n");
> +		goto err_init_hw;
> +	}
> +
> +	/* IRQ event handling initialization */
> +	spin_lock_init(&dev->cmd_issue_lock);
> +	dev->cmd_event = STDDCI2C_EVENT_NONE;
> +	dev->cmd_err = STDDCI2C_ERROR_NONE;
> +
> +	adap = &dev->adapter;
> +	adap->owner = THIS_MODULE;
> +	/* DDC class but actually often used for more generic I2C */
> +	adap->class = I2C_CLASS_DDC;

I thoguht jdelvare was trying to get rid of this?

> +	strncpy(adap->name, "ST Microelectronics DDC I2C adapter",
> +		sizeof(adap->name));
> +	adap->nr = bus_nr;
> +	adap->algo = &stddci2c_algo;
> +	adap->dev.parent = &pdev->dev;
> +	i2c_set_adapdata(adap, dev);
> +
> +	/* i2c device drivers may be active on return from add_adapter() */
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret) {
> +		dev_err(&dev->pdev->dev, "failure adding ST Micro DDC "
> +		       "I2C adapter\n");
> +		goto err_add_adapter;
> +	}
> +	return 0;
> +
> + err_add_adapter:
> + err_init_hw:
> +	free_irq(dev->irq, dev);
> + err_no_irq:
> +	iounmap(dev->virtbase);
> + err_no_ioremap:
> +	release_mem_region(dev->phybase, dev->physize);
> + err_no_ioregion:
> +	platform_set_drvdata(pdev, NULL);
> + err_no_resource:
> +	clk_put(dev->clk);
> + err_no_clk:
> +	kfree(dev);
> + err_no_devmem:
> +	dev_err(&pdev->dev, "failed to add " NAME " adapter: %d\n",
> +		pdev->id);
> +	return ret;
> +}
> +
> +static int stddci2c_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct stddci2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	/* Turn off everything */
> +	STDDCI2C_WRITE_DATA_8_BIT(0x00, dev->virtbase + I2C_CR);
> +	return 0;
> +}
> +
> +static int stddci2c_resume(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct stddci2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	clk_enable(dev->clk);
> +	ret = stddci2c_init_hw(dev);
> +	clk_disable(dev->clk);
> +
> +	if (ret != 0)
> +		dev_err(&pdev->dev, "error re-initializing hardware.\n");
> +	return ret;
> +}

should wrap these in #ifdef CONFIG_PM.

> +static int __exit

__devexit, iirc.

> +stddci2c_remove(struct platform_device *pdev)
> +{
> +	struct stddci2c_dev *dev = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&dev->adapter);
> +	/* Turn off everything */
> +	STDDCI2C_WRITE_DATA_8_BIT(0x00, dev->virtbase + I2C_CR);
> +	free_irq(dev->irq, dev);
> +	iounmap(dev->virtbase);
> +	release_mem_region(dev->phybase, dev->physize);
> +	clk_put(dev->clk);
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(dev);
> +	return 0;
> +}
> +
> +static struct platform_driver stddci2c_i2c_driver = {
> +	.driver = {
> +		.name	= "stddci2c",
> +		.owner	= THIS_MODULE,
> +	},
> +	.remove		= __exit_p(stddci2c_remove),

thought __devexit_p()?

> +	.suspend        = stddci2c_suspend,
> +	.resume         = stddci2c_resume,
> +
> +};
> +
> +static int __init stddci2c_init(void)
> +{
> +	return platform_driver_probe(&stddci2c_i2c_driver, stddci2c_probe);
> +}
> +
> +static void __exit stddci2c_exit(void)
> +{
> +	platform_driver_unregister(&stddci2c_i2c_driver);
> +}
> +
> +/*
> + * The systems using this bus often have very basic devices such
> + * as regulators on the I2C bus, so this needs to be loaded early.
> + * Therefore it is registered in the subsys_initcall().
> + */
> +subsys_initcall(stddci2c_init);
> +module_exit(stddci2c_exit);
> +
> +MODULE_AUTHOR("Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>");
> +MODULE_DESCRIPTION("ST Micro DDC I2C adapter");
> +MODULE_LICENSE("GPL");

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
