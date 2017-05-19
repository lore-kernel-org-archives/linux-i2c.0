From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 1/2] i2c: sh_mobile: remove platform_data
Date: Fri, 19 May 2017 09:42:43 +0200
Message-ID: <CAMuHMdV5soEj4w-h19sRDrzRHfn-Zj-t0Dfc3Q7LwyD0UZLyzg@mail.gmail.com>
References: <20170518211140.12023-1-wsa+renesas@sang-engineering.com> <20170518211140.12023-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170518211140.12023-2-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 18, 2017 at 11:11 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> No platform currently upstream makes use of this platform_data anymore.
> The ones that did are converted to DT meanwhile. So, remove it. The old
> platforms likely don't have the 'clks_per_cnt' feature, otherwise it
> would have been implemented by now. And in the unlikely case they need
> to setup a different bus speed, we should rather go for a generic i2c
> platform data just for that.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
