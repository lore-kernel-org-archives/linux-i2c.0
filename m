From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 00/14] ARM: dts: r8a779x: use demuxer for I2C
Date: Wed, 9 Nov 2016 20:00:01 +0100
Message-ID: <CAMuHMdU_eLmb2ET0KvUyQEfeeUK7Vy3mk6+=FSvczBhy8snvNA@mail.gmail.com>
References: <20161106202032.5227-1-wsa+renesas@sang-engineering.com>
 <20161109084406.GA22213@verge.net.au> <20161109085954.GA1807@katana> <20161109143508.GA19184@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161109143508.GA19184@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 9, 2016 at 3:35 PM, Simon Horman <horms@verge.net.au> wrote:
>> Will you get access to these boards in the foreseeable future?
>
> As mentioned by Geert, there is a porter in Magnus's board farm.
> Unforunately I have never had much luck in getting it to boot.

>From the point of view of the kernel, there's not much difference between
Koelsch/Lager and Porter. The U-Boot is newer than the one on Lager,
though, so no need for the "dtb" keyword in the bootz command.

I use:

    setenv ethaddr 2e:01:02:03:04:05
    tftp 41000000 porter/zImage
    tftp 40f00000 porter/r8a7791-porter.dtb
    bootz 41000000 - 40f00000

Perhaps you didn't have the MAC address set?

BTW, for blanche, I had to add "setenv fdt_high 41000000".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
