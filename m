From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
Date: Sun, 18 Apr 2010 15:22:51 +0200
Message-ID: <20100418132251.GB21364@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de> <1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de> <20100228155502.GB16745@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100228155502.GB16745-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Sorry to bump this old thread, it dropped off my todo-list :(

On Sun, Feb 28, 2010 at 03:55:02PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 24, 2010 at 12:01:45PM +0100, Uwe Kleine-K=F6nig wrote:
> > From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > This talkative function is also called on timeouts. As timeouts can
> > happen on regular writes to EEPROMs (no error case), this creates false
> > positives.  Giving lots of details is interesting only for developers
> > anyhow, so just use the function if DEBUG is #defined.
>=20
> Are you sure this is safe?  If you time out the write before it completes,
> how do you know if the write was successful?
>=20
> I don't think this is "no error code" nor "false positive".  If the timeo=
ut
> is too short for your EEPROMs, then the timeout needs to be increased.

I am sure this is safe because we have retries. The eeprom driver first tri=
es
to write data without a delay, because EEPROMs often have buffers. Once the
buffers are full, the chip will not answer to the next write request which =
will
result in a timeout for this write request. This is expected, so it will be
retried after some delay. Something like -EBUSY. Only if another "outer"
timeout passed after some retries, then we have a problem and this should be
user visible. But the timeout for the write request is nothing exceptional =
and
the user doesn't need to be informed about it, especially not in this detai=
l.
This is what the patch is addressing.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvLB6sACgkQD27XaX1/VRtCBQCeJOtzw7shQQA99eMRDv7/fguO
/mUAoJxN7wyGOxM0DiwNvOzPl8aUGs/i
=qrgG
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
