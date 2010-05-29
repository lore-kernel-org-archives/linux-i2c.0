From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PMBus support in Linux
Date: Sat, 29 May 2010 04:34:01 +0200
Message-ID: <20100529023401.GB12507@pengutronix.de>
References: <1275063391.2631.137.camel@groeck-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1275063391.2631.137.camel@groeck-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


CCing lm-sensors and David...

On Fri, May 28, 2010 at 09:16:31AM -0700, Guenter Roeck wrote:

> does anyone know if there is an effort to add infrastructure for PMBus
> support (or support for specific PMBus devices) to Linux ?

I found this:

http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022969.html

Hmm, sitting ontop of SMBus, it makes perfect sense to use i2c-dev (David k=
nows
what he is doing, of course ;)). But having no repo and all, it is hard to
maintain this utility. Is there any chance to pick it up in the kernel-tree?
tools/i2c/ or such? Hmm, it's GPL v3...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwAfRkACgkQD27XaX1/VRvOJgCeLTSXrDNxFkMa74IMcdLIkSfr
7EUAoJJeMr2BM0Wlnjg6SmCyy20rm965
=wur8
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
