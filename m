From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V10 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 21 Mar 2013 15:45:29 +0530
Message-ID: <CAKohpo=NdN64bJ_uD4cZ_aJppz+zschYFMyoP=-2c+NfuOqFfg@mail.gmail.com>
References: <59a73d182bf1ce330becf32ad780f3501a57aed0.1359106966.git.viresh.kumar@linaro.org>
	<20130125111322.GA2649@pengutronix.de>
	<CAKohpok2arxhsAt3xOxRCZZjvLMTed1EYX3ZRUSQ3733wx2mMw@mail.gmail.com>
	<CAKohpokNVPOvAc=Gbxn4ZquPnG4huukDmwhOsqaV51p0aRo8xw@mail.gmail.com>
	<CAKohpokCqe7LHFMn0t7EivTQ7US9Fp=07nowGP2H2ujeDKbHXg@mail.gmail.com>
	<CAKohpondDBBjTQYgV9XOFMYp_aKO+SdeRR1gjxe1ovTLuOm2Wg@mail.gmail.com>
	<20130321093648.GA19297@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130321093648.GA19297-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rajeev kumar <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 21 March 2013 15:06, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> I applied V11 of the core changes with minor modifications.

Wow!! Thanks.

> I do wonder
> about the hook in the designware driver. You apply the recovery on
> transfer timeout. I think this should go into the timeout of
> i2c_dw_wait_bus_not_busy()?

Hmm.. Rajeev/Shiraz were the guys who tested this code earlier and i am
sure we were failing in this piece of code, which i just fixed and so
i2c_dw_wait_bus_not_busy() didn't fail for us.

Below is a conversation that we had with Uwe some time back on the exac=
t
problem we faced and it was a bit different from the traditional proble=
m.

So, maybe we need bus recovery at both places: i2c_dw_wait_bus_not_busy=
()
(for the traditional hang) and during transfer (for our case).

--
viresh

> On 7 November 2012 18:53, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > Hello Viresh,
> >
> > in our irc conversation you told that the SDA signal being stuck lo=
w
> > happened with an sta529 audio codec. I quickly scanned over its
> > datasheet (Doc ID 13095 Rev 3; March 2012).
> >
> > Some questions that come to my mind regarding your issue:
> >  - What is the situation the stall occurs? How do you reproduce?

I2C data lines are permanently held low by the slave device
(sta529 codec in this case).

There is a fixed way in which we can always reproduce it. The
codec can support different sample rate. As soon as we switch from
one sample rate to another (and accordingly re-configure sta529),
this happens.

> >  - I didn't find a specification of the allowed i2c clock frequency=
=2E Do
> >    you have a different document that specifies this? (Or maybe I j=
ust
> >    missed it?!) I assume you're using the device in the right range=
?

sta529 can work in fast mode at 400 KHz without any issues.
