From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/5] i2c: core: Move ACPI gpio IRQ handling into
 i2c_acpi_get_irq
Date: Tue, 21 May 2019 20:27:26 +0300
Message-ID: <20190521172726.GO9224@smile.fi.intel.com>
References: <20190521150502.27305-1-ckeepax@opensource.cirrus.com>
 <20190521150502.27305-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190521150502.27305-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Tue, May 21, 2019 at 04:05:01PM +0100, Charles Keepax wrote:
> It makes sense to contain all the ACPI IRQ handling in a single helper
> function.

> Note that this one is somewhat interesting, it seems the search
> through the resource list is done against the companion device
> of the adapter but the GPIO search is done against the companion
> device of the client. It feels to me like these really should
> be done on the same device, and certainly this is what SPI
> does (both against the equivalent of the adapter). Perhaps
> someone with more ACPI knowledge than myself could comment?

It would be interesting to see the path how you come to this conclusion.

>  	acpi_dev_free_resource_list(&resource_list);
>  
> +	if (*irq < 0)
> +		*irq = acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);

I think adev here is what we may use here.

You may put assert here and see if it happens when you test your series.

-- 
With Best Regards,
Andy Shevchenko
