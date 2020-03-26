From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: refactor parsing of timings
Date: Thu, 26 Mar 2020 13:16:35 +0200
Message-ID: <20200326111635.GO1922688@smile.fi.intel.com>
References: <20200326101647.1756-1-wsa+renesas@sang-engineering.com>
 <20200326104701.GM1922688@smile.fi.intel.com>
 <20200326110042.GB1538@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200326110042.GB1538@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 26, 2020 at 12:00:42PM +0100, Wolfram Sang wrote:
> 
> > However, looking into the code, I would go a bit further (perhaps as a separate
> > change) and export parsing of clock-frequency, because tons of drivers only
> > need one property, i.e. clock-frequency out of firmware.
> 
> Cool idea. Could be easily something like this (typed from the top of my
> head):
> 
> static inline u32 i2c_parse_fw_bus_speed(struct device *dev)
> {
> 	u32 speed;
> 
> 	i2c_parse_timing(dev, "clock-frequency", &speed, I2C_MAX_STANDARD_MODE_FREQ, true);
> 
> 	return speed;
> }

Yes, looks like this, thanks!

-- 
With Best Regards,
Andy Shevchenko
