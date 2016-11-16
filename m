From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 07/14] ARM: dts: koelsch: use demuxer for I2C4
Date: Wed, 16 Nov 2016 11:35:22 +0100
Message-ID: <CAMuHMdVVqhZgTjaFiGgviCRD0X0DkQPZjpnta2FOhFmV7M+CvQ@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161106202032.5227-8-wsa+renesas@sang-engineering.com> <CAMuHMdXzqakz6RYXFMOe5ps0SPsxDWHbOV024ts_E_qufVOutQ@mail.gmail.com>
 <20161115174450.GA21715@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161115174450.GA21715@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hi Simon,

On Tue, Nov 15, 2016 at 6:44 PM, Simon Horman <horms@verge.net.au> wrote:
>> i2c4 shares pins with vin0. Hence enabling the former breaks the latter:
>>
>>     sh-pfc e6060000.pfc: pin GP_4_13 already requested by
>> e6520000.i2c; cannot claim for e6ef0000.video
>>     sh-pfc e6060000.pfc: pin-141 (e6ef0000.video) status -22
>>     sh-pfc e6060000.pfc: could not request pin 141 (GP_4_13) from
>> group vin0_data24  on device sh-pfc
>>     rcar-vin e6ef0000.video: Error applying setting, reverse things back
>>     rcar-vin: probe of e6ef0000.video failed with error -22
>>
>> There may be similar issues on other boards. Haven't checked yet.
>
> Thanks, I will drop this patch for now.
>
> I checked the boot logs of other boards with similar patches and didn't see
> anything there.

Do you have CONFIG_VIDEO_ADV7604=y?

I expect the issue to be present on gose, too. So far I didn't see it
there, yet.
But the vin DTS of gose is different from koelsch, causing vin0 not to be
initialized?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
