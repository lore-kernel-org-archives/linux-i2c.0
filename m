From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 02/15] platform/x86: intel_cht_int33fe: Accept errors
 of i2c_acpi_new_device()
Date: Sun, 2 Dec 2018 19:38:54 +0200
Message-ID: <20181202173854.GG10650@smile.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-3-andriy.shevchenko@linux.intel.com>
 <20181202155606.16b55703@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181202155606.16b55703@archlinux>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Dec 02, 2018 at 03:56:06PM +0000, Jonathan Cameron wrote:
> On Wed, 28 Nov 2018 13:45:22 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > In the future i2c_acpi_new_device() will return error pointer in some cases.
> > Prepare intel_cht_int33fe driver to support that.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Really trivial comment inline.  I haven't checked back to see if there
> has been any previous discussion on that bit of code.
> 
> Otherwise looks sensible to me.

> >  		data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
> > -		if (!data->max17047)
> > -			return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> > +		if (IS_ERR(data->max17047))
> > +			ret = PTR_ERR(data->max17047);
> Every so slightly nicer to just return directly in these error cases?
> > +		else if (!data->max17047)
> > +			ret = -EPROBE_DEFER; /* Wait for i2c-adapter to load */
> > +		else
> > +			ret = 0;

> Particularly so as then you don't need to set this ret as it's set in all
> paths where it is used below anyway...

It doesn't matter much, since the logically it's split to 3 stages:
- preparation
- change API
- drop obsoleted pieces of code

This one is preparation stage. After 3rd stage it will be as you suggested.

> > +		if (ret)
> > +			return ret;

-- 
With Best Regards,
Andy Shevchenko
