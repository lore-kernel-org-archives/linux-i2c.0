From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH 1/2] ACPI / APD: Add clock frequency for Hisilicon
 Hip07/08 I2C controller
Date: Mon, 24 Apr 2017 19:51:28 +0800
Message-ID: <735385cf-6f64-9321-f8e5-1bffdf0708e1@huawei.com>
References: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-i2c@vger.kernel.org



On 2017/4/22 11:23, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> I2C clock frequency of Designware ip for Hisilicon Hip07 is 200M,
> but 250M for Hip08, use two ACPI IDs to differentiate them.

It is valuable to support i2c on hisilicon D0x board, Hip05/06/07 using same clock frequency,
it should have their own ACPI ID. For both two patches,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/acpi_apd.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
> index 26696b6..8f57648 100644
> --- a/drivers/acpi/acpi_apd.c
> +++ b/drivers/acpi/acpi_apd.c
> @@ -106,6 +106,16 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
>  	.setup = acpi_apd_setup,
>  	.fixed_clk_rate = 133000000,
>  };
> +
> +static const struct apd_device_desc hip07_i2c_desc = {
> +	.setup = acpi_apd_setup,
> +	.fixed_clk_rate = 200000000,
> +};
> +
> +static const struct apd_device_desc hip08_i2c_desc = {
> +	.setup = acpi_apd_setup,
> +	.fixed_clk_rate = 250000000,
> +};
>  #endif
>  
>  #else
> @@ -169,6 +179,8 @@ static int acpi_apd_create_device(struct acpi_device *adev,
>  #ifdef CONFIG_ARM64
>  	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
>  	{ "BRCM900D", APD_ADDR(vulcan_spi_desc) },
> +	{ "HISI0A21", APD_ADDR(hip07_i2c_desc) },
> +	{ "HISI0A22", APD_ADDR(hip08_i2c_desc) },
>  #endif
>  	{ }
>  };
> 
