From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Mon, 26 Oct 2015 09:31:15 +0100
Message-ID: <CAMuHMdXLMRji80Ma9hbUJg_PChS1s2JaGy00L3M3rmyOnYKqHQ@mail.gmail.com>
References: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
	<20151026081746.GC597@x1>
	<CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK7LNATVmVi=4ugv0MgoCUzusphNeAXTC_K-PsXDiTLoCkV4-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mauro Carvalho Chehab <mc>
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 26, 2015 at 9:27 AM, Masahiro Yamada
<yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org> wrote:
> 2015-10-26 17:17 GMT+09:00 Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>:
>>> This series adds two I2C controller drivers.
>>> (they are completely different IPs.)
>>>
>>> The first one is a very simple FIFO-less I2C controller,
>>> which is used on some older UniPhier SoCs.
>>>
>>> The other one is higher-performance I2C controller with TX/RX FIFO,
>>> used on newer UniPhier SoCs.
>>
>> And you have sent this to me because ... ?
>
>
> No special reason.
>
>
> I sent this series to linux-i2c-u79uwXL29TaiAVqoAR/hOA@public.gmane.org
>
> I guess you were automatically CC'ed by scripts/get_maintainer.pl.
>
> Using get_maintainer.pl is a normal process when sending patches, I think.

Please use common sense. It doesn't make much sense to CC everybody who
ever made a minor edit to an affected file.

If checkpatch comes up with more than 5 names, this should ring a bell.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
