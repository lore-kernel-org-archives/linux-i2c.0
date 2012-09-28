From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 28 Sep 2012 14:05:36 +0530
Message-ID: <CAKohpok6hOwzaV+6SYRH3jiZ24MNLZA1oQb7PpKkTDeKgLy5Tw@mail.gmail.com>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
	<20120927142825.GB16606@pengutronix.de>
	<CAOh2x=nm+iiw3pcKtRcWjBnnjc0+p1kQ7zcqjHHyX9351cZDHQ@mail.gmail.com>
	<20120928072735.GC16606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120928072735.GC16606-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 28 September 2012 12:57, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Why do you default to GPIOF_OUT_INIT_LOW? The idle state of scl is hi=
gh.
> Using low here introduces an additional clk pulse.

Went deep into the code i wrote ages ago to check why i did so :)

My initial idea was, because the idle state of scl is high, giving anot=
her high
initially  with gpio would be a waste. As the slave will not notice a c=
hange.

So, i will do it low and then following code will run with delay before=
 setting
gpio again. This will ensure, the initial gpio-set is used as clock.

	for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
		ndelay(delay);
		gpio_set_value(bri->scl_gpio, val);

                ...
	}

Yes, you are correct in saying that i have generated 9 *2 + 1 =3D 19
half-clocks...
or 9.5 clocks. Will fix it by making initial value of i as 1.

Also, will take care of this when user sends his own flags :)

--
viresh
