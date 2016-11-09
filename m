From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 1/2] i2c: octeon: Fix register access
Date: Wed, 9 Nov 2016 14:09:38 +0000
Message-ID: <10136944.jCslgNClvG@np-p-burton>
References: <20161107200921.30284-1-paul.burton@imgtec.com> <20161108071337.GA4601@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1679706.iadls1NNpy";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161108071337.GA4601@hardcore>
Sender: stable-owner@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

--nextPart1679706.iadls1NNpy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 8 November 2016 08:13:37 GMT Jan Glauber wrote:
> On Mon, Nov 07, 2016 at 08:09:20PM +0000, Paul Burton wrote:
> > Commit 70121f7f3725 ("i2c: octeon: thunderx: Limit register access
> > retries") attempted to replace potentially infinite loops with ones
> > which will time out using readq_poll_timeout, but in doing so it
> > inverted the condition for exiting this loop.
> > 
> > Tested on a Rhino Labs UTM-8 with Octeon CN7130.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jan Glauber <jglauber@cavium.com>
> > Cc: David Daney <david.daney@cavium.com>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c@vger.kernel.org
> > 
> > ---
> 
> Acked-by: Jan Glauber <jglauber@cavium.com>
> 
> Thanks for spotting this. I think this should go into stable too for
> 4.8, so adding Cc: stable@vger.kernel.org.

Hi Jan,

...but the bad patch was only merged for v4.9-rc1?

Thanks,
    Paul

> 
> >  drivers/i2c/busses/i2c-octeon-core.h | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-octeon-core.h
> > b/drivers/i2c/busses/i2c-octeon-core.h index 1db7c83..d980406 100644
> > --- a/drivers/i2c/busses/i2c-octeon-core.h
> > +++ b/drivers/i2c/busses/i2c-octeon-core.h
> > @@ -146,8 +146,9 @@ static inline void octeon_i2c_reg_write(struct
> > octeon_i2c *i2c, u64 eop_reg, u8> 
> >  	__raw_writeq(SW_TWSI_V | eop_reg | data, i2c->twsi_base + 
SW_TWSI(i2c));
> > 
> > -	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp, tmp & 
SW_TWSI_V,
> > -			   I2C_OCTEON_EVENT_WAIT, i2c->adap.timeout);
> > +	readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > +			   !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > +			   i2c->adap.timeout);
> > 
> >  }
> >  
> >  #define octeon_i2c_ctl_write(i2c, val)					\
> > 
> > @@ -173,7 +174,7 @@ static inline int octeon_i2c_reg_read(struct
> > octeon_i2c *i2c, u64 eop_reg,> 
> >  	__raw_writeq(SW_TWSI_V | eop_reg | SW_TWSI_R, i2c->twsi_base +
> >  	SW_TWSI(i2c));
> >  	
> >  	ret = readq_poll_timeout(i2c->twsi_base + SW_TWSI(i2c), tmp,
> > 
> > -				 tmp & SW_TWSI_V, I2C_OCTEON_EVENT_WAIT,
> > +				 !(tmp & SW_TWSI_V), I2C_OCTEON_EVENT_WAIT,
> > 
> >  				 i2c->adap.timeout);
> >  	
> >  	if (error)
> >  	
> >  		*error = ret;


--nextPart1679706.iadls1NNpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYIy4iAAoJEIIg2fppPBxltykP/i2zTP544fkCFKG44pTGgAAb
/+6uPeid6OB1UAOmNpF1HoZA8M9Ag/6JCxd/lwnAq3L3TzJPb18zqXyHZfhi9Uxk
7OqC8amjvxJC41hF5NLxyPBc+cuX1yKusy/dRfhWvjchZAwq8x61MpX7UJ14HHLk
bMmei3sNnL1FL6exVKwvDxGqHaXjULBIEF6LCVaCCaErDD8YIXL2lIqDHum+5wLi
Sp4jTfRMdyZLRLyWRpdR++H4+CWSYrt427narLwUbHoRIrxWOCENH3qQobWamfqL
sF54kGtniWLuIKokOcER+FB+sU2zDnkfJ10r+yeejC/+boSEcuLoM6Xs966j+6TS
nXYkPnmN0a6SmwAWjDFpSxd82oYmGKZTohzVVikCFwhw2LSr4nG8ElJmn/COuuza
nncIP9B4M0Avoie2saiIq4LMntQgn2N96p0VVW1gGcl6M0lzdVXmCGd80hJrX8L5
atqxMSCGNli26mu6Hq3Y2iPS+95GSl+GnXCZS4sMxYrZpbaiixwWiNHGTomjo3J3
d/28rWL1NbbnmC7n4XTUEXn0OuJtQUw2nh2z2vyb5DNYPGAMSpNz5PoL3GSicbrx
9VlfaI4D0cRNMbppWkjF81KlBynGUEKXZpzSojg4yKI3UWflVtLOhOfYbtGcM1Io
hNRFZALCF4vOqIi72E82
=R8TF
-----END PGP SIGNATURE-----

--nextPart1679706.iadls1NNpy--
