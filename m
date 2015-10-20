From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Wed, 21 Oct 2015 01:13:37 +0200
Message-ID: <30756241.j6CcpgUCpp@vostro.rjw.lan>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com> <20151020125111.GJ1526@lahna.fi.intel.com> <20151020174959.GA14829@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20151020174959.GA14829@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Tuesday, October 20, 2015 10:49:59 AM Dustin Byford wrote:
> Hi Mika,
> 
> On Tue Oct 20 15:51, Mika Westerberg wrote:
> > On Mon, Oct 19, 2015 at 03:29:00PM -0700, Dustin Byford wrote:
> > > Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> > > device property compatible string match) enumerating I2C client devices
> > > connected through a I2C mux device requires a little extra work.
> > > 
> > > This change implements a method for describing an I2C device hierarchy that
> > > includes mux devices by using an ACPI Device() for each mux channel along
> > > with an _ADR to set the channel number for the device.  See
> > > Documentation/acpi/i2c-muxes.txt for a simple example.
> > > 
> > > Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
> > 
> > In general this looks good to me.
> > 
> > > ---
> > >  Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/i2c/i2c-core.c           | 15 +++++++++--
> > >  drivers/i2c/i2c-mux.c            |  8 ++++++
> > >  include/linux/acpi.h             |  6 +++++
> > >  4 files changed, 85 insertions(+), 2 deletions(-)
> > >  create mode 100644 Documentation/acpi/i2c-muxes.txt
> > > 
> > 
> > [...]
> > 
> > > +	/*
> > > +	 * By default, associate I2C adapters with their parent device's ACPI
> > > +	 * node.
> > > +	 */
> > > +	if (!has_acpi_companion(dev)) {
> > > +		struct acpi_device *adev = ACPI_COMPANION(dev->parent);
> > > +
> > > +		if (adev)
> > > +			ACPI_COMPANION_SET(dev, adev);
> > 
> > Instead of always doing this in the I2C core, maybe we can make it
> > dependent on the host controller driver. For example the I2C designware
> > driver already did this for both DT and ACPI:
> 
> I considered it, but I thought a default that fairly closely matches the
> old behavior was more convenient.
> 
> On the other hand, leaving it up to the controllers makes it all very
> explicit and perhaps simpler to reason about.
> 
> 
> I could be convinced either way.  But, if we move it to the controller
> drivers, which ones need the change?
> 
> grep -i acpi drivers/i2c/busses/i2c*
> 
> shows 18 drivers that might care.
> 
> > 	adap->dev.parent = &pdev->dev;
> > 	adap->dev.of_node = pdev->dev.of_node;
> > 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
> 
> Interesting, this code isn't in my tree.  I wonder why it was added,
> what code looks at the acpi companion on the i2c dev?  Before my change
> it was supposed to be NULL, and it is NULL on every other controller.

As I said, IMO it should be NULL for i2c devices (power management is the
main reason here).

Thanks,
Rafael

