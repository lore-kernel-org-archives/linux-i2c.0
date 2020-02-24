From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 19/40] i2c: lpc2k: Use generic definitions for bus
 frequencies
Date: Mon, 24 Feb 2020 18:01:56 +0200
Message-ID: <20200224160156.GB10400@smile.fi.intel.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-19-andriy.shevchenko@linux.intel.com>
 <db95daf2-bccf-1073-91d5-5e827e011645@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:18224 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgBXQB5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 11:01:57 -0500
Content-Disposition: inline
In-Reply-To: <db95daf2-bccf-1073-91d5-5e827e011645@mleia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Mon, Feb 24, 2020 at 05:35:54PM +0200, Vladimir Zapolskiy wrote:
> On 2/24/20 5:15 PM, Andy Shevchenko wrote:
> > Since we have generic definitions for bus frequencies, let's use them.

> > -		bus_clk_rate = 100000; /* 100 kHz default clock rate */
> > +		bus_clk_rate = I2C_STANDARD_MODE_FREQ; /* 100 kHz default clock rate */
> 
> The line above becomes longer than 80 symbols, please fix it by simply
> removing the comment, note that it might be an issue through the series.

Will do.

> Could I2C_STD_MODE_FREQ be a shorter and still acceptable name?

I/m fine with it, but I will wait for Wolfram and others to comment.

> After the requested fix:
> 
> Acked-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks!

-- 
With Best Regards,
Andy Shevchenko
