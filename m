From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] [ARM] tegra: Add i2c support
Date: Tue, 21 Dec 2010 16:11:47 -0800
Message-ID: <AANLkTimYURYGix-0Xk3wdf1A-XEAJbBXR_JDn1BFw_uq@mail.gmail.com>
References: <1283466103-20889-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283466103-20889-1-git-send-email-ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 2, 2010 at 3:21 PM, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrote:
> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> ---
> =A0drivers/i2c/busses/Kconfig =A0 =A0 | =A0 =A07 +
> =A0drivers/i2c/busses/Makefile =A0 =A0| =A0 =A01 +
> =A0drivers/i2c/busses/i2c-tegra.c | =A0665 ++++++++++++++++++++++++++=
++++++++++++++
> =A0include/linux/i2c-tegra.h =A0 =A0 =A0| =A0 25 ++
> =A04 files changed, 698 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/i2c/busses/i2c-tegra.c
> =A0create mode 100644 include/linux/i2c-tegra.h
>
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 6539ac2..7466333 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -596,6 +596,13 @@ config I2C_STU300
> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. If so, =
the module
> =A0 =A0 =A0 =A0 =A0will be called i2c-stu300.
>
> +config I2C_TEGRA
> + =A0 =A0 =A0 tristate "NVIDIA Tegra internal I2C controller"
> + =A0 =A0 =A0 depends on ARCH_TEGRA
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes to this option, support will be incl=
uded for the
> + =A0 =A0 =A0 =A0 I2C controller embedded in NVIDIA Tegra SOCs
> +
> =A0config I2C_VERSATILE
> =A0 =A0 =A0 =A0tristate "ARM Versatile/Realview I2C bus support"
> =A0 =A0 =A0 =A0depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEX=
PRESS
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefil=
e
> index c3ef492..94348a5 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_I2C_SH7760) =A0 =A0 =A0+=3D i2c-sh7760=
=2Eo
> =A0obj-$(CONFIG_I2C_SH_MOBILE) =A0 =A0+=3D i2c-sh_mobile.o
> =A0obj-$(CONFIG_I2C_SIMTEC) =A0 =A0 =A0 +=3D i2c-simtec.o
> =A0obj-$(CONFIG_I2C_STU300) =A0 =A0 =A0 +=3D i2c-stu300.o
> +obj-$(CONFIG_I2C_TEGRA) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D i2c-tegr=
a.o
> =A0obj-$(CONFIG_I2C_VERSATILE) =A0 =A0+=3D i2c-versatile.o
> =A0obj-$(CONFIG_I2C_OCTEON) =A0 =A0 =A0 +=3D i2c-octeon.o
> =A0obj-$(CONFIG_I2C_XILINX) =A0 =A0 =A0 +=3D i2c-xiic.o
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-=
tegra.c
> new file mode 100644
> index 0000000..cfa0084
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -0,0 +1,665 @@
> +/*
> + * drivers/i2c/busses/i2c-tegra.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/i2c-tegra.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <mach/clk.h>
> +
> +#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define BYTES_PER_FIFO_WORD 4
> +
> +#define I2C_CNFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 0x000
> +#define I2C_CNFG_PACKET_MODE_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1<<10)
> +#define I2C_CNFG_NEW_MASTER_FSM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1<<11)
> +#define I2C_SL_CNFG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x020
> +#define I2C_SL_CNFG_NEWSL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1<<2)
> +#define I2C_SL_ADDR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x02c
> +#define I2C_TX_FIFO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x050
> +#define I2C_RX_FIFO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x054
> +#define I2C_PACKET_TRANSFER_STATUS =A0 =A0 =A0 =A0 =A0 =A0 0x058
> +#define I2C_FIFO_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x05c
> +#define I2C_FIFO_CONTROL_TX_FLUSH =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<1)
> +#define I2C_FIFO_CONTROL_RX_FLUSH =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<0)
> +#define I2C_FIFO_CONTROL_TX_TRIG_SHIFT =A0 =A0 =A0 =A0 5
> +#define I2C_FIFO_CONTROL_RX_TRIG_SHIFT =A0 =A0 =A0 =A0 2
> +#define I2C_FIFO_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x060
> +#define I2C_FIFO_STATUS_TX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00xF0
> +#define I2C_FIFO_STATUS_TX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 4
> +#define I2C_FIFO_STATUS_RX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x0F
> +#define I2C_FIFO_STATUS_RX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
> +#define I2C_INT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x064
> +#define I2C_INT_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x068
> +#define I2C_INT_PACKET_XFER_COMPLETE =A0 =A0 =A0 =A0 =A0 (1<<7)
> +#define I2C_INT_ALL_PACKETS_XFER_COMPLETE =A0 =A0 =A0(1<<6)
> +#define I2C_INT_TX_FIFO_OVERFLOW =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<5)
> +#define I2C_INT_RX_FIFO_UNDERFLOW =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<4)
> +#define I2C_INT_NO_ACK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<3)
> +#define I2C_INT_ARBITRATION_LOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2)
> +#define I2C_INT_TX_FIFO_DATA_REQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<1)
> +#define I2C_INT_RX_FIFO_DATA_REQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<0)
> +#define I2C_CLK_DIVISOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x06c
> +
> +#define DVC_CTRL_REG1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x000
> +#define DVC_CTRL_REG1_INTR_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<10)
> +#define DVC_CTRL_REG2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x004
> +#define DVC_CTRL_REG3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x008
> +#define DVC_CTRL_REG3_SW_PROG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<26)
> +#define DVC_CTRL_REG3_I2C_DONE_INTR_EN =A0 =A0 =A0 =A0 (1<<30)
> +#define DVC_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00c
> +#define DVC_STATUS_I2C_DONE_INTR =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<30)
> +
> +#define I2C_ERR_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x00
> +#define I2C_ERR_NO_ACK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x01
> +#define I2C_ERR_ARBITRATION_LOST =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
> +
> +#define PACKET_HEADER0_HEADER_SIZE_SHIFT =A0 =A0 =A0 28
> +#define PACKET_HEADER0_PACKET_ID_SHIFT =A0 =A0 =A0 =A0 16
> +#define PACKET_HEADER0_CONT_ID_SHIFT =A0 =A0 =A0 =A0 =A0 12
> +#define PACKET_HEADER0_PROTOCOL_I2C =A0 =A0 =A0 =A0 =A0 =A0(1<<4)
> +
> +#define I2C_HEADER_HIGHSPEED_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<22)
> +#define I2C_HEADER_CONT_ON_NAK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<2=
1)
> +#define I2C_HEADER_SEND_START_BYTE =A0 =A0 =A0 =A0 =A0 =A0 (1<<20)
> +#define I2C_HEADER_READ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1<<19)
> +#define I2C_HEADER_10BIT_ADDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<=
<18)
> +#define I2C_HEADER_IE_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<=
<17)
> +#define I2C_HEADER_REPEAT_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1<<16)
> +#define I2C_HEADER_MASTER_ADDR_SHIFT =A0 =A0 =A0 =A0 =A0 12
> +#define I2C_HEADER_SLAVE_ADDR_SHIFT =A0 =A0 =A0 =A0 =A0 =A01
> +
> +struct tegra_i2c_dev {
> + =A0 =A0 =A0 struct device *dev;
> + =A0 =A0 =A0 struct i2c_adapter adapter;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct clk *i2c_clk;
> + =A0 =A0 =A0 struct resource *iomem;
> + =A0 =A0 =A0 void __iomem *base;
> + =A0 =A0 =A0 int cont_id;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 int is_dvc;
> + =A0 =A0 =A0 struct completion msg_complete;
> + =A0 =A0 =A0 int msg_err;
> + =A0 =A0 =A0 u8 *msg_buf;
> + =A0 =A0 =A0 size_t msg_buf_remaining;
> + =A0 =A0 =A0 int msg_read;
> + =A0 =A0 =A0 int msg_transfer_complete;
> + =A0 =A0 =A0 unsigned long bus_clk_rate;
> + =A0 =A0 =A0 bool is_suspended;
> +};
> +
> +static void dvc_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsig=
ned long reg)
> +{
> + =A0 =A0 =A0 writel(val, i2c_dev->base + reg);
> +}
> +
> +static u32 dvc_readl(struct tegra_i2c_dev *i2c_dev, unsigned long re=
g)
> +{
> + =A0 =A0 =A0 return readl(i2c_dev->base + reg);
> +}
> +
> +/*
> + * i2c_writel and i2c_readl will offset the register if necessary to=
 talk
> + * to the I2C block inside the DVC block
> + */
> +static void i2c_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsig=
ned long reg)
> +{
> + =A0 =A0 =A0 if (i2c_dev->is_dvc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D (reg >=3D I2C_TX_FIFO) ? 0x10 =
: 0x40;
> + =A0 =A0 =A0 writel(val, i2c_dev->base + reg);
> +}
> +
> +static u32 i2c_readl(struct tegra_i2c_dev *i2c_dev, unsigned long re=
g)
> +{
> + =A0 =A0 =A0 if (i2c_dev->is_dvc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D (reg >=3D I2C_TX_FIFO) ? 0x10 =
: 0x40;
> + =A0 =A0 =A0 return readl(i2c_dev->base + reg);
> +}
> +
> +static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 ma=
sk)
> +{
> + =A0 =A0 =A0 u32 int_mask =3D i2c_readl(i2c_dev, I2C_INT_MASK);
> + =A0 =A0 =A0 int_mask &=3D ~mask;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
> +}
> +
> +static void tegra_i2c_unmask_irq(struct tegra_i2c_dev *i2c_dev, u32 =
mask)
> +{
> + =A0 =A0 =A0 u32 int_mask =3D i2c_readl(i2c_dev, I2C_INT_MASK);
> + =A0 =A0 =A0 int_mask |=3D mask;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, int_mask, I2C_INT_MASK);
> +}
> +
> +static void tegra_i2c_set_clk(struct tegra_i2c_dev *i2c_dev, unsigne=
d int freq)
> +{
> + =A0 =A0 =A0 clk_set_rate(i2c_dev->clk, freq * 8);
> +}
> +
> +static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
> +{
> + =A0 =A0 =A0 unsigned long timeout =3D jiffies + HZ;
> + =A0 =A0 =A0 u32 val =3D i2c_readl(i2c_dev, I2C_FIFO_CONTROL);
> + =A0 =A0 =A0 val |=3D I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_CONTROL_R=
X_FLUSH;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> +
> + =A0 =A0 =A0 while (i2c_readl(i2c_dev, I2C_FIFO_CONTROL) &
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_C=
ONTROL_RX_FLUSH)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(i2c_dev->dev, =
"timeout waiting for fifo flush\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_i2c_empty_rx_fifo(struct tegra_i2c_dev *i2c_dev)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 int rx_fifo_avail;
> + =A0 =A0 =A0 int word;
> + =A0 =A0 =A0 u8 *buf =3D i2c_dev->msg_buf;
> + =A0 =A0 =A0 size_t buf_remaining =3D i2c_dev->msg_buf_remaining;
> + =A0 =A0 =A0 int words_to_transfer;
> +
> + =A0 =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_FIFO_STATUS);
> + =A0 =A0 =A0 rx_fifo_avail =3D (val & I2C_FIFO_STATUS_RX_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_FIFO_STATUS_RX_SHIFT;
> +
> + =A0 =A0 =A0 words_to_transfer =3D buf_remaining / BYTES_PER_FIFO_WO=
RD;
> + =A0 =A0 =A0 if (words_to_transfer > rx_fifo_avail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 words_to_transfer =3D rx_fifo_avail;
> +
> + =A0 =A0 =A0 for (word =3D 0; word < words_to_transfer; word++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_RX_FIFO)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 put_unaligned_le32(val, buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D BYTES_PER_FIFO_WORD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_remaining -=3D BYTES_PER_FIFO_WORD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_avail--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (rx_fifo_avail > 0 && buf_remaining > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bytes_to_transfer =3D buf_remaining=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int byte;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(bytes_to_transfer > 3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_RX_FIFO)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (byte =3D 0; byte < bytes_to_transf=
er; byte++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *buf++ =3D val & 0xFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val >>=3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_remaining -=3D bytes_to_transfer;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_avail--;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 BUG_ON(rx_fifo_avail > 0 && buf_remaining > 0);
> + =A0 =A0 =A0 i2c_dev->msg_buf_remaining =3D buf_remaining;
> + =A0 =A0 =A0 i2c_dev->msg_buf =3D buf;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 int tx_fifo_avail;
> + =A0 =A0 =A0 int word;
> + =A0 =A0 =A0 u8 *buf =3D i2c_dev->msg_buf;
> + =A0 =A0 =A0 size_t buf_remaining =3D i2c_dev->msg_buf_remaining;
> + =A0 =A0 =A0 int words_to_transfer;
> +
> + =A0 =A0 =A0 val =3D i2c_readl(i2c_dev, I2C_FIFO_STATUS);
> + =A0 =A0 =A0 tx_fifo_avail =3D (val & I2C_FIFO_STATUS_TX_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_FIFO_STATUS_TX_SHIFT;
> +
> + =A0 =A0 =A0 words_to_transfer =3D buf_remaining / BYTES_PER_FIFO_WO=
RD;
> + =A0 =A0 =A0 if (words_to_transfer > tx_fifo_avail)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 words_to_transfer =3D tx_fifo_avail;
> +
> + =A0 =A0 =A0 for (word =3D 0; word < words_to_transfer; word++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D get_unaligned_le32(buf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_writel(i2c_dev, val, I2C_TX_FIFO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf +=3D BYTES_PER_FIFO_WORD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_remaining -=3D BYTES_PER_FIFO_WORD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_avail--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (tx_fifo_avail > 0 && buf_remaining > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bytes_to_transfer =3D buf_remaining=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int byte;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(bytes_to_transfer > 3);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (byte =3D 0; byte < bytes_to_transf=
er; byte++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (*buf++) << (b=
yte * 8);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_writel(i2c_dev, val, I2C_TX_FIFO);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf_remaining -=3D bytes_to_transfer;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_avail--;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 BUG_ON(tx_fifo_avail > 0 && buf_remaining > 0);
> + =A0 =A0 =A0 i2c_dev->msg_buf_remaining =3D buf_remaining;
> + =A0 =A0 =A0 i2c_dev->msg_buf =3D buf;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * One of the Tegra I2C blocks is inside the DVC (Digital Voltage Co=
ntroller)
> + * block. =A0This block is identical to the rest of the I2C blocks, =
except that
> + * it only supports master mode, it has registers moved around, and =
it needs
> + * some extra init to get it into I2C mode. =A0The register moves ar=
e handled
> + * by i2c_readl and i2c_writel
> + */
> +static void tegra_dvc_init(struct tegra_i2c_dev *i2c_dev)
> +{
> + =A0 =A0 =A0 u32 val =3D 0;
> + =A0 =A0 =A0 val =3D dvc_readl(i2c_dev, DVC_CTRL_REG3);
> + =A0 =A0 =A0 val |=3D DVC_CTRL_REG3_SW_PROG;
> + =A0 =A0 =A0 val |=3D DVC_CTRL_REG3_I2C_DONE_INTR_EN;
> + =A0 =A0 =A0 dvc_writel(i2c_dev, val, DVC_CTRL_REG3);
> +
> + =A0 =A0 =A0 val =3D dvc_readl(i2c_dev, DVC_CTRL_REG1);
> + =A0 =A0 =A0 val |=3D DVC_CTRL_REG1_INTR_EN;
> + =A0 =A0 =A0 dvc_writel(i2c_dev, val, DVC_CTRL_REG1);
> +}
> +
> +static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
> +{
> + =A0 =A0 =A0 u32 val;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 clk_enable(i2c_dev->clk);
> +
> + =A0 =A0 =A0 tegra_periph_reset_assert(i2c_dev->clk);
> + =A0 =A0 =A0 udelay(2);
> + =A0 =A0 =A0 tegra_periph_reset_deassert(i2c_dev->clk);
> +
> + =A0 =A0 =A0 if (i2c_dev->is_dvc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_dvc_init(i2c_dev);
> +
> + =A0 =A0 =A0 val =3D I2C_CNFG_NEW_MASTER_FSM | I2C_CNFG_PACKET_MODE_=
EN;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, val, I2C_CNFG);
> + =A0 =A0 =A0 i2c_writel(i2c_dev, 0, I2C_INT_MASK);
> + =A0 =A0 =A0 tegra_i2c_set_clk(i2c_dev, i2c_dev->bus_clk_rate);
> +
> + =A0 =A0 =A0 val =3D 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> +
> + =A0 =A0 =A0 if (tegra_i2c_flush_fifos(i2c_dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ETIMEDOUT;
> +
> + =A0 =A0 =A0 clk_disable(i2c_dev->clk);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 u32 status;
> + =A0 =A0 =A0 const u32 status_err =3D I2C_INT_NO_ACK | I2C_INT_ARBIT=
RATION_LOST;
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D dev_id;
> +
> + =A0 =A0 =A0 status =3D i2c_readl(i2c_dev, I2C_INT_STATUS);
> +
> + =A0 =A0 =A0 if (status =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(i2c_dev->dev, "irq status 0 %0=
8x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_readl(i2c_dev, I2C_=
PACKET_TRANSFER_STATUS));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (unlikely(status & status_err)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & I2C_INT_NO_ACK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->msg_err |=3D I=
2C_ERR_NO_ACK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & I2C_INT_ARBITRATION_LOST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->msg_err |=3D I=
2C_ERR_ARBITRATION_LOST;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&i2c_dev->msg_complete);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (i2c_dev->msg_read && (status & I2C_INT_RX_FIFO_DATA=
_REQ)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_dev->msg_buf_remaining)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_empty_rx_fifo=
(i2c_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!i2c_dev->msg_read && (status & I2C_INT_TX_FIFO_DAT=
A_REQ)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2c_dev->msg_buf_remaining)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_fill_tx_fifo(=
i2c_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_mask_irq(i2c_=
dev, I2C_INT_TX_FIFO_DATA_REQ);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (status & I2C_INT_PACKET_XFER_COMPLETE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->msg_transfer_complete =3D 1;
> +
> + =A0 =A0 =A0 if (i2c_dev->msg_transfer_complete && !i2c_dev->msg_buf=
_remaining)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 complete(&i2c_dev->msg_complete);
> + =A0 =A0 =A0 i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> + =A0 =A0 =A0 if (i2c_dev->is_dvc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dvc_writel(i2c_dev, DVC_STATUS_I2C_DONE=
_INTR, DVC_STATUS);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +err:
> + =A0 =A0 =A0 /* An error occured, mask all interrupts */
> + =A0 =A0 =A0 tegra_i2c_mask_irq(i2c_dev, I2C_INT_NO_ACK | I2C_INT_AR=
BITRATION_LOST |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_INT_PACKET_XFER_COMPLETE | I2C_INT_=
TX_FIFO_DATA_REQ |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 I2C_INT_RX_FIFO_DATA_REQ);
> + =A0 =A0 =A0 i2c_writel(i2c_dev, status, I2C_INT_STATUS);
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> +static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
> + =A0 =A0 =A0 struct i2c_msg *msg, int stop)
> +{
> + =A0 =A0 =A0 u32 packet_header;
> + =A0 =A0 =A0 u32 int_mask;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 tegra_i2c_flush_fifos(i2c_dev);
> + =A0 =A0 =A0 i2c_writel(i2c_dev, 0xFF, I2C_INT_STATUS);
> +
> + =A0 =A0 =A0 if (msg->len =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 i2c_dev->msg_buf =3D msg->buf;
> + =A0 =A0 =A0 i2c_dev->msg_buf_remaining =3D msg->len;
> + =A0 =A0 =A0 i2c_dev->msg_err =3D I2C_ERR_NONE;
> + =A0 =A0 =A0 i2c_dev->msg_transfer_complete =3D 0;
> + =A0 =A0 =A0 i2c_dev->msg_read =3D (msg->flags & I2C_M_RD);
> + =A0 =A0 =A0 INIT_COMPLETION(i2c_dev->msg_complete);
> +
> + =A0 =A0 =A0 packet_header =3D (0 << PACKET_HEADER0_HEADER_SIZE_SHIF=
T) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PACKET_HEADER0_PROTOCOL=
_I2C |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (i2c_dev->cont_id << PA=
CKET_HEADER0_CONT_ID_SHIFT) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << PACKET_HEADER0_PA=
CKET_ID_SHIFT);
> + =A0 =A0 =A0 i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> + =A0 =A0 =A0 packet_header =3D msg->len - 1;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> + =A0 =A0 =A0 packet_header =3D msg->addr << I2C_HEADER_SLAVE_ADDR_SH=
IFT;
> + =A0 =A0 =A0 packet_header |=3D I2C_HEADER_IE_ENABLE;
> + =A0 =A0 =A0 if (msg->flags & I2C_M_TEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_header |=3D I2C_HEADER_10BIT_ADD=
R;
> + =A0 =A0 =A0 if (msg->flags & I2C_M_IGNORE_NAK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_header |=3D I2C_HEADER_CONT_ON_N=
AK;
> + =A0 =A0 =A0 if (msg->flags & I2C_M_NOSTART)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_header |=3D I2C_HEADER_REPEAT_ST=
ART;
> + =A0 =A0 =A0 if (msg->flags & I2C_M_RD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 packet_header |=3D I2C_HEADER_READ;
> + =A0 =A0 =A0 i2c_writel(i2c_dev, packet_header, I2C_TX_FIFO);
> +
> + =A0 =A0 =A0 if (!(msg->flags & I2C_M_RD))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_fill_tx_fifo(i2c_dev);
> +
> + =A0 =A0 =A0 int_mask =3D I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> + =A0 =A0 =A0 if (msg->flags & I2C_M_RD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_mask |=3D I2C_INT_RX_FIFO_DATA_REQ;
> + =A0 =A0 =A0 else if (i2c_dev->msg_buf_remaining)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int_mask |=3D I2C_INT_TX_FIFO_DATA_REQ;
> + =A0 =A0 =A0 tegra_i2c_unmask_irq(i2c_dev, int_mask);
> + =A0 =A0 =A0 pr_debug("unmasked irq: %02x\n", i2c_readl(i2c_dev, I2C=
_INT_MASK));
> +
> + =A0 =A0 =A0 ret =3D wait_for_completion_timeout(&i2c_dev->msg_compl=
ete, TEGRA_I2C_TIMEOUT);
> + =A0 =A0 =A0 tegra_i2c_mask_irq(i2c_dev, int_mask);
> +
> + =A0 =A0 =A0 if (WARN_ON(ret =3D=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2c_dev->dev, "i2c transfer tim=
ed out\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tegra_i2c_init(i2c_dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("transfer complete: %d %d %d\n", ret, completi=
on_done(&i2c_dev->msg_complete), i2c_dev->msg_err);
> +
> + =A0 =A0 =A0 if (likely(i2c_dev->msg_err =3D=3D I2C_ERR_NONE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 tegra_i2c_init(i2c_dev);
> + =A0 =A0 =A0 if (i2c_dev->msg_err =3D=3D I2C_ERR_NO_ACK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msg->flags & I2C_M_IGNORE_NAK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EREMOTEIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EIO;
> +}
> +
> +static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg m=
sgs[],
> + =A0 =A0 =A0 int num)
> +{
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D i2c_get_adapdata(adap=
);
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (i2c_dev->is_suspended)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> +
> + =A0 =A0 =A0 clk_enable(i2c_dev->clk);
> + =A0 =A0 =A0 for (i =3D 0; i < num; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stop =3D (i =3D=3D (num - 1)) ? 1 =A0=
: 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D tegra_i2c_xfer_msg(i2c_dev, &ms=
gs[i], stop);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 clk_disable(i2c_dev->clk);
> + =A0 =A0 =A0 return ret ?: i;
> +}
> +
> +static u32 tegra_i2c_func(struct i2c_adapter *adap)
> +{
> + =A0 =A0 =A0 return I2C_FUNC_I2C;
> +}
> +
> +static const struct i2c_algorithm tegra_i2c_algo =3D {
> + =A0 =A0 =A0 .master_xfer =A0 =A0=3D tegra_i2c_xfer,
> + =A0 =A0 =A0 .functionality =A0=3D tegra_i2c_func,
> +};
> +
> +static int tegra_i2c_probe(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev;
> + =A0 =A0 =A0 struct tegra_i2c_platform_data *pdata =3D pdev->dev.pla=
tform_data;
> + =A0 =A0 =A0 struct resource *res;
> + =A0 =A0 =A0 struct resource *iomem;
> + =A0 =A0 =A0 struct clk *clk;
> + =A0 =A0 =A0 struct clk *i2c_clk;
> + =A0 =A0 =A0 void *base;
> + =A0 =A0 =A0 int irq;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource?\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 iomem =3D request_mem_region(res->start, resource_size(=
res), pdev->name);
> + =A0 =A0 =A0 if (!iomem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "I2C region already=
 claimed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 base =3D ioremap(iomem->start, resource_size(iomem));
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Can't ioremap I2C =
region\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> + =A0 =A0 =A0 if (!res) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no irq resource?\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_iounmap;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 irq =3D res->start;
> +
> + =A0 =A0 =A0 clk =3D clk_get(&pdev->dev, NULL);
> + =A0 =A0 =A0 if (!clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_release_region;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_clk =3D clk_get(&pdev->dev, "i2c");
> + =A0 =A0 =A0 if (!i2c_clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk_put;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_dev =3D kzalloc(sizeof(struct tegra_i2c_dev), GFP_K=
ERNEL);
> + =A0 =A0 =A0 if (!i2c_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_i2c_clk_put;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_dev->base =3D base;
> + =A0 =A0 =A0 i2c_dev->clk =3D clk;
> + =A0 =A0 =A0 i2c_dev->i2c_clk =3D i2c_clk;
> + =A0 =A0 =A0 i2c_dev->iomem =3D iomem;
> + =A0 =A0 =A0 i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> + =A0 =A0 =A0 i2c_dev->irq =3D irq;
> + =A0 =A0 =A0 i2c_dev->cont_id =3D pdev->id;
> + =A0 =A0 =A0 i2c_dev->dev =3D &pdev->dev;
> + =A0 =A0 =A0 i2c_dev->bus_clk_rate =3D pdata ? pdata->bus_clk_rate :=
 100000;
> +
> + =A0 =A0 =A0 if (pdev->id =3D=3D 3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_dev->is_dvc =3D 1;
> + =A0 =A0 =A0 init_completion(&i2c_dev->msg_complete);
> +
> + =A0 =A0 =A0 platform_set_drvdata(pdev, i2c_dev);
> +
> + =A0 =A0 =A0 ret =3D tegra_i2c_init(i2c_dev);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> +
> + =A0 =A0 =A0 ret =3D request_irq(i2c_dev->irq, tegra_i2c_isr, IRQF_D=
ISABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->name, i2c_dev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to request =
irq %i\n", i2c_dev->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_enable(i2c_dev->i2c_clk);
> +
> + =A0 =A0 =A0 i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> + =A0 =A0 =A0 i2c_dev->adapter.owner =3D THIS_MODULE;
> + =A0 =A0 =A0 i2c_dev->adapter.class =3D I2C_CLASS_HWMON;
> + =A0 =A0 =A0 strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(i2c_dev->adapter.name));
> + =A0 =A0 =A0 i2c_dev->adapter.algo =3D &tegra_i2c_algo;
> + =A0 =A0 =A0 i2c_dev->adapter.dev.parent =3D &pdev->dev;
> + =A0 =A0 =A0 i2c_dev->adapter.nr =3D pdev->id;
> +
> + =A0 =A0 =A0 ret =3D i2c_add_numbered_adapter(&i2c_dev->adapter);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Failed to add I2C =
adapter\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +err_free_irq:
> + =A0 =A0 =A0 free_irq(i2c_dev->irq, i2c_dev);
> +err_free:
> + =A0 =A0 =A0 kfree(i2c_dev);
> +err_i2c_clk_put:
> + =A0 =A0 =A0 clk_put(i2c_clk);
> +err_clk_put:
> + =A0 =A0 =A0 clk_put(clk);
> +err_release_region:
> + =A0 =A0 =A0 release_mem_region(iomem->start, resource_size(iomem));
> +err_iounmap:
> + =A0 =A0 =A0 iounmap(base);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int tegra_i2c_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D platform_get_drvdata(=
pdev);
> + =A0 =A0 =A0 i2c_del_adapter(&i2c_dev->adapter);
> + =A0 =A0 =A0 free_irq(i2c_dev->irq, i2c_dev);
> + =A0 =A0 =A0 clk_put(i2c_dev->i2c_clk);
> + =A0 =A0 =A0 clk_put(i2c_dev->clk);
> + =A0 =A0 =A0 release_mem_region(i2c_dev->iomem->start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 resource_size(i2c_dev->iomem));
> + =A0 =A0 =A0 iounmap(i2c_dev->base);
> + =A0 =A0 =A0 kfree(i2c_dev);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int tegra_i2c_suspend(struct platform_device *pdev, pm_messag=
e_t state)
> +{
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D platform_get_drvdata(=
pdev);
> +
> + =A0 =A0 =A0 i2c_lock_adapter(&i2c_dev->adapter);
> + =A0 =A0 =A0 i2c_dev->is_suspended =3D true;
> + =A0 =A0 =A0 i2c_unlock_adapter(&i2c_dev->adapter);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int tegra_i2c_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct tegra_i2c_dev *i2c_dev =3D platform_get_drvdata(=
pdev);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 i2c_lock_adapter(&i2c_dev->adapter);
> +
> + =A0 =A0 =A0 ret =3D tegra_i2c_init(i2c_dev);
> +
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_unlock_adapter(&i2c_dev->adapter);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 i2c_dev->is_suspended =3D false;
> +
> + =A0 =A0 =A0 i2c_unlock_adapter(&i2c_dev->adapter);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
> +static struct platform_driver tegra_i2c_driver =3D {
> + =A0 =A0 =A0 .probe =A0 =3D tegra_i2c_probe,
> + =A0 =A0 =A0 .remove =A0=3D tegra_i2c_remove,
> +#ifdef CONFIG_PM
> + =A0 =A0 =A0 .suspend =3D tegra_i2c_suspend,
> + =A0 =A0 =A0 .resume =A0=3D tegra_i2c_resume,
> +#endif
> + =A0 =A0 =A0 .driver =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0=3D "tegra-i2c",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> +};
> +
> +static int __init tegra_i2c_init_driver(void)
> +{
> + =A0 =A0 =A0 return platform_driver_register(&tegra_i2c_driver);
> +}
> +
> +static void __exit tegra_i2c_exit_driver(void)
> +{
> + =A0 =A0 =A0 platform_driver_unregister(&tegra_i2c_driver);
> +}
> +
> +subsys_initcall(tegra_i2c_init_driver);
> +module_exit(tegra_i2c_exit_driver);
> diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
> new file mode 100644
> index 0000000..9c85da4
> --- /dev/null
> +++ b/include/linux/i2c-tegra.h
> @@ -0,0 +1,25 @@
> +/*
> + * drivers/i2c/busses/i2c-tegra.c
> + *
> + * Copyright (C) 2010 Google, Inc.
> + * Author: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> + *
> + * This software is licensed under the terms of the GNU General Publ=
ic
> + * License version 2, as published by the Free Software Foundation, =
and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef _LINUX_I2C_TEGRA_H
> +#define _LINUX_I2C_TEGRA_H
> +
> +struct tegra_i2c_platform_data {
> + =A0 =A0 =A0 unsigned long bus_clk_rate;
> +};
> +
> +#endif /* _LINUX_I2C_TEGRA_H */
> --
> 1.7.1
>
>

Ben, this didn't make it into 2.6.37?  Can it go into next-i2c?
