From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 03/12] i2c: meson: use i2c core for DT clock-frequency
 parsing
Date: Wed, 08 Mar 2017 10:10:29 +0100
Message-ID: <1488964229.2514.4.camel@baylibre.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
         <a8a8f3e8-4568-67a9-25bc-874c6f426243@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38402 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdCHMHa (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 07:07:30 -0500
Received: by mail-wm0-f45.google.com with SMTP id t189so28934750wmt.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 04:06:56 -0800 (PST)
In-Reply-To: <a8a8f3e8-4568-67a9-25bc-874c6f426243@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-03-08 at 07:44 +0100, Heiner Kallweit wrote:
> We don't have to parse the DT manually to retrieve the bus frequency
> and we don't have to maintain an own default for the bus frequency.
> Let the i2c core do this for us.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-
> meson.c
> index 50059d09..5e243efa 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -38,7 +38,6 @@
>  #define REG_CTRL_CLKDIV_MASK	((BIT(10) - 1) <<
> REG_CTRL_CLKDIV_SHIFT)
>  
>  #define I2C_TIMEOUT_MS		500
> -#define DEFAULT_FREQ		100000
>  
>  enum {
>  	TOKEN_END = 0,
> @@ -73,7 +72,7 @@ enum {
>   * @error:	Flag set when an error is received
>   * @lock:	To avoid race conditions between irq handler and
> xfer code
>   * @done:	Completion used to wait for transfer termination
> - * @frequency:	Operating frequency of I2C bus clock
> + * @timings:	Struct including the bus frequency
>   * @tokens:	Sequence of tokens to be written to the device
>   * @num_tokens:	Number of tokens
>   */
> @@ -92,7 +91,7 @@ struct meson_i2c {
>  
>  	spinlock_t		lock;
>  	struct completion	done;
> -	unsigned int		frequency;
> +	struct i2c_timings	timings;
>  	u32			tokens[2];
>  	int			num_tokens;
>  };
> @@ -136,12 +135,12 @@ static void meson_i2c_set_clk_div(struct
> meson_i2c *i2c)
>  	unsigned long clk_rate = clk_get_rate(i2c->clk);
>  	unsigned int div;
>  
> -	div = DIV_ROUND_UP(clk_rate, i2c->frequency * 4);
> +	div = DIV_ROUND_UP(clk_rate, i2c->timings.bus_freq_hz * 4);
>  	meson_i2c_set_mask(i2c, REG_CTRL, REG_CTRL_CLKDIV_MASK,
>  			   div << REG_CTRL_CLKDIV_SHIFT);
>  
>  	dev_dbg(i2c->dev, "%s: clk %lu, freq %u, div %u\n",
> __func__,
> -		clk_rate, i2c->frequency, div);
> +		clk_rate, i2c->timings.bus_freq_hz, div);
>  }
>  
>  static void meson_i2c_get_data(struct meson_i2c *i2c, char *buf, int
> len)
> @@ -396,9 +395,7 @@ static int meson_i2c_probe(struct platform_device
> *pdev)
>  	if (!i2c)
>  		return -ENOMEM;
>  
> -	if (of_property_read_u32(pdev->dev.of_node, "clock-
> frequency",
> -				 &i2c->frequency))
> -		i2c->frequency = DEFAULT_FREQ;
> +	i2c_parse_fw_timings(&pdev->dev, &i2c->timings, true);
>  
>  	i2c->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, i2c);

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
