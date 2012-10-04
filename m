From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 Resend 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 4 Oct 2012 15:28:19 +0530
Message-ID: <CAKohpom3j930DuMLKscCsC3h9D_KvTeaJ4xwJub-=JNdju8+Fw@mail.gmail.com>
References: <viresh.kumar@linaro.org>
	<d5eaf5302de6a2ba01d1c11abeeed8850be879be.1348831273.git.viresh.kumar@linaro.org>
	<20121004080051.GG598@pengutronix.de>
	<CAKohpok-4PUz=1OMdJ7-TyWPi+f46k8NgFNUx0Z0La5aN-r5Hw@mail.gmail.com>
	<20121004092017.GH598@pengutronix.de>
	<CAKohpon-q9VdP4crEr0KXpDi+AhcOM708PZkJwZzuUH_4p56+Q@mail.gmail.com>
	<20121004094743.GJ598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121004094743.GJ598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 4 October 2012 15:17, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Oct 04, 2012 at 03:02:26PM +0530, Viresh Kumar wrote:
>> On 4 October 2012 14:50, Uwe Kleine-K=F6nig
>> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>>
>> >> So, we actually need to do "Low-High" 9 times instead of "High-Lo=
w".
>> >> So, initializing val to 0 should fix it?
>> > I don't think this is enough. If you cut off the last half clock o=
f the
>> > first sequence above doing 9 times low-high isn't enough. So you h=
ave to
>> > do high + 9x low-high to assert 9 full cycles.
>>
>> I am not cutting the last half clock. val is the variable which keep=
s
>> track of value to be
>> set on the line. I am asking to start from zero.
> I meant the sequence that created the stall, not the one intending to
> clear it. If you remove the last rising edge from that the SCL line i=
s
> initially low.

But then, wouldn't only 8.5 cycles are enough? As with 8.5 cycles we wi=
ll
achieve 9 low-high cycles?

I can't find you on IRC (#linaro on freenode). Want to finish this up q=
uickly,
so that i can send a fixup patch ASAP and get your reviewed-by :)

--
viresh

--
viresh
