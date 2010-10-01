From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Please pull bjdooks' i2c-fixes
Date: Fri, 1 Oct 2010 10:09:51 +0200
Message-ID: <20101001080951.GA27870@pengutronix.de>
References: <E1P1SAZ-0001tp-ON@ben-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E1P1SAZ-0001tp-ON@ben-laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ben,

On Fri, Oct 01, 2010 at 12:04:07AM +0100, Ben Dooks wrote:
> The following changes since commit 4193d9163582b05e33aca3392e46649e5c3da8=
d1:
>   Linus Torvalds (1):
>         Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs
>=20
> are available in the git repository at:
>=20
>   git://git.fluff.org/bjdooks/linux.git for-linus/i2c/2636-rc5
>=20
> Bernhard Walle (1):
>       i2c-octeon: Return -ETIMEDOUT in octeon_i2c_wait() on timeout
>=20
> Jon Povey (1):
>       i2c-davinci: Fix race when setting up for TX
>=20
> MyungJoo Ham (1):
>       i2c-s3c2410: fix calculation of SDA line delay
>=20
>  drivers/i2c/busses/i2c-davinci.c |    6 +++---
>  drivers/i2c/busses/i2c-octeon.c  |    2 +-
>  drivers/i2c/busses/i2c-s3c2410.c |    4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

Is there a specific reason this patch was not picked up/commented (again)?

http://thread.gmane.org/gmane.linux.drivers.i2c/6222/focus=3D6265

It prevents getting a stalled bus, and we have done similar things for MPC =
and
other platforms.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkyll08ACgkQD27XaX1/VRuUBQCeOYP6KgsmmQirb6XyOKbi95pB
+ikAnR6FVZ4qlOWgNc0bwJGlW3g5c6xy
=c++d
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
