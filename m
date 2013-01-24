From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V9 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 12:43:03 +0100
Message-ID: <20130124114303.GE8668@pengutronix.de>
References: <fe4fba74b7bac4fe56e26b2a947280390182c66c.1359023434.git.viresh.kumar@linaro.org>
 <20130124110643.GC8668@pengutronix.de>
 <CAKohpo=OwnPcfQxxk22nOWZ1c=Ke4s_i=GN3A6_bo6RAEa6P8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpo=OwnPcfQxxk22nOWZ1c=Ke4s_i=GN3A6_bo6RAEa6P8w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thu, Jan 24, 2013 at 04:47:53PM +0530, Viresh Kumar wrote:
> On 24 January 2013 16:36, Uwe Kleine-K=F6nig
> <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Thu, Jan 24, 2013 at 04:06:37PM +0530, Viresh Kumar wrote:
> >> Most number of versions for any patchset i submitted :)
> > So let's see if you do a v10 ... :-)
>=20
> Haha..
>=20
> >> +static int i2c_generic_recovery(struct i2c_adapter *adap)
> >> +{
> >> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_inf=
o;
> >> +     int i =3D 0, val =3D 1, ret =3D 0;
> >> +
> >> +     if (bri->prepare_recovery)
> >> +             bri->prepare_recovery(bri);
> >> +
> > Do we want to break out here if sda is high?
>=20
> Good point actually. It may happen we are asked to recover already wo=
rking
> system :)
>=20
> >> +     /*
> >> +      * By this time SCL is high, as we need to give 9 falling-ri=
sing edges
> >> +      */
> >> +     while (i++ < RECOVERY_CLK_CNT * 2) {
> >> +             /* SCL shouldn't be low here */
> >> +             if (val && !bri->get_scl(adap)) {
> >> +                     dev_err(&adap->dev, "SCL is stuck Low exit r=
ecovery\n");
> >> +                     ret =3D -EBUSY;
> >> +                     goto unprepare;
> >> +             }
> >> +
> >> +             val =3D !val;
> >> +             bri->set_scl(adap, val);
> >> +             ndelay(clk_delay);
> >> +
> >> +             /* break if sda got high, check only when scl line i=
s high */
> > Above you wrote "SCL", here "scl". I suggest to use one of them
> > consistently and use the same capitalisation for sda.
>=20
> Sure.
>=20
> >> +             if (bri->get_sda && val)
> >> +                     if (bri->get_sda(adap))
> >> +                             break;
> > Maybe better:
> >                 /* break if sda got high */
> >                 if (bri->get_sda && bri->get_sda(adap)) {
> >                         /* don't leave with scl low */
> >                         if (!val)
> >                                 bri->set_scl(adap, 1);
> >                         break;
> >                 }
>=20
> So, the whole loop is for 9 pulses at max and it runs 18 times. Twice=
 per
> clock. With my code, i only check for sda after supplying full clock =
pulse,
> and you are asking me to check that in middle of clock. Isn't it wron=
g?
Actually in the data phase of a transfer sda only changes when scl is
low. (Otherwise it's a stop condition.) So it should make sense to chec=
k
after pulling scl low, doesn't it? Hmm, it trades one ndelay for
(possibly several) get_sda. hmm, *shrug*.

> >> +int i2c_generic_scl_recovery(struct i2c_adapter *adap)
> >> +{
> >> +     adap->bus_recovery_info->set_scl(adap, 1);
> > Why this?
>=20
> This came out of some earlier discussion we had. We should start
> with high and then do low-high 9 times.
Ah, I missed the first val =3D !val and so thought you start with setti=
ng
to 1 anyhow. So yes, I agree. Maybe document this assumption in a
comment?

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
