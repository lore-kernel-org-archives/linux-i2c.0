From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: i2c-mpc: Correct I2C reset procedure
Date: Thu, 11 May 2017 11:23:57 +0000
Message-ID: <1494501836.5113.60.camel@infinera.com>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
         <20170509205447.ww7436pixxl2sxt6@home.buserror.net>
         <1494399764.5113.30.camel@infinera.com>
         <1494466940.29095.3.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:35040
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755510AbdEKLYB (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 11 May 2017 07:24:01 -0400
In-Reply-To: <1494466940.29095.3.camel@buserror.net>
Content-Language: en-US
Content-ID: <7C65185F2EF32446AFBB3D153841D2F3@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "oss@buserror.net" <oss@buserror.net>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-05-10 at 20:42 -0500, Scott Wood wrote:
> On Wed, 2017-05-10 at 07:02 +0000, Joakim Tjernlund wrote:
> > On Tue, 2017-05-09 at 15:54 -0500, Scott Wood wrote:
> > > On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> > > > Current I2C reset procedure is broken in two ways:
> > > > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > > > 2) It leaves the bus Busy so every I2C xfer after the first
> > > > =A0=A0=A0fixup calls the reset routine again, for every xfer there =
after.
> > > >=20
> > > > This fixes both errors. Add an iobarrier_rw() when writing the
> > > > I2C control register as well to make sure the register reaches the
> > > > controller in time.
> > > >=20
> > > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > > ---
> > > >=20
> > > > =A0Not sure where to sent this as there is no maintainer so adding
> > > > =A0Scott Wood as well.
> > > >=20
> > > > =A0drivers/i2c/busses/i2c-mpc.c | 24 ++++++++++++++++--------
> > > > =A01 file changed, 16 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-=
mpc.c
> > > > index 8393140..09b826d 100644
> > > > --- a/drivers/i2c/busses/i2c-mpc.c
> > > > +++ b/drivers/i2c/busses/i2c-mpc.c
> > > > @@ -86,6 +86,7 @@ struct mpc_i2c_data {
> > > > =A0static inline void writeccr(struct mpc_i2c *i2c, u32 x)
> > > > =A0{
> > > > =A0	writeb(x, i2c->base + MPC_I2C_CR);
> > > > +	iobarrier_rw();
> > > > =A0}
> > >=20
> > > Why are the barriers in the I/O accessors insufficient?
> >=20
> > You mean writeb()?=A0=A0As far as I can see the writeb/readb only uses =
volatile
> > and that
> > can be a bit weak for ppc, even on guarded, uncached memory mappings.
> > I wanted to make sure multiple writeb did hit the controller correctly.
>=20
> It's not just a volatile.  There's a sync before each access, and a twi/i=
sync
> after loads.  writeb() maps to __do_writeb() which maps to out_8() which =
is
> implemented with DEF_MMIO_OUT_D.

ehh, right you are. That was some very complicated include/#ifdef trickery =
to go through.
I will send an update patch with the iobarrier_rw() removed.

 Jocke=
