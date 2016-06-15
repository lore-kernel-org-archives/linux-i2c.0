From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 10/10] i2c: designware-platdrv: Rework system PM support
Date: Wed, 15 Jun 2016 09:52:37 +0200
Message-ID: <CAPDyKFow3QqMx_qCuSwBbL2rp2zfazyHWb0ez1nuM863b+=AKg@mail.gmail.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org>
 <1465916848-8207-11-git-send-email-ulf.hansson@linaro.org> <1465918516.30123.66.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34724 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcFOHwj (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2016 03:52:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id k184so26145545wme.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jun 2016 00:52:39 -0700 (PDT)
In-Reply-To: <1465918516.30123.66.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 14 June 2016 at 17:35, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>> The current code that deploys the system PM support relies on the
>> "direct_complete" feature supported by the PM core. The goal is to
>> avoid
>> performing unnecessary operations during the system PM sequence.
>>
>
>>
>>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>> -     .prepare = dw_i2c_plat_prepare,
>> -     .complete = dw_i2c_plat_complete,
>> -     SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend,
>> dw_i2c_plat_resume)
>> -     SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume,
>> NULL)
>> +     SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> +                             pm_runtime_force_resume)
>> +     SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
>> +                     dw_i2c_plat_runtime_resume,
>> +                     NULL)
>>  };
>
> UNIVERSAL_PM_OPS ?

The UNIVERSAL_DEV_PM_OPS assigns the same callbacks for system PM as
runtime PM, that doesn't work here.

Kind regards
Uffe
