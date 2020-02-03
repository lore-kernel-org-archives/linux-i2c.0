From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI / APD: Add clock frequency for Hisilicon
 Hip08-Lite I2C controller
Date: Mon, 3 Feb 2020 11:00:02 +0200
Message-ID: <b4f8eab1-a540-7011-4433-6a8133594ddf@linux.intel.com>
References: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1580693767-5185-1-git-send-email-guohanjun@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, Sheng Feng <fengsheng5@huawei.com>
List-Id: linux-i2c@vger.kernel.org

On 2/3/20 3:36 AM, Hanjun Guo wrote:
> I2C clock frequency of Designware ip for Hisilicon Hip08 Lite
> is 125M, use a new ACPI HID to enable it.
> 
> Tested-by: Sheng Feng <fengsheng5@huawei.com>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
> 
> v2:
>   - Reverse the order of the two patches suggested by Andy;
> 
>   drivers/acpi/acpi_apd.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
