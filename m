From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Wed, 21 Oct 2015 11:12:31 +0300
Message-ID: <20151021081231.GQ1526@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
 <20151020125111.GJ1526@lahna.fi.intel.com>
 <20151020174959.GA14829@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151020174959.GA14829@cumulusnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 20, 2015 at 10:49:59AM -0700, Dustin Byford wrote:
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

I'm quite confident the designware I2C is enough for now. Intel uses it
for all SoCs with LPSS and I think AMD has the same block for their I2C
solution.

> > 	adap->dev.parent = &pdev->dev;
> > 	adap->dev.of_node = pdev->dev.of_node;
> > 	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
> 
> Interesting, this code isn't in my tree.  I wonder why it was added,
> what code looks at the acpi companion on the i2c dev?  Before my change
> it was supposed to be NULL, and it is NULL on every other controller.

It is not in any tree. I meant that before b34bb1ee71158d5b it looked
something like that :-)
