From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: acpi: Do not create i2c-clients for LNXVIDEO
 ACPI devices
Date: Tue, 04 Jul 2017 16:20:53 +0300
Message-ID: <1499174453.22624.253.camel@linux.intel.com>
References: <20170704130448.19064-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39921 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751641AbdGDNVC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 4 Jul 2017 09:21:02 -0400
In-Reply-To: <20170704130448.19064-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org

On Tue, 2017-07-04 at 15:04 +0200, Hans de Goede wrote:
> ACPI video devices get tagged by the kernel with the custom LNXVIDEO
> HID so that normal pnp-id matching can be used and are handled by the
> acpi-video driver.
> 
> Sometimes the ACPI nodes describing these contain a SERIAL_TYPE_I2C
> ACPI
> resource. Before this commit the presence of this resource would cause
> the
> i2c-core to create a /sys/bus/i2c/devices/i2c-LNXVIDEO:00 device for
> this
> with a modalias of: "i2c:LNXVIDEO:00".
> 
> There is no i2c driver for this custom HID, the acpi-video driver
> binds
> directly to the ACPI device /sys/bus/acpi/devices/LNXVIDEO\:00 which
> has
> a modalias of "acpi:LNXVIDEO:" .
> 
> Not only is the creation of an i2c-client for this undesirable, it is
> actually causing problems. This weird pseudo-resource claims an i2c
> speed of 100KHz and typically points to the i2c bus which is used by
> the
> touchscreen controller. Some touchscreen controllers only work
> properly at
> 400KHz, at 100KHz they cause errors like these:
> 
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> i2c_designware 80860F41:03: i2c_dw_handle_tx_abort: lost arbitration
> silead_ts i2c-MSSL1680:00: Registers clear error -11
> 
> This commit makes the i2c-core ignore LNXVIDEO compatible ACPI devices
> which has 2 positive results:
> 
> 1) The bogus i2c-client for these is no longer created.
> 2) i2c_acpi_lookup_speed now ignores the 100KHz speed from the pseudo
> i2c-resouce and properly returns 400KHz as speed for the touchscreen
> i2c bus, fixing the touchscreen not working on various devies.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Rebase on top of linux-i2c/for-next
> 
> Changes in v3:
> -Rename the acpi_device_id-s array to ignored_device_ids
> -Move the acpi_device_id-s array outside of i2c_acpi_do_lookup
> ---
>  drivers/i2c/i2c-core-acpi.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index 052005579ed6..4842ec3a5451 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -76,6 +76,15 @@ static int i2c_acpi_fill_info(struct acpi_resource
> *ares, void *data)
>  	return 1;
>  }
>  
> +static const struct acpi_device_id i2c_acpi_ignored_device_ids[] = {
> +	/*
> +	 * ACPI video acpi_devices, which are handled by the acpi-
> video driver
> +	 * sometimes contain a SERIAL_TYPE_I2C ACPI resource, ignore
> these.
> +	 */
> +	{ ACPI_VIDEO_HID, 0 },
> +	{}
> +};
> +
>  static int i2c_acpi_do_lookup(struct acpi_device *adev,
>  			      struct i2c_acpi_lookup *lookup)
>  {
> @@ -87,6 +96,9 @@ static int i2c_acpi_do_lookup(struct acpi_device
> *adev,
>  	    acpi_device_enumerated(adev))
>  		return -EINVAL;
>  
> +	if (acpi_match_device_ids(adev, i2c_acpi_ignored_device_ids)
> == 0)
> +		return -ENODEV;
> +
>  	memset(info, 0, sizeof(*info));
>  	lookup->device_handle = acpi_device_handle(adev);
>  

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
