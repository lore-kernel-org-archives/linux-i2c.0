From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH 11/12] nvmem: mxs-ocotp: remove nvmem regmap dependency
Date: Thu, 28 Apr 2016 08:50:34 +0200
Message-ID: <5721B2BA.4080100@i2se.com>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-12-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1461526096-29584-12-git-send-email-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: andrew-g2DYL2Zd6BY@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Srinivas,

Am 24.04.2016 um 21:28 schrieb Srinivas Kandagatla:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/nvmem/mxs-ocotp.c | 79 +++++++++++++----------------------------------
>  1 file changed, 21 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
> index 8ba19bb..3bf962c 100644
> --- a/drivers/nvmem/mxs-ocotp.c
> +++ b/drivers/nvmem/mxs-ocotp.c

the include of regmap.h should also be removed.

> @@ -66,11 +66,10 @@ static int mxs_ocotp_wait(struct mxs_ocotp *otp)
>  	return 0;
>  }
>  
> -static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
> -			  void *val, size_t val_size)
> +static int mxs_ocotp_read(void *context, unsigned int offset,
> +			  void *val, size_t bytes)
>  {
>  	struct mxs_ocotp *otp = context;
> -	unsigned int offset = *(u32 *)reg;
>  	u32 *buf = val;
>  	int ret;
>  
> @@ -94,17 +93,16 @@ static int mxs_ocotp_read(void *context, const void *reg, size_t reg_size,
>  	if (ret)
>  		goto close_banks;
>  
> -	while (val_size) {
> +	while (bytes) {
>  		if ((offset < OCOTP_DATA_OFFSET) || (offset % 16)) {
>  			/* fill up non-data register */
> -			*buf = 0;
> +			*buf++ = 0;
>  		} else {
> -			*buf = readl(otp->base + offset);
> +			*buf++ = readl(otp->base + offset);
>  		}
>  
> -		buf++;
> -		val_size--;
> -		offset += reg_size;
> +		bytes -= 4;
> +		offset += 4;

This change would also fix the buffer overflow but Stanislav's patch
should be applied before to get the fix in stable.

>  	}
>  
>  close_banks:
> @@ -117,57 +115,28 @@ disable_clk:
>  	return ret;
>  }
>  
> -static int mxs_ocotp_write(void *context, const void *data, size_t count)
> -{
> -	/* We don't want to support writing */
> -	return 0;
> -}
> -
> -static bool mxs_ocotp_writeable_reg(struct device *dev, unsigned int reg)
> -{
> -	return false;
> -}
> -
>  static struct nvmem_config ocotp_config = {
>  	.name = "mxs-ocotp",
> +	.stride = 16,
> +	.word_size = 4,
>  	.owner = THIS_MODULE,

.reg_read = mxs_ocotp_read,

>  };
>  
> -static const struct regmap_range imx23_ranges[] = {
> -	regmap_reg_range(OCOTP_DATA_OFFSET, 0x210),
> -};
> -
> -static const struct regmap_access_table imx23_access = {
> -	.yes_ranges = imx23_ranges,
> -	.n_yes_ranges = ARRAY_SIZE(imx23_ranges),
> -};
> -
> -static const struct regmap_range imx28_ranges[] = {
> -	regmap_reg_range(OCOTP_DATA_OFFSET, 0x290),
> -};
> -
> -static const struct regmap_access_table imx28_access = {
> -	.yes_ranges = imx28_ranges,
> -	.n_yes_ranges = ARRAY_SIZE(imx28_ranges),
> +struct imx_data {
struct mxs_data

These chips are named imx2x but the platform is mxs. Please don't ask why.
> +	int max_reg;
Since nvmem_config uses "size" instead of "max_reg" we better use "size"
here, too. This avoids confusion and potential issues see below.
>  };
>  
> -static struct regmap_bus mxs_ocotp_bus = {
> -	.read = mxs_ocotp_read,
> -	.write = mxs_ocotp_write, /* make regmap_init() happy */
> -	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> -	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> +static const struct imx_data imx23_data = {
static const struct mxs_data imx23_data
> +	.max_reg = 0x210,
.size = 0x220,
>  };
>  
> -static struct regmap_config mxs_ocotp_config = {
> -	.reg_bits = 32,
> -	.val_bits = 32,
> -	.reg_stride = 16,
> -	.writeable_reg = mxs_ocotp_writeable_reg,
> +static const struct imx_data imx28_data = {
static const struct mxs_data imx28_data
> +	.max_reg = 0x290,
.size = 0x2a0,
>  };
>  
>  static const struct of_device_id mxs_ocotp_match[] = {
> -	{ .compatible = "fsl,imx23-ocotp", .data = &imx23_access },
> -	{ .compatible = "fsl,imx28-ocotp", .data = &imx28_access },
> +	{ .compatible = "fsl,imx23-ocotp", .data = &imx23_data },
> +	{ .compatible = "fsl,imx28-ocotp", .data = &imx23_data },
.compatible = "fsl,imx28-ocotp", .data = &imx28_data
>  	{ /* sentinel */},
>  };
>  MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
> @@ -175,6 +144,7 @@ MODULE_DEVICE_TABLE(of, mxs_ocotp_match);
>  static int mxs_ocotp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct imx_data *data;
const struct mxs_data *data
>  	struct mxs_ocotp *otp;
>  	struct resource *res;
>  	const struct of_device_id *match;
> @@ -205,17 +175,10 @@ static int mxs_ocotp_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	access = match->data;
> -	mxs_ocotp_config.rd_table = access;
> -	mxs_ocotp_config.max_register = access->yes_ranges[0].range_max;
> -
> -	regmap = devm_regmap_init(dev, &mxs_ocotp_bus, otp, &mxs_ocotp_config);
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "regmap init failed\n");
> -		ret = PTR_ERR(regmap);
> -		goto err_clk;
> -	}
> +	data = match->data;
>  
> +	ocotp_config.size = data->max_reg;
data->size

Regards
Stefan
> +	ocotp_config.priv = otp;
>  	ocotp_config.dev = dev;
>  	otp->nvmem = nvmem_register(&ocotp_config);
>  	if (IS_ERR(otp->nvmem)) {
