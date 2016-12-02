From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 i2c/for-next] i2c: rcar: Add per-Generation fallback bindings
Date: Fri, 2 Dec 2016 15:59:51 +0100
Message-ID: <CAMuHMdWBCJgaiZoKeVBH2KuRPdBFoS6D-=7-8jAwCKe8MGJgUA@mail.gmail.com>
References: <1480688736-7175-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35636 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbcLBO7w (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 2 Dec 2016 09:59:52 -0500
In-Reply-To: <1480688736-7175-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Dec 2, 2016 at 3:25 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that it's not clear what the
> relationship between IP blocks might be. For example, I believe that
> r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
> descendant of the former or vice versa.
>
> We can, however, by examining the documentation and behaviour of the
> hardware at run-time observe that the current driver implementation appears
> to be compatible with the IP blocks on SoCs within a given generation.
>
> For the above reasons and convenience when enabling new SoCs a
> per-generation fallback compatibility string scheme is being adopted for
> drivers for Renesas SoCs.
>
> Also:
> * Deprecate renesas,i2c-rcar. It seems poorly named as it is only
>   compatible with R-Car Gen 1. It also appears unused in mainline.
> * Add some text to describe per-SoC bindings
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt

> +       "renesas,i2c-r8a7779" if the device is a part of a R8A7797 SoC.

R8A7779

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
