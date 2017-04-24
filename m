From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add ACPI HID for Hisilicon Hip07/08
 I2C controller
Date: Mon, 24 Apr 2017 12:34:40 +0300
Message-ID: <2cb57c38-e480-06d5-2f5d-1db2a8d75c00@linux.intel.com>
References: <1492831424-40581-1-git-send-email-guohanjun@huawei.com>
 <1492831424-40581-2-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28729 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168031AbdDXJg5 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Apr 2017 05:36:57 -0400
In-Reply-To: <1492831424-40581-2-git-send-email-guohanjun@huawei.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linuxarm@huawei.com, wangkefeng.wang@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

On 04/22/2017 06:23 AM, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> Add ACPI HID HISI02A1 and HISI02A2 for Hisilicon Hip07/08,
> which have different clock frequency.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 79c4b4e..90c7c10 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -129,6 +129,8 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>  	{ "AMDI0010", ACCESS_INTR_MASK },
>  	{ "AMDI0510", 0 },
>  	{ "APMC0D0F", 0 },
> +	{ "HISI02A1", 0 },
> +	{ "HISI02A2", 0 },
>  	{ }

Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
