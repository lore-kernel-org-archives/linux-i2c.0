From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Build regressions/improvements in v3.14-rc7
Date: Tue, 18 Mar 2014 09:50:37 +0100
Message-ID: <CAMuHMdVUKbgKEaQ-0ksTd3NJoNASmqy0CiVH6AryAt-HT7Qy3A@mail.gmail.com>
References: <1395132465-19450-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395132465-19450-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Mar 18, 2014 at 9:47 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> JFYI, when comparing v3.14-rc7[1]  to v3.14-rc6[3], the summaries are:
>   - build errors: +5/-13

Ignoring randconfig failures that are not really new:

  + /scratch/kisskb/src/drivers/i2c/busses/i2c-cpm.c: error: implicit
declaration of function 'irq_of_parse_and_map'
[-Werror=implicit-function-declaration]:  => 449:2
  + /scratch/kisskb/src/drivers/i2c/busses/i2c-cpm.c: error: implicit
declaration of function 'of_iomap'
[-Werror=implicit-function-declaration]:  => 460:2

powerpc/mpc85xx_defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7277/ (all 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7258/ (all 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
