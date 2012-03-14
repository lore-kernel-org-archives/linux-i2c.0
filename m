From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Add support for 16bit register access
Date: Wed, 14 Mar 2012 08:58:00 +0100
Message-ID: <201203140858.00472.sr@denx.de>
References: <1331654061-5322-1-git-send-email-sr@denx.de> <D5ECB3C7A6F99444980976A8C6D896384FA2BA250F@EAPEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D5ECB3C7A6F99444980976A8C6D896384FA2BA250F-8vAmw3ZAcdzhJTuQ9jeba9BPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spear-devel <spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Bhupesh,

On Wednesday 14 March 2012 04:29:23 Bhupesh SHARMA wrote:
> > -----Original Message-----
> > From: Stefan Roese [mailto:sr-ynQEQJNshbs@public.gmane.org]
> > Sent: Tuesday, March 13, 2012 9:24 PM
> > To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: spear-devel; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
> > Subject: [PATCH] i2c: designware: Add support for 16bit register access
> > 
> > The STM SPEAr platform can only access the i2c controller register
> > via 16bit read/write functions. This patch adds support to
> > automatically detect this 16bit access mode.
> > 
> > Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> > ---
> > 
> >  drivers/i2c/busses/i2c-designware-core.c |   22 ++++++++++++++++++++--
> >  drivers/i2c/busses/i2c-designware-core.h |    1 +
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.c
> > b/drivers/i2c/busses/i2c-designware-core.c
> > index df87992..d1facbc 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.c
> > +++ b/drivers/i2c/busses/i2c-designware-core.c
> > @@ -164,7 +164,14 @@ static char *abort_sources[] = {
> > 
> >  u32 dw_readl(struct dw_i2c_dev *dev, int offset)
> >  {
> > 
> > -	u32 value = readl(dev->base + offset);
> > +	u32 value;
> > +
> > +	if (dev->access_16bit) {
> > +		value = readw(dev->base + offset) |
> > +			(readw(dev->base + offset + 2) << 16);
> > +	} else {
> > +		value = readl(dev->base + offset);
> > +	}
> 
> We can do away with '{' parenthesis as these are single line
> of code inside both the 'if-else' blocks.

It's not a single-line statement. The first block extends spans 2 lines. At 
least that how I interpret this CodingStyle recommendation.
 
> >  	if (dev->swab)
> >  	
> >  		return swab32(value);
> > 
> > @@ -177,7 +184,12 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int
> > offset)
> > 
> >  	if (dev->swab)
> >  	
> >  		b = swab32(b);
> > 
> > -	writel(b, dev->base + offset);
> > +	if (dev->access_16bit) {
> > +		writew((u16)b, dev->base + offset);
> > +		writew((u16)(b >> 16), dev->base + offset + 2);
> > +	} else {
> > +		writel(b, dev->base + offset);
> > +	}
> > 
> >  }
> >  
> >  static u32
> > 
> > @@ -258,6 +270,12 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> > 
> >  		reg = DW_IC_COMP_TYPE_VALUE;
> >  	
> >  	}
> > 
> > +	/* Configure register access mode 16bit */
> > +	if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> > +		dev->access_16bit = 1;
> 
> Can we use a suitable macro for 0x0000ffff?

Hmmm. Wouldn't that make it more complex? 0x0000ffff is easy to understand. A 
marco would "hide" this value. I would prefer to keep the value.

> Also, if dev->access_16bit is bool we can simply set:
> 		dev->access_16bit = true;
> 
> more on that below...
> 
> > +		reg = DW_IC_COMP_TYPE_VALUE;
> > +	}
> > +
> > 
> >  	if (reg != DW_IC_COMP_TYPE_VALUE) {
> >  	
> >  		dev_err(dev->dev, "Unknown Synopsys component type: "
> >  		
> >  			"0x%08x\n", reg);
> > 
> > diff --git a/drivers/i2c/busses/i2c-designware-core.h
> > b/drivers/i2c/busses/i2c-designware-core.h
> > index 02d1a2d..f5af101 100644
> > --- a/drivers/i2c/busses/i2c-designware-core.h
> > +++ b/drivers/i2c/busses/i2c-designware-core.h
> > @@ -83,6 +83,7 @@ struct dw_i2c_dev {
> > 
> >  	u32			abort_source;
> >  	int			irq;
> >  	int			swab;
> > 
> > +	int			access_16bit;
> 
> ...
> int?? Probably we are better off with making this as bool.

I'm not a big fan of bool's. But I have no strong preference here. My 
reasoning here was consistency. As we already have "int swab" for a similar 
issue.

So basically, I would prefer to not make the changes you suggested. But in the 
end its the decision of the maintainer(s).

Thanks,
Stefan
