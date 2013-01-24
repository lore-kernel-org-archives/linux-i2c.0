From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 11:54:38 +0100
Message-ID: <20130124105438.GB8668@pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <20130124072445.GA8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130124072445.GA8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 24, 2013 at 08:24:45AM +0100, Wolfram Sang wrote:
> Hi Viresh,
>=20
> I think we are getting close.
>=20
> On Mon, Dec 03, 2012 at 08:24:04AM +0530, Viresh Kumar wrote:
> > Add i2c bus recovery infrastructure to i2c adapters as specified in=
 the i2c
> > protocol Rev. 03 section 3.1.16 titled "Bus clear".
> >=20
> > http://www.nxp.com/documents/user_manual/UM10204.pdf
> >=20
> > Sometimes during operation i2c bus hangs and we need to give dummy =
clocks to
> > slave device to start the transfer again. Now we may have capabilit=
y in the bus
> > controller to generate these clocks or platform may have gpio pins =
which can be
> > toggled to generate dummy clocks. This patch supports both.
> >=20
> > This patch also adds in generic bus recovery routines gpio or scl l=
ine based
> > which can be used by bus controller. In addition controller driver =
may provide
> > its own version of the bus recovery routine.
> >=20
> > This doesn't support multi-master recovery for now.
>=20
> Assuming that recover_bus is not called on BUS_BUSY but on TIMEOUTs,,
> this should work?
How do you differentiate these two? You're machine boots and sees sda
being low. How long should it wait for action on sda or scl until it ca=
n
diagnose a timeout?

If the current code is operated on a multi-master bus and the bus is
busy various things can happen. At least without sda polling the curren=
t
transaction could be modified and completed. Not sure if that can happe=
n
with sda polling.

Some more comments below.

> > +static int i2c_generic_recovery(struct i2c_adapter *adap)
> > +{
> > +	struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> > +	int i, val =3D 0;
> > +
> > +	if (bri->prepare_recovery)
> > +		bri->prepare_recovery(bri);
>=20
> prepare_recovery and unprepare should be in i2c_generic_scl_recovery =
and
> i2c_generic_gpio_recovery since they are probably needed to turn SDA/=
SCL
> into GPIOs and back. We want that before the gpio_get/put routines.
>=20
> > +
> > +	/* SCL shouldn't be low here */
> > +	if (!bri->get_scl(adap)) {
> > +		dev_err(&adap->dev, "SCL is stuck Low, exiting recovery.\n");
>=20
> returning -EBUSY?
>=20
> > +		goto unprepare;
> > +	}
> > +
> > +	/*
> > +	 * By this time SCL is high, as we need to give 9 falling-rising =
edges
> > +	 */
> > +	for (i =3D 0; i < RECOVERY_CLK_CNT * 2; i++, val =3D !val) {
> > +		bri->set_scl(adap, val);
> > +		ndelay(clk_delay);
> > +
> > +		/* break if sda got high, check only when scl line is high */
> > +		if (!bri->skip_sda_polling && val)
>=20
> * if (val && bri->get_sda)
>=20
> > +			/* Check SCL again to see fault condition */
> > +			if (!bri->get_scl(adap)) {
> > +				dev_err(&adap->dev, "SCL is stuck Low during recovery, exiting=
 recovery.\n");
>=20
> returning -EBUSY?
> This scl check should not depend on skip_sda_polling, or?
Well right. But note this might also just be a slave doing clock
streching.

> > +				goto unprepare;
> > +			}
> > +
> > +			if (bri->get_sda(adap))
> > +				break;
Indention suggests that you want this in the body of the if (val &&
bri->get_sda). Unfortunately the C-Compiler won't notice without braces=
=2E

> Checking SDA should be done before setting SCL? That would
>=20
> a) let us escape early if SDA got HIGH magically somehow until we ent=
er
>    the for loop for the first time
> b) breaking out of the for loop after the last pulse is moot
You mean:

	val =3D 0;

	for (i =3D 0; i < RECOVERY_CLK_CNT * 2; i++, val =3D !val) {
		if (!val && !bri->get_scl(adap))
				scl stuck low (or wait a bit to sort out clock streching)
		if (bri->get_sda && bri->get_sda(adap))
			break;

		bri->set_scl(adap, val);
		ndelay(clk_delay);
	}

Looks ok I think. This would also get rid of the seperate scl check
before the loop.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
