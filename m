From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V9 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 19:39:43 +0530
Message-ID: <CAKohpo=+Uh4AuR-SYueGyTjKbZjwkCavmfeq6sjd2c4T5mYN6A@mail.gmail.com>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
	<20130124110643.GC8668@pengutronix.de>
	<CAKohpo=OwnPcfQxxk22nOWZ1c=Ke4s_i=GN3A6_bo6RAEa6P8w@mail.gmail.com>
	<20130124114303.GE8668@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124114303.GE8668-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 24 January 2013 17:13, Uwe Kleine-K=F6nig
<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Thu, Jan 24, 2013 at 04:47:53PM +0530, Viresh Kumar wrote:
>> So, the whole loop is for 9 pulses at max and it runs 18 times. Twic=
e per
>> clock. With my code, i only check for sda after supplying full clock=
 pulse,
>> and you are asking me to check that in middle of clock. Isn't it wro=
ng?
> Actually in the data phase of a transfer sda only changes when scl is
> low. (Otherwise it's a stop condition.) So it should make sense to ch=
eck
> after pulling scl low, doesn't it? Hmm, it trades one ndelay for
> (possibly several) get_sda. hmm, *shrug*.

In any case, we have to make scl high again. So, why not check it at
that stage only?

>> >> +int i2c_generic_scl_recovery(struct i2c_adapter *adap)
>> >> +{
>> >> +     adap->bus_recovery_info->set_scl(adap, 1);
>> > Why this?
>>
>> This came out of some earlier discussion we had. We should start
>> with high and then do low-high 9 times.
> Ah, I missed the first val =3D !val and so thought you start with set=
ting
> to 1 anyhow. So yes, I agree. Maybe document this assumption in a
> comment?

Some sort of comment is present in the routine which toggles the line,
which says "by this time scl must be high and we should apply 9 pulses
now"
