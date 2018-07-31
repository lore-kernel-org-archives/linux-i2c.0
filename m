From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] i2c: designware: move #ifdef CONFIG_OF to the top
Date: Tue, 31 Jul 2018 17:04:31 +0300
Message-ID: <e9c70e9265587b69c07629dfdfd2ea041c70acae.camel@linux.intel.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-3-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731134740.441-3-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> Move the #ifdef CONFIG_OF section to the top of the file, after the
> ACPI
> section so functions defined there can be used in dw_i2c_plat_probe.
> 

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 00bf62f77c47..ba142d7c0e05 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -157,6 +157,14 @@ static inline int dw_i2c_acpi_configure(struct
> platform_device *pdev)
>  }
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id dw_i2c_of_match[] = {
> +	{ .compatible = "snps,designware-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> +#endif
> +
>  static void i2c_dw_configure_master(struct dw_i2c_dev *dev)
>  {
>  	struct i2c_timings *t = &dev->timings;
> @@ -391,14 +399,6 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id dw_i2c_of_match[] = {
> -	{ .compatible = "snps,designware-i2c", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, dw_i2c_of_match);
> -#endif
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int dw_i2c_plat_prepare(struct device *dev)
>  {

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
