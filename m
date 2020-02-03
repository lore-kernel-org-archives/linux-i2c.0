From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/2] i2c: designware: Add ACPI HID for Hisilicon
 Hip08-Lite I2C controller
Date: Mon, 3 Feb 2020 11:01:02 +0200
Message-ID: <4e1889bd-39e0-9b87-9f47-e460a782ee09@linux.intel.com>
References: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
 <1580693767-5185-2-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1580693767-5185-2-git-send-email-guohanjun@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Sheng Feng <fengsheng5@huawei.com>
List-Id: linux-i2c@vger.kernel.org

On 2/3/20 3:36 AM, Hanjun Guo wrote:
> Add ACPI HID HISI02A3 for Hisilicon Hip08 Lite, which has different
> clock frequency from Hip08 for I2C controller.
> 
> Tested-by: Sheng Feng <fengsheng5@huawei.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>   drivers/i2c/busses/i2c-designware-platdrv.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 16dd338..3b7d58c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -130,6 +130,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>   	{ "APMC0D0F", 0 },
>   	{ "HISI02A1", 0 },
>   	{ "HISI02A2", 0 },
> +	{ "HISI02A3", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, dw_i2c_acpi_match);
> -- 

Acked-by: Nikula <jarkko.nikula@linux.intel.com>
