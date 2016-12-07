From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 1/2] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 7 Dec 2016 02:57:55 +0200
Message-ID: <3236642a-3907-d54f-a091-6a952d8ff1c9@mleia.com>
References: <1480467618-7497-1-git-send-email-brendanhiggins@google.com>
 <1480467618-7497-2-git-send-email-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480467618-7497-2-git-send-email-brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, clg-Bxea+6Xhats@public.gmane.org, mouse-Pma6HLj0uuo@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Brendan,

please find review comments below.

After reviewing device tree binding now I'm confident that you should split
the file into two and then send interrupt controller driver for a separate
review by IRQCHIP maintainers. The interrupt controller driver will be
quite simple (as almost all of them), but it deserves its own review
and it should be placed under drivers/irqchip.

On 11/30/2016 03:00 AM, Brendan Higgins wrote:
> Added initial master and slave support for Aspeed I2C controller.
> Supports fourteen busses present in ast24xx and ast25xx BMC SoCs by
> Aspeed.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
> Changes for v2:
>   - Added single module_init (multiple was breaking some builds).
> Changes for v3:
>   - Removed "bus" device tree param; now extracted from bus address offset
> Changes for v4:
>   - I2C adapter number is now generated dynamically unless specified in alias.
> Changes for v5:
>   - Removed irq_chip used to multiplex IRQ and replaced it with dummy_irq_chip
>     along with some other IRQ cleanup.
>   - Addressed comments from Cedric, and Vladimir, mostly stylistic things and
>     using devm managed resources.
>   - Increased max clock frequency before the bus is put in HighSpeed mode, as
>     per Kachalov's comment.
> ---
>  drivers/i2c/busses/Kconfig      |  10 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-aspeed.c | 839 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 850 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-aspeed.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d252276..e8cf750 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -325,6 +325,16 @@ config I2C_POWERMAC
>  
>  comment "I2C system bus drivers (mostly embedded / system-on-chip)"
>  
> +config I2C_ASPEED
> +	tristate "Aspeed AST2xxx SoC I2C Controller"
> +	depends on ARCH_ASPEED
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Aspeed AST2xxx SoC I2C controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-aspeed.
> +
>  config I2C_AT91
>  	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
>  	depends on ARCH_AT91
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 29764cc..73fec22 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
>  obj-$(CONFIG_I2C_POWERMAC)	+= i2c-powermac.o
>  
>  # Embedded system I2C/SMBus host controller drivers
> +obj-$(CONFIG_I2C_ASPEED)	+= i2c-aspeed.o
>  obj-$(CONFIG_I2C_AT91)		+= i2c-at91.o
>  obj-$(CONFIG_I2C_AU1550)	+= i2c-au1550.o
>  obj-$(CONFIG_I2C_AXXIA)		+= i2c-axxia.o
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> new file mode 100644
> index 0000000..0e68808
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -0,0 +1,839 @@
> +/*
> + *  I2C adapter for the ASPEED I2C bus.
> + *
> + *  Copyright (C) 2012-2016 ASPEED Technology Inc.
> + *  Copyright 2016 IBM Corporation
> + *  Copyright 2016 Google, Inc.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License version 2 as
> + *  published by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/* I2C Register */
> +#define ASPEED_I2C_FUN_CTRL_REG				0x00
> +#define ASPEED_I2C_AC_TIMING_REG1			0x04
> +#define ASPEED_I2C_AC_TIMING_REG2			0x08
> +#define ASPEED_I2C_INTR_CTRL_REG			0x0c
> +#define ASPEED_I2C_INTR_STS_REG				0x10
> +#define ASPEED_I2C_CMD_REG				0x14
> +#define ASPEED_I2C_DEV_ADDR_REG				0x18
> +#define ASPEED_I2C_BYTE_BUF_REG				0x20
> +
> +#define ASPEED_I2C_NUM_BUS 14
> +
> +/* Global Register Definition */
> +/* 0x00 : I2C Interrupt Status Register  */
> +/* 0x08 : I2C Interrupt Target Assignment  */
> +
> +/* Device Register Definition */
> +/* 0x00 : I2CD Function Control Register  */
> +#define ASPEED_I2CD_MULTI_MASTER_DIS			BIT(15)
> +#define ASPEED_I2CD_SDA_DRIVE_1T_EN			BIT(8)
> +#define ASPEED_I2CD_M_SDA_DRIVE_1T_EN			BIT(7)
> +#define ASPEED_I2CD_M_HIGH_SPEED_EN			BIT(6)
> +#define ASPEED_I2CD_SLAVE_EN				BIT(1)
> +#define ASPEED_I2CD_MASTER_EN				BIT(0)
> +
> +/* 0x08 : I2CD Clock and AC Timing Control Register #2 */
> +#define ASPEED_NO_TIMEOUT_CTRL				0
> +
> +

checkpatch complains here:

CHECK: Please don't use multiple blank lines
#60: FILE: drivers/i2c/busses/i2c-aspeed.c:60:

> +/* 0x0c : I2CD Interrupt Control Register &
> + * 0x10 : I2CD Interrupt Status Register
> + *
> + * These share bit definitions, so use the same values for the enable &
> + * status bits.
> + */
> +#define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(14)
> +#define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
> +#define ASPEED_I2CD_INTR_SLAVE_MATCH			BIT(7)
> +#define ASPEED_I2CD_INTR_SCL_TIMEOUT			BIT(6)
> +#define ASPEED_I2CD_INTR_ABNORMAL			BIT(5)
> +#define ASPEED_I2CD_INTR_NORMAL_STOP			BIT(4)
> +#define ASPEED_I2CD_INTR_ARBIT_LOSS			BIT(3)
> +#define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
> +#define ASPEED_I2CD_INTR_TX_NAK				BIT(1)
> +#define ASPEED_I2CD_INTR_TX_ACK				BIT(0)
> +#define ASPEED_I2CD_INTR_ERROR						       \
> +		(ASPEED_I2CD_INTR_ARBIT_LOSS |				       \
> +		 ASPEED_I2CD_INTR_ABNORMAL |				       \
> +		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
> +		 ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
> +		 ASPEED_I2CD_INTR_TX_NAK)
> +#define ASPEED_I2CD_INTR_ALL						       \
> +		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |			       \
> +		 ASPEED_I2CD_INTR_BUS_RECOVER_DONE |			       \
> +		 ASPEED_I2CD_INTR_SCL_TIMEOUT |				       \
> +		 ASPEED_I2CD_INTR_ABNORMAL |				       \
> +		 ASPEED_I2CD_INTR_NORMAL_STOP |				       \
> +		 ASPEED_I2CD_INTR_ARBIT_LOSS |				       \
> +		 ASPEED_I2CD_INTR_RX_DONE |				       \
> +		 ASPEED_I2CD_INTR_TX_NAK |				       \
> +		 ASPEED_I2CD_INTR_TX_ACK)
> +
> +/* 0x14 : I2CD Command/Status Register   */
> +#define ASPEED_I2CD_SCL_LINE_STS			BIT(18)
> +#define ASPEED_I2CD_SDA_LINE_STS			BIT(17)
> +#define ASPEED_I2CD_BUS_BUSY_STS			BIT(16)
> +#define ASPEED_I2CD_BUS_RECOVER_CMD			BIT(11)
> +
> +/* Command Bit */
> +#define ASPEED_I2CD_M_STOP_CMD				BIT(5)
> +#define ASPEED_I2CD_M_S_RX_CMD_LAST			BIT(4)
> +#define ASPEED_I2CD_M_RX_CMD				BIT(3)
> +#define ASPEED_I2CD_S_TX_CMD				BIT(2)
> +#define ASPEED_I2CD_M_TX_CMD				BIT(1)
> +#define ASPEED_I2CD_M_START_CMD				BIT(0)
> +
> +/* 0x18 : I2CD Slave Device Address Register   */
> +#define ASPEED_I2CD_DEV_ADDR_MASK			GENMASK(6, 0)
> +
> +enum aspeed_i2c_slave_state {
> +	ASPEED_I2C_SLAVE_START,
> +	ASPEED_I2C_SLAVE_READ_REQUESTED,
> +	ASPEED_I2C_SLAVE_READ_PROCESSED,
> +	ASPEED_I2C_SLAVE_WRITE_REQUESTED,
> +	ASPEED_I2C_SLAVE_WRITE_RECEIVED,
> +	ASPEED_I2C_SLAVE_STOP,
> +};
> +
> +struct aspeed_i2c_bus {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	spinlock_t			lock;

checkpatch complains here:

CHECK: spinlock_t definition without comment
#124: FILE: drivers/i2c/busses/i2c-aspeed.c:124:

> +	struct completion		cmd_complete;
> +	int				irq;
> +	/* Transaction state. */
> +	struct i2c_msg			*msg;
> +	int				msg_pos;
> +	u32				cmd_err;
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	struct i2c_client		*slave;
> +	enum aspeed_i2c_slave_state	slave_state;
> +#endif
> +};
> +
> +struct aspeed_i2c_controller {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	int			irq;
> +	struct irq_domain	*irq_domain;
> +};
> +
> +static inline void aspeed_i2c_write(struct aspeed_i2c_bus *bus, u32 val,
> +				    u32 reg)
> +{
> +	writel(val, bus->base + reg);
> +}
> +
> +static inline u32 aspeed_i2c_read(struct aspeed_i2c_bus *bus, u32 reg)
> +{
> +	return readl(bus->base + reg);
> +}
> +
> +static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
> +{
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +	u32 command;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	command = aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG);
> +
> +	if (command & ASPEED_I2CD_SDA_LINE_STS) {
> +		/* Bus is idle: no recovery needed. */
> +		if (command & ASPEED_I2CD_SCL_LINE_STS)
> +			goto out;
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		aspeed_i2c_write(bus, ASPEED_I2CD_M_STOP_CMD,
> +				 ASPEED_I2C_CMD_REG);
> +		reinit_completion(&bus->cmd_complete);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			ret = -ETIMEDOUT;
> +		else if (bus->cmd_err)
> +			ret = -EIO;
> +	/* Bus error. */
> +	} else {
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		aspeed_i2c_write(bus, ASPEED_I2CD_BUS_RECOVER_CMD,
> +				 ASPEED_I2C_CMD_REG);
> +		reinit_completion(&bus->cmd_complete);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			ret = -ETIMEDOUT;
> +		else if (bus->cmd_err)
> +			ret = -EIO;
> +		/* Recovery failed. */
> +		else if (!(aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG) &
> +			   ASPEED_I2CD_SDA_LINE_STS))
> +			ret = -EIO;
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +}
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +static bool aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus)
> +{
> +	u32 command, irq_status, status_ack = 0;
> +	struct i2c_client *slave = bus->slave;
> +	bool irq_handled = true;
> +	u8 value;
> +
> +	spin_lock(&bus->lock);
> +	if (!slave) {
> +		irq_handled = false;
> +		goto out;
> +	}
> +
> +	command = aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG);
> +	irq_status = aspeed_i2c_read(bus, ASPEED_I2C_INTR_STS_REG);
> +
> +	/* Slave was requested, restart state machine. */
> +	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> +		status_ack |= ASPEED_I2CD_INTR_SLAVE_MATCH;
> +		bus->slave_state = ASPEED_I2C_SLAVE_START;
> +	}
> +
> +	/* Slave is not currently active, irq was for someone else. */
> +	if (bus->slave_state == ASPEED_I2C_SLAVE_STOP) {
> +		irq_handled = false;
> +		goto out;
> +	}
> +
> +	dev_dbg(bus->dev, "slave irq status 0x%08x, cmd 0x%08x\n",
> +		irq_status, command);
> +
> +	/* Slave was sent something. */
> +	if (irq_status & ASPEED_I2CD_INTR_RX_DONE) {
> +		value = aspeed_i2c_read(bus, ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		/* Handle address frame. */
> +		if (bus->slave_state == ASPEED_I2C_SLAVE_START) {
> +			if (value & 0x1)
> +				bus->slave_state =
> +						ASPEED_I2C_SLAVE_READ_REQUESTED;
> +			else
> +				bus->slave_state =
> +						ASPEED_I2C_SLAVE_WRITE_REQUESTED;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> +	}
> +
> +	/* Slave was asked to stop. */
> +	if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) {
> +		status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
> +		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> +	}
> +	if (irq_status & ASPEED_I2CD_INTR_TX_NAK) {
> +		status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +		bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> +	}
> +
> +	switch (bus->slave_state) {
> +	case ASPEED_I2C_SLAVE_READ_REQUESTED:
> +		if (irq_status & ASPEED_I2CD_INTR_TX_ACK)
> +			dev_err(bus->dev, "Unexpected ACK on read request.\n");
> +		bus->slave_state = ASPEED_I2C_SLAVE_READ_PROCESSED;
> +
> +		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
> +		aspeed_i2c_write(bus, value, ASPEED_I2C_BYTE_BUF_REG);
> +		aspeed_i2c_write(bus, ASPEED_I2CD_S_TX_CMD, ASPEED_I2C_CMD_REG);
> +		break;
> +	case ASPEED_I2C_SLAVE_READ_PROCESSED:
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		if (!(irq_status & ASPEED_I2CD_INTR_TX_ACK))
> +			dev_err(bus->dev,
> +				"Expected ACK after processed read.\n");
> +		i2c_slave_event(slave, I2C_SLAVE_READ_PROCESSED, &value);
> +		aspeed_i2c_write(bus, value, ASPEED_I2C_BYTE_BUF_REG);
> +		aspeed_i2c_write(bus, ASPEED_I2CD_S_TX_CMD, ASPEED_I2C_CMD_REG);
> +		break;
> +	case ASPEED_I2C_SLAVE_WRITE_REQUESTED:
> +		bus->slave_state = ASPEED_I2C_SLAVE_WRITE_RECEIVED;
> +		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +		break;
> +	case ASPEED_I2C_SLAVE_WRITE_RECEIVED:
> +		i2c_slave_event(slave, I2C_SLAVE_WRITE_RECEIVED, &value);
> +		break;
> +	case ASPEED_I2C_SLAVE_STOP:
> +		i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +		break;
> +	default:
> +		dev_err(bus->dev, "unhandled slave_state: %d\n",
> +			bus->slave_state);
> +		break;
> +	}
> +
> +	if (status_ack != irq_status)
> +		dev_err(bus->dev,
> +			"irq handled != irq. expected %x, but was %x\n",
> +			irq_status, status_ack);
> +	aspeed_i2c_write(bus, status_ack, ASPEED_I2C_INTR_STS_REG);
> +
> +out:
> +	spin_unlock(&bus->lock);
> +	return irq_handled;
> +}
> +#endif
> +
> +static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> +{
> +	u32 irq_status;
> +
> +	spin_lock(&bus->lock);
> +	irq_status = aspeed_i2c_read(bus, ASPEED_I2C_INTR_STS_REG);
> +	bus->cmd_err = irq_status & ASPEED_I2CD_INTR_ERROR;
> +
> +	dev_dbg(bus->dev, "master irq status 0x%08x\n", irq_status);
> +
> +	/* No message to transfer. */
> +	if (bus->cmd_err ||
> +	    (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP) ||
> +	    (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE)) {
> +		complete(&bus->cmd_complete);
> +		goto out;
> +	} else if (!bus->msg || bus->msg_pos >= bus->msg->len)
> +		goto out;

checkpatch complains here:

CHECK: braces {} should be used on all arms of this statement
#329: FILE: drivers/i2c/busses/i2c-aspeed.c:329:

> +
> +	if ((bus->msg->flags & I2C_M_RD) &&
> +	    (irq_status & ASPEED_I2CD_INTR_RX_DONE)) {
> +		bus->msg->buf[bus->msg_pos++] = aspeed_i2c_read(
> +				bus, ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		if (bus->msg_pos + 1 < bus->msg->len)
> +			aspeed_i2c_write(bus, ASPEED_I2CD_M_RX_CMD,
> +					 ASPEED_I2C_CMD_REG);
> +		else if (bus->msg_pos < bus->msg->len)
> +			aspeed_i2c_write(bus, ASPEED_I2CD_M_RX_CMD |
> +				      ASPEED_I2CD_M_S_RX_CMD_LAST,
> +				      ASPEED_I2C_CMD_REG);
> +	} else if (!(bus->msg->flags & I2C_M_RD) &&
> +		   (irq_status & ASPEED_I2CD_INTR_TX_ACK)) {
> +		aspeed_i2c_write(bus, bus->msg->buf[bus->msg_pos++],
> +			      ASPEED_I2C_BYTE_BUF_REG);

checkpatch complains here:

CHECK: Alignment should match open parenthesis
#351: FILE: drivers/i2c/busses/i2c-aspeed.c:351:

> +		aspeed_i2c_write(bus, ASPEED_I2CD_M_TX_CMD, ASPEED_I2C_CMD_REG);
> +	}
> +
> +	/* Transmission complete: notify caller. */
> +	if (bus->msg_pos >= bus->msg->len)
> +		complete(&bus->cmd_complete);
> +out:
> +	aspeed_i2c_write(bus, irq_status, ASPEED_I2C_INTR_STS_REG);
> +	spin_unlock(&bus->lock);
> +
> +	return true;
> +}
> +
> +static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct aspeed_i2c_bus *bus = dev_id;
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	if (aspeed_i2c_slave_irq(bus)) {
> +		dev_dbg(bus->dev, "irq handled by slave.\n");
> +		return IRQ_HANDLED;
> +	}
> +#endif
> +
> +	if (aspeed_i2c_master_irq(bus)) {
> +		dev_dbg(bus->dev, "irq handled by master.\n");
> +		return IRQ_HANDLED;
> +	}

aspeed_i2c_master_irq() always return 'true', this means that
without functional change you can move dev_dbg() into
aspeed_i2c_master_irq() function, and then remove the if-check
for return value.

> +
> +	dev_err(bus->dev, "irq not handled properly!\n");
> +	return IRQ_NONE;

This is dead code, if functional changes in aspeed_i2c_master_irq()
are not done, please remove it.

> +}
> +
> +static int aspeed_i2c_master_single_xfer(struct i2c_adapter *adap,
> +				      struct i2c_msg *msg)

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#386: FILE: drivers/i2c/busses/i2c-aspeed.c:386:

> +{
> +	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
> +	struct aspeed_i2c_bus *bus = adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret = msg->len;
> +	u8 slave_addr;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->msg = msg;
> +	bus->msg_pos = 0;
> +	slave_addr = msg->addr << 1;
> +
> +	if (msg->flags & I2C_M_RD) {
> +		slave_addr |= 1;
> +		command |= ASPEED_I2CD_M_RX_CMD;
> +		if (msg->len == 1)
> +			command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +	}
> +
> +	aspeed_i2c_write(bus, slave_addr, ASPEED_I2C_BYTE_BUF_REG);
> +	aspeed_i2c_write(bus, command, ASPEED_I2C_CMD_REG);
> +	reinit_completion(&bus->cmd_complete);
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(
> +			&bus->cmd_complete, bus->adap.timeout);
> +	if (time_left == 0)
> +		return -ETIMEDOUT;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	if (bus->cmd_err)
> +		ret = -EIO;
> +
> +	bus->msg = NULL;
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> +				  struct i2c_msg *msgs, int num)
> +{
> +	struct aspeed_i2c_bus *bus = adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret, i;
> +
> +	/* If bus is busy, attempt recovery. We assume a single master
> +	 * environment.
> +	 */
> +	if (aspeed_i2c_read(bus, ASPEED_I2C_CMD_REG) &
> +	    ASPEED_I2CD_BUS_BUSY_STS) {
> +		ret = aspeed_i2c_recover_bus(bus);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < num; i++) {
> +		ret = aspeed_i2c_master_single_xfer(adap, &msgs[i]);
> +		if (ret < 0)
> +			break;

Please insert an empty line here to improve readability.

> +		/* TODO: Support other forms of I2C protocol mangling. */
> +		if (msgs[i].flags & I2C_M_STOP) {
> +			spin_lock_irqsave(&bus->lock, flags);
> +			aspeed_i2c_write(bus, ASPEED_I2CD_M_STOP_CMD,
> +				      ASPEED_I2C_CMD_REG);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#451: FILE: drivers/i2c/busses/i2c-aspeed.c:451:

> +			reinit_completion(&bus->cmd_complete);
> +			spin_unlock_irqrestore(&bus->lock, flags);
> +
> +			time_left = wait_for_completion_timeout(
> +					&bus->cmd_complete, bus->adap.timeout);
> +			if (time_left == 0)
> +				return -ETIMEDOUT;
> +		}
> +	}
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	aspeed_i2c_write(bus, ASPEED_I2CD_M_STOP_CMD, ASPEED_I2C_CMD_REG);
> +	reinit_completion(&bus->cmd_complete);
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(
> +			&bus->cmd_complete, bus->adap.timeout);
> +	if (time_left == 0)
> +		return -ETIMEDOUT;
> +
> +	/* If nothing went wrong, return number of messages transferred. */
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return i;
> +}
> +
> +static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +static int aspeed_i2c_reg_slave(struct i2c_client *client)
> +{
> +	u32 addr_reg_val, func_ctrl_reg_val;
> +	struct aspeed_i2c_bus *bus;
> +	unsigned long flags;
> +
> +	bus = client->adapter->algo_data;
> +	spin_lock_irqsave(&bus->lock, flags);
> +	if (bus->slave) {
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	/* Set slave addr. */
> +	addr_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_DEV_ADDR_REG);
> +	addr_reg_val &= ~ASPEED_I2CD_DEV_ADDR_MASK;
> +	addr_reg_val |= client->addr & ASPEED_I2CD_DEV_ADDR_MASK;
> +	aspeed_i2c_write(bus, addr_reg_val, ASPEED_I2C_DEV_ADDR_REG);
> +
> +	/* Switch from master mode to slave mode. */
> +	func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
> +	func_ctrl_reg_val &= ~ASPEED_I2CD_MASTER_EN;
> +	func_ctrl_reg_val |= ASPEED_I2CD_SLAVE_EN;
> +	aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	bus->slave = client;
> +	bus->slave_state = ASPEED_I2C_SLAVE_STOP;
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_unreg_slave(struct i2c_client *client)
> +{
> +	struct aspeed_i2c_bus *bus = client->adapter->algo_data;
> +	u32 func_ctrl_reg_val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	if (!bus->slave) {
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	/* Switch from slave mode to master mode. */
> +	func_ctrl_reg_val = aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG);
> +	func_ctrl_reg_val &= ~ASPEED_I2CD_SLAVE_EN;
> +	func_ctrl_reg_val |= ASPEED_I2CD_MASTER_EN;
> +	aspeed_i2c_write(bus, func_ctrl_reg_val, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	bus->slave = NULL;
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct i2c_algorithm aspeed_i2c_algo = {
> +	.master_xfer	= aspeed_i2c_master_xfer,
> +	.functionality	= aspeed_i2c_functionality,
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	.reg_slave	= aspeed_i2c_reg_slave,
> +	.unreg_slave	= aspeed_i2c_unreg_slave,
> +#endif
> +};
> +
> +static u32 aspeed_i2c_get_clk_reg_val(u32 divider_ratio)
> +{
> +	u32 scl_low, scl_high, data;
> +	unsigned int inc = 0, div;
> +
> +	for (div = 0; divider_ratio >= 16; div++) {
> +		inc |= (divider_ratio & 1);
> +		divider_ratio >>= 1;
> +	}
> +
> +	divider_ratio += inc;
> +	scl_low = (divider_ratio >> 1) - 1;
> +	scl_high = divider_ratio - scl_low - 2;
> +	data = 0x77700300 | (scl_high << 16) | (scl_low << 12) | div;
> +	return data;
> +}
> +
> +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> +			    struct platform_device *pdev)

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#569: FILE: drivers/i2c/busses/i2c-aspeed.c:569:

> +{
> +	u32 clk_freq, divider_ratio;
> +	struct clk *pclk;
> +	int ret;
> +
> +	pclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pclk)) {
> +		dev_err(&pdev->dev, "clk_get failed\n");
> +		return PTR_ERR(pclk);
> +	}
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +			"clock-frequency", &clk_freq);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#581: FILE: drivers/i2c/busses/i2c-aspeed.c:581:

> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +				"Could not read clock-frequency property\n");

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#584: FILE: drivers/i2c/busses/i2c-aspeed.c:584:

> +		clk_freq = 100000;
> +	}
> +	divider_ratio = clk_get_rate(pclk) / clk_freq;
> +	/* We just need the clock rate, we don't actually use the clk object. */
> +	devm_clk_put(&pdev->dev, pclk);
> +
> +	/* Set AC Timing */
> +	if (clk_freq / 1000 > 1000) {
> +		aspeed_i2c_write(bus, aspeed_i2c_read(bus,
> +						      ASPEED_I2C_FUN_CTRL_REG) |
> +				ASPEED_I2CD_M_HIGH_SPEED_EN |
> +				ASPEED_I2CD_M_SDA_DRIVE_1T_EN |
> +				ASPEED_I2CD_SDA_DRIVE_1T_EN,
> +				ASPEED_I2C_FUN_CTRL_REG);
> +
> +		aspeed_i2c_write(bus, 0x3, ASPEED_I2C_AC_TIMING_REG2);
> +		aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divider_ratio),
> +			      ASPEED_I2C_AC_TIMING_REG1);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#602: FILE: drivers/i2c/busses/i2c-aspeed.c:602:

> +	} else {
> +		aspeed_i2c_write(bus, aspeed_i2c_get_clk_reg_val(divider_ratio),
> +			      ASPEED_I2C_AC_TIMING_REG1);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#605: FILE: drivers/i2c/busses/i2c-aspeed.c:605:

> +		aspeed_i2c_write(bus, ASPEED_NO_TIMEOUT_CTRL,
> +				 ASPEED_I2C_AC_TIMING_REG2);
> +	}
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus;
> +	struct resource *res;
> +	int ret;
> +
> +	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bus->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(bus->base))
> +		return PTR_ERR(bus->base);
> +
> +	bus->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	ret = devm_request_irq(&pdev->dev, bus->irq, aspeed_i2c_bus_irq,
> +			       IRQF_SHARED, dev_name(&pdev->dev), bus);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to request interrupt\n");
> +		return ret;
> +	}
> +
> +	/* Initialize the I2C adapter */
> +	spin_lock_init(&bus->lock);
> +	init_completion(&bus->cmd_complete);
> +	bus->adap.owner = THIS_MODULE;
> +	bus->adap.retries = 0;
> +	bus->adap.timeout = 5 * HZ;
> +	bus->adap.algo = &aspeed_i2c_algo;
> +	bus->adap.algo_data = bus;
> +	bus->adap.dev.parent = &pdev->dev;
> +	bus->adap.dev.of_node = pdev->dev.of_node;
> +	snprintf(bus->adap.name, sizeof(bus->adap.name), "Aspeed i2c");
> +
> +	bus->dev = &pdev->dev;
> +
> +	/* reset device: disable master & slave functions */
> +	aspeed_i2c_write(bus, 0, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	ret = aspeed_i2c_init_clk(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Master Mode */
> +	aspeed_i2c_write(bus, aspeed_i2c_read(bus, ASPEED_I2C_FUN_CTRL_REG) |
> +		      ASPEED_I2CD_MASTER_EN |
> +		      ASPEED_I2CD_MULTI_MASTER_DIS, ASPEED_I2C_FUN_CTRL_REG);
> +
> +	/* Set interrupt generation of I2C controller */
> +	aspeed_i2c_write(bus, ASPEED_I2CD_INTR_ALL, ASPEED_I2C_INTR_CTRL_REG);
> +
> +	ret = i2c_add_adapter(&bus->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, bus);
> +
> +	dev_info(bus->dev, "i2c bus %d registered, irq %d\n",
> +			bus->adap.nr, bus->irq);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#672: FILE: drivers/i2c/busses/i2c-aspeed.c:672:

> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_remove_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&bus->adap);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_i2c_bus_of_table[] = {
> +	{ .compatible = "aspeed,ast2400-i2c-bus", },
> +	{ .compatible = "aspeed,ast2500-i2c-bus", },

checkpatch complains here:

WARNING: DT compatible string "aspeed,ast2400-i2c-bus" appears un-documented -- check ./Documentation/devicetree/bindings/
#687: FILE: drivers/i2c/busses/i2c-aspeed.c:687:
WARNING: DT compatible string "aspeed,ast2500-i2c-bus" appears un-documented -- check ./Documentation/devicetree/bindings/
#688: FILE: drivers/i2c/busses/i2c-aspeed.c:688:

Device tree binding documentation must precede the driver.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
> +
> +static struct platform_driver aspeed_i2c_bus_driver = {
> +	.probe		= aspeed_i2c_probe_bus,
> +	.remove		= aspeed_i2c_remove_bus,
> +	.driver		= {
> +		.name		= "ast-i2c-bus",
> +		.of_match_table	= aspeed_i2c_bus_of_table,
> +	},
> +};
> +
> +/*
> + * The aspeed chip provides a single hardware interrupt for all of the I2C
> + * busses, so we use a dummy interrupt chip to translate this single interrupt
> + * into multiple interrupts, each associated with a single I2C bus.
> + */
> +static void aspeed_i2c_controller_irq(struct irq_desc *desc)
> +{
> +	struct aspeed_i2c_controller *c = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned long p, status;
> +	unsigned int bus_irq;
> +
> +	chained_irq_enter(chip, desc);
> +	status = readl(c->base);
> +	for_each_set_bit(p, &status, ASPEED_I2C_NUM_BUS) {
> +		bus_irq = irq_find_mapping(c->irq_domain, p);
> +		generic_handle_irq(bus_irq);
> +	}
> +	chained_irq_exit(chip, desc);
> +}
> +
> +/*
> + * Set simple handler and mark IRQ as valid. Nothing interesting to do here
> + * since we are using a dummy interrupt chip.
> + */
> +static int aspeed_i2c_map_irq_domain(struct irq_domain *domain,
> +				     unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops aspeed_i2c_irq_domain_ops = {
> +	.map = aspeed_i2c_map_irq_domain,
> +};
> +
> +static int aspeed_i2c_probe_controller(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_controller *controller;
> +	struct device_node *np;
> +	struct resource *res;
> +
> +	controller = devm_kzalloc(&pdev->dev, sizeof(*controller), GFP_KERNEL);
> +	if (!controller)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	controller->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(controller->base))
> +		return PTR_ERR(controller->base);
> +
> +	controller->irq = platform_get_irq(pdev, 0);
> +	if (controller->irq < 0)
> +		return -ENXIO;

here it should be "return controller->irq;"

> +
> +	controller->irq_domain = irq_domain_add_linear(pdev->dev.of_node,
> +			ASPEED_I2C_NUM_BUS, &aspeed_i2c_irq_domain_ops, NULL);
> +	if (!controller->irq_domain)
> +		return -ENOMEM;
> +
> +	controller->irq_domain->name = "ast-i2c-domain";
> +
> +	irq_set_chained_handler_and_data(controller->irq,
> +			aspeed_i2c_controller_irq, controller);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#767: FILE: drivers/i2c/busses/i2c-aspeed.c:767:

But due to the long name of the function this warning can be ignored.

> +
> +	controller->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, controller);
> +
> +	dev_info(controller->dev, "i2c controller registered, irq %d\n",
> +			controller->irq);

checkpatch complains here:
CHECK: Alignment should match open parenthesis
#774: FILE: drivers/i2c/busses/i2c-aspeed.c:774:

> +
> +	for_each_child_of_node(pdev->dev.of_node, np) {
> +		of_platform_device_create(np, NULL, &pdev->dev);
> +	}

This should be removed, when you correct the layout of device tree nodes
as I described in the comments to v6 2/2.

> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_remove_controller(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_controller *controller = platform_get_drvdata(pdev);
> +
> +	irq_domain_remove(controller->irq_domain);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_i2c_controller_of_table[] = {
> +	{ .compatible = "aspeed,ast2400-i2c-controller", },
> +	{ .compatible = "aspeed,ast2500-i2c-controller", },

checkpatch complains here:
WARNING: DT compatible string "aspeed,ast2400-i2c-controller" appears un-documented -- check ./Documentation/devicetree/bindings/
#793: FILE: drivers/i2c/busses/i2c-aspeed.c:793:
WARNING: DT compatible string "aspeed,ast2500-i2c-controller" appears un-documented -- check ./Documentation/devicetree/bindings/
#794: FILE: drivers/i2c/busses/i2c-aspeed.c:794:

Device tree binding documentation must precede the driver.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_i2c_controller_of_table);
> +
> +static struct platform_driver aspeed_i2c_controller_driver = {
> +	.probe		= aspeed_i2c_probe_controller,
> +	.remove		= aspeed_i2c_remove_controller,
> +	.driver		= {
> +		.name		= "ast-i2c-controller",

It might be good to get from the name that this is an interrupt controller
driver.

> +		.of_match_table	= aspeed_i2c_controller_of_table,
> +	},
> +};
> +
> +static int __init aspeed_i2c_driver_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&aspeed_i2c_controller_driver);
> +	if (ret < 0) {
> +		platform_driver_unregister(&aspeed_i2c_controller_driver);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&aspeed_i2c_bus_driver);
> +
> +	if (ret < 0) {
> +		platform_driver_unregister(&aspeed_i2c_bus_driver);
> +		platform_driver_unregister(&aspeed_i2c_controller_driver);
> +		return ret;

Now it is done incorrectly, please unregister only successfully registered
device drivers.

This will be simplified after decoupling the driver into two independent
drivers.

> +	}
> +
> +	return 0;
> +}
> +module_init(aspeed_i2c_driver_init);
> +
> +static void __exit aspeed_i2c_driver_exit(void)
> +{
> +	platform_driver_unregister(&aspeed_i2c_bus_driver);
> +	platform_driver_unregister(&aspeed_i2c_controller_driver);

This will be simplified after decoupling the driver into two independent
drivers.

> +}
> +module_exit(aspeed_i2c_driver_exit);
> +
> +MODULE_AUTHOR("Brendan Higgins <brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
> +MODULE_LICENSE("GPL");

>From the header this is GPL v2 only driver, then please use
MODULE_LICENSE("GPL v2");

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
