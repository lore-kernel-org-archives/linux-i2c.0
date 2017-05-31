From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Wed, 31 May 2017 12:16:41 +1000
Message-ID: <1496197001.3354.19.camel@kernel.crashing.org>
References: <20170525064925.16867-1-brendanhiggins@google.com>
         <20170525064925.16867-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35770 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdEaCR7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 30 May 2017 22:17:59 -0400
In-Reply-To: <20170525064925.16867-5-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org

On Wed, 2017-05-24 at 23:49 -0700, Brendan Higgins wrote:
> Added initial master support for Aspeed I2C controller. Supports
> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.

Hi Brendan !

It's getting there :-) I have a few comments mostly about some corner
cases below.

Cheers,
Ben.

> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
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
> Changes for v6:
>   - No longer arbitrarily restrict bus to be slave xor master.
>   - Pulled out "struct aspeed_i2c_controller" as a interrupt controller.
>   - Pulled out slave support into its own commit.
>   - Rewrote code that sets clock divider register because the original version
>     set it incorrectly.
>   - Rewrote the aspeed_i2c_master_irq handler because the old method of
>     completing a completion in between restarts was too slow causing devices to
>     misbehave.
>   - Added support for I2C_M_RECV_LEN which I had incorrectly said was supported
>     before.
>   - Addressed other comments from Vladimir.
> Changes for v7:
>   - Changed clock-frequency to bus-frequency
>   - Made some fixes to clock divider code
>   - Added hardware reset function
>   - Marked functions that need to be called with the lock held as "unlocked"
>   - Did a bunch of clean up
> Changes for v8:
>   - ACK IRQ status bits before doing anything else
>   - Added multi-master device tree property
>   - Do not send STOP commands after interrupt errors
>   - Fix SMBUS_QUICK emulation handling
>   - Removed highspeed clock code (I will do it in a later patch set)
>   - Use the platform_device name for the adapter name
>   - Reset for all failed recoveries
>   - Removed the "__" prefix from all of the non-thread safe functions
> ---
>  drivers/i2c/busses/Kconfig      |  10 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-aspeed.c | 695 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 706 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-aspeed.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 144cbadc7c72..280f84a0d7d1 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -326,6 +326,16 @@ config I2C_POWERMAC
>  
>  comment "I2C system bus drivers (mostly embedded / system-on-chip)"
>  
> +config I2C_ASPEED
> +	tristate "Aspeed I2C Controller"
> +	depends on ARCH_ASPEED
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Aspeed I2C controller.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called i2c-aspeed.
> +
>  config I2C_AT91
>  	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
>  	depends on ARCH_AT91
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 30b60855fbcd..e84604b9bf3b 100644
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
> index 000000000000..3eb1252442d7
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -0,0 +1,695 @@
> +/*
> + *  Aspeed 24XX/25XX I2C Controller.
> + *
> + *  Copyright (C) 2012-2017 ASPEED Technology Inc.
> + *  Copyright 2017 IBM Corporation
> + *  Copyright 2017 Google, Inc.
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
> +#define ASPEED_I2CD_MASTER_EN				BIT(0)
> +
> +/* 0x04 : I2CD Clock and AC Timing Control Register #1 */
> +#define ASPEED_I2CD_TIME_SCL_HIGH_SHIFT			16
> +#define ASPEED_I2CD_TIME_SCL_HIGH_MASK			GENMASK(19, 16)
> +#define ASPEED_I2CD_TIME_SCL_LOW_SHIFT			12
> +#define ASPEED_I2CD_TIME_SCL_LOW_MASK			GENMASK(15, 12)
> +#define ASPEED_I2CD_TIME_BASE_DIVISOR_MASK		GENMASK(3, 0)
> +#define ASPEED_I2CD_TIME_SCL_REG_MAX			GENMASK(3, 0)
> +/* 0x08 : I2CD Clock and AC Timing Control Register #2 */
> +#define ASPEED_NO_TIMEOUT_CTRL				0
> +
> +/* 0x0c : I2CD Interrupt Control Register &
> + * 0x10 : I2CD Interrupt Status Register
> + *
> + * These share bit definitions, so use the same values for the enable &
> + * status bits.
> + */
> +#define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(14)
> +#define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
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
> +		 ASPEED_I2CD_INTR_SDA_DL_TIMEOUT)
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
> +enum aspeed_i2c_master_state {
> +	ASPEED_I2C_MASTER_START,
> +	ASPEED_I2C_MASTER_TX_FIRST,
> +	ASPEED_I2C_MASTER_TX,
> +	ASPEED_I2C_MASTER_RX_FIRST,
> +	ASPEED_I2C_MASTER_RX,
> +	ASPEED_I2C_MASTER_STOP,
> +	ASPEED_I2C_MASTER_INACTIVE,
> +};
> +
> +struct aspeed_i2c_bus {
> +	struct i2c_adapter		adap;
> +	struct device			*dev;
> +	void __iomem			*base;
> +	/* Synchronizes I/O mem access to base. */
> +	spinlock_t			lock;
> +	struct completion		cmd_complete;
> +	int				irq;
> +	/* Transaction state. */
> +	enum aspeed_i2c_master_state	master_state;
> +	struct i2c_msg			*msgs;
> +	size_t				buf_index;
> +	size_t				msgs_index;
> +	size_t				msgs_count;
> +	bool				send_stop;
> +	int				cmd_err;
> +};
> +
> +static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
> +
> +static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
> +{
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +	u32 command;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	command = readl(bus->base + ASPEED_I2C_CMD_REG);
> +
> +	if (command & ASPEED_I2CD_SDA_LINE_STS) {
> +		/* Bus is idle: no recovery needed. */
> +		if (command & ASPEED_I2CD_SCL_LINE_STS)
> +			goto out;
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		reinit_completion(&bus->cmd_complete);
> +		writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			goto reset_out;
> +		else if (bus->cmd_err)
> +			goto reset_out;
> +		/* Recovery failed. */
> +		else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +			   ASPEED_I2CD_SCL_LINE_STS))
> +			goto reset_out;
> +	/* Bus error. */
> +	} else {
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting recovery\n",
> +			command);
> +
> +		reinit_completion(&bus->cmd_complete);
> +		writel(ASPEED_I2CD_BUS_RECOVER_CMD,
> +		       bus->base + ASPEED_I2C_CMD_REG);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left = wait_for_completion_timeout(
> +				&bus->cmd_complete, bus->adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left == 0)
> +			goto reset_out;
> +		else if (bus->cmd_err)
> +			goto reset_out;
> +		/* Recovery failed. */
> +		else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +			   ASPEED_I2CD_SDA_LINE_STS))
> +			goto reset_out;
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +
> +reset_out:
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return aspeed_i2c_reset(bus);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static void aspeed_i2c_do_start(struct aspeed_i2c_bus *bus)
> +{
> +	u32 command = ASPEED_I2CD_M_START_CMD | ASPEED_I2CD_M_TX_CMD;
> +	struct i2c_msg *msg = &bus->msgs[bus->msgs_index];
> +	u8 slave_addr = msg->addr << 1;
> +
> +	bus->master_state = ASPEED_I2C_MASTER_START;
> +	bus->buf_index = 0;
> +
> +	if (msg->flags & I2C_M_RD) {
> +		slave_addr |= 1;
> +		command |= ASPEED_I2CD_M_RX_CMD;
> +		/* Need to let the hardware know to NACK after RX. */
> +		if (msg->len == 1 && !(msg->flags & I2C_M_RECV_LEN))
> +			command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +	}
> +
> +	writel(slave_addr, bus->base + ASPEED_I2C_BYTE_BUF_REG);
> +	writel(command, bus->base + ASPEED_I2C_CMD_REG);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus)
> +{
> +	bus->master_state = ASPEED_I2C_MASTER_STOP;
> +	writel(ASPEED_I2CD_M_STOP_CMD, bus->base + ASPEED_I2C_CMD_REG);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static void aspeed_i2c_next_msg_or_stop(struct aspeed_i2c_bus *bus)
> +{
> +	if (bus->msgs_index + 1 < bus->msgs_count) {
> +		bus->msgs_index++;
> +		aspeed_i2c_do_start(bus);
> +	} else {
> +		aspeed_i2c_do_stop(bus);
> +	}
> +}
> +
> +static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> +{
> +	u32 irq_status, status_ack = 0, command = 0;
> +	struct i2c_msg *msg;
> +	u8 recv_byte;
> +
> +	spin_lock(&bus->lock);
> +	irq_status = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupt bits. */
> +	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		status_ack |= ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
> +		goto out_complete;
> +	}
> +
> +	/*
> +	 * We encountered an interrupt that reports an error: the hardware
> +	 * should clear the command queue effectively taking us back to the
> +	 * INACTIVE state.
> +	 */
> +	if (irq_status & ASPEED_I2CD_INTR_ERROR) {
> +		dev_dbg(bus->dev, "received error interrupt: 0x%08x",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	}
> +
> +	/* We are in an invalid state; reset bus to a known state. */
> +	if (!bus->msgs && bus->master_state != ASPEED_I2C_MASTER_STOP) {
> +		dev_err(bus->dev, "bus in unknown state",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		aspeed_i2c_do_stop(bus);
> +		goto out_no_complete;
> +	}
> +	msg = &bus->msgs[bus->msgs_index];
> +
> +	/*
> +	 * START is a special case because we still have to handle a subsequent
> +	 * TX or RX immediately after we handle it, so we handle it here and
> +	 * then update the state and handle the new state below.
> +	 */
> +	if (bus->master_state == ASPEED_I2C_MASTER_START) {
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +			dev_dbg(bus->dev,
> +				"no slave present at %02x", msg->addr);

I would make that a dev_devel, so that it doesn't fill up the logs in
dynamic debug mode, this is a rather common occurrence.

> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		if (msg->len == 0) { /* SMBUS_QUICK */
> +			aspeed_i2c_do_stop(bus);
> +			goto out_no_complete;
> +		}
> +		if (msg->flags & I2C_M_RD)
> +			bus->master_state = ASPEED_I2C_MASTER_RX_FIRST;
> +		else
> +			bus->master_state = ASPEED_I2C_MASTER_TX_FIRST;
> +	}
> +
> +	switch (bus->master_state) {
> +	case ASPEED_I2C_MASTER_TX:
> +		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK)) {
> +			dev_dbg(bus->dev, "slave NACKed TX");
> +			status_ack |= ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		} else if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> +			dev_err(bus->dev, "slave failed to ACK TX");
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_TX_ACK;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_TX_FIRST:
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_TX;
> +			writel(msg->buf[bus->buf_index++],
> +			       bus->base + ASPEED_I2C_BYTE_BUF_REG);
> +			writel(ASPEED_I2CD_M_TX_CMD,
> +			       bus->base + ASPEED_I2C_CMD_REG);
> +		} else {
> +			aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_RX_FIRST:
> +		/* RX may not have completed yet (only address cycle) */
> +		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
> +			goto out_no_complete;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_RX:
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_RX_DONE))) {
> +			dev_err(bus->dev, "master failed to RX");
> +			goto error_and_stop;
> +		}
> +		status_ack |= ASPEED_I2CD_INTR_RX_DONE;
> +
> +		recv_byte = readl(bus->base + ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		msg->buf[bus->buf_index++] = recv_byte;
> +
> +		if (msg->flags & I2C_M_RECV_LEN) {
> +			if (unlikely(recv_byte > I2C_SMBUS_BLOCK_MAX)) {
> +				bus->cmd_err = -EPROTO;
> +				aspeed_i2c_do_stop(bus);
> +				goto out_no_complete;
> +			}
> +			msg->len = recv_byte +
> +					((msg->flags & I2C_CLIENT_PEC) ? 2 : 1);
> +			msg->flags &= ~I2C_M_RECV_LEN;
> +		}
> +
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state = ASPEED_I2C_MASTER_RX;
> +			command = ASPEED_I2CD_M_RX_CMD;
> +			if (bus->buf_index + 1 == msg->len)
> +				command |= ASPEED_I2CD_M_S_RX_CMD_LAST;
> +			writel(command, bus->base + ASPEED_I2C_CMD_REG);
> +		} else {
> +			aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_STOP:
> +		if (unlikely(!(irq_status & ASPEED_I2CD_INTR_NORMAL_STOP))) {
> +			dev_err(bus->dev, "master failed to STOP");
> +			bus->cmd_err = -EIO;
> +			/* Do not STOP as we have already tried. */
> +		} else {
> +			status_ack |= ASPEED_I2CD_INTR_NORMAL_STOP;
> +		}
> +
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	case ASPEED_I2C_MASTER_INACTIVE:
> +		dev_err(bus->dev,
> +			"master received interrupt 0x%08x, but is inactive",
> +			irq_status);
> +		bus->cmd_err = -EIO;
> +		/* Do not STOP as we should be inactive. */
> +		goto out_complete;
> +	default:
> +		WARN(1, "unknown master state\n");
> +		bus->master_state = ASPEED_I2C_MASTER_INACTIVE;
> +		bus->cmd_err = -EIO;
> +		goto out_complete;
> +	}
> +error_and_stop:
> +	bus->cmd_err = -EIO;
> +	aspeed_i2c_do_stop(bus);
> +	goto out_no_complete;
> +out_complete:
> +	complete(&bus->cmd_complete);
> +out_no_complete:
> +	if (irq_status != status_ack)
> +		dev_err(bus->dev,
> +			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
> +			irq_status, status_ack);
> +	spin_unlock(&bus->lock);
> +	return !!irq_status;
> +}
> +
> +static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct aspeed_i2c_bus *bus = dev_id;
> +
> +	if (aspeed_i2c_master_irq(bus))
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +
> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> +				  struct i2c_msg *msgs, int num)
> +{
> +	struct aspeed_i2c_bus *bus = adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->cmd_err = 0;
> +
> +	/* If bus is busy, attempt recovery. We assume a single master
> +	 * environment.
> +	 */
> +	if (readl(bus->base + ASPEED_I2C_CMD_REG) & ASPEED_I2CD_BUS_BUSY_STS) {
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +		ret = aspeed_i2c_recover_bus(bus);
> +		if (ret)
> +			return ret;
> +		spin_lock_irqsave(&bus->lock, flags);

Should you re-clear cmd_err ? The interrupt handler might trigger
it during recovery no ? Or just move the clearing to below.

> +	}
> +
> +	bus->msgs = msgs;
> +	bus->msgs_index = 0;
> +	bus->msgs_count = num;
> +
> +	reinit_completion(&bus->cmd_complete);
> +	aspeed_i2c_do_start(bus);
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	time_left = wait_for_completion_timeout(&bus->cmd_complete,
> +						bus->adap.timeout);
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->msgs = NULL;
> +	if (time_left == 0)
> +		ret = -ETIMEDOUT;
> +	else
> +		ret = bus->cmd_err;
> +	spin_unlock_irqrestore(&bus->lock, flags);

I would make the interrupt handler self-clear msgs and I would copy
cmd_err to a separate field (or ensure it's only set by the interrupt
handler when msgs is non-NULL, by the completion code).

That way you avoid the above lock which is racy, slave activity could
get in there and trigger an error interrupt clobbering cmd_err for
example no ? Or am I missing something... 

> +	/* If nothing went wrong, return number of messages transferred. */
> +	if (ret >= 0)
> +		return bus->msgs_index + 1;
> +	else
> +		return ret;
> +}
> +
> +static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm aspeed_i2c_algo = {
> +	.master_xfer	= aspeed_i2c_master_xfer,
> +	.functionality	= aspeed_i2c_functionality,
> +};
> +
> +static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
> +{
> +	u32 base_clk, clk_high, clk_low, tmp;
> +
> +	/*
> +	 * The actual clock frequency of SCL is:
> +	 *	SCL_freq = APB_freq / (base_freq * (SCL_high + SCL_low))
> +	 *		 = APB_freq / divisor
> +	 * where base_freq is a programmable clock divider; its value is
> +	 *	base_freq = 1 << base_clk
> +	 * SCL_high is the number of base_freq clock cycles that SCL stays high
> +	 * and SCL_low is the number of base_freq clock cycles that SCL stays
> +	 * low for a period of SCL.
> +	 * The actual register has a minimum SCL_high and SCL_low minimum of 1;
> +	 * thus, they start counting at zero. So
> +	 *	SCL_high = clk_high + 1
> +	 *	SCL_low	 = clk_low + 1
> +	 * Thus,
> +	 *	SCL_freq = APB_freq /
> +	 *		((1 << base_clk) * (clk_high + 1 + clk_low + 1))
> +	 * The documentation recommends clk_high >= 8 and clk_low >= 7 when
> +	 * possible; this last constraint gives us the following solution:
> +	 */
> +	base_clk = divisor > 33 ? ilog2((divisor - 1) / 32) + 1 : 0;
> +	tmp = divisor / (1 << base_clk);
> +	clk_high = tmp / 2 + tmp % 2;
> +	clk_low = tmp - clk_high;
> +
> +	clk_high -= 1;
> +	clk_low -= 1;
> +
> +	return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
> +		& ASPEED_I2CD_TIME_SCL_HIGH_MASK)
> +			| ((clk_low << ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
> +			   & ASPEED_I2CD_TIME_SCL_LOW_MASK)
> +			| (base_clk & ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus,
> +				 struct platform_device *pdev)
> +{
> +	u32 clk_freq, divisor, clk_reg_val;
> +	struct clk *pclk;
> +	int ret;
> +
> +	pclk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(pclk)) {
> +		dev_err(&pdev->dev, "clk_get failed\n");
> +		return PTR_ERR(pclk);
> +	}

I disagree with the pre-condition. I don't think it's safe
to call devm_clk_get() with a lock held anyway.

I don't think you really need the lock here, but if you think
you really need to block against concurrent slave accesses
then you may need a mutex rather than a lock.

If you want to keep the lock, then do the clk_get/get_rate
at probe time instead and cache the speed. I would do the same with the
property.

Also you should probably call clk_enable() somewhere for when we add
proper clock control, but that's not urgent, we can do that when we get
to that point in a separate patch...

> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "bus-frequency", &clk_freq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not read bus-frequency property\n");
> +		clk_freq = 100000;
> +	}
> +	divisor = clk_get_rate(pclk) / clk_freq;
> +	/* We just need the clock rate, we don't actually use the clk object. */
> +	devm_clk_put(&pdev->dev, pclk);
> +
> +	clk_reg_val = aspeed_i2c_get_clk_reg_val(divisor);
> +	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
> +	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base + ASPEED_I2C_AC_TIMING_REG2);
> +
> +	return 0;
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
> +			     struct platform_device *pdev)
> +{
> +	u32 fun_ctrl_reg = ASPEED_I2CD_MASTER_EN;
> +	int ret;
> +
> +	/* Disable everything. */
> +	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +	ret = aspeed_i2c_init_clk(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!of_property_read_bool(pdev->dev.of_node, "multi-master"))
> +		fun_ctrl_reg |= ASPEED_I2CD_MULTI_MASTER_DIS;
> +
> +	/* Enable Master Mode */
> +	writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) | fun_ctrl_reg,
> +	       bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +	/* Set interrupt generation of I2C controller */
> +	writel(ASPEED_I2CD_INTR_ALL, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
> +{
> +	struct platform_device *pdev = to_platform_device(bus->dev);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	/* Disable and quiesce interrupts. */
> +	reinit_completion(&bus->cmd_complete);
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);

See comments below in probe() about cleaning interrupts. They apply
to this as well.

> +	spin_unlock_irqrestore(&bus->lock, flags);
> +	/*
> +	 * We need to make sure that there are no interrupts that fired just
> +	 * before we grabbed the lock; if that did not happen, then we are going
> +	 * to timeout and that is okay.
> +	 */
> +	wait_for_completion_timeout(&bus->cmd_complete, bus->adap.timeout);
> +	spin_lock_irqsave(&bus->lock, flags);

This isn't necessary. Just clear the interrupt status register, that
way even if an interrupt fired, the handler won't "see" anything and
will return. An occasional such spurious interupt is a non-issue.

> +	ret = aspeed_i2c_init(bus, pdev);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
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
> +	strlcpy(bus->adap.name, pdev->name, sizeof(bus->adap.name));
> +
> +	bus->dev = &pdev->dev;
> +
> +	/*
> +	 * No need to quiesce interrupts because there is no interrupt handler
> +	 * installed.
> +	 */
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);

There seem to be a mismatch between comment and code ;-) You do need to
quiesce them before you register the handler in case some stale bit
is set causing an interrupt before you are ready to handle them.

I would suggest adding

       writel(0xffffffff, bus->base + ASPEED_I2C_INTR_STS_REG);

As well to "ack" anything that was left pending, ie, remove stale
conditions. (You may want to do that in the reset code as well).

There is no guarantee you won't still take an interrupt, it could
already be on its way to the CPU before it's masked, but at least
the interrupt handler will not see anything in the status reg.

The above also applies to your reset code.

> +	/*
> +	 * bus.lock does not need to be held because the interrupt handler has
> +	 * not been enabled yet.
> +	 */
> +	ret = aspeed_i2c_init(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	bus->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	ret = devm_request_irq(&pdev->dev, bus->irq, aspeed_i2c_bus_irq,
> +			       0, dev_name(&pdev->dev), bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_add_adapter(&bus->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, bus);
> +
> +	dev_info(bus->dev, "i2c bus %d registered, irq %d\n",
> +		 bus->adap.nr, bus->irq);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_remove_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus = platform_get_drvdata(pdev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	/* Disable everything. */
> +	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	i2c_del_adapter(&bus->adap);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_i2c_bus_of_table[] = {
> +	{ .compatible = "aspeed,ast2400-i2c-bus", },
> +	{ .compatible = "aspeed,ast2500-i2c-bus", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
> +
> +static struct platform_driver aspeed_i2c_bus_driver = {
> +	.probe		= aspeed_i2c_probe_bus,
> +	.remove		= aspeed_i2c_remove_bus,
> +	.driver		= {
> +		.name		= "aspeed-i2c-bus",
> +		.of_match_table	= aspeed_i2c_bus_of_table,
> +	},
> +};
> +module_platform_driver(aspeed_i2c_bus_driver);
> +
> +MODULE_AUTHOR("Brendan Higgins <brendanhiggins@google.com>");
> +MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
> +MODULE_LICENSE("GPL v2");
