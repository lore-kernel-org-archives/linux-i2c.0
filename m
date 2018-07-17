From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 17:47:19 +0300
Message-ID: <c912248504a4cd534a90d263ab6005526a7e16ab.camel@linux.intel.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
         <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
         <TY1PR01MB1769BD3E271E217E0CFBAB46F55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
         <40f2729f38bd565a829d60d9cc8f508e33b0dc65.camel@linux.intel.com>
         <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR01MB1769F130075F1635CC51532FF55C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms@verge.net.au>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-17 at 14:40 +0000, Phil Edworthy wrote:
> Hi Andy,
> 
> On 17 July 2018 15:19, Andy Shevchenko wrote:
> > On Tue, 2018-07-17 at 12:42 +0000, Phil Edworthy wrote:
> > 
> > > > While your point sounds valid (don't remember how clk_get() is
> > > > implemented), NULL is also OK to have.
> > > 
> > > Ok as in there is no bus clock, right?
> > > So it should be:
> > >  if (!IS_ERR_OR_NULL (dev->busclk))
> > 
> > Nope, NULL is no error case for optional clock.
> 
> I must be missing something here...

See how clk_prepare_enable() is implemented.

> I agree that NULL for an optional clock is not an error. However, the 
> code above is now:
> +	if (prepare) {
> +		/* Optional bus clock */

> +		if (!IS_ERR_OR_NULL(dev->busclk)) {

Check for NULL is redundant.

> +			ret = clk_prepare_enable(dev->busclk);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		return clk_prepare_enable(dev->clk);
> +	}
> 
> So, if you have a valid busclk, it gets enabled, otherwise it is
> left alone.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
