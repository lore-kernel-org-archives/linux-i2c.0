From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V3] m68knommu: driver for Freescale Coldfire I2C
 controller.
Date: Tue, 12 Jun 2012 09:42:29 +0200
Message-ID: <20120612074229.GA9230@pengutronix.de>
References: <201205161910.36693.sfking@fdwdc.com>
 <20120611174634.GI3887@pengutronix.de>
 <201206111229.51887.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201206111229.51887.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, uClinux development list <uclinux-dev-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> While they are physically similar, just as the mpc and the imx are physic=
ally=20
> similar, the imx driver has a lot of imx'isms, device tree and OF=20
> dependencies that aren't supported by the m68k/nommu.

Devicetree/OF should be optional. If not, we need to fix it anyhow. So,
the question is how much imx'ism there is really in there.

> I would expect the changes needed tantamount to having separate
> drivers.

If that is really true, then two seperate drivers might be the right
choice. Yet, I'd like to base this decision on facts and not
expectations (which might be wrong). I understand that you worked on the
driver for some time now, from a maintanence point of view having only
one driver is preferable, though. That works at least for fec.c.

>  Plus I have no way of testing what impact any changes I made had on
>  the imx functionality, so I expect I would end up mostly just
>  annoying the imx developers.

I am an imx-developer and I won't be annoyed :)

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/W8uUACgkQD27XaX1/VRv6VwCffnhj8Yv7a5HCZ7pZGjaJIdOi
xgsAoItMHO7Fi/x+40BGjlGQYnF58xzl
=aDow
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
