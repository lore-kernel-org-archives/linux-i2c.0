From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
Date: Sun, 18 Apr 2010 16:05:48 +0200
Message-ID: <20100418140548.GC21364@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de> <20100228155502.GB16745@n2100.arm.linux.org.uk> <20100418132251.GB21364@pengutronix.de> <20100418134502.GA15452@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100418134502.GA15452-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > I am sure this is safe because we have retries. The eeprom driver first=
 tries
> > to write data without a delay, because EEPROMs often have buffers. Once=
 the
> > buffers are full, the chip will not answer to the next write request wh=
ich will
> > result in a timeout for this write request. This is expected, so it wil=
l be
> > retried after some delay. Something like -EBUSY. Only if another "outer"
> > timeout passed after some retries, then we have a problem and this shou=
ld be
> > user visible. But the timeout for the write request is nothing exceptio=
nal and
> > the user doesn't need to be informed about it, especially not in this d=
etail.
> > This is what the patch is addressing.
>=20
> And what if it's not an EEPROM that you're talking to?

That's up to the corresponding driver. The driver is still notified via the
return value how many i2c-messages could be transmitted. If this is not equ=
al
to what the driver intended, then it can decide to retry or notify the user.
And that is the apropriate level. Doing all this printout at the bus-driver
level is only interesting for developers. Users are frightened by the "time=
out"
in their logs although everything might be as expected. A bus driver can't
know.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvLEbwACgkQD27XaX1/VRs2ZQCfeklIZBCpAHjDejGUybnI4h2X
Rn4AniKOIGYIkgTsfbR0HSEssP9F8PQh
=dxFb
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
