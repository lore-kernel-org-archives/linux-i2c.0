From: Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH v10 4/5] i2c: aspeed: added driver for Aspeed I2C
Date: Mon, 05 Jun 2017 14:32:21 +0930
Message-ID: <1496638941.8159.20.camel@aj.id.au>
References: <20170603012952.2192-1-brendanhiggins@google.com>
         <20170603012952.2192-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-OF20X2RuIP+loAZW5poJ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55949 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751274AbdFEFCc (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Jun 2017 01:02:32 -0400
In-Reply-To: <20170603012952.2192-5-brendanhiggins@google.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, joel@jms.id.au, vz@mleia.com, mouse@mayc.ru, clg@kaod.org, benh@kernel.crashing.org, ryan_chen@aspeedtech.com
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--=-OF20X2RuIP+loAZW5poJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2017-06-02 at 18:29 -0700, Brendan Higgins wrote:
> Added initial master support for Aspeed I2C controller. Supports
> fourteen busses present in AST24XX and AST25XX BMC SoCs by Aspeed.
>=20
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

I exercised this patch on an AST2500-based machine. The results were
good, and the implementation copes fine with a workload that causes an
oops in our (older, unrelated) out-of-tree bus driver.

Tested-by: Andrew Jeffery <andrew@aj.id.au>

> ---
> Changes for v2:
> =C2=A0 - Added single module_init (multiple was breaking some builds).
> Changes for v3:
> =C2=A0 - Removed "bus" device tree param; now extracted from bus address
> offset
> Changes for v4:
> =C2=A0 - I2C adapter number is now generated dynamically unless specified
> in alias.
> Changes for v5:
> =C2=A0 - Removed irq_chip used to multiplex IRQ and replaced it with
> dummy_irq_chip
> =C2=A0=C2=A0=C2=A0=C2=A0along with some other IRQ cleanup.
> =C2=A0 - Addressed comments from Cedric, and Vladimir, mostly stylistic
> things and
> =C2=A0=C2=A0=C2=A0=C2=A0using devm managed resources.
> =C2=A0 - Increased max clock frequency before the bus is put in HighSpeed
> mode, as
> =C2=A0=C2=A0=C2=A0=C2=A0per Kachalov's comment.
> Changes for v6:
> =C2=A0 - No longer arbitrarily restrict bus to be slave xor master.
> =C2=A0 - Pulled out "struct aspeed_i2c_controller" as a interrupt
> controller.
> =C2=A0 - Pulled out slave support into its own commit.
> =C2=A0 - Rewrote code that sets clock divider register because the
> original version
> =C2=A0=C2=A0=C2=A0=C2=A0set it incorrectly.
> =C2=A0 - Rewrote the aspeed_i2c_master_irq handler because the old method
> of
> =C2=A0=C2=A0=C2=A0=C2=A0completing a completion in between restarts was t=
oo slow causing
> devices to
> =C2=A0=C2=A0=C2=A0=C2=A0misbehave.
> =C2=A0 - Added support for I2C_M_RECV_LEN which I had incorrectly said wa=
s
> supported
> =C2=A0=C2=A0=C2=A0=C2=A0before.
> =C2=A0 - Addressed other comments from Vladimir.
> Changes for v7:
> =C2=A0 - Changed clock-frequency to bus-frequency
> =C2=A0 - Made some fixes to clock divider code
> =C2=A0 - Added hardware reset function
> =C2=A0 - Marked functions that need to be called with the lock held as
> "unlocked"
> =C2=A0 - Did a bunch of clean up
> Changes for v8:
> =C2=A0 - ACK IRQ status bits before doing anything else
> =C2=A0 - Added multi-master device tree property
> =C2=A0 - Do not send STOP commands after interrupt errors
> =C2=A0 - Fix SMBUS_QUICK emulation handling
> =C2=A0 - Removed highspeed clock code (I will do it in a later patch set)
> =C2=A0 - Use the platform_device name for the adapter name
> =C2=A0 - Reset for all failed recoveries
> =C2=A0 - Removed the "__" prefix from all of the non-thread safe function=
s
> Changes for v9:
> =C2=A0 - No longer debug log after every address NACK
> =C2=A0 - Clear errors after reset
> =C2=A0 - No longer access clock while holding lock
> =C2=A0 - Ack all interrupts durring bus reset and initialization
> Changes for v10:
> =C2=A0 - Added master_xfer_result field to struct aspeed_i2c_bus
> ---
> =C2=A0drivers/i2c/busses/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A010 +
> =C2=A0drivers/i2c/busses/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A01 +
> =C2=A0drivers/i2c/busses/i2c-aspeed.c | 681
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 692 insertions(+)
> =C2=A0create mode 100644 drivers/i2c/busses/i2c-aspeed.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 144cbadc7c72..280f84a0d7d1 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -326,6 +326,16 @@ config I2C_POWERMAC
> =C2=A0
> =C2=A0comment "I2C system bus drivers (mostly embedded / system-on-chip)"
> =C2=A0
> +config I2C_ASPEED
> +	tristate "Aspeed I2C Controller"
> +	depends on ARCH_ASPEED
> +	help
> +	=C2=A0=C2=A0If you say yes to this option, support will be included
> for the
> +	=C2=A0=C2=A0Aspeed I2C controller.
> +
> +	=C2=A0=C2=A0This driver can also be built as a module.=C2=A0=C2=A0If so=
, the
> module
> +	=C2=A0=C2=A0will be called i2c-aspeed.
> +
> =C2=A0config I2C_AT91
> =C2=A0	tristate "Atmel AT91 I2C Two-Wire interface (TWI)"
> =C2=A0	depends on ARCH_AT91
> diff --git a/drivers/i2c/busses/Makefile
> b/drivers/i2c/busses/Makefile
> index 30b60855fbcd..e84604b9bf3b 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_I2C_HYDRA)		+=3D i2c-
> hydra.o
> =C2=A0obj-$(CONFIG_I2C_POWERMAC)	+=3D i2c-powermac.o
> =C2=A0
> =C2=A0# Embedded system I2C/SMBus host controller drivers
> +obj-$(CONFIG_I2C_ASPEED)	+=3D i2c-aspeed.o
> =C2=A0obj-$(CONFIG_I2C_AT91)		+=3D i2c-at91.o
> =C2=A0obj-$(CONFIG_I2C_AU1550)	+=3D i2c-au1550.o
> =C2=A0obj-$(CONFIG_I2C_AXXIA)		+=3D i2c-axxia.o
> diff --git a/drivers/i2c/busses/i2c-aspeed.c
> b/drivers/i2c/busses/i2c-aspeed.c
> new file mode 100644
> index 000000000000..a04021e3b3ab
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -0,0 +1,681 @@
> +/*
> + *=C2=A0=C2=A0Aspeed 24XX/25XX I2C Controller.
> + *
> + *=C2=A0=C2=A0Copyright (C) 2012-2017 ASPEED Technology Inc.
> + *=C2=A0=C2=A0Copyright 2017 IBM Corporation
> + *=C2=A0=C2=A0Copyright 2017 Google, Inc.
> + *
> + *=C2=A0=C2=A0This program is free software; you can redistribute it and=
/or
> modify
> + *=C2=A0=C2=A0it under the terms of the GNU General Public License versi=
on 2
> as
> + *=C2=A0=C2=A0published by the Free Software Foundation.
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
> +/* 0x00 : I2C Interrupt Status Register=C2=A0=C2=A0*/
> +/* 0x08 : I2C Interrupt Target Assignment=C2=A0=C2=A0*/
> +
> +/* Device Register Definition */
> +/* 0x00 : I2CD Function Control Register=C2=A0=C2=A0*/
> +#define ASPEED_I2CD_MULTI_MASTER_DIS			BIT(15)
> +#define ASPEED_I2CD_SDA_DRIVE_1T_EN			BIT(8)
> +#define ASPEED_I2CD_M_SDA_DRIVE_1T_EN			BIT(7)
> +#define ASPEED_I2CD_M_HIGH_SPEED_EN			BIT(6)
> +#define ASPEED_I2CD_MASTER_EN				BIT(0)
> +
> +/* 0x04 : I2CD Clock and AC Timing Control Register #1 */
> +#define ASPEED_I2CD_TIME_SCL_HIGH_SHIFT			16
> +#define ASPEED_I2CD_TIME_SCL_HIGH_MASK			GENMAS
> K(19, 16)
> +#define ASPEED_I2CD_TIME_SCL_LOW_SHIFT			12
> +#define ASPEED_I2CD_TIME_SCL_LOW_MASK			GENMASK
> (15, 12)
> +#define ASPEED_I2CD_TIME_BASE_DIVISOR_MASK		GENMASK(3,
> 0)
> +#define ASPEED_I2CD_TIME_SCL_REG_MAX			GENMASK(
> 3, 0)
> +/* 0x08 : I2CD Clock and AC Timing Control Register #2 */
> +#define ASPEED_NO_TIMEOUT_CTRL				0
> +
> +/* 0x0c : I2CD Interrupt Control Register &
> + * 0x10 : I2CD Interrupt Status Register
> + *
> + * These share bit definitions, so use the same values for the
> enable &
> + * status bits.
> + */
> +#define ASPEED_I2CD_INTR_SDA_DL_TIMEOUT			BIT(1
> 4)
> +#define ASPEED_I2CD_INTR_BUS_RECOVER_DONE		BIT(13)
> +#define ASPEED_I2CD_INTR_SCL_TIMEOUT			BIT(6)
> +#define ASPEED_I2CD_INTR_ABNORMAL			BIT(5)
> +#define ASPEED_I2CD_INTR_NORMAL_STOP			BIT(4)
> +#define ASPEED_I2CD_INTR_ARBIT_LOSS			BIT(3)
> +#define ASPEED_I2CD_INTR_RX_DONE			BIT(2)
> +#define ASPEED_I2CD_INTR_TX_NAK				BIT(1
> )
> +#define ASPEED_I2CD_INTR_TX_ACK				BIT(0
> )
> +#define ASPEED_I2CD_INTR_ERROR				=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		(ASPEED_I2CD_INTR_ARBIT_LOSS |		=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_ABNORMAL |			=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_SCL_TIMEOUT |		=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_SDA_DL_TIMEOUT)
> +#define ASPEED_I2CD_INTR_ALL					=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		(ASPEED_I2CD_INTR_SDA_DL_TIMEOUT |		=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_BUS_RECOVER_DONE |		=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_SCL_TIMEOUT |		=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_ABNORMAL |			=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_NORMAL_STOP |		=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_ARBIT_LOSS |		=09
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_RX_DONE |			=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_TX_NAK |			=09
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +		=C2=A0ASPEED_I2CD_INTR_TX_ACK)
> +
> +/* 0x14 : I2CD Command/Status Register=C2=A0=C2=A0=C2=A0*/
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
> +#define ASPEED_I2CD_M_START_CMD				BIT(0
> )
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
> +	unsigned long			parent_clk_frequency;
> +	u32				bus_frequency;
> +	/* Transaction state. */
> +	enum aspeed_i2c_master_state	master_state;
> +	struct i2c_msg			*msgs;
> +	size_t				buf_index;
> +	size_t				msgs_index;
> +	size_t				msgs_count;
> +	bool				send_stop;
> +	int				cmd_err;
> +	/* Protected only by i2c_lock_bus */
> +	int				master_xfer_result;
> +};
> +
> +static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus);
> +
> +static int aspeed_i2c_recover_bus(struct aspeed_i2c_bus *bus)
> +{
> +	unsigned long time_left, flags;
> +	int ret =3D 0;
> +	u32 command;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	command =3D readl(bus->base + ASPEED_I2C_CMD_REG);
> +
> +	if (command & ASPEED_I2CD_SDA_LINE_STS) {
> +		/* Bus is idle: no recovery needed. */
> +		if (command & ASPEED_I2CD_SCL_LINE_STS)
> +			goto out;
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting
> recovery\n",
> +			command);
> +
> +		reinit_completion(&bus->cmd_complete);
> +		writel(ASPEED_I2CD_M_STOP_CMD, bus->base +
> ASPEED_I2C_CMD_REG);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left =3D wait_for_completion_timeout(
> +				&bus->cmd_complete, bus-
> >adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left =3D=3D 0)
> +			goto reset_out;
> +		else if (bus->cmd_err)
> +			goto reset_out;
> +		/* Recovery failed. */
> +		else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +			=C2=A0=C2=A0=C2=A0ASPEED_I2CD_SCL_LINE_STS))
> +			goto reset_out;
> +	/* Bus error. */
> +	} else {
> +		dev_dbg(bus->dev, "bus hung (state %x), attempting
> recovery\n",
> +			command);
> +
> +		reinit_completion(&bus->cmd_complete);
> +		writel(ASPEED_I2CD_BUS_RECOVER_CMD,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus->base + ASPEED_I2C_CMD_R=
EG);
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +
> +		time_left =3D wait_for_completion_timeout(
> +				&bus->cmd_complete, bus-
> >adap.timeout);
> +
> +		spin_lock_irqsave(&bus->lock, flags);
> +		if (time_left =3D=3D 0)
> +			goto reset_out;
> +		else if (bus->cmd_err)
> +			goto reset_out;
> +		/* Recovery failed. */
> +		else if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
> +			=C2=A0=C2=A0=C2=A0ASPEED_I2CD_SDA_LINE_STS))
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
> +	u32 command =3D ASPEED_I2CD_M_START_CMD |
> ASPEED_I2CD_M_TX_CMD;
> +	struct i2c_msg *msg =3D &bus->msgs[bus->msgs_index];
> +	u8 slave_addr =3D msg->addr << 1;
> +
> +	bus->master_state =3D ASPEED_I2C_MASTER_START;
> +	bus->buf_index =3D 0;
> +
> +	if (msg->flags & I2C_M_RD) {
> +		slave_addr |=3D 1;
> +		command |=3D ASPEED_I2CD_M_RX_CMD;
> +		/* Need to let the hardware know to NACK after RX.
> */
> +		if (msg->len =3D=3D 1 && !(msg->flags & I2C_M_RECV_LEN))
> +			command |=3D ASPEED_I2CD_M_S_RX_CMD_LAST;
> +	}
> +
> +	writel(slave_addr, bus->base + ASPEED_I2C_BYTE_BUF_REG);
> +	writel(command, bus->base + ASPEED_I2C_CMD_REG);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static void aspeed_i2c_do_stop(struct aspeed_i2c_bus *bus)
> +{
> +	bus->master_state =3D ASPEED_I2C_MASTER_STOP;
> +	writel(ASPEED_I2CD_M_STOP_CMD, bus->base +
> ASPEED_I2C_CMD_REG);
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
> +	u32 irq_status, status_ack =3D 0, command =3D 0;
> +	struct i2c_msg *msg;
> +	u8 recv_byte;
> +
> +	spin_lock(&bus->lock);
> +	irq_status =3D readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupt bits. */
> +	writel(irq_status, bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	if (irq_status & ASPEED_I2CD_INTR_BUS_RECOVER_DONE) {
> +		bus->master_state =3D ASPEED_I2C_MASTER_INACTIVE;
> +		status_ack |=3D ASPEED_I2CD_INTR_BUS_RECOVER_DONE;
> +		goto out_complete;
> +	}
> +
> +	/*
> +	=C2=A0* We encountered an interrupt that reports an error: the
> hardware
> +	=C2=A0* should clear the command queue effectively taking us back
> to the
> +	=C2=A0* INACTIVE state.
> +	=C2=A0*/
> +	if (irq_status & ASPEED_I2CD_INTR_ERROR) {
> +		dev_dbg(bus->dev, "received error interrupt:
> 0x%08x",
> +			irq_status);
> +		bus->cmd_err =3D -EIO;
> +		bus->master_state =3D ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	}
> +
> +	/* We are in an invalid state; reset bus to a known state.
> */
> +	if (!bus->msgs && bus->master_state !=3D
> ASPEED_I2C_MASTER_STOP) {
> +		dev_err(bus->dev, "bus in unknown state");
> +		bus->cmd_err =3D -EIO;
> +		aspeed_i2c_do_stop(bus);
> +		goto out_no_complete;
> +	}
> +	msg =3D &bus->msgs[bus->msgs_index];
> +
> +	/*
> +	=C2=A0* START is a special case because we still have to handle a
> subsequent
> +	=C2=A0* TX or RX immediately after we handle it, so we handle it
> here and
> +	=C2=A0* then update the state and handle the new state below.
> +	=C2=A0*/
> +	if (bus->master_state =3D=3D ASPEED_I2C_MASTER_START) {
> +		if (unlikely(!(irq_status &
> ASPEED_I2CD_INTR_TX_ACK))) {
> +			pr_devel("no slave present at %02x", msg-
> >addr);
> +			status_ack |=3D ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		}
> +		status_ack |=3D ASPEED_I2CD_INTR_TX_ACK;
> +		if (msg->len =3D=3D 0) { /* SMBUS_QUICK */
> +			aspeed_i2c_do_stop(bus);
> +			goto out_no_complete;
> +		}
> +		if (msg->flags & I2C_M_RD)
> +			bus->master_state =3D
> ASPEED_I2C_MASTER_RX_FIRST;
> +		else
> +			bus->master_state =3D
> ASPEED_I2C_MASTER_TX_FIRST;
> +	}
> +
> +	switch (bus->master_state) {
> +	case ASPEED_I2C_MASTER_TX:
> +		if (unlikely(irq_status & ASPEED_I2CD_INTR_TX_NAK))
> {
> +			dev_dbg(bus->dev, "slave NACKed TX");
> +			status_ack |=3D ASPEED_I2CD_INTR_TX_NAK;
> +			goto error_and_stop;
> +		} else if (unlikely(!(irq_status &
> ASPEED_I2CD_INTR_TX_ACK))) {
> +			dev_err(bus->dev, "slave failed to ACK TX");
> +			goto error_and_stop;
> +		}
> +		status_ack |=3D ASPEED_I2CD_INTR_TX_ACK;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_TX_FIRST:
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state =3D ASPEED_I2C_MASTER_TX;
> +			writel(msg->buf[bus->buf_index++],
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus->base + ASPEED_I2C_BYTE=
_BUF_REG);
> +			writel(ASPEED_I2CD_M_TX_CMD,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus->base + ASPEED_I2C_CMD_=
REG);
> +		} else {
> +			aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_RX_FIRST:
> +		/* RX may not have completed yet (only address
> cycle) */
> +		if (!(irq_status & ASPEED_I2CD_INTR_RX_DONE))
> +			goto out_no_complete;
> +		/* fallthrough intended */
> +	case ASPEED_I2C_MASTER_RX:
> +		if (unlikely(!(irq_status &
> ASPEED_I2CD_INTR_RX_DONE))) {
> +			dev_err(bus->dev, "master failed to RX");
> +			goto error_and_stop;
> +		}
> +		status_ack |=3D ASPEED_I2CD_INTR_RX_DONE;
> +
> +		recv_byte =3D readl(bus->base +
> ASPEED_I2C_BYTE_BUF_REG) >> 8;
> +		msg->buf[bus->buf_index++] =3D recv_byte;
> +
> +		if (msg->flags & I2C_M_RECV_LEN) {
> +			if (unlikely(recv_byte >
> I2C_SMBUS_BLOCK_MAX)) {
> +				bus->cmd_err =3D -EPROTO;
> +				aspeed_i2c_do_stop(bus);
> +				goto out_no_complete;
> +			}
> +			msg->len =3D recv_byte +
> +					((msg->flags &
> I2C_CLIENT_PEC) ? 2 : 1);
> +			msg->flags &=3D ~I2C_M_RECV_LEN;
> +		}
> +
> +		if (bus->buf_index < msg->len) {
> +			bus->master_state =3D ASPEED_I2C_MASTER_RX;
> +			command =3D ASPEED_I2CD_M_RX_CMD;
> +			if (bus->buf_index + 1 =3D=3D msg->len)
> +				command |=3D
> ASPEED_I2CD_M_S_RX_CMD_LAST;
> +			writel(command, bus->base +
> ASPEED_I2C_CMD_REG);
> +		} else {
> +			aspeed_i2c_next_msg_or_stop(bus);
> +		}
> +		goto out_no_complete;
> +	case ASPEED_I2C_MASTER_STOP:
> +		if (unlikely(!(irq_status &
> ASPEED_I2CD_INTR_NORMAL_STOP))) {
> +			dev_err(bus->dev, "master failed to STOP");
> +			bus->cmd_err =3D -EIO;
> +			/* Do not STOP as we have already tried. */
> +		} else {
> +			status_ack |=3D ASPEED_I2CD_INTR_NORMAL_STOP;
> +		}
> +
> +		bus->master_state =3D ASPEED_I2C_MASTER_INACTIVE;
> +		goto out_complete;
> +	case ASPEED_I2C_MASTER_INACTIVE:
> +		dev_err(bus->dev,
> +			"master received interrupt 0x%08x, but is
> inactive",
> +			irq_status);
> +		bus->cmd_err =3D -EIO;
> +		/* Do not STOP as we should be inactive. */
> +		goto out_complete;
> +	default:
> +		WARN(1, "unknown master state\n");
> +		bus->master_state =3D ASPEED_I2C_MASTER_INACTIVE;
> +		bus->cmd_err =3D -EIO;
> +		goto out_complete;
> +	}
> +error_and_stop:
> +	bus->cmd_err =3D -EIO;
> +	aspeed_i2c_do_stop(bus);
> +	goto out_no_complete;
> +out_complete:
> +	bus->msgs =3D NULL;
> +	if (bus->cmd_err)
> +		bus->master_xfer_result =3D bus->cmd_err;
> +	else
> +		bus->master_xfer_result =3D bus->msgs_index + 1;
> +	complete(&bus->cmd_complete);
> +out_no_complete:
> +	if (irq_status !=3D status_ack)
> +		dev_err(bus->dev,
> +			"irq handled !=3D irq. expected 0x%08x, but
> was 0x%08x\n",
> +			irq_status, status_ack);
> +	spin_unlock(&bus->lock);
> +	return !!irq_status;
> +}
> +
> +static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
> +{
> +	struct aspeed_i2c_bus *bus =3D dev_id;
> +
> +	if (aspeed_i2c_master_irq(bus))
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +
> +static int aspeed_i2c_master_xfer(struct i2c_adapter *adap,
> +				=C2=A0=C2=A0struct i2c_msg *msgs, int num)
> +{
> +	struct aspeed_i2c_bus *bus =3D adap->algo_data;
> +	unsigned long time_left, flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +	bus->cmd_err =3D 0;
> +
> +	/* If bus is busy, attempt recovery. We assume a single
> master
> +	=C2=A0* environment.
> +	=C2=A0*/
> +	if (readl(bus->base + ASPEED_I2C_CMD_REG) &
> ASPEED_I2CD_BUS_BUSY_STS) {
> +		spin_unlock_irqrestore(&bus->lock, flags);
> +		ret =3D aspeed_i2c_recover_bus(bus);
> +		if (ret)
> +			return ret;
> +		spin_lock_irqsave(&bus->lock, flags);
> +	}
> +
> +	bus->cmd_err =3D 0;
> +	bus->msgs =3D msgs;
> +	bus->msgs_index =3D 0;
> +	bus->msgs_count =3D num;
> +
> +	reinit_completion(&bus->cmd_complete);
> +	aspeed_i2c_do_start(bus);
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	time_left =3D wait_for_completion_timeout(&bus->cmd_complete,
> +						bus->adap.timeout);
> +
> +	if (time_left =3D=3D 0)
> +		return -ETIMEDOUT;
> +	else
> +		return bus->master_xfer_result;
> +}
> +
> +static u32 aspeed_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> I2C_FUNC_SMBUS_BLOCK_DATA;
> +}
> +
> +static const struct i2c_algorithm aspeed_i2c_algo =3D {
> +	.master_xfer	=3D aspeed_i2c_master_xfer,
> +	.functionality	=3D aspeed_i2c_functionality,
> +};
> +
> +static u32 aspeed_i2c_get_clk_reg_val(u32 divisor)
> +{
> +	u32 base_clk, clk_high, clk_low, tmp;
> +
> +	/*
> +	=C2=A0* The actual clock frequency of SCL is:
> +	=C2=A0*	SCL_freq =3D APB_freq / (base_freq * (SCL_high +
> SCL_low))
> +	=C2=A0*		=C2=A0=3D APB_freq / divisor
> +	=C2=A0* where base_freq is a programmable clock divider; its
> value is
> +	=C2=A0*	base_freq =3D 1 << base_clk
> +	=C2=A0* SCL_high is the number of base_freq clock cycles that SCL
> stays high
> +	=C2=A0* and SCL_low is the number of base_freq clock cycles that
> SCL stays
> +	=C2=A0* low for a period of SCL.
> +	=C2=A0* The actual register has a minimum SCL_high and SCL_low
> minimum of 1;
> +	=C2=A0* thus, they start counting at zero. So
> +	=C2=A0*	SCL_high =3D clk_high + 1
> +	=C2=A0*	SCL_low	=C2=A0=3D clk_low + 1
> +	=C2=A0* Thus,
> +	=C2=A0*	SCL_freq =3D APB_freq /
> +	=C2=A0*		((1 << base_clk) * (clk_high + 1 + clk_low
> + 1))
> +	=C2=A0* The documentation recommends clk_high >=3D 8 and clk_low >=3D
> 7 when
> +	=C2=A0* possible; this last constraint gives us the following
> solution:
> +	=C2=A0*/
> +	base_clk =3D divisor > 33 ? ilog2((divisor - 1) / 32) + 1 : 0;
> +	tmp =3D divisor / (1 << base_clk);
> +	clk_high =3D tmp / 2 + tmp % 2;
> +	clk_low =3D tmp - clk_high;
> +
> +	clk_high -=3D 1;
> +	clk_low -=3D 1;
> +
> +	return ((clk_high << ASPEED_I2CD_TIME_SCL_HIGH_SHIFT)
> +		& ASPEED_I2CD_TIME_SCL_HIGH_MASK)
> +			| ((clk_low <<
> ASPEED_I2CD_TIME_SCL_LOW_SHIFT)
> +			=C2=A0=C2=A0=C2=A0& ASPEED_I2CD_TIME_SCL_LOW_MASK)
> +			| (base_clk &
> ASPEED_I2CD_TIME_BASE_DIVISOR_MASK);
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static int aspeed_i2c_init_clk(struct aspeed_i2c_bus *bus)
> +{
> +	u32 divisor, clk_reg_val;
> +
> +	divisor =3D bus->parent_clk_frequency / bus->bus_frequency;
> +	clk_reg_val =3D aspeed_i2c_get_clk_reg_val(divisor);
> +	writel(clk_reg_val, bus->base + ASPEED_I2C_AC_TIMING_REG1);
> +	writel(ASPEED_NO_TIMEOUT_CTRL, bus->base +
> ASPEED_I2C_AC_TIMING_REG2);
> +
> +	return 0;
> +}
> +
> +/* precondition: bus.lock has been acquired. */
> +static int aspeed_i2c_init(struct aspeed_i2c_bus *bus,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_device *pdev)
> +{
> +	u32 fun_ctrl_reg =3D ASPEED_I2CD_MASTER_EN;
> +	int ret;
> +
> +	/* Disable everything. */
> +	writel(0, bus->base + ASPEED_I2C_FUN_CTRL_REG);
> +
> +	ret =3D aspeed_i2c_init_clk(bus);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!of_property_read_bool(pdev->dev.of_node, "multi-
> master"))
> +		fun_ctrl_reg |=3D ASPEED_I2CD_MULTI_MASTER_DIS;
> +
> +	/* Enable Master Mode */
> +	writel(readl(bus->base + ASPEED_I2C_FUN_CTRL_REG) |
> fun_ctrl_reg,
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus->base + ASPEED_I2C_FUN_CT=
RL_REG);
> +
> +	/* Set interrupt generation of I2C controller */
> +	writel(ASPEED_I2CD_INTR_ALL, bus->base +
> ASPEED_I2C_INTR_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)
> +{
> +	struct platform_device *pdev =3D to_platform_device(bus->dev);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	/* Disable and ack all interrupts. */
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +	writel(0xffffffff, bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	ret =3D aspeed_i2c_init(bus, pdev);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int aspeed_i2c_probe_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus;
> +	struct clk *parent_clk;
> +	struct resource *res;
> +	int ret;
> +
> +	bus =3D devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bus->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(bus->base))
> +		return PTR_ERR(bus->base);
> +
> +	parent_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(parent_clk))
> +		return PTR_ERR(parent_clk);
> +	bus->parent_clk_frequency =3D clk_get_rate(parent_clk);
> +	/* We just need the clock rate, we don't actually use the
> clk object. */
> +	devm_clk_put(&pdev->dev, parent_clk);
> +
> +	ret =3D of_property_read_u32(pdev->dev.of_node,
> +				=C2=A0=C2=A0=C2=A0"bus-frequency", &bus-
> >bus_frequency);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Could not read bus-frequency property\n");
> +		bus->bus_frequency =3D 100000;
> +	}
> +
> +	/* Initialize the I2C adapter */
> +	spin_lock_init(&bus->lock);
> +	init_completion(&bus->cmd_complete);
> +	bus->adap.owner =3D THIS_MODULE;
> +	bus->adap.retries =3D 0;
> +	bus->adap.timeout =3D 5 * HZ;
> +	bus->adap.algo =3D &aspeed_i2c_algo;
> +	bus->adap.algo_data =3D bus;
> +	bus->adap.dev.parent =3D &pdev->dev;
> +	bus->adap.dev.of_node =3D pdev->dev.of_node;
> +	strlcpy(bus->adap.name, pdev->name, sizeof(bus->adap.name));
> +
> +	bus->dev =3D &pdev->dev;
> +
> +	/* Clean up any left over interrupt state. */
> +	writel(0, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +	writel(0xffffffff, bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/*
> +	=C2=A0* bus.lock does not need to be held because the interrupt
> handler has
> +	=C2=A0* not been enabled yet.
> +	=C2=A0*/
> +	ret =3D aspeed_i2c_init(bus, pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	bus->irq =3D irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	ret =3D devm_request_irq(&pdev->dev, bus->irq,
> aspeed_i2c_bus_irq,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00, dev_name(&pdev->dev), bu=
s);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D i2c_add_adapter(&bus->adap);
> +	if (ret < 0)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, bus);
> +
> +	dev_info(bus->dev, "i2c bus %d registered, irq %d\n",
> +		=C2=A0bus->adap.nr, bus->irq);
> +
> +	return 0;
> +}
> +
> +static int aspeed_i2c_remove_bus(struct platform_device *pdev)
> +{
> +	struct aspeed_i2c_bus *bus =3D platform_get_drvdata(pdev);
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
> +static const struct of_device_id aspeed_i2c_bus_of_table[] =3D {
> +	{ .compatible =3D "aspeed,ast2400-i2c-bus", },
> +	{ .compatible =3D "aspeed,ast2500-i2c-bus", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_i2c_bus_of_table);
> +
> +static struct platform_driver aspeed_i2c_bus_driver =3D {
> +	.probe		=3D aspeed_i2c_probe_bus,
> +	.remove		=3D aspeed_i2c_remove_bus,
> +	.driver		=3D {
> +		.name		=3D "aspeed-i2c-bus",
> +		.of_match_table	=3D aspeed_i2c_bus_of_table,
> +	},
> +};
> +module_platform_driver(aspeed_i2c_bus_driver);
> +
> +MODULE_AUTHOR("Brendan Higgins <brendanhiggins@google.com>");
> +MODULE_DESCRIPTION("Aspeed I2C Bus Driver");
> +MODULE_LICENSE("GPL v2");
--=-OF20X2RuIP+loAZW5poJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZNOXdAAoJEJ0dnzgO5LT5xAEP/304Z6ARP7Rkg1A0FzJegJPs
4Zs0adb3DPHXrxb0i9wEB2USqRKkDR4ULmYZ6Knis01/xjZA6mUuBef8DSvME1RC
ma55wN9b5CwIuv0RmejQtFQx6ZLpH43htGKHM+viRECU/0V6osgMr9vR/h4tZ55y
fGwCOUyZQhQkQh4lMJG2SyO2Dn0HI+qltmHjzzbrU0jnkPz0gbC6Nn2ve5b5zoLV
QPLNSXeVZRHCQHAGpNuvDx1DWeRpNMdTLyjOnFltTjDteepuell5nBPnfpv4LeYq
3Mxcvt/2mTnEV/dt1R0uvSXayciVwvn+BkzI1jYC4DUZ6ocQ6E96+3QkXjYDn/ph
j49qT3Xd3duQHl/cSwaZEX/wisb8ghH1dU1uTIAtpuDUENl6wQT2tHup+Wc+VkR+
fMRQyuOb1PTFhQQbmXH7uexstodLsmXWxxmNL8EbJ/jiWIZEIA+az75FWV1vda6H
ZLhC1uWmYmSX/ybdC8APOz5wHMFjpNjw7m2/ouPk4UmouqyKi15jAH5P1gZ01vbm
b6HK9yu1pDisH05H7XwDuNYhca51PcPTWf9DLvTaNLBD8KRZux9ToBuXvCiv3gdm
nxWaqBtgN1vj9wv2jAj4bAeAQasUyUJFdig+QaZEtdQexq0b2TRdFuMXT7v7KCih
IoV5WWcokAq+FkkSh5oT
=hUj+
-----END PGP SIGNATURE-----

--=-OF20X2RuIP+loAZW5poJ--
