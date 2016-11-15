From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 07/14] ARM: dts: koelsch: use demuxer for I2C4
Date: Tue, 15 Nov 2016 16:45:01 +0100
Message-ID: <CAMuHMdXzqakz6RYXFMOe5ps0SPsxDWHbOV024ts_E_qufVOutQ@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com> <20161106202032.5227-8-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33069 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933828AbcKOPpD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 15 Nov 2016 10:45:03 -0500
In-Reply-To: <20161106202032.5227-8-wsa+renesas@sang-engineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>

Hi Wolfram,

On Sun, Nov 6, 2016 at 9:20 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
>
> Make it possible to fallback to GPIO for I2C4 on the EXIO-E connector.
>
> This is based on reference work for the I2C0 core of the lager/r8a7790
> by Wolfram Sang.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> [wsa: rebased and fixed aliases]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 8d653920957a4b..442d1512a8fa9c 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts

> @@ -476,6 +501,11 @@
>                 function = "i2c2";
>         };
>
> +       i2c4_pins: i2c4 {
> +               groups = "i2c4";
> +               function = "i2c4";
> +       };
> +
>         du_pins: du {
>                 groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
>                 function = "du";
> @@ -732,6 +762,11 @@
>         clock-frequency = <100000>;
>  };
>
> +&i2c4 {
> +       pinctrl-0 = <&i2c4_pins>;
> +       pinctrl-names = "i2c-exio4";
> +};

i2c4 shares pins with vin0. Hence enabling the former breaks the latter:

    sh-pfc e6060000.pfc: pin GP_4_13 already requested by
e6520000.i2c; cannot claim for e6ef0000.video
    sh-pfc e6060000.pfc: pin-141 (e6ef0000.video) status -22
    sh-pfc e6060000.pfc: could not request pin 141 (GP_4_13) from
group vin0_data24  on device sh-pfc
    rcar-vin e6ef0000.video: Error applying setting, reverse things back
    rcar-vin: probe of e6ef0000.video failed with error -22

There may be similar issues on other boards. Haven't checked yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
