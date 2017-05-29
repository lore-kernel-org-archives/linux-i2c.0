From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: rcar: use correct length when unmapping DMA
Date: Mon, 29 May 2017 11:11:18 +0200
Message-ID: <CAMuHMdVWxQSKGox8v=n-E2HWtr2pWbK1WJ8JDfR+=sEw1-ZjkQ@mail.gmail.com>
References: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170528075217.1214-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
List-Id: linux-i2c@vger.kernel.org

On Sun, May 28, 2017 at 9:52 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Because we need to transfer some bytes with PIO, the msg length is not
> the length of the DMA buffer. Use the correct value which we used when
> doing the mapping.
>
> Fixes: 73e8b0528346e8 ("i2c: rcar: add DMA support")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
