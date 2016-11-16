From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 07/14] ARM: dts: koelsch: use demuxer for I2C4
Date: Wed, 16 Nov 2016 14:48:18 +0100
Message-ID: <CAMuHMdWXRdHo2cRigCPXWLfEd+FQjwDD0Q4t4AkG0ROckcZFhA@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161106202032.5227-8-wsa+renesas@sang-engineering.com> <CAMuHMdXzqakz6RYXFMOe5ps0SPsxDWHbOV024ts_E_qufVOutQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXzqakz6RYXFMOe5ps0SPsxDWHbOV024ts_E_qufVOutQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 15, 2016 at 4:45 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> i2c4 shares pins with vin0. Hence enabling the former breaks the latter:
>
>     sh-pfc e6060000.pfc: pin GP_4_13 already requested by
> e6520000.i2c; cannot claim for e6ef0000.video
>     sh-pfc e6060000.pfc: pin-141 (e6ef0000.video) status -22
>     sh-pfc e6060000.pfc: could not request pin 141 (GP_4_13) from
> group vin0_data24  on device sh-pfc
>     rcar-vin e6ef0000.video: Error applying setting, reverse things back
>     rcar-vin: probe of e6ef0000.video failed with error -22
>
> There may be similar issues on other boards. Haven't checked yet.

I inspected the DTSes for Koelsch, Lager, Gose, and Alt, looking for
conflicting configurations of pins:
  - Lager:
      - i2c1 and iic1 share GP1_16 and GP1_17, but that is handled through
        i2c-demux-pinctrl
      - usb0_ovc_vbus and usb0 share GP5_19, but that is probably OK, as these
        groups are configured for the same function?
  - Koelsch: i2c4 and and vin0_data24 share pins GP4_13 and GP4_14
             (vin0_data8 would be OK)
  - Gose: Same issue as Koelsch.
  - Alt: No conflicts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
