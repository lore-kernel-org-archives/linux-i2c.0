From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH] i2c: meson: fix wrong variable usage in
 meson_i2c_put_data
Date: Wed, 08 Mar 2017 10:17:03 +0100
Message-ID: <1488964623.2514.7.camel@baylibre.com>
References: <7ecc4542-a6ca-f266-5c34-057b3f5a33bf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34696 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbdCHJ0C (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 04:26:02 -0500
Received: by mail-wr0-f169.google.com with SMTP id l37so18953169wrc.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 01:25:16 -0800 (PST)
In-Reply-To: <7ecc4542-a6ca-f266-5c34-057b3f5a33bf@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Tue, 2017-03-07 at 21:06 +0100, Heiner Kallweit wrote:
> Most likely a copy & paste error.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
> index 2aa61bbb..73b97c71 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -175,7 +175,7 @@ static void meson_i2c_put_data(struct meson_i2c *i2c, char *buf, int len)
>  		wdata1 |= *buf++ << ((i - 4) * 8);
>  
>  	writel(wdata0, i2c->regs + REG_TOK_WDATA0);
> -	writel(wdata0, i2c->regs + REG_TOK_WDATA1);
> +	writel(wdata1, i2c->regs + REG_TOK_WDATA1);
>  
>  	dev_dbg(i2c->dev, "%s: data %08x %08x len %d\n", __func__,
>  		wdata0, wdata1, len);

Good catch, Strange it did not show up before.

You are just missing the Fixes tag.
Fixes: 30021e3707a7 ("i2c: add support for Amlogic Meson I2C controller")

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
