From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [CORRECTED] I2C driver supporting Moorestown and Medfield
	platform
Date: Tue, 31 Aug 2010 23:44:45 +0100
Message-ID: <20100831224445.GD24761@trinity.fluff.org>
References: <20100803143431.23655.31975.stgit@localhost.localdomain> <4C5FDFA9.60703@fluff.org> <20100809132345.44fdbaea@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100809132345.44fdbaea-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 09, 2010 at 01:23:45PM +0100, Alan Cox wrote:
> > I would much prefer this to be called i2c-moorsetown, we have modern
> > systems which can handle >8 character names.
> 
> Moorestown. Everything else in the kernel uses 'mrst' so this would
> make the driver differ from the rest of the tree. I don't care too much
> what its called. Given its now for Medfield etc as well it probably
> should be i2c_intel_mid to match the rest of the kernel

Ok.
 
> > Hmm, if this is a synopsys block, then is it a standard one and if so
> > can we get some standard support?
> 
> See other reply on this one.

Annoying, I'd much rather have a core driver with some bus support
added as needed.

> > > +	if ((p1->flags ^ p2->flags) & I2C_M_TEN)
> > > +		return 1;
> > > +	return 0;
> > > +}
> > 
> > would have been better to return bool.
> 
> Can do but most of the kernel never uses bool so again it would be a
> quirky style. If its preferred i2c style no problem.

I thought it was introduced for this sort of thing... I've been using
it in all my new driver work.
 
> 
> > > +	for (i = 0; i < length; i++)
> > > +		mrst_i2c_write(i2c->base + IC_DATA_CMD,
> > > +			       (uint16_t)(*(buf + i)));
> > 
> > you say length in bytes, but write u16?
> > also, would be neater to have a u16 *buf?
> 
> Ermm no - that would be most peculiar as you'd then only send every
> alternate byte of data. Then again the cast ought to be implied by the
> types of mrst_i2c_write - will review

This code is rather easy to mis-understand, how about making it
easier to read, ie:

       (uint16_t)buf[i]

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
