From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 3/6] i2c: acpi: Factor out getting the IRQ from ACPI
Date: Tue, 28 May 2019 13:35:38 +0300
Message-ID: <20190528103538.GC2781@lahna.fi.intel.com>
References: <20190527151932.14310-1-ckeepax@opensource.cirrus.com>
 <20190527151932.14310-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190527151932.14310-3-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Mon, May 27, 2019 at 04:19:29PM +0100, Charles Keepax wrote:
>  static int i2c_acpi_get_info(struct acpi_device *adev,
>  			     struct i2c_board_info *info,
>  			     struct i2c_adapter *adapter,
>  			     acpi_handle *adapter_handle)
>  {
> -	struct list_head resource_list;
>  	struct i2c_acpi_lookup lookup;
> -	int irq = -ENOENT;
>  	int ret;
>  
>  	memset(&lookup, 0, sizeof(lookup));
> @@ -186,16 +202,9 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
>  		*adapter_handle = lookup.adapter_handle;
>  
>  	/* Then fill IRQ number if any */
> -	INIT_LIST_HEAD(&resource_list);
> -	ret = acpi_dev_get_resources(adev, &resource_list,
> -				     i2c_acpi_add_resource, &irq);
> -	if (ret < 0)
> -		return -EINVAL;
> -
> -	if (irq >= 0)
> -		info->irq = irq;
> -
> -	acpi_dev_free_resource_list(&resource_list);
> +	ret = i2c_acpi_get_irq(adev);
> +	if (ret >= 0)

Same comment here regarding irq == 0.
