From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [Patch V4 1/2] i2c: imx: add low power i2c bus driver
Date: Thu, 17 Nov 2016 02:58:49 +0200
Message-ID: <62c45c5d-0567-99b6-b435-1f01408f61db@mleia.com>
References: <1479115411-1537-1-git-send-email-pandy.gao@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:45802 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932212AbcKQA6y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 16 Nov 2016 19:58:54 -0500
In-Reply-To: <1479115411-1537-1-git-send-email-pandy.gao@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <pandy.gao@nxp.com>, wsa@the-dreams.de, u.kleine-koenig@pengutronix.de, cmo@melexis.com, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, frank.li@nxp.com, fugang.duan@nxp.com

On 11/14/2016 11:23 AM, Gao Pan wrote:
> This patch adds lpi2c bus driver to support new i.MX products
> which use lpi2c instead of the old imx i2c.
>
> The lpi2c can continue operating in stop mode when an appropriate
> clock is available. It is also designed for low CPU overhead with
> DMA offloading of FIFO register accesses.
>
> Signed-off-by: Gao Pan <pandy.gao@nxp.com>
> Reviewed-by: Fugang Duan <B38611@freescale.com>
> ---

[snip]

> +
> +static int lpi2c_imx_master_enable(struct lpi2c_imx_struct *lpi2c_imx)
> +{
> +	unsigned int temp;
> +	int ret;
> +
> +	ret = clk_enable(lpi2c_imx->clk);
> +	if (ret)
> +		return ret;
> +
> +	temp = MCR_RST;
> +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> +	writel(0, lpi2c_imx->base + LPI2C_MCR);
> +
> +	ret = lpi2c_imx_config(lpi2c_imx);
> +	if (ret)
> +		return ret;

Missing clk_disable() on error path.

> +
> +	temp = readl(lpi2c_imx->base + LPI2C_MCR);
> +	temp |= MCR_MEN;
> +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> +
> +	return 0;
> +}
> +
> +static int lpi2c_imx_master_disable(struct lpi2c_imx_struct *lpi2c_imx)
> +{
> +	unsigned int temp = 0;

No need of assignment, just do a declaration "u32 temp;".

> +
> +	temp = readl(lpi2c_imx->base + LPI2C_MCR);
> +	temp &= ~MCR_MEN;
> +	writel(temp, lpi2c_imx->base + LPI2C_MCR);
> +
> +	clk_disable(lpi2c_imx->clk);
> +
> +	return 0;
> +}
> +
> +static int lpi2c_imx_msg_complete(struct lpi2c_imx_struct *lpi2c_imx)
> +{
> +	unsigned int timeout;

unsigned long timeout;

> +
> +	timeout = wait_for_completion_timeout(&lpi2c_imx->complete, HZ);
> +
> +	return timeout ? 0 : -ETIMEDOUT;
> +}
> +

[snip]

> +static void lpi2c_imx_read_rxfifo(struct lpi2c_imx_struct *lpi2c_imx)
> +{
> +	unsigned int blocklen, remaining;
> +	unsigned int temp, data;
> +
> +	do {
> +		data = readl(lpi2c_imx->base + LPI2C_MRDR);
> +		if (data & MRDR_RXEMPTY)
> +			break;
> +
> +		lpi2c_imx->rx_buf[lpi2c_imx->delivered++] = data & 0xff;
> +	} while (1);
> +
> +	/*
> +	 * First byte is the length of remaining packet in the SMBus block
> +	 * data read. Add it to msgs->len.
> +	 */
> +	if (lpi2c_imx->block_data) {
> +		blocklen = lpi2c_imx->rx_buf[0];
> +		lpi2c_imx->msglen += blocklen;
> +	}
> +
> +	remaining = lpi2c_imx->msglen - lpi2c_imx->delivered;
> +
> +	if (!remaining) {
> +		complete(&lpi2c_imx->complete);
> +		return;
> +	}
> +
> +	/* not finished, still waiting for rx data */
> +	lpi2c_imx_set_rx_watermark(lpi2c_imx);
> +
> +	/* multiple receive commands */
> +	if (lpi2c_imx->block_data) {
> +		lpi2c_imx->block_data = 0;
> +		temp = remaining;
> +		temp |= (RECV_DATA << 8);
> +		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> +	} else if (!(lpi2c_imx->delivered & 0xff)) {
> +		temp = remaining > CHUNK_DATA ? CHUNK_DATA - 1 : (remaining - 1);

checkpatch complains:

WARNING: line over 80 characters
#473: FILE: drivers/i2c/busses/i2c-imx-lpi2c.c:421:
+     temp = remaining > CHUNK_DATA ? CHUNK_DATA - 1 : (remaining - 1);

May be rewrite it as

	temp = (remaining > CHUNK_DATA ? CHUNK_DATA : remaining) - 1;

?

> +		temp |= (RECV_DATA << 8);
> +		writel(temp, lpi2c_imx->base + LPI2C_MTDR);
> +	}
> +
> +	lpi2c_imx_intctrl(lpi2c_imx, MIER_RDIE);
> +}
> +

[snip]

> +
> +static u32 lpi2c_imx_func(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> +	I2C_FUNC_SMBUS_READ_BLOCK_DATA;

Please indent deeper the second line.

> +}
> +
> +static struct i2c_algorithm lpi2c_imx_algo = {
> +	.master_xfer	= lpi2c_imx_xfer,
> +	.functionality	= lpi2c_imx_func,
> +};
> +
> +static const struct of_device_id lpi2c_imx_of_match[] = {
> +	{ .compatible = "fsl,imx8dv-lpi2c" },
> +	{ .compatible = "fsl,imx7ulp-lpi2c" },

Please sort the compatibles alphanumerically.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lpi2c_imx_of_match)

Missing closing ";"                        ^^^^^^

> +
> +static int lpi2c_imx_probe(struct platform_device *pdev)
> +{
> +	struct lpi2c_imx_struct *lpi2c_imx;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	lpi2c_imx = devm_kzalloc(&pdev->dev,
> +				sizeof(*lpi2c_imx), GFP_KERNEL);

Please place it on a single line, it fits into 80 character limit.

> +	if (!lpi2c_imx)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	lpi2c_imx->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(lpi2c_imx->base))
> +		return PTR_ERR(lpi2c_imx->base);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "can't get irq number\n");
> +		return irq;
> +	}
> +
> +	lpi2c_imx->adapter.owner	= THIS_MODULE;
> +	lpi2c_imx->adapter.algo		= &lpi2c_imx_algo;
> +	lpi2c_imx->adapter.dev.parent	= &pdev->dev;
> +	lpi2c_imx->adapter.dev.of_node	= pdev->dev.of_node;
> +	strlcpy(lpi2c_imx->adapter.name, pdev->name,
> +				sizeof(lpi2c_imx->adapter.name));

checkpatch --strict complains:

CHECK: Alignment should match open parenthesis
#630: FILE: drivers/i2c/busses/i2c-imx-lpi2c.c:578:
+       strlcpy(lpi2c_imx->adapter.name, pdev->name,
+                               sizeof(lpi2c_imx->adapter.name));

> +
> +	lpi2c_imx->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(lpi2c_imx->clk)) {
> +		dev_err(&pdev->dev, "can't get I2C peripheral clock\n");
> +		return PTR_ERR(lpi2c_imx->clk);
> +	}
> +
> +	ret = clk_prepare(lpi2c_imx->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "clk prepare failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "clock-frequency", &lpi2c_imx->bitrate);
> +	if (ret)
> +		lpi2c_imx->bitrate = LPI2C_DEFAULT_RATE;
> +
> +	ret = devm_request_irq(&pdev->dev, irq, lpi2c_imx_isr, 0,
> +				pdev->name, lpi2c_imx);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> +		return ret;

On error path you leak clk_prepare()'d lpi2c_imx->clk clock.

I would recommend to prepare the clock after successful
adapter registration.

> +	}
> +
> +	i2c_set_adapdata(&lpi2c_imx->adapter, lpi2c_imx);
> +	platform_set_drvdata(pdev, lpi2c_imx);
> +
> +	ret = i2c_add_adapter(&lpi2c_imx->adapter);
> +	if (ret) {
> +		dev_err(&pdev->dev, "registration failed\n");

Please remove this notification line, it is reported by I2C core.

> +		return ret;
> +	}
> +
> +	dev_info(&lpi2c_imx->adapter.dev, "LPI2C adapter registered\n");
> +
> +	return 0;
> +}
> +
> +static int lpi2c_imx_remove(struct platform_device *pdev)
> +{
> +	struct lpi2c_imx_struct *lpi2c_imx = platform_get_drvdata(pdev);
> +

Missing clk_unprepare(lpi2c_imx->clk clock);

> +	i2c_del_adapter(&lpi2c_imx->adapter);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver lpi2c_imx_driver = {
> +	.probe = lpi2c_imx_probe,
> +	.remove = lpi2c_imx_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.of_match_table = lpi2c_imx_of_match,
> +	},
> +};
> +
> +module_platform_driver(lpi2c_imx_driver);
> +
> +MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
> +MODULE_DESCRIPTION("I2C adapter driver for LPI2C bus");
> +MODULE_LICENSE("GPL v2");
>

--
With best wishes,
Vladimir
