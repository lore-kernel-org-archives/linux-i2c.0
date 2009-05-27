From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: driver for the Synopsys DesignWare I2C controller
Date: Wed, 27 May 2009 21:23:22 +0200
Message-ID: <63386a3d0905271223k470bb89elbbb566b68c0d7cd7@mail.gmail.com>
References: <1242725005-6431-1-git-send-email-baruch@tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1242725005-6431-1-git-send-email-baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Just some comments since I've been reading a lot of drivers lately...

2009/5/19 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>:
>
> Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> ---
> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
> =A0drivers/i2c/busses/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/i2c/busses/i2c-designware.c | =A0587 +++++++++++++++++++++=
++++++++++++++
> =A03 files changed, 597 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/i2c/busses/i2c-designware.c
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index f1c6ca7..cef1567 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -326,6 +326,15 @@ config I2C_DAVINCI
> =A0 =A0 =A0 =A0 =A0devices such as DaVinci NIC.
> =A0 =A0 =A0 =A0 =A0For details please see http://www.ti.com/davinci
>
> +config I2C_DESIGNWARE
> + =A0 =A0 =A0 tristate "Synopsys DesignWare"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes to this option, support will be incl=
uded for the
> + =A0 =A0 =A0 =A0 Synopsys DesignWare I2C adapter. Only master mode i=
s supported.
> +
> + =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0If so=
, the module
> + =A0 =A0 =A0 =A0 will be called i2c-designware.
> +
> =A0config I2C_GPIO
> =A0 =A0 =A0 =A0tristate "GPIO-based bitbanging I2C"
> =A0 =A0 =A0 =A0depends on GENERIC_GPIO
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index 776acb6..c2be11e 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_I2C_AU1550) =A0 =A0 =A0+=3D i2c-au1550=
=2Eo
> =A0obj-$(CONFIG_I2C_BLACKFIN_TWI) +=3D i2c-bfin-twi.o
> =A0obj-$(CONFIG_I2C_CPM) =A0 =A0 =A0 =A0 =A0+=3D i2c-cpm.o
> =A0obj-$(CONFIG_I2C_DAVINCI) =A0 =A0 =A0+=3D i2c-davinci.o
> +obj-$(CONFIG_I2C_DESIGNWARE) =A0 +=3D i2c-designware.o
> =A0obj-$(CONFIG_I2C_GPIO) =A0 =A0 =A0 =A0 +=3D i2c-gpio.o
> =A0obj-$(CONFIG_I2C_HIGHLANDER) =A0 +=3D i2c-highlander.o
> =A0obj-$(CONFIG_I2C_IBM_IIC) =A0 =A0 =A0+=3D i2c-ibm_iic.o
> diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses=
/i2c-designware.c
> new file mode 100644
> index 0000000..0138fea
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-designware.c
> @@ -0,0 +1,587 @@
> +/*
> + * Synopsys Designware I2C adapter driver (master only).
> + *
> + * Based on the TI DAVINCI I2C adapter driver.
> + *
> + * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2007 MontaVista Software Inc.
> + * Copyright (C) 2009 Provigent Ltd.
> + *
> + * -----------------------------------------------------------------=
-----------
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + * -----------------------------------------------------------------=
-----------
> + *
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/clk.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +/*
> + * Registers offset
> + */
> +#define DW_IC_CON =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> +#define DW_IC_TAR =A0 =A0 =A0 =A0 =A0 =A0 =A00x4
> +#define DW_IC_DATA_CMD =A0 =A0 =A0 =A0 0x10
> +#define DW_IC_SS_SCL_HCNT =A0 =A0 =A00x14
> +#define DW_IC_SS_SCL_LCNT =A0 =A0 =A00x18
> +#define DW_IC_FS_SCL_HCNT =A0 =A0 =A00x1c
> +#define DW_IC_FS_SCL_LCNT =A0 =A0 =A00x20
> +#define DW_IC_INTR_STAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2c
> +#define DW_IC_INTR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x30
> +#define DW_IC_CLR_INTR =A0 =A0 =A0 =A0 0x40
> +#define DW_IC_ENABLE =A0 =A0 =A0 =A0 =A0 0x6c
> +#define DW_IC_STATUS =A0 =A0 =A0 =A0 =A0 0x70
> +#define DW_IC_TXFLR =A0 =A0 =A0 =A0 =A0 =A00x74
> +#define DW_IC_RXFLR =A0 =A0 =A0 =A0 =A0 =A00x78
> +#define DW_IC_COMP_PARAM_1 =A0 =A0 0xf4
> +#define DW_IC_TX_ABRT_SOURCE =A0 0x80
> +
> +#define DW_IC_CON_MASTER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> +#define DW_IC_CON_SPEED_STD =A0 =A0 =A0 =A0 =A0 =A00x2
> +#define DW_IC_CON_SPEED_FAST =A0 =A0 =A0 =A0 =A0 0x4
> +#define DW_IC_CON_10BITADDR_MASTER =A0 =A0 0x10
> +#define DW_IC_CON_RESTART_EN =A0 =A0 =A0 =A0 =A0 0x20
> +#define DW_IC_CON_SLAVE_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40
> +
> +#define DW_IC_INTR_TX_EMPTY =A0 =A00x10
> +#define DW_IC_INTR_TX_ABRT =A0 =A0 0x40
> +#define DW_IC_INTR_STOP_DET =A0 =A00x200
> +
> +#define DW_IC_STATUS_ACTIVITY =A00x1
> +
> +#define DW_IC_ERR_TX_ABRT =A0 =A0 =A00x1
> +
> +/*
> + * status codes
> + */
> +#define STATUS_IDLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> +#define STATUS_WRITE_IN_PROGRESS =A0 =A0 =A0 0x1
> +#define STATUS_READ_IN_PROGRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2
> +
> +/*
> + * hardware abort codes
> + *
> + * only expected abort codes are listed here
> + * refer to the datasheet for the full list

Write here that this is the bit number in register DW_IC_TX_ABRT_SOURCE
that's good to know!

Makes me curious why the rest of the codes are unexpected, usually
error paths handle the unexpected but hey, I can live with degrees
of unexpectedness..

> + */
> +#define ABRT_7B_ADDR_NOACK =A0 =A0 0
> +#define ABRT_10ADDR1_NOACK =A0 =A0 1
> +#define ABRT_10ADDR2_NOACK =A0 =A0 2
> +#define ABRT_TXDATA_NOACK =A0 =A0 =A03
> +#define ABRT_GCALL_NOACK =A0 =A0 =A0 4
> +#define ABRT_GCALL_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A05
> +#define ABRT_SBYTE_ACKDET =A0 =A0 =A07
> +#define ABRT_SBYTE_NORSTRT =A0 =A0 9
> +#define ABRT_10B_RD_NORSTRT =A0 =A010
> +#define ARB_MASTER_DIS =A0 =A0 =A0 =A0 11
> +#define ARB_LOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 12
> +
> +static char *abort_sources[] =3D {
> + =A0 =A0 =A0 [ABRT_7B_ADDR_NOACK] =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "slave address not acknowledged (7bit m=
ode)",
> + =A0 =A0 =A0 [ABRT_10ADDR1_NOACK] =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "first address byte not acknowledged (1=
0bit mode)",
> + =A0 =A0 =A0 [ABRT_10ADDR2_NOACK] =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "second address byte not acknowledged (=
10bit mode)",
> + =A0 =A0 =A0 [ABRT_TXDATA_NOACK] =A0 =A0 =A0 =A0 =A0 =A0 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "data not acknowledged",
> + =A0 =A0 =A0 [ABRT_GCALL_NOACK] =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "no acknowledgement for a general call"=
,
> + =A0 =A0 =A0 [ABRT_GCALL_READ] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "read after general call",
> + =A0 =A0 =A0 [ABRT_SBYTE_ACKDET] =A0 =A0 =A0 =A0 =A0 =A0 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "start byte acknowledged",
> + =A0 =A0 =A0 [ABRT_SBYTE_NORSTRT] =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "trying to send start byte when restart=
 is disabled",
> + =A0 =A0 =A0 [ABRT_10B_RD_NORSTRT] =A0 =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "trying to read when restart is disable=
d (10bit mode)",
> + =A0 =A0 =A0 [ARB_MASTER_DIS] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "trying to use disabled adapter",
> + =A0 =A0 =A0 [ARB_LOST] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "lost arbitration",
> +};
> +
> +struct dw_i2c_dev {
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> + =A0 =A0 =A0 struct completion =A0 =A0 =A0 cmd_complete;
> + =A0 =A0 =A0 struct tasklet_struct =A0 pump_msg;
> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0lock;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clk;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd_err;
> + =A0 =A0 =A0 struct i2c_msg =A0 =A0 =A0 =A0 =A0*msgs;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msgs_num;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_write_i=
dx;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_read_id=
x;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg_err;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0status;
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abort_sourc=
e;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> + =A0 =A0 =A0 struct i2c_adapter =A0 =A0 =A0adapter;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tx_fifo_depth;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0rx_fifo_depth;
> +};
> +
> +/*
> + * This functions configures I2C and enables I2C.
> + * This function is called during I2C init function.
> + */
> +static int i2c_dw_init(struct dw_i2c_dev *dev)

Can this be tagged with __init?

> +{
> + =A0 =A0 =A0 u32 input_clock_khz =3D clk_get_rate(dev->clk) / 1000;
> + =A0 =A0 =A0 u16 ic_con;
> +
> + =A0 =A0 =A0 /* Disable the adapter */
> + =A0 =A0 =A0 writeb(0, dev->base + DW_IC_ENABLE);
> +
> + =A0 =A0 =A0 /* set standard and fast speed deviders for high/low pe=
riods */
> + =A0 =A0 =A0 writew((input_clock_khz * 40 / 10000)+1, /* std speed h=
igh, 4us */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->base + DW_IC_SS_SC=
L_HCNT);
> + =A0 =A0 =A0 writew((input_clock_khz * 47 / 10000)+1, /* std speed l=
ow, 4.7us */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->base + DW_IC_SS_SC=
L_LCNT);
> + =A0 =A0 =A0 writew((input_clock_khz * =A06 / 10000)+1, /* fast spee=
d high, 0.6us */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->base + DW_IC_FS_SC=
L_HCNT);
> + =A0 =A0 =A0 writew((input_clock_khz * 13 / 10000)+1, /* fast speed =
low, 1.3us */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->base + DW_IC_FS_SC=
L_LCNT);
> +
> + =A0 =A0 =A0 /* configure the i2c master */
> + =A0 =A0 =A0 ic_con =3D DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_=
=46AST;
> + =A0 =A0 =A0 writew(ic_con, dev->base + DW_IC_CON);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Waiting for bus not busy
> + */
> +static int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
> +{
> + =A0 =A0 =A0 unsigned long timeout;
> +
> + =A0 =A0 =A0 timeout =3D jiffies + HZ;

Is this timeout really valid if this device is clocked differently than
the CPU, as indicated when supplying a clk? Well, should work...

> + =A0 =A0 =A0 while (readb(dev->base + DW_IC_STATUS) & DW_IC_STATUS_A=
CTIVITY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"tim=
eout waiting for bus ready\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_timeout(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Initiate low level master read/write transaction.
> + * This function is called from i2c_dw_xfer when starting a transfer=
=2E
> + * This function is also called from dw_i2c_pump_msg to continue a t=
ransfer
> + * that is longer than the size of the TX FIFO.
> + */
> +static void
> +i2c_dw_xfer_msg(struct i2c_adapter *adap)
> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D i2c_get_adapdata(adap);
> + =A0 =A0 =A0 struct i2c_msg *msgs =3D dev->msgs;
> + =A0 =A0 =A0 int num =3D dev->msgs_num;
> + =A0 =A0 =A0 u16 ic_con, intr_mask;
> + =A0 =A0 =A0 int tx_valid_bytes =3D readb(dev->base + DW_IC_TXFLR);
> + =A0 =A0 =A0 int tx_limit =3D dev->tx_fifo_depth - tx_valid_bytes;
> + =A0 =A0 =A0 int rx_limit =3D dev->rx_fifo_depth - readb(dev->base +=
 DW_IC_RXFLR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 - tx_valid_bytes;
> + =A0 =A0 =A0 static u16 buf_len =3D 0;
> + =A0 =A0 =A0 static u16 addr;
> +
> + =A0 =A0 =A0 if (!(dev->status & STATUS_WRITE_IN_PROGRESS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable the adapter */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0, dev->base + DW_IC_ENABLE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set the slave (target) address */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(msgs[dev->msg_write_idx].addr, d=
ev->base + DW_IC_TAR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if the slave address is ten bit addr=
ess, enable 10BITADDR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ic_con =3D readw(dev->base + DW_IC_CON)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[dev->msg_write_idx].flags & I2=
C_M_TEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ic_con |=3D DW_IC_CON_1=
0BITADDR_MASTER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ic_con &=3D ~DW_IC_CON_=
10BITADDR_MASTER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(ic_con, dev->base + DW_IC_CON);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the adapter */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(1, dev->base + DW_IC_ENABLE);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 addr =3D msgs[dev->msg_write_idx].addr;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (; dev->msg_write_idx < num; dev->msg_write_idx++) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static u8 *buf;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if target address has changed, we ne=
ed to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* reprogram the target address in th=
e i2c
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* adapter when we are done with this=
 transfer
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[dev->msg_write_idx].addr !=3D =
addr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[dev->msg_write_idx].len =3D=3D=
 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: in=
valid message length\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->msg_err =3D -EINVA=
L;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(dev->status & STATUS_WRITE_IN_PRO=
GRESS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* new i2c_msg */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf =3D msgs[dev->msg_w=
rite_idx].buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_len =3D msgs[dev->m=
sg_write_idx].len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; buf_len > 0 && tx_limit > 0 && r=
x_limit > 0; buf_len--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[dev->msg_write=
_idx].flags & I2C_M_RD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
0x100, dev->base + DW_IC_DATA_CMD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_limi=
t--; tx_limit--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(=
*buf++, dev->base + DW_IC_DATA_CMD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_limi=
t--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 intr_mask =3D DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
> + =A0 =A0 =A0 if (buf_len > 0) { /* more bytes to be written */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 intr_mask |=3D DW_IC_INTR_TX_EMPTY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->status |=3D STATUS_WRITE_IN_PROGRE=
SS;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->status &=3D ~STATUS_WRITE_IN_PROGR=
ESS;
> + =A0 =A0 =A0 writew(intr_mask, dev->base + DW_IC_INTR_MASK);
> +}
> +
> +static void
> +i2c_dw_read(struct i2c_adapter *adap)
> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D i2c_get_adapdata(adap);
> + =A0 =A0 =A0 struct i2c_msg *msgs =3D dev->msgs;
> + =A0 =A0 =A0 int num =3D dev->msgs_num;
> + =A0 =A0 =A0 u16 addr =3D msgs[dev->msg_read_idx].addr;
> + =A0 =A0 =A0 int rx_valid =3D readw(dev->base + DW_IC_RXFLR);
> +
> + =A0 =A0 =A0 for (; dev->msg_read_idx < num; dev->msg_read_idx++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static int len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static u8 *buf;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(msgs[dev->msg_read_idx].flags & I=
2C_M_RD))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* different i2c client, reprogram the =
i2c adapter */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[dev->msg_read_idx].addr !=3D a=
ddr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(dev->status & STATUS_READ_IN_PROG=
RESS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 len =3D msgs[dev->msg_r=
ead_idx].len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf =3D msgs[dev->msg_r=
ead_idx].buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; len > 0 && rx_valid > 0; len--, =
rx_valid--)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D readb(dev->b=
ase + DW_IC_DATA_CMD);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (len > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->status |=3D STATUS=
_READ_IN_PROGRESS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->status &=3D ~STATU=
S_READ_IN_PROGRESS;
> + =A0 =A0 =A0 }
> +}
> +
> +/*
> + * Prepare controller for a transaction and call i2c_dw_xfer_msg
> + */
> +static int
> +i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num=
)
> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D i2c_get_adapdata(adap);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
> +
> + =A0 =A0 =A0 mutex_lock(&dev->lock);
> +
> + =A0 =A0 =A0 INIT_COMPLETION(dev->cmd_complete);
> + =A0 =A0 =A0 dev->msgs =3D msgs;
> + =A0 =A0 =A0 dev->msgs_num =3D num;
> + =A0 =A0 =A0 dev->cmd_err =3D 0;
> + =A0 =A0 =A0 dev->msg_write_idx =3D 0;
> + =A0 =A0 =A0 dev->msg_read_idx =3D 0;
> + =A0 =A0 =A0 dev->msg_err =3D 0;
> + =A0 =A0 =A0 dev->status =3D STATUS_IDLE;
> +
> + =A0 =A0 =A0 ret =3D i2c_dw_wait_bus_not_busy(dev);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 /* start the transfers */
> + =A0 =A0 =A0 i2c_dw_xfer_msg(adap);
> +
> + =A0 =A0 =A0 /* wait for tx to complete */
> + =A0 =A0 =A0 ret =3D wait_for_completion_interruptible_timeout(&dev-=
>cmd_complete, HZ);
> + =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev, "controller timed out=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dw_init(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 } else if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> +
> + =A0 =A0 =A0 if (dev->msg_err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->msg_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* no error */
> + =A0 =A0 =A0 if (likely(!dev->cmd_err)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* read rx fifo, and disable the adapte=
r */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dw_read(adap);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (dev->status & STATUS_READ_IN_P=
ROGRESS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(0, dev->base + DW_IC_ENABLE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* We have an error */
> + =A0 =A0 =A0 if (dev->cmd_err =3D=3D DW_IC_ERR_TX_ABRT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long abort_source =3D dev->abo=
rt_source;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_bit(i, &abort_source, ARRAY_SI=
ZE(abort_sources)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev->dev, "%s: %s\n", _=
_func__, abort_sources[i]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 ret =3D -EIO;
> +
> +done:
> + =A0 =A0 =A0 mutex_unlock(&dev->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static u32 i2c_dw_func(struct i2c_adapter *adap)
> +{
> + =A0 =A0 =A0 return I2C_FUNC_I2C | I2C_FUNC_10BIT_ADDR;
> +}
> +
> +static void dw_i2c_pump_msg(unsigned long data)
> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D (struct dw_i2c_dev *) data;
> + =A0 =A0 =A0 u16 intr_mask;
> +
> + =A0 =A0 =A0 i2c_dw_read(&dev->adapter);
> + =A0 =A0 =A0 i2c_dw_xfer_msg(&dev->adapter);
> +
> + =A0 =A0 =A0 intr_mask =3D DW_IC_INTR_STOP_DET | DW_IC_INTR_TX_ABRT;
> + =A0 =A0 =A0 if (dev->status & STATUS_WRITE_IN_PROGRESS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 intr_mask |=3D DW_IC_INTR_TX_EMPTY;
> + =A0 =A0 =A0 writew(intr_mask, dev->base + DW_IC_INTR_MASK);
> +}
> +
> +/*
> + * Interrupt service routine. This gets called whenever an I2C inter=
rupt
> + * occurs.
> + */
> +static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D dev_id;
> + =A0 =A0 =A0 u16 stat;
> +
> + =A0 =A0 =A0 stat =3D readw(dev->base + DW_IC_INTR_STAT);
> + =A0 =A0 =A0 dev_dbg(dev->dev, "%s: stat=3D0x%x\n", __func__, stat);
> + =A0 =A0 =A0 if (stat & DW_IC_INTR_TX_ABRT) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->abort_source =3D readw(dev->base +=
 DW_IC_TX_ABRT_SOURCE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cmd_err |=3D DW_IC_ERR_TX_ABRT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->status =3D STATUS_IDLE;
> + =A0 =A0 =A0 } else if (stat & DW_IC_INTR_TX_EMPTY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&dev->pump_msg);
> +
> + =A0 =A0 =A0 readb(dev->base + DW_IC_CLR_INTR); =A0 =A0 =A0/* clear =
interrupts */
> + =A0 =A0 =A0 writew(0, dev->base + DW_IC_INTR_MASK); /* disable inte=
rrupts */
> + =A0 =A0 =A0 if (stat & (DW_IC_INTR_TX_ABRT | DW_IC_INTR_STOP_DET))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&dev->cmd_complete);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static struct i2c_algorithm i2c_dw_algo =3D {
> + =A0 =A0 =A0 .master_xfer =A0 =A0=3D i2c_dw_xfer,
> + =A0 =A0 =A0 .functionality =A0=3D i2c_dw_func,
> +};
> +
> +static int dw_i2c_probe(struct platform_device *pdev)

Can you tag this with __init?

> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev;
> + =A0 =A0 =A0 struct i2c_adapter *adap;
> + =A0 =A0 =A0 struct resource *mem, *irq, *ioarea;
> + =A0 =A0 =A0 int r;
> +
> + =A0 =A0 =A0 /* NOTE: driver uses the static register mapping */
> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

I've seen other drivers use -ENOENT which makes sense.

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> + =A0 =A0 =A0 if (!irq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;

-ENOENT

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ioarea =3D request_mem_region(mem->start, (mem->end - m=
em->start) + 1,

Use resource_size(mem) instead of the last argument.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 pdev->name);
> + =A0 =A0 =A0 if (!ioarea) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "I2C region already=
 claimed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev =3D kzalloc(sizeof(struct dw_i2c_dev), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 init_completion(&dev->cmd_complete);
> + =A0 =A0 =A0 tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned=
 long) dev);
> + =A0 =A0 =A0 mutex_init(&dev->lock);
> + =A0 =A0 =A0 dev->dev =3D get_device(&pdev->dev);
> + =A0 =A0 =A0 dev->irq =3D irq->start;
> + =A0 =A0 =A0 platform_set_drvdata(pdev, dev);
> +
> + =A0 =A0 =A0 dev->clk =3D clk_get(&pdev->dev, "I2CCLK");
> + =A0 =A0 =A0 if (IS_ERR(dev->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_enable(dev->clk);
> +
> + =A0 =A0 =A0 dev->base =3D ioremap(mem->start, mem->end - mem->start=
 + 1);

resource_size()

> + =A0 =A0 =A0 if (dev->base =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failure mapping io=
 resources\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -EBUSY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_unuse_clocks;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 dev->tx_fifo_depth =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((readl(dev->base + DW_IC_COMP_PARAM_1)=
 & 0x00ff0000) >> 16) + 1;
> + =A0 =A0 =A0 dev->rx_fifo_depth =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((readl(dev->base + DW_IC_COMP_PARAM_1)=
 & 0x0000ff00) >> 8) + 1;
> + =A0 =A0 =A0 i2c_dw_init(dev);
> +
> + =A0 =A0 =A0 writew(0, dev->base + DW_IC_INTR_MASK); /* disable IRQ =
*/
> + =A0 =A0 =A0 r =3D request_irq(dev->irq, i2c_dw_isr, 0, pdev->name, =
dev);
> + =A0 =A0 =A0 if (r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failure requesting=
 irq %i\n", dev->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 adap =3D &dev->adapter;
> + =A0 =A0 =A0 i2c_set_adapdata(adap, dev);
> + =A0 =A0 =A0 adap->owner =3D THIS_MODULE;
> + =A0 =A0 =A0 adap->class =3D I2C_CLASS_HWMON;
> + =A0 =A0 =A0 strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(adap->name));
> + =A0 =A0 =A0 adap->algo =3D &i2c_dw_algo;
> + =A0 =A0 =A0 adap->dev.parent =3D &pdev->dev;
> +
> + =A0 =A0 =A0 adap->nr =3D pdev->id;
> + =A0 =A0 =A0 r =3D i2c_add_numbered_adapter(adap);
> + =A0 =A0 =A0 if (r) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failure adding ada=
pter\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(dev->irq, dev);
> +err_iounmap:
> + =A0 =A0 =A0 iounmap(dev->base);
> +err_unuse_clocks:
> + =A0 =A0 =A0 clk_disable(dev->clk);
> + =A0 =A0 =A0 clk_put(dev->clk);
> + =A0 =A0 =A0 dev->clk =3D NULL;
> +err_free_mem:
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 put_device(&pdev->dev);
> + =A0 =A0 =A0 kfree(dev);
> +err_release_region:
> + =A0 =A0 =A0 release_mem_region(mem->start, (mem->end - mem->start) =
+ 1);

resource_size()

> +
> + =A0 =A0 =A0 return r;
> +}
> +
> +static int dw_i2c_remove(struct platform_device *pdev)

Can you tag this with __exit?

> +{
> + =A0 =A0 =A0 struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev);
> + =A0 =A0 =A0 struct resource *mem;
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> + =A0 =A0 =A0 i2c_del_adapter(&dev->adapter);
> + =A0 =A0 =A0 put_device(&pdev->dev);
> +
> + =A0 =A0 =A0 clk_disable(dev->clk);
> + =A0 =A0 =A0 clk_put(dev->clk);
> + =A0 =A0 =A0 dev->clk =3D NULL;
> +
> + =A0 =A0 =A0 writeb(0, dev->base + DW_IC_ENABLE);
> + =A0 =A0 =A0 free_irq(dev->irq, dev);
> + =A0 =A0 =A0 kfree(dev);
> +
> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 release_mem_region(mem->start, (mem->end - mem->start) =
+ 1);

resource_size()
But I usually cache important resources in the driver private struct
(struct dw_i2c_dev in this case)

> + =A0 =A0 =A0 return 0;
> +}
> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:i2c_designware");
> +
> +static struct platform_driver dw_i2c_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D dw_i2c_probe,

Can you remove this and use platform_driver_probe() as detaile below in=
stead?

> + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D dw_i2c_remove,

If the function can be tagges __exit, this can be tagged
__exit_p(dw_i2c_remove);

> + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "i2c_designware",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init dw_i2c_init_driver(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&dw_i2c_driver);

return platform_driver_probe(&dw_i2c_driver, dw_i2c_probe);
and remove the .probe field in the driver.

> +}
> +module_init(dw_i2c_init_driver);
> +
> +static void __exit dw_i2c_exit_driver(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&dw_i2c_driver);
> +}
> +module_exit(dw_i2c_exit_driver);
> +
> +MODULE_AUTHOR("Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>");
> +MODULE_DESCRIPTION("Synopsys DesignWare I2C bus adapter");
> +MODULE_LICENSE("GPL");
> --
> 1.6.2.4
>


Yours,
Linus Walleij
