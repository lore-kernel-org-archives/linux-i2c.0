From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 2/4] i2c: add docs to clarify DMA handling
Date: Tue, 6 Jun 2017 13:12:02 +0200
Message-ID: <CAMuHMdVQmFqC3pZh8BcNROnrdqQ+gx+4Mg40Y1AY=WXE9i83wQ@mail.gmail.com>
References: <20170606092034.1516-1-wsa+renesas@sang-engineering.com>
 <20170606092034.1516-3-wsa+renesas@sang-engineering.com> <CAMuHMdVLV91TdpWz=AeCbLM0Occ4byGMZ37wDtBGStR+j9OL2Q@mail.gmail.com>
 <20170606102447.cftuyhtx7zo2fe2g@ninjato> <CAMuHMdWv9hBtYO_Xqwx_A64anC=4d3o_EE7FOSbknPYb-N5X8g@mail.gmail.com>
 <20170606105431.bm7jiclz2k7h7lj2@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170606105431.bm7jiclz2k7h7lj2@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Jun 6, 2017 at 12:54 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> So it won't fall back to PIO if CONFIG_DMA_API_DEBUG is enabled?
>
> No, it will complain loudly with more details about the same things (and
> some more). But for that to do, it cannot fall back to PIO.
>
> Otherwise, you might get the idea that all is fine since you enabled
> CONFIG_DMA_API_DEBUG but miss that most of you transfers fell back to
> PIO. That was my thinking...

Hmm....

I have it enabled all the time. So my devices may stop working...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
