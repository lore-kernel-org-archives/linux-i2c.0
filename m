From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Tue, 24 Apr 2012 14:08:48 +0200
Message-ID: <CACRpkdboocdbmx-cFR_ApYX=B4e=CDMzWn+oZMWrn7vxTpnvvw@mail.gmail.com>
References: <cover.1330669025.git.viresh.kumar@st.com>
	<3d25a5406975dbab9d21bfe406e5f779480da17f.1330669025.git.viresh.kumar@st.com>
	<20120423125630.GG19192@pengutronix.de>
	<CAOh2x==SfyVVvoK83c4fBO5HVkLtJhd3CDcDfULXTNcZzfZ4Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOh2x==SfyVVvoK83c4fBO5HVkLtJhd3CDcDfULXTNcZzfZ4Dg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 23, 2012 at 3:55 PM, viresh kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
> On Mon, Apr 23, 2012 at 6:26 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>=
 wrote:

>>> + * @set_scl: controller specific scl configuration routine. Only r=
equired if
>>> + * =A0 is_gpio_recovery =3D=3D false
>>> + * @get_sda: controller specific sda read routine. Only required i=
f
>>> + * =A0 is_gpio_recovery =3D=3D false and skip_sda_polling =3D=3D f=
alse.
>>> + * @get_gpio: called before recover_bus() to get padmux configured=
 for scl line.
>>> + * =A0 as gpio. Only required if is_gpio_recovery =3D=3D true.
>>> + * @put_gpio: called after recover_bus() to get padmux configured =
for scl line
>>> + * =A0 as scl. Only required if is_gpio_recovery =3D=3D true.
>>
>> Can't we use the pinmux/pinctrl subsystem here? Not knowing too much
>> about it, CCing Linus.
>
> Can be. But probably true only for architectures where pinctrl is
> defined. Linus?

We *could* do it by defining a standard state for the pinctrl handle
in <linux/pinctrl/pinctrl-state.h> (pending in linux-next) like:

#define PINCTRL_STATE_GPIO "gpio"

Or so, then have the core grab that using the struct device * of this
pin controller, returing it to PINCTRL_STATE_DEFAULT afterwards.

It seems a bit scary to do that in core code though, because we
don't know which state we should return to, should it really
be default state?

And what if we're using GPIO bit-banging, then we grab the pins
into some state they're already in.

So to me it seems better to do this at driver level using these
hooks so the driver is in full control of the pinctrl states.

Stephen, do you agree?

But:

Many platforms I've seen actually have the ability to mux their
I2C pins into GPIO and bitbang them, sometimes this seems
to be used to work around broken silicon for example. And
it seems what is done here is simply some instance of
bitbanging (am I right?).

I wonder if it would make sense to model this in the core,
so any I2C driver can specify that it also supports bit-banging
using GPIO pins A,B and then this can be used for anything,
not just for this recovery.

So the above hooks should be possible to use to switch the
entire driver over to bitbang mode.

Yours,
Linus Walleij
