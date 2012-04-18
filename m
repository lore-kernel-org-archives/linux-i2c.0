From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2] i2c: designware: Add support for 16bit register access
Date: Wed, 18 Apr 2012 14:58:11 +0200
Message-ID: <201204181458.11326.sr@denx.de>
References: <1334734399-1003-1-git-send-email-sr@denx.de> <20120418112426.GD21955@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418112426.GD21955-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 18 April 2012 13:24:26 Wolfram Sang wrote:

<snip>

> > @@ -254,7 +265,13 @@ int i2c_dw_init(struct dw_i2c_dev *dev)
> > 
> >  	/* Configure register endianess access */
> >  	reg = dw_readl(dev, DW_IC_COMP_TYPE);
> >  	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
> > 
> > -		dev->swab = 1;
> > +		dev->accessor_flags |= ACCESS_SWAP;
> > +		reg = DW_IC_COMP_TYPE_VALUE;
> 
> May I ask you to use proper if/elseif/else blocks instead of overwriting
> reg? I know you didn't come up with the mechanism, yet it looks too
> fragile to be extended IMO.

Okay, will do.
 
> > +	}
> > +
> > +	/* Configure register access mode 16bit */
> > +	if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
> 
> Does it make sense to check reg + 2 for the upper part of the signature?

Not from my point of view. Its very unlikely that this driver will be used on 
another controller. Its configured (via its address in platform-data or DT) 
for exactly this controller. And matching 16bit of this 32bit register seems 
enough for me. I would even have no problem to remove this check completely.

Thanks,
Stefan
