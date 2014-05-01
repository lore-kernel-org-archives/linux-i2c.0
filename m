From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC] i2c: sh_mobile: WIP! Fix clock calculation for newer SoCs
Date: Thu, 1 May 2014 15:26:15 +0200
Message-ID: <CAMuHMdUVCP-dwJ-HMD1xHb9qR_qm-n0YTpYVq9w37DvD=E=X=w@mail.gmail.com>
References: <1398945555-12928-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398945555-12928-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Thu, May 1, 2014 at 1:59 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> +static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
> +       { .compatible = "renesas,rmobile-iic", .data = (void *)1 },
> +       { .compatible = "renesas,iic-r8a7790", .data = (void *)2 },
> +       { .compatible = "renesas,iic-r8a7791", .data = (void *)2 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);

> +               const struct of_device_id *match;
> +
> +               match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
> +               pd->clks_per_count = match->data;

Missing cast "(int)match->data"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
