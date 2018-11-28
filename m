From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v5 14/15] ACPI / scan: Create platform device for INT3515
 ACPI nodes
Date: Wed, 28 Nov 2018 14:07:21 +0200
Message-ID: <20181128120721.GB32679@kuha.fi.intel.com>
References: <20181128114535.80223-1-andriy.shevchenko@linux.intel.com>
 <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181128114535.80223-15-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 28, 2018 at 01:45:34PM +0200, Andy Shevchenko wrote:
> The ACPI device with INT3515 _HID is representing a complex USB PD
> hardware infrastructure which includes several I2C slave ICs.
> 
> We add an ID to the I2C multi instantiate list to enumerate
> all I2C slaves correctly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/acpi/scan.c                          | 1 +
>  drivers/platform/x86/i2c-multi-instantiate.c | 9 +++++++++
>  drivers/usb/typec/tps6598x.c                 | 8 ++++----
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index bd1c59fb0e17..e9eda5558c1f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1541,6 +1541,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
>  		{"BSG1160", },
>  		{"INT33FE", },
> +		{"INT3515", },
>  		{}
>  	};
>  
> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> index 2439d4c71118..3d893e0ac250 100644
> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> @@ -159,12 +159,21 @@ static const struct i2c_inst_data bsg1160_data[]  = {
>  	{}
>  };
>  
> +static const struct i2c_inst_data int3515_data[]  = {
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 0 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 1 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 2 },
> +	{ "tps6598x", IRQ_RESOURCE_APIC, 3 },
> +	{}
> +};
> +
>  /*
>   * Note new device-ids must also be added to i2c_multi_instantiate_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
>   */
>  static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)bsg1160_data },
> +	{ "INT3515", (unsigned long)int3515_data },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, i2c_multi_inst_acpi_ids);
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index c84c8c189e90..1c0033ad8738 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -501,19 +501,19 @@ static int tps6598x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static const struct acpi_device_id tps6598x_acpi_match[] = {
> -	{ "INT3515", 0 },
> +static const struct i2c_device_id tps6598x_id[] = {
> +	{ "tps6598x" },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(acpi, tps6598x_acpi_match);
> +MODULE_DEVICE_TABLE(i2c, tps6598x_id);
>  
>  static struct i2c_driver tps6598x_i2c_driver = {
>  	.driver = {
>  		.name = "tps6598x",
> -		.acpi_match_table = tps6598x_acpi_match,
>  	},
>  	.probe_new = tps6598x_probe,
>  	.remove = tps6598x_remove,
> +	.id_table = tps6598x_id,
>  };
>  module_i2c_driver(tps6598x_i2c_driver);
>  
> -- 
> 2.19.2

-- 
heikki
