From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 01/14] ARM: dts: lager: rename and reindex i2cexio
Date: Mon, 7 Nov 2016 14:12:05 +0100
Message-ID: <CAMuHMdVqy1=uAa7WUgLo_3mpqyTzoab0bSnmHBUgpQ=vJup0Gw@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com> <20161106202032.5227-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161106202032.5227-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

On Sun, Nov 6, 2016 at 9:20 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
>
> The rename from i2cexio to i2cexio0 is in in preparation for adding

double "in"

> i2cexio1 which will use the dmuxer for IIC1/I2C1.

demuxer

> The reindexing from i2c8 to i2c10 is to allow space for grouping of
> additional GPIO buses to added by follow-up patches to support demuxing of

to be added

> other i2c buses.
>
> Also note that fallback to GPIO is not provided by the hardware for IIC0/I2C0.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [wsa: rebased, fixed alias and removed typo in commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
