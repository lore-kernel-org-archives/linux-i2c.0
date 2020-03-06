From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/3] i2c: core: Provide generic definitions for bus
 frequencies
Date: Fri, 6 Mar 2020 12:10:49 +0200
Message-ID: <20200306101049.GT1224808@smile.fi.intel.com>
References: <20200227122129.65516-1-andriy.shevchenko@linux.intel.com>
 <73b9a005-e4b1-5dbf-5769-ee0866ba8c4e@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:32754 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgCFKKt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 6 Mar 2020 05:10:49 -0500
Content-Disposition: inline
In-Reply-To: <73b9a005-e4b1-5dbf-5769-ee0866ba8c4e@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Thu, Mar 05, 2020 at 09:58:29PM +0000, Peter Rosin wrote:
> On 2020-02-27 13:21, Andy Shevchenko wrote:
> > There are few maximum bus frequencies being used in the I²C core code.
> > Provide generic definitions for bus frequencies and use them in the core.
> > 
> > The drivers may use predefined constants where it is appropriate.
> > Some of them are already using these under slightly different names.
> > We will convert them later to use newly introduced defines.
> > 
> > These definitions will also help to avoid typos in the numbers that
> > may lead to subtle errors.

...

> > +/* I2C Frequency Modes */
> > +#define I2C_MAX_STANDARD_MODE_FREQ	100000
> > +#define I2C_MAX_FAST_MODE_FREQ		400000
> > +#define I2C_MAX_FAST_PLUS_MODE_FREQ	1000000
> > +#define I2C_MAX_TURBO_MODE_FREQ		1400000
> > +#define I2C_MAX_HIGH_SPEED_MODE_FREQ	3400000
> > +#define I2C_MAX_ULTRA_SPEED_MODE_FREQ	5000000
> 
> Am I the only one who do /not/ find these names readable?

Seems so :-)

> I can't seem to
> remember what frequency TURBO, HIGH, etc are and their ordering is
> difficult. It's all sounds like marketing buzz to me and my brain shuts
> off instantly.
> 
> This feels a lot like moving away from octal permissions for files, which
> is frowned upon...
> 
> Can we include some kind of indication of the actual frequency in the
> names as well please?
> 
> Perhaps something like I2C_MAX_STANDARD_MODE_100KHZ?

It's definitely a duplicate information here.

In I²C we have quite established range of frequencies (4 out of 6 in above
list), so, their names already implying very well defined frequencies.

For the rest 2 perhaps it's good to have something like your proposal,
but it will be inconsistent with the rest and with many controller
specifications.

Wolfram, what do you think about Peter's idea?

-- 
With Best Regards,
Andy Shevchenko
