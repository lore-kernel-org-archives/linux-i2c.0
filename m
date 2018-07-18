From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Wed, 18 Jul 2018 11:14:49 +0200
Message-ID: <20180718091448.fw2y7ea6sk2osi3g@verge.net.au>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
 <20180717120737.bipotpki3yhn6klf@verge.net.au>
 <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
 <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
 <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
 <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1769473F18D646B7011C5803F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 17, 2018 at 02:57:27PM +0000, Phil Edworthy wrote:
> Hi Andy,
> 
> On 17 July 2018 15:47, Andy Shevchenko wrote:
> > On Tue, 2018-07-17 at 14:40 +0000, Phil Edworthy wrote:
> > > On 17 July 2018 15:19, Andy Shevchenko wrote:
> > > > On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:
> > > >
> > > > > > While your point sounds valid (don't remember how clk_get() is
> > > > > > implemented), NULL is also OK to have.
> > > > >
> > > > > Ok as in there is no bus clock, right?
> > > > > So it should be:
> > > > >  if (!IS_ERR_OR_NULL (dev->busclk))
> > > >
> > > > Nope, NULL is no error case for optional clock.
> > >
> > > I must be missing something here...
> > 
> > See how clk_prepare_enable() is implemented.
> Ok, if busclk is NULL the code can safely call clk_prepare_enable()
>
> > > I agree that NULL for an optional clock is not an error. However, the
> > > code above is now:
> > > +	if (prepare) {
> > > +		/* Optional bus clock */
> > 
> > > +		if (!IS_ERR_OR_NULL(dev->busclk)) {
> > 
> > Check for NULL is redundant.
> > 
> > > +			ret = clk_prepare_enable(dev->busclk);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > >  		return clk_prepare_enable(dev->clk);
> > > +	}
> > >
> > > So, if you have a valid busclk, it gets enabled, otherwise it is left
> > > alone.
> > 
> So the code as sent in the original email is correct (aside from Geert's
> comments about EPROBE_DEFER handling).
> 
> Maybe I need some coffee :\
> Thanks
> Phil

My point is that errors should be treated as errors.

In i2c_dw_prepare_clk() the following appears:

        if (IS_ERR(dev->clk))
                return PTR_ERR(dev->clk);

So dev->clk being an error value is treated as an error that
is passed up to the caller.

But in your patch (and the snippet below) dev->busclk is treated
as the optional clock not being present. Even if the error stored
nothing to do with the clock not being present - f.e.  ENOMEM or
as Geert mentioned elsewhere, EPROBE_DEFER.

Assuming the absense of the optional clock is indicated by ENOENT,
in my view correct code would include something like:

	...

	if (IS_ERR(dev->clk))
		return PTR_ERR(dev->clk);

	if (IS_ERR(dev->buslck) && PTR_ERR(dev->busclk) != -ENOENT)
		return PTR_ERR(dev->busclk);

	...
