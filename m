From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V3] m68knommu: driver for Freescale Coldfire I2C
 controller.
Date: Mon, 11 Jun 2012 19:46:34 +0200
Message-ID: <20120611174634.GI3887@pengutronix.de>
References: <201205161910.36693.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205161910.36693.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2012 at 07:10:35PM -0700, Steven King wrote:
> D'oh!  I really dropped the ball on this, but I figure better late than n=
ever ;-).

Thank you for this! Yet, I just noticed that the register layout is the
same as in i2c-imx.c. Not surprisingly, since both platforms share the
roots. Have you checked if you can use the imx-driver as well?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/WLvoACgkQD27XaX1/VRu2kgCdGg31cLv2u50qFskVDo62I5R8
5AwAn3NcNSqT6wQRFe5ZM45roJwy1DwG
=TuUP
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
