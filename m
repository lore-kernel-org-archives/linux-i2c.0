From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC PATCH] i2c: acpi: put device when verifying client fails
Date: Thu, 12 Mar 2020 16:49:08 +0200
Message-ID: <20200312144908.GX1922688@smile.fi.intel.com>
References: <20200312133244.9564-1-wsa@the-dreams.de>
 <20200312144739.GW1922688@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200312144739.GW1922688@smile.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 12, 2020 at 04:47:39PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 12, 2020 at 02:32:44PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > i2c_verify_client() can fail, so we need to put the device when that
> > happens.
> 
> NAK, this will do double put and messing up with reference counters.
> Besides the fact, that device may disappear after looking up which leads us to
> even more problems.
> 
> See how i2c_acpi_find_client_by_adev() is used in callers.

Perhaps proper "fix" is to add the explanation to a comment in the code to
prevent false positive reports in the future?

-- 
With Best Regards,
Andy Shevchenko
