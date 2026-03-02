Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB482DAFBB;
	Mon,  2 Mar 2026 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436251; cv=none; b=rw9i4U05OTe26459eXPHA7VyXf1lv80SEGTCud7zCgBRhpUmH4wPX1j2L5ENL1Uaa44HxdBsaaTKuElrepp+RD/CBF0MqQDLrE4b8ch6LX+Q2jULmnLCyCuSU8oQbBEHriv/YrDQLEUQsmK7W8ec3MRa4tyYjYr4YXXnHGzLgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436251; c=relaxed/simple;
	bh=mckUW/1KbPzJ+xiJL5UO159/k0otECZIExeNuSqax1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZobrogM48qIZcV+qY1wt+CbOqRgRKmxIFfxz1QKoEq6QjT4js5ho/y/Ut6PpPRqQGPhUjFvDwNVBE7ez9gV4haW6wq/Rw5R72CvZetj20QwS2FVPel4pYDhyhXJyJTySKOJ543fax1giGNj7x+K9qnFS8ghSi0RVxhKC2nn+5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA1Y95kr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA1Y95kr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6403C19423;
	Mon,  2 Mar 2026 07:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772436251;
	bh=mckUW/1KbPzJ+xiJL5UO159/k0otECZIExeNuSqax1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TA1Y95krxt0o+actWzMSM0X0DwjzYlLg9rwCSCDHsKGiHOfsl/Fv5B6tcWjCvJ5lQ
	 R2Z9Eo1RQFqh3Ic+eOQ2KPoxHqHKOr0Xi1qTjB7ZGZzi4O610tKMO+4nahMx3RKyYu
	 Hq+vad/1X3AkUvGUWVxmsOoPWgEfec0PDpTo9v9m4cYG6DbF8LrlRGxEfgruYF4QOj
	 Nsk4DUhoW71Zo1OJi79nfNdBbWCUwveOg2Yw6Y5+wihlrrZe9ZTOL7PJpsrLy2KdSF
	 8XR0ihx3xyE7gjbMhS4Fn9yjugDxdrB2WlRHtBUXZ5k2aam3cZX29xInJiYbGS1wTE
	 1PTt7u88aeU8Q==
Date: Mon, 2 Mar 2026 08:24:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: andi.shyti@kernel.org, ychuang3@nuvoton.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] i2c: ma35d1: Add Nuvoton MA35D1 I2C driver support
Message-ID: <20260302-spiffy-capuchin-of-completion-e8c5b2@quoll>
References: <20260302020822.13936-1-zychennvt@gmail.com>
 <20260302020822.13936-3-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302020822.13936-3-zychennvt@gmail.com>

On Mon, Mar 02, 2026 at 02:08:21AM +0000, Zi-Yu Chen wrote:
> Add I2C support for Nuvoton MA35D1 SoC.
> The controller supports standard, fast and fast-plus modes,
> and provides master/slave functionality.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
> ---
>  drivers/i2c/busses/Kconfig      |  13 +
>  drivers/i2c/busses/Makefile     |   1 +
>  drivers/i2c/busses/i2c-ma35d1.c | 819 ++++++++++++++++++++++++++++++++
>  3 files changed, 833 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-ma35d1.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index e11d50750e63..6bf8be1d2575 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1589,4 +1589,17 @@ config I2C_VIRTIO
>            This driver can also be built as a module. If so, the module
>            will be called i2c-virtio.
>  
> +config I2C_MA35D1
> +	tristate "Nuvoton MA35D1 I2C driver"
> +	depends on ARCH_MA35


Missing COMPILE_TEST

...

> +	/* Setup info block for the I2C core */
> +	strscpy(i2c->adap.name, "ma35d1-i2c", sizeof(i2c->adap.name));
> +	i2c->adap.owner = THIS_MODULE;
> +	i2c->adap.algo = &ma35d1_i2c_algorithm;
> +	i2c->adap.retries = 2;
> +	i2c->adap.algo_data = i2c;
> +	i2c->adap.dev.parent = &pdev->dev;
> +	i2c->adap.dev.of_node = pdev->dev.of_node;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +
> +	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +				   &busfreq);
> +	if (ret) {
> +		dev_err(i2c->dev, "clock-frequency not specified in DT\n");
> +		return ret;
> +	}
> +
> +	/* Calculate divider based on the current peripheral clock rate */
> +	clkdiv = DIV_ROUND_CLOSEST(clk_get_rate(i2c->clk), busfreq * 4) - 1;
> +	if (clkdiv < 0 || clkdiv > 0xffff) {
> +		dev_err(dev, "invalid clkdiv value: %d\n", clkdiv);
> +		return -EINVAL;
> +	}
> +
> +	i2c->irq = platform_get_irq(pdev, 0);
> +	if (i2c->irq < 0)
> +		return i2c->irq;
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	pm_runtime_set_autosuspend_delay(dev, I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0)
> +		goto rpm_disable;
> +
> +	writel(clkdiv & 0xffff, i2c->regs + MA35_CLKDIV);
> +
> +	ret = devm_request_irq(dev, i2c->irq, ma35d1_i2c_irq, IRQF_SHARED,
> +			       dev_name(dev), i2c);
> +

No blank line ever between call and if()

> +	if (ret != 0) {

Write simple and obvious code.

if (ret)

> +		dev_err(dev, "cannot claim IRQ %d\n", i2c->irq);
> +		goto rpm_disable;
> +	}
> +
> +	/* Give it another chance if pinctrl used is not ready yet */
> +	if (ret == -EPROBE_DEFER)

Pointless and dead code.

> +		goto rpm_disable;
> +
> +	ret = i2c_add_adapter(&i2c->adap);
> +	if (ret) {
> +		dev_err(dev, "failed to add bus to i2c core: %d\n", ret);
> +		goto rpm_disable;
> +	}
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +rpm_disable:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_suspended(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	return ret;
> +}
> +
> +static void ma35d1_i2c_remove(struct platform_device *pdev)
> +{
> +	struct ma35d1_i2c *i2c = platform_get_drvdata(pdev);
> +
> +	i2c_del_adapter(&i2c->adap);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
> +static int ma35d1_i2c_suspend(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	spin_lock_irq(&i2c->lock);
> +
> +	/* Prepare for wake-up from I2C events if slave mode is active */
> +	if (i2c->slave) {
> +		val = readl(i2c->regs + MA35_CTL0);
> +		val |= (MA35_CTL_SI | MA35_CTL_AA);
> +		writel(val, i2c->regs + MA35_CTL0);
> +		ma35d1_i2c_enable_irq(i2c);
> +	}
> +
> +	spin_unlock_irq(&i2c->lock);
> +
> +	/* Setup wake-up control */
> +	writel(0x1, i2c->regs + MA35_WKCTL);
> +
> +	/* Clear pending wake-up flags */
> +	val = readl(i2c->regs + MA35_WKSTS);
> +	writel(val, i2c->regs + MA35_WKSTS);
> +
> +	enable_irq_wake(i2c->irq);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_i2c_resume(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	/* Disable wake-up */
> +	writel(0x0, i2c->regs + MA35_WKCTL);
> +
> +	/* Clear pending wake-up flags */
> +	val = readl(i2c->regs + MA35_WKSTS);
> +	writel(val, i2c->regs + MA35_WKSTS);
> +
> +	disable_irq_wake(i2c->irq);
> +	return 0;
> +}
> +
> +static int ma35d1_i2c_runtime_suspend(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +
> +	/* Disable I2C controller */
> +	val = readl(i2c->regs + MA35_CTL0);
> +	val &= ~MA35_CTL_I2CEN;
> +	writel(val, i2c->regs + MA35_CTL0);
> +
> +	clk_disable_unprepare(i2c->clk);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_i2c_runtime_resume(struct device *dev)
> +{
> +	struct ma35d1_i2c *i2c = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = clk_prepare_enable(i2c->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock in resume\n");
> +		return ret;
> +	}
> +
> +	/* Enable I2C controller */
> +	val = readl(i2c->regs + MA35_CTL0);
> +	val |= MA35_CTL_I2CEN;
> +	writel(val, i2c->regs + MA35_CTL0);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ma35d1_i2c_pmops = {
> +	SYSTEM_SLEEP_PM_OPS(ma35d1_i2c_suspend, ma35d1_i2c_resume)
> +		RUNTIME_PM_OPS(ma35d1_i2c_runtime_suspend,
> +			       ma35d1_i2c_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id ma35d1_i2c_of_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-i2c" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_i2c_of_match);
> +
> +static struct platform_driver ma35d1_i2c_driver = {
> +	.probe      = ma35d1_i2c_probe,
> +	.remove     = ma35d1_i2c_remove,
> +	.driver     = {
> +		.name   = "ma35d1-i2c",
> +		.owner  = THIS_MODULE,

Do not upstream 12-year-old code. We fixed all these issues long time.
Please write your driver from scratch, so you will not
repeat/reintroduce all the issues which we already fixed.

> +		.of_match_table = ma35d1_i2c_of_match,
> +		.pm = pm_ptr(&ma35d1_i2c_pmops),
> +	},

Best regards,
Krzysztof

