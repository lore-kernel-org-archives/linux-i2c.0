From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] i2c: enable i2c adapter to suspend/resume asynchronously
Date: Thu, 24 Sep 2015 14:51:21 +0800
Message-ID: <56039D69.1040602@linux.intel.com>
References: <55D20919.5020800@linux.intel.com> <55DB369D.7030305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:8836 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756569AbbIXGvX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Sep 2015 02:51:23 -0400
In-Reply-To: <55DB369D.7030305@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi,

I have resent this patch with updated commit message - "[PATCH v2] i2c: enable i2c adapter to suspend/resume asynchronously".


Thanks,
Zhonghui

On 2015/8/24 23:22, Fu, Zhonghui wrote:
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
> On 2015/8/18 0:17, Fu, Zhonghui wrote:
>> Enable i2c adapter to suspend/resume asynchronously. This can improve
>> system suspend/resume speed.
>>
>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>> ---
>>  drivers/i2c/i2c-core.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> index c83e4d1..90251be 100644
>> --- a/drivers/i2c/i2c-core.c
>> +++ b/drivers/i2c/i2c-core.c
>> @@ -1439,6 +1439,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>  
>>  	pm_runtime_no_callbacks(&adap->dev);
>>  
>> +	device_enable_async_suspend(&adap->dev);
>> +
>>  #ifdef CONFIG_I2C_COMPAT
>>  	res = class_compat_create_link(i2c_adapter_compat_class, &adap->dev,
>>  				       adap->dev.parent);
>> -- 1.7.1
>>
