From: andrew-ct chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH 08/12] nvmem: mtk-efuse: remove nvmem regmap dependency
Date: Wed, 27 Apr 2016 14:30:13 +0800
Message-ID: <1461738613.12466.8.camel@mtksdaap41>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
	 <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:23833 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752241AbcD0GaR (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Apr 2016 02:30:17 -0400
In-Reply-To: <1461526096-29584-9-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, andrew@lunn.ch, Heiko Stuebner <heiko@sntech.de>, Wolfram Sang <wsa@the-dreams.de>, Joachim Eastwood <manabian@gmail.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Srinivas,

On Sun, 2016-04-24 at 20:28 +0100, Srinivas Kandagatla wrote:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Thanks for the patch. It works on our platform. This driver doesn't
support "efuse write". I will send another patch for fixing this.

Acked-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>

Andrew

>  drivers/nvmem/Kconfig     |  1 -
>  drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++++++++++++++++---------------
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 377bc21..c158712 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -48,7 +48,6 @@ config NVMEM_MXS_OCOTP
>  config MTK_EFUSE
>  	tristate "Mediatek SoCs EFUSE support"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
> -	select REGMAP_MMIO
>  	help
>  	  This is a driver to access hardware related data like sensor
>  	  calibration, HDMI impedance etc.
> diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> index 9c49369..32fd572 100644
> --- a/drivers/nvmem/mtk-efuse.c
> +++ b/drivers/nvmem/mtk-efuse.c
> @@ -14,15 +14,35 @@
>  
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/io.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/platform_device.h>
> -#include <linux/regmap.h>
>  
> -static struct regmap_config mtk_regmap_config = {
> -	.reg_bits = 32,
> -	.val_bits = 32,
> -	.reg_stride = 4,
> -};
> +static int mtk_reg_read(void *context,
> +			unsigned int reg, void *_val, size_t bytes)
> +{
> +	void __iomem *base = context;
> +	u32 *val = _val;
> +	int i = 0, words = bytes / 4;
> +
> +	while (words--)
> +		*val++ = readl(base + reg + (i++ * 4));
> +
> +	return 0;
> +}
> +
> +static int mtk_reg_write(void *context,
> +			 unsigned int reg, void *_val, size_t bytes)
> +{
> +	void __iomem *base = context;
> +	u32 *val = _val;
> +	int i = 0, words = bytes / 4;
> +
> +	while (words--)
> +		writel(*val++, base + reg + (i++ * 4));
> +
> +	return 0;
> +}
>  
>  static int mtk_efuse_probe(struct platform_device *pdev)
>  {
> @@ -30,7 +50,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct nvmem_device *nvmem;
>  	struct nvmem_config *econfig;
> -	struct regmap *regmap;
>  	void __iomem *base;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -42,14 +61,12 @@ static int mtk_efuse_probe(struct platform_device *pdev)
>  	if (!econfig)
>  		return -ENOMEM;
>  
> -	mtk_regmap_config.max_register = resource_size(res) - 1;
> -
> -	regmap = devm_regmap_init_mmio(dev, base, &mtk_regmap_config);
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "regmap init failed\n");
> -		return PTR_ERR(regmap);
> -	}
> -
> +	econfig->stride = 4;
> +	econfig->word_size = 4;
> +	econfig->reg_read = mtk_reg_read;
> +	econfig->reg_write = mtk_reg_write;
> +	econfig->size = resource_size(res);
> +	econfig->priv = base;
>  	econfig->dev = dev;
>  	econfig->owner = THIS_MODULE;
>  	nvmem = nvmem_register(econfig);
