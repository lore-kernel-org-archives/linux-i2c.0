From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/4] i2c: sunxi: Add Reduced Serial Bus (RSB) support
Date: Wed, 4 Mar 2015 17:53:52 +0100
Message-ID: <20150304165352.GP4911@lukather>
References: <1425284686-5116-1-git-send-email-wens@csie.org>
 <1425284686-5116-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425284686-5116-2-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 02, 2015 at 04:24:43PM +0800, Chen-Yu Tsai wrote:
> The RSB controller looks like an SMBus controller which only supports byte
> and word data transfers. It can also do double-word data transfers, but t=
he
> I2C subsystem does not support this, nor have we seen devices using this.
>=20
> The RSB differs from standard SMBus protocol on several aspects:
> - it uses addresses set at runtime to address slaves. Runtime addresses
>   are sent to slaves using their 12bit hardware addresses. Up to 15
>   runtime addresses are available.
> - it adds a parity bit every 8bits of data and address for read and
>   write accesses; this replaces the ack bit
> - only one read access is required to read a byte (instead of a write
>   followed by a read access in standard SMBus protocol)
> - there's no Ack bit after each read access
>=20
> This means this bus cannot be used to interface with standard SMBus
> devices (known devices supporting this interface are the AXP223, AXP806,
> AXP809 PMICs and the AC100 codec/RTC). However the RSB protocol is an
> extension of P2WI, which was close enough to SMBus to be integrated into
> the I2C subsystem in commit 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull
> 2 Wire Interface) controller support").
>=20
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig         |  12 +
>  drivers/i2c/busses/Makefile        |   1 +
>  drivers/i2c/busses/i2c-sunxi-rsb.c | 458 +++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 471 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-sunxi-rsb.c
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 22da9c2ffa22..cf9337877181 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -840,6 +840,18 @@ config I2C_SUN6I_P2WI
>  	  This interface is used to connect to specific PMIC devices (like the
>  	  AXP221).
> =20
> +config I2C_SUNXI_RSB
> +	tristate "Allwinner Reduced Serial Bus controller"
> +	depends on RESET_CONTROLLER
> +	depends on MACH_SUN8I || MACH_SUN9I || COMPILE_TEST
> +	help
> +	  If you say yes to this option, support will be included for the
> +	  Reduced Serial Bus controller embedded in some sunxi SOCs.
> +	  The RSB looks like an SMBus controller (which supports only byte
> +	  accesses), but requires setting runtime addresses for slave devices.
> +	  This interface is used to connect to specific PMIC devices (like the
> +	  AXP223) or peripherals (like the AC100).
> +
>  config I2C_TEGRA
>  	tristate "NVIDIA Tegra internal I2C controller"
>  	depends on ARCH_TEGRA
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3638feb6677e..f95d50315003 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -81,6 +81,7 @@ obj-$(CONFIG_I2C_SIRF)		+=3D i2c-sirf.o
>  obj-$(CONFIG_I2C_ST)		+=3D i2c-st.o
>  obj-$(CONFIG_I2C_STU300)	+=3D i2c-stu300.o
>  obj-$(CONFIG_I2C_SUN6I_P2WI)	+=3D i2c-sun6i-p2wi.o
> +obj-$(CONFIG_I2C_SUNXI_RSB)	+=3D i2c-sunxi-rsb.o
>  obj-$(CONFIG_I2C_TEGRA)		+=3D i2c-tegra.o
>  obj-$(CONFIG_I2C_VERSATILE)	+=3D i2c-versatile.o
>  obj-$(CONFIG_I2C_WMT)		+=3D i2c-wmt.o
> diff --git a/drivers/i2c/busses/i2c-sunxi-rsb.c b/drivers/i2c/busses/i2c-=
sunxi-rsb.c
> new file mode 100644
> index 000000000000..7e9be3e14b8a
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-sunxi-rsb.c
> @@ -0,0 +1,458 @@
> +/*
> + * RSB (Reduced Serial Bus) driver.
> + *
> + * Author: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
> + *
> + * This file is licensed under the terms of the GNU General Public Licen=
se
> + * version 2.  This program is licensed "as is" without any warranty of =
any
> + * kind, whether express or implied.
> + *
> + * The RSB controller looks like an SMBus controller which only supports
> + * byte and word data transfers. But, it differs from standard SMBus
> + * protocol on several aspects:
> + * - it uses addresses set at runtime to address slaves. Runtime address=
es
> + *   are sent to slaves using their 12bit hardware addresses. Up to 15
> + *   runtime addresses are available.
> + * - it adds a parity bit every 8bits of data and address for read and
> + *   write accesses; this replaces the ack bit
> + * - only one read access is required to read a byte (instead of a write
> + *   followed by a read access in standard SMBus protocol)
> + * - there's no Ack bit after each read access
> + *
> + * This means this bus cannot be used to interface with standard SMBus
> + * devices. Devices known to support this interface include the AXP223,
> + * AXP809, and AXP806 PMICs, and the AC100 audio codec, all from X-Power=
s.
> + *
> + * A description of the operation and wire protocol can be found in the
> + * RSB section of Allwinner's A80 user manual, which can be found at
> + *
> + *     https://github.com/allwinner-zh/documents/tree/master/A80
> + *
> + * This document is officially released by Allwinner.
> + *
> + * This driver is based on i2c-sun6i-p2wi.c, the P2WI bus driver.
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +
> +/* RSB registers */
> +#define RSB_CTRL	0x0	/* Global control */
> +#define RSB_CCR		0x4	/* Clock control */
> +#define RSB_INTE	0x8	/* Interrupt controls */
> +#define RSB_INTS	0xc	/* Interrupt status */
> +#define RSB_ADDR	0x10	/* Address to send with read/write command */
> +#define RSB_DATA	0x1c	/* Data to read/write */
> +#define RSB_LCR		0x24	/* Line control */
> +#define RSB_DMCR	0x28	/* Device mode (init) control */
> +#define RSB_CMD		0x2c	/* RSB Command */
> +#define RSB_DAR		0x30	/* Device address / runtime address */
> +
> +/* CTRL fields */
> +#define RSB_CTRL_START_TRANS		BIT(7)
> +#define RSB_CTRL_ABORT_TRANS		BIT(6)
> +#define RSB_CTRL_GLOBAL_INT_ENB		BIT(1)
> +#define RSB_CTRL_SOFT_RST		BIT(0)
> +
> +/* CLK CTRL fields */
> +#define RSB_CCR_SDA_OUT_DELAY(v)	(((v) & 0x7) << 8)
> +#define RSB_CCR_MAX_CLK_DIV		0xff
> +#define RSB_CCR_CLK_DIV(v)		((v) & RSB_CCR_MAX_CLK_DIV)
> +
> +/* STATUS fields */
> +#define RSB_INTS_TRANS_ERR_ACK		BIT(16)
> +#define RSB_INTS_TRANS_ERR_ID(v)	(((v) >> 8) & 0xf)
> +#define RSB_INTS_LOAD_BSY		BIT(2)
> +#define RSB_INTS_TRANS_ERR		BIT(1)
> +#define RSB_INTS_TRANS_OVER		BIT(0)
> +
> +/* LINE CTRL fields*/
> +#define RSB_LCR_SCL_STATE		BIT(5)
> +#define RSB_LCR_SDA_STATE		BIT(4)
> +#define RSB_LCR_SCL_CTL			BIT(3)
> +#define RSB_LCR_SCL_CTL_EN		BIT(2)
> +#define RSB_LCR_SDA_CTL			BIT(1)
> +#define RSB_LCR_SDA_CTL_EN		BIT(0)
> +
> +/* DEVICE MODE CTRL field values */
> +#define RSB_DMCR_DEVICE_START		BIT(31)
> +#define RSB_DMCR_MODE_DATA		(0x7c << 16)
> +#define RSB_DMCR_MODE_REG		(0x3e << 8)
> +#define RSB_DMCR_DEV_ADDR		0x00
> +
> +/* CMD values */
> +#define RSB_CMD_RD8			0x8b
> +#define RSB_CMD_RD16			0x9c
> +#define RSB_CMD_RD32			0xa6
> +#define RSB_CMD_WR8			0x4e
> +#define RSB_CMD_WR16			0x59
> +#define RSB_CMD_WR32			0x63
> +#define RSB_CMD_STRA			0xe8
> +
> +/* DAR fields */
> +#define RSB_DAR_RTA(v)			(((v) & 0xff) << 16)
> +#define RSB_DAR_DA(v)			((v) & 0xffff)
> +
> +#define RSB_MAX_FREQ			20000000
> +
> +#define RSB_CTRL_NAME			"sunxi-rsb"
> +
> +struct rsb {
> +	struct i2c_adapter adapter;
> +	struct completion complete;
> +	unsigned int status;
> +	void __iomem *regs;
> +	struct clk *clk;
> +	struct reset_control *rstc;
> +};
> +
> +static irqreturn_t rsb_interrupt(int irq, void *dev_id)
> +{
> +	struct rsb *rsb =3D dev_id;
> +	unsigned long status;
> +
> +	status =3D readl(rsb->regs + RSB_INTS);
> +	rsb->status =3D status;
> +
> +	/* Clear interrupts */
> +	status &=3D (RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR |
> +		   RSB_INTS_TRANS_OVER);
> +	writel(status, rsb->regs + RSB_INTS);
> +
> +	complete(&rsb->complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* common code that starts a transfer */
> +static int rsb_run_xfer(struct rsb *rsb)
> +{
> +	if (readl(rsb->regs + RSB_CTRL) & RSB_CTRL_START_TRANS) {
> +		dev_dbg(&rsb->adapter.dev, "RSB bus busy\n");
> +		return -EBUSY;
> +	}
> +
> +	reinit_completion(&rsb->complete);
> +
> +	writel(RSB_INTS_LOAD_BSY | RSB_INTS_TRANS_ERR | RSB_INTS_TRANS_OVER,
> +	       rsb->regs + RSB_INTE);
> +
> +	writel(RSB_CTRL_START_TRANS | RSB_CTRL_GLOBAL_INT_ENB,
> +	       rsb->regs + RSB_CTRL);
> +
> +	wait_for_completion(&rsb->complete);
> +
> +	if (rsb->status & RSB_INTS_LOAD_BSY) {
> +		dev_dbg(&rsb->adapter.dev, "RSB bus busy\n");
> +		return -EBUSY;
> +	}
> +
> +	if (rsb->status & RSB_INTS_TRANS_ERR) {
> +		dev_dbg(&rsb->adapter.dev, "RSB bus xfer error\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rsb_smbus_xfer(struct i2c_adapter *adap, u16 addr,
> +			   unsigned short flags, char read_write,
> +			   u8 command, int size, union i2c_smbus_data *data)
> +{
> +	struct rsb *rsb =3D i2c_get_adapdata(adap);
> +	int ret;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	writel(command, rsb->regs + RSB_ADDR);
> +	writel(RSB_DAR_RTA(addr), rsb->regs + RSB_DAR);
> +
> +	if (read_write =3D=3D I2C_SMBUS_READ) {
> +		if (size =3D=3D I2C_SMBUS_BYTE_DATA)
> +			writel(RSB_CMD_RD8, rsb->regs + RSB_CMD);
> +		else
> +			writel(RSB_CMD_RD16, rsb->regs + RSB_CMD);
> +	} else {
> +		if (size =3D=3D I2C_SMBUS_BYTE_DATA) {
> +			writel(RSB_CMD_WR8, rsb->regs + RSB_CMD);
> +			writel(data->byte, rsb->regs + RSB_DATA);
> +		} else {
> +			writel(RSB_CMD_WR16, rsb->regs + RSB_CMD);
> +			writel(data->word, rsb->regs + RSB_DATA);
> +		}
> +	}

Maybe something like the following would be better:

if (read_write =3D=3D ...) {
    if (size =3D=3D ..)
        cmd =3D RSB_CMD_RD8;
    else
        cmd =3D RSB_CMD_RD16;

    writel(cmd, ....);
} else {
    if (size =3D=3D ...) {
        cmd =3D RSB_CMD_WR8;
	val =3D data->byte;
    } else {
        cmd =3D RSB_CMD_WR16;
	val =3D data->word;
    }

    writel(cmd, ...);
    writel(val, ...);
}

> +
> +	ret =3D rsb_run_xfer(rsb);
> +	if (ret)
> +		return ret;
> +
> +	if (read_write =3D=3D I2C_SMBUS_READ) {
> +		if (size =3D=3D I2C_SMBUS_BYTE_DATA)
> +			data->byte =3D readl(rsb->regs + RSB_DATA);
> +		else
> +			data->word =3D readl(rsb->regs + RSB_DATA);
> +	}
> +
> +	return 0;
> +}
> +
> +static u32 rsb_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA;
> +}
> +
> +static const struct i2c_algorithm rsb_algo =3D {
> +	.smbus_xfer	=3D rsb_smbus_xfer,
> +	.functionality	=3D rsb_functionality,
> +};
> +
> +/* following functions are used strictly during device probe */
> +static void rsb_init_device_mode(struct rsb *rsb)
> +{
> +	unsigned long expire =3D jiffies + msecs_to_jiffies(250);
> +	u32 reg;
> +
> +	/* send init sequence */
> +	writel(RSB_DMCR_DEVICE_START | RSB_DMCR_MODE_DATA |
> +	       RSB_DMCR_MODE_REG | RSB_DMCR_DEV_ADDR, rsb->regs + RSB_DMCR);
> +	do {
> +		reg =3D readl(rsb->regs + RSB_DMCR);
> +	} while (time_before(jiffies, expire) && (reg & RSB_DMCR_DEVICE_START));

You can use readl_poll_timeout for this (introduced in 4.0).

> +
> +	if (reg & RSB_DMCR_DEVICE_START)
> +		dev_warn(&rsb->adapter.dev, "send init sequence timeout\n");
> +
> +	/* clear interrupt status bits */
> +	writel(readl(rsb->regs + RSB_INTS), rsb->regs + RSB_INTS);
> +}
> +
> +/* 15 valid runtime addresses for RSB slaves */
> +static const u8 rsb_valid_rtaddr[] =3D {
> +	0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74,
> +	/*
> +	 * Currently this driver only supports 7-bit addresses.
> +	 * The following addresses will be blocked by the i2c core.
> +	 */
> +	0x8b, 0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff,
> +};
> +
> +static int rsb_check_rt_addr(u8 addr)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(rsb_valid_rtaddr); i++)
> +		if (addr =3D=3D rsb_valid_rtaddr[i])
> +			return 0;
> +
> +	return -EINVAL;
> +}
> +
> +/* Scan the device tree for child nodes and set runtime address for them=
=2E */
> +static int rsb_set_rt_addrs(struct rsb *rsb)
> +{
> +	struct device *dev =3D rsb->adapter.dev.parent;
> +	struct device_node *child, *np =3D dev->of_node;
> +	u32 rt_addr, hw_addr;
> +	int ret;
> +
> +	if (!np)
> +		return -EINVAL;
> +
> +	for_each_child_of_node(np, child) {
> +		/* get hardware address */
> +		ret =3D of_property_read_u32(child, "allwinner,rsb-hw-addr",
> +					   &hw_addr);
> +		if (ret) {
> +			dev_warn(dev, "runtime address not given for %s\n",
> +				 of_node_full_name(child));
> +			continue;
> +		}
> +
> +		/* get runtime address */
> +		ret =3D of_property_read_u32(child, "reg", &rt_addr);
> +		if (ret) {
> +			dev_warn(dev, "runtime address not given for %s\n",
> +				 of_node_full_name(child));
> +			continue;
> +		}

Isn't that stored in the struct i2c_client address field already?

> +		/* check runtime address */
> +		ret =3D rsb_check_rt_addr(rt_addr);
> +		if (ret) {
> +			dev_warn(dev, "runtime address for %s is invalid\n",
> +				 of_node_full_name(child));
> +			continue;
> +		}
> +
> +		/* setup command parameters */
> +		writel(RSB_CMD_STRA, rsb->regs + RSB_CMD);
> +		writel(RSB_DAR_RTA(rt_addr) | RSB_DAR_DA(hw_addr),
> +		       rsb->regs + RSB_DAR);
> +
> +		/* send command */
> +		ret =3D rsb_run_xfer(rsb);
> +		if (ret)
> +			dev_warn(dev, "set runtime address failed for %s\n",
> +				 of_node_full_name(child));
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static const struct of_device_id rsb_of_match_table[] =3D {
> +	{ .compatible =3D "allwinner,sun8i-a23-rsb" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rsb_of_match_table);
> +
> +static int rsb_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	unsigned long parent_clk_freq;
> +	u32 clk_freq =3D 100000;
> +	struct resource *r;
> +	struct rsb *rsb;
> +	int clk_div;
> +	int irq;
> +	int ret;
> +
> +	of_property_read_u32(np, "clock-frequency", &clk_freq);
> +	if (clk_freq > RSB_MAX_FREQ) {
> +		dev_err(dev,
> +			"clock-frequency (%u Hz) is too high (max =3D 20MHz)",
> +			clk_freq);
> +		return -EINVAL;
> +	}
> +
> +	rsb =3D devm_kzalloc(dev, sizeof(struct rsb), GFP_KERNEL);
> +	if (!rsb)
> +		return -ENOMEM;
> +
> +	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	rsb->regs =3D devm_ioremap_resource(dev, r);
> +	if (IS_ERR(rsb->regs))
> +		return PTR_ERR(rsb->regs);
> +
> +	strlcpy(rsb->adapter.name, pdev->name, sizeof(rsb->adapter.name));

Isn't that what strcpy is doing already?

> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(dev, "failed to retrieve irq: %d\n", irq);
> +		return irq;
> +	}
> +
> +	rsb->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(rsb->clk)) {
> +		ret =3D PTR_ERR(rsb->clk);
> +		dev_err(dev, "failed to retrieve clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare_enable(rsb->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	parent_clk_freq =3D clk_get_rate(rsb->clk);
> +
> +	rsb->rstc =3D devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(rsb->rstc)) {
> +		ret =3D PTR_ERR(rsb->rstc);
> +		dev_err(dev, "failed to retrieve reset controller: %d\n", ret);
> +		goto err_clk_disable;
> +	}
> +
> +	ret =3D reset_control_deassert(rsb->rstc);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert reset line: %d\n", ret);
> +		goto err_clk_disable;
> +	}
> +
> +	init_completion(&rsb->complete);
> +	strlcpy(rsb->adapter.name, RSB_CTRL_NAME, sizeof(rsb->adapter.name));
> +	rsb->adapter.dev.parent =3D dev;
> +	rsb->adapter.algo =3D &rsb_algo;
> +	rsb->adapter.owner =3D THIS_MODULE;

Is the owner field still needed?

> +	rsb->adapter.dev.of_node =3D pdev->dev.of_node;
> +	platform_set_drvdata(pdev, rsb);
> +	i2c_set_adapdata(&rsb->adapter, rsb);
> +
> +	writel(RSB_CTRL_SOFT_RST, rsb->regs + RSB_CTRL);
> +
> +	clk_div =3D parent_clk_freq / clk_freq;
> +	if (!clk_div) {
> +		dev_warn(dev,
> +			 "clock-frequency is too high, setting it to %lu Hz\n",
> +			 parent_clk_freq);
> +		clk_div =3D 1;
> +	} else if (clk_div > RSB_CCR_MAX_CLK_DIV) {
> +		dev_warn(dev,
> +			 "clock-frequency is too low, setting it to %lu Hz\n",
> +			 parent_clk_freq / RSB_CCR_MAX_CLK_DIV);
> +		clk_div =3D RSB_CCR_MAX_CLK_DIV;
> +	}

Why not just error out?

> +	writel(RSB_CCR_SDA_OUT_DELAY(1) | RSB_CCR_CLK_DIV(clk_div),
> +	       rsb->regs + RSB_CCR);
> +
> +	ret =3D devm_request_irq(dev, irq, rsb_interrupt, 0, RSB_CTRL_NAME, rsb=
);
> +	if (ret) {
> +		dev_err(dev, "can't register interrupt handler irq%d: %d\n",
> +			irq, ret);
> +		goto err_reset_assert;
> +	}
> +
> +	rsb_init_device_mode(rsb);
> +
> +	ret =3D rsb_set_rt_addrs(rsb);
> +	if (ret)
> +		goto err_reset_assert;
> +
> +	ret =3D i2c_add_adapter(&rsb->adapter);
> +	if (!ret)
> +		return 0;
> +
> +err_reset_assert:
> +	reset_control_assert(rsb->rstc);
> +
> +err_clk_disable:
> +	clk_disable_unprepare(rsb->clk);
> +
> +	return ret;
> +}
> +
> +static int rsb_remove(struct platform_device *dev)
> +{
> +	struct rsb *rsb =3D platform_get_drvdata(dev);
> +
> +	i2c_del_adapter(&rsb->adapter);
> +	reset_control_assert(rsb->rstc);
> +	clk_disable_unprepare(rsb->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rsb_driver =3D {
> +	.probe =3D rsb_probe,
> +	.remove	=3D rsb_remove,
> +	.driver	=3D {
> +		.name =3D "i2c-sunxi-rsb",
> +		.of_match_table =3D rsb_of_match_table,
> +	},
> +};
> +module_platform_driver(rsb_driver);
> +
> +MODULE_AUTHOR("Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>");
> +MODULE_DESCRIPTION("Allwinner RSB driver");
> +MODULE_LICENSE("GPL v2");
> --=20
> 2.1.4
>=20

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9zigAAoJEBx+YmzsjxAgKlQP/07X2cS65/4ds4/52+Z52eNX
yYa4CGbaHWl9LHv8kFcoTzuRWTId50BN3NKGP/UgrwCABqnKWm7hXkkAUNRMFZJc
VY5kHkXCNJg/MT1dHyyIt34Y0qOzQvZ9g/aFyrR5Fx0wTmo3YoohRDoxchQQBHCV
a2OdAjjFTpn3oX2BsMUJtkOBTiZhLJpc3OsFneVH4BgDYkneYLFf7ZjPYw6rNSkO
O3vOkPSpJjvxnsvwMCZCqLPyUhjU4VzrKWgrGksTzvhsDdOeWZMsSxiHG19Ydb2a
NjD92LyFgTWhY21UCDkxvqLZmGWhKpzYqtXb8lA3DRlEZiGXXrhhqEHcqy6bjHbA
AYaGwhH/Uj15R1SOKbTUv41Ma6LgFpvjYUMAXkqg5DNSKtZ/jBNyW5/pUSWL3ht6
ZH262G+LwVhPEoEKh6MrGOTCMsxxXYzvekvNS8buNK6qJ3Oxnr3MUtCci+Wey+i9
zHz74mBh3E2Td8RaQ/w2FRffOOWz3bo+hS/KoJXFBMfgsWpKleJJNVe280lK8cx0
+hqhjxAxfugWMZr9bH5OI9c4Hd/jwWGQxQrOTUcdLp+PXot0HtNJbSNpTTHL6Wc7
IEF27U8jSLJeDracU7VJhJZJpZinCMoLJ7iRXEjl6yOGAQRsqZ59o+YgiFUac5cl
GxHsso0A4f4Gc+G+ZFYn
=1iTQ
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--
