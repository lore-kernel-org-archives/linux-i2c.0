From: <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 0/4] Led driver support for LP5521 and LP5523 chips
Date: Mon, 27 Sep 2010 11:21:40 +0200
Message-ID: <62697B07E9803846BC582181BD6FB6B835EF64A9AA@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1284631946-5350-1-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1284631946-5350-1-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rpurdie-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, akpm-3NddpPZAyC0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi

>-----Original Message-----
>From: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-i2c-
>owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Onkalo Samu.P (Nokia-MS/Tampere)
>Sent: 16 September, 2010 13:12
>To: rpurdie-VuQAYsv1563Yd54FQh9/CA@public.gmane.org

I haven't got any mails or comments from Richard about this driver. 
Also led tree here:
http://git.o-hand.com/cgit.cgi/linux-rpurdie-leds/

is not updated in 4 months.

I'm just wondering should I send this to somebody else than Richard Purdie?

I'll update the driver based on other comments and send v2 patch set.

-Samu

>Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: [PATCH 0/4] Led driver support for LP5521 and LP5523 chips
>
>Patch set provides support for LP5521 and LP5523 LED driver chips
>from National Semicondutor. Both drivers supports programmable engines
>and naturally LED class features.
>
>Documentation is provided as a part of the patch set.
>I created "leds" sub directory to Documentation.
>Perhaps rest of the leds* documentation should be moved
>there.
>
>Datasheets are freely available at National Semiconductor www pages.
>
>Tested to work in top of 2.6.36-RC4 kernel.
>
>Samu Onkalo (4):
>  leds: driver for National Semiconductor LP5521 chip
>  leds: Driver for National Semiconductors LP5523 chip
>  leds: Update LP552x support Kconfig and Makefile
>  Documentation: led drivers lp5521 and lp5523
>
> Documentation/leds/leds-lp5521.txt |   85 +++
> Documentation/leds/leds-lp5523.txt |   81 +++
> drivers/leds/Kconfig               |   18 +
> drivers/leds/Makefile              |    2 +
> drivers/leds/leds-lp5521.c         |  820 +++++++++++++++++++++++++++
> drivers/leds/leds-lp5523.c         | 1063
>++++++++++++++++++++++++++++++++++++
> include/linux/leds-lp5521.h        |   46 ++
> include/linux/leds-lp5523.h        |   46 ++
> 8 files changed, 2161 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/leds/leds-lp5521.txt
> create mode 100644 Documentation/leds/leds-lp5523.txt
> create mode 100644 drivers/leds/leds-lp5521.c
> create mode 100644 drivers/leds/leds-lp5523.c
> create mode 100644 include/linux/leds-lp5521.h
> create mode 100644 include/linux/leds-lp5523.h
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
