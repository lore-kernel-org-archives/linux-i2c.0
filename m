From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2] i2c: designwear: Fix clk warning on suspend/resume
Date: Thu, 2 Mar 2017 15:39:49 -0800
Message-ID: <CALAqxLUBBZOPvZ_Lu2X5ygoorubKdRW3GHzv41WHdOJf-z4PZA@mail.gmail.com>
References: <1487045142-1434-1-git-send-email-john.stultz@linaro.org> <e0c3968e-cff1-5cc7-9c42-1c3858e76077@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:32780 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdCBXsf (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Mar 2017 18:48:35 -0500
Received: by mail-wr0-f174.google.com with SMTP id u48so63431686wrc.0
        for <linux-i2c@vger.kernel.org>; Thu, 02 Mar 2017 15:47:00 -0800 (PST)
In-Reply-To: <e0c3968e-cff1-5cc7-9c42-1c3858e76077@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Tue, Feb 14, 2017 at 7:30 AM, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
> On 14.02.2017 06:05, John Stultz wrote:
>>
>> On my HiKey board, I'm seeing clk warnings on suspend/resume,
>> which seem to be caused by runtime pm suspending the device,
>> then the same suspend hook being called again on suspend time.
>>
>> This patch fixes this by setting the SYSTEM_SLEEP_PM_OPS to
>> using pm_runtime_force_suspend and  pm_runtime_force_resume.
>>
>> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-i2c@vger.kernel.org
>> Suggested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>> ---
>> v2: Switch to suggested fix by Jarkko.
>>
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 6ce4313..09f27ec 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -362,7 +362,7 @@ static int dw_i2c_plat_resume(struct device *dev)
>>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>>         .prepare = dw_i2c_plat_prepare,
>>         .complete = dw_i2c_plat_complete,
>> -       SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> pm_runtime_force_resume)
>>         SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>>  };
>
>
> We need to hold this a bit. I've been debugging this on our platforms but
> haven't figured out yet how to fix a regression it is causing with
> drivers/acpi/acpi_lpss.c :-(
>
> With this change in i2c-designware-platdrv.c the suspend path in acpi_lpss.c
> changes. First it saves its the register context in
> acpi_lpss_runtime_suspend() and powers down. Then the device which is now
> off will save again the register context (now reads full of 0xff...) in
> acpi_lpss_suspend_late() and restores wrong context (0xff...) when resuming.

Hey,
  Just wanted to follow up to see if any progress was made on this
issue? Anything you need from me?

thanks
-john
