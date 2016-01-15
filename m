From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] i2c/designware: enable i2c controller to suspend/resume
 asynchronously
Date: Fri, 15 Jan 2016 15:01:48 +0800
Message-ID: <5698995C.3070002@linux.intel.com>
References: <567C0192.2050601@linux.intel.com>
 <568B848F.1070801@linux.intel.com>
 <1451996056.30729.394.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451996056.30729.394.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srinivas.kowtal@intel.com
List-Id: linux-i2c@vger.kernel.org



On 1/5/2016 8:14 PM, Andy Shevchenko wrote:
> On Tue, 2016-01-05 at 10:53 +0200, Jarkko Nikula wrote:
>> Hi
>>
>> On 12/24/2015 04:30 PM, Fu, Zhonghui wrote:
>>> Now, PM core supports asynchronous suspend/resume mode for devices
>>> during system suspend/resume, and the power state transition of one
>>> device may be completed in separate kernel thread. PM core ensures
>>> all power state transition dependency between devices. This patch
>>> enables designware i2c controllers to suspend/resume
>>> asynchronously.
>>> This will take advantage of multicore and improve system
>>> suspend/resume
>>> speed. After enabling all i2c devices, i2c adapters and i2c
>>> controllers
>>> on ASUS T100TA tablet, the system suspend-to-idle time is reduced
>>> to
>>> about 510ms from 750ms, and the system resume time is reduced to
>>> about
>>> 790ms from 900ms.
>>>
>> Nice reduction :-)
>>
>>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> index 6b00061..395130b 100644
>>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>>> @@ -230,6 +230,7 @@ static int dw_i2c_plat_probe(struct
>>> platform_device *pdev)
>>>   	}
>>>
>>>   	adap = &dev->adapter;
>>> +	device_enable_async_suspend(&pdev->dev);
>>>   	adap->owner = THIS_MODULE;
>>>   	adap->class = I2C_CLASS_DEPRECATED;
>>>   	ACPI_COMPANION_SET(&adap->dev, ACPI_COMPANION(&pdev-
>>>> dev));
>> Does device_enable_async_suspend() need to be called before enabling 
>> runtime PM? I suppose not since there appears to have also related
>> sysfs 
>> node for toggling it runtime.
>>
>> I'm thinking if you could move the device_enable_async_suspend() call
>> into drivers/i2c/busses/i2c-designware-core.c: i2c_dw_probe() and
>> then 
>> also PCI enumerated adapter could take advantage of it.
> I concern about Intel BayTrail-T / Braswell / CherryTrail cases, since
> we have non-trivial PM for LPSS there. Zhonghui, have you a chance to
> stress test this on platforms based on mentioned SoCs?
Because of long leave, so sorry for late reply.

I understand what you said, if enable all LPSS devices suspend/resume asynchronously, the system can't resume sometimes on ASUS T100TA(BayTrail-T SoC). But, I have verified that the system can resume normally every time if enable only i2c controller async mode and let other LPSS devices in sync mode on ASUS T100TA.  I have no Braswell and cherryTrail platforms, so no verification test on them.

I have submitted a new version of this patch to move the device_enable_async_suspend() call into i2c_dw_proble() function - "[PATCH v2] i2c/designware: enable i2c controller to suspend/resume asynchronously".


Thanks,
Zhonghui
>
>
