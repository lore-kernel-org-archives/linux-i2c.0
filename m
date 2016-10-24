From: Pandy Gao <pandy.gao@nxp.com>
Subject: RE: [Patch V3] i2c: imx: add low power i2c bus driver
Date: Mon, 24 Oct 2016 05:51:12 +0000
Message-ID: <HE1PR0401MB1787792E3863AB69CEE0D8B4F6A90@HE1PR0401MB1787.eurprd04.prod.outlook.com>
References: <1471420784-11727-1-git-send-email-pandy.gao@nxp.com>
 <VI1PR0401MB1791A799C3E1447559F436F7F6EC0@VI1PR0401MB1791.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0040.outbound.protection.outlook.com ([104.47.2.40]:26240
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752429AbcJXGGA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Oct 2016 02:06:00 -0400
In-Reply-To: <VI1PR0401MB1791A799C3E1447559F436F7F6EC0@VI1PR0401MB1791.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Pandy Gao <pandy.gao@nxp.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "cmo@melexis.com" <cmo@melexis.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Frank Li <frank.li@nxp.com>, Andy Duan <fugang.duan@nxp.com>

Ping...

> -----Original Message-----
> From: linux-i2c-owner@vger.kernel.org [mailto:linux-i2c-
> owner@vger.kernel.org] On Behalf Of Pan Gao
> Sent: Friday, August 26, 2016 3:37 PM
> To: wsa@the-dreams.de; u.kleine-koenig@pengutronix.de; cmo@melexis.com
> Cc: linux-i2c@vger.kernel.org; Frank Li <frank.li@nxp.com>; Fugang Duan
> <fugang.duan@nxp.com>
> Subject: RE: [Patch V3] i2c: imx: add low power i2c bus driver
>=20
> Ping...
>=20
> > -----Original Message-----
> > From: Pan Gao
> > Sent: Wednesday, August 17, 2016 4:00 PM
> > To: wsa@the-dreams.de; u.kleine-koenig@pengutronix.de;
> cmo@melexis.com
> > Cc: linux-i2c@vger.kernel.org; Frank Li <frank.li@nxp.com>; Fugang
> > Duan <fugang.duan@nxp.com>; Pan Gao <pandy.gao@nxp.com>
> > Subject: [Patch V3] i2c: imx: add low power i2c bus driver
> >
> > This patch adds low power i2c bus driver to support new i.MX products
> > which use low power i2c instead of the old imx i2c.
> >
> > The low power i2c can continue operating in stop mode when an
> > appropriate clock is available. It is also designed for low CPU
> > overhead with DMA offloading of FIFO register accesses.
> >
> > Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> > Reviewed-by: Fugang Duan <B38611@freescale.com>
> > ---
> > V2:
> >  -stop i2c transfer under the wrong condition  -add timeout check in
> > while() domain
> >
> > V3:
> >  -fix typo inside commit message and the driver.
> >
> >  .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |  25 +
> >  drivers/i2c/busses/Kconfig                         |  10 +
> >  drivers/i2c/busses/Makefile                        |   1 +
> >  drivers/i2c/busses/i2c-imx-lpi2c.c                 | 667 +++++++++++++=
++++++++
> >  4 files changed, 703 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
> > new file mode 100644
> > index 0000000..1f10cbf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
> > @@ -0,0 +1,25 @@
> > +* Freescale Low Power Inter IC (LPI2C) for i.MX
> > +
> > +Required properties:
> > +- compatible :
> > +  - "fsl,imx8dv-lpi2c" for LPI2C compatible with the one integrated
> > +on i.MX8DV soc
> > +  - "fsl,imx7ulp-lpi2c" for LPI2C compatible with the one integrated
> > +on i.MX7ULP soc
> > +- reg : Should contain LPI2C registers location and length
> > +- interrupts : Should contain LPI2C interrupt
> > +- clocks : Should contain LPI2C clock specifier
> > +- power-domains : should contain LPI2C power domain
> > +
> > +Optional properties:
> > +- clock-frequency : Constains desired LPI2C bus clock frequency in Hz.
> > +  The absence of the property indicates the default frequency 100 kHz.
> > +
> > +Examples:
> > +
> > +i2c1: i2c@5e110000 { /* LPI2C on i.MX8DV */
> > +	compatible =3D "fsl,imx8dv-lpi2c";
> > +	reg =3D <0x0 0x5e110000 0x0 0x4000>;
> > +	interrupts =3D <0 88 4>;
> > +	clocks =3D <&clk IMX8DV_I2C1_CLK>;
> > +	clock-names =3D "per";
> > +	power-domains =3D <&pd_lsio_i2c1>;
> > +};
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index
> > efa3d9b..1fc7a10 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -596,6 +596,16 @@ config I2C_IMX
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called i2c-imx.
> >
> > +config I2C_IMX_LPI2C
> > +	tristate "IMX Low Power I2C interface"
> > +	depends on ARCH_MXC || COMPILE_TEST
> > +	help
> > +          Say Y here if you want to use the Low Power IIC bus controll=
er
> > +          on the Freescale i.MX processors.
> > +
> > +          This driver can also be built as a module. If so, the module
> > +          will be called i2c-imx-lpi2c.
> > +
> >  config I2C_IOP3XX
> >  	tristate "Intel IOPx3xx and IXP4xx on-chip I2C interface"
> >  	depends on ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX ||
> ARCH_IOP13XX
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 37f2819..cc93457 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_I2C_HIX5HD2)	+=3D i2c-hix5hd2.o
> >  obj-$(CONFIG_I2C_IBM_IIC)	+=3D i2c-ibm_iic.o
> >  obj-$(CONFIG_I2C_IMG)		+=3D i2c-img-scb.o
> >  obj-$(CONFIG_I2C_IMX)		+=3D i2c-imx.o
> > +obj-$(CONFIG_I2C_IMX_LPI2C)	+=3D i2c-imx-lpi2c.o
> >  obj-$(CONFIG_I2C_IOP3XX)	+=3D i2c-iop3xx.o
> >  obj-$(CONFIG_I2C_JZ4780)	+=3D i2c-jz4780.o
> >  obj-$(CONFIG_I2C_KEMPLD)	+=3D i2c-kempld.o
> > diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c
> > b/drivers/i2c/busses/i2c-imx-lpi2c.c
> > new file mode 100644
> > index 0000000..308ecf5
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
> > @@ -0,0 +1,667 @@
> > +/*
> > + * This is i.MX low power i2c controller driver.
> > + *
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +
> > +#define DRIVER_NAME "imx-lpi2c"
> > +
> > +#define	LPI2C_PARAM	0x04	/* i2c RX/TX FIFO size */
> > +#define	LPI2C_MCR	0x10	/* i2c contrl register */
> > +#define	LPI2C_MSR	0x14	/* i2c status register */
> > +#define	LPI2C_MIER	0x18	/* i2c interrupt enable */
> > +#define	LPI2C_MCFGR0	0x20	/* i2c master configuration */
> > +#define	LPI2C_MCFGR1	0x24	/* i2c master configuration */
> > +#define	LPI2C_MCFGR2	0x28	/* i2c master configuration */
> > +#define	LPI2C_MCFGR3	0x2C	/* i2c master configuration */
> > +#define	LPI2C_MCCR0	0x48	/* i2c master clk configuration */
> > +#define	LPI2C_MCCR1	0x50	/* i2c master clk configuration */
> > +#define	LPI2C_MFCR	0x58	/* i2c master FIFO control */
> > +#define	LPI2C_MFSR	0x5C	/* i2c master FIFO status */
> > +#define	LPI2C_MTDR	0x60	/* i2c master TX data register */
> > +#define	LPI2C_MRDR	0x70	/* i2c master RX data register */
> > +
> > +/* i2c command */
> > +#define	TRAN_DATA	0X00
> > +#define	RECV_DATA	0X01
> > +#define	GEN_STOP	0X02
> > +#define	RECV_DISCARD	0X03
> > +#define	GEN_START	0X04
> > +#define	START_NACK	0X05
> > +#define	START_HIGH	0X06
> > +#define	START_HIGH_NACK	0X07
> > +
> > +#define	MCR_MEN		(1 << 0)
> > +#define	MCR_RST		(1 << 1)
> > +#define	MCR_DOZEN	(1 << 2)
> > +#define	MCR_DBGEN	(1 << 3)
> > +#define	MCR_RTF		(1 << 8)
> > +#define	MCR_RRF		(1 << 9)
> > +#define	MSR_TDF		(1 << 0)
> > +#define	MSR_RDF		(1 << 1)
> > +#define	MSR_SDF		(1 << 9)
> > +#define	MSR_NDF		(1 << 10)
> > +#define	MSR_ALF		(1 << 11)
> > +#define	MSR_MBF		(1 << 24)
> > +#define	MSR_BBF		(1 << 25)
> > +#define	MIER_TDIE	(1 << 0)
> > +#define	MIER_RDIE	(1 << 1)
> > +#define	MIER_SDIE	(1 << 9)
> > +#define	MIER_NDIE	(1 << 10)
> > +#define	MCFGR1_AUTOSTOP	(1 << 8)
> > +#define	MCFGR1_IGNACK	(1 << 9)
> > +#define	MRDR_RXEMPTY	(1 << 14)
> > +
> > +#define	I2C_CLK_RATIO	2
> > +#define	CHUNK_DATA	256
> > +
> > +#define LPI2C_RX_FIFOSIZE	4
> > +#define LPI2C_TX_FIFOSIZE	4
> > +
> > +#define	LPI2C_DEFAULT_RATE	100000
> > +#define	STARDARD_MAX_BITRATE	400000
> > +#define	FAST_MAX_BITRATE	1000000
> > +#define	FAST_PLUS_MAX_BITRATE	3400000
> > +#define	HIGHSPEED_MAX_BITRATE	5000000
> > +
> > +
> > +enum lpi2c_imx_mode {
> > +	STANDARD,	/* 100+Kbps */
> > +	FAST,		/* 400+Kbps */
> > +	FAST_PLUS,	/* 1.0+Mbps */
> > +	ULTRA_FAST,	/* 5.0+Mbps */
> > +	HS,		/* 3.4+Mbps */
> > +};
> > +
> > +enum lpi2c_imx_pincfg {
> > +	TWO_PIN_OD,	/* 2-pin open drain mode */
> > +	TWO_PIN_OO,	/* 2-pin output only mode (utra-fast mode) */
> > +	TWO_PIN_PP,	/* 2-pin push-pull mode */
> > +	FOUR_PIN_PP,	/* 4-pin push-pull mode */
> > +	TWO_PIN_OD_SS,	/* 2-pin open drain mode with separate slave
> */
> > +	TWO_PIN_OO_SS,	/* 2-pin output only mode with separate slave
> */
> > +	TWO_PIN_PP_SS,	/* 2-pin push-pull mode with separate slave */
> > +	FOUR_PIN_PP_IO,	/* 4-pin push-pull mode (inverted output) */
> > +};
> > +
> > +struct lpi2c_imx_clkcfg {
> > +	u8	prescale;
> > +	u8	filtscl;
> > +	u8	filtsda;
> > +	u8	sethold;
> > +	u8	clklo;
> > +	u8	clkhi;
> > +	u8	datavd;
> > +};
> > +
> > +struct lpi2c_imx_struct {
> > +	struct i2c_adapter	adapter;
> > +	struct clk		*per_clk;
> > +	void __iomem		*base;
> > +	__u8			*rx_buf;
> > +	__u8			*tx_buf;
> > +	struct completion	complete;
> > +	unsigned int		msglen;
> > +	unsigned int		delivered;
> > +	unsigned int		block_data;
> > +	unsigned int		bitrate;
> > +	enum lpi2c_imx_mode	mode;
> > +};
> > +
> > +static void lpi2c_imx_intctrl(
> > +		struct lpi2c_imx_struct *lpi2c_imx, unsigned int enable) {
> > +	writel(enable, lpi2c_imx->base + LPI2C_MIER); }
> > +
> > +static int lpi2c_imx_bus_busy(struct lpi2c_imx_struct *lpi2c_imx) {
> > +	unsigned long orig_jiffies =3D jiffies;
> > +	unsigned int temp;
> > +
> > +	while (1) {
> > +		temp =3D readl(lpi2c_imx->base + LPI2C_MSR);
> > +
> > +		/* check for arbitration lost, clear if set */
> > +		if (temp & MSR_ALF) {
> > +			writel(temp, lpi2c_imx->base + LPI2C_MSR);
> > +			return -EAGAIN;
> > +		}
> > +
> > +		if ((temp & MSR_BBF) && (temp & MSR_MBF))
> > +			break;
> > +
> > +		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
> > +			dev_dbg(&lpi2c_imx->adapter.dev, "bus not work\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +		schedule();
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void lpi2c_imx_set_mode(struct lpi2c_imx_struct *lpi2c_imx) {
> > +	enum lpi2c_imx_mode mode;
> > +	unsigned int bitrate =3D lpi2c_imx->bitrate;
> > +
> > +	if (bitrate < STARDARD_MAX_BITRATE)
> > +		mode =3D STANDARD;
> > +	else if (bitrate < FAST_MAX_BITRATE)
> > +		mode =3D FAST;
> > +	else if (bitrate < FAST_PLUS_MAX_BITRATE)
> > +		mode =3D FAST_PLUS;
> > +	else if (bitrate < HIGHSPEED_MAX_BITRATE)
> > +		mode =3D HS;
> > +	else
> > +		mode =3D ULTRA_FAST;
> > +
> > +	lpi2c_imx->mode =3D mode;
> > +}
> > +
> > +static int lpi2c_imx_start(struct lpi2c_imx_struct *lpi2c_imx,
> > +						struct i2c_msg *msgs)
> > +{
> > +	u8 read;
> > +	unsigned int temp;
> > +
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MCR);
> > +	temp |=3D MCR_RRF | MCR_RTF;
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> > +	writel(0x7f00, lpi2c_imx->base + LPI2C_MSR);
> > +
> > +	read =3D msgs->flags & I2C_M_RD;
> > +	temp =3D (msgs->addr << 1 | read) | (GEN_START << 8);
> > +	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> > +
> > +	return lpi2c_imx_bus_busy(lpi2c_imx); }
> > +
> > +static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx) {
> > +	unsigned int temp;
> > +	unsigned long orig_jiffies =3D jiffies;
> > +
> > +	writel(GEN_STOP << 8, lpi2c_imx->base + LPI2C_MTDR);
> > +	do {
> > +		temp =3D readl(lpi2c_imx->base + LPI2C_MSR);
> > +		if (temp & MSR_SDF)
> > +			break;
> > +
> > +		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
> > +			dev_dbg(&lpi2c_imx->adapter.dev, "stop timeout\n");
> > +			break;
> > +		}
> > +		schedule();
> > +
> > +	} while (1);
> > +}
> > +
> > +
> > +/* CLKLO =3D I2C_CLK_RATIO * CLKHI, SETHOLD =3D CLKHI, DATAVD =3D CLKH=
I/2
> > +*/ static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx) {
> > +	unsigned int temp;
> > +	unsigned int per_clk_rate;
> > +	unsigned int prescale, clk_high, clk_low, clk_cycle;
> > +	enum lpi2c_imx_pincfg pincfg;
> > +	struct lpi2c_imx_clkcfg clkcfg;
> > +
> > +	lpi2c_imx_set_mode(lpi2c_imx);
> > +	per_clk_rate =3D clk_get_rate(lpi2c_imx->per_clk);
> > +
> > +	if (lpi2c_imx->mode =3D=3D HS || lpi2c_imx->mode =3D=3D ULTRA_FAST)
> > +		clkcfg.filtscl =3D clkcfg.filtsda =3D 0;
> > +	else
> > +		clkcfg.filtscl =3D clkcfg.filtsda =3D 2;
> > +
> > +	for (prescale =3D 0; prescale <=3D 7; prescale++) {
> > +		clk_cycle =3D per_clk_rate / ((1 << prescale) * lpi2c_imx->bitrate)
> > +			    - 3 - (clkcfg.filtscl >> 1);
> > +		clk_high =3D (clk_cycle + I2C_CLK_RATIO) / (I2C_CLK_RATIO + 1);
> > +		clk_low =3D clk_cycle - clk_high;
> > +		if (clk_low < 64)
> > +			break;
> > +	}
> > +
> > +	if (prescale > 7)
> > +		return -EINVAL;
> > +
> > +	clkcfg.prescale =3D prescale;
> > +	clkcfg.sethold =3D clk_high;
> > +	clkcfg.clklo =3D clk_low;
> > +	clkcfg.clkhi =3D clk_high;
> > +	clkcfg.datavd =3D clk_high >> 1;
> > +
> > +	/* set MCFGR1: PINCFG, PRESCALE, IGNACK */
> > +	if (lpi2c_imx->mode =3D=3D ULTRA_FAST)
> > +		pincfg =3D TWO_PIN_OO;
> > +	else
> > +		pincfg =3D TWO_PIN_OD;
> > +	temp =3D clkcfg.prescale | pincfg << 24;
> > +
> > +	if (lpi2c_imx->mode =3D=3D ULTRA_FAST)
> > +		temp |=3D MCFGR1_IGNACK;
> > +
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCFGR1);
> > +
> > +	/* set MCFGR2: FILTSDA, FILTSCL */
> > +	temp =3D (clkcfg.filtscl << 16) | (clkcfg.filtsda << 24);
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCFGR2);
> > +
> > +
> > +	/* set MCCR: DATAVD, SETHOLD, CLKHI, CLKLO */
> > +	temp =3D clkcfg.datavd << 24 | clkcfg.sethold << 16 |
> > +				clkcfg.clkhi << 8 | clkcfg.clklo;
> > +
> > +	if (lpi2c_imx->mode =3D=3D HS)
> > +		writel(temp, lpi2c_imx->base + LPI2C_MCCR1);
> > +	else
> > +		writel(temp, lpi2c_imx->base + LPI2C_MCCR0);
> > +
> > +	return 0;
> > +}
> > +
> > +static int lpi2c_imx_master_enable(struct lpi2c_imx_struct
> > +*lpi2c_imx) {
> > +	int ret;
> > +	unsigned int temp;
> > +
> > +	ret =3D clk_prepare_enable(lpi2c_imx->per_clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	temp =3D MCR_RST;
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> > +	writel(0, lpi2c_imx->base + LPI2C_MCR);
> > +
> > +	ret =3D lpi2c_imx_config(lpi2c_imx);
> > +	if (ret)
> > +		return ret;
> > +
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MCR);
> > +	temp |=3D MCR_MEN;
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> > +
> > +	return 0;
> > +}
> > +
> > +static int lpi2c_imx_master_disable(struct lpi2c_imx_struct
> > +*lpi2c_imx) {
> > +	unsigned int temp =3D 0;
> > +
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MCR);
> > +	temp &=3D ~MCR_MEN;
> > +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> > +
> > +	clk_disable_unprepare(lpi2c_imx->per_clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static int lpi2c_imx_msg_complete(struct lpi2c_imx_struct *lpi2c_imx) =
{
> > +	unsigned int timeout;
> > +
> > +	timeout =3D wait_for_completion_timeout(&lpi2c_imx->complete, HZ);
> > +
> > +	return timeout ? 0 : -ETIMEDOUT;
> > +}
> > +
> > +static int lpi2c_imx_txfifo_empty(struct lpi2c_imx_struct *lpi2c_imx) =
{
> > +	u32 txcnt;
> > +	unsigned long orig_jiffies =3D jiffies;
> > +
> > +	do {
> > +		txcnt =3D readl(lpi2c_imx->base + LPI2C_MFSR) & 0xff;
> > +
> > +		if (readl(lpi2c_imx->base + LPI2C_MSR) & MSR_NDF) {
> > +			dev_dbg(&lpi2c_imx->adapter.dev, "NDF detected\n");
> > +			return -EIO;
> > +		}
> > +
> > +		if (time_after(jiffies, orig_jiffies + msecs_to_jiffies(500))) {
> > +			dev_dbg(&lpi2c_imx->adapter.dev, "txfifo empty
> > timeout\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +		schedule();
> > +
> > +	} while (txcnt);
> > +
> > +	return 0;
> > +}
> > +
> > +static void lpi2c_imx_set_tx_watermark(struct lpi2c_imx_struct
> > +*lpi2c_imx) {
> > +	unsigned int temp;
> > +
> > +	temp =3D LPI2C_TX_FIFOSIZE >> 1;
> > +	writel(temp, lpi2c_imx->base + LPI2C_MFCR); }
> > +
> > +static void lpi2c_imx_set_rx_watermark(struct lpi2c_imx_struct
> > +*lpi2c_imx) {
> > +	unsigned int temp, remaining;
> > +
> > +	remaining =3D lpi2c_imx->msglen - lpi2c_imx->delivered;
> > +
> > +	if (remaining > (LPI2C_RX_FIFOSIZE >> 1))
> > +		temp =3D LPI2C_RX_FIFOSIZE >> 1;
> > +	else
> > +		temp =3D 0;
> > +
> > +	writel(temp << 16, lpi2c_imx->base + LPI2C_MFCR); }
> > +
> > +static void lpi2c_imx_write_txfifo(struct lpi2c_imx_struct
> > +*lpi2c_imx) {
> > +	unsigned int data, txcnt;
> > +
> > +	txcnt =3D readl(lpi2c_imx->base + LPI2C_MFSR) & 0xff;
> > +	while (txcnt < LPI2C_TX_FIFOSIZE) {
> > +		if (lpi2c_imx->delivered =3D=3D lpi2c_imx->msglen)
> > +			break;
> > +		data =3D lpi2c_imx->tx_buf[lpi2c_imx->delivered++];
> > +		writel(data, lpi2c_imx->base + LPI2C_MTDR);
> > +		txcnt++;
> > +	}
> > +
> > +	if (lpi2c_imx->delivered < lpi2c_imx->msglen)
> > +		lpi2c_imx_intctrl(lpi2c_imx, MIER_TDIE | MIER_NDIE);
> > +	else
> > +		complete(&lpi2c_imx->complete);
> > +}
> > +
> > +static void lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx) =
{
> > +	unsigned int temp, data;
> > +	unsigned int blocklen, remaining;
> > +
> > +	do {
> > +		data =3D readl(lpi2c_imx->base + LPI2C_MRDR);
> > +		if (data & MRDR_RXEMPTY)
> > +			break;
> > +		lpi2c_imx->rx_buf[lpi2c_imx->delivered++] =3D data & 0xff;
> > +	} while (1);
> > +
> > +	/*
> > +	 * First byte is the length of remaining packet in the SMBus block
> > +	 * data read. Add it to msgs->len.
> > +	 */
> > +	if (lpi2c_imx->block_data) {
> > +		blocklen =3D lpi2c_imx->rx_buf[0];
> > +		lpi2c_imx->msglen +=3D blocklen;
> > +	}
> > +
> > +	remaining =3D lpi2c_imx->msglen - lpi2c_imx->delivered;
> > +	/* not finished, still waiting for rx data */
> > +	if (remaining) {
> > +		lpi2c_imx_set_rx_watermark(lpi2c_imx);
> > +		/* multiple receive commands */
> > +		if (lpi2c_imx->block_data) {
> > +			lpi2c_imx->block_data =3D 0;
> > +			temp =3D remaining;
> > +			temp |=3D (RECV_DATA << 8);
> > +			writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> > +		} else if (!(lpi2c_imx->delivered & 0xff)) {
> > +			temp =3D remaining > CHUNK_DATA ?
> > +				CHUNK_DATA - 1 : (remaining - 1);
> > +			temp |=3D (RECV_DATA << 8);
> > +			writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> > +		}
> > +
> > +		lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE);
> > +	} else
> > +		complete(&lpi2c_imx->complete);
> > +}
> > +
> > +static void lpi2c_imx_write(struct lpi2c_imx_struct *lpi2c_imx,
> > +							struct i2c_msg *msgs)
> > +{
> > +	lpi2c_imx->tx_buf =3D msgs->buf;
> > +	lpi2c_imx_set_tx_watermark(lpi2c_imx);
> > +	lpi2c_imx_write_txfifo(lpi2c_imx);
> > +}
> > +
> > +static void lpi2c_imx_read(struct lpi2c_imx_struct *lpi2c_imx,
> > +							struct i2c_msg *msgs)
> > +{
> > +	unsigned int temp;
> > +
> > +	lpi2c_imx->rx_buf =3D msgs->buf;
> > +	lpi2c_imx->block_data =3D msgs->flags & I2C_M_RECV_LEN;
> > +
> > +	lpi2c_imx_set_rx_watermark(lpi2c_imx);
> > +	temp =3D msgs->len > CHUNK_DATA ? CHUNK_DATA - 1 : msgs->len - 1;
> > +	temp |=3D (RECV_DATA << 8);
> > +	writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> > +
> > +	lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE | MIER_NDIE); }
> > +
> > +static int lpi2c_imx_xfer(struct i2c_adapter *adapter,
> > +						struct i2c_msg *msgs, int num)
> > +{
> > +	int i, result;
> > +	unsigned int temp;
> > +	struct lpi2c_imx_struct *lpi2c_imx =3D i2c_get_adapdata(adapter);
> > +
> > +	result =3D lpi2c_imx_master_enable(lpi2c_imx);
> > +	if (result)
> > +		return result;
> > +
> > +	for (i =3D 0; i < num; i++) {
> > +		result =3D lpi2c_imx_start(lpi2c_imx, &msgs[i]);
> > +		if (result)
> > +			goto disable;
> > +
> > +		/* quick smbus */
> > +		if (num =3D=3D 1 && msgs[0].len =3D=3D 0)
> > +			goto stop;
> > +
> > +		lpi2c_imx->delivered =3D 0;
> > +		lpi2c_imx->msglen =3D msgs[i].len;
> > +		init_completion(&lpi2c_imx->complete);
> > +
> > +		if (msgs[i].flags & I2C_M_RD)
> > +			lpi2c_imx_read(lpi2c_imx, &msgs[i]);
> > +		else
> > +			lpi2c_imx_write(lpi2c_imx, &msgs[i]);
> > +
> > +		result =3D lpi2c_imx_msg_complete(lpi2c_imx);
> > +		if (result)
> > +			goto stop;
> > +
> > +		if (!(msgs[i].flags & I2C_M_RD)) {
> > +			result =3D lpi2c_imx_txfifo_empty(lpi2c_imx);
> > +			if (result)
> > +				goto stop;
> > +		}
> > +	}
> > +
> > +stop:
> > +	lpi2c_imx_stop(lpi2c_imx);
> > +
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MSR);
> > +	if ((temp & MSR_NDF) && !result)
> > +		result =3D -EIO;
> > +
> > +disable:
> > +	lpi2c_imx_master_disable(lpi2c_imx);
> > +
> > +	dev_dbg(&lpi2c_imx->adapter.dev, "<%s> exit with: %s: %d\n",
> __func__,
> > +		(result < 0) ? "error" : "success msg",
> > +		(result < 0) ? result : num);
> > +
> > +	return (result < 0) ? result : num;
> > +}
> > +
> > +static irqreturn_t lpi2c_imx_isr(int irq, void *dev_id) {
> > +	unsigned int temp;
> > +	struct lpi2c_imx_struct *lpi2c_imx =3D dev_id;
> > +
> > +	lpi2c_imx_intctrl(lpi2c_imx, 0);
> > +	temp =3D readl(lpi2c_imx->base + LPI2C_MSR);
> > +
> > +	if (temp & MSR_RDF) {
> > +		lpi2c_imx_read_rxfifo(lpi2c_imx);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (temp & MSR_TDF) {
> > +		lpi2c_imx_write_txfifo(lpi2c_imx);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	complete(&lpi2c_imx->complete);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static u32 lpi2c_imx_func(struct i2c_adapter *adapter) {
> > +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL
> > +		| I2C_FUNC_SMBUS_READ_BLOCK_DATA;
> > +}
> > +
> > +static struct i2c_algorithm lpi2c_imx_algo =3D {
> > +	.master_xfer	=3D lpi2c_imx_xfer,
> > +	.functionality	=3D lpi2c_imx_func,
> > +};
> > +
> > +static const struct of_device_id lpi2c_imx_of_match[] =3D {
> > +	{ .compatible =3D "fsl,imx8dv-lpi2c" },
> > +	{ .compatible =3D "fsl,imx7ulp-lpi2c" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, lpi2c_imx_of_match)
> > +
> > +static int lpi2c_imx_probe(struct platform_device *pdev) {
> > +	int irq, ret;
> > +	void __iomem *base;
> > +	struct resource *res;
> > +	struct lpi2c_imx_struct *lpi2c_imx;
> > +
> > +	lpi2c_imx =3D devm_kzalloc(&pdev->dev,
> > +				sizeof(*lpi2c_imx), GFP_KERNEL);
> > +	if (!lpi2c_imx)
> > +		return -ENOMEM;
> > +
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	base =3D devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);
> > +
> > +	irq =3D platform_get_irq(pdev, 0);
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "can't get irq number\n");
> > +		return irq;
> > +	}
> > +
> > +	lpi2c_imx->adapter.owner	=3D THIS_MODULE;
> > +	lpi2c_imx->adapter.algo		=3D &lpi2c_imx_algo;
> > +	lpi2c_imx->adapter.dev.parent	=3D &pdev->dev;
> > +	lpi2c_imx->adapter.nr		=3D pdev->id;
> > +	lpi2c_imx->base			=3D base;
> > +	lpi2c_imx->adapter.dev.of_node	=3D pdev->dev.of_node;
> > +	strlcpy(lpi2c_imx->adapter.name, pdev->name,
> > +				sizeof(lpi2c_imx->adapter.name));
> > +
> > +	lpi2c_imx->per_clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(lpi2c_imx->per_clk)) {
> > +		dev_err(&pdev->dev, "can't get I2C peripheral clock\n");
> > +		return PTR_ERR(lpi2c_imx->per_clk);
> > +	}
> > +
> > +	ret =3D of_property_read_u32(pdev->dev.of_node,
> > +				   "clock-frequency", &lpi2c_imx->bitrate);
> > +	if (ret)
> > +		lpi2c_imx->bitrate =3D LPI2C_DEFAULT_RATE;
> > +
> > +	ret =3D devm_request_irq(&pdev->dev, irq, lpi2c_imx_isr, 0,
> > +				pdev->name, lpi2c_imx);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> > +		goto ret;
> > +	}
> > +
> > +	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
> > +	platform_set_drvdata(pdev, lpi2c_imx);
> > +
> > +	ret =3D i2c_add_numbered_adapter(&lpi2c_imx->adapter);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "registration failed\n");
> > +		goto ret;
> > +	}
> > +
> > +	dev_info(&lpi2c_imx->adapter.dev, "LPI2C adapter registered\n");
> > +
> > +ret:
> > +	return ret;
> > +}
> > +
> > +static int lpi2c_imx_remove(struct platform_device *pdev) {
> > +	struct lpi2c_imx_struct *lpi2c_imx =3D platform_get_drvdata(pdev);
> > +
> > +	i2c_del_adapter(&lpi2c_imx->adapter);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver lpi2c_imx_driver =3D {
> > +	.probe =3D lpi2c_imx_probe,
> > +	.remove =3D lpi2c_imx_remove,
> > +	.driver =3D {
> > +		.name =3D DRIVER_NAME,
> > +		.of_match_table =3D lpi2c_imx_of_match,
> > +	},
> > +};
> > +
> > +static int __init i2c_adap_imx_init(void) {
> > +	return platform_driver_register(&lpi2c_imx_driver);
> > +}
> > +module_init(i2c_adap_imx_init);
> > +
> > +static void __exit i2c_adap_imx_exit(void) {
> > +	platform_driver_unregister(&lpi2c_imx_driver);
> > +}
> > +module_exit(i2c_adap_imx_exit);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
> > MODULE_DESCRIPTION("I2C
> > +adapter driver for LPI2C bus"); MODULE_ALIAS("platform:"
> > +DRIVER_NAME);
> > --
> > 1.9.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in t=
he body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
