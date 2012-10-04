From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery
 infrastructure
Date: Thu, 4 Oct 2012 11:47:43 +0200
Message-ID: <20121004094743.GJ598@pengutronix.de>
References: <viresh.kumar@linaro.org>
 <d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
 <20121004080051.GG598@pengutronix.de>
 <CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw@mail.gmail.com>
 <20121004092017.GH598@pengutronix.de>
 <CAKohpon-q9VdP4crEr0KXpDi+AhcOM708PZkJwZzuUH_4p56+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpon-q9VdP4crEr0KXpDi+AhcOM708PZkJwZzuUH_4p56+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 04, 2012 at 03:02:26PM +0530, Viresh Kumar wrote:
> On 4 October 2012 14:50, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>=20
> >> So, we actually need to do "Low-High" 9 times instead of "High-Low=
".
> >> So, initializing val to 0 should fix it?
> > I don't think this is enough. If you cut off the last half clock of=
 the
> > first sequence above doing 9 times low-high isn't enough. So you ha=
ve to
> > do high + 9x low-high to assert 9 full cycles.
>=20
> I am not cutting the last half clock. val is the variable which keeps
> track of value to be
> set on the line. I am asking to start from zero.
I meant the sequence that created the stall, not the one intending to
clear it. If you remove the last rising edge from that the SCL line is
initially low.
=20
> You mean, we should do a high first and then 9 low-high? But this lin=
e was high
> initially.. what difference will it make by making it high again?
>=20
> Sorry, i am not a I2C expert, so need some help :)
:(

> >> >> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 i=
mplies
> >> >> + *   GPIOF_OUT_INIT_LOW.
> >> >> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 i=
mplies
> >> >> + *   GPIOF_OUT_INIT_LOW.
> >>
> >> > Didn't you want to change this to GPIOF_OUT_INIT_HIGH |
> >> > GPIOF_OPEN_DRAIN? Hmm, I just wonder how to distinguish
> >> > GPIOF_OUT_INIT_LOW from unset. Hmm, maybe assume unset because _=
LOW is
> >> > wrong?
> >>
> >> Hmmm.... Hmmmm... Hmmm... :)
> >> Two things:
> >> - Why should we default it to GPIOF_OPEN_DRAIN? Open drain would m=
ean,
> >> gpio_set_value() will not write one for it, but would put it in in=
put mode.
> >> I don't think that would be correct, as an generic case.
> > As the i2c-bus is open drain and multi-master capable it's wrong to=
 pull
> > it to 1 because this can result in a short circuit. Even in a
> > single-master scenario (where you can pull SCL in both directions) =
you
> > must not drive SDA to 1.
>=20
> Hmm... Hopefully i understood it well this time.
> - We actually don't need these flags then.
>=20
> Always pass:
> - scl_flags: GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH
> - sda_flags: GPIOF_IN
>=20
> Why would anybody else require something different for any SoC?
IMHO this should work, yes. (At least conceptually, not necessary for
all implementations.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
