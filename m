From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/2] i2c: designware: Some broken DSTDs use 1MiHz
 instead of 1MHz
Date: Sun, 16 Jul 2017 17:04:18 +0300
Message-ID: <1500213858.29303.20.camel@linux.intel.com>
References: <20170713134502.10816-1-hdegoede@redhat.com>
         <20170713134502.10816-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170713134502.10816-2-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-07-13 at 15:45 +0200, Hans de Goede wrote:
> At least the Acer Iconia Tab8 / aka W1-810 uses 1MiHz instead of
> 1MHz for one of its busses, fix this up to 1MHz instead of failing
> the probe of that bus.
> 
> This fixes the accelerometer on the Acer Iconia Tab8 not working.
> 

Should it have a Fixes tag?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(on condition Jarkko and Wolfram are okay with this; in the future it
would be better to have a list of possible speeds and algo that chooses
one based on FW configuration)

> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d139b156f9c9..143a8fd582b4 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -298,6 +298,9 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	}
>  
>  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> +	/* Some broken DSTDs use 1MiHz instead of 1MHz */
> +	if (acpi_speed == 1048576)
> +		acpi_speed = 1000000;
>  	/*
>  	 * Find bus speed from the "clock-frequency" device property,
> ACPI
>  	 * or by using fast mode if neither is set.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
