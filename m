From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
Date: Mon, 3 Sep 2012 11:44:48 +0200
Message-ID: <20120903094448.GB11780@pengutronix.de>
References: <1345734087-21803-1-git-send-email-lee.jones@linaro.org>
 <1345734087-21803-3-git-send-email-lee.jones@linaro.org>
 <20120831112258.GA2624@pengutronix.de>
 <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2012 at 11:22:28AM +0200, Linus Walleij wrote:
> On Fri, Aug 31, 2012 at 2:23 PM, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>=20
> (...)
> >  static int nmk_i2c_probe(struct amba_device *adev, const struct amba_i=
d *id)
> >  {
> >         int ret =3D 0;
> >         struct nmk_i2c_controller *pdata =3D adev->dev.platform_data;
> > +       struct device_node *np =3D adev->dev.of_node;
> >         struct nmk_i2c_dev      *dev;
> >         struct i2c_adapter *adap;
> >
> > +       if (np) {
> > +               if (!pdata) {
>=20
> So, if no pdata is provided, we go on to allocate some ...
>=20
> > +                       pdata =3D devm_kzalloc(&adev->dev, sizeof(*pdat=
a), GFP_KERNEL);
> > +                       if (!pdata) {
> > +                               ret =3D -ENOMEM;
> > +                               goto err_no_mem;
> > +                       }
> > +               }
> > +               /* Provide the default configuration as a base. */
> > +               pdata =3D &u8500_i2c;
>=20
> Then you just override that pointer with a pointer to the local config.
>=20
> > +               nmk_i2c_of_probe(np, pdata);
> > +       }
> > +
> >         if (!pdata)
> >                 /* No i2c configuration found, using the default. */
> >                 pdata =3D &u8500_i2c;
>=20
> This in it's entirety does not look sound. I *think* this is what you
> want to do,
> replace all of the above codde (including the last if (!pdata) clause) wi=
th:
>=20
> if (!pdata) {
>     /* If no platform data passed in, use the default configuration as
> a base. */
>     pdata =3D &u8500_i2c;
>     if (np)
>         /* Further, if we have a DT node, override the default with this =
*/
>         nmk_i2c_of_probe(np, pdata);
> }
>=20
> This makes any passed pdata take precedence, else default pdata
> complemented with DT info. Which is what we want.

No. of_probe modifies pdata which in this case the default config which
might already be in use. So, you will get problems if you have two
instances with different configuration. So, we need to allocate memory
but copy the content of the default data. The patch above just copies
the pointer which is bogus.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBEfBAACgkQD27XaX1/VRsjUwCgyqoDMZ/wjLR/YU1jiWrkBEHf
LG8AoIZdoi8nDhFcW9ElnLoph5QT5b1e
=RxHU
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
