From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 28 Sep 2012 13:09:24 +0530
Message-ID: <CAKohpomTCRxdE9QcKhisy8Yik_G1i8+DOjhDakLd7imLqX8qmw@mail.gmail.com>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
	<20120927142825.GB16606@pengutronix.de>
	<CAOh2x=nm+iiw3pcKtRcWjBnnjc0+p1kQ7zcqjHHyX9351cZDHQ@mail.gmail.com>
	<20120928072735.GC16606@pengutronix.de>
	<CAKohpo=BCyu2M18TZKhGUUkOKi4y-g-=-dmvY8dzefJTFtgAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKohpo=BCyu2M18TZKhGUUkOKi4y-g-=-dmvY8dzefJTFtgAvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 28 September 2012 13:06, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Why do you default to GPIOF_OUT_INIT_LOW? The idle state of scl is high.
>> Using low here introduces an additional clk pulse.
>
> We aren't giving any clock pulses to scl line. Are you talking about sda?

My fault... we are sending clocks on scl only... Will take care to
optimize it in
next version. If decide to keep it as is, will inform you.

--
viresh
