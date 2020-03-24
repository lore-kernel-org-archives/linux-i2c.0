From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/6] i2c: rcar: Consolidate timings calls in
 rcar_i2c_clock_calculate()
Date: Tue, 24 Mar 2020 11:02:00 +0200
Message-ID: <20200324090200.GC1922688@smile.fi.intel.com>
References: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
 <20200316154929.20886-3-andriy.shevchenko@linux.intel.com>
 <20200323215420.GA10635@ninjato>
 <20200323220353.GZ1922688@smile.fi.intel.com>
 <20200324081328.GA1134@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:1664 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgCXJCA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 24 Mar 2020 05:02:00 -0400
Content-Disposition: inline
In-Reply-To: <20200324081328.GA1134@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Tue, Mar 24, 2020 at 09:13:28AM +0100, Wolfram Sang wrote:
> Hi Andy,
> 
> > > Here, the initialization to 0 is missing, so some values are broken.
> > 
> > Yes, and this is fine. They are not being used. So, the idea is, whenever we
> > pass "false" as a parameter to the function we must take care of all fields we
> > are using.
> 
> Can be argued. Still, uninitialized values look a little sloppy IMO. I
> had a patch on top of this series to print the generated values as debug
> output, and '0' looks much more intentional there.
> 
> > > Why don't we just drop the pointer and init the array directly?
> > > 
> > > 	struct i2c_timings t = {
> > > 		.bus_freq_hz = ...
> > > 		...
> > > 	}
> > 
> > I can do it if you think it's better. I have no strong opinion here.
> > From code prospective I guess it will be something similar anyway.
> 
> I like it better. Easier to read in the code, no need for a seperate
> pointer. I can fix it locally here, though.

I already sent v4 the other day, but can update since I have got new tags to
pick up.

-- 
With Best Regards,
Andy Shevchenko
