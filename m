From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/6] i2c: core: Provide generic definitions for bus
 frequencies
Date: Fri, 20 Mar 2020 18:23:56 +0200
Message-ID: <20200320162356.GE1922688@smile.fi.intel.com>
References: <20200316154929.20886-1-andriy.shevchenko@linux.intel.com>
 <20200319171913.GM1922688@smile.fi.intel.com>
 <20200320144542.GB1282@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:16452 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgCTQZF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 20 Mar 2020 12:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20200320144542.GB1282@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Mar 20, 2020 at 03:45:42PM +0100, Wolfram Sang wrote:
> On Thu, Mar 19, 2020 at 07:19:13PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 16, 2020 at 05:49:24PM +0200, Andy Shevchenko wrote:
> > > There are few maximum bus frequencies being used in the I²C core code.
> > > Provide generic definitions for bus frequencies and use them in the core.
> > > 
> > > The drivers may use predefined constants where it is appropriate.
> > > Some of them are already using these under slightly different names.
> > > We will convert them later to use newly introduced defines.
> > > 
> > > Note, the name of modes are chosen to follow well established naming
> > > scheme [1].
> > > 
> > > These definitions will also help to avoid typos in the numbers that
> > > may lead to subtle errors.
> > 
> > Wolfram, is any chance to get applied at least 1, 5 and 6 from this series?
> 
> Yes, just make sure v4 is based on i2c/for-next to minimize merge
> conflicts.

Will do, thank you!

-- 
With Best Regards,
Andy Shevchenko
