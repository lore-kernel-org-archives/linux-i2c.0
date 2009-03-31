From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/2] powerpc: i2c-mpc: preserve I2C clocking
Date: Tue, 31 Mar 2009 15:56:29 +0200
Message-ID: <20090331135629.GC3044@pengutronix.de>
References: <20090331125028.066613801@denx.de> <20090331125451.600446749@denx.de> <20090331133953.GB3044@pengutronix.de> <49D21EF1.9050200@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49D21EF1.9050200-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> -=09
> >> -	mpc_i2c_setclock(i2c);
> >> +
> >> +	if (set_clock)
> >> +		mpc_i2c_setclock(i2c);
> >=20
> > Can't we drop 'set_clock' with something like this here?
> >=20
> > +	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
> > +
> > +		if (of_get_property(op->node, "dfsrr", NULL))
> > +			i2c->flags |=3D FSL_I2C_DEV_SEPARATE_DFSRR;
> > +
> > +		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
> > +		    of_device_is_compatible(op->node, "mpc5200-i2c"))
> > +			i2c->flags |=3D FSL_I2C_DEV_CLOCK_5200;
> > +
> > +		mpc_i2c_setclock(i2c);
> > +	}
>=20
> No, because the I2C registers are not yet mapped.

Sorry, I used misleading words :) With 'here' I meant 'at this
position', i.e. insert my above block where mpc_i2c_setclock was used
anyway.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknSIQ0ACgkQD27XaX1/VRtgGgCaA8NXZCaycG9m10echwEbflPH
0h4An1f+rODAfKMA7sQBtcMauawjHmc4
=mWLk
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
