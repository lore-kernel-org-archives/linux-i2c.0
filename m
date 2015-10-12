From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] i2c: scan entire ACPI namespace for I2C connections
Date: Mon, 12 Oct 2015 13:46:49 +0300
Message-ID: <20151012104649.GW1506@lahna.fi.intel.com>
References: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-1-git-send-email-dustin@cumulusnetworks.com>
 <1444437707-19027-2-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:10811 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbbJLKqx (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 12 Oct 2015 06:46:53 -0400
Content-Disposition: inline
In-Reply-To: <1444437707-19027-2-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Fri, Oct 09, 2015 at 05:41:46PM -0700, Dustin Byford wrote:
> An I2cSerialBus connection resource descriptor may indicate a
> ResourceSource (a string uniquely identifying the I2C bus controller)
> anywhere in the ACPI namespace.  However, when enumerating connections to a
> I2C bus controller, i2c-core.c:acpi_i2c_register_devices() as only
> searching devices that are descendants of the bus controller.
> 
> This change corrects acpi_i2c_register_devices() to walk the entire ACPI
> namespace searching for I2C connections.
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>

This patch is already included in Andy's latest series adding support
for Intel Galileo here:

https://patchwork.ozlabs.org/patch/527231/

Maybe we can add your Tested-by/Reviewed-by to that patch instead?

> ---
>  drivers/i2c/i2c-core.c | 82 ++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 59 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 5f89f1e..3a4c54e 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -99,27 +99,40 @@ struct gsb_buffer {
>  	};
>  } __packed;
>  
> -static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
> +struct acpi_i2c_lookup {
> +	struct i2c_board_info *info;
> +	acpi_handle adapter_handle;
> +	acpi_handle device_handle;
> +};
> +
> +static int acpi_i2c_find_address(struct acpi_resource *ares, void *data)
>  {
> -	struct i2c_board_info *info = data;
> +	struct acpi_i2c_lookup *lookup = data;
> +	struct i2c_board_info *info = lookup->info;
> +	struct acpi_resource_i2c_serialbus *sb;
> +	acpi_handle adapter_handle;
> +	acpi_status status;
>  
> -	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		struct acpi_resource_i2c_serialbus *sb;
> +	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return 1;
>  
> -		sb = &ares->data.i2c_serial_bus;
> -		if (!info->addr && sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> -			info->addr = sb->slave_address;
> -			if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> -				info->flags |= I2C_CLIENT_TEN;
> -		}
> -	} else if (!info->irq) {
> -		struct resource r;
> +	sb = &ares->data.i2c_serial_bus;
> +	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return 1;
>  
> -		if (acpi_dev_resource_interrupt(ares, 0, &r))
> -			info->irq = r.start;
> +	/*
> +	 * Extract the ResourceSource and make sure that the handle matches
> +	 * with the I2C adapter handle.
> +	 */
> +	status = acpi_get_handle(lookup->device_handle,
> +				 sb->resource_source.string_ptr,
> +				 &adapter_handle);
> +	if (ACPI_SUCCESS(status) && adapter_handle == lookup->adapter_handle) {
> +		info->addr = sb->slave_address;
> +		if (sb->access_mode == ACPI_I2C_10BIT_MODE)
> +			info->flags |= I2C_CLIENT_TEN;
>  	}
>  
> -	/* Tell the ACPI core to skip this resource */
>  	return 1;
>  }
>  
> @@ -128,6 +141,8 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  {
>  	struct i2c_adapter *adapter = data;
>  	struct list_head resource_list;
> +	struct acpi_i2c_lookup lookup;
> +	struct resource_entry *entry;
>  	struct i2c_board_info info;
>  	struct acpi_device *adev;
>  	int ret;
> @@ -140,14 +155,37 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  	memset(&info, 0, sizeof(info));
>  	info.fwnode = acpi_fwnode_handle(adev);
>  
> +	memset(&lookup, 0, sizeof(lookup));
> +	lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
> +	lookup.device_handle = handle;
> +	lookup.info = &info;
> +
> +	/*
> +	 * Look up for I2cSerialBus resource with ResourceSource that
> +	 * matches with this adapter.
> +	 */
>  	INIT_LIST_HEAD(&resource_list);
>  	ret = acpi_dev_get_resources(adev, &resource_list,
> -				     acpi_i2c_add_resource, &info);
> +				     acpi_i2c_find_address, &lookup);
>  	acpi_dev_free_resource_list(&resource_list);
>  
>  	if (ret < 0 || !info.addr)
>  		return AE_OK;
>  
> +	/* Then fill IRQ number if any */
> +	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +	if (ret < 0)
> +		return AE_OK;
> +
> +	resource_list_for_each_entry(entry, &resource_list) {
> +		if (resource_type(entry->res) == IORESOURCE_IRQ) {
> +			info.irq = entry->res->start;
> +			break;
> +		}
> +	}
> +
> +	acpi_dev_free_resource_list(&resource_list);
> +
>  	adev->power.flags.ignore_parent = true;
>  	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
>  	if (!i2c_new_device(adapter, &info)) {
> @@ -160,6 +198,8 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>  	return AE_OK;
>  }
>  
> +#define ACPI_I2C_MAX_SCAN_DEPTH 32
> +
>  /**
>   * acpi_i2c_register_devices - enumerate I2C slave devices behind adapter
>   * @adap: pointer to adapter
> @@ -170,17 +210,13 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
>   */
>  static void acpi_i2c_register_devices(struct i2c_adapter *adap)
>  {
> -	acpi_handle handle;
>  	acpi_status status;
>  
> -	if (!adap->dev.parent)
> -		return;
> -
> -	handle = ACPI_HANDLE(adap->dev.parent);
> -	if (!handle)
> +	if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
>  		return;
>  
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +				     ACPI_I2C_MAX_SCAN_DEPTH,
>  				     acpi_i2c_add_device, NULL,
>  				     adap, NULL);
>  	if (ACPI_FAILURE(status))
> -- 
> 2.1.4
