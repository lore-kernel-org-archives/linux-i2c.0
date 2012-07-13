From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH 2/4] i2c: i2c-ocores: Use reg-shift property
Date: Fri, 13 Jul 2012 18:08:45 +0530
Message-ID: <20120713123845.GB18519@jayachandranc.netlogicmicro.com>
References: <1342161543-5838-1-git-send-email-jayachandranc@netlogicmicro.com>
 <1342161543-5838-3-git-send-email-jayachandranc@netlogicmicro.com>
 <20120713091731.GI32184@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120713091731.GI32184-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 13, 2012 at 11:17:31AM +0200, Wolfram Sang wrote:
> On Fri, Jul 13, 2012 at 12:09:01PM +0530, Jayachandran C wrote:
> > From: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > 
> > Deprecate 'regstep' property and use the standard 'reg-shift' property
> > for register offset shifts. 'regstep' will still be supported as an
> > optional property, but will give a warning when used.
> > 
> > Signed-off-by: Ganesan Ramalingam <ganesanr-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
> > ---
[...]
> > +		}
> > +	} else
> > +		i2c->reg_shift = val;
> 
> Now you are assigning an u32 to an int. Regstep will never be really a
> huge number, but still...
> 
> Also, braces around else-block according to coding style.
> 
> >  
> > -	val = of_get_property(pdev->dev.of_node, "clock-frequency", NULL);
> > -	if (!val) {
> > +	if (of_property_read_u32(np, "clock-frequency", &val)) {
> >  		dev_err(&pdev->dev,
> >  			"Missing required parameter 'clock-frequency'\n");
> >  		return -ENODEV;
> >  	}
> > -	i2c->clock_khz = be32_to_cpup(val) / 1000;
> > +	i2c->clock_khz = val / 1000;
> 
> Okay, "/ 1000" will guarantee that the divided value will fit into an
> int. Yet, what do we gain by not using u32?

I will send out a new version of this patch using u32. In this case I
felt that there is no need to use a fixed width type when an int would
do.

Regards,
JC.
