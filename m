From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V4 Resend 1/2] i2c/adapter: Add bus recovery
 infrastructure
Date: Fri, 28 Sep 2012 09:27:35 +0200
Message-ID: <20120928072735.GC16606@pengutronix.de>
References: <fce6ddd7e8061ed0f428d48973d73b75c9ae585c.1346044190.git.viresh.kumar@linaro.org>
 <20120927142825.GB16606@pengutronix.de>
 <CAOh2x=nm+iiw3pcKtRcWjBnnjc0+p1kQ7zcqjHHyX9351cZDHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOh2x=nm+iiw3pcKtRcWjBnnjc0+p1kQ7zcqjHHyX9351cZDHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viresh kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Sep 28, 2012 at 09:11:34AM +0530, viresh kumar wrote:
> >> +             ndelay(delay);
> >> +             gpio_set_value(bri->scl_gpio, val);
> >> +
> >> +             /* break if sda got high, check only when scl line i=
s high */
> >> +             if (!bri->skip_sda_polling && val)
> >> +                     if (gpio_get_value(bri->sda_gpio))
> >> +                             break;
> > I'm not sure it's worth to conditionally shortcut here. Either alwa=
ys or
> > never shortcut.
>=20
> This was done, because few platforms may not have configuration bits =
to read
> status of sda line.. For them skip_sda_polling was required.
>=20
> Whereas, others would need this to see if we can return early.
What is the upside of returning early? I'd say, just don't do it.

> >> + * @put_gpio: called after recover_bus() to get padmux configured=
 for scl line
> >> + *   as scl. Only required if is_gpio_recovery =3D=3D true.
> >> + * @scl_gpio: gpio number of the scl line. Only required if is_gp=
io_recovery =3D=3D
> >> + *   true.
> >> + * @sda_gpio: gpio number of the sda line. Only required if is_gp=
io_recovery =3D=3D
> >> + *   true and skip_sda_polling =3D=3D false.
> >> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 impl=
ies
> >> + *   GPIOF_OUT_INIT_LOW.
> > IMHO you should not make this configurable but use
> >
> >         GPIOF_OUT_INIT_HIGH | GPIOF_OPEN_DRAIN
>=20
> Discussed here:
> http://www.spinics.net/lists/linux-i2c/msg07325.html
Why do you default to GPIOF_OUT_INIT_LOW? The idle state of scl is high=
=2E
Using low here introduces an additional clk pulse.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
