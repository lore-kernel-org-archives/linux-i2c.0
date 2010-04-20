From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Tue, 20 Apr 2010 09:16:29 +0200
Message-ID: <20100420071629.GI19957@pengutronix.de>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de> <20100418130457.0341efce@hyperion.delvare> <20100418114021.GA21364@pengutronix.de> <20100420001536.GL32401@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100420001536.GL32401-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 20, 2010 at 01:15:36AM +0100, Ben Dooks wrote:
> On Sun, Apr 18, 2010 at 01:40:21PM +0200, Wolfram Sang wrote:
> > On Sun, Apr 18, 2010 at 01:04:57PM +0200, Jean Delvare wrote:
> > > Hi Wolfram,
> > >=20
> > > On Sun, 18 Apr 2010 12:21:10 +0200, Wolfram Sang wrote:
> > > > The issue was truly solved by the second patch in this thread:
> > > >=20
> > > > http://thread.gmane.org/gmane.linux.drivers.i2c/5436
> > > >=20
> > > > Accidently, the first one was picked up. So, this patch adds the
> > > > remaining diff (and an additional newline).
> > > >=20
> > > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
> > > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > > ---
> > > >=20
> > > > Jean, can you pick this up, so it will be correct in 2.6.34?
> > >=20
> > > i2c-pnx is for an embedded platform -> this is for Ben.
> >=20
> > Would you mind picking it up if he has not done till, let's say, rc6? H=
e did
> > not comment to my pointers so far. Other stuff is pending, too (though =
not
> > urgent). Maybe he is away/busy?
>=20
> Could you check my for-linus/i2c branch on git.fluff.org to see if
> that fixes the problem for you, and if there is anything else that
> needs fixing.

Looks good to me. Kevin, are you fine, too?

All other patches I carry can wait for the next merge window. Just, I'd rea=
lly
like to finally get rid of them then :) The branch is here:

The following changes since commit 01bf0b64579ead8a82e7cfc32ae44bc667e7ad0f:
  Linus Torvalds (1):
        Linux 2.6.34-rc5

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

Is a branch okay or do you prefer a series?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvNVMwACgkQD27XaX1/VRutiwCgiRZ79rNjcVqhuhLIsmc+xUKU
dssAnj5TeOclvI0rKxJ+SlQtfqLkPR3f
=+9D3
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
