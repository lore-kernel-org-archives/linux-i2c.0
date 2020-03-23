From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 3/6] i2c: rcar: Consolidate timings calls in
 rcar_i2c_clock_calculate()
Date: Tue, 24 Mar 2020 00:03:53 +0200
Message-ID: <20200323220353.GZ1922688@smile.fi.intel.com>
References: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
 <20200316154929.20886-3-andriy.shevchenko@linux.intel.com>
 <20200323215420.GA10635@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:19436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCWWDw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 23 Mar 2020 18:03:52 -0400
Content-Disposition: inline
In-Reply-To: <20200323215420.GA10635@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

On Mon, Mar 23, 2020 at 10:54:21PM +0100, Wolfram Sang wrote:
> 
> > +	struct i2c_timings i2c_t, *t = &i2c_t;
> >  
> >  	/* Fall back to previously used values if not supplied */
> > -	t->bus_freq_hz = t->bus_freq_hz ?: 100000;
> > -	t->scl_fall_ns = t->scl_fall_ns ?: 35;
> > -	t->scl_rise_ns = t->scl_rise_ns ?: 200;
> > -	t->scl_int_delay_ns = t->scl_int_delay_ns ?: 50;
> > +	t->bus_freq_hz = I2C_MAX_STANDARD_MODE_FREQ;
> > +	t->scl_fall_ns = 35;
> > +	t->scl_rise_ns = 200;
> > +	t->scl_int_delay_ns = 50;
> 
> Here, the initialization to 0 is missing, so some values are broken.

Yes, and this is fine. They are not being used. So, the idea is, whenever we
pass "false" as a parameter to the function we must take care of all fields we
are using.

> Why don't we just drop the pointer and init the array directly?
> 
> 	struct i2c_timings t = {
> 		.bus_freq_hz = ...
> 		...
> 	}

I can do it if you think it's better. I have no strong opinion here.
>From code prospective I guess it will be something similar anyway.

-- 
With Best Regards,
Andy Shevchenko
