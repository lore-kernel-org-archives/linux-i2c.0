From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC v2 i2c/for-next] i2c: rcar: Add per-Generation
 fallback bindings
Date: Thu, 1 Dec 2016 16:55:13 +0100
Message-ID: <CAMuHMdXr5stBRDtD0AE=1Af3PUiA=e5pP_X1onfbfO5ri=fPrw@mail.gmail.com>
References: <1480606863-4418-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480606863-4418-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Simon,

On Thu, Dec 1, 2016 at 4:41 PM, Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
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
> Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> ---
> Include accidently omitted i2c-rcar.c portion of patch
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 32 ++++++++++++++--------
>  drivers/i2c/busses/i2c-rcar.c                      |  5 +++-
>  2 files changed, 24 insertions(+), 13 deletions(-)
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

"renesas,rcar-gen1-i2c" etc.

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

"renesas,rcar-gen2-i2c"

>         reg = <0 0xe6508000 0 0x40>;
>         interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
>         clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 726615e54f2a..622def6b43e2 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -793,7 +793,6 @@ static const struct i2c_algorithm rcar_i2c_algo = {
>  };
>
>  static const struct of_device_id rcar_i2c_dt_ids[] = {
> -       { .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },
>         { .compatible = "renesas,i2c-r8a7778", .data = (void *)I2C_RCAR_GEN1 },
>         { .compatible = "renesas,i2c-r8a7779", .data = (void *)I2C_RCAR_GEN1 },
>         { .compatible = "renesas,i2c-r8a7790", .data = (void *)I2C_RCAR_GEN2 },
> @@ -803,6 +802,10 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
>         { .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
>         { .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },
>         { .compatible = "renesas,i2c-r8a7796", .data = (void *)I2C_RCAR_GEN3 },
> +       { .compatible = "renesas,i2c-rcar", .data = (void *)I2C_RCAR_GEN1 },    // Deprecated
> +       { .compatible = "renesas,rcar-gen1-i2c", .data = (void *)I2C_RCAR_GEN1 },
> +       { .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
> +       { .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },

The driver does it right ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
