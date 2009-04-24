From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH, v3] Let PCA9564 recover from unacked data byte (state
 0x30)
Date: Fri, 24 Apr 2009 13:33:53 +0200
Message-ID: <20090424133353.7925e34b@hyperion.delvare>
References: <20090407103847.GA13586@ngeserver2.localdomain>
	<20090409093855.GB539@ngeserver2.localdomain>
	<20090414170107.GA4260@pengutronix.de>
	<20090415074500.GA629@ngeserver2.localdomain>
	<20090424103218.GE26169@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090424103218.GE26169-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>, Ian Campbell <icampbell-2sJRl1BP9u0AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Fri, 24 Apr 2009 12:32:18 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> can you pick this one up? I think it qualifies as a bugfix.

Sure! Sorry I had missed your review. It's queued up for 2.6.30 now.

> 
> Regards,
> 
>    Wolfram
> 
> On Wed, Apr 15, 2009 at 09:45:00AM +0200, Enrik Berkhan wrote:
> > Currently, the i2c-algo-pca driver does nothing if the chip enters state
> > 0x30 (Data byte in I2CDAT has been transmitted; NOT ACK has been
> > received).  Thus, the i2c bus connected to the controller gets stuck
> > afterwards.
> > 
> > I have seen this kind of error on a custom board in certain load
> > situations most probably caused by interference or noise.
> > 
> > A possible reaction is to let the controller generate a STOP condition.
> > This is documented in the PCA9564 data sheet (2006-09-01) and the same
> > is done for other NACK states as well.
> > 
> > Further, state 0x38 isn't handled completely, either. Try to do another
> > START in this case like the data sheet says. As this couldn't be tested,
> > I've added a comment to try to reset the chip if the START doesn't help
> > as suggested by Wolfram Sang.
> > 
> > Signed-off-by: Enrik Berkhan <Enrik.Berkhan-JJi787mZWgc@public.gmane.org>
> > Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/algos/i2c-algo-pca.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > Index: drivers/i2c/algos/i2c-algo-pca.c
> > ===================================================================
> > --- drivers/i2c/algos/i2c-algo-pca.c.orig	2008-12-25 00:26:37.000000000 +0100
> > +++ drivers/i2c/algos/i2c-algo-pca.c	2009-04-15 09:37:22.000000000 +0200
> > @@ -270,10 +270,21 @@ static int pca_xfer(struct i2c_adapter *
> >  
> >  		case 0x30: /* Data byte in I2CDAT has been transmitted; NOT ACK has been received */
> >  			DEB2("NOT ACK received after data byte\n");
> > +			pca_stop(adap);
> >  			goto out;
> >  
> >  		case 0x38: /* Arbitration lost during SLA+W, SLA+R or data bytes */
> >  			DEB2("Arbitration lost\n");
> > +			/*
> > +			 * The PCA9564 data sheet (2006-09-01) says "A
> > +			 * START condition will be transmitted when the
> > +			 * bus becomes free (STOP or SCL and SDA high)"
> > +			 * when the STA bit is set (p. 11).
> > +			 *
> > +			 * In case this won't work, try pca_reset()
> > +			 * instead.
> > +			 */
> > +			pca_start(adap);
> >  			goto out;
> >  
> >  		case 0x58: /* Data byte has been received; NOT ACK has been returned */
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Jean Delvare
