From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: i2c-ocores: Add irq support for sparc
Date: Tue, 13 Nov 2012 17:31:12 +0100
Message-ID: <20121113163112.GA20739@pengutronix.de>
References: <1352739591-1317-1-git-send-email-andreas@gaisler.com>
 <1352739591-1317-2-git-send-email-andreas@gaisler.com>
 <20121113111055.GF23119@pengutronix.de>
 <50A248AD.9000705@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50A248AD.9000705-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> >> @@ -275,8 +276,8 @@ static int __devinit ocores_i2c_probe(struct platf=
orm_device *pdev)
> >>  	if (!res)
> >>  		return -ENODEV;
> >> =20
> >> -	res2 =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >> -	if (!res2)
> >> +	irq =3D platform_get_irq(pdev, 0);
> >> +	if (irq < 0)
> >>  		return -ENODEV;
> >=20
> > Why not pass the error code you got?
>=20
> I believe that should actually be a check for 'irq <=3D 0' as it returns
> NO_IRQ on error.

I wish it did, but (from 3.7-rc5):

  79 /**
  80  * platform_get_irq - get an IRQ for a device
  81  * @dev: platform device
  82  * @num: IRQ number index
  83  */
  84 int platform_get_irq(struct platform_device *dev, unsigned int num)
  85 {
  86 #ifdef CONFIG_SPARC
  87         /* sparc does not have irqs represented as IORESOURCE_IRQ reso=
urces */
  88         if (!dev || num >=3D dev->archdata.num_irqs)
  89                 return -ENXIO;
  90         return dev->archdata.irqs[num];
  91 #else
  92         struct resource *r =3D platform_get_resource(dev, IORESOURCE_I=
RQ, num);
  93=20
  94         return r ? r->start : -ENXIO;
  95 #endif
  96 }
  97 EXPORT_SYMBOL_GPL(platform_get_irq);

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCiddAACgkQD27XaX1/VRsBggCgyKZB2dNjQfv4RV3m51I/6IKj
+WIAoKDeClzav47jB9V2xYMwfLWZh+om
=Ar2x
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
