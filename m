From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Some broken DSTDs use 1MiHz
 instead of 1MHz
Date: Sat, 08 Jul 2017 16:55:54 +0300
Message-ID: <1499522154.22624.307.camel@linux.intel.com>
References: <20170708131052.13524-1-hdegoede@redhat.com>
         <20170708131052.13524-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22607 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdGHODh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 8 Jul 2017 10:03:37 -0400
In-Reply-To: <20170708131052.13524-2-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, stable@vger.kernel.org

On Sat, 2017-07-08 at 15:10 +0200, Hans de Goede wrote:
> At least the Acer Iconia Tab8 / aka W1-810 uses 1MiHz instead of
> 1MHz for one of its busses, fix this up to 1MHz instead of failing
> the probe of that bus.
> 
> This fixes the accelerometer on the Acer Iconia Tab8 not working.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d5acaf8d65bf..c6f5a41d72b5 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -254,6 +254,9 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	}
>  
>  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> +	/* Some broken DSTDs use 1MiHz instead of 1MHz */
> +	if (acpi_speed == 1048576)
> +		acpi_speed = 1000000;

I would rather convert to choose closest one, though I am not sure at
all which approach would be better in long term.

>  	/*
>  	 * Find bus speed from the "clock-frequency" device property,
> ACPI
>  	 * or by using fast mode if neither is set.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
