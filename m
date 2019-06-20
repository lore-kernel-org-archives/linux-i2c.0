From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 2/7] i2c: acpi: Use available IRQ helper functions
Date: Thu, 20 Jun 2019 17:52:21 +0300
Message-ID: <20190620145221.GC9224@smile.fi.intel.com>
References: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
 <20190620133420.4632-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190620133420.4632-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 20, 2019 at 02:34:15PM +0100, Charles Keepax wrote:
> Use the available IRQ helper functions, most of the functions have
> additional helpful side affects like configuring the trigger type of the
> IRQ.
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Some last minute observations / questions.

> +	struct resource r;
> +
> +	if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
> +		*irq = i2c_dev_irq_from_resources(&r, 1);
> +
> +	return 1; /* No need to add resource to the list */

If we don't add it to the list, do we still need to manage the empty
resource_list below?

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

Hmm... can't we just assign it directly inside the _add_resource() call back as
original code did?

-- 
With Best Regards,
Andy Shevchenko
