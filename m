From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v7 2/6] i2c: acpi: Use available IRQ helper functions
Date: Thu, 27 Jun 2019 09:18:31 +0100
Message-ID: <20190627081831.GF54126@ediswmail.ad.cirrus.com>
References: <20190626150302.22703-1-ckeepax@opensource.cirrus.com>
 <20190626150302.22703-3-ckeepax@opensource.cirrus.com>
 <20190626190906.GA9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626190906.GA9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Wed, Jun 26, 2019 at 10:09:06PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 26, 2019 at 04:02:58PM +0100, Charles Keepax wrote:
> > Use the available IRQ helper functions, most of the functions have
> > additional helpful side affects like configuring the trigger type of the
> > IRQ.
> 
> > -	acpi_dev_free_resource_list(&resource_list);
> 
> I have thought that we can drop completely the resource_list, though ACPI
> doesn't allow this. So, I would rather withdraw this change to be on the safe
> (symmetrical) side.
> 

Yeah would be my preference as well, will do another spin.

Thanks,
Charles
