From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 08:44:34 -0600
Message-ID: <567178D2.30002@amd.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216094202.GR1762@lahna.fi.intel.com> <56717100.3020602@amd.com>
 <20151216142810.GW1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-bl2on0054.outbound.protection.outlook.com ([65.55.169.54]:32000
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751758AbbLPOop (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 16 Dec 2015 09:44:45 -0500
In-Reply-To: <20151216142810.GW1762@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>



On 12/16/2015 08:28 AM, Mika Westerberg wrote:
> On Wed, Dec 16, 2015 at 08:11:12AM -0600, Suravee Suthikulpanit wrote:
>>> The clk framework should work fine if the returned clock is NULL (which
>>> I think is your case).
>>>
>>> The driver gates clocks when the device is suspended and on Intel LPSS
>>> there actually is a clock that gets gated.
>>>
>>>> [..]
>>>> @@ -203,13 +223,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>>>>   		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
>>>>   			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
>>>>
>>>> -	dev->clk = devm_clk_get(&pdev->dev, NULL);
>>>> -	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>>>> -	if (IS_ERR(dev->clk))
>>>> -		return PTR_ERR(dev->clk);
>>
>> Actually, if we don't provide the clock (which is the case for ACPI), this
>> would also return and cause the probing to fail.
>
> Indeed it seems that when you have CONFIG_COMMON_CLK selected the clock
> framework starts returning errors if the clock is not found.
>
> Since we need the clock for Intel LPSS I2C host controllers (and they
> may have *CNT methods), I think you just need to provide the clock for
> AMD I2C host controller in similar way than we do in
> drivers/acpi/acpi_lpss.c.

I am trying to avoid having to hard-coded clock frequency value in the 
driver. Would it be alright to not return w/ error, and just do the 
following?

	dev->clk = devm_clk_get(&pdev->dev, NULL);
	if (!IS_ERR(dev->clk))
		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;

This should work for the Intel case when clock is also provided.

Thanks,
Suravee
