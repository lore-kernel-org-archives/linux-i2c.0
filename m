From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 4/7] i2c: core: Make i2c_acpi_get_irq available to the
 rest of the I2C core
Date: Fri, 21 Jun 2019 15:24:06 +0300
Message-ID: <20190621122406.GL9224@smile.fi.intel.com>
References: <20190621100815.12417-1-ckeepax@opensource.cirrus.com>
 <20190621100815.12417-5-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621100815.12417-5-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jbroadus@gmail.com, patches@opensource.cirrus.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Jun 21, 2019 at 11:08:12AM +0100, Charles Keepax wrote:
> In preparation for more refactoring make i2c_acpi_get_irq available
> outside i2c-core-acpi.c.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v5:
>  - Pass a struct device rather than acpi_device to i2c_acpi_get_irq,
>    note this is more awkward than I would have liked as I am very
>    unconvinced that adev->dev can actually be passed to
>    ACPI_COMPANION. If anyone can answer that for sure that would be
>    very helpful.

Sounds you are right. I stand corrected.
We can not use ACPI_COMPANION() against &adev->dev.

-- 
With Best Regards,
Andy Shevchenko
