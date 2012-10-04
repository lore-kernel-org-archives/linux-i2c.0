From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 4 Oct 2012 15:02:26 +0530
Message-ID: <CAKohpon-q9VdP4crEr0KXpDi+AhcOM708PZkJwZzuUH_4p56+Q@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
	<20121004080051.GG598@pengutronix.de>
	<CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw@mail.gmail.com>
	<20121004092017.GH598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121004092017.GH598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4 October 2012 14:50, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

>> So, we actually need to do "Low-High" 9 times instead of "High-Low".
>> So, initializing val to 0 should fix it?
> I don't think this is enough. If you cut off the last half clock of t=
he
> first sequence above doing 9 times low-high isn't enough. So you have=
 to
> do high + 9x low-high to assert 9 full cycles.

I am not cutting the last half clock. val is the variable which keeps
track of value to be
set on the line. I am asking to start from zero.

You mean, we should do a high first and then 9 low-high? But this line =
was high
initially.. what difference will it make by making it high again?

Sorry, i am not a I2C expert, so need some help :)

>> >> + * @scl_gpio_flags: flag for gpio_request_one of scl_gpio. 0 imp=
lies
>> >> + *   GPIOF_OUT_INIT_LOW.
>> >> + * @sda_gpio_flags: flag for gpio_request_one of sda_gpio. 0 imp=
lies
>> >> + *   GPIOF_OUT_INIT_LOW.
>>
>> > Didn't you want to change this to GPIOF_OUT_INIT_HIGH |
>> > GPIOF_OPEN_DRAIN? Hmm, I just wonder how to distinguish
>> > GPIOF_OUT_INIT_LOW from unset. Hmm, maybe assume unset because _LO=
W is
>> > wrong?
>>
>> Hmmm.... Hmmmm... Hmmm... :)
>> Two things:
>> - Why should we default it to GPIOF_OPEN_DRAIN? Open drain would mea=
n,
>> gpio_set_value() will not write one for it, but would put it in inpu=
t mode.
>> I don't think that would be correct, as an generic case.
> As the i2c-bus is open drain and multi-master capable it's wrong to p=
ull
> it to 1 because this can result in a short circuit. Even in a
> single-master scenario (where you can pull SCL in both directions) yo=
u
> must not drive SDA to 1.

Hmm... Hopefully i understood it well this time.
- We actually don't need these flags then.

Always pass:
- scl_flags: GPIOF_OPEN_DRAIN | GPIOF_OUT_INIT_HIGH
- sda_flags: GPIOF_IN

Why would anybody else require something different for any SoC?

--
viresh
