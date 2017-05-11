From: Scott Wood <oss@buserror.net>
Subject: Re: i2c-mpc: Correct I2C reset procedure
Date: Wed, 10 May 2017 20:42:20 -0500
Message-ID: <1494466940.29095.3.camel@buserror.net>
References: <20170509120351.28273-1-joakim.tjernlund@infinera.com>
         <20170509205447.ww7436pixxl2sxt6@home.buserror.net>
         <1494399764.5113.30.camel@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from host.buserror.net ([209.198.135.123]:58104 "EHLO
        host.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdEKBm2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 10 May 2017 21:42:28 -0400
In-Reply-To: <1494399764.5113.30.camel@infinera.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Wed, 2017-05-10 at 07:02 +0000, Joakim Tjernlund wrote:
> On Tue, 2017-05-09 at 15:54 -0500, Scott Wood wrote:
> > On Tue, May 09, 2017 at 02:03:51PM +0200, Joakim Tjernlund wrote:
> > > Current I2C reset procedure is broken in two ways:
> > > 1) It only generate 1 START instead of 9 STARTs and STOP.
> > > 2) It leaves the bus Busy so every I2C xfer after the first
> > >    fixup calls the reset routine again, for every xfer there after.
> > > 
> > > This fixes both errors. Add an iobarrier_rw() when writing the
> > > I2C control register as well to make sure the register reaches the
> > > controller in time.
> > > 
> > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> > > ---
> > > 
> > >  Not sure where to sent this as there is no maintainer so adding
> > >  Scott Wood as well.
> > > 
> > >  drivers/i2c/busses/i2c-mpc.c | 24 ++++++++++++++++--------
> > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> > > index 8393140..09b826d 100644
> > > --- a/drivers/i2c/busses/i2c-mpc.c
> > > +++ b/drivers/i2c/busses/i2c-mpc.c
> > > @@ -86,6 +86,7 @@ struct mpc_i2c_data {
> > >  static inline void writeccr(struct mpc_i2c *i2c, u32 x)
> > >  {
> > >  	writeb(x, i2c->base + MPC_I2C_CR);
> > > +	iobarrier_rw();
> > >  }
> > 
> > Why are the barriers in the I/O accessors insufficient?
> 
> You mean writeb()?  As far as I can see the writeb/readb only uses volatile
> and that
> can be a bit weak for ppc, even on guarded, uncached memory mappings.
> I wanted to make sure multiple writeb did hit the controller correctly.

It's not just a volatile.  There's a sync before each access, and a twi/isync
after loads.  writeb() maps to __do_writeb() which maps to out_8() which is
implemented with DEF_MMIO_OUT_D.

-Scott
