From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 3/6] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Tue, 28 May 2019 09:37:59 +0100
Message-ID: <20190528083759.GE28362@ediswmail.ad.cirrus.com>
References: <20190527151932.14310-1-ckeepax@opensource.cirrus.com>
 <20190527151932.14310-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190527151932.14310-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, mika.westerberg@linux.intel.com
Cc: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 27, 2019 at 04:19:29PM +0100, Charles Keepax wrote:
> In preparation for future refactoring factor out the fetch of the IRQ
> into its own helper function.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  
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
> +
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	return irq;
> +}
> +

Sorry just noticed I forgot to add the kernel doc. Will fix that
up in the next spin, or do an incremental patch.

Thanks,
Charles
