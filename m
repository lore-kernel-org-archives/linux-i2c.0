From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V6 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 30 Nov 2012 15:11:29 +0100
Message-ID: <20121130141129.GG23231@pengutronix.de>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
 <20121124205931.GB3210@pengutronix.de>
 <CAKohpokLD60N087_ae8-JY-4b4Opn+OrTErt0MwFsTgnSwFb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m972NQjnE83KvVa/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKohpokLD60N087_ae8-JY-4b4Opn+OrTErt0MwFsTgnSwFb0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--m972NQjnE83KvVa/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2012 at 09:34:46AM +0530, Viresh Kumar wrote:
> Hi Wolfram,
>=20
> Thanks for sharing your opinion.
>=20
> On 25 November 2012 02:29, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> > On Thu, Oct 04, 2012 at 04:34:53PM +0530, Viresh Kumar wrote:
>=20
> >> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>=20
> >> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
> >> +{
> >> +     struct i2c_bus_recovery_info *bri =3D adap->bus_recovery_info;
> >> +     struct device *dev =3D &adap->dev;
> >> +     int ret =3D 0;
> >> +
> >> +     if (bri->get_gpio) {
> >> +             ret =3D bri->get_gpio(bri->scl_gpio);
> >> +             if (ret) {
> >> +                     dev_warn(dev, "scl get_gpio: %d\n", bri->scl_gpi=
o);
> >
> > This warning is probably not very helpful to a user.
>=20
> This is what i thought about it: This is a platform specific routine and
> most probably it will fail the first time this code is ever hit and so a
> warning would be very helpful for them.
>=20
> But, now i think platforms should have these prints in their get_gpio
> implementations. And we can make it have return type void.

The warning could be made helpful if properly rephrased. Actually, I
think returning an err is OK here, but if there is a warning it should
be a proper human readable sentence.

> >> +             if (unlikely(ret ||
> >
> > Since the unlikely() are not in hot-paths, you probably better skip
> > them.
>=20
> It will be removed as get_gpio() would have return type void.

Keep in mind that it was not the only one. I think V7 had still one
left.

> >> + * @skip_sda_polling: if true, bus recovery will not poll sda line to=
 check if
> >> + *   it became high or not. Only required if recover_bus =3D=3D NULL.
> >
> > Does a user really need to set this?
>=20
> This was done for platforms and i2c controllers which don't have configur=
ation
> to control scl line. So i still feel we need it.

It might be needed internally, still not sure if a user needs to set it.
If so, there should be more documentation when she wants to use this.

> >> + * @clock_rate_khz: clock rate of dummy clock in khz. Required for bo=
th gpio and
> >> + *   scl type recovery.
> >
> > Does a user really need this? We could probably use something close to
> > 100kHz always?
>=20
> Not sure. Doesn't it depend on the current clk rate of controller ?
> If not then yes it can be 100 KHz

It should be OK to drive the bus at x kHz and recover from it at y kHz
(as long as y < 100).

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--m972NQjnE83KvVa/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlC4vpEACgkQD27XaX1/VRv85gCeKJ5g2ttQ0Dp6CGicJg9zctTp
TtgAnRdAmlp6cNNr4Stp7852nHR/Vg2H
=wbpD
-----END PGP SIGNATURE-----

--m972NQjnE83KvVa/--
