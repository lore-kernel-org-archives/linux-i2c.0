From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/10] i2c: designware-platdrv: Some improvments related
 to PM
Date: Wed, 15 Jun 2016 10:16:04 +0200
Message-ID: <CAPDyKFray1jNtu3sGbQXcc2BG=crFUikSFEZvhEYCeuu5GRKKw@mail.gmail.com>
References: <1465916848-8207-1-git-send-email-ulf.hansson@linaro.org> <1465918749.30123.70.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38048 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbcFOIQH (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 15 Jun 2016 04:16:07 -0400
Received: by mail-wm0-f44.google.com with SMTP id m124so23791220wme.1
        for <linux-i2c@vger.kernel.org>; Wed, 15 Jun 2016 01:16:06 -0700 (PDT)
In-Reply-To: <1465918749.30123.70.camel@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>

+ Rafael, Kevin, Tomeu

On 14 June 2016 at 17:39, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, 2016-06-14 at 17:07 +0200, Ulf Hansson wrote:
>> Here's a couple changes for the i2c-designware driver. Most of them a
>> related to
>> the support for runtime PM and system PM, but there's also a few that
>> improves
>> some error handling.
>>
>> I have tested these on Hisilicon Linaro 96-board (hi6220). I used a
>> couple local
>> changes to enable the power-key to act as a wakeup in system PM
>> suspend state.
>> If anyone are interested about those as well, I am happy to share
>> them.
>
> I know Jarkko spent a lot to understand PM flow in this driver.
>
> My overall feelings after brief reading of the series you fixed a
> particular problem with your device or flow, which might have broken the
> half of current users. So, I wouldn't take this without Tested-by tags
> of (almost) all active stakeholders.

That makes sense to me. Should I resend to include some more people?

Let me also elaborate a bit more of the reason behind this series.

I was using a 4.4 kernel on my Hikey board and testing system PM
suspend/resume, when I found this driver to be broken. Not only broken
for the Hikey board but for *all* users of this driver!

Without going into too much details, the problem was because of how
the "direct_complete" feature was being used and supported by the PM
core. In the case when the driver's ->prepare() callback found the
device runtime suspended and thus returning '1' to allow the PM core
to try "direct_complete" for the device, it caused the driver's
->suspend() callback to be invoked twice in a row. This causes a clk
reference count imbalance issue and messing up system PM
suspend/resume.

Therefore I started piece by piece improving the error handling,
system PM code and runtime PM code to narrow down the problem.
This series solves the problem on a 4.4 based kernel, however I also
realized that the issue became resolved already in 4.5 kernel because
of the following commit:

commit aa8e54b559479d0cb7eb632ba443b8cacd20cd4b
Author: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Date:   Thu Jan 7 16:46:14 2016 +0100

    PM / sleep: Go direct_complete if driver has no callbacks

    If a suitable prepare callback cannot be found for a given device and
    its driver has no PM callbacks at all, assume that it can go direct to
    complete when the system goes to sleep.

    The reason for this is that there's lots of devices in a system that do
    no PM at all and there's no reason for them to prevent their ancestors
    to do direct_complete if they can support it.

    Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
    Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I believe this commit solved the problem more as of a co-incidence,
than actually intended to be a fix for a regression. Perhaps I should
send this patch to "stable" as well.

Anyway, I still think the series I have posted here make some nice
improvement to the driver.

Kind regards
Uffe

>
>>
>> Ulf Hansson (10):
>>   i2c: designware-platdrv: Return error in ->probe() when clk ungate
>>     fails
>>   i2c: designware-platdrv: Gate clk in error path in ->probe()
>>   i2c: designware-platdrv: Unconditionally enable runtime PM
>>   i2c: designware-platdrv: Disable autosuspend in error path in
>>     ->probe()
>>   i2c: designware-platdrv: Fix clk gating in ->remove()
>>   i2c: designware-platdrv: Update runtime PM last busy mark in
>> ->probe()
>>   i2c: designware-platdrv: Re-init the HW when resuming
>>   i2c: designware-platdrv: Check return value from
>> clk_prepare_enable()
>>   i2c: designware-platdrv: Simplify code by using dev_get_drvdata()
>>   i2c: designware-platdrv: Rework system PM support
>>
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 106 +++++++++++++----
>> -----------
>>  1 file changed, 50 insertions(+), 56 deletions(-)
>>
>
> --
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
