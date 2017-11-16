From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/6] arm64: renesas: r8a77995: add I2C support
Date: Thu, 16 Nov 2017 10:10:27 +0100
Message-ID: <CAMuHMdV4pBYPTrnCCU8BU1Lr8t2ejcKwWpXWzp-PuBgT2DfVSg@mail.gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510759526-30346-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-4-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ulrich,

On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Defines R-Car D3 I2C controllers 0-3.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
> @@ -400,6 +400,70 @@
>                         status = "disabled";
>                 };
>
> +               i2c0: i2c@e6500000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       compatible = "renesas,i2c-r8a77995",
> +                                    "renesas,rcar-gen3-i2c";
> +                       reg = <0 0xe6500000 0 0x40>;
> +                       interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 931>;
> +                       power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +                       resets = <&cpg 931>;
> +                       dmas = <&dmac1 0x91>, <&dmac1 0x90>;
> +                       dma-names = "tx", "rx";

Missing set for dmac2? (for all four interfaces)

> +                       i2c-scl-internal-delay-ns = <110>;

According to Table 57.1, all i2c interfaces on R-Car D3 have LVTTL
output buffers,
so this should be <6> for all four interfaces.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
