From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH] i2c: acpi: put device when verifying client fails
Date: Thu, 12 Mar 2020 14:38:24 +0100
Message-ID: <CAMuHMdXUZF3R7TaB6E96DGbb320fD51w0ycJouOEfR-LwoUZQA@mail.gmail.com>
References: <20200312133244.9564-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200312133244.9564-1-wsa@the-dreams.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 12, 2020 at 2:32 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> i2c_verify_client() can fail, so we need to put the device when that
> happens.
>
> Fixes: 525e6fabeae2 ("i2c / ACPI: add support for ACPI reconfigure notifications")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
