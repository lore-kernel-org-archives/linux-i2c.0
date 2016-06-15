From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 02/10] i2c: designware-platdrv: Gate clk in error path in ->probe()
Date: Wed, 15 Jun 2016 09:16:22 +0200
Message-ID: <CAPDyKFpqR5a+b68wMmyY086OCmkiK9mvC-kcav8Q2x28z=0ONA@mail.gmail.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-3-git-send-email-ulf.hansson@linaro.org> <1465917768.30123.65.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35744 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbcFOHQY (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2016 03:16:24 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so149953753wmv.0
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jun 2016 00:16:24 -0700 (PDT)
In-Reply-To: <1465917768.30123.65.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 14 June 2016 at 17:22, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>> The call to i2c_dw_probe() may fail in ->probe() in which case the
>> clock
>> remains ungated. Fix the error path by gating the clock before the
>> error
>> code is returned.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index e39962b..19174e7 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -235,6 +235,7 @@ static int dw_i2c_plat_probe(struct
>> platform_device *pdev)
>>       ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev->dev));
>>       adap->dev.of_node = pdev->dev.of_node;
>>
>
>
>> +     pm_runtime_get_noresume(&pdev->dev);
>
>> +     pm_runtime_put(&pdev->dev);
>
> I don't see an explanation of these add-ons.

As we explicitly do clk_disable_unprepare() in the error path, we must
prevent the ->runtime_suspend() callback to be called during this
period.

This is a common pattern used by many drivers deploying runtime PM
support, which is probably why I left out the explanation.

I can update the change log with this information, if you like.

Kind regards
Uffe
