From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/6] arm64: renesas: draak: enable I2C controller 1
Date: Thu, 16 Nov 2017 10:31:31 +0100
Message-ID: <CAMuHMdX1iitObng0nvhmP4r5yb1CnqBwbchu6qDQLtqjPLbDQg@mail.gmail.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1510759526-30346-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510759526-30346-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Uli,

On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> No devices to add, I2C1 has an external connector only.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
but please see below.

> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts

> @@ -84,6 +89,12 @@
>         };
>  };
>
> +&i2c1 {
> +       pinctrl-0 = <&i2c1_pins>;
> +       pinctrl-names = "default";
> +       status = "okay";

If no devices are connected, perhaps it's wise to defer the status update
to e.g. an overlay that describes what's connected to CN23?

Or do you want it enabled to allow adding devices manually using
/sys/bus/i2c/devices/i2c-1/new_device?

> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
