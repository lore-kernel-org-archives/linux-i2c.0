From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Current status of my for-3.3/for-3.4 branches
Date: Fri, 24 Feb 2012 22:36:03 +0100
Message-ID: <20120224213603.GA9745@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all (and Ben),

here is how my current branches look like:

=3D=3D=3D for-3.3

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git i2c-embedded/for-3.3

Wolfram Sang (1):
      i2c: mxs: only flag completion when queue is completely done

 drivers/i2c/busses/i2c-mxs.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

=3D=3D=3D for-3.4

The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git i2c-embedded/for-3.4

Ganesan Ramalingam (1):
      i2c: Support for Netlogic XLR/XLS I2C controller.

Jayachandran C (1):
      i2c: Move I2C_EG20T option to the right place.

Pawel Moll (1):
      i2c: versatile: Add Device Tree support

Tang Yuantian (1):
      i2c: mpc: Add support for SMBUS_READ_BLOCK_DATA

Wolfram Sang (1):
      misc: at24: describe platform_data with kernel_doc

 drivers/i2c/busses/Kconfig         |   34 +++--
 drivers/i2c/busses/Makefile        |    3 +-
 drivers/i2c/busses/i2c-mpc.c       |   63 +++++++--
 drivers/i2c/busses/i2c-versatile.c |   10 ++
 drivers/i2c/busses/i2c-xlr.c       |  278 ++++++++++++++++++++++++++++++++=
++++
 include/linux/i2c/at24.h           |   35 ++++-
 6 files changed, 390 insertions(+), 33 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

=3D=3D=3D

Ben, can you pull these into your trees? If you don't have time right now I=
 can
also send them directly.

There have been patches from Oskar and Viresh lately which look good to me,=
 but
I'll give people some more time to comment on them. The driver by Barry has
outstanding comments. I decided to leave the Samsung related patches to Ben=
, he
knows that platform way better. Any other patches pending I missed so far?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk9IAsMACgkQD27XaX1/VRu9LQCdF4ZXUwToShTe3GPNq32R+cKq
JLgAn3M2gR41gF9ALxYHzahZc13P8Y0L
=D2BH
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
