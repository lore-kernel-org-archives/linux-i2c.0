From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count
 to 2
Date: Fri, 7 Nov 2014 08:12:57 +0100
Message-ID: <CAMuHMdVWS3HjsPj7T3JFxVuiRGSZmopkeDadpKH1YdmnAGYdNw@mail.gmail.com>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
	<1415274730-310-2-git-send-email-geert+renesas@glider.be>
	<20141107052420.GA1278@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141107052420.GA1278@katana>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, Nov 7, 2014 at 6:24 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> Note that the L/H values still differ from the Transfer Rate Settings
>> example in Table 19.3 of the datasheet, which suggests 0x121/0xe7.
>
> Is the formula different or is it rounding errors?

The formula is different. It doesn't use absolute tLOW, tHIGH, and tF
values, but only the duty cycle of the clock.

It's similar in the R-Car Gen2 docs. Except that on Gen2, there's no
mention of using a duty cycle of 5/3 for High Speed like on AG5.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
