From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/4] i2c: designware-platdrv: Fix runtime PM
 initialization
Date: Thu, 21 Apr 2016 10:48:56 +0300
Message-ID: <571885E8.4000301@linux.intel.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
 <1460638414-5987-2-git-send-email-jszhang@marvell.com>
 <571789C4.5020904@linux.intel.com> <20160421110859.1509ad2c@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37505 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbcDUHtA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 03:49:00 -0400
In-Reply-To: <20160421110859.1509ad2c@xhacker>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On 04/21/2016 06:08 AM, Jisheng Zhang wrote:
> Dear Jarkko,
>
> On Wed, 20 Apr 2016 16:53:08 +0300 Jarkko Nikula wrote:
>
>> On 04/14/2016 03:53 PM, Jisheng Zhang wrote:
>>> When pm_runtime_enable() was being called, the device's usage counter
>>> was 0, causing the PM layer to runtime-suspend the device.  We then
>>> went on to call i2c_dw_probe() on a suspended device, which could hung.
>>>
>>> Fix this by incrementing the usage counter before pm_runtime_enable().
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
>>> ---
>>>    drivers/i2c/busses/i2c-designware-platdrv.c | 14 +++++++++++++-
>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index d656657..00f9e99 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -246,6 +246,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>>>    	if (dev->pm_runtime_disabled) {
>>>    		pm_runtime_forbid(&pdev->dev);
>>>    	} else {
>>> +		pm_runtime_get_noresume(&pdev->dev);
>>>    		pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
>>>    		pm_runtime_use_autosuspend(&pdev->dev);
>>>    		pm_runtime_set_active(&pdev->dev);
>>
>> pm_runtime_enable() here after pm_runtime_set_active() shouldn't suspend
>> as far as I understand which made me thinking if there is some other
>
> FWICT, on arm DT platform, the device usage counter is zero at the beginning,
> once we enable rpm, the i2c have chance to runtime suspend.
>
Yes it is same also for ACPI platforms. What I like to understand what 
is actually causing the runtime suspend in your case.

If I add delay longer than 1 second between pm_runtime_enable() and 
i2c_dw_probe() suspends still happens only after probe finishes. It will 
be triggered by the drivers/base/dd.c: driver_probe_device() when code 
calls the pm_request_idle().

I'm wondering is it possible there is a race with deferred probe etc. 
that is causing the issue you are seeing.

-- 
Jarkko
