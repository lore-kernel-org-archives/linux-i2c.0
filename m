From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] i2c: sh_mobile: use proper device with dma_mapping_error
Date: Thu, 25 Aug 2016 09:59:12 +0200
Message-ID: <CAMuHMdUsm4bH8oiTAit6cooOfH6tzzuZ8QnfbOe+1gbzrpbRDQ@mail.gmail.com>
References: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824091929.2082-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 24, 2016 at 11:19 AM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We must use the same device we used for mapping.
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
