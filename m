From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/6] arm64: renesas: draak: enable I2C controller 0 and EEPROM
Date: Thu, 16 Nov 2017 10:27:56 +0100
Message-ID: <CAMuHMdWmZEoNGRjsumOc+yPe3JTCBobVZd8arzUfcymjF0imDA@mail.gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510759526-30346-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ulrich,

On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enables EEPROM on I2C0 on the Draak board.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts

> @@ -67,6 +72,18 @@
>         };
>  };
>
> +&i2c0 {
> +       pinctrl-0 = <&i2c0_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";
> +
> +       eeprom@50 {
> +               compatible = "atmel,24c01";

This is actually a ROHM Semiconductor BR24T01FVM-W, so it should be

        compatible = "rohm,br24t01", "atmel,24c01";

Please also submit a patch to add that compatible value to
Documentation/devicetree/bindings/eeprom/eeprom.txt.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
