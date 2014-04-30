From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/6] i2c: sh_mobile: devm conversion, irq setup
Date: Thu, 1 May 2014 00:44:56 +0200
Message-ID: <CAMuHMdXZ3OhfLi4Yk7rhA+C2rneoQ+7ouPhdLewgUscUkP5m6g@mail.gmail.com>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
	<1398896470-24663-7-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1398896470-24663-7-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This is what devm was made for. No rollback mechanism needed, remove the
> hook parameter from the irq setup function and simplify it. While we are
> here change some variables to proper types.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
