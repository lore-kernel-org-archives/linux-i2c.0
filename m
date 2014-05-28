From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 00/11] i2c: rcar: cleanup series
Date: Wed, 28 May 2014 10:26:38 +0200
Message-ID: <CAMuHMdUq5YxL+JfSuAzPtd4bHkPJXACqMAG+Fc0AFv7TkUDHDg@mail.gmail.com>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Wed, May 28, 2014 at 9:44 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> Wolfram Sang (11):
>   i2c: rcar: not everything needs to be a function
>   i2c: rcar: no need to store irq number
>   i2c: rcar: refactor bus state machine
>   i2c: rcar: refactor irq state machine
>   i2c: rcar: check bus free before first message
>   i2c: rcar: refactor setting up msg
>   i2c: rcar: refactor status bit handling
>   i2c: rcar: remove spinlock
>   i2c: rcar: reuse status bits as enable bits
>   i2c: rcar: janitorial cleanup after refactoring
>   i2c: rcar: update copyright and license information

Acked-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
