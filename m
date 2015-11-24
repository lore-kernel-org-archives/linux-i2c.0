From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 13/13] i2c: designware: Convert to use unified device
 property API
Date: Tue, 24 Nov 2015 12:53:06 +0200
Message-ID: <56544192.1030708@linux.intel.com>
References: <1448360579-79260-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1448360579-79260-14-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1448360579-79260-14-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On 11/24/2015 12:22 PM, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> With ACPI _DSD (introduced in ACPI v5.1) it is now possible to pass device
> configuration information from ACPI in addition to DT. In order to support
> this, convert the driver to use the unified device property accessors
> instead of DT specific.
>
> Change to ordering a bit so that we first try platform data and if that's
> not available look from device properties. ACPI *CNT methods are then used
> as last resort to override everything else.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 48 +++++++++++++----------------
>   1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 809579e..e9062be 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -36,6 +36,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm.h>
>   #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>   #include <linux/io.h>
>   #include <linux/slab.h>
>   #include <linux/acpi.h>
> @@ -156,33 +157,28 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>   	/* fast mode by default because of legacy reasons */
>   	clk_freq = 400000;
>
> -	if (has_acpi_companion(&pdev->dev)) {
> -		dw_i2c_acpi_configure(pdev);
> -	} else if (pdev->dev.of_node) {
> -		of_property_read_u32(pdev->dev.of_node,
> -					"i2c-sda-hold-time-ns", &ht);
> -
> -		of_property_read_u32(pdev->dev.of_node,
> -				     "i2c-sda-falling-time-ns",
> -				     &dev->sda_falling_time);
> -		of_property_read_u32(pdev->dev.of_node,
> -				     "i2c-scl-falling-time-ns",
> -				     &dev->scl_falling_time);
> -
> -		of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> -				     &clk_freq);
> -
> -		/* Only standard mode at 100kHz and fast mode at 400kHz
> -		 * are supported.
> -		 */
> -		if (clk_freq != 100000 && clk_freq != 400000) {
> -			dev_err(&pdev->dev, "Only 100kHz and 400kHz supported");
> -			return -EINVAL;
> -		}
> +	if ((pdata = dev_get_platdata(&pdev->dev))) {
> +		clk_freq = pdata->i2c_scl_freq;
>   	} else {
> -		pdata = dev_get_platdata(&pdev->dev);
> -		if (pdata)
> -			clk_freq = pdata->i2c_scl_freq;
> +		device_property_read_u32(&pdev->dev, "i2c-sda-hold-time-ns",
> +					 &ht);
> +		device_property_read_u32(&pdev->dev, "i2c-sda-falling-time-ns",
> +					 &dev->sda_falling_time);
> +		device_property_read_u32(&pdev->dev, "i2c-scl-falling-time-ns",
> +					 &dev->scl_falling_time);
> +		device_property_read_u32(&pdev->dev, "clock-frequency",
> +					 &clk_freq);

Mika, Andy: Was this one able to go separately? At least it builds 
without rest of the set but is there anything that could break DT based 
system if there are no patches 1-8/13?

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
