From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PULL REQUEST] i2c-embedded for 3.4
Date: Thu, 3 May 2012 14:32:20 +0200
Message-ID: <20120503123220.GA4803@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here are some typical i2c driver bugfixes for 3.4. Missed clock
handling, improper timeout fixes, hardware wrokarounds... All patches have
been in linux-next for a few days, too.

Please pull.

Thanks,

   Wolfram

The following changes since commit 66f75a5d028beaf67c931435fdc3e7823125730c:

  Linux 3.4-rc4 (2012-04-21 14:47:52 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-current

for you to fetch changes up to 1e4f0b82577e59f23484c99056c96465e202fdd5:

  i2c: mxs: disable QUEUE when sending is done (2012-04-27 16:13:29 +0200)

----------------------------------------------------------------
Alok Chauhan (1):
      i2c: tegra: Add delay before resetting the controller after NACK

Roland Stigge (1):
      i2c: pnx: Disable clk in suspend

Tomoya MORINAGA (2):
      i2c-eg20t: change timeout value 50msec to 1000msec
      i2c-eg20t: Modify MODULE_AUTHOR's email address

Wolfram Sang (2):
      i2c: mxs: handle spurious interrupt
      i2c: mxs: disable QUEUE when sending is done

 drivers/i2c/busses/i2c-eg20t.c |    4 ++--
 drivers/i2c/busses/i2c-mxs.c   |    8 ++++----
 drivers/i2c/busses/i2c-pnx.c   |    3 +--
 drivers/i2c/busses/i2c-tegra.c |    8 ++++++++
 4 files changed, 15 insertions(+), 8 deletions(-)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+ietQACgkQD27XaX1/VRvo8wCeIpjSy7I6bwbfOSJYWQW8O7+6
BiAAn0YY8WnBV/VxbgnvaEZceFlOKSFu
=2VX2
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
