Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3ED432BD8;
	Tue, 21 Jul 2026 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618074; cv=none; b=kaV6+n6PcFunH4R3sy110luhfvVQ4wmDZyzTETin3z788wwBrlcsftR7uwYa+BKP97IOaNMEvAlRDEG9iVh291FbIAezPDnE2yxw9TRYeDc+aMiDm1wEzYeJvDTVUdpk1yhr4HNskpJ6/7JRVHKBLAtw0RijdInHhekaXZVHqls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618074; c=relaxed/simple;
	bh=jr0b1lua5vEp7miN9+ABJLweal/AiKuMndn/u+84zbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwG+lt0YmvHgls7oBQktVH01QR4xY3XLMI8yre813jRVQGA/pSagZuz4upoXce5nqdxj9BOv4ZziNvjKTOs4NSG/hUCERx4nZ/fET1KCNsPpRjH+Oe3Ux0oLUgU1FwS5x4+s+A1d9AdL9nbv0GlxSduSh7I92z9oi9Yk/QkFPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1FXNd35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1FXNd35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C071F000E9;
	Tue, 21 Jul 2026 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618072;
	bh=HvaixHYbM3OubS7LO+agyIgFP8m6s3KgZsCNhudraAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U1FXNd35Ua/iejyLavvg7O0fjr4MpfMf/iVRSy6KdF3hOsDkiCNuDmt7xDV7pOyFi
	 gWxiZ0pxxxkvd11IkA9jIuCl1j5IuvLJjZStw99CJ25f44zgYp4H8CqzVUHR+jxLKX
	 NYVLwBFord+SiIn1QUGj+AMAwRr6K2j1FnNjgLUQ0e55gdHrsvQr5Hzu6vCNbG/bSS
	 DQUFKyR5zzAFOsyRo3VvX+4O5pWZEVCrNYnpubA06Qwhmjj7thS6bLDLKoyhhHKctr
	 C4bGjyHQ7i/JD/UojUmFH47vQo2FckS73EnQctSNxkYcXhNBVzIlqNSP0Hzgv6+02S
	 gSDTyTk19hoig==
Date: Tue, 21 Jul 2026 09:14:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nina_Kuo@novatek.com.tw
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ben_huang@novatek.com.tw, toby_chui@novatek.com.tw, 
	shihpei_hsu@novatek.com.tw
Subject: Re: [PATCH v3 3/3] i2c: Add i2c-nt726xx.c I2C driver for Novatek
 NT726xx SoCs
Message-ID: <20260721-qualified-mustang-of-pride-a6fc53@quoll>
References: <20260715073521.147610-1-Nina_Kuo@novatek.com.tw>
 <20260715073534.147663-1-Nina_Kuo@novatek.com.tw>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715073534.147663-1-Nina_Kuo@novatek.com.tw>

On Wed, Jul 15, 2026 at 03:35:34PM +0800, Nina_Kuo@novatek.com.tw wrote:
> From: Ben Huang <Ben_Huang@novatek.com.tw>
> 
> This patch introduce the support of I2C bus controller driver of
> Novatek NT726xx SoCs.
> 
> This driver performs the fundamental read/write functions as
> an I2C controller and supports Standard-mode and Fast-mode.
> Default operation is Stardard-mode.
> 
> Signed-off-by: Ben Huang <Ben_Huang@novatek.com.tw>
> Signed-off-by: Nina Kuo <Nina_Kuo@novatek.com.tw>
> ---
>  drivers/i2c/busses/Kconfig       |  10 +
>  drivers/i2c/busses/Makefile      |   1 +
>  drivers/i2c/busses/i2c-nt726xx.c | 698 +++++++++++++++++++++++++++++++
>  3 files changed, 709 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-nt726xx.c
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index d35456994280..52ee2c82e9d5 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -962,6 +962,16 @@ config I2C_NPCM
>  	  controllers.
>  	  Driver can also support slave mode (select I2C_SLAVE).
>  
> +config I2C_NT726XX
> +	tristate "Novatek NT726xx Driver"
> +	default n
> +	help
> +	  Say Y here if you want to enable I2C bus controller on
> +	  Novatek NT726xx SoCs.
> +	  This driver performs fundamental read/write functions
> +	  as an I2C bus controller and supports Standard-mode and
> +	  Fast-mode. Default operation is Standard-mode.
> +
>  config I2C_OCORES
>  	tristate "OpenCores I2C Controller"
>  	help
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 3755c54b3d82..e82646919916 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_I2C_MV64XXX)	+= i2c-mv64xxx.o
>  obj-$(CONFIG_I2C_MXS)		+= i2c-mxs.o
>  obj-$(CONFIG_I2C_NOMADIK)	+= i2c-nomadik.o
>  obj-$(CONFIG_I2C_NPCM)		+= i2c-npcm7xx.o
> +obj-$(CONFIG_I2C_NT726XX)	+= i2c-nt726xx.o
>  obj-$(CONFIG_I2C_OCORES)	+= i2c-ocores.o
>  obj-$(CONFIG_I2C_OMAP)		+= i2c-omap.o
>  obj-$(CONFIG_I2C_OWL)		+= i2c-owl.o
> diff --git a/drivers/i2c/busses/i2c-nt726xx.c b/drivers/i2c/busses/i2c-nt726xx.c
> new file mode 100644
> index 000000000000..ac3fd7ccc68c
> --- /dev/null
> +++ b/drivers/i2c/busses/i2c-nt726xx.c
> @@ -0,0 +1,698 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Novatek Microelectronics Corp.
> + * Author: Ben Huang <ben_huang@novatek.com.tw>
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/version.h>
> +
> +#define I2C_INFO_LOG(fmt, ...)		\
> +	pr_info("[I/SOC_I2C] " fmt, ##__VA_ARGS__)
> +
> +#define I2C_ERR_LOG(fmt, ...)		\
> +	pr_err("[E/SOC_I2C] " fmt, ##__VA_ARGS__)

No, you do not get own printing stuff.

This is not Linux coding style. Learn how Linux treats your own new
abstraction layers.

...

> +static int nvt_i2c_probe(struct platform_device *pdev)
> +{
> +	struct nvt_i2c_bus *i2c;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	i2c->base = devm_ioremap_resource(&pdev->dev, res);

Look at other drivers

> +	if (IS_ERR(i2c->base)) {
> +		I2C_ERR_LOG("failed to map controller\n");
> +		return PTR_ERR(i2c->base);

Look at other drivers how they do it

> +	}
> +
> +	init_completion(&i2c->msg_complete);
> +	i2c->dev = &pdev->dev;
> +
> +	ret = nvt_i2c_parse_dts(i2c);
> +	if (ret)
> +		return ret;
> +
> +	nvt_i2c_init(i2c);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		I2C_ERR_LOG("No IRQ resource\n");

Look at other drivers how they do it

> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, nvt_i2c_isr,
> +			       IRQF_SHARED | IRQF_TRIGGER_HIGH, I2C_NAME, i2c);
> +	if (ret) {
> +		I2C_ERR_LOG("devm_request_irq fail\n");

Look at other drivers how they do it

> +		return ret;
> +	}
> +
> +	/* Setup I2C adapter */
> +	i2c->adapter.owner = THIS_MODULE;
> +	i2c->adapter.class = I2C_CLASS_HWMON;
> +	i2c->adapter.algo = &nvt_i2c_algo;
> +	i2c->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
> +	i2c->adapter.dev.parent = &pdev->dev;
> +	i2c->adapter.timeout = 3 * HZ;
> +	strscpy(i2c->adapter.name, I2C_NAME, sizeof(i2c->adapter.name));
> +	i2c_set_adapdata(&i2c->adapter, i2c);
> +
> +	ret = i2c_add_numbered_adapter(&i2c->adapter);
> +	if (ret) {
> +		I2C_ERR_LOG("[%s] failed to add adapter\n", dev_name(&pdev->dev));
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, i2c);
> +
> +	return 0;
> +}
> +
> +static void nvt_i2c_remove(struct platform_device *pdev)
> +{
> +	struct nvt_i2c_bus *i2c = platform_get_drvdata(pdev);
> +
> +	writel(I2C_IRQ_DISABLE_SETTING, i2c->base + I2C_REG_INTR);
> +	writel(readl(i2c->base + I2C_REG_CTRL) & ~I2C_ENABLE,
> +	       i2c->base + I2C_REG_CTRL);
> +	of_node_put(i2c->adapter.dev.of_node);
> +	i2c_del_adapter(&i2c->adapter);
> +}
> +
> +static const struct dev_pm_ops nvt_i2c_pm_ops = {
> +	.resume_early = nvt_i2c_resume,
> +	.suspend_late = nvt_i2c_suspend,
> +};
> +
> +static struct platform_driver nvt_i2c_driver = {
> +	.probe = nvt_i2c_probe,
> +	.remove = nvt_i2c_remove,
> +	.driver = {
> +		.name = "nvt_nt726xx_i2c",
> +		.owner = THIS_MODULE,

NAK, you just sent us 13 year old downstream junk code. This is not
acceptable, because by doing that you ignore all the bugs or issues we
fixed over last 13 years.


> +		.pm = &nvt_i2c_pm_ops,
> +		.of_match_table = of_match_ptr(nvt_i2c_of_match),
> +	},
> +};
> +
> +static int __init nvt_i2c_platform_init(void)
> +{
> +	return platform_driver_register(&nvt_i2c_driver);
> +}
> +postcore_initcall(nvt_i2c_platform_init);

NAK, this is not postcore!

You have standard module. Full stop.

Best regards,
Krzysztof

