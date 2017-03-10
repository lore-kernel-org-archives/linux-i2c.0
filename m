From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 05/10] i2c: meson: set clock divider in probe instead of setting it for each transfer
Date: Fri, 10 Mar 2017 15:17:55 -0800
Message-ID: <m2shmkd8m4.fsf@baylibre.com>
References: <f39c9314-4314-3d98-aef2-3bc3c815e63b@gmail.com>
        <5fcfa996-5986-1856-d6f7-a979b7c5d5c9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36196 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdCJXYR (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 10 Mar 2017 18:24:17 -0500
Received: by mail-pf0-f179.google.com with SMTP id o126so47172796pfb.3
        for <linux-i2c@vger.kernel.org>; Fri, 10 Mar 2017 15:24:16 -0800 (PST)
In-Reply-To: <5fcfa996-5986-1856-d6f7-a979b7c5d5c9@gmail.com> (Heiner
        Kallweit's message of "Thu, 9 Mar 2017 07:42:08 +0100")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> The bus frequency won't change, therefore we can set the clock divider
> in probe already and we don't have to set it for each transfer.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - no changes
> ---
>  drivers/i2c/busses/i2c-meson.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index a5764be5..594fec22 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -74,7 +74,6 @@ enum {
>   * @error:	Flag set when an error is received
>   * @lock:	To avoid race conditions between irq handler and xfer code
>   * @done:	Completion used to wait for transfer termination
> - * @timings:	Struct including the bus frequency

You just added this field in PATCH 03/10.  Why not do this patch
first, which will simplify the other.

Kevin

>   * @tokens:	Sequence of tokens to be written to the device
>   * @num_tokens:	Number of tokens
>   */
> @@ -93,7 +92,6 @@ struct meson_i2c {
>  
>  	spinlock_t		lock;
>  	struct completion	done;
> -	struct i2c_timings	timings;
>  	u32			tokens[2];
>  	int			num_tokens;
>  };
> @@ -132,12 +130,12 @@ static void meson_i2c_write_tokens(struct meson_i2c *i2c)
>  	writel(i2c->tokens[1], i2c->regs + REG_TOK_LIST1);
>  }
>  
> -static void meson_i2c_set_clk_div(struct meson_i2c *i2c)
> +static void meson_i2c_set_clk_div(struct meson_i2c *i2c, unsigned int freq)
>  {
>  	unsigned long clk_rate = clk_get_rate(i2c->clk);
>  	unsigned int div;
>  
> -	div = DIV_ROUND_UP(clk_rate, i2c->timings.bus_freq_hz * 4);
> +	div = DIV_ROUND_UP(clk_rate, freq * 4);
>  
>  	/* clock divider has 12 bits */
>  	WARN_ON(div >= (1 << 12));
> @@ -149,7 +147,7 @@ static void meson_i2c_set_clk_div(struct meson_i2c *i2c)
>  			   (div >> 10) << REG_CTRL_CLKDIVEXT_SHIFT);
>  
>  	dev_dbg(i2c->dev, "%s: clk %lu, freq %u, div %u\n", __func__,
> -		clk_rate, i2c->timings.bus_freq_hz, div);
> +		clk_rate, freq, div);
>  }
>  
>  static void meson_i2c_get_data(struct meson_i2c *i2c, char *buf, int len)
> @@ -369,7 +367,6 @@ static int meson_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	int i, ret = 0, count = 0;
>  
>  	clk_enable(i2c->clk);
> -	meson_i2c_set_clk_div(i2c);
>  
>  	for (i = 0; i < num; i++) {
>  		ret = meson_i2c_xfer_msg(i2c, msgs + i, i == num - 1);
> @@ -396,6 +393,7 @@ static const struct i2c_algorithm meson_i2c_algorithm = {
>  static int meson_i2c_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> +	struct i2c_timings timings;
>  	struct meson_i2c *i2c;
>  	struct resource *mem;
>  	int irq, ret = 0;
> @@ -404,7 +402,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
>  	if (!i2c)
>  		return -ENOMEM;
>  
> -	i2c_parse_fw_timings(&pdev->dev, &i2c->timings, true);
> +	i2c_parse_fw_timings(&pdev->dev, &timings, true);
>  
>  	i2c->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, i2c);
> @@ -462,6 +460,8 @@ static int meson_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	meson_i2c_set_clk_div(i2c, timings.bus_freq_hz);
> +
>  	return 0;
>  }
