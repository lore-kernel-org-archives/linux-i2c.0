From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery
 infrastructure
Date: Thu, 4 Oct 2012 11:20:17 +0200
Message-ID: <20121004092017.GH598@pengutronix.de>
References: <viresh.kumar@linaro.org>
 <d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
 <20121004080051.GG598@pengutronix.de>
 <CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

> >> +     for (i =3D 0; i < bri->clock_cnt * 2; i++, val =3D !val) {
> >> +             set_scl_value(adap, val);
> >> +             ndelay(delay);
> >> +
> >> +             /* break if sda got high, check only when scl line i=
s high */
> >> +             if (!bri->skip_sda_polling && val)
> >> +                     if (unlikely(get_sda_value(adap)))
> >> +                             break;
> >> +     }
> > With clock_cnt usually being 9 (and skipping sda polling) assume a
> > device pulls down SDA because it was just addressed but the last cl=
ock
> > pulse to release SDA didn't occur:
> >
> >         SDAout =AF\_/=AF=AF=AF\___/=AF=AF=AF\___________________/=AF=
=AF=AF=AF=AF=AF
> >         SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF=
\_/=AF=AF=AF=AF=AF
> >                 S   1   2   3   4   5   6   7   8   9
> >
> > This adresses an eeprom with address 0x50. When SCL is released for=
 the
> > 9th clock the eeprom pulls down SDA to ack being addressed. After t=
hat
> > the eeprom expects the master to write a byte.
> >
> > Now you do write 0xff:
> >
> >          i      0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
> >         SDAin  ___/=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=
=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF=AF\____=
__
> >         SCL    =AF=AF\_/=AF\_/=AF\_/=AF\_/=AF\_/=AF=AF\__/=AF=AF\__=
/=AF=AF\__/=AF=AF\______/
> >                 9   1   2   3   4    5     6     7     8
> >
> > (assuming the SCL line goes up some time later to its idle state).
> > That is you leave the bus in exactly the same state as before: The =
9th
> > clock isn't complete and the eeprom asserts SDA low to ack the byte=
 just
> > written. So the bus is still stalled. The problem is BTW the exact =
same
> > one I introduced first in my bus clear routine (for barebox though)=
=2E
> > Even though you count to 2*9 you only do 8 real clock pulses becaus=
e you
> > have a half cycle at both the start and the end.
>=20
> Fantastic explanation!!
Your luck that I just had the same problem ;-)

> So, we actually need to do "Low-High" 9 times instead of "High-Low".
> So, initializing val to 0 should fix it?
I don't think this is enough. If you cut off the last half clock of the
first sequence above doing 9 times low-high isn't enough. So you have t=
o
do high + 9x low-high to assert 9 full cycles.

> >> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 impl=
ies
> >> + *   GPIOF_OUT_INIT_LOW.
> >> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 impl=
ies
> >> + *   GPIOF_OUT_INIT_LOW.
>=20
> > Didn't you want to change this to GPIOF_OUT_INIT_HIGH |
> > GPIOF_OPEN_DRAIN? Hmm, I just wonder how to distinguish
> > GPIOF_OUT_INIT_LOW from unset. Hmm, maybe assume unset because _LOW=
 is
> > wrong?
>=20
> Hmmm.... Hmmmm... Hmmm... :)
> Two things:
> - Why should we default it to GPIOF_OPEN_DRAIN? Open drain would mean=
,
> gpio_set_value() will not write one for it, but would put it in input=
 mode.
> I don't think that would be correct, as an generic case.
As the i2c-bus is open drain and multi-master capable it's wrong to pul=
l
it to 1 because this can result in a short circuit. Even in a
single-master scenario (where you can pull SCL in both directions) you
must not drive SDA to 1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
