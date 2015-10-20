From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v3 1/1] i2c: add ACPI support for I2C mux ports
Date: Tue, 20 Oct 2015 15:51:11 +0300
Message-ID: <20151020125111.GJ1526@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-1-git-send-email-dustin@cumulusnetworks.com>
 <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445293740-28537-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, andriy.shevchenko@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On Mon, Oct 19, 2015 at 03:29:00PM -0700, Dustin Byford wrote:
> Although I2C mux devices are easily enumerated using ACPI (_HID/_CID or
> device property compatible string match) enumerating I2C client devices
> connected through a I2C mux device requires a little extra work.
> 
> This change implements a method for describing an I2C device hierarchy that
> includes mux devices by using an ACPI Device() for each mux channel along
> with an _ADR to set the channel number for the device.  See
> Documentation/acpi/i2c-muxes.txt for a simple example.
> 
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

In general this looks good to me.

> ---
>  Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-core.c           | 15 +++++++++--
>  drivers/i2c/i2c-mux.c            |  8 ++++++
>  include/linux/acpi.h             |  6 +++++
>  4 files changed, 85 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/acpi/i2c-muxes.txt
> 

[...]

> +	/*
> +	 * By default, associate I2C adapters with their parent device's ACPI
> +	 * node.
> +	 */
> +	if (!has_acpi_companion(dev)) {
> +		struct acpi_device *adev = ACPI_COMPANION(dev->parent);
> +
> +		if (adev)
> +			ACPI_COMPANION_SET(dev, adev);

Instead of always doing this in the I2C core, maybe we can make it
dependent on the host controller driver. For example the I2C designware
driver already did this for both DT and ACPI:

	adap->dev.parent = &pdev->dev;
	adap->dev.of_node = pdev->dev.of_node;
	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));

Also I would like to ask what Rafael thinks about this since he authored
b34bb1ee71158d5b ("ACPI / I2C: Use parent's ACPI_HANDLE() in
acpi_i2c_register_devices()").

I don't see a problem multiple Linux devices sharing a single ACPI
companion device like in this patch but I may be forgetting something ;-)
