From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Thu, 20 Jun 2019 17:59:50 +0300
Message-ID: <20190620145950.GE9224@smile.fi.intel.com>
References: <20190620133420.4632-1-ckeepax@opensource.cirrus.com>
 <20190620133420.4632-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190620133420.4632-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 20, 2019 at 02:34:17PM +0100, Charles Keepax wrote:
> In preparation for more refactoring make i2c_acpi_get_irq available
> outside i2c-core-acpi.c.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I'm not sure Rb tags are suitable for patches 4 and 5 since the changes made.

> +struct acpi_device;

Hmm... Doesn't acpi.h define that for !ACPI case?

>  #ifdef CONFIG_ACPI
>  const struct acpi_device_id *
>  i2c_acpi_match_device(const struct acpi_device_id *matches,
>  		      struct i2c_client *client);
>  void i2c_acpi_register_devices(struct i2c_adapter *adap);
> +
> +int i2c_acpi_get_irq(struct acpi_device *adev);

Since you call this afterwards with struct device from which companion is
derived, can't we directly use struct device as a parameter?

Yes, in case of adev call, it might be &adev->dev I suppose?

-- 
With Best Regards,
Andy Shevchenko
