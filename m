From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 3/7] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Thu, 20 Jun 2019 17:54:32 +0300
Message-ID: <20190620145432.GD9224@smile.fi.intel.com>
References: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
 <20190620133420.4632-4-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190620133420.4632-4-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 20, 2019 at 02:34:16PM +0100, Charles Keepax wrote:
> In preparation for future refactoring factor out the fetch of the IRQ
> into its own helper function.

> +static int i2c_acpi_get_irq(struct acpi_device *adev)
> +{
> +	struct list_head resource_list;
> +	int irq = -ENOENT;
> +	int ret;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +
> +	ret = acpi_dev_get_resources(adev, &resource_list,
> +				     i2c_acpi_add_resource, &irq);
> +	if (ret < 0)

> +		return -EINVAL;

Can't we return ret value?

> +
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	return irq;
> +}

> +	ret = i2c_acpi_get_irq(adev);
> +	if (ret > 0)
> +		info->irq = ret;

And on error we do not bail out. This changes the behaviour.

-- 
With Best Regards,
Andy Shevchenko
