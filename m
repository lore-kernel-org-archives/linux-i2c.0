From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 13/13] drivers/media/tuners/e4000.c: use macros for
 i2c_msg initialization
Date: Tue, 18 Dec 2012 14:13:24 +0100
Message-ID: <20121218131324.GE2612@pengutronix.de>
References: <1349645970.15802.12.camel@joe-AO722>
 <alpine.DEB.2.02.1210072342460.2745@localhost6.localdomain6>
 <1349646718.15802.16.camel@joe-AO722>
 <20121007225639.364a41b4@infradead.org>
 <50723661.6040107@gmail.com>
 <alpine.DEB.2.02.1210081028340.1989@hadrien>
 <20121009203238.63d2275f@infradead.org>
 <alpine.DEB.2.02.1210110836030.2010@hadrien>
 <20121218124640.5b1e7176@endymion.delvare>
 <alpine.DEB.2.02.1212181335360.1993@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1212181335360.1993@hadrien>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, walter harms <wharms-fPG8STNUNVg@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antti Palosaari <crope-X3B1VOXEql0@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shubhrajyoti-l0cyMroinI0@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Please note that I resigned from my position of i2c subsystem
> > maintainer, so I will not handle this. If you think this is important,
> > you'll have to resubmit and Wolfram will decide what he wants to do
> > about it.
>=20
> OK, I had the impression that the conclusion was that the danger was
> greater than the benefit.  If there is interest in it, since I think it
> does make the code more readable, I can pick it up again.

TBH, there are other things coming which have higher priority, so from
my side, currently, there is not much interest right now.

Thanks nonetheless,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlDQa/QACgkQD27XaX1/VRvheACgwsK3xYgkw/pySALcMFsbOkQf
TL8An1ItUMbT2JBMRw3OkXN+pnpb073g
=H4y4
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
