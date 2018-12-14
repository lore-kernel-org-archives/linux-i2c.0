From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Date: Fri, 14 Dec 2018 11:40:20 +0100
Message-ID: <CAMuHMdWzXW15qX5AHxbDObp-9EJbLVv0J1myN1g9nPA1fUGFaQ@mail.gmail.com>
References: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544732554-7140-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 13, 2018 at 9:22 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Similarly to R-Car E3, RZ/G2E doesn't come with automatic
> transmission registers, as such it is not considered compatible
> with the existing fallback bindings.
>
> Add SoC specific binding compatibility to allow for later
> support for automatic transmission.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
