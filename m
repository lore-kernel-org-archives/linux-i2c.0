From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH 1/2] i2c: scan entire ACPI namespace for I2C connections
Date: Mon, 12 Oct 2015 11:57:23 -0700
Message-ID: <20151012185723.GA11643@cumulusnetworks.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-2-git-send-email-dustin@cumulusnetworks.com>
 <7153761.vXTXx4WAKT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36057 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbJLS5Y (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 12 Oct 2015 14:57:24 -0400
Received: by pacex6 with SMTP id ex6so6874709pac.3
        for <linux-i2c@vger.kernel.org>; Mon, 12 Oct 2015 11:57:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7153761.vXTXx4WAKT@vostro.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Andriy Shevchenko <andriy.shevchenko@intel.com>, Lee Jones <lee.jones@linaro.org>

On Mon Oct 12 21:01, Rafael J. Wysocki wrote:
> On Friday, October 09, 2015 05:41:46 PM Dustin Byford wrote:
> > An I2cSerialBus connection resource descriptor may indicate a
> > ResourceSource (a string uniquely identifying the I2C bus controller)
> > anywhere in the ACPI namespace.  However, when enumerating connections to a
> > I2C bus controller, i2c-core.c:acpi_i2c_register_devices() as only
> > searching devices that are descendants of the bus controller.
> > 
> > This change corrects acpi_i2c_register_devices() to walk the entire ACPI
> > namespace searching for I2C connections.
> > 
> > Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> 
> This one has already been submitted by Andy and I've ACKed it.

Sorry, I missed that before I sent the patch.

> I'm not sure what to do here, though.
> 
> I guess I can apply this one and put it into a branch for others to pull from.
>
> Thoughts?

I'd be OK if you just drop this patch and I won't include it in my next
revision.

		--Dustin
