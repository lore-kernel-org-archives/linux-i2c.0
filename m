From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 01/40] i2c: qup: Move bus frequency definitions to
 i2c.h
Date: Tue, 25 Feb 2020 12:47:08 +0200
Message-ID: <20200225104708.GF10400@smile.fi.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200225102233.GA3677@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40215 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbgBYKrI (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 05:47:08 -0500
Content-Disposition: inline
In-Reply-To: <20200225102233.GA3677@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>

On Tue, Feb 25, 2020 at 11:22:33AM +0100, Wolfram Sang wrote:
> On Mon, Feb 24, 2020 at 05:14:51PM +0200, Andy Shevchenko wrote:
> > Move bus frequency definitions to i2c.h for wider use.
> > 
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> A cover letter would have been nice so we could discuss the general
> appraoch there. And to read more about the motivation.

Motivation is simple:
 - Standardize the (small) set of mostly used bus frequences
 - Get rid of repetition of (subset) of above in many drivers
 - Reduce amount of potential typos

Let's discuss it here. I don't think new version of this would be good to have
without initial settlement.

> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -39,6 +39,13 @@ enum i2c_slave_event;
> >  typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
> >  			      enum i2c_slave_event event, u8 *val);
> >  
> > +#define HZ_PER_KHZ			1000
> 
> Unlike Jarkko, I think such macros help readability when calculating
> frequencies within drivers. However, they shouldn't be local to I2C if
> we agree on them. They should be available Linux-wide. There are some
> other (few) local implementations already.

I aware about that, but I would like to avoid I²C subsystem storming for
another change like this. So, let's consider this as a trampoline when in the
future we will switch entire subsystem to Linux wide header at once.

We have already same/similar definitions in the other drivers and I really
would like to avoid cross subsystem collisions.

> > +/* I2C Frequency Modes */
> > +#define I2C_STANDARD_MODE_FREQ		(100 * HZ_PER_KHZ)
> > +#define I2C_FAST_MODE_FREQ		(400 * HZ_PER_KHZ)
> > +#define I2C_FAST_MODE_PLUS_FREQ		(1000 * HZ_PER_KHZ)
> 
> For such a header, I'd prefer the plain number, though. There will be
> enough review to make sure we get it right ;)

No problem. I'm fine with either.

> Furthermore, I'd prefer to
> have 'MAX' in there, e.g. I2C_MAX_STANDARD_MODE_FREQ etc. Just to make
> clear that I2C can have other bus speeds as well.

Works for me.

Btw, what about Vladimir's comment WRT STANDARD -> STD? My personal opinion
that STD is a bit too short.

> And finally, I'd think all driver patches should be squashed into one,
> and all core ones into one etc. Or?

I'm fine with either. For reviewers it would be better I think to see only
their portion. Since I got a lot of tags already I consider I may squash it
together. So, what do you prefer?

-- 
With Best Regards,
Andy Shevchenko
