From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] i2c/busses/i2c-icy: Add platform_data for LTC2990
Date: Tue, 13 Aug 2019 09:04:20 +0200
Message-ID: <CAMuHMdWZHFPQ7Wt9oD8jiyBsXzoTQsxgr-U5kLsgG82n_gfTzA@mail.gmail.com>
References: <20190812235237.21797-1-max@enpas.org> <20190812235237.21797-4-max@enpas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812235237.21797-4-max@enpas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Staudt <max@enpas.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, linux-hwmon@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
List-Id: linux-i2c@vger.kernel.org

Hi Max,

On Tue, Aug 13, 2019 at 1:54 AM Max Staudt <max@enpas.org> wrote:
> This enables the three additional inputs available on the 2019 a1k.org
> reprint of the ICY board:
>
>   in1 will be the voltage of the 5V rail, divided by 2.
>   in2 will be the voltage of the 12V rail, divided by 4.
>   temp3 will be measured using a PCB loop next the chip.
>
> Signed-off-by: Max Staudt <max@enpas.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

However, I would merge patches 2/4 and 4/4, and move the result
after patch 3.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
