From: "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Subject: Re: [PATCH v1 05/40] i2c: amd-mp2: Use generic definitions for bus
 frequencies
Date: Thu, 27 Feb 2020 10:36:28 +0530
Message-ID: <1a1aed47-80c6-6de7-16af-4b14adea9c46@amd.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr750083.outbound.protection.outlook.com ([40.107.75.83]:2054
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgB0FGn (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 27 Feb 2020 00:06:43 -0500
In-Reply-To: <20200224151530.31713-5-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Elie Morisse <syniurge@gmail.com>, Shyam Sundar S K <shyam-sundar.s-k@amd.com>

Hi

On 2/24/2020 8:44 PM, Andy Shevchenko wrote:
> Since we have generic definitions for bus frequencies, let's use them.
>
> Cc: Elie Morisse <syniurge@gmail.com>
> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-amd-mp2-plat.c | 27 ++++++++++++++++-----------
>  include/linux/i2c.h                   |  2 ++
>  2 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-amd-mp2-plat.c b/drivers/i2c/busses/i2c-amd-mp2-plat.c
> index f5b3f00c6559..9b9d90b98a05 100644
> --- a/drivers/i2c/busses/i2c-amd-mp2-plat.c
> +++ b/drivers/i2c/busses/i2c-amd-mp2-plat.c
> @@ -201,32 +201,37 @@ static int i2c_amd_resume(struct amd_i2c_common *i2c_common)
>  }
>  #endif
>  
> +static const u32 supported_speeds[] = {
> +	I2C_HIGH_SPEED_MODE_FREQ,
> +	I2C_TURBO_MODE_FREQ,
> +	I2C_FAST_MODE_PLUS_FREQ,
> +	I2C_FAST_MODE_FREQ,
> +	I2C_STANDARD_MODE_FREQ,
> +};
> +
>  static enum speed_enum i2c_amd_get_bus_speed(struct platform_device *pdev)
>  {
>  	u32 acpi_speed;
>  	int i;
> -	static const u32 supported_speeds[] = {
> -		0, 100000, 400000, 1000000, 1400000, 3400000
> -	};
>  
>  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
>  	/* round down to the lowest standard speed */
> -	for (i = 1; i < ARRAY_SIZE(supported_speeds); i++) {
> -		if (acpi_speed < supported_speeds[i])
> +	for (i = 0; i < ARRAY_SIZE(supported_speeds); i++) {
> +		if (acpi_speed >= supported_speeds[i])
>  			break;
>  	}
> -	acpi_speed = supported_speeds[i - 1];
> +	acpi_speed = i < ARRAY_SIZE(supported_speeds) ? supported_speeds[i] : 0;
>  
>  	switch (acpi_speed) {
> -	case 100000:
> +	case I2C_STANDARD_MODE_FREQ:
>  		return speed100k;
> -	case 400000:
> +	case I2C_FAST_MODE_FREQ:
>  		return speed400k;
> -	case 1000000:
> +	case I2C_FAST_MODE_PLUS_FREQ:
>  		return speed1000k;
> -	case 1400000:
> +	case I2C_TURBO_MODE_FREQ:
>  		return speed1400k;
> -	case 3400000:
> +	case I2C_HIGH_SPEED_MODE_FREQ:
>  		return speed3400k;
>  	default:
>  		return speed400k;
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 1b9c483bd9f5..d3022a014227 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -46,6 +46,8 @@ typedef int (*i2c_slave_cb_t)(struct i2c_client *client,
>  #define I2C_STANDARD_MODE_FREQ		(100 * HZ_PER_KHZ)
>  #define I2C_FAST_MODE_FREQ		(400 * HZ_PER_KHZ)
>  #define I2C_FAST_MODE_PLUS_FREQ		(1000 * HZ_PER_KHZ)
> +#define I2C_TURBO_MODE_FREQ		(1400 * HZ_PER_KHZ)
> +#define I2C_HIGH_SPEED_MODE_FREQ	(3400 * HZ_PER_KHZ)
>  
>  struct module;
>  struct property_entry;

Fine for me.

Acked-by: Nehal Shah <nehal-bakulchandra.shah@amd.com>


Thanks

Nehal Shah
