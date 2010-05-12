From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: bjdooks' i2c-next
Date: Wed, 12 May 2010 02:06:45 +0200
Message-ID: <20100512000645.GA13984@pengutronix.de>
References: <20100511232039.GA32733@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100511232039.GA32733-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 12, 2010 at 12:20:39AM +0100, Ben Dooks wrote:

> Here's the current contents of my i2c-next. All branches are
> on http://git.fluff.org/gitweb?p=3Dbjdooks/linux.git;a=3Dsummary
>=20
> Let me know if there is anything that has been missed.

Yes, my branch of old patches. Can also repost a patch series, whatever you
prefer:

The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc2a1cc9:
  Linus Torvalds (1):
        Linux 2.6.34-rc7

are available in the git repository at:

  git://git.pengutronix.de/git/wsa/linux-2.6.git for-i2c

Uwe Kleine-K=F6nig (2):
      i2c/pxa: remove unused macro
      MAINTAINERS: add i2c tree for embedded platforms

Wolfram Sang (5):
      i2c/pxa: only define 'blue_murder'-function if DEBUG is #defined
      i2c/mpc: drop NO_IRQ
      i2c/cpm: drop NO_IRQ
      i2c/ibm-iic: drop NO_IRQ
      i2c/highlander: remover superflous variable

 MAINTAINERS                         |    1 +
 drivers/i2c/busses/i2c-cpm.c        |    2 +-
 drivers/i2c/busses/i2c-highlander.c |    5 ++---
 drivers/i2c/busses/i2c-ibm_iic.c    |   14 +++++++-------
 drivers/i2c/busses/i2c-mpc.c        |    6 +++---
 drivers/i2c/busses/i2c-pxa.c        |   26 ++++++++++++++------------
 6 files changed, 28 insertions(+), 26 deletions(-)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvp8RUACgkQD27XaX1/VRsBvACfW374Rr4Rj5S1MgapQavYGdbG
+TcAnRLDOmFoR6pVyJFbcSGiy7KhZcof
=wx6p
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
