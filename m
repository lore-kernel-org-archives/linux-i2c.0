From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: i2c-mux: Fix channel parent node assignment
Date: Tue, 30 May 2017 10:31:21 +0200
Message-ID: <CAMuHMdV3MMMegePaNRk07Stym+ovhjksPFrpeBRbxSciSB7BTQ@mail.gmail.com>
References: <1496132006-20329-1-git-send-email-jacopo+renesas@jmondi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496132006-20329-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Peter Rosin <peda@axentia.se>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jacopo,

On Tue, May 30, 2017 at 10:13 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> I2c-mux channels are created with the mux parent device as their own
> parent, while they should be siblings of the mux itself.

Isn't it the other way around? Cfr. the example and the patch.

> Fix this.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> ---
>
> Hello,
>    while inspecting child nodes of an i2c adapter it has been noted that
> child devices of an i2c-mux are listed as children of the i2c adapter itself,
> and not of the i2c-mux.
>
> The hierarchy of devices looked like
>
> -- i2c-04
> --- eeprom@57
> --- video_receiver@70
> --- video_receiver@34
> --- gmsl-deserializer@0         <-- MUX
> --- gmsl-deserializer@0/i2c@0   <-- MUX CHANNEL

= sibling of mux

>
> It now looks like
>
> -- i2c-04
> --- eeprom@57
> --- video_receiver@70
> --- video_receiver@34
> --- gmsl-deserializer@0
> ---- gmsl-deserializer@0/i2c@0

= child of mux

>
>  drivers/i2c/i2c-mux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 83768e8..37b7804 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -324,7 +324,7 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>         priv->adap.owner = THIS_MODULE;
>         priv->adap.algo = &priv->algo;
>         priv->adap.algo_data = priv;
> -       priv->adap.dev.parent = &parent->dev;

= sibling of mux

> +       priv->adap.dev.parent = muxc->dev;

= child of mux

>         priv->adap.retries = parent->retries;
>         priv->adap.timeout = parent->timeout;
>         priv->adap.quirks = parent->quirks;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
