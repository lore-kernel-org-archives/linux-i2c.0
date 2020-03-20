From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/6] i2c: core: Allow override timing properties with 0
Date: Fri, 20 Mar 2020 18:46:10 +0200
Message-ID: <20200320164610.GG1922688@smile.fi.intel.com>
References: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
 <20200316154929.20886-2-andriy.shevchenko@linux.intel.com>
 <20200320144357.GA1282@ninjato>
 <20200320162326.GD1922688@smile.fi.intel.com>
 <20200320164454.GE1282@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:28643 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbgCTQqK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Mar 2020 12:46:10 -0400
Content-Disposition: inline
In-Reply-To: <20200320164454.GE1282@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Fri, Mar 20, 2020 at 05:44:54PM +0100, Wolfram Sang wrote:
> On Fri, Mar 20, 2020 at 06:23:26PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 20, 2020 at 03:43:57PM +0100, Wolfram Sang wrote:
> > > 
> > > > +	struct i2c_timings i2c_t = {0};
> > > 
> > > Simply '... = { }'?
> > 
> > I prefer C standard over GCC extension.
> 
> Okay. I don't care too much. But '{ 0 }' then, with kernel style spacing?

Works for me!

-- 
With Best Regards,
Andy Shevchenko
