From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 10:04:47 +0100
Message-ID: <20130125090447.GG8668@pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <20130124072445.GA8364@nekote.pengutronix.de>
 <20130124105438.GB8668@pengutronix.de>
 <20130125085337.GC5684@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130125085337.GC5684-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hey Wolfram,

On Fri, Jan 25, 2013 at 09:53:37AM +0100, Wolfram Sang wrote:
> > > Assuming that recover_bus is not called on BUS_BUSY but on TIMEOU=
Ts,,
> > > this should work?
> > How do you differentiate these two? You're machine boots and sees s=
da
> > being low. How long should it wait for action on sda or scl until i=
t can
> > diagnose a timeout?
>=20
> Timeout value. I consider I2C a static bus with no hotplugging. So,
> either we have seen a START bit and know we are inside a transaction =
or
> SDA is low because a slave is in an unknown state.
This is probably true in at least 9 out of 10 cases today. I wonder if
that will stay as is. Up to you to ignore it. (I promise not to be
offended.)

> > > This scl check should not depend on skip_sda_polling, or?
> > Well right. But note this might also just be a slave doing clock
> > streching.
>=20
> Which is a good reason to exit recovery.
Not necessarily. If a slave hangs and would need say 5 additional clock=
s
it still can stretch the 2nd clock cycle.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
