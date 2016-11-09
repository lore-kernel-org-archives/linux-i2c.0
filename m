From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Date: Wed, 9 Nov 2016 15:43:31 +0100
Message-ID: <20161109144331.GF2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161108071337.GA4601@hardcore>
 <10136944.jCslgNClvG@np-p-burton>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2nam02on0070.outbound.protection.outlook.com ([104.47.38.70]:38179
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932212AbcKIOns (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 9 Nov 2016 09:43:48 -0500
Content-Disposition: inline
In-Reply-To: <10136944.jCslgNClvG@np-p-burton>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org

On Wed, Nov 09, 2016 at 02:09:38PM +0000, Paul Burton wrote:
> On Tuesday, 8 November 2016 08:13:37 GMT Jan Glauber wrote:
> > On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > > retries") attempted to replace potentially infinite loops with ones
> > > which will time out using readq_poll_timeout, but in doing so it
> > > inverted the condition for exiting this loop.
> > > 
> > > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> > > 
> > > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > > Cc: Jan Glauber <jglauber@cavium.com>
> > > Cc: David Daney <david.daney@cavium.com>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: linux-i2c@vger.kernel.org
> > > 
> > > ---
> > 
> > Acked-by: Jan Glauber <jglauber@cavium.com>
> > 
> > Thanks for spotting this. I think this should go into stable too for
> > 4.8, so adding Cc: stable@vger.kernel.org.
> 
> Hi Jan,
> 
> ...but the bad patch was only merged for v4.9-rc1?

true, I've misread it.

> Thanks,
>     Paul
> 
> > 
> > >  drivers/i2c/busses/i2c-octeon-core.h | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-octeon-core.h
> > > b/drivers/i2c/busses/i2c-octeon-core.h index 1db7c83..d980406 100644
> > > --- a/drivers/i2c/busses/i2c-octeon-core.h
> > > +++ b/drivers/i2c/busses/i2c-octeon-core.h
> > > @@ -146,8 +146,9 @@ static inline void octeon_i2c_reg_write(struct
> > > octeon_i2c *i2c, u64 eop_reg, u8> 
> > >  	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + 
> SW_TWSI(i2c));
> > > 
> > > -	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & 
> SW_TWSI_V,
> > > -			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
> > > +	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > > +			   !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > > +			   i2c->adap.timeout);
> > > 
> > >  }
> > >  
> > >  #define octeon_i2c_ctl_write(i2c, val)					\
> > > 
> > > @@ -173,7 +174,7 @@ static inline int octeon_i2c_reg_read(struct
> > > octeon_i2c *i2c, u64 eop_reg,> 
> > >  	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base +
> > >  	SW_TWSI(i2c));
> > >  	
> > >  	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > > 
> > > -				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
> > > +				 !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > > 
> > >  				 i2c->adap.timeout);
> > >  	
> > >  	if (error)
> > >  	
> > >  		*error = ret;
> 
