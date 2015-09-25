From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH 0/3] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Fri, 25 Sep 2015 11:12:13 +0900
Message-ID: <CAK7LNAQgcphEQA27Z4+rDiJZ1wZ7-FLDhx3hVz+bVcTstdgQXw@mail.gmail.com>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438243942-26401-1-git-send-email-yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Xudong Chen <xudong.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Subhendu Sekhar Behera <sbehera-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Wei Yan <sledge.yanwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,


Could you have some time for reviewing this series?
Perhaps, after ELCE?


2015-07-30 17:12 GMT+09:00 Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:
>
> This series adds two I2C controller drivers.
> (they are completely different IPs.)
>
> The first one is a very simple FIFO-less I2C controller,
> which is used on some older UniPhier SoCs.
>
> The other one is higher-performance I2C controller with TX/RX FIFO,
> used on newer UniPhier SoCs.
>
>
>
> Masahiro Yamada (3):
>   i2c: uniphier: add UniPhier FIFO-less I2C driver
>   i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
>   i2c: uniphier: add bindings for UniPhier I2C controllers
>
>  .../devicetree/bindings/i2c/i2c-uniphier.txt       |  46 ++
>  drivers/i2c/busses/Kconfig                         |  16 +
>  drivers/i2c/busses/Makefile                        |   2 +
>  drivers/i2c/busses/i2c-uniphier-f.c                | 589 +++++++++++++++++++++
>  drivers/i2c/busses/i2c-uniphier.c                  | 446 ++++++++++++++++
>  5 files changed, 1099 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
>  create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
>  create mode 100644 drivers/i2c/busses/i2c-uniphier.c
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
