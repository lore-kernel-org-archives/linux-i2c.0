From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] i2c: designware: Make master module optional
Date: Wed, 25 Mar 2020 13:45:29 +0200
Message-ID: <20200325114529.GU1922688@smile.fi.intel.com>
References: <20200323100451.28808-1-andriy.shevchenko@linux.intel.com>
 <c3d2d5ff-605a-bdb7-275b-872fdfd10ccd@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:52302 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCYLp2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Mar 2020 07:45:28 -0400
Content-Disposition: inline
In-Reply-To: <c3d2d5ff-605a-bdb7-275b-872fdfd10ccd@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>

On Wed, Mar 25, 2020 at 09:47:47AM +0200, Jarkko Nikula wrote:
> On 3/23/20 12:04 PM, Andy Shevchenko wrote:
> > In some cases we know that the controller will be always used in slave mode and
> > master is just a bulk. In order to drop that, introduce a separate configuration
> > parameter for master mode. Default it to core to avoid regressions.

> I think we should go to a opposite direction - reduce the number of
> I2C_DESIGNWARE_ config options rather than add new ones. We already have 5
> config options for it.
> 
> Size of i2c-designware-core.ko is around 12 kB with all master, slave and
> Baytrail semaphore code built in so I don't think it justifies the added
> config complexity. I think distributions will have anyway all of those
> options set.

I would rather go with conditional based on I²C generic options, like I2C_SLAVE.
Do we have something similar for master?

> Having those code in separate modules and load only when needed might make
> sense as that would save a few kB of RAM.

...which makes sense for embedded systems where exactly the device represents
I²C slave.

-- 
With Best Regards,
Andy Shevchenko
