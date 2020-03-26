From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: rcar: clean up after refactoring i2c_timings
Date: Thu, 26 Mar 2020 11:19:00 +0100
Message-ID: <CAMuHMdUGD4LNXUxWes6VH=agwC_W6_MzoV13bnR4LPYqe2e6wg@mail.gmail.com>
References: <20200326100721.1265-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200326100721.1265-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 11:07 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The pointer is not really needed anymore since we have the timings
> struct available in the function itself now. Remove the pointer and
> access the struct directly.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
