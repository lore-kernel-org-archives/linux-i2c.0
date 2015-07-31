From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: designware-pci: use IRQF_COND_SUSPEND flag
Date: Fri, 31 Jul 2015 12:07:23 +0200
Message-ID: <20150731100723.GA1522@katana>
References: <1436350536-99102-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1437997043.29746.86.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437997043.29746.86.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2015 at 02:37:23PM +0300, Andy Shevchenko wrote:
> On Wed, 2015-07-08 at 13:15 +0300, Andy Shevchenko wrote:
> > The mentioned flag fixes a warning on Intel Edison board since one of=
=20
> > the I2C
> > controller shares IRQ line with watchdog timer.
> >=20
>=20
> Wolfram, do you have any comments on this?

Adding Mika to cc, he is more experienced with these platforms.

>=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-designware-pcidrv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c=20
> > b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > index 6643d2d..df23e8c 100644
> > --- a/drivers/i2c/busses/i2c-designware-pcidrv.c
> > +++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
> > @@ -260,8 +260,8 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
> > =20
> >  	snprintf(adap->name, sizeof(adap->name), "i2c-designware
> > -pci");
> > =20
> > -	r =3D devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr,=20
> > IRQF_SHARED,
> > -			adap->name, dev);
> > +	r =3D devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr,
> > +			IRQF_SHARED | IRQF_COND_SUSPEND, adap->name,=20
> > dev);
> >  	if (r) {
> >  		dev_err(&pdev->dev, "failure requesting irq %i\n",=20
> > dev->irq);
> >  		return r;
>=20
> --=20
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Intel Finland Oy

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu0jbAAoJEBQN5MwUoCm2uF4P/2+pBT6BNjflq+03eRzdlf4z
jduDZD+9HB2tAV9/7sD8A/okUc9RLdnxjovr3QOjtO6HT7n0uINfEEpm/BCT9PbF
xauMKEfvyDnVYUA4qMuc/IjSYiH3+BPXeBweKrE6ezcwbDbTKO08o3Ej+uZNkgGj
qWqZLnAO9KQph8aPTQ9gsM0i3LzJ7H8Y9ypn3X/2ILXrjafUj6/+JPpalSNOrkyU
tD7RBp7LZPNY0gJMbTIfloLVXfUIogUOvyji5c034rdYEwRN8WigsJxibjrHLbdP
3kz+9XXLNn8Mp/KgNTNcMGOU3GW+7FUAIHohFz2q0OjrzpsC+HE76X+EMSsj1gxO
tLFQoXOI9xuNx0FTQli3Kpbt850j3n+cE9ZFARZNUkI/CTlAGgfGWc1RXQel5W7i
9/jd395ARGKoJpDS7c/hIF+SpZjSgm6e/7trvrLpoLLyZUZG+PSqV3TB4NkE1oQV
MD6j1IV6aIxV/9NCKBs+uTOqnLzhFEEsKmdFFEEzw88WnFyN5mCUoHCf9LWEZxU4
TNw8pGgL9spGvuJc0j7SMGtcyy9WMuFS6GxupTuOk87zdYK5wZnnHlO2U00cUk/8
JdCH8+e3qEiUwegTLsNHsUFr/yKlU5WEwPYDebj18VgBfgQAsWx9vHxfNXOEOlhZ
fBuPAe9ToBsp3jeSnTOr
=k/Uu
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
