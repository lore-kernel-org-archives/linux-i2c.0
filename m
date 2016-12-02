From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 i2c/for-next] i2c: rcar: Add per-Generation fallback bindings
Date: Fri, 2 Dec 2016 09:42:42 +0100
Message-ID: <CAMuHMdUhgphRaHS8ms9syFmq4V1BpYAAkLDh7Jdbsf8t+zCDMw@mail.gmail.com>
References: <1480666227-7622-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1480666227-7622-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 2, 2016 at 9:10 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the

it's

> relationship between IP blocks might be. For example, I believe that
> r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> descendant of the former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme being adopted for

is being

> drivers for Renesas SoCs.
>
> Also:
> * Deprecate renesas,i2c-rcar. It seems poorly named as it is only
>   compatible with R-Car Gen 1. It also appears unused in mainline.
> * Add some text to describe per-SoC bindings
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
