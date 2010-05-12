From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: bjdooks' i2c-next
Date: Wed, 12 May 2010 03:41:17 +0100
Message-ID: <20100512024117.GN2589@trinity.fluff.org>
References: <20100511232039.GA32733@fluff.org.uk> <20100512000645.GA13984@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100512000645.GA13984-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 12, 2010 at 02:06:45AM +0200, Wolfram Sang wrote:
> On Wed, May 12, 2010 at 12:20:39AM +0100, Ben Dooks wrote:
>=20
> > Here's the current contents of my i2c-next. All branches are
> > on http://git.fluff.org/gitweb?p=3Dbjdooks/linux.git;a=3Dsummary
> >=20
> > Let me know if there is anything that has been missed.
>=20
> Yes, my branch of old patches. Can also repost a patch series, whatev=
er you
> prefer:

Will pull later, in future, prefer i2c-<drivername> in the headers. I'l=
l
fix up as necessary once pulled.
=20
> The following changes since commit b57f95a38233a2e73b679bea4a5453a1cc=
2a1cc9:
>   Linus Torvalds (1):
>         Linux 2.6.34-rc7
>=20
> are available in the git repository at:
>=20
>   git://git.pengutronix.de/git/wsa/linux-2.6.git for-i2c
>=20
> Uwe Kleine-K=F6nig (2):
>       i2c/pxa: remove unused macro
>       MAINTAINERS: add i2c tree for embedded platforms
>=20
> Wolfram Sang (5):
>       i2c/pxa: only define 'blue_murder'-function if DEBUG is #define=
d
>       i2c/mpc: drop NO_IRQ
>       i2c/cpm: drop NO_IRQ
>       i2c/ibm-iic: drop NO_IRQ
>       i2c/highlander: remover superflous variable
>=20
>  MAINTAINERS                         |    1 +
>  drivers/i2c/busses/i2c-cpm.c        |    2 +-
>  drivers/i2c/busses/i2c-highlander.c |    5 ++---
>  drivers/i2c/busses/i2c-ibm_iic.c    |   14 +++++++-------
>  drivers/i2c/busses/i2c-mpc.c        |    6 +++---
>  drivers/i2c/busses/i2c-pxa.c        |   26 ++++++++++++++-----------=
-
>  6 files changed, 28 insertions(+), 26 deletions(-)
>=20
> --=20
> Pengutronix e.K.                           | Wolfram Sang            =
    |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |



--=20
--=20
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
