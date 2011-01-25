From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 4/4] drivers/staging/lirc: Remove obsolete cleanup for
 clientdata
Date: Tue, 25 Jan 2011 21:57:54 +0100
Message-ID: <20110125205754.GB22589@pengutronix.de>
References: <1295865880-27672-1-git-send-email-w.sang@pengutronix.de>
 <1295865880-27672-4-git-send-email-w.sang@pengutronix.de>
 <1295914142.2420.29.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1295914142.2420.29.camel@localhost>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 24, 2011 at 07:09:02PM -0500, Andy Walls wrote:
> On Mon, 2011-01-24 at 11:44 +0100, Wolfram Sang wrote:
> > A few new i2c-drivers came into the kernel which clear the clientdata-p=
ointer
> > on exit or error. This is obsolete meanwhile, the core will do it. Simp=
lify the
> > kfree() calls after that, the pointers don't need to be checked.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
> > Cc: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Andy Walls <awalls-Xoej9cPu4Z+RGvkDC/A1pg@public.gmane.org>
>=20
> Nak.
>=20
> In a module where I plan to do more cleanup and add reference counting
> to struct IR, IR_tx, and IR_rx objects, I'd like the explicit "NULL"s in
> pointer checks to stay in for now.

Okay, I will ignore this driver until it comes out of staging.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk0/OVIACgkQD27XaX1/VRthgACgnah2/2nSjroHHkLiFZ7bWoq1
NHwAoKCl7Ssi8OraQFvUPerNR30byc3j
=ZOSa
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
