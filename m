From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/7] i2c: acpi: Use available IRQ helper functions
Date: Tue, 11 Jun 2019 15:47:01 +0300
Message-ID: <20190611124701.GU9224@smile.fi.intel.com>
References: <20190611123101.25264-1-ckeepax@opensource.cirrus.com>
 <20190611123101.25264-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611123101.25264-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 11, 2019 at 01:30:56PM +0100, Charles Keepax wrote:
> Use the available IRQ helper functions, most of the functions have
> additional helpful side affects like configuring the trigger type of the
> IRQ.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v3.
> 
> Apologies Andy but I really can't see a sensible way to split this
> patch up. I have tried moving the resource_list_for_each_loop
> into a function in one patch then switching to using
> acpi_dev_resource_interrupt and i2c_dev_irq_from_resource, but the
> function is basically a completely different function ie. all the
> arguments are different and the purpose is different. So it makes
> no sense, and it is very ping pong. I tried doing the switch to
> i2c_dev_irq_from_resources as a separate patch which isn't so bad,
> but feels pointless as it is such a small change, let me know if you
> really want me to send that version.
> 
> Basically the switch to the helper function and the use of
> acpi_dev_resource_interrupt are intrinsically linked, so there isn't
> really a sensible way to split those up. If you still want some
> changes I am afraid you will have to be more specific in what you are
> looking for.

It seems I missed few details, thus the current approach works for me, thanks!

> 
> Thanks,
> Charles
> 
>  drivers/i2c/i2c-core-acpi.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
> index f1d648962b223..47d5b1c5ec9e0 100644
> --- a/drivers/i2c/i2c-core-acpi.c
> +++ b/drivers/i2c/i2c-core-acpi.c
> @@ -133,14 +133,25 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
>  	return 0;
>  }
>  
> +static int i2c_acpi_add_resource(struct acpi_resource *ares, void *data)
> +{
> +	int *irq = data;
> +	struct resource r;
> +
> +	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
> +		*irq = i2c_dev_irq_from_resources(&r, 1);
> +
> +	return 1; /* No need to add resource to the list */
> +}
> +
>  static int i2c_acpi_get_info(struct acpi_device *adev,
>  			     struct i2c_board_info *info,
>  			     struct i2c_adapter *adapter,
>  			     acpi_handle *adapter_handle)
>  {
>  	struct list_head resource_list;
> -	struct resource_entry *entry;
>  	struct i2c_acpi_lookup lookup;
> +	int irq = -ENOENT;
>  	int ret;
>  
>  	memset(&lookup, 0, sizeof(lookup));
> @@ -172,16 +183,13 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
>  
>  	/* Then fill IRQ number if any */
>  	INIT_LIST_HEAD(&resource_list);
> -	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> +	ret = acpi_dev_get_resources(adev, &resource_list,
> +				     i2c_acpi_add_resource, &irq);
>  	if (ret < 0)
>  		return -EINVAL;
>  
> -	resource_list_for_each_entry(entry, &resource_list) {
> -		if (resource_type(entry->res) == IORESOURCE_IRQ) {
> -			info->irq = entry->res->start;
> -			break;
> -		}
> -	}
> +	if (irq > 0)
> +		info->irq = irq;
>  
>  	acpi_dev_free_resource_list(&resource_list);
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko
