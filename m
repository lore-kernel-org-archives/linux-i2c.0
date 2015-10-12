From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: add ACPI support for I2C mux ports
Date: Mon, 12 Oct 2015 13:50:23 +0300
Message-ID: <20151012105023.GX1506@lahna.fi.intel.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-3-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10585 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbbJLKu1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 06:50:27 -0400
Content-Disposition: inline
In-Reply-To: <1444437707-19027-3-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net

On Fri, Oct 09, 2015 at 05:41:47PM -0700, Dustin Byford wrote:
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
> ---
>  Documentation/acpi/i2c-muxes.txt | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-core.c           | 18 +++++++++++--
>  drivers/i2c/i2c-mux.c            |  8 ++++++
>  3 files changed, 82 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/acpi/i2c-muxes.txt
> 
> diff --git a/Documentation/acpi/i2c-muxes.txt b/Documentation/acpi/i2c-muxes.txt
> new file mode 100644
> index 0000000..efdcf0d
> --- /dev/null
> +++ b/Documentation/acpi/i2c-muxes.txt
> @@ -0,0 +1,58 @@
> +ACPI I2C Muxes
> +--------------
> +
> +Describing an I2C device hierarchy that includes I2C muxes requires an ACPI
> +Device() scope per mux channel.
> +
> +Consider this topology:
> +
> ++------+   +------+
> +| SMB1 |-->| MUX0 |--CH00--> i2c client A (0x50)
> +|      |   | 0x70 |--CH01--> i2c client B (0x50)
> ++------+   +------+
> +
> +which corresponds to the following ASL:
> +
> +Device(SMB1)
> +{
> +    Name (_HID, ...)
> +    Device(MUX0)

Nit: please be consistent:

	Name ()
	Device ()

> +    {
> +        Name (_HID, ...)
> +        Name (_CRS, ResourceTemplate () {
> +            I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
> +                          AddressingMode7Bit, "^SMB1", 0x00,
> +                          ResourceConsumer,,)
> +        }
> +
> +        Device(CH00)
> +        {
> +            Name (_ADR, 0)
> +
> +            Device(CLIA)
> +            {
> +                Name (_HID, ...)
> +                Name (_CRS, ResourceTemplate () {
> +                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                  AddressingMode7Bit, "^CH00", 0x00,
> +                                  ResourceConsumer,,)
> +                }
> +            }
> +        }
> +
> +        Device(CH01)
> +        {
> +            Name (_ADR, 1)
> +
> +            Device(CLIB)
> +            {
> +                Name (_HID, ...)
> +                Name (_CRS, ResourceTemplate () {
> +                    I2cSerialBus (0x50, ControllerInitiated, I2C_SPEED,
> +                                  AddressingMode7Bit, "^CH01", 0x00,
> +                                  ResourceConsumer,,)
> +                }
> +            }
> +        }
> +    }
> +}
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 3a4c54e..a2de010 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -156,7 +156,10 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  	info.fwnode = acpi_fwnode_handle(adev);
>  
>  	memset(&lookup, 0, sizeof(lookup));
> -	lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
> +	if (i2c_parent_is_i2c_adapter(adapter))
> +		lookup.adapter_handle = ACPI_HANDLE(&adapter->dev);
> +	else
> +		lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);

So I don't really like this.

Isn't there any other way to figure out the right companion for the
device?

>  	lookup.device_handle = handle;
>  	lookup.info = &info;
>  
> @@ -210,9 +213,20 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>   */
>  static void acpi_i2c_register_devices(struct i2c_adapter *adap)
>  {
> +	struct device *dev;
>  	acpi_status status;
>  
> -	if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
> +	/*
> +	 * Typically we look at the ACPI device's parent for an ACPI companion.
> +	 * However, in the case of an I2C-connected I2C mux, the "virtual" I2C
> +	 * adapter allocated for the mux channel has that association.
> +	 */
> +	if (i2c_parent_is_i2c_adapter(adap))
> +		dev = &adap->dev;
> +	else
> +		dev = adap->dev.parent;

Ditto.

> +
> +	if (!has_acpi_companion(dev))
>  		return;
>  
>  	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index 2ba7c0f..00fc5b1 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -25,6 +25,7 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
>  #include <linux/of.h>
> +#include <linux/acpi.h>
>  
>  /* multiplexer per channel data */
>  struct i2c_mux_priv {
> @@ -173,6 +174,13 @@ struct i2c_adapter *i2c_add_mux_adapter(struct i2c_adapter *parent,
>  		}
>  	}
>  
> +	/*
> +	 * Associate the mux channel with an ACPI node.
> +	 */
> +	if (has_acpi_companion(mux_dev))
> +		acpi_preset_companion(&priv->adap.dev, ACPI_COMPANION(mux_dev),
> +				      chan_id);
> +
>  	if (force_nr) {
>  		priv->adap.nr = force_nr;
>  		ret = i2c_add_numbered_adapter(&priv->adap);
> -- 
> 2.1.4
