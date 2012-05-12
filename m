From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv9 00/10] I2C fixes
Date: Sat, 12 May 2012 20:10:50 +0200
Message-ID: <20120512181050.GB28973@pengutronix.de>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com
List-Id: linux-i2c@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2012 at 08:02:05PM +0530, Shubhrajyoti D wrote:
>=20
> The patch series does the following
>=20
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - In case of i2c remove register access was done without any
>  get_sync fix the same.
> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> - Prevents the XDUF flag to be set if the underflow condition is not met.
> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>  use the unique id instead as the section number in the recent errata
>  docs has changed.
>=20
> v9:
> Fix the comments from Wolfram Sang

Patch 2 has my comment not addressed, so I stopped reviewing. It is
probably more helpful (and easier for me, too) if you do a changelog per
patch (and not of the whole series), then you can immediately see if
that specific changelog matches the current patch. 'git send-email
--annotate' might be helpful here.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+up6oACgkQD27XaX1/VRttpQCaApsb/1a6jj9hgUwDGpnAryQm
xGIAn1ZkCtLV9i9q5GC7meIKIcj2h4s7
=OI09
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
