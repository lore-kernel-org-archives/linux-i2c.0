From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 14/14] i2c: mux: demux-pinctrl: make drivers with no
 pinctrl work again
Date: Mon, 7 Nov 2016 14:10:12 +0100
Message-ID: <CAMuHMdX6aV0htv+zFqoaGZpjs=JYwVBegOdzye3z0wB6PeGMvQ@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com> <20161106202032.5227-15-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33357 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbcKGNKO (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 7 Nov 2016 08:10:14 -0500
In-Reply-To: <20161106202032.5227-15-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>

On Sun, Nov 6, 2016 at 9:20 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Some drivers like i2c-gpio do not have dedicated pinctrl states. They
> broke when error checking for pinctrl was added. Detect them now, and in
> their case, simply skip over pinctrl configuration.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> index b3893f6282ba5b..3e6fe1760d82fc 100644
> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> @@ -69,10 +69,28 @@ static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 ne
>                 goto err_with_revert;
>         }
>
> -       p = devm_pinctrl_get_select(adap->dev.parent, priv->bus_name);
> +       /*
> +        * Check if there are pinctrl states at all. Note: we cant' use

can't

> +        * devm_pinctrl_get_select() because we need to distinguish between
> +        * the -ENODEV from devm_pinctrl_get() and pinctrl_lookup_state().
> +        */
> +       p = devm_pinctrl_get(adap->dev.parent);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
