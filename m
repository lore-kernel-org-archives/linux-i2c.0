From: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] i2c/pnx: Really fix start/stop issue
Date: Tue, 20 Apr 2010 19:23:46 +0200
Message-ID: <083DF309106F364B939360100EC290F80979C819E1@eu1rdcrdc1wx030.exi.nxp.com>
References: <1271586070-12266-1-git-send-email-w.sang@pengutronix.de>
 <20100418130457.0341efce@hyperion.delvare>
 <20100418114021.GA21364@pengutronix.de>
 <20100420001536.GL32401@fluff.org.uk> <20100420071629.GI19957@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100420071629.GI19957-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Subject: Re: [PATCH] i2c/pnx: Really fix start/stop issue
>=20
> On Tue, Apr 20, 2010 at 01:15:36AM +0100, Ben Dooks wrote:
> > On Sun, Apr 18, 2010 at 01:40:21PM +0200, Wolfram Sang wrote:
> > > On Sun, Apr 18, 2010 at 01:04:57PM +0200, Jean Delvare wrote:
> > > > Hi Wolfram,
> > > >
> > > > On Sun, 18 Apr 2010 12:21:10 +0200, Wolfram Sang wrote:
> > > > > The issue was truly solved by the second patch in this thread=
:
> > > > >
> > > > > http://thread.gmane.org/gmane.linux.drivers.i2c/5436
> > > > >
> > > > > Accidently, the first one was picked up. So, this patch adds =
the
> > > > > remaining diff (and an additional newline).
> > > > >
> > > > > Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > > Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > > > Cc: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
> > > > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> > > > > Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > > > > ---
> > > > >
> > > > > Jean, can you pick this up, so it will be correct in 2.6.34?
> > > >
> > > > i2c-pnx is for an embedded platform -> this is for Ben.
> > >
> > > Would you mind picking it up if he has not done till, let's say,
> > > rc6? He did not comment to my pointers so far. Other stuff is
> > > pending, too (though not urgent). Maybe he is away/busy?
> >
> > Could you check my for-linus/i2c branch on git.fluff.org to see if
> > that fixes the problem for you, and if there is anything else that
> > needs fixing.
>=20
> Looks good to me. Kevin, are you fine, too?

I just pulled and checked them. They work fine.
I'll resubmit the clock optimizations in a future patch.
Thanks!

>=20
> All other patches I carry can wait for the next merge window. Just, I=
'd
> really like to finally get rid of them then :) The branch is here:
>=20
> The following changes since commit 01bf0b64579ead8a82e7cfc32ae44bc667=
e7ad0f:
>   Linus Torvalds (1):
>         Linux 2.6.34-rc5
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
> Is a branch okay or do you prefer a series?
>=20
> Regards,
>=20
>    Wolfram
>=20
> --
> Pengutronix e.K.                           | Wolfram Sang            =
    |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |
