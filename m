From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: tegra: Add i2c support
Date: Tue, 15 Feb 2011 23:48:51 +0000
Message-ID: <4D5B10E3.5030208@fluff.org>
References: <1297169061-17689-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297169061-17689-1-git-send-email-broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 08/02/11 12:44, Mark Brown wrote:
> From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>

Some sort of explanation here would have been nice.

> Signed-off-by: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  drivers/i2c/busses/Kconfig     |    7 +
>  drivers/i2c/busses/Makefile    |    1 +
>  drivers/i2c/busses/i2c-tegra.c |  665 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c-tegra.h      |   25 ++
>  4 files changed, 698 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/busses/i2c-tegra.c
>  create mode 100644 include/linux/i2c-tegra.h
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 30f8dbd..b76a2a4 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig

Fine.

> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3c630b7..f505253 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile

Fine.

> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
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
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
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

I don't think you should be including


> +
> +struct tegra_i2c_dev {
> +	struct device *dev;
> +	struct i2c_adapter adapter;
> +	struct clk *clk;
> +	struct clk *i2c_clk;
> +	struct resource *iomem;
> +	void __iomem *base;
> +	int cont_id;
> +	int irq;
> +	int is_dvc;
> +	struct completion msg_complete;
> +	int msg_err;
> +	u8 *msg_buf;
> +	size_t msg_buf_remaining;
> +	int msg_read;
> +	int msg_transfer_complete;
> +	unsigned long bus_clk_rate;
> +	bool is_suspended;
> +};

would have been nice to have some kerneldoc for this.

> +/*
> + * i2c_writel and i2c_readl will offset the register if necessary to talk
> + * to the I2C block inside the DVC block
> + */
> +static void i2c_writel(struct tegra_i2c_dev *i2c_dev, u32 val, unsigned long reg)
> +{
> +	if (i2c_dev->is_dvc)
> +		reg += (reg >= I2C_TX_FIFO) ? 0x10 : 0x40;
> +	writel(val, i2c_dev->base + reg);
> +}
> +
> +static u32 i2c_readl(struct tegra_i2c_dev *i2c_dev, unsigned long reg)
> +{
> +	if (i2c_dev->is_dvc)
> +		reg += (reg >= I2C_TX_FIFO) ? 0x10 : 0x40;
> +	return readl(i2c_dev->base + reg);
> +}

as a note, would have been better to wrap up the address changes into
one place to ensure that they're consistent.

[snip]

> +static void tegra_i2c_set_clk(struct tegra_i2c_dev *i2c_dev, unsigned int freq)
> +{
> +	clk_set_rate(i2c_dev->clk, freq * 8);
> +}

hmm, really need a separate function?

> +static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
> +{
> +	unsigned long timeout = jiffies + HZ;
> +	u32 val = i2c_readl(i2c_dev, I2C_FIFO_CONTROL);
> +	val |= I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_CONTROL_RX_FLUSH;
> +	i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> +
> +	while (i2c_readl(i2c_dev, I2C_FIFO_CONTROL) &
> +		(I2C_FIFO_CONTROL_TX_FLUSH | I2C_FIFO_CONTROL_RX_FLUSH)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(i2c_dev->dev, "timeout waiting for fifo flush\n");
> +			return -ETIMEDOUT;
> +		}
> +		msleep(1);
> +	}
> +	return 0;
> +}
> +
> +static int tegra_i2c_empty_rx_fifo(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	int rx_fifo_avail;
> +	int word;
> +	u8 *buf = i2c_dev->msg_buf;
> +	size_t buf_remaining = i2c_dev->msg_buf_remaining;
> +	int words_to_transfer;
> +
> +	val = i2c_readl(i2c_dev, I2C_FIFO_STATUS);
> +	rx_fifo_avail = (val & I2C_FIFO_STATUS_RX_MASK) >>
> +		I2C_FIFO_STATUS_RX_SHIFT;
> +
> +	words_to_transfer = buf_remaining / BYTES_PER_FIFO_WORD;
> +	if (words_to_transfer > rx_fifo_avail)
> +		words_to_transfer = rx_fifo_avail;
> +
> +	for (word = 0; word < words_to_transfer; word++) {
> +		val = i2c_readl(i2c_dev, I2C_RX_FIFO);
> +		put_unaligned_le32(val, buf);
> +		buf += BYTES_PER_FIFO_WORD;
> +		buf_remaining -= BYTES_PER_FIFO_WORD;
> +		rx_fifo_avail--;
> +	}

you know, there's a readsl() function that does this.

> +
> +	if (rx_fifo_avail > 0 && buf_remaining > 0) {
> +		int bytes_to_transfer = buf_remaining;
> +		int byte;
> +		BUG_ON(bytes_to_transfer > 3);
> +		val = i2c_readl(i2c_dev, I2C_RX_FIFO);
> +		for (byte = 0; byte < bytes_to_transfer; byte++) {
> +			*buf++ = val & 0xFF;
> +			val >>= 8;
> +		}
> +		buf_remaining -= bytes_to_transfer;
> +		rx_fifo_avail--;
> +	}
> +	BUG_ON(rx_fifo_avail > 0 && buf_remaining > 0);
> +	i2c_dev->msg_buf_remaining = buf_remaining;
> +	i2c_dev->msg_buf = buf;
> +	return 0;
> +}

this whole function gives me the creeps, is there any reason why
we can't use the readsl or similar functions for this?

> +static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	int tx_fifo_avail;
> +	int word;
> +	u8 *buf = i2c_dev->msg_buf;
> +	size_t buf_remaining = i2c_dev->msg_buf_remaining;
> +	int words_to_transfer;
> +
> +	val = i2c_readl(i2c_dev, I2C_FIFO_STATUS);
> +	tx_fifo_avail = (val & I2C_FIFO_STATUS_TX_MASK) >>
> +		I2C_FIFO_STATUS_TX_SHIFT;
> +
> +	words_to_transfer = buf_remaining / BYTES_PER_FIFO_WORD;
> +	if (words_to_transfer > tx_fifo_avail)
> +		words_to_transfer = tx_fifo_avail;
> +
> +	for (word = 0; word < words_to_transfer; word++) {
> +		val = get_unaligned_le32(buf);
> +		i2c_writel(i2c_dev, val, I2C_TX_FIFO);
> +		buf += BYTES_PER_FIFO_WORD;
> +		buf_remaining -= BYTES_PER_FIFO_WORD;
> +		tx_fifo_avail--;
> +	}
> +
> +	if (tx_fifo_avail > 0 && buf_remaining > 0) {
> +		int bytes_to_transfer = buf_remaining;
> +		int byte;
> +		BUG_ON(bytes_to_transfer > 3);
> +		val = 0;
> +		for (byte = 0; byte < bytes_to_transfer; byte++)
> +			val |= (*buf++) << (byte * 8);
> +		i2c_writel(i2c_dev, val, I2C_TX_FIFO);
> +		buf_remaining -= bytes_to_transfer;
> +		tx_fifo_avail--;
> +	}
> +	BUG_ON(tx_fifo_avail > 0 && buf_remaining > 0);
> +	i2c_dev->msg_buf_remaining = buf_remaining;
> +	i2c_dev->msg_buf = buf;
> +	return 0;
> +}

And the same goes for this one too.

> +static int tegra_i2c_init(struct tegra_i2c_dev *i2c_dev)
> +{
> +	u32 val;
> +	int err = 0;
> +
> +	clk_enable(i2c_dev->clk);
> +
> +	tegra_periph_reset_assert(i2c_dev->clk);
> +	udelay(2);
> +	tegra_periph_reset_deassert(i2c_dev->clk);
> +
> +	if (i2c_dev->is_dvc)
> +		tegra_dvc_init(i2c_dev);
> +
> +	val = I2C_CNFG_NEW_MASTER_FSM | I2C_CNFG_PACKET_MODE_EN;
> +	i2c_writel(i2c_dev, val, I2C_CNFG);
> +	i2c_writel(i2c_dev, 0, I2C_INT_MASK);
> +	tegra_i2c_set_clk(i2c_dev, i2c_dev->bus_clk_rate);
> +
> +	val = 7 << I2C_FIFO_CONTROL_TX_TRIG_SHIFT |
> +		0 << I2C_FIFO_CONTROL_RX_TRIG_SHIFT;
> +	i2c_writel(i2c_dev, val, I2C_FIFO_CONTROL);
> +
> +	if (tegra_i2c_flush_fifos(i2c_dev))
> +		err = -ETIMEDOUT;
> +
> +	clk_disable(i2c_dev->clk);
> +	return 0;
> +}

err never gets returned. please remove or return.

> +static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
> +{
> +	u32 status;
> +	const u32 status_err = I2C_INT_NO_ACK | I2C_INT_ARBITRATION_LOST;
> +	struct tegra_i2c_dev *i2c_dev = dev_id;
> +
> +	status = i2c_readl(i2c_dev, I2C_INT_STATUS);
> +
> +	if (status == 0) {
> +		dev_warn(i2c_dev->dev, "irq status 0 %08x\n",
> +			i2c_readl(i2c_dev, I2C_PACKET_TRANSFER_STATUS));
> +		return IRQ_HANDLED;

maybe return IRQ_UNHANDED?

> +	if (WARN_ON(ret == 0)) {

suppose a WARN_ON() is OK here.


> +		dev_err(i2c_dev->dev, "i2c transfer timed out\n");
> +
> +		tegra_i2c_init(i2c_dev);
> +		return -ETIMEDOUT;
> +	}
> +
> +	pr_debug("transfer complete: %d %d %d\n", ret, completion_done(&i2c_dev->msg_complete), i2c_dev->msg_err);

not dev_dbg()?

> +	if (likely(i2c_dev->msg_err == I2C_ERR_NONE))
> +		return 0;
> +
> +	tegra_i2c_init(i2c_dev);
> +	if (i2c_dev->msg_err == I2C_ERR_NO_ACK) {
> +		if (msg->flags & I2C_M_IGNORE_NAK)
> +			return 0;
> +		return -EREMOTEIO;
> +	}
> +
> +	return -EIO;
> +}

think that's fine.

[snip]

> +static int tegra_i2c_probe(struct platform_device *pdev)
> +{
> +	struct tegra_i2c_dev *i2c_dev;
> +	struct tegra_i2c_platform_data *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	struct resource *iomem;
> +	struct clk *clk;
> +	struct clk *i2c_clk;
> +	void *base;
> +	int irq;
> +	int ret = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no mem resource?\n");
> +		return -ENODEV;
> +	}

-ENODEV gets ignored by the upper layer, maybe find something else to
return.

> +	iomem = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (!iomem) {
> +		dev_err(&pdev->dev, "I2C region already claimed\n");
> +		return -EBUSY;
> +	}
> +
> +	base = ioremap(iomem->start, resource_size(iomem));
> +	if (!base) {
> +		dev_err(&pdev->dev, "Can't ioremap I2C region\n");

would prefer Cannot

> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "no irq resource?\n");

No need for ? after this.

> +		ret = -ENODEV;

and see again.

> +		goto err_iounmap;
> +	}
> +	irq = res->start;
> +
> +	clk = clk_get(&pdev->dev, NULL);
> +	if (!clk) {

you've departed from no dev_err() here.

> +		ret = -ENOMEM;
> +		goto err_release_region;
> +	}
> +


> +	i2c_clk = clk_get(&pdev->dev, "i2c");
> +	if (!i2c_clk) {

see again.

> +		ret = -ENOMEM;
> +		goto err_clk_put;
> +	}
> +
> +	i2c_dev = kzalloc(sizeof(struct tegra_i2c_dev), GFP_KERNEL);
> +	if (!i2c_dev) {
> +		ret = -ENOMEM;
> +		goto err_i2c_clk_put;
> +	}
> +
> +	i2c_dev->base = base;
> +	i2c_dev->clk = clk;
> +	i2c_dev->i2c_clk = i2c_clk;
> +	i2c_dev->iomem = iomem;
> +	i2c_dev->adapter.algo = &tegra_i2c_algo;
> +	i2c_dev->irq = irq;
> +	i2c_dev->cont_id = pdev->id;
> +	i2c_dev->dev = &pdev->dev;
> +	i2c_dev->bus_clk_rate = pdata ? pdata->bus_clk_rate : 100000;
> +
> +	if (pdev->id == 3)
> +		i2c_dev->is_dvc = 1;
> +	init_completion(&i2c_dev->msg_complete);
> +
> +	platform_set_drvdata(pdev, i2c_dev);
> +
> +	ret = tegra_i2c_init(i2c_dev);
> +	if (ret)
> +		goto err_free;

does tegra_i2c_init() print an appropriate error?

> +
> +	ret = request_irq(i2c_dev->irq, tegra_i2c_isr, IRQF_DISABLED,
> +		pdev->name, i2c_dev);

hmm, do you really want to be running IRQF_DISABLED?

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to request irq %i\n", i2c_dev->irq);
> +		goto err_free;
> +	}
> +
> +	clk_enable(i2c_dev->i2c_clk);
> +
> +	i2c_set_adapdata(&i2c_dev->adapter, i2c_dev);
> +	i2c_dev->adapter.owner = THIS_MODULE;
> +	i2c_dev->adapter.class = I2C_CLASS_HWMON;
> +	strlcpy(i2c_dev->adapter.name, "Tegra I2C adapter",
> +		sizeof(i2c_dev->adapter.name));
> +	i2c_dev->adapter.algo = &tegra_i2c_algo;
> +	i2c_dev->adapter.dev.parent = &pdev->dev;
> +	i2c_dev->adapter.nr = pdev->id;
> +
> +	ret = i2c_add_numbered_adapter(&i2c_dev->adapter);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to add I2C adapter\n");
> +		goto err_free_irq;
> +	}
> +
> +	return 0;
> +err_free_irq:
> +	free_irq(i2c_dev->irq, i2c_dev);
> +err_free:
> +	kfree(i2c_dev);
> +err_i2c_clk_put:
> +	clk_put(i2c_clk);
> +err_clk_put:
> +	clk_put(clk);
> +err_release_region:
> +	release_mem_region(iomem->start, resource_size(iomem));
> +err_iounmap:
> +	iounmap(base);
> +	return ret;
> +}

[snip]

how about MODULE_* decelerations at the end of this, with license, etc?

> diff --git a/include/linux/i2c-tegra.h b/include/linux/i2c-tegra.h
> new file mode 100644
> index 0000000..9c85da4
> --- /dev/null

looks ok.

could do with a few tidies before inclusion.

-- 
Ben
