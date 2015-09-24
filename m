From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] i2c/designware: enable i2c controller to suspend/resume
 asynchronously
Date: Thu, 24 Sep 2015 15:12:20 +0800
Message-ID: <5603A254.8050102@linux.intel.com>
References: <55D20D79.3090308@linux.intel.com> <55DB36FE.10204@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:8301 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932717AbbIXHMZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Sep 2015 03:12:25 -0400
In-Reply-To: <55DB36FE.10204@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, christian.ruppert@alitech.com, atull@opensource.altera.com, jszhang@marvell.com, raymond.tan@intel.com, Romain.Baeriswyl@abilis.com, carlpeng008@gmail.com, david.e.box@linux.intel.com, Alexey.Brodkin@synopsys.com, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

I have resent this patch with updated commit message - "[PATCH v2] i2c/designware: enable i2c controller to suspend/resume asynchronously".


Thanks,
Zhonghui

On 2015/8/24 23:23, Fu, Zhonghui wrote:
> Hi,
>
> Any comments are welcome.
>
>
> Thanks,
> Zhonghui
>
>
>
> On 2015/8/18 0:36, Fu, Zhonghui wrote:
>> Enable i2c controller to suspend/resume asynchronously. This can improve
>> system suspend/resume speed.
>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index 3dd2de3..fec0fce 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -245,6 +245,7 @@ static int dw_i2c_probe(struct platform_device *pdev)
>>  
>>  	adap = &dev->adapter;
>>  	i2c_set_adapdata(adap, dev);
>> +	device_enable_async_suspend(&pdev->dev);
>>  	adap->owner = THIS_MODULE;
>>  	adap->class = I2C_CLASS_DEPRECATED;
>>  	strlcpy(adap->name, "Synopsys DesignWare I2C adapter",
>> -- 1.7.1
>>
