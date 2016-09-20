From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [REGRESSION? v4.8] i2c-core: acpi_i2c_get_info() touches
 non-existent devices
Date: Tue, 20 Sep 2016 10:55:43 +0300
Message-ID: <20160920075543.GL1811@lahna.fi.intel.com>
References: <87a8f4kfhe.fsf@gmail.com>
 <20160919084807.GC1811@lahna.fi.intel.com>
 <20160919130324.GI1811@lahna.fi.intel.com>
 <87fuowf0tf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fuowf0tf.fsf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Octavian Purdila <octavian.purdila@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 19, 2016 at 03:58:52PM +0200, Nicolai Stange wrote:
> > Can you try if the following patch cures the problem?
> 
> Unfortunately not. That patch installs the check after the
> acpi_i2c_get_info() invocation which is part of the backtrace above.

Ah, indeed it needs to happen before we parse resources.

> I moved your check into i2c_get_info(), right in front of the IRQ
> handling and this works.
> 
> So,
> 
>   Tested-by: Nicolai Stange <nicstange@gmail.com>

Thanks.

> for this:
> 
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 74e5aea..3f2b3cf 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -141,6 +141,7 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
>  	struct list_head resource_list;
>  	struct resource_entry *entry;
>  	struct acpi_i2c_lookup lookup;
> +	struct acpi_device *adapter_adev;
>  	int ret;
>  
>  	if (acpi_bus_get_status(adev) || !adev->status.present ||
> @@ -163,6 +164,12 @@ static int acpi_i2c_get_info(struct acpi_device *adev,
>  	if (ret < 0 || !info->addr)
>  		return -EINVAL;
>  
> +	/* The adapter must be present */
> +	if (acpi_bus_get_device(lookup.adapter_handle, &adapter_adev))
> +		return -EINVAL;
> +	if (acpi_bus_get_status(adapter_adev) || !adapter_adev->status.present)
> +		return -EINVAL;;
> +
>  	*adapter_handle = lookup.adapter_handle;
>  
>  	/* Then fill IRQ number if any */
> 
> 
> 
> But it is still true that acpi_i2c_register_devices() configures the
> interrupts for all ACPI I2C slaves attached to an available adapter,
> independent of whether their adapter is the one given as an argument or
> not. I can't tell whether this is desired, just a note...

You are right it should not do that. I'll send you an updated patch
shortly, can you try if it works?
