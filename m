From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/10] i2c: designware-platdrv: Gate clk in error path in ->probe()
Date: Mon, 20 Jun 2016 06:41:03 +0200
Message-ID: <CAPDyKFrB8sjK_3DVLFouE1LCLXZ6sk16XzqVZM+7bRuQ=Gsuww@mail.gmail.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org> <1465917768.30123.65.camel@linux.intel.com>
 <CAPDyKFpqR5a+b68wMmyY086OCmkiK9mvC-kcav8Q2x28z=0ONA@mail.gmail.com> <0b2b63b3-6c66-fba2-028d-ab366b9df1af@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35708 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcFTElL (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 20 Jun 2016 00:41:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id v199so52961907wmv.0
        for <linux-i2c@vger.kernel.org>; Sun, 19 Jun 2016 21:41:05 -0700 (PDT)
In-Reply-To: <0b2b63b3-6c66-fba2-028d-ab366b9df1af@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 15 June 2016 at 14:07, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
> On 06/15/2016 10:16 AM, Ulf Hansson wrote:
>>
>> On 14 June 2016 at 17:22, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>>
>>> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>>>>
>>>> The call to i2c_dw_probe() may fail in ->probe() in which case the
>>>> clock
>>>> remains ungated. Fix the error path by gating the clock before the
>>>> error
>>>> code is returned.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> ---
>>>>  drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> index e39962b..19174e7 100644
>>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>>> @@ -235,6 +235,7 @@ static int dw_i2c_plat_probe(struct
>>>> platform_device *pdev)
>>>>       ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>>>>       adap->dev.of_node = pdev->dev.of_node;
>>>>
>>>
>>>
>>>> +     pm_runtime_get_noresume(&pdev->dev);
>>>
>>>
>>>> +     pm_runtime_put(&pdev->dev);
>>>
>>>
>>> I don't see an explanation of these add-ons.
>>
>>
>> As we explicitly do clk_disable_unprepare() in the error path, we must
>> prevent the ->runtime_suspend() callback to be called during this
>> period.
>>
>> This is a common pattern used by many drivers deploying runtime PM
>> support, which is probably why I left out the explanation.
>>
> What would cause here runtime suspend during probe? Also pairing

In practice this might not happen, although in theory it could...

The struct device is accessible by others than the driver (userspace
through sysfs for example). So, if "someone" would invoke
pm_runtime_suspend() (or a similar runtime PM API) for the device,
that would cause the ->runtime_suspend() callback to be invoked within
this period.

I suggest we just make sure to protect from this to happen.

> pm_runtime_get_noresume() with pm_runtime_put() instead of
> pm_runtime_put_noidle() looks suspicious to me.
>

It's not a problem. There's two cases here:

*) Runtime PM is enabled.
In this case the pm_runtime_put() will decrease the runtime PM usage
count and likely cause the device to be runtime suspended. Earlier,
the similar would happen as the driver core do a pm_request_idle()
when the ->probe() has completed.

**) Runtime PM is disabled.
In this case, the pm_runtime_put() has the same effect as a
pm_runtime_put_noidle(). It simply decrease the runtime PM usage
count, that's it.

Following this reasoning, one could decide to replace the
pm_runtime_put() with pm_runtime_put_noidle(), the behaviour will be
very similar.

If you would like to change to pm_runtime_put_noidle(), that's
perfectly fine by me.

Kind regards
Uffe
