From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: i2c-mpc: Correct I2C reset procedure
Date: Wed, 10 May 2017 07:02:47 +0000
Message-ID: <1494399764.5113.30.camel@infinera.com>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
         <20170509205447.ww7436pixxl2sxt6@home.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:9696
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751592AbdEJHCw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 10 May 2017 03:02:52 -0400
In-Reply-To: <20170509205447.ww7436pixxl2sxt6@home.buserror.net>
Content-Language: en-US
Content-ID: <34B363A78DBE6D41B0078BD0E6740217@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "oss@buserror.net" <oss@buserror.net>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Tue, 2017-05-09 at 15:54 -0500, Scott Wood wrote:
> On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> > Current I2C reset procedure is broken in two ways:
> > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > 2) It leaves the bus Busy so every I2C xfer after the first
> >    fixup calls the reset routine again, for every xfer there after.
> >=20
> > This fixes both errors. Add an iobarrier_rw() when writing the
> > I2C control register as well to make sure the register reaches the
> > controller in time.
> >=20
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > ---
> >=20
> >  Not sure where to sent this as there is no maintainer so adding
> >  Scott Wood as well.
> >=20
> >  drivers/i2c/busses/i2c-mpc.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.=
c
> > index 8393140..09b826d 100644
> > --- a/drivers/i2c/busses/i2c-mpc.c
> > +++ b/drivers/i2c/busses/i2c-mpc.c
> > @@ -86,6 +86,7 @@ struct mpc_i2c_data {
> >  static inline void writeccr(struct mpc_i2c *i2c, u32 x)
> >  {
> >  	writeb(x, i2c->base + MPC_I2C_CR);
> > +	iobarrier_rw();
> >  }
>=20
> Why are the barriers in the I/O accessors insufficient?

You mean writeb()?  As far as I can see the writeb/readb only uses volatile=
 and that
can be a bit weak for ppc, even on guarded, uncached memory mappings.
I wanted to make sure multiple writeb did hit the controller correctly.

 Jocke =
