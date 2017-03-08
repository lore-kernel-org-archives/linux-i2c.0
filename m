From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 01/12] i2c: meson: use min instead of min_t where min_t
 isn't needed
Date: Wed, 08 Mar 2017 10:25:57 +0100
Message-ID: <1488965157.2514.10.camel@baylibre.com>
References: <d5f0545a-fb4c-b436-20f5-7df9d10605b1@gmail.com>
         <c1a3b573-bb03-059a-ee7a-77903d2aebfe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36629 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdCHJ0C (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 8 Mar 2017 04:26:02 -0500
Received: by mail-wm0-f46.google.com with SMTP id n11so109859614wma.1
        for <linux-i2c@vger.kernel.org>; Wed, 08 Mar 2017 01:25:59 -0800 (PST)
In-Reply-To: <c1a3b573-bb03-059a-ee7a-77903d2aebfe@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-amlogic@lists.infradead.org, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-03-08 at 07:42 +0100, Heiner Kallweit wrote:
> Use min instead of min_t where min_t isn't needed.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/i2c/busses/i2c-meson.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-
> meson.c
> index 73b97c71..40e5da9a 100644
> --- a/drivers/i2c/busses/i2c-meson.c
> +++ b/drivers/i2c/busses/i2c-meson.c
> @@ -156,10 +156,10 @@ static void meson_i2c_get_data(struct meson_i2c
> *i2c, char *buf, int len)
>  	dev_dbg(i2c->dev, "%s: data %08x %08x len %d\n", __func__,
>  		rdata0, rdata1, len);
>  
> -	for (i = 0; i < min_t(int, 4, len); i++)
> +	for (i = 0; i < min(4, len); i++)
>  		*buf++ = (rdata0 >> i * 8) & 0xff;
>  
> -	for (i = 4; i < min_t(int, 8, len); i++)
> +	for (i = 4; i < min(8, len); i++)
>  		*buf++ = (rdata1 >> (i - 4) * 8) & 0xff;
>  }
>  
> @@ -168,10 +168,10 @@ static void meson_i2c_put_data(struct meson_i2c
> *i2c, char *buf, int len)
>  	u32 wdata0 = 0, wdata1 = 0;
>  	int i;
>  
> -	for (i = 0; i < min_t(int, 4, len); i++)
> +	for (i = 0; i < min(4, len); i++)
>  		wdata0 |= *buf++ << (i * 8);
>  
> -	for (i = 4; i < min_t(int, 8, len); i++)
> +	for (i = 4; i < min(8, len); i++)
>  		wdata1 |= *buf++ << ((i - 4) * 8);
>  
>  	writel(wdata0, i2c->regs + REG_TOK_WDATA0);
> @@ -186,7 +186,7 @@ static void meson_i2c_prepare_xfer(struct
> meson_i2c *i2c)
>  	bool write = !(i2c->msg->flags & I2C_M_RD);
>  	int i;
>  
> -	i2c->count = min_t(int, i2c->msg->len - i2c->pos, 8);
> +	i2c->count = min(i2c->msg->len - i2c->pos, 8);
>  
>  	for (i = 0; i < i2c->count - 1; i++)
>  		meson_i2c_add_token(i2c, TOKEN_DATA);

Since the second argument of min is always a constant, this patch does
not change anything, but it doesn't hurt either. I suppose it is OK
