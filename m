From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 08:11:12 -0600
Message-ID: <56717100.3020602@amd.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216094202.GR1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151216094202.GR1762@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: wsa@the-dreams.de, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi Mika,

On 12/16/2015 03:42 AM, Mika Westerberg wrote:
> +Jarkko and Andy
>
> On Tue, Dec 15, 2015 at 04:38:58PM -0600, Suravee Suthikulpanit wrote:
>> The current driver uses input clock source frequency to calculate
>> values for [SS|FS]_[HC|LC] registers. However, when booting ACPI, we do not
>> currently have a good way to provide the frequency information.
>> Instead, we can leverage the SSCN and FFCN ACPI methods, which can be used
>> to directly provide these values.
>>
>> So, this patch removes the clock requirement when SSCN and FFCN
>> are provided.
>
> Actually I think the only thing you need to change is i2c_dw_init() so
> that it does not call dev->get_clk_rate_khz(dev) if *CNT values are
> already provided.

Please see below.

>
> The clk framework should work fine if the returned clock is NULL (which
> I think is your case).
>
> The driver gates clocks when the device is suspended and on Intel LPSS
> there actually is a clock that gets gated.
>
>> [..]
>> @@ -203,13 +223,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>>   		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
>>   			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
>>
>> -	dev->clk = devm_clk_get(&pdev->dev, NULL);
>> -	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
>> -	if (IS_ERR(dev->clk))
>> -		return PTR_ERR(dev->clk);

Actually, if we don't provide the clock (which is the case for ACPI), 
this would also return and cause the probing to fail.

Thanks,
Suravee
