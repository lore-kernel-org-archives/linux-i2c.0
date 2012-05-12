From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/4] MXS: I2C improvements
Date: Sat, 12 May 2012 13:36:30 +0200
Message-ID: <20120512113630.GE20673@pengutronix.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201205092033.46812.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 08:33:46PM +0200, Marek Vasut wrote:
> > This patchset implements support for adjustment of I2C bus speed via
> > platform data. Further, it implements support for DMA transfers into the
> > mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning included.
> >=20
> > Marek Vasut (4):
> >   MXS: Allow passing i2c bus speed via platform data
> >   MXS: Set I2C timing registers for mxs-i2c
> >   MXS: Implement DMA support into mxs-i2c
> >   MXS: Fix GCC4.7 complaint in mxs-i2c
>=20
> Bump?

Regarding I2C, I think we will have DT support for it already in 3.5.
So, I am with Shawn here to not introduce new features with new
platform_data when there is a more recent alternative. So, drop 1/4 and
refactor 2/4 according to DT (you only need to get and parse the
"clock-frequency" property).

3/4 is the most interesting patch of this series, since it is a major
bugfix. Due to holidays, I won't be able to test it in the next 10 days,
but I am very eager to get it into 3.5. Since it is a bugfix, we could
probably get it in after the merge window, but I'll try to make the
merge window nontheless. If somebody donates Tested or Acked or Reviewed
tags, that would also help.

I already NACKed 4/4, so I wonder why you resent it.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+uSz4ACgkQD27XaX1/VRunjwCeP7oyDDGYPZ4mE+HXi+0VXXbO
SEUAnjEHloAxJr2nuJgftVGS2uRMDQjD
=uPIX
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
