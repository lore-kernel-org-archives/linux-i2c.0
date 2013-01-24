From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [RFC PATCH] mxs: i2c: Implement arbitrary clock speed derivation
 algorithm
Date: Thu, 24 Jan 2013 08:25:56 +0100
Message-ID: <20130124072555.GD8364@nekote.pengutronix.de>
References: <1354297715-12201-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1354297715-12201-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Marek,

On Fri, Nov 30, 2012 at 06:48:35PM +0100, Marek Vasut wrote:
> This patch drops the i2c timing tables from this driver and instead
> derives the timing based from the requested clock sleep. The timing
> tables were completely wrong anyway when observed on a scope.
> 
> This new algorithm is also only derived by using a scope, but it seems
> to produce much more accurate result.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mxs.c |   94 ++++++++++++++++++++++++------------------
>  1 file changed, 55 insertions(+), 39 deletions(-)
> 
> NOTE: Can someone please test if this patch works for them as well?
>       I tested this on DENX M28EVK and Freescale MX28EVK.

Second call for testers.

> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 9048f34..ad28a7b 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -93,35 +93,6 @@
>  #define MXS_CMD_I2C_READ	(MXS_I2C_CTRL0_SEND_NAK_ON_LAST | \
>  				 MXS_I2C_CTRL0_MASTER_MODE)
>  
> -struct mxs_i2c_speed_config {
> -	uint32_t	timing0;
> -	uint32_t	timing1;
> -	uint32_t	timing2;
> -};
> -
> -/*
> - * Timing values for the default 24MHz clock supplied into the i2c block.
> - *
> - * The bus can operate at 95kHz or at 400kHz with the following timing
> - * register configurations. The 100kHz mode isn't present because it's
> - * values are not stated in the i.MX233/i.MX28 datasheet. The 95kHz mode
> - * shall be close enough replacement. Therefore when the bus is configured
> - * for 100kHz operation, 95kHz timing settings are actually loaded.
> - *
> - * For details, see i.MX233 [25.4.2 - 25.4.4] and i.MX28 [27.5.2 - 27.5.4].
> - */
> -static const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
> -	.timing0	= 0x00780030,
> -	.timing1	= 0x00800030,
> -	.timing2	= 0x00300030,
> -};
> -
> -static const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
> -	.timing0	= 0x000f0007,
> -	.timing1	= 0x001f000f,
> -	.timing2	= 0x00300030,
> -};
> -
>  /**
>   * struct mxs_i2c_dev - per device, private MXS-I2C data
>   *
> @@ -137,7 +108,9 @@ struct mxs_i2c_dev {
>  	struct completion cmd_complete;
>  	u32 cmd_err;
>  	struct i2c_adapter adapter;
> -	const struct mxs_i2c_speed_config *speed;
> +
> +	uint32_t timing0;
> +	uint32_t timing1;
>  
>  	/* DMA support components */
>  	int				dma_channel;
> @@ -153,9 +126,16 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
>  {
>  	stmp_reset_block(i2c->regs);
>  
> -	writel(i2c->speed->timing0, i2c->regs + MXS_I2C_TIMING0);
> -	writel(i2c->speed->timing1, i2c->regs + MXS_I2C_TIMING1);
> -	writel(i2c->speed->timing2, i2c->regs + MXS_I2C_TIMING2);
> +	/*
> +	 * Configure timing for the I2C block. The I2C TIMING2 register has to
> +	 * be programmed with this particular magic number. The rest is derived
> +	 * from the XTAL speed and requested I2C speed.
> +	 *
> +	 * For details, see i.MX233 [25.4.2 - 25.4.4] and i.MX28 [27.5.2 - 27.5.4].
> +	 */
> +	writel(i2c->timing0, i2c->regs + MXS_I2C_TIMING0);
> +	writel(i2c->timing1, i2c->regs + MXS_I2C_TIMING1);
> +	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
>  
>  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
>  }
> @@ -540,6 +520,43 @@ static bool mxs_i2c_dma_filter(struct dma_chan *chan, void *param)
>  	return true;
>  }
>  
> +static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, int speed)
> +{
> +	/* The I2C block clock run at 24MHz */
> +	const uint32_t clk = 24000000;
> +	uint32_t base;
> +	uint16_t high_count, low_count, rcv_count, xmit_count;
> +	struct device *dev = i2c->dev;
> +
> +	if (speed > 540000) {
> +		dev_err(dev, "Speed too high (%d Hz), using 540 kHz\n", speed);
> +		speed = 540000;
> +	} else if (speed < 12000) {
> +		dev_err(dev, "Speed too low (%d Hz), using 12 kHz\n", speed);
> +		speed = 12000;
> +	}

I'd think dev_warn would do, since we are able to continue. No need to
resend, though.

Rest looks good, thanks!

   Wolfram
