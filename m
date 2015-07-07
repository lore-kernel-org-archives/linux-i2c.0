From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 0/5] enable I2C on Renesas EMEV2 and KZM9D board
Date: Tue, 7 Jul 2015 10:38:55 +0200
Message-ID: <CAMuHMdUwivjTgj-nOKnHhmmU2po0JMPDhHqW6z7ngiO-D+a6iA@mail.gmail.com>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436219188-4325-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

CC Ian

On Mon, Jul 6, 2015 at 11:46 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> So, I picked up the old series from Ian and reworked it significantly. While
> his series was already an improvement from the driver found in the BSP, it was
> still not ready for upstream. It should be now :) My idea was to start simple
> and improve incrementally, so e.g. clock handling was broken, so clocks are
> always on for starters. Major changes include:

Thanks for your series!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
