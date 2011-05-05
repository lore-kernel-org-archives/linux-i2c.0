From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-gpio performance issue w/MPC8xx @ 50 MHz
Date: Thu, 5 May 2011 21:48:35 +0200
Message-ID: <20110505214835.6fadb3f0@endymion.delvare>
References: <BANLkTikaS8yOTcO+OChvutB0syWdVBsh8g@mail.gmail.com>
	<20110501102603.7993da58@endymion.delvare>
	<BANLkTik_mBMHJt-MzcSQfdnAhseBM5KwFg@mail.gmail.com>
	<BANLkTi=+JxbLfvjrh8A_KQ58CeJJB0wKjw@mail.gmail.com>
	<BANLkTikaifXi9+G-3=QAihqxZqPAuBSuGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTikaifXi9+G-3=QAihqxZqPAuBSuGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?B?SOV2YXJk?= Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi H=E5vard,

On Thu, 5 May 2011 11:54:44 -0700, H=E5vard Skinnemoen wrote:
> On Mon, May 2, 2011 at 1:48 AM, Eran Duchan <pavius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> Hmm. i2c-gpio overrides the udelay specified by the platform? That
> >> shouldn't happen. It does try to come up with some reasonable defa=
ults
> >> if the platform doesn't specify any though.
> >
> > Yep, only this scheme explicitly disallows a udelay of 0. It's not =
too
> > problematic, I guess, seeing how close 1 is to 0 in terms of timing=
=2E
>=20
> Hmm, yeah. Not sure how to allow 0 while still being backwards compat=
ible.

You don't want to allow 0 anyway, as this is wrong. With 0 you can't
make _any_ timing guarantee, it might go faster than desired depending
on the CPU. You don't want I2C to break when the vendor implements a
faster CPU in their next product.

As said before, if the GPIO layer is too slow for such systems, then
either it has to be improved (if possible at all, maybe be enabling
some caching of the values which keep being recomputed for frequently
used GPIO pins?) or these platforms have to do without it.

> >> I haven't investigated this in depth, but I'd say it's probably ca=
used
> >> by the extra indirection added by gpiolib, assuming the gpio frame=
work
> >> on your platform uses it. I guess it's one of the downsides of gre=
atly
> >> reducing the amount of platform-specific code.
> >
> > Indeed. Tracing the platform gpio code does not show it to be overl=
y
> > complex at all; simply a matter of mapping the gpio # to a chip (wh=
ich
> > is mapped to a port bank), mapping to the specific bit in the bank,
> > some locking, setting and unlocking. The only problem is that while
> > this is straightforward, it does introduce unwanted latency. I did =
not
> > get to profiling the code, though.
>=20
> Well, not really complex as such, but when you want to do all that
> every 10 microseconds, it adds up really quickly.
>=20
> >>> While I don't expect all users of i2c-algo-bit to be converted to=
 such
> >>> a platform driver, it may indeed be useful in some cases, so I ha=
ve no
> >>> objection.
> >
> > Nor would I expect this to be the case. i2c-algo-bit obviously work=
s
> > well on most platforms when paired to the gpio facility. It just is=
n't
> > tight enough for environments low on processing power.
> >
> >> You can probably create a minimal i2c-platform driver which just
> >> passes the platform-specific callbacks to i2c-algo-bit. I think it
> >> should be a new bus driver though...
> >
> > This is where I kind of lost you. I implemented a bus driver specif=
ic
> > to my platform (compiled in in drivers/i2c/busses) and then
> > instantiated it in my platform module. I thought about adding a
> > generic bus driver that would receive callbacks from the platform
> > module (for example, drivers/i2c/busses/i2c-gpio-direct, or somethi=
ng)
> > and simply pass these on to i2c-bit-algo. This would allow other
> > platforms to do the same without having to create a platform specif=
ic
> > bus driver each time like I did. I can submit something generic lik=
e
> > this, if you think this it conforms to the model.
>=20
> That sounds exactly like what I had in mind, except for the naming. I=
f
> the driver doesn't use the generic GPIO facilities at all, I don't
> think it should have "gpio" in its name. What the driver does,

I agree.

> however, is taking platform-specific callbacks and passes them to
> i2c-algo-bit. So I think "i2c-platform" would be a better name.

Err, no, i2c-platform is no better than i2c-gpio-direct, I'm afraid.
There are many "platform" i2c bus drivers already, so that would be
confusing. I'd vote for "i2c-bitbang", or "i2c-bit-platform" to match
"i2c-pca-platform" we already have for i2c-algo-pca.

> I don't really know whether it conforms to the "model" (or which mode=
l
> we're talking about for that matter), but I can't see any problems
> with it. Platforms for which i2c-gpio doesn't perform well enough can
> get better performance at the cost of a little bit more
> platform-specific code if they switch to i2c-platform.

Agreed. As long as care is taken that other drivers won't poke at the
same registers, obviously.

--=20
Jean Delvare
