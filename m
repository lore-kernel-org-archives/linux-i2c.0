From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PULL REQUEST] i2c for 3.8
Date: Wed, 23 Jan 2013 14:23:01 +0100
Message-ID: <20130123132301.GA18005@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

here are a few, typical driver fixes for the I2C subsystem. Please pull.

Thanks,

   Wolfram


The following changes since commit 7d1f9aeff1ee4a20b1aeb377dd0f579fe9647619:

  Linux 3.8-rc4 (2013-01-17 19:25:45 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-current

for you to fetch changes up to 9dd3162deb67e9d2dc08af8bedea61c41fae85a8:

  i2c-designware: add missing MODULE_LICENSE (2013-01-22 16:43:34 +0100)

----------------------------------------------------------------
Aaro Koskinen (2):
      i2c: omap: errata i462: fix incorrect ack for arbitration lost interr=
upt
      i2c: omap: fix draining irq handling

Barry Song (1):
      i2c: sirf: register i2c_client from dt child-nodes in probe entry

Fabio Estevam (1):
      i2c: mxs: Fix type of error code

Laurent Navet (1):
      i2c: muxes: fix wrong use of sizeof(ptr)

Marek Vasut (1):
      i2c: mxs: Fix misuse init_completion

Mika Westerberg (1):
      i2c-designware: add missing MODULE_LICENSE

 drivers/i2c/busses/i2c-designware-core.c |    4 ++++
 drivers/i2c/busses/i2c-mxs.c             |    6 ++++--
 drivers/i2c/busses/i2c-omap.c            |    6 +++---
 drivers/i2c/busses/i2c-sirf.c            |    4 ++++
 drivers/i2c/muxes/i2c-mux-pinctrl.c      |    2 +-
 5 files changed, 16 insertions(+), 6 deletions(-)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlD/5DUACgkQD27XaX1/VRt5qwCfUisVfXBxKaIby+oc3dSMP+cQ
NRUAnA03Hta7H07pBdt+x/ZFYMDK3WpB
=z2vQ
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
