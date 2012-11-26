From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 21:20:03 +0100
Message-ID: <20121126202003.GA3384@pengutronix.de>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
 <50B20670.5070509@pcserviceselectronics.co.uk>
 <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
 <50B35642.7030104@pcserviceselectronics.co.uk>
 <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpomNTKFJQCrZdC81OiQpjdtK85XXWfvvB=XYb85e49OBZA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello Viresh,

On Mon, Nov 26, 2012 at 06:21:25PM +0530, Viresh Kumar wrote:
> On 26 November 2012 17:15, Paul Carpenter
> <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
> > Unless you know why the bus is stuck, how can you reset reminder th=
is
> > method ONLY works if SCL is high and SDA probably was low and the s=
lave
> > device is what is stuck in wrong state. NOTE SCL and SDA high can b=
e
> > considered as BUS IDLE or having passed SDA =3D 1 waiting next cloc=
k edge
> > or state transition without other state information.
> >
> > From i2c protocol Rev. 03 section 3.1.16 titled "Bus clear" first b=
it -
> >
> >   "In the unlikely event where the clock (SCL) is stuck LOW, the
> >    preferential procedure is to reset the bus using the HW reset si=
gnal
> >    if your I2C devices have HW reset inputs. If the I2C devices do =
not
> >    have HW reset inputs, cycle power to the devices to activate the
> >    mandatory internal Power-On Reset (POR) circuit."
> >
> > So if you do not check that SCL is NOT stuck Low the rest will just=
 do
> > nothing, it wont clear the bus and the fault will not be reported.
> > The open drain nature of the bus means that you may attempt to togg=
le it
> > but if SCL is stuck low nothing will happen on the bus.
> >
> > Attempting to configure an SCL drive as any form of high driving ou=
tput
> > will create a situation that when the SCL is driven high a high dri=
ver
> > on the GPIO will be driving into a stuck low situation potentially
> > creating a short between a power source and a power sink, that in m=
ost
> > cases will damage or shorten life of one or both ends.
> >
> > In over 10 years of using I2C in various forms the only times I hav=
e
> > seen bus stuck or device in wrong state
> >
> > 1/ Some code changed a bus switch when Bus was NOT idle
> >         i.e mid transaction
not sure what you mean here. Does it include a (SoC i.e. i2c master)
reset while the bus is not idle? That's the problem I was faced with
some time ago.

> > 2/ Bit-banged I2C software was wrong incomplete transaction
> > 3/ Short on bus
> > 4/ Faulty device
> > 5/ Faulty design so 1 and 0 thresholds were compromised
I can add:
6/ device does clock stretching which is not detected/supported by the
   bus master
7/ clock frequency too high for a device

In reply to a more detailed problem report that should be addressed by
this series on spear-devel I asked a few questions to rule out 6/ and
7/. I cannot find it in an public accessible archive though. It's about
a sta529 codec. When switching sample rates the codec then holds down
SDA. After an additional clock pulse the device and bus are OK again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
