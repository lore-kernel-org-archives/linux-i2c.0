From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [V2 1/2] i2c: brcmstb: Add Broadcom settop SoC i2c controller
 driver
Date: Tue, 14 Apr 2015 15:47:40 +0200
Message-ID: <20150414134740.GB1375@katana>
References: <1428004866-13543-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428004866-13543-1-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2015 at 04:01:05PM -0400, Kamal Dasu wrote:
> Adding support for i2c controller driver for Broadcom settop
> SoCs.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Wow, this is the third I2C master driver coming from Broadcom in a
pretty short time. May I ask the authors of the previous Broadcom
drivers (CCed) to do the initial review?

Thanks,

   Wolfram

> ---
> V2 changes
>  - Separate commits for device tree bindings and
>    initial i2c-brcmstb driver code
> ---
>  drivers/i2c/busses/Kconfig       |  10 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-brcmstb.c | 703 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 714 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-brcmstb.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 22da9c2..e3938f4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -392,6 +392,16 @@ config I2C_BCM_KONA
> =20
>  	  If you do not need KONA I2C interface, say N.
> =20
> +config I2C_BRCMSTB
> +	tristate "BRCM Settop I2C adapter"
> +	depends on ARCH_BRCMSTB
> +	default y
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  I2C interface on the Broadcom Settop SoCs.
> +
> +	  If you do not need I2C interface, say N.
> +
>  config I2C_BLACKFIN_TWI
>  	tristate "Blackfin TWI I2C support"
>  	depends on BLACKFIN
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3638feb..91a0b5f 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_I2C_VIPERBOARD)	+=3D i2c-viperboard.o
>  # Other I2C/SMBus bus drivers
>  obj-$(CONFIG_I2C_ACORN)		+=3D i2c-acorn.o
>  obj-$(CONFIG_I2C_BCM_KONA)	+=3D i2c-bcm-kona.o
> +obj-$(CONFIG_I2C_BRCMSTB)	+=3D i2c-brcmstb.o
>  obj-$(CONFIG_I2C_CROS_EC_TUNNEL)	+=3D i2c-cros-ec-tunnel.o
>  obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o
>  obj-$(CONFIG_I2C_OPAL)		+=3D i2c-opal.o
> diff --git a/drivers/i2c/busses/i2c-brcmstb.c b/drivers/i2c/busses/i2c-br=
cmstb.c
> new file mode 100644
> index 0000000..b69ab14
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-brcmstb.c
> @@ -0,0 +1,703 @@
> +/*
> + * Copyright (C) 2014 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/clk.h>
> +#include <linux/slab.h>
> +#include <linux/version.h>
> +#include <linux/delay.h>
> +
> +#define N_DATA_REGS					8
> +#define N_DATA_BYTES					(N_DATA_REGS * 4)
> +
> +/* BSC count register field definitions */
> +#define BSC_CNT_REG1_MASK				0x0000003f
> +#define BSC_CNT_REG1_SHIFT				0
> +#define BSC_CNT_REG2_MASK				0x00000fc0
> +#define BSC_CNT_REG2_SHIFT				6
> +
> +/* BSC CTL register field definitions */
> +#define BSC_CTL_REG_DTF_MASK				0x00000003
> +#define BSC_CTL_REG_SCL_SEL_MASK			0x00000030
> +#define BSC_CTL_REG_SCL_SEL_SHIFT			4
> +#define BSC_CTL_REG_INT_EN_MASK				0x00000040
> +#define BSC_CTL_REG_INT_EN_SHIFT			6
> +#define BSC_CTL_REG_DIV_CLK_MASK			0x00000080
> +
> +/* BSC_IIC_ENABLE r/w enable and interrupt field defintions */
> +#define BSC_IIC_EN_RESTART_MASK				0x00000040
> +#define BSC_IIC_EN_NOSTART_MASK				0x00000020
> +#define BSC_IIC_EN_NOSTOP_MASK				0x00000010
> +#define BSC_IIC_EN_NOACK_MASK				0x00000004
> +#define BSC_IIC_EN_INTRP_MASK				0x00000002
> +#define BSC_IIC_EN_ENABLE_MASK				0x00000001
> +
> +/* BSC_CTLHI control register field definitions */
> +#define BSC_CTLHI_REG_INPUT_SWITCHING_LEVEL_MASK	0x00000080
> +#define BSC_CTLHI_REG_DATAREG_SIZE_MASK			0x00000040
> +#define BSC_CTLHI_REG_IGNORE_ACK_MASK			0x00000002
> +#define BSC_CTLHI_REG_WAIT_DIS_MASK			0x00000001
> +
> +#define I2C_TIMEOUT					100 /* msecs */
> +
> +/* Condition mask used for non combined transfer */
> +#define COND_RESTART		BSC_IIC_EN_RESTART_MASK
> +#define COND_NOSTART		BSC_IIC_EN_NOSTART_MASK
> +#define	COND_NOSTOP		BSC_IIC_EN_NOSTOP_MASK
> +#define COND_START_STOP		(COND_RESTART | COND_NOSTART | COND_NOSTOP)
> +
> +/* BSC data transfer direction */
> +#define DTF_WR_MASK		0x00000000
> +#define DTF_RD_MASK		0x00000001
> +/* BSC data transfer direction combined format */
> +#define DTF_RD_WR_MASK		0x00000002
> +#define DTF_WR_RD_MASK		0x00000003
> +/* default bus speed  */
> +#define DEFAULT_BUS_SPEEDHZ     375000
> +
> +struct bsc_regs {
> +	u32	chip_address;
> +	u32	data_in[N_DATA_REGS];
> +	u32	cnt_reg;
> +	u32	ctl_reg;
> +	u32	iic_enable;
> +	u32	data_out[N_DATA_REGS];
> +	u32	ctlhi_reg;
> +	u32	scl_param;
> +};
> +
> +struct bsc_clk_param {
> +	u32 hz;
> +	u32 scl_mask;
> +	u32 div_mask;
> +};
> +
> +enum bsc_xfer_cmd {
> +	CMD_WR,
> +	CMD_RD,
> +	CMD_WR_NOACK,
> +	CMD_RD_NOACK,
> +};
> +
> +static char const *cmd_string[] =3D {
> +	[CMD_WR] =3D "WR",
> +	[CMD_RD] =3D "RD",
> +	[CMD_WR_NOACK] =3D "WR NOACK",
> +	[CMD_RD_NOACK] =3D "RD NOACK",
> +};
> +
> +enum bus_speeds {
> +	SPD_375K,
> +	SPD_390K,
> +	SPD_187K,
> +	SPD_200K,
> +	SPD_93K,
> +	SPD_97K,
> +	SPD_46K,
> +	SPD_50K
> +};
> +
> +static const struct bsc_clk_param  bsc_clk[] =3D {
> +	[SPD_375K] =3D {
> +		.hz =3D 375000,
> +		.scl_mask =3D SPD_375K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D 0
> +	},
> +	[SPD_390K] =3D {
> +		.hz =3D 390000,
> +		.scl_mask =3D SPD_390K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D 0
> +	},
> +	[SPD_187K] =3D {
> +		.hz =3D 187500,
> +		.scl_mask =3D SPD_187K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D 0
> +	},
> +	[SPD_200K] =3D {
> +		.hz =3D 200000,
> +		.scl_mask =3D SPD_200K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D 0
> +	},
> +	[SPD_93K]  =3D {
> +		.hz =3D 93750,
> +		.scl_mask =3D SPD_375K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D BSC_CTL_REG_DIV_CLK_MASK
> +	},
> +	[SPD_97K]  =3D {
> +		.hz =3D 97500,
> +		.scl_mask =3D SPD_390K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D BSC_CTL_REG_DIV_CLK_MASK
> +	},
> +	[SPD_46K]  =3D {
> +		.hz =3D 46875,
> +		.scl_mask =3D SPD_187K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D BSC_CTL_REG_DIV_CLK_MASK
> +	},
> +	[SPD_50K]  =3D {
> +		.hz =3D 50000,
> +		.scl_mask =3D SPD_200K << BSC_CTL_REG_SCL_SEL_SHIFT,
> +		.div_mask =3D BSC_CTL_REG_DIV_CLK_MASK
> +	}
> +};
> +
> +struct brcmstb_i2c_dev {
> +	struct device *device;
> +	void __iomem *base;
> +	void __iomem *irq_base;
> +	int irq;
> +	struct bsc_regs *bsc_regmap;
> +	struct i2c_adapter adapter;
> +	struct completion done;
> +	bool is_suspended;
> +	u32 clk_freq_hz;
> +};
> +
> +#define bsc_readl(_dev, reg)						\
> +	__bsc_readl(_dev, offsetof(struct bsc_regs, reg))
> +
> +#define bsc_writel(_dev, val, reg)					\
> +	__bsc_writel(_dev, val, offsetof(struct bsc_regs, reg))
> +
> +static inline u32 __bsc_readl(struct brcmstb_i2c_dev *dev, u32 reg)
> +{
> +	return __raw_readl(dev->base + reg);
> +}
> +
> +static inline void __bsc_writel(struct brcmstb_i2c_dev *dev, u32 val,
> +				  u32 reg)
> +{
> +	__raw_writel(val, dev->base + reg);
> +}
> +
> +static void brcmstb_i2c_disable_irq(struct brcmstb_i2c_dev *dev)
> +{
> +	/* Disable BSC CTL interrupt line */
> +	dev->bsc_regmap->ctl_reg &=3D ~BSC_CTL_REG_INT_EN_MASK;
> +	barrier();
> +	bsc_writel(dev, dev->bsc_regmap->ctl_reg, ctl_reg);
> +}
> +
> +static void brcmstb_i2c_enable_irq(struct brcmstb_i2c_dev *dev)
> +{
> +	/* Enable BSC  CTL interrupt line */
> +	dev->bsc_regmap->ctl_reg |=3D BSC_CTL_REG_INT_EN_MASK;
> +	barrier();
> +	bsc_writel(dev, dev->bsc_regmap->ctl_reg, ctl_reg);
> +}
> +
> +static irqreturn_t brcmstb_i2c_isr(int irq, void *devid)
> +{
> +	struct brcmstb_i2c_dev *dev =3D devid;
> +	u32 status_bsc_ctl =3D bsc_readl(dev, ctl_reg);
> +	u32 status_iic_intrp =3D bsc_readl(dev, iic_enable);
> +
> +	dev_dbg(dev->device, "isr CTL_REG %x IIC_EN %x\n",
> +		status_bsc_ctl, status_iic_intrp);
> +
> +	if (!(status_bsc_ctl & BSC_CTL_REG_INT_EN_MASK))
> +		return IRQ_NONE;
> +
> +	brcmstb_i2c_disable_irq(dev);
> +	complete_all(&dev->done);
> +
> +	dev_dbg(dev->device, "isr handled");
> +	return IRQ_HANDLED;
> +}
> +
> +/* Wait for device to be ready */
> +static int brcmstb_i2c_wait_if_busy(struct brcmstb_i2c_dev *dev)
> +{
> +	unsigned long timeout =3D jiffies + msecs_to_jiffies(I2C_TIMEOUT);
> +
> +	while ((bsc_readl(dev, iic_enable) & BSC_IIC_EN_INTRP_MASK)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(dev->device, "i2c device busy timeout\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/* i2c xfer completion function, handles both irq and polling mode
> + */
> +static int brcmstb_i2c_waitforcompletion(struct brcmstb_i2c_dev *dev)
> +{
> +	int ret =3D 0;
> +	unsigned long timeout =3D msecs_to_jiffies(I2C_TIMEOUT);
> +
> +	if (dev->irq >=3D 0) {
> +		if (!wait_for_completion_timeout(&dev->done, timeout))
> +			ret =3D -ETIMEDOUT;
> +	} else {
> +		/* we are in polling mode */
> +		u32 bsc_intrp;
> +		unsigned long time_left =3D jiffies + timeout;
> +
> +		do {
> +			bsc_intrp =3D bsc_readl(dev, iic_enable) &
> +				BSC_IIC_EN_INTRP_MASK;
> +			if (time_after(jiffies, time_left)) {
> +				ret =3D -ETIMEDOUT;
> +				break;
> +			}
> +			udelay(100);
> +		} while (!bsc_intrp);
> +		brcmstb_i2c_disable_irq(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Set xfer START/STOP conditions for subsequent transfer */
> +static void brcmstb_set_i2c_start_stop(struct brcmstb_i2c_dev *dev,
> +				       u32 cond_flag)
> +{
> +	u32 regval =3D dev->bsc_regmap->iic_enable;
> +
> +	dev->bsc_regmap->iic_enable =3D (regval & ~COND_START_STOP) | cond_flag;
> +}
> +
> +/* Send I2C request */
> +static int brcmstb_send_i2c_cmd(struct brcmstb_i2c_dev *dev,
> +				enum bsc_xfer_cmd cmd)
> +{
> +	int rc =3D 0, ignore_ack =3D 0;
> +	struct bsc_regs *pi2creg =3D dev->bsc_regmap;
> +	u32 ctl_reg;
> +
> +	/* Make sure the hardware is ready */
> +	rc =3D brcmstb_i2c_wait_if_busy(dev);
> +	if (rc < 0)
> +		return rc;
> +
> +	dev_dbg(dev->device, "%s, %d\n", __func__, cmd);
> +
> +	/* see if the transaction needs check NACK conditions */
> +	ignore_ack =3D (cmd =3D=3D CMD_WR || cmd =3D=3D CMD_RD) ? 0 : 1;
> +	if (ignore_ack)
> +		pi2creg->ctlhi_reg |=3D BSC_CTLHI_REG_IGNORE_ACK_MASK;
> +	else
> +		pi2creg->ctlhi_reg &=3D ~BSC_CTLHI_REG_IGNORE_ACK_MASK;
> +	bsc_writel(dev, pi2creg->ctlhi_reg, ctlhi_reg);
> +
> +	if (dev->irq >=3D 0)
> +		reinit_completion(&dev->done);
> +
> +	/* set data transfer direction */
> +	ctl_reg =3D pi2creg->ctl_reg & ~BSC_CTL_REG_DTF_MASK;
> +	if (cmd =3D=3D CMD_WR || cmd =3D=3D CMD_WR_NOACK)
> +		pi2creg->ctl_reg =3D ctl_reg | DTF_WR_MASK;
> +	else
> +		pi2creg->ctl_reg =3D ctl_reg | DTF_RD_MASK;
> +
> +	/* enable BSC CTL interrupt line */
> +	brcmstb_i2c_enable_irq(dev);
> +
> +	/* initiate transfer by setting iic_enable */
> +	pi2creg->iic_enable |=3D BSC_IIC_EN_ENABLE_MASK;
> +	bsc_writel(dev, pi2creg->iic_enable, iic_enable);
> +
> +	/* Wait for transaction to finish or timeout */
> +	rc =3D brcmstb_i2c_waitforcompletion(dev);
> +	if (rc) {
> +		dev_err(dev->device, "intr timeout for cmd %s\n",
> +			cmd_string[cmd]);
> +		goto cmd_out;
> +	}
> +
> +	if (!ignore_ack && bsc_readl(dev, iic_enable) & BSC_IIC_EN_NOACK_MASK) {
> +		rc =3D -EREMOTEIO;
> +		dev_dbg(dev->device, "controller received NOACK intr for %s\n",
> +			cmd_string[cmd]);
> +	}
> +
> +cmd_out:
> +	bsc_writel(dev, 0, cnt_reg);
> +	bsc_writel(dev, 0, iic_enable);
> +
> +	return rc;
> +}
> +
> +static int brcmstb_i2c_xfer_bsc_data(struct brcmstb_i2c_dev *dev,
> +				     u8 *buf, unsigned int len,
> +				     enum bsc_xfer_cmd cmd)
> +{
> +	int i, j, rc;
> +
> +	/* set the read/write length */
> +	bsc_writel(dev, BSC_CNT_REG1_MASK & (len << BSC_CNT_REG1_SHIFT),
> +		   cnt_reg);
> +
> +	/* Write data into data_in register */
> +	if (cmd =3D=3D CMD_WR || cmd =3D=3D CMD_WR_NOACK) {
> +		for (i =3D 0; i < len; i +=3D 4) {
> +			u32 word =3D 0;
> +
> +			for (j =3D 0; j < 4; j++) {
> +				word >>=3D 8;
> +				if ((i + j) < len)
> +					word |=3D buf[i + j] << 24;
> +			}
> +			bsc_writel(dev, word, data_in[i >> 2]);
> +		}
> +	}
> +
> +	/* Initiate xfer */
> +	rc =3D brcmstb_send_i2c_cmd(dev, cmd);
> +
> +	if (rc !=3D 0)
> +		return rc;
> +
> +	if (cmd =3D=3D CMD_RD || cmd =3D=3D CMD_RD_NOACK) {
> +		for (i =3D 0; i < len; i +=3D 4) {
> +			u32 data =3D bsc_readl(dev, data_out[i >> 2]);
> +
> +			for (j =3D 0; j < 4 && (j + i) < len; j++) {
> +				buf[i + j] =3D data & 0xff;
> +				data >>=3D 8;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/* Write a single byte of data to the i2c bus */
> +static int brcmstb_i2c_write_data_byte(struct brcmstb_i2c_dev *dev,
> +				       u8 *buf, unsigned int nak_expected)
> +{
> +	enum bsc_xfer_cmd cmd =3D nak_expected ? CMD_WR : CMD_WR_NOACK;
> +
> +	bsc_writel(dev, 1, cnt_reg);
> +	bsc_writel(dev, *buf, data_in);
> +
> +	return brcmstb_send_i2c_cmd(dev, cmd);
> +}
> +
> +/* Send i2c address */
> +static int brcmstb_i2c_do_addr(struct brcmstb_i2c_dev *dev,
> +			       struct i2c_msg *msg)
> +{
> +	unsigned char addr;
> +
> +	if (msg->flags & I2C_M_TEN) {
> +
> +		/* First byte is 11110XX0 where XX is upper 2 bits */
> +		addr =3D 0xF0 | ((msg->addr & 0x300) >> 7);
> +		bsc_writel(dev, addr, chip_address);
> +
> +		/* Second byte is the remaining 8 bits */
> +		addr =3D msg->addr & 0xFF;
> +		if (brcmstb_i2c_write_data_byte(dev, &addr, 0) < 0)
> +			return -EREMOTEIO;
> +
> +		if (msg->flags & I2C_M_RD) {
> +			/* For read, send restart without stop condition */
> +			brcmstb_set_i2c_start_stop(dev, COND_RESTART
> +						   | COND_NOSTOP);
> +			/* Then re-send the first byte with the read bit set */
> +			addr =3D 0xF0 | ((msg->addr & 0x300) >> 7) | 0x01;
> +			if (brcmstb_i2c_write_data_byte(dev, &addr, 0) < 0)
> +				return -EREMOTEIO;
> +
> +		}
> +	} else {
> +		addr =3D msg->addr << 1;
> +		if (msg->flags & I2C_M_RD)
> +			addr |=3D 1;
> +
> +		bsc_writel(dev, addr, chip_address);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Master transfer function */
> +static int brcmstb_i2c_xfer(struct i2c_adapter *adapter,
> +			    struct i2c_msg msgs[], int num)
> +{
> +	struct brcmstb_i2c_dev *dev =3D i2c_get_adapdata(adapter);
> +	struct i2c_msg *pmsg;
> +	int rc =3D 0;
> +	int i;
> +	int bytes_to_xfer;
> +	enum bsc_xfer_cmd cmd;
> +	u8 *tmp_buf;
> +	int len =3D 0;
> +	int ignore_nack =3D 0;
> +
> +	if (dev->is_suspended)
> +		return -EBUSY;
> +
> +	/* Loop through all messages */
> +	for (i =3D 0; i < num; i++) {
> +		pmsg =3D &msgs[i];
> +		len =3D pmsg->len;
> +		tmp_buf =3D pmsg->buf;
> +		ignore_nack =3D pmsg->flags & I2C_M_IGNORE_NAK;
> +
> +		dev_dbg(dev->device,
> +			"msg# %d/%d flg %x buf %x len %d\n", i,
> +			num - 1, pmsg->flags,
> +			pmsg->buf ? pmsg->buf[0] : '0', pmsg->len);
> +
> +		if (i < (num - 1) && (msgs[i + 1].flags & I2C_M_NOSTART))
> +			brcmstb_set_i2c_start_stop(dev, ~(COND_START_STOP));
> +		else
> +			brcmstb_set_i2c_start_stop(dev,
> +						   COND_RESTART | COND_NOSTOP);
> +
> +		/* Send slave address */
> +		if (!(pmsg->flags & I2C_M_NOSTART)) {
> +			rc =3D brcmstb_i2c_do_addr(dev, pmsg);
> +			if (rc < 0) {
> +				dev_dbg(dev->device,
> +					"NACK for addr %2.2x msg#%d rc =3D %d\n",
> +					pmsg->addr, i, rc);
> +				goto out;
> +			}
> +		}
> +
> +		cmd =3D (pmsg->flags & I2C_M_RD) ? CMD_RD : CMD_WR;
> +
> +		/* Perform data transfer */
> +		while (len) {
> +			bytes_to_xfer =3D min(len, N_DATA_BYTES);
> +
> +			if (ignore_nack || len <=3D N_DATA_BYTES)
> +				cmd =3D (pmsg->flags & I2C_M_RD) ? CMD_RD_NOACK
> +					: CMD_WR_NOACK;
> +
> +			if (len <=3D N_DATA_BYTES && i =3D=3D (num - 1))
> +				brcmstb_set_i2c_start_stop(dev,
> +							   ~(COND_START_STOP));
> +
> +			rc =3D brcmstb_i2c_xfer_bsc_data(dev, tmp_buf,
> +						       bytes_to_xfer, cmd);
> +			if (rc < 0) {
> +				dev_dbg(dev->device, "%s failure",
> +					cmd_string[cmd]);
> +				goto out;
> +			}
> +
> +			len -=3D  bytes_to_xfer;
> +			tmp_buf +=3D bytes_to_xfer;
> +		}
> +	}
> +
> +	rc =3D num;
> +out:
> +	return rc;
> +
> +}
> +
> +static u32 brcmstb_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR
> +		| I2C_FUNC_NOSTART | I2C_FUNC_PROTOCOL_MANGLING;
> +}
> +
> +static const struct i2c_algorithm brcmstb_i2c_algo =3D {
> +	.master_xfer =3D brcmstb_i2c_xfer,
> +	.functionality =3D brcmstb_i2c_functionality,
> +};
> +
> +static void brcmstb_i2c_set_bus_speed(struct brcmstb_i2c_dev *dev)
> +{
> +	int i =3D 0, num_speeds =3D ARRAY_SIZE(bsc_clk);
> +	u32 clk_freq_hz =3D dev->clk_freq_hz;
> +
> +	for (i =3D 0; i < num_speeds; i++) {
> +		if (bsc_clk[i].hz =3D=3D clk_freq_hz) {
> +			dev->bsc_regmap->ctl_reg &=3D ~(BSC_CTL_REG_SCL_SEL_MASK
> +						| BSC_CTL_REG_DIV_CLK_MASK);
> +			dev->bsc_regmap->ctl_reg |=3D (bsc_clk[i].scl_mask |
> +						     bsc_clk[i].div_mask);
> +			bsc_writel(dev, dev->bsc_regmap->ctl_reg, ctl_reg);
> +			break;
> +		}
> +	}
> +
> +	if (i =3D=3D num_speeds) {
> +		i =3D (bsc_readl(dev, ctl_reg) & BSC_CTL_REG_SCL_SEL_MASK) >>
> +			BSC_CTL_REG_SCL_SEL_SHIFT;
> +		dev_warn(dev->device, "invalid input clock-frequency %dHz\n",
> +			clk_freq_hz);
> +		dev_warn(dev->device, "leaving current clock-frequency @ %dHz\n",
> +			bsc_clk[i].hz);
> +	}
> +}
> +
> +static void brcmstb_i2c_set_bsc_reg_defaults(struct brcmstb_i2c_dev *dev)
> +{
> +	/* 4 byte data register */
> +	dev->bsc_regmap->ctlhi_reg =3D BSC_CTLHI_REG_DATAREG_SIZE_MASK;
> +	bsc_writel(dev, dev->bsc_regmap->ctlhi_reg, ctlhi_reg);
> +	/* set bus speed */
> +	brcmstb_i2c_set_bus_speed(dev);
> +}
> +
> +static int brcmstb_i2c_probe(struct platform_device *pdev)
> +{
> +	int rc =3D 0;
> +	struct brcmstb_i2c_dev *dev;
> +	struct i2c_adapter *adap;
> +	struct resource *iomem;
> +	const char *int_name;
> +
> +	/* Allocate memory for private data structure */
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->bsc_regmap =3D kzalloc(sizeof(struct bsc_regs), GFP_KERNEL);
> +	if (!dev->bsc_regmap)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, dev);
> +	dev->device =3D &pdev->dev;
> +	init_completion(&dev->done);
> +
> +	/* Map hardware registers */
> +	iomem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dev->base =3D devm_ioremap_resource(dev->device, iomem);
> +	if (IS_ERR(dev->base)) {
> +		rc =3D -ENOMEM;
> +		goto probe_errorout;
> +	}
> +
> +	rc =3D of_property_read_string(dev->device->of_node, "interrupt-names",
> +				     &int_name);
> +	if (rc < 0)
> +		int_name =3D NULL;
> +
> +	/* Get the interrupt number */
> +	dev->irq =3D platform_get_irq(pdev, 0);
> +
> +	/* disable the bsc interrupt line */
> +	brcmstb_i2c_disable_irq(dev);
> +
> +	/* register the ISR handler */
> +	rc =3D devm_request_irq(&pdev->dev, dev->irq, brcmstb_i2c_isr,
> +			      IRQF_SHARED,
> +			      int_name ? int_name : pdev->name,
> +			      dev);
> +
> +	if (rc) {
> +		dev_dbg(dev->device, "falling back to polling mode");
> +		dev->irq =3D -1;
> +	}
> +
> +	/* Add the i2c adapter */
> +	adap =3D &dev->adapter;
> +	i2c_set_adapdata(adap, dev);
> +	adap->owner =3D THIS_MODULE;
> +	strlcpy(adap->name, "Broadcom STB : ", sizeof(adap->name));
> +	if (int_name)
> +		strlcat(adap->name, int_name, sizeof(adap->name));
> +	adap->algo =3D &brcmstb_i2c_algo;
> +	adap->dev.parent =3D &pdev->dev;
> +	adap->dev.of_node =3D pdev->dev.of_node;
> +	rc =3D i2c_add_adapter(adap);
> +	if (rc) {
> +		dev_err(dev->device, "failed to add adapter\n");
> +		goto probe_errorout;
> +	}
> +
> +	if (of_property_read_u32(dev->device->of_node,
> +				 "clock-frequency", &dev->clk_freq_hz)) {
> +		dev_warn(dev->device, "missing clock-frequency property\n");
> +		dev_warn(dev->device, "setting default clock-frequency %dHz\n",
> +			 bsc_clk[0].hz);
> +		dev->clk_freq_hz =3D bsc_clk[0].hz;
> +	}
> +
> +	brcmstb_i2c_set_bsc_reg_defaults(dev);
> +	dev_info(dev->device, "%s@%dhz registered in %s mode\n",
> +		 int_name ? int_name : " ", dev->clk_freq_hz,
> +		 (dev->irq >=3D 0) ? "interrupt" : "polling");
> +
> +	return 0;
> +
> +probe_errorout:
> +	kfree(dev->bsc_regmap);
> +	return rc;
> +}
> +
> +static int brcmstb_i2c_remove(struct platform_device *pdev)
> +{
> +	struct brcmstb_i2c_dev *dev =3D platform_get_drvdata(pdev);
> +
> +	kfree(dev->bsc_regmap);
> +	i2c_del_adapter(&dev->adapter);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int brcmstb_i2c_suspend(struct device *dev)
> +{
> +	struct brcmstb_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> +
> +	i2c_lock_adapter(&i2c_dev->adapter);
> +	i2c_dev->is_suspended =3D true;
> +	i2c_unlock_adapter(&i2c_dev->adapter);
> +
> +	return 0;
> +}
> +
> +static int brcmstb_i2c_resume(struct device *dev)
> +{
> +	struct brcmstb_i2c_dev *i2c_dev =3D dev_get_drvdata(dev);
> +
> +	i2c_lock_adapter(&i2c_dev->adapter);
> +	brcmstb_i2c_set_bsc_reg_defaults(i2c_dev);
> +	i2c_dev->is_suspended =3D false;
> +	i2c_unlock_adapter(&i2c_dev->adapter);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(brcmstb_i2c_pm, brcmstb_i2c_suspend,
> +			 brcmstb_i2c_resume);
> +
> +static const struct of_device_id brcmstb_i2c_of_match[] =3D {
> +	{.compatible =3D "brcm,brcmstb-i2c"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, brcmstb_i2c_of_match);
> +
> +static struct platform_driver brcmstb_i2c_driver =3D {
> +	.driver =3D {
> +		   .name =3D "brcmstb-i2c",
> +		   .owner =3D THIS_MODULE,
> +		   .of_match_table =3D brcmstb_i2c_of_match,
> +		   .pm =3D &brcmstb_i2c_pm,
> +		   },
> +	.probe =3D brcmstb_i2c_probe,
> +	.remove =3D brcmstb_i2c_remove,
> +};
> +module_platform_driver(brcmstb_i2c_driver);
> +
> +MODULE_AUTHOR("Kamal Dasu <kdasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>");
> +MODULE_DESCRIPTION("Broadcom Settop I2C Driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.3.2
>=20

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLRp8AAoJEBQN5MwUoCm2n44P/08XkEixgLkZfBcl/ykZD4X0
p9BPBWfy9UJj1TKxK0FpVx72QJ+ZDYPRDxEXH6MxO9Q2Wbct7bicsorMBXwfTN86
ksF0Yc4LYabdBWFqfvyxnIVJWKRajC4Ft8GCzyg2+f0lOopqmReeaaJ/xY+cx3+h
+YgloZhBvHI1tNsnBXMmr9JI4SqzBD1FVC8QSWEJ0Bj+IlD3S4WOM3IL78HHND/U
GyWDMc/EozHduLmxdFIO3SAE6PPGqzrBXhzLwIGn06J1SZrqluLWStQzjYxnPLPi
LqyKQSusOpPSHKDcauQRRmqeQvMEW9pZVyBt9O1deuUiSnksKzo4zMVATVKPr5wM
gX0qeSBzgJspAx4Z9/bi+Mpqyk6JE9/qWkiVaZHF33PGISrm6JnpgDYtqGO6G3ak
lvWHmFyJ+ixP/awgTZEOChDgjS3gGMbPpVHFV5oZx+DYgyWWpcjLQl/WC1n9l9Ar
Wd1bNYhooSW3tjBp5GahW+/ExlgKwWFI3HDp+eL4/OOVHYZo2ai6a9wLTpJORw2T
wOrU6KNvszjH6tRF0XexZNxUEhoy1Ok+91b1z1EriGHuNPTwaewUjR2N8r7SZw27
rL8mrAHl+/UZ8g1g8rzceF9wiYXANfxBIYZxOTFrgxs3LccZDqIHj8axRDNkTI38
1pcYARoAe7adlzXHa3xv
=kC+y
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
