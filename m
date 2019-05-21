From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/5] i2c: acpi: Use available IRQ helper functions
Date: Tue, 21 May 2019 20:16:47 +0300
Message-ID: <20190521171647.GM9224@smile.fi.intel.com>
References: <20190521150502.27305-1-ckeepax@opensource.cirrus.com>
 <20190521150502.27305-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521150502.27305-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 21, 2019 at 04:04:59PM +0100, Charles Keepax wrote:
> Use the available IRQ helper functions, most of the functions have
> additional helpful side affects like configuring the trigger type of the
> IRQ.

More logical to me is to do this as a first patch in the series.
Besides that, I would really split it into two:
- exporting helper;
- using it.

-- 
With Best Regards,
Andy Shevchenko
