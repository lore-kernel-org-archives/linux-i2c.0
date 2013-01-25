From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Fri, 25 Jan 2013 10:23:35 +0100
Message-ID: <20130125092335.GF5684@pengutronix.de>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
 <20130124072445.GA8364@nekote.pengutronix.de>
 <20130124105438.GB8668@pengutronix.de>
 <20130125085337.GC5684@pengutronix.de>
 <20130125090447.GG8668@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z+pzSjdB7cqptWpS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130125090447.GG8668-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--z+pzSjdB7cqptWpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Timeout value. I consider I2C a static bus with no hotplugging. So,
> > either we have seen a START bit and know we are inside a transaction or
> > SDA is low because a slave is in an unknown state.
> This is probably true in at least 9 out of 10 cases today. I wonder if
> that will stay as is. Up to you to ignore it. (I promise not to be
> offended.)

If that will be the case somewhen, bus recovery might be a bad idea in
general. Then again, such a setup is the one needing it most, probably
;) But hotplugging I2C is desperatly asking for problems.

> > > > This scl check should not depend on skip_sda_polling, or?
> > > Well right. But note this might also just be a slave doing clock
> > > streching.
> >=20
> > Which is a good reason to exit recovery.
> Not necessarily. If a slave hangs and would need say 5 additional clocks
> it still can stretch the 2nd clock cycle.

While unlikely on the bit-level, still true. Need to think about it.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--z+pzSjdB7cqptWpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlECTxcACgkQD27XaX1/VRt5RACgg2QhCaQRUJcDoEFYtyrAZXOm
2P0AniNvSsgs1knCmWyzswcN/dj14Kw1
=6V2V
-----END PGP SIGNATURE-----

--z+pzSjdB7cqptWpS--
