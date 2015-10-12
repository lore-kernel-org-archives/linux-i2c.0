From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH 1/2] i2c: scan entire ACPI namespace for I2C connections
Date: Mon, 12 Oct 2015 10:00:26 -0700
Message-ID: <20151012170026.GA5909@cumulusnetworks.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-2-git-send-email-dustin@cumulusnetworks.com>
 <20151012104649.GW1506@lahna.fi.intel.com>
 <1444648839.8361.590.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35243 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbJLRA2 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 13:00:28 -0400
Received: by pabve7 with SMTP id ve7so100796822pab.2
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2015 10:00:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444648839.8361.590.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net

On Mon Oct 12 14:20, Andy Shevchenko wrote:
> On Mon, 2015-10-12 at 13:46 +0300, Mika Westerberg wrote:
> > On Fri, Oct 09, 2015 at 05:41:46PM -0700, Dustin Byford wrote:
> > > An I2cSerialBus connection resource descriptor may indicate a
> > > ResourceSource (a string uniquely identifying the I2C bus 
> > > controller)
> > > anywhere in the ACPI namespace.  However, when enumerating 
> > > connections to a
> > > I2C bus controller, i2c-core.c:acpi_i2c_register_devices() as only
> > > searching devices that are descendants of the bus controller.
> > > 
> > > This change corrects acpi_i2c_register_devices() to walk the entire 
> > > ACPI
> > > namespace searching for I2C connections.
> > > 
> > > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> > 
> > This patch is already included in Andy's latest series adding support
> > for Intel Galileo here:
> > 
> > https://patchwork.ozlabs.org/patch/527231/
> > 
> > Maybe we can add your Tested-by/Reviewed-by to that patch instead?
> 
> Indeed, the Tested-by tag would be much appreciated!

OK, that works for me.  I didn't realize it had been submitted elsewhere
or I wouldn't have sent the duplicate.

Thanks.

		--Dustin
