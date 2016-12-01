From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC i2c/for-next] i2c: rcar: Add per-Generation fallback bindings
Date: Thu, 1 Dec 2016 16:26:14 +0100
Message-ID: <CAMuHMdX9Wavet8LpWvLMfJ3ZpwF+7biPSXtZAKq1YdKCe7ubDg@mail.gmail.com>
References: <1480605494-32460-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36003 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757738AbcLAP0Q (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 1 Dec 2016 10:26:16 -0500
In-Reply-To: <1480605494-32460-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Thu, Dec 1, 2016 at 4:18 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> In the case of Renesas R-Car hardware we know that there are generations of
> SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the
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
> drivers for Renesas SoCs.
>
> Also deprecate renesas,i2c-rcar. It seems poorly named as it is only
> compatible with R-Car Gen 1. It also appears unused in mainline.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 32 ++++++++++++++--------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> index 239632a0d709..8c679b17c4c6 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> @@ -1,17 +1,25 @@
>  I2C for R-Car platforms
>
>  Required properties:
> -- compatible: Must be one of
> -       "renesas,i2c-rcar"
> -       "renesas,i2c-r8a7778"
> -       "renesas,i2c-r8a7779"
> -       "renesas,i2c-r8a7790"
> -       "renesas,i2c-r8a7791"
> -       "renesas,i2c-r8a7792"
> -       "renesas,i2c-r8a7793"
> -       "renesas,i2c-r8a7794"
> -       "renesas,i2c-r8a7795"
> -       "renesas,i2c-r8a7796"
> +- compatible:
> +       "renesas,i2c-r8a7778" if the device is a part of a R8A7778 SoC.
> +       "renesas,i2c-r8a7779" if the device is a part of a R8A7797 SoC.
> +       "renesas,i2c-r8a7790" if the device is a part of a R8A7790 SoC.
> +       "renesas,i2c-r8a7791" if the device is a part of a R8A7791 SoC.
> +       "renesas,i2c-r8a7792" if the device is a part of a R8A7792 SoC.
> +       "renesas,i2c-r8a7793" if the device is a part of a R8A7793 SoC.
> +       "renesas,i2c-r8a7794" if the device is a part of a R8A7794 SoC.
> +       "renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
> +       "renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
> +       "renesas,i2c-rcar-gen1" for a generic R-Car Gen1 compatible device.
> +       "renesas,i2c-rcar-gen2" for a generic R-Car Gen2 compatible device.
> +       "renesas,i2c-rcar-gen3" for a generic R-Car Gen3 compatible device.

Please use "renesas,<family>-<module>" when adding family-specific
compatible values where non are defined yet.

I.e.
"renesas,rcar-gen1-i2c"
"renesas,rcar-gen1-i2c"
"renesas,rcar-gen1-i2c"

> +       "renesas,i2c-rcar" (deprecated)
> +
> +       When compatible with the generic version, nodes must list the
> +       SoC-specific version corresponding to the platform first followed
> +       by the generic version.
> +
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: interrupt specifier.
> @@ -33,7 +41,7 @@ Examples :
>  i2c0: i2c@e6508000 {
>         #address-cells = <1>;
>         #size-cells = <0>;
> -       compatible = "renesas,i2c-r8a7791";
> +       compatible = "renesas,i2c-r8a7791", "renesas,i2c-rcar-gen2";

"renesas,rcar-gen2-i2c".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
