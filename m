From: Dustin Byford <dustin@cumulusnetworks.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Tue, 20 Oct 2015 10:49:59 -0700
Message-ID: <20151020174959.GA14829@cumulusnetworks.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
 <20151020125111.GJ1526@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33584 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbbJTRuC (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 20 Oct 2015 13:50:02 -0400
Received: by pabrc13 with SMTP id rc13so27683051pab.0
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2015 10:50:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151020125111.GJ1526@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com

Hi Mika,

On Tue Oct 20 15:51, Mika Westerberg wrote:
> On Mon, Oct 19, 2015 at 03:29:00PM -0700, Dustin Byford wrote:
> > Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> > device property compatible string match) enumerating I2C client devices
> > connected through a I2C mux device requires a little extra work.
> > 
> > This change implements a method for describing an I2C device hierarchy that
> > includes mux devices by using an ACPI Device() for each mux channel along
> > with an _ADR to set the channel number for the device.  See
> > Documentation/acpi/i2c-muxes.txt for a simple example.
> > 
> > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> 
> In general this looks good to me.
> 
> > ---
> >  Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/i2c-core.c           | 15 +++++++++--
> >  drivers/i2c/i2c-mux.c            |  8 ++++++
> >  include/linux/acpi.h             |  6 +++++
> >  4 files changed, 85 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/acpi/i2c-muxes.txt
> > 
> 
> [...]
> 
> > +	/*
> > +	 * By default, associate I2C adapters with their parent device's ACPI
> > +	 * node.
> > +	 */
> > +	if (!has_acpi_companion(dev)) {
> > +		struct acpi_device *adev = ACPI_COMPANION(dev->parent);
> > +
> > +		if (adev)
> > +			ACPI_COMPANION_SET(dev, adev);
> 
> Instead of always doing this in the I2C core, maybe we can make it
> dependent on the host controller driver. For example the I2C designware
> driver already did this for both DT and ACPI:

I considered it, but I thought a default that fairly closely matches the
old behavior was more convenient.

On the other hand, leaving it up to the controllers makes it all very
explicit and perhaps simpler to reason about.


I could be convinced either way.  But, if we move it to the controller
drivers, which ones need the change?

grep -i acpi drivers/i2c/busses/i2c*

shows 18 drivers that might care.

> 	adap->dev.parent = &pdev->dev;
> 	adap->dev.of_node = pdev->dev.of_node;
> 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));

Interesting, this code isn't in my tree.  I wonder why it was added,
what code looks at the acpi companion on the i2c dev?  Before my change
it was supposed to be NULL, and it is NULL on every other controller.

> Also I would like to ask what Rafael thinks about this since he authored
> b34bb1ee71158d5b ("ACPI / I2C: Use parent's ACPI_HANDLE() in
> acpi_i2c_register_devices()").
> 
> I don't see a problem multiple Linux devices sharing a single ACPI
> companion device like in this patch but I may be forgetting something ;-)

OK.  Thanks.

		--Dustin
