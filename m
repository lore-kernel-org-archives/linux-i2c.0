From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 36/62] i2c: irq: Remove IRQF_DISABLED
Date: Mon, 19 Sep 2011 16:44:55 +0800
Message-ID: <CAGsJ_4z8_zx3dATD+F8A0Krw0N0REBTdzD3NiHFOU9P5h0Reuw@mail.gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com> <1315383059-3673-37-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1315383059-3673-37-git-send-email-yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, mingo-X9Un+BFzKDI@public.gmane.org, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alessandro Rubini <rubini-9wsNiZum9E8@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Lucas De Marchi <lucas.demarchi-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, STEricsson <STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2011/9/7 Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> This flag is a NOOP and can be removed now.
>
> Signed-off-by: Yong Zhang <yong.zhang0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
> =C2=A0drivers/i2c/busses/i2c-bfin-twi.c =C2=A0 | =C2=A0 =C2=A04 ++--
> =C2=A0drivers/i2c/busses/i2c-designware.c | =C2=A0 =C2=A02 +-
> =C2=A0drivers/i2c/busses/i2c-highlander.c | =C2=A0 =C2=A02 +-
> =C2=A0drivers/i2c/busses/i2c-nomadik.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 =
+-
> =C2=A0drivers/i2c/busses/i2c-nuc900.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 =
+-
> =C2=A0drivers/i2c/busses/i2c-pmcmsp.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 =
+-
> =C2=A0drivers/i2c/busses/i2c-s3c2410.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 =
+-
> =C2=A0drivers/i2c/busses/i2c-sh7760.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 =
+-
> =C2=A0drivers/i2c/busses/i2c-sh_mobile.c =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0drivers/i2c/busses/i2c-stu300.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 =
+-
> =C2=A010 files changed, 11 insertions(+), 11 deletions(-)
