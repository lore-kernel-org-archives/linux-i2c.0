From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch] MPC Adapter: read class attribute from device tree
Date: Tue, 21 Apr 2009 10:37:54 +0200
Message-ID: <20090421083754.GA3100@pengutronix.de>
References: <49ED6AD3.2060808@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49ED6AD3.2060808-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Delvare, Jean " <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> For MPC adapter there is no class assigned as it is done in other
> adapters.

Still, the trend is to use the class field less, not more often. Probing
causes more pain than gain. Most of us have been through that, try to
believe us.

> This way no new-style client will ever be instantiated.

Sorry, this seems wrong to me:

1) The client _instance_ does come from the dts, as Jean explained
before. Did you get the difference? You said yourself that you could see
the entries in sysfs. It seems just that it does not get connected to
the driver. This should be the place to fix the error.

2) When I showed you the output of modprobing the rtc-ds1307 driver, I
was using exactly this i2c-master driver (the board uses an MPC5200B).
Plus, I often use at24 as a module. Doesn't look like a problem in the
infrastructure to me.

> this patch class assignment is read from device tree.
> Necessary entry:
> class =3D <1>; /* I2C_CLASS_HWMON (iic.h) */

The device tree is OS independent. You are encoding something
linux-specific into it. This is regularly rejected. I am quite surprised
to see that there is such a thing in i2c-cpm. Lucky punch, I guess ;)
Should be removed IMHO.

Have you already posted the DTS snipplet for your I2C setup?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkntheIACgkQD27XaX1/VRseTwCfThl98tP0nY4y09j/UttV+5w7
WucAoKZhuRvSLVgC/zYXnMfn4TmRAINX
=qQiv
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
