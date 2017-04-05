From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v5 4/4] platform/x86: Add Intel Cherry Trail ACPI INT33FE
 device driver
Date: Wed, 5 Apr 2017 08:41:46 -0700
Message-ID: <20170405154146.GD27833@fury>
References: <20170404220335.9815-1-hdegoede@redhat.com>
 <20170404220335.9815-5-hdegoede@redhat.com>
 <1491400346.24567.5.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:32932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755441AbdDEPlv (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 5 Apr 2017 11:41:51 -0400
Content-Disposition: inline
In-Reply-To: <1491400346.24567.5.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Wed, Apr 05, 2017 at 04:52:26PM +0300, Andy Shevchenko wrote:
> On Wed, 2017-04-05 at 00:03 +0200, Hans de Goede wrote:
> > The INT33FE ACPI device has a CRS table with I2cSerialBusV2 resources
> > for
> > 3 devices: Maxim MAX17047 Fuel Gauge Controller, FUSB300C USB Type-C
> > Controller and PI3USB30532 USB switch.
> > 
> > This commit adds a driver for this ACPI device which instantiates
> > i2c-clients for these, so that the standard i2c drivers for these
> > chips
> > can bind to the them.
> > 
> 
> Looks like we need something such as MFD for I2C bus clients...
> 
> FWIW:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wolfram, will you be making an immutable i2c branch available for us to merge
into our platform driver x86 for-next branch in order to apply this patch?

Alternatively you could send this in on our behalf, but that complicates any
fixes between now and rc1 for this new driver. We'd prefer the immutable branch
and pull this in ourselves.

Either way,

Reviewed-by: Darren Hart (VMware) <dvhart@infradead.org>

Thanks,

-- 
Darren Hart
VMware Open Source Technology Center
